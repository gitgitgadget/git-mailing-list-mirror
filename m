Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6085482EB
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738354540; cv=none; b=UAOcVY2DCEZZHmAfxGxw6flge1yPCN7otqPE2MCb+dNukVfithQeb3iIh6KTrOIz6el1l1hckNb/y+TzQo3oyi+ui9+i76JvG5p7zpryaRopMaJL4azY467cIHz8eIwoeF/RNO6c9ItFZHpwgk1/uSzoGeGDWhfgRgmRK8Dj4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738354540; c=relaxed/simple;
	bh=0qqKjRvtUXaSGVCmqLMxqkAeET41gzcx18dr0Rmfg5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IP+Dq0vwisEbKzl/LRLXPPDwtM4FGr4Doy3ogOBAPwdTzuRdnq/Hc1+N04vnEXgpHJIhGOaEe2VAeQkPFsEfCXWU9QPELmcYTZuTcO2WCXjfeDoMyupvYAPz88VpXs0n2kxHn/a0kYlmAcTJzOcTRDxrjGiF7e32wPF3E/r9YoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jBfw5hai; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aMUYvcyu; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jBfw5hai";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aMUYvcyu"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67ED62540195;
	Fri, 31 Jan 2025 15:15:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 31 Jan 2025 15:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738354537; x=1738440937; bh=tJyaM6/LEj
	fwmeaCxGZLjjykn9OouDbfWacwZZbEnFU=; b=jBfw5haikTQL+k7j2EjmDttCqU
	jFBY39TnqYj9dV4D6UmFxmpUdLUK+3JkptjhoWw5TMAo7R0GMiZrBFcPUz2upWLw
	2mZ2TbUDETVRye5caihCDTbQ2cf3BTsZqRt+XTH3ZK79rzKFNyz5OGU0x+03r5M7
	+upb+F40Qz9gHRyWDiH3geE9/1AC1saFG/S7HPfX9puUtoYQ3rhGYZ8oRc8kbVs+
	opfMt3L4M3sevTPuT/iQuX+iBQGyo3y5jVFIH9DxsZ0b657j9mMJ2vyN1/qHSu3p
	FyFIM1p2wjoto/fRG1146JR9BtudFXNQP3+xiDW2A95fQC06NzsEyZXNrCew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738354537; x=1738440937; bh=tJyaM6/LEjfwmeaCxGZLjjykn9OouDbfWac
	wZZbEnFU=; b=aMUYvcyu2c/JLw0E6b0eia9uh4OZhE7FcdzndpEqpbCFSgIKMEb
	5396CjAL9kxv0HwbFDTda/176QxSbV1Il60NwrcdwI8zZ2Cuk+OVnKYoYQ+mOrnE
	bSkidG7MKlXawjVvbim3DPSIiWEDc3x47pcVXelJ06vy/RXdEjeeDQ86Wcgy7+mN
	ZlNXAaYkJj/WlE+T21xIyma301GISKU7b+WqLKdsDZsJEmsI+ix20bJ9/ZIQaV1L
	NH8Z6l46U8/DfOyjfdIL8ak29NVd/W9fS0WVOCdStfDpugVRHZUHRsmHmk2+1BIp
	g6duOqUJRJ/4F2E1nHdhGRK46Y23ipJbTww==
X-ME-Sender: <xms:aC-dZ1xN_LKq1eP-UghvYAO2H_aSLz54dSqEW9pVfgDovkI4Vd2GoA>
    <xme:aC-dZ1S0s0NEP_rUbR120rNGiquxybxaqjdrPj7EVcH-NmYl41rFxzQq5nJU7tt70
    90whkXVb5qhxmLm-w>
X-ME-Received: <xmr:aC-dZ_WXV1QP57puzGNKdeGDi6prk1JQLEcm1stA7_Sj42ZaQnql6DmTIzjiCilQmURY1XC0wqH3CqG_NEWW4BTM9YSuZJbuqdXO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeljeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkih
    hnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghn
    rdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehj
    ohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomh
X-ME-Proxy: <xmx:aC-dZ3g9kWw2lKI_fIrWo0TFj5jZTrWdumnQ1LH5G7sq7rdDTh8-0w>
    <xmx:aC-dZ3DA9K0zQ0T1IDF4HwZDEbk5IxuhHjbAFst2ndRYDBCJGkHhJA>
    <xmx:aC-dZwIsQf6eeawHk-SiWzKWfVIyk2k995l3qegRaXbxWfum_aSI-w>
    <xmx:aC-dZ2Aav491ecLlYkY0C4CKqbrIKiqcLeBusI9Q7A_2xh3EWJ_Hhg>
    <xmx:aS-dZ0JDYgAyUBT4UsldpDii789qMgSiYuJE7PTSwMe2HndXCCprM5QU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 15:15:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  ps@pks.im,  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,
  me@ttaylorr.com,  phillip.wood@dunelm.org.uk,  rsbecker@nexbridge.com,
  sunshine@sunshineco.com
Subject: Re: [PATCH v3 0/6][Outreachy] Introduce os-version Capability with
 Configurable Options
In-Reply-To: <CAPSxiM9xO+GPNrScQS0C02qNJM8M+hOpEfkr0Vp1Tz3i_jkCjA@mail.gmail.com>
	(Usman Akinyemi's message of "Sat, 1 Feb 2025 01:12:34 +0530")
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250124122217.250925-1-usmanakinyemi202@gmail.com>
	<xmqqed0sxdiz.fsf@gitster.g>
	<CAP8UFD31A9KuqzXrDWzjokWzBtTYsF1FGJPX8PFAWXnn_2BH_w@mail.gmail.com>
	<xmqq5xm0wa5l.fsf@gitster.g>
	<CAP8UFD1+Qa2cRkYs8R_Lgr8Bkz7YqPUW6Q3ogKcrBSp+q-3qbw@mail.gmail.com>
	<xmqqzfj77xd7.fsf@gitster.g>
	<CAPSxiM9xO+GPNrScQS0C02qNJM8M+hOpEfkr0Vp1Tz3i_jkCjA@mail.gmail.com>
Date: Fri, 31 Jan 2025 12:15:34 -0800
Message-ID: <xmqqh65e7na1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Do you have any concerns "git/2.47.1 Windows" instead of
> "Windows git/2.47.1" ?

Either is fine.  I expect that

 (1) Implementors on _our_ side will do the sensible thing and
     reviewers help them to make sure, where the definition of "the
     sensible thing" will be that whatever order we pick, we
     consistently use that same order.  If "git/2.47.1 Windows" is
     how GfW identifies itself, "git/2.48.1 Linux" or "git/2.49.0
     macOS" would be its contemporary counterparts, and _our_
     binaries would not identify themselves as "Linux git/2.49.0".

 (2) Implementors of third-party reimplementations of Git will just
     mimick what we will do, as long as we tell them our intention
     (i.e. this is a single opaque unparsable string to be collected
     for statistics, nothing more) clearly enough.

 (3) Most users are lazy and/or trusting enough that only a very few
     minority privacy conscious folks would configure it away,
     making their "IamNotTellingYou" agent string merely an
     insignificant noise in the statistics.

