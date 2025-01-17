Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D53C17
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 00:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737072281; cv=none; b=Z3jbqnthzQ/C1hlEcckGoRirwz5YD0Z3JDNpj+PHVGJ28P4UOsI3PK8fGFHZEzjaCLwepCdOhWUoxO4CvI1ICz0PMPZjZsHRqRofRXOT7JybDP5qADvgjgZj/pRQkF8r/8a+18GnEH//z8TaP6aGy/8k1mc9X9KVbAJ1lulGqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737072281; c=relaxed/simple;
	bh=jdH1KvhwlwGeigIgF6Nm1U16gCn+K5yyVDuz2Pm+kAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S5NtMCJ6DrhaBncT0bcibuH1T47D1WGLdXkpvLBaL6ov3rpJMw4ZfzDr+LCKRkhYjhCZuWMiw9G/PPKt/nZII9KeZT21+fTmawX3pKNn3pdRqNwZ3ox8dSJkSoBtZZCaD0DeEKkgvXBpty1yc88OBwCfixpXTR3/GCZ4W0NEayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Go2GnAhJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SXg17rkC; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Go2GnAhJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXg17rkC"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 561191140108;
	Thu, 16 Jan 2025 19:04:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jan 2025 19:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737072278; x=1737158678; bh=ZwWfPonS3F
	bKSbJiu8d/Ivpbh45u0Bk7fOIwrkbSrZc=; b=Go2GnAhJuww4CZeHBMbTNwU/LC
	y+RceHLM938BCMp5ArErGxp7pSx4bnmjZgvXXcrNAta3CMgCceBKAYFPID9luVdi
	rC7ZFnZurDnb6dVZ0ke/uD0wkr7tzguGxlvUiurfk2nFa7hMsw6zLn2sH5SD84ex
	/bBmhIJDBa6A70PqttCLObsECg/T+Na/HgLli3sdYePEEfg36fKYYiiYzvrN55PK
	5BOAmih5tu20uPC31jzJ0ruKnBn/LwskYE6gxWloe3qbcAWfmIl7PvbCRMqIgF13
	jCCINvPqhacXNofD2sUwseigG4Mfu/iLZ6hkU9QgqsBouxzV0nu8wzOJAjVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737072278; x=1737158678; bh=ZwWfPonS3FbKSbJiu8d/Ivpbh45u0Bk7fOI
	wrkbSrZc=; b=SXg17rkCRI7jGT/lcSWhoZUVxAeljM86w2KhOVZBX7N3qh3aLP6
	GLFkegAFDdwL+5yhi6pnQVRn2VVtyZFk+uE0AhBFbokovapu8i+keG28P+TA6DwB
	2ISPuCocQu0lKCK3GzCfKWNdkXaP6IxDOR245Bn6+2Djn1oPQZayQI+NOGJdfq6e
	JoLQ13fyw/Xob44sP1u48XqpInEHG9lQS6r9pQXgzYPmhK+jyG6EJSYskOlVBosW
	Ti3DUzkxl+TAwe396yjLOt0MQMIXTpx5+4J8QsAGfCvDCOcoQhwhPrcFyt8Ppm+i
	qowmSI5OH+IR4W94xj4KTsb3Lhy8DMIHPdQ==
X-ME-Sender: <xms:lp6JZ0b-HuxCw1jakNC1vCGBQx_mjCn8QparsBfF-xNSQ5F06WUP2g>
    <xme:lp6JZ_ZDI8a91fh11B9WFOkuF2HnFnVh2GNFRYkufaaTS66kB-_oMMOCTFzIYAgwW
    NsaTo123q8vfdpO8g>
X-ME-Received: <xmr:lp6JZ-9LO_6-6aypu1y7q-22oRmt3QfFAqtOUTRa0hSBKAJBcwW_cGR6mPW9gRqbnRUonDc_ouAeyliSyPg40L1bXGPWzIffb3yc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeivddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdr
    udekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lp6JZ-p6rwyav7rdw_PAV9C7fN_hH9i5FSgUsch4fvEvU6xtk5oFTQ>
    <xmx:lp6JZ_pVIYc5D6qhsIURXU5UpPo1saYjdDlNtIGDqKGoJxGHfLQDhg>
    <xmx:lp6JZ8TTzgum0ciE0F1rV4siGlYZOtVh1z5oiAXqllZW8Qjlq2hKyw>
    <xmx:lp6JZ_rTn3xzmguGLy2OV6nLDHY9uvdt4JXSEl8fJdBhS--T4GzLsg>
    <xmx:lp6JZwAYPA6JVCSYmrSB6Xu5o0-DFO4SSYlHzo8i585NYYd2veu5O--W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 19:04:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: Bug in 2.48 with `git refs migrate`
In-Reply-To: <Z4mUizLNUdq_1BgY@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 16 Jan 2025 23:21:47 +0000")
References: <Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net>
	<CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
	<Z4mUizLNUdq_1BgY@tapette.crustytoothpaste.net>
Date: Thu, 16 Jan 2025 16:04:35 -0800
Message-ID: <xmqqmsfqnw4s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-01-15 at 11:54:51, Karthik Nayak wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> I'm attaching a patch below which should fixes the issue for me and also
>> adding a test to test against the same. I'd be grateful if you could
>> also test the patch against the repositoryies you mention.
>
> I can confirm that the patch did indeed fix the problem.  I was able to
> convert both repositories successfully (and very quickly, no less), and
> they both work fine (I did normal development activity with them) with
> an unmodified Git 2.48 after the migration process.
>
> Thanks again for the quick fix.

Thanks, both.  Let's merge it down to 'next' and then to 'master',
then.
