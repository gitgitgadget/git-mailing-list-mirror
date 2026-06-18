Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62278221F20
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764245; cv=none; b=AsQhS/3LCu7ifkm8G0pbzQOUJimkt2CnB6R7MXCAodzDRd8vse1Y+70tVpAzOBobE2hBIUREPyQe2Ih/VsqdegJGtyZXejO+BYmRm/9e7k8LC/HHoTyC8BDy7Qq83r0exNzjEvVPwNZZLs0+8Dv5LlnGXcnB1rk0PNu+Gz2IfMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764245; c=relaxed/simple;
	bh=F6/O3SnfaKtIQOStAp+f6XAjJ7MdTIWffLDhXksmrfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAqNM+sWjyCnJVonxKejVa3UuQi9i0PvnXKadzdT0EaJ9ZTGK7tDzYnodHgZDikV3FbutZAAJl1fVm1mxuLuFB9oC9C7aIehgvPes15AE8Py7n3wsTNCsYuvgnYzKnSwswDkIEK6jIJLKCjeGzXU1fIMHpbNQ/G+iObaGP2H6YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OzwwKU12; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ab9FSOVm; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OzwwKU12";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ab9FSOVm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 900EA7A016E;
	Thu, 18 Jun 2026 02:30:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 18 Jun 2026 02:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781764243; x=1781850643; bh=YBttzBq/KX
	E/2BhQV3pyNQ244KQ7js40OOWeebHHtak=; b=OzwwKU12GFkfQ5yqJ5UHQUdC75
	f3ISB39cVz9TzbHM2YNc3thVNXmQ2jOVAAN81D2q0ZvgQcc3Q9J09b9p2vze6Tck
	JXOOFN5qQM8nl54nWYi5BP0kyNsImPH1nastNfuKfa6IwmHkIL+9W1kJAMvj+vhu
	wyqD014N4aeHARORJFcxWrx026iyS/PnZuFpFwWifpFgIzHANYf5B4xRvioK0/g1
	Uh/uqjBCmwXdfFNYvm2ChC7k9x/ZHb32IHRKoxKgAk6D3kMI+plIPRwicoVEW1F2
	z8tRSZWIizkm6SjGawU/SZ9RnSqQKm3nDpSounjTwmLYJrBByvM1Z75rouug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781764243; x=1781850643; bh=YBttzBq/KXE/2BhQV3pyNQ244KQ7js40OOW
	eebHHtak=; b=Ab9FSOVmkmrRfvUjFNcQn8p8prjg8vwi41qLZDy2H6lgdCJBxFw
	omX+LeJSnF/JNgAnW5B34+sHYzGa9dOnDdy22nTNuA+nN7zv+yo3+D7gnWqpI4JH
	4YC8MPoseWL3US92NjMZfapAPY2Qf+hEUVQnrMwRpfdh7+oHc29JErgg+J6n2uCA
	ytVcInQHgNlB20PmzbQOlVDjJ1Q9o57tWlVTodbcNZSHsxaDbHYc2HHVSKj7IB6W
	GFpSkyhxtzedhixFTe1fZkCOu19w8vYPdDRSPz6ihVf5oPQUjpAwNzJhsz9+Qowi
	fzJ7Bog/Sx2jVoRfPZ6WtLoy29jcOh/6Mrw==
X-ME-Sender: <xms:k5AzamrjCg6CdIQPT9CHKJ7Mkgje_EMB2uaSnfX1JMg401reu6twFA>
    <xme:k5AzarrQ2rfoHD6sO_1sSy2OJodo_yBmvmyXMQrSF2lmra6pZMtfnrtstDXvJSA1C
    5aZ9ySdFITjhJZFGK3oR4QNULAI1QwiHUh0jvgA3de-DY9ShkA-_w>
X-ME-Received: <xmr:k5AzagMJFAUbIU3DPDElXqghX1eOWd9rWbZ3P9PWou1TICXnD3wt9sHnohAqCgJWE_mRF_gHSXyIHlU0jpENFOa1JzioGCXKcq2FQlB9Ng>
X-ME-Proxy-Cause: dmFkZTEiPa89YsmrAzVX6Bfq6ui/en4HSK5ajQI3pVN7/+f3WZj4Ucr2zEcH5ovUn8Kex8
    PmkkGGpFcQJUIjhixfMfWDHlIYwTOCNMUxvcrHAIRpLqv9P0ZvX+W+suMg4DJ1VIf+vVbV
    QidV2nJP/dmyxdhHNBGQG2JEsQrAv6POJPJLHRu1LPEYt7zbUyJ3SI/6YBSJcAhhny/yqG
    3eWPLhV4rH3xjuU/rq233KUDNq03WPbb28Yy+2X3+ep/9eQ07A33kWOChDwlXC/6Z2tQKt
    IlDywJo7essvn33mQB1hR25CvKOaw8ZlrptXRblGlDYssvnXNBRlcj6H/4BnkB2BAwH5cS
    AFTGMy9sxuD3Y/PWuL3PFM6t+DDnD5y1Jcw4yDnOk+Ch9PUOMWawp01o8W8OleVfn3v5ro
    v1K+TxvMAjfsy5oIZrYaAbTAUJ+mtgZQYcwZocnssNfOlRbvdMnp65shHe1LgKAwhM3Bt7
    6AJ9C0S3mU/xxNZXyVo5QAtR79uGdJkVoJ7BBI/Pq7p7mkwN/wdk+JXRwGz7zQ+wuKhzGt
    2DytJ8hGekR4ENZFF2rhweaUD2VFF2VogNvt9PM/whSvTGbESYDzstnmXqE60mek3Ff+pu
    /Lk1z5SRpeVeZU7yKxEZXwjkWpXvkTlz2UfIIA7zlwVVHCsgZd3t6M4iSYRQ
X-ME-Proxy: <xmx:k5AzakyWhOvJQkqmHOP66WAmItS0tNuYj-UuM8V0tIx3hia5Xrxhyw>
    <xmx:k5Azaht8zYl6GiBJRfy6W5_5cKv4ByeNQvu9PsoN-fr9bA2MPUIJYQ>
    <xmx:k5Azal5neGuzohxMUhd4BKqTOSuh3LwoRU2etaZ39Z8NPt9g-PCGHA>
    <xmx:k5AzaoSKtUUJz501un9XJ25w-5XA80s9byNi9Ga0qdfNnLaLnMprtQ>
    <xmx:k5AzallAW3FKj5I2ul5kb__x_C4At5owccVstrCGlmMVt9CQTkLAZCQn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 02:30:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe73b019 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 06:30:40 +0000 (UTC)
Date: Thu, 18 Jun 2026 08:30:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] osxkeychain: fix build with Rust
Message-ID: <ajOQjfLXQwdEB6Hl@pks.im>
References: <pull.2154.git.1781691074710.gitgitgadget@gmail.com>
 <xmqq8q8d1ixq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8q8d1ixq.fsf@gitster.g>

On Wed, Jun 17, 2026 at 04:54:09AM -0700, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Without NO_RUST defined, the varint encoder/decoder lives in the
> > RUST_LIB, which needs to be linked. Symptom:
> >
> > cc [... -o contrib/credential/osxkeychain/git-credential-osxkeychain [...]
> > Undefined symbols for architecture x86_64:
> >   "_decode_varint", referenced from:
> >       _read_untracked_extension in libgit.a[x86_64][63](dir.o)
> >       _read_untracked_extension in libgit.a[x86_64][63](dir.o)
> >       _read_one_dir in libgit.a[x86_64][63](dir.o)
> >       _read_one_dir in libgit.a[x86_64][63](dir.o)
> >       _load_cache_entry_block in libgit.a[x86_64][174](read-cache.o)
> >   "_encode_varint", referenced from:
> >       _write_untracked_extension in libgit.a[x86_64][63](dir.o)
> >       _write_untracked_extension in libgit.a[x86_64][63](dir.o)
> >       _write_untracked_extension in libgit.a[x86_64][63](dir.o)
> >       _write_one_dir in libgit.a[x86_64][63](dir.o)
> >       _write_one_dir in libgit.a[x86_64][63](dir.o)
> >       _do_write_index in libgit.a[x86_64][174](read-cache.o)
> > ld: symbol(s) not found for architecture x86_64
> >
> > While it is curious why these functions are needed at all (osxkeychain
> > does not read or write the index), the compile error is a real problem.
> >
> > Instead of trying to play games to add `GITLIBS` while filtering out
> > `common-main.o`, replace the `$(LIB_FILE) $(EXTLIBS)` construct with the
> > much shorter `$(LIBS)` construct that _already_ filters out
> > `common-main.o` and adds the Rust library when needed.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> Hmph, we do not build this at GitHub Actions based CI?  Just being
> curious.

We build it with Meson, but not with our Makefile. And in Meson things
are working alright.

> Let me take this directly to 'master' before tagging -rc1.  Thanks.

Makes sense.

Patrick
