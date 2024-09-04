Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6F188914
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439984; cv=none; b=cJFpsOhNkkPWVXV/JTWai+fyDrIcaxSxiwWRa2QpNeEPw9IPylQSeklIGVY6Hl3nu4ywjxA/eBRv3d5KvdRetAyLkPaiSpN4DO/VwcqyHFLrD4FNZ7Fs1iRLPxi7hM8Uc7dDnHlfsmI/3VJ/jcaTuwSvZ/njAm+mRr4FqGG1BsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439984; c=relaxed/simple;
	bh=eL4qYQZtRCaTTcG3CXDVZKTp/ibzeukVxsWMs4rfB3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnlLQSZ6bo/ZTgmmabuNl76V6KU+Ww61E9BksurFS/P7J2QM+WTxrqNnaM8t5nIZHLrSxqA0j1f/x801Dh7Z7weCSmNhvpJJ6KB1KaQX0xqa/M52HT2TYy9eSjYmXCjWKcWPadcUb3ctHro8kneJHn5PRUPJ5qCVtKGIS1jNih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KTCRqjT1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=slOJqrJg; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KTCRqjT1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="slOJqrJg"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 519FA1140064;
	Wed,  4 Sep 2024 04:53:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 04 Sep 2024 04:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725439981; x=1725526381; bh=p6nY/2u9sl
	XmF4cJpOsOVVElZymtFMh2FvT0LlPhD0Q=; b=KTCRqjT1tRs+wcbVAW3as2np/j
	kmFx5Kf+1/xKxCFfztUjbAtMYH/vpusLY/7OBQV3cmma3GiHW/ylkBGrAmxgLlyc
	fBJ7nhD8sAxq05DtD9LeqEEIGhR3pSCf/wC4HKd7YBB7raOa+ifSLT/qMSCffWpf
	7X75MNXeLCQtuVXiAmpJQWxElBSYUw3ZI4xJYLCDWlQQaX00zu7ZD20DbAFcCblk
	PD/b1tzA3JcPIxKvVDwJq9nJ45i0jA6qvrVZ5zm/GbPseaBk1vD6kJFx8gdNyVc4
	UZjFjjsYrnAOvruB20cL2E9iru7yUOgJW8j5AGV6o6X1RqYla5ILooOSo8Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725439981; x=1725526381; bh=p6nY/2u9slXmF4cJpOsOVVElZymt
	FMh2FvT0LlPhD0Q=; b=slOJqrJgSzMCoxVPrlvEZqk1iwNQ5XmOHy4/OJX9P8xO
	xQ9lPXkhM5+ueQasb94XSwWD6Bkv5FmY618xeeSolMoGRRQBuQo2b/U1ByhaG9Ql
	B8Lu7F0CDNAtOJDYbGQ+BeQR84U/bgVmaeMIfqT0QGaoKy272aJ2VJjgR1zhnKXE
	/b7VSu31t8Bx/WQSHjtI2hvvGtRkAeTpYx9moHkbwbR1HX2UXWNWAD3uUGp7+WTK
	wLCbqYsUxu6Gt5S/wu52oZMhDaKnCLzRcA/eGYIY8ixdxPBI5Et/atHlHqWwV4Rv
	RtePOi1uMqU+RPgZ2FuIEdMQ9vnkxvWPCmNhFelzKg==
X-ME-Sender: <xms:7R_YZqKllwn_Tg2V8rkmYeYAWBIkJM0U4DtcdTOImjYsVTt-mdJJIg>
    <xme:7R_YZiIur8mF2_B2i9Wx3FBvQA12MBShy89Cts4vb5LT-PBXrPhPn8ScjSLCl1y4X
    c2rNv16I6NZDIKRdw>
X-ME-Received: <xmr:7R_YZquIwT3zwaqJBeupmFYdS_ds7JvIXl1Ic2-bI4G0YkI8OSg49Cbzs7DGunwSTJU9dpMgDsdwvhzUFUke5gEXdvFSg9pNE70d4dEsMNm7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7R_YZvY-uLiSER43AsvavHBG9LMdVXZrd1dpGRbCJfXQTSIX5-aDpg>
    <xmx:7R_YZhaXD8rQToGHi5dEASOZeX6YjqeVmyFht_FbSWSz1mEs9jb6_A>
    <xmx:7R_YZrC0j-cdh4vN5ZBk0X_tzOqmGf12CJbjB6haQWJS-XLacdkd8Q>
    <xmx:7R_YZnagY1kK7P-G2Xl5dpInby0ZEEoQsjRe3dY3YWUmqwPlf_fz0w>
    <xmx:7R_YZlEA2G2cdRxjwOUplr5jlLNYnHl5u4vsOKcNRBtGDg7I3MN11RDZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 04:53:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9f2971e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 08:52:50 +0000 (UTC)
Date: Wed, 4 Sep 2024 10:52:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] refs/files: use heuristics to decide whether to
 repack with `--auto`
Message-ID: <cover.1725439407.git.ps@pks.im>
References: <cover.1725280479.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725280479.git.ps@pks.im>

Hi,

this is the second version of my patch series that introduces a new
heuristic for packing refs with the "files" backend. This heuristic is
designed to avoid needlessly rewriting the "packed-refs" file when there
are only a small set of loose refs. The number of loose refs required
scales with the size of the "packed-refs" file.

There is only one change compared to v1, namely a deduplication of the
log2 functions we have in our tree.

Thanks!

Patrick

Patrick Steinhardt (3):
  wrapper: introduce `log2u()`
  t0601: merge tests for auto-packing of refs
  refs/files: use heuristic to decide whether to repack with `--auto`

 bisect.c                      |  12 +---
 refs/files-backend.c          |  65 ++++++++++++++++++++++
 refs/packed-backend.c         |  18 ++++++
 refs/packed-backend.h         |   7 +++
 t/t0601-reffiles-pack-refs.sh | 101 ++++++++++++++++++++++++++++------
 wrapper.h                     |  18 ++++++
 6 files changed, 194 insertions(+), 27 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  df8c5dffffe wrapper: introduce `log2u()`
1:  3a8063e8b2c = 2:  4a59cec205d t0601: merge tests for auto-packing of refs
2:  9a63abfe3b8 ! 3:  49f953142b1 refs/files: use heuristic to decide whether to repack with `--auto`
    @@ refs/files-backend.c: static int should_pack_ref(struct files_ref_store *refs,
      	return 0;
      }
      
    -+static size_t fastlog2(size_t sz)
    -+{
    -+	size_t l = 0;
    -+	if (!sz)
    -+		return 0;
    -+	for (; sz; sz /= 2)
    -+		l++;
    -+	return l - 1;
    -+}
    -+
     +static int should_pack_refs(struct files_ref_store *refs,
     +			    struct pack_refs_opts *opts)
     +{
    @@ refs/files-backend.c: static int should_pack_ref(struct files_ref_store *refs,
     +	 * packed refs. This heuristic may be tweaked in the future, but should
     +	 * serve as a sufficiently good first iteration.
     +	 */
    -+	limit = fastlog2(packed_size / 100) * 5;
    ++	limit = log2u(packed_size / 100) * 5;
     +	if (limit < 16)
     +		limit = 16;
     +

base-commit: 4590f2e9412378c61eac95966709c78766d326ba
-- 
2.46.0.519.g2e7b89e038.dirty

