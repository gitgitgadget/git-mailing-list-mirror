Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA51553A3
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756054712; cv=none; b=TksFXhua6DFxzL4C62Lz3PglONfl5xAKWzoK2ADJbbcKXBoHQUEQsgyFYe/ffMv0+oCLyqXQR/cprJYkkAO5edUd2vEnRtviryD6hSZ277hNVI7dH8LDQ/tvDksG/888Yie5g++/zwaefUrzg+K2h6F1FBUrzt2KggM6JIbRxOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756054712; c=relaxed/simple;
	bh=XiIC4GJ9Xi1mbqVYpJYMXSxLmi/KH8AwRSIhocQdLko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgU3fWM94mOQs8wYt92rrVpirBFWKM4yLH3CoNv8O0lWYvjjbrAq9loFE5qxLD3ySU8LoiCICZUZqVfgIVGR4s8+CTHYRQw0rNMy2No4CyxmORhyg8VrIGigOPsuuIzD4VRBnTJDHAWQfLfW9+tcfBfFEKSRYsIlf5ybQrcrUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ltPThZLU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G3m3bLpT; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ltPThZLU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G3m3bLpT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C23A1D000B2;
	Sun, 24 Aug 2025 12:58:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 24 Aug 2025 12:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756054710; x=1756141110; bh=XiIC4GJ9Xi
	1mbqVYpJYMXSxLmi/KH8AwRSIhocQdLko=; b=ltPThZLUGkxRq++3Ur2NvPEtgw
	JS/Hh7f/qKkdAo299GSezCZ+rWZQe0czugCp0b+TJRfZEmIhf8IRHk7eBV93Zj45
	VuX4MmwXxX7Gj5NFF51rPQrXXbQ6jyBn9yoBXgkFrBCIExtYnuyqakZXr2XCrj8L
	7AC/UX9EFGV6KdipRPwpLydPYwjUQGbb8WVTFEt16dK1QirRpChCL66/FAyQ/mEH
	cSaYgbQ9S+Ie3k46fA9yeinlAr99lu2Qb7cKtuNQz3u18YyT+7anTrl2JDV8y2Uj
	IDjM9rTloRcFnCeLX9dJkr63/mavDYtn5bDzeEuPZxldfzTePGIIhbdkAJyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756054710; x=1756141110; bh=XiIC4GJ9Xi1mbqVYpJYMXSxLmi/KH8AwRSI
	hocQdLko=; b=G3m3bLpTNKlwoLbEKsMPKPqTQqKvLHgmQAlgdcwAvhTYWpMl/fg
	qyi9c3x1185FxG1PDzhAK+90eM1oms6yFQ4txYaXlKePPZWoAF59EM+6lzFindeu
	H1zksVWEswtDzWLThSchIeAHDM5nSWqbhJER91nb9ymM3Djsbidh9gDdQQiucfX6
	1PZRMqUOSKb9JrFzzT9cK8/SlHsrRqGYI5eq3QzXtC4bCb/Y5qpzGj8bcGqyF8+i
	T46JK285ovloqNh8zMIHDJ84+EuGRlK93yAYPI0wEn9p9/FHpiBe+ImA3yprlNU0
	q6cu8Gah9M6NSh1FC1G6/LCkJIGMgVuPAQA==
X-ME-Sender: <xms:tkSraC8Sb45-MbBH4Wv2wN9tDhaOribr_ghV5AcB0hnpsVDLozqzSA>
    <xme:tkSraNQF32LmtOhwxJODeErVOx6lHFDaf6Ev3za5kIkUKVAvUCo_Yrw_i9DDlPlVO
    AIduKbseFMcJNuLdg>
X-ME-Received: <xmr:tkSraEkBwogcCeQih8K8aCzy-l-7R6vOn6J84RNzpR7Z6IksTgoUgPWEydJPXjjgd7hiCTrRrFrN4cP8u8HeuQtOMF1Qc90mQKsHhbEu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedttdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:tkSraNRXT7KYFXt0L7B9nRHs1vSxoJHXASIN3lHg4xg-4X0YwFLCvA>
    <xmx:tkSraCMrt1Jlm4RLAD_RkQvoAfLonjANen3m44fAToCLfLbq06CLtQ>
    <xmx:tkSraGXj7W6-I1jf5i6Zy9Ajx4uvDt1RfDCJhy9eS5-OvXTUBDxdgw>
    <xmx:tkSraJd230c2QNDMtRmQo_c5KIhopiej42e-Fh1zsZDyzr-f-V6CmA>
    <xmx:tkSraFNEOwDB_czSGekCA5WiOB2QZhVlCs3FaqJL65BIV5pyiosvtLEn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 12:58:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 72760493 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 16:58:28 +0000 (UTC)
Date: Sun, 24 Aug 2025 18:58:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com, gitster@pobox.com
Subject: Re: [GSoC][PATCH v2 3/4] t1422: refactor tests to be shareable
Message-ID: <aKtEr0wwNHfiF4dN@pks.im>
References: <20250821085246.929307-1-meetsoni3017@gmail.com>
 <20250823060012.540433-1-meetsoni3017@gmail.com>
 <20250823060012.540433-4-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823060012.540433-4-meetsoni3017@gmail.com>

On Sat, Aug 23, 2025 at 11:30:11AM +0530, Meet Soni wrote:
> diff --git a/t/show-ref-exists-tests.sh b/t/show-ref-exists-tests.sh
> new file mode 100644
> index 0000000000..2c29643573
> --- /dev/null
> +++ b/t/show-ref-exists-tests.sh
> @@ -0,0 +1,76 @@
> +git_show_ref_exists=${git_show_ref_exists:-git show-ref --exists}
> +test_expect_success setup '

Tiny nit: let's add an empty line between these two lines.

Patrick
