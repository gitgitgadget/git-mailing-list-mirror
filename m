Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA7C205E12
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591898; cv=none; b=HN3ty0tsVivGo8AvKAdM2qFIYWdNv7I58VJl7oZPSaXTXvuhZYfId9Ud9j690tHGi6yXoyoGzGCBDOSILb517iwMJwJQSf2tbJdpof/PCHs4im5sjiwAvWys+OjSIBB0JDe+PIWBgDbGOIDA7wPy0lALsmRdvwnS9hs+Jf5Cuqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591898; c=relaxed/simple;
	bh=cKk1+MIVwIspd89mmyE7Y+87F06RS8Po3hBmpsyDAzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a7Z+FmglcPpSw9B860GsslPTw0a7hVXxwaSxbPuwzmqyI99gsXaNLNB7A1/XABCf7sHSlxD1dNc3NFd61FGZCWlRxn4m6vGss/RGP8Yki3Pz3lI7y2oHt59f5QhBs10URnKo7XXjVXc9BpSSh/IzblY7c9MNFdSdnr4kU8rCqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M/qpmUV8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uarIzmE8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M/qpmUV8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uarIzmE8"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC4CD114019E;
	Mon,  3 Feb 2025 09:11:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 03 Feb 2025 09:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738591895; x=1738678295; bh=8YsTSuyM9W
	xvuJBK/FgPrfPbYUsTrmpHuxpUnx1SwM0=; b=M/qpmUV84HMSYPqcJH1n7BKhqa
	usuAW4EIIf4d63A6kGMXBvwaM+DNao5vLG+friJQDO8VYUxsDgK/6s1OJFb0Uqi6
	erbBnc2FKbNlf/e6otcJNH0rAgBmFUmgMJ7gqAwrA8/y9L272oK1Yve3ffSxHv0s
	L1mhaPRXPB0IxQ7mb0dVJX+hVclCDp37F4aIbBIcdrmMND5sGp+MD5MWQ15mXd/x
	FIoL2Percj+sB6EhymgvPwLdAHMitKBEWFaD6KDO8hJNi9zdFvdFJC9IbdQKD66Y
	ZezVfSmgQkmdUxNeY/x0NotyQyRHZ4JkbUqmpsDpvtnClG1ziDLFbWKk7lnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738591895; x=1738678295; bh=8YsTSuyM9WxvuJBK/FgPrfPbYUsTrmpHuxp
	Unx1SwM0=; b=uarIzmE82ik2airayq4EV6Re94MnRj1Qm1BOokXILFE1ftna/IH
	9vMsVfYRFshHqV9ZEnGZxONfAUnL+mYrzuDXuM108M+R3SVfLNxyd2w6Inyi2JYo
	2U4FDj0g0/3xWN/7p1i3NfSGQNM2tGM2K7gd7Oaevk+QOVgo23B/DGbCoeu+7lgQ
	Oxb8JGotQwHrQF7IDu84rIzug5Vzt6EVjEmqd0YeWk0mnS7zFH+o6MJvkTvT03IU
	3eSyVTF/s3UDk18kkKMDvDMj7fh7fJ6E8fRTwc4B6n3fe/NeXV1jFJ47JS0c2Jx0
	9CQQFhDUOsm/TgrRNG04MmZfSmp4EKsa5Ig==
X-ME-Sender: <xms:l86gZ4LAQzynzRDngJIXfi6OuYj3qlNffoc8BJGB0t1nc1R5eedYHg>
    <xme:l86gZ4LfmwPjzyj_8hHCE-RsrG6EPlt6aZkSG_yVKOob3ZCQL9h3D9wHtvW74-cGd
    HxtY4My2CU2uEKHiA>
X-ME-Received: <xmr:l86gZ4tOZVPecQnBCGtEaU0tDtWW_lmz5kMaVQYCuO4XL76AB2ZOz6AxkOdkSKRV1cqatkgN9u_84EbdvpTuEJxwb1KBPXgswPAB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:l86gZ1a_ur1R2iXZtxay8EM-hfFrhkq-Kdif4Myw7cm5ufpvN4Y8MQ>
    <xmx:l86gZ_Z_9sP0UjTZGQsM1Ha1M-UaEuCXyM_GvUCBVRyLi3xrpdFbAg>
    <xmx:l86gZxAcmrKduWyaTvYQJJTN0XEMqYISO6F4iXfItamvuoKA4qOfaQ>
    <xmx:l86gZ1bkMbIsHP-4Rcxv5AiMnbdoZdgWfbl8fZYAF4ggEOPq_FhFdA>
    <xmx:l86gZ0NKCnvKExzvtFXuWaXaPUkWahYMXqkx9p7rBsU8zuY9vBCXE1H8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 09:11:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk,  Jeff King <peff@peff.net>,  Karthik Nayak
 <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: undefined behavior in unit tests, was Re: [PATCH v3 3/3]
 reftable: prevent 'update_index' changes after adding records
In-Reply-To: <Z6BW7_aj4C7B-g9P@pks.im> (Patrick Steinhardt's message of "Mon,
	3 Feb 2025 06:41:03 +0100")
References: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
	<20250122-461-corrupted-reftable-followup-v3-3-ae5f88bf04fa@gmail.com>
	<20250201022409.GA4082344@coredump.intra.peff.net>
	<425859d1-d42e-42ee-b59c-723a519f0ad8@gmail.com>
	<Z6BW7_aj4C7B-g9P@pks.im>
Date: Mon, 03 Feb 2025 06:11:33 -0800
Message-ID: <xmqqcyfzyv6y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> 	if (!check(ptr))
>> 		return;
>> 
>> As we're in the process of switching to using clar which does exit the text
>> function if a check fails (that means there may be leaks on failure but if
>> the test is failing then I don't think we should be worrying about leaks) I
>> don't know if it is worth fixing these or not. I guess it depends if there
>> are the list of targets for Seyi's Outreachy project.
>
> Ah, yes, should've read your mail first, as you're saying basically the
> same as I did :)

Yup, I 100% agree with both of you.  Thanks.
