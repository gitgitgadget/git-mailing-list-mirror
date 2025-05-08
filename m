Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D4827AC31
	for <git@vger.kernel.org>; Thu,  8 May 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716207; cv=none; b=fYzCsKvoIHP7pUFdgXFrsepqPOkN5kBnEcbYanuVmpTdIPJacd4sc5qvEEPQyN21BtDJTKrIVj+F7sv52TysdSW5HvdCRi7EMJnx4jPZZYAjlZi8GM3OAQBCxTLCmfsg4q8pVu1BswrXs1m39ffo9EGICGiEA/oTXDWWBb47H3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716207; c=relaxed/simple;
	bh=1j4KrzzM1RnSYqa+b8ZJR2+76N+qBw7OBaPDjG8M88A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fPbkipmOEWJYvY/9oaWuMVoabWsXfAvq4cBzi+v0yRiEqXlzf+WkG2BBfrtvRe5ibf3mLdkUEZAxJh6Hi/6l4qFQJ1TAxkie043s5Srv+vFOP/6FsjETcuEcRrfVuktCkusybl08PbMzsdZ6WEKtUqCutKtIgtf5ZuWsqo+axBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gppyZWZ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PiwELOG/; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gppyZWZ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PiwELOG/"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DCD4D254015B;
	Thu,  8 May 2025 10:56:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 08 May 2025 10:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746716203; x=1746802603; bh=oCo+tgiaqi
	Q2xC3JhEaGctw4ut0CutnogWwM3EwkiNQ=; b=gppyZWZ3QiXntUX3SfiU+Du82D
	tOFM0zuSX1mavNshIaYlL0i2ZqcC/MfZyuutmyHzbbEOccjm6M1VsBvmH3AZWqWC
	Zh5bxsokTC15QoYLFzewCrugcvncYzv33ne3QvByUB8xPDUl9eIRNoKPC/U3ocqp
	d+8FsvvrnolTtXETKN5ASjaAx+7MECq94rCalqiX48T18BLTl+FeRiyR1LwFq6dh
	o6E09w1KTb/HA2tDP/fleEfx1FPFkbYQw9q7NPN76mtdEuExTo3pQ3r6HrnJC/cI
	57D4nzixGZ9kWRZVJGnD/3AZ/n3QiSdxwy5NT4IEjOeffFupDb1V4iN2qnDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746716203; x=1746802603; bh=oCo+tgiaqiQ2xC3JhEaGctw4ut0CutnogWw
	M3EwkiNQ=; b=PiwELOG/4KYGBXDOv2K2LYdaYmrJL28YpNyEWwJ0WDbSO4YdIUt
	YYbh/ORRMoEVNTGVOvONMrF/nZ1DupqcoFHBg+ebMn4zU0eBDKxP8Q3UC3gqcdYo
	LgnIJNuXdcW7xqsed9jiMqhC6vojQVgBI9t4ASnAsAuBKKXuBv2ZJkzRzessIzlq
	fas42VoPMoKrBkxb1P30srTqJahLBOWnSZ0wkeDqZ3rbgCAi7eSJ30f8mPacRuV+
	lD8jkcZS0iooaJKQRLty4k26ZrCZSjYPLOXhxmvXbFpFKbSgpJbVdw0vWIKWCW+i
	0GrcSfDqw/mNQsKgSqM+HZ3Qzp48H2DHkjA==
X-ME-Sender: <xms:K8YcaIpE2xM_gLvV84zqgTxTDvJnmgv-R4qY3YXMpAF5x87hq1GDfQ>
    <xme:K8YcaOpGHpexRREWMAKwoRAh3nsuNAcIG5A9Qti3HV8XcUXGmuDz78hoI7YfjKaUv
    FFkyH05eCJHE3VB8w>
X-ME-Received: <xmr:K8YcaNPFss7K_rGeJWYEc6fybb9hsA5Oo0ooQqdWO4T02wANefrKwI5nTKSjq8m8jy-GsPyvvnwnSIcop-b2MmgCBZEmpPgMKGBT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledttdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguih
    hthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:K8YcaP44QT3Dfjnliwii-S-4R3K4V6n5LljI2Q4ccc68aOenJOoztg>
    <xmx:K8YcaH48Zbhbs4kIIy_PF0RzEulEyXMjNd-IQPVF3hK4C7w3v3WicA>
    <xmx:K8YcaPiRggBu4K3sbANUH6VyGbgyoPlYI7O9SH7WIy0Bri3vRzCpXg>
    <xmx:K8YcaB6I-pmju93Ld0gofDVzBs8cm7YY-_EuqIQPqj13YzkAbjh0Cg>
    <xmx:K8YcaGMmzQ-utT3s8XTgmPWWgoerLXtbzm8ioav0HQn44BuyVFelysrB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 10:56:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>,  Julian
 Swagemakers <julian@swagemakers.org>,  sandals@crustytoothpaste.net,  Eric
 Sunshine <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 0/3] Improve checks for valid_fqdn in send-email and
 update documentation
In-Reply-To: <PN3PR01MB95974932FF37D9F24A7633C6B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 8 May 2025 10:31:55 +0000")
References: <PN3PR01MB95974932FF37D9F24A7633C6B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 08 May 2025 07:56:41 -0700
Message-ID: <xmqq8qn7882e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> This series of patches mainly has two changes:
>
> 1. Improve the checks for valid_fqdn in send-email to be more strict and
>    compliant with RFC1035.
> 2. Update the documentation for send-email to include examples of using
>    OAuth2.0 with Gmail and Outlook, as well as links to the credential
>    helpers for these services.
>
> P.S. I have used `git-credential-outlook` linked in the second and third
> patch for this email!

;-)

> v5: - Simplify the regex in the first patch to check for valid FQDN.
>     - Fix formatting in the second patch to make it more readable.

I didn't know if the $subdomain variable thing would actually work,
so it is great to see you took it and tested it.

Thanks for an update.  Will queue.
