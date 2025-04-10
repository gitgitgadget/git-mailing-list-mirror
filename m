Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2982836A2
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286071; cv=none; b=pUu4PC63shI1Ob0i7Ahm1WJTkCDbdNqxmiu2y7f73eWJdjh7fi7jgnCZAKT7vbcQl4+WLY2kGDK+9cQsYYUUj4s6esEVtTNrG7yrUL0Ky774kt02FUD0AzdZ8gQP9Ak2xDAwcfksJvMj8QPmcJ5hau5PHnYecqx4khgADlkzYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286071; c=relaxed/simple;
	bh=A9CRQ02iBx//xlHlG5JmcP+EGKhdq43dq6P+DEza2jk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RXlsZxX/Ggq99QPSes7BFVgSu2ipVCe0mTqFl9cHzBNkGO2PeBSSLicAlL7XgCDWiSjVD8Lk516UKTo2X1d+OdlIKB2KWnyDxxb5caKMAi99qE/ptYAI7Gpr058DYA95n0paeehVusJ/yYSSUqkK8ZRJY9bIsga8TTVdXb79ov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i6WxAFtR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wx8udTx9; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i6WxAFtR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wx8udTx9"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB82A254023D;
	Thu, 10 Apr 2025 07:54:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 10 Apr 2025 07:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744286067;
	 x=1744372467; bh=KnFuYWbZ4gnF8l/oXtX79eWPCses8els+RPojGoeYw8=; b=
	i6WxAFtRNekJ0JG0OicVHX9/8Fq/l13x7gxc7hTQhT013I4e/Tszbs9AJwz4dBvX
	7ilM84WyHS8CtgqLuJ9DHB5yxddKa+e4j7KFali2HuEwLsNiINUk59t4m2Gq6CgI
	Gr3oziXhHChGiAXjDNZfEvIMDVRzkj20TUdhzoR5fZiCvzVg2tw8dKdzAZ2tmMl6
	ret46KKD2lswGgsp6rGQET1s+6E6zEfTbqRMc1JdEUYNlR5YAqoBf76XjMOt+PQH
	kNl0p72TFKkj9/JaTbfgIPeahIjImOE24oOsSyjXGBIJ1SmYEMqGrfw1i7veMKcn
	y/QrWqZjGCETmAl++oSE6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744286067; x=
	1744372467; bh=KnFuYWbZ4gnF8l/oXtX79eWPCses8els+RPojGoeYw8=; b=w
	x8udTx9SpVwvevn9NS7L0V527tHgp2KDqDqT595lLtQ+A3zsps3mucpTk3NsHA+Q
	XtiTj+/Evg95ko1C7xFikGRVhJzmGloIB52sdR7IlI+HLvScCCFLDiWY1TfKIeEt
	8DKSyV94gGU3i6L2F9W20NesAkHxQ0pQYWJUv78lf1KLRm5QPDVah4kymp8i8v/A
	nOKYKEfd8GGPvc1buNhyClEdWxK8QB+XYVq/3zIW2XljmwzgTT1+2Nr6PcQipYec
	m3prXjsa06el5N5mrPlxRCfuOIUflmPrjAMUtRZJ7hoIRh0dEq2lKFQRsYSJFDT0
	0QGZdwBwjfBSLAtjrozOQ==
X-ME-Sender: <xms:c7H3Z8A-v8nGVvHbYY8kQClxVO8CiEW6mC45aKWiXeggwBVSdEkvMQ>
    <xme:c7H3Z-hTxFl3tfKn44M3qxvts_QD9iNp_HZ8_5kcC_uEnmx8B_xH8Ct21vT-W1lzH
    k6p07gCVOzZoXR3qg>
X-ME-Received: <xmr:c7H3Z_mBOh1vaf89cOtm8ZlW4APCpCLlVvB8cf5QCwjHxoPLTzZrYD8OMpJlK_X-3O2ZiIKr0RgYnt3l3lP2B8SQp2tEbgih19VU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvjeehudehgeelheefieevtdeg
    leefvdfftdevtdduffeikeeiieejvdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhi
    thhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepohhgohhnugiirgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:c7H3Zyx5HgdsmCruSs454AM6VUvogtGW0Gug8CtgljhDlUvJhzxv_Q>
    <xmx:c7H3ZxTkqoEC1hCqFApizFuUam4_l7uLC2u-81FQ3kajIN_r7nwwZQ>
    <xmx:c7H3Z9awA9qIWgBRpc61vVQWEHi5oCfo7l_2-9kvAc2zZ7Lwms5-Kg>
    <xmx:c7H3Z6QgWDDguRLIsDo15W9kpiXmYOA3utcYTkVuwIKAh3umU9-1eQ>
    <xmx:c7H3Z6Ox4IOYNx9Ebx8bU80nlL8YFdcSlNl7naj-72AzfzZ-9clb05L->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Apr 2025 07:54:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oliver =?utf-8?Q?Gond=C5=BEa?= <ogondza@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFE] Add config option to always add --signoff to git commit
In-Reply-To: <ac87b389-2bf8-4c2e-aecd-9e86f65ca8c1@gmail.com> ("Oliver
	=?utf-8?Q?Gond=C5=BEa=22's?= message of "Thu, 10 Apr 2025 09:54:09 +0200")
References: <ac87b389-2bf8-4c2e-aecd-9e86f65ca8c1@gmail.com>
Date: Thu, 10 Apr 2025 04:54:25 -0700
Message-ID: <xmqqo6x4p6z2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Oliver Gondža <ogondza@gmail.com> writes:

> I appreciate any feedback. Thanks!

This is almost as old as Git itself.  Perhaps start from these places?

https://lore.kernel.org/git/Pine.LNX.4.63.0611281426311.30004@wbgn013.biozentrum.uni-wuerzburg.de/
https://lore.kernel.org/git/7veiw69p26.fsf@gitster.siamese.dyndns.org/
https://lore.kernel.org/git/cfa40ca5-98a1-fc9c-9ccc-f14b81119e60@gmail.com/
