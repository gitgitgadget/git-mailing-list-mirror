Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3D81732
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994522; cv=none; b=KLWn1y90tYjvouX6KmOqjkF5fMIxTv8rAzh4kYvwT0TNtwbQYl+D2aQlteVRLZngkYP+up+Jb9Ctoxr5syGU9XLFeMkC313LNXxY/K5VM9+J77dlmlc9ad/UrMoHYIEOg1S1ZZgske5tBTX+EWJn7H8K8h1TWUSqL4l4esifxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994522; c=relaxed/simple;
	bh=eFKHHU51A2aQtY3DJvSoN75UcT7iGYaGeQq028Z2+I0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A0bVi7pHam7O96RsfZMFtXSEajFVHAYXRKn7RYBLU6f5cel8BMDTaNPbrhsX+xSywDXNWHvJjbENqPutR//l+emAv8Qey12fq2imiLcTu5UTLI83u+N9L5lswtHO3UI+vLbJtmMmy7XTQYqnpoWr3sBXfIhaSwqkVuLHOl1pxXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F8JdjDdr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x5LDWHCo; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F8JdjDdr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x5LDWHCo"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D58F114026E;
	Mon, 27 Jan 2025 11:15:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jan 2025 11:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737994519; x=1738080919; bh=ze5+wgP0fG
	H3VA875v6CLM8ANRHawWp7UINWb/RH7q4=; b=F8JdjDdrrYY6rrVu+zAsVwZj9u
	4ieiQIGsjj7zurZc3jw+NmLdEaqWciQg/aVKV7WSeQ9/Mr/eUvZmM/96ur6D9VCm
	+h15oAcwYUXeplbHu/xfVjHcLTXs4QNwkxBiPm8bbwCDIJAZRmqZCb/mcmU9waGC
	oAQeIkKluZgUYHiWLOLaHBtUgHAo3dT2cPy2XbtIVHT+N+9GsIhQGwimDbLa04HI
	tzUpHBDsVQyBPw6/iVv+t0eLPHSsThq/OhAawpZVPHGKGYnlWTAdpDE34dvoyphc
	7ePTiBWH0wq8Zs62r9nPLuOkIROZ+zGNVTDFMRC9ohOAfpORIE1lEuOdyZpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737994519; x=1738080919; bh=ze5+wgP0fGH3VA875v6CLM8ANRHawWp7UIN
	Wb/RH7q4=; b=x5LDWHCoe50BV8d4NZ7Cf2EK6L2knpdH/EZm7RYz5cwqOUVZgas
	XMS5ljdBIoIM/yAlkd5PboSGWFbPKmsmXOW36xkGZkrLV6sIHJUTR2a9rY5JBonZ
	XD1XYPI6cHRqx3mDy6/jLbnCtO+kfkvPBKGMrCLzhkBTJmxzIKBaQQJ+buICboTt
	7bntxj/lQIjmYPgjCT59RPwvEktS3/9jms+iJJaRNLFLCGLF6RK/F+lfzmzwZ61T
	aFJRGkt5OuabISSdNtxQeVKOty7GVtBijlktO013khRE6ByRcLW/BnOxDGb27Fp9
	gDD14IQVJHUJN3wcjFAATa38DjrYZGC+k4w==
X-ME-Sender: <xms:F7GXZyUoBCQ-trhIzgp437ofVh8AQkSh-2br9X_M_qJhi-dNvn7o2w>
    <xme:F7GXZ-lx6HEAUs4QUOsmalnn6JetLZfKOYCJEg7xxUc2j5ksLDj6kpXQShgW04L-B
    Z5b7uXdzYHe5meH-g>
X-ME-Received: <xmr:F7GXZ2YufF470lJW76KsDUsanPHOKECAKF7vJSnjKqi3ecIXTK0iAqYSfvoLwKelcMD6jG5_lVFthabN93pfelsF2MkSwvS_Dquf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopedvtddvhedtuddvieduvdehieefkedrfedtkeelqdduqdhsohgv
    khhklhgvsehfrhgvvghnvghtrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepshhovghkkhhlvgesfhhrvggvnhgvthdruggvpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:F7GXZ5XReku-SclV5m6cQ_b-sq7EJwi-to1u1zOo9hoWnIW8Ytgwxw>
    <xmx:F7GXZ8neNiNEVm8aFgQ9vhvr2KJ9Q93eAKPHymXYtiAy8m_puWmaJQ>
    <xmx:F7GXZ-cNuHpTEFbEbXO-iZ98m0XMK5dBZHajvFVhpWc1_1JIx-qnmA>
    <xmx:F7GXZ-EGbTKScvN14APZtk2fr-oEUfJXAZ6jpbkgBBNn63vuPi1FGA>
    <xmx:F7GXZ2VI5qxpts29uOUbrHCvlibxx2l0dB5g8f8s1orlEInTKZcO5Dxk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 11:15:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: 20250126125638.3089-1-soekkle@freenet.de,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  sunshine@sunshineco.com,  =?utf-8?Q?S=C3=B6r?=
 =?utf-8?Q?en?= Krecker
 <soekkle@freenet.de>
Subject: Re: [PATCH v3 2/4] date.c: Fix type conversation warnings from msvc
In-Reply-To: <Z5c1F7oqsaPrHRiT@pks.im> (Patrick Steinhardt's message of "Mon,
	27 Jan 2025 08:26:15 +0100")
References: <20250126125850.3195-1-soekkle@freenet.de>
	<Z5c1F7oqsaPrHRiT@pks.im>
Date: Mon, 27 Jan 2025 08:15:17 -0800
Message-ID: <xmqqwmegutbe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> diff --git a/date.c b/date.c
>> index a1b26a8dce..0a3fafc8a4 100644
>> --- a/date.c
>> +++ b/date.c
>> @@ -1270,8 +1270,8 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
>>  
>>  	tl = typelen;
>>  	while (tl->type) {
>> -		int len = strlen(tl->type);
>> -		if (match_string(date, tl->type) >= len-1) {
>> +		size_t len = strlen(tl->type);
>> +		if (match_string(date, tl->type)+1 >= len) {
>
> Formatting is off here, there should be spaces around `+`, even though
> you simply followed previous style. It would be nice to point out why
> this change is makde in the commit message.

I think len-1 here is perfectly fine, as there is no element in
typelen[] whose .type member is an empty string, and no need to
touch that.

Besides, we already have this one in 'next'.

Thanks.

