Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA43D76
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795362; cv=none; b=OQ8B2qA+8XxOxlgsueMQ2kUv78/JVN4krKVkzUJb/FMQ/w7hvb3phRl93InLNMuxUuM7r0tAnVZi8GH2SdEqzm9dmGxp+/WIvhLlyuARXaL4wrVzPKU0wsXze6QsfAJzozwkhEAj9Kpmu58973Nxe7j1wY5tMb1GTjq4OykH04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795362; c=relaxed/simple;
	bh=OHC8742V3u8OW7FI/+ySpTi1uyOZzNiKP+eBpgJkQmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fsnq1DMUNvOclprS1ACcE7dt1qlPqdhwi7Dny5uY/zAbDu1ft6PomWPouJ5ilrzl9yhn+yHOMQWMpbV4qh3Z4TAKsaot5wMdGPyPVzz0qc8G0wdEsj/uTieEgksHPRM82S/C0pHT97ENDrr9NHw6LLBe10OaPnbVWDRP1Mt3sro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wT5bJUox; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WIP++vB2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wT5bJUox";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WIP++vB2"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 470E81382D78;
	Wed, 12 Mar 2025 12:02:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 12 Mar 2025 12:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741795359; x=1741881759; bh=OHC8742V3u
	8OW7FI/+ySpTi1uyOZzNiKP+eBpgJkQmk=; b=wT5bJUoxqRTkju+aKkOAQGyhuU
	mAq2v1xwsvc6YtVI9x2AQ0UmZV+bY7bq2ccC/DNCHhmBQR/ptf433vj19mQNNv5o
	QvLNNt9roi4uz1TMxFoQntZHSGvuM2qlaO5Y5CEMv3qXkJOS5fRPXysBVcoHecrx
	nvkgjuK05+ujc/LRo60+SDj9R9VtAPTKhzwFHq43ednsdZrNSwSwU6xIO4LyqNoW
	XrDlCbm+XzbBWibmDD9/6CaqidE69lWInoW5Vb0XbArJafeXw0icFK7nmJgOlhP/
	cb0hL6HDFJ4VMGuJAchd4qX1auDPgCE0nDGArlWbWVu7w8J8zTfC9IVi0Egg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741795359; x=1741881759; bh=OHC8742V3u8OW7FI/+ySpTi1uyOZzNiKP+e
	BpgJkQmk=; b=WIP++vB2qQjB2Pr6lwauecnPXkJXzjLPcAxnMTOFFT5pOWKTwdN
	zDIUy08Dp8WJFfdPZf/5RPNAeFH11e2RnsNVJDR/2WyeKmFrOHje+m9A5HjCzBEO
	Iyb+Xurj2dn5qv5W0FsynaGU6+dDNoL4XNkIaTuDLShbiaZjd/RQar2TNS8dMFFO
	QyOzhIHwkYj4tGxsXV4eBpYtRFzwkeyOOODC1wBztmQtmWz27BA9uiaVvwRfjxAA
	HmyNPUJv9e7aO+JQD4mdW4PAD9XsKn/B2MF2B9Yr0sKdfEL3Q9D1lCJbwg4I5LR+
	cazkWA+7XZLtP8Dwji3plXi9jESCtHMmlIw==
X-ME-Sender: <xms:HrDRZ_px7_nRrk262lvtILPPV_QjgOZP_KTQaUx2Enycil0OdteDtQ>
    <xme:HrDRZ5o_yLGC-7Wr-5Ei6LO1pZ0S_KnnGSU2DrbP7qc_lZevj3QF6mUPsO0M9kRKF
    -ZWlIUN690myv6f_g>
X-ME-Received: <xmr:HrDRZ8PIv8BISGK4KPUuzZtuUbeLl62ahiTtZHZC5zlTLrHyv0gQ2i33pFPaQVWTMBJH2QAK0Xv8TpZpRNGX0Xn9jSJveQiiyD6S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhimhhonhesjh
    hoshgvfhhsshhonhdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HrDRZy4Zr9KS1CLGJKv5ysYzVE3L4t5YfjiTucl_rw9CWIq-ItqI3A>
    <xmx:HrDRZ-7Q2FvzXGn_eiH-_VpU9B4xfkV0owEONisCtBe1SFOdlRYJjg>
    <xmx:HrDRZ6hlVWelm4QON4A68KFJimrnN5vFXb68HDAsEEQ1IoorIDVeFg>
    <xmx:HrDRZw7KLpLECNdne5YXJAS0S0GWqRaNjFzkCsq0_mlJFpjTMRoHhw>
    <xmx:H7DRZ0nYFUtSDVIdUe7OxeRJlc6wd-kayEAfhrE5LJRc_KbutTWOqGM1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 12:02:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Simon Josefsson <simon@josefsson.org>
Cc: git@vger.kernel.org
Subject: Re: Making bit-by-bit reproducible Git Bundles?
In-Reply-To: <871pv2jx4a.fsf@josefsson.org> (Simon Josefsson's message of
	"Wed, 12 Mar 2025 12:40:05 +0100")
References: <871pv2jx4a.fsf@josefsson.org>
Date: Wed, 12 Mar 2025 09:02:37 -0700
Message-ID: <xmqqbju61bky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Josefsson <simon@josefsson.org> writes:

> Can anyone explain what is causing the irreproducibility?

Multithreading?

