Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58885227B94
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 11:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697253; cv=none; b=u8MIHtang0VktN7O+QwuwPOAPeK0yKCCVriNHvkwca55LPTi5XQMb/xJTHtwnqlrTRihAIAm2+evNquz2r70hN5MBg6gIyGdI//H/dSYjDBLw6mDc4emWTSqJN4BFFytqsC1pS6TFq3K8kdJmhd326qWfoZ2CBGBZhcNv74qk00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697253; c=relaxed/simple;
	bh=7oZJFtLbU5rLbhemrnE7QuXuedrLYSVI22+3hwYCV04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NlEDYhjzzDEfH2q8Wi7kQpPciXRNowJBwZw57W0Oy8BNMQezLe9fUCzDusZL3sydyBTwovUwAxOz7YBZppbAuoJY9IMN94bpGQpKiE2NObU55xhl7+Yuoh3AC/+/dJeuTBd0T9CZSmsd7UcYXrkScIyC9m17q6RA9/PrIwC4gFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oODtLQ5L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZrGvE1O; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oODtLQ5L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZrGvE1O"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD2D37A00CB;
	Wed, 17 Jun 2026 07:54:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 17 Jun 2026 07:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781697251; x=1781783651; bh=/ZwPcyOvt3
	XeNSb9Nm7nSD4PxT+sF24iJZ7VR7bqNMY=; b=oODtLQ5Ly8b8VqHM/NbxUDbDWv
	fBD2Uwnr4k/LZLCuhHn9mwaiFtrZ4N72B/MXtjLNLs3+JQNuUzTUE+f3ab4bEK4m
	JX/Y9vU6MFMKcuzgdKTiyal91tBctpIQXsdPHb/n+Zs6bOZbQspd8bj/hzOo7hMz
	D6f0qHlxRsSU0LpNUm/kzS115JupPfPcbsz6a2LzKU7xv3HKNrlgdHjialEAFamI
	0/ZVP5tKIUUzzbrkLZngbizN42j9knSGhZEty/ZZRVpaE5I+tBG7LeNbioC2r1Ni
	NW45jjPm8LB2GIahHWJCD/SmDHgbmi1yiTg/rmRqfZ1ysxGZ/VrhE1o3ywUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781697251; x=1781783651; bh=/ZwPcyOvt3XeNSb9Nm7nSD4PxT+sF24iJZ7
	VR7bqNMY=; b=hZrGvE1OrkgT83rmAdkC1QK3Jtn9H1dtAlLXih3ZxcjFYX+AYey
	Y8pw7MpC7+Z4VTjfoL3pB4JD7xmGQ10//CGUL+1f+ORcFd0hujllVihD5Cm4MfRZ
	A2MvNaDXAtE5qSPR93cGKvYENc0nfKabKA/45bf5sDv0MvSpN/1pOe9rI+u9PViy
	D9SFjG0Tp2QK0/PTn3vBBK2NhQi13XMw5JQ81/oVMngh/r8kPCLaiJzacCKE2Xwb
	N9Gd+0VEsD6ybFRboc9Rwq2qDXTwAw3pSz1otDp9o7SxVP7fj89iD6jfUInL5SJr
	eRr0/rapOlr39Aukmet62tZwUTrclp5rFSw==
X-ME-Sender: <xms:44oyavbO5HbG_YRJ-sbFs7Ku9QLkMZU-sH-S69HAa10YUvP_xJPs-Q>
    <xme:44oyalbjU7PQusoPcRz75x4vU9BZ3kYWM8iraE6a6HzorF6jWtMZuh_sJZbeWXIjt
    60KiMAjEtUKoRRAgCpT7yA4UPRTLYZLpLl4M7cE4KKIIEgcq0PFlQ>
X-ME-Received: <xmr:44oyam8dKU7Pm-cOZXA6IlXXh31x8bwFq-G5AAgll-kv-Y3RlFNe6XR1wrJeKVvOtxWZc0qY7hkTr5jBh117zhwgZhUi7w8vRc87>
X-ME-Proxy-Cause: dmFkZTFB/fFbrb4SRL6U0vbzzjRGhBdEvPVuL5n0B6JwXlPA9RwaR5kKJH5RDriLu6gRSv
    ElyUOFsQanAGp/PlCzhiPZt7LBwZ8s8oAy1rZ2oda9dSIy023m+aomQERsARBVRqxAKBe5
    pka6f4OxNyPEjzWtXEhWQz+kGzJQRmf6NRuiDK2U07sEwutYjJkehON2e2J9HZZqLT04TO
    JnFtEal5bCRIwntHErlAxTnSyqwDf9eJjhythqmqNW9pTp5stm+7Nxq7NLma5IrQbjYy19
    4mcKMTavrZEf4om0DzpHuuujgtVT95HELW2tPYVFzzeYemNhB7M/GuZSfkXTMrVLSfe3Ik
    VMEur8O/WYEcfHiouynWnFGnIvJnyRYnH7uFIyErqq1fb/Tej727ajMw0eGulaLOkrSeeI
    pKrd/TUkOrMsW4AnEakDYXRfEt/JaM5APA7Sf7TRLY79kj7f5DrHhEaEjq9guWB0YjMh5l
    DbDTFNBoW1kTtWHu0sG8ozka+obYnFnYQYsG2iKWJKHq/5zKeQJFPRfX//tepcR1OuhJmm
    TcbsFNfGoSo235kVDnyoE7OKE0KeCbi6MlGF/50euJ8FwLvTxFksxV9BDq3PS31xBwiuZx
    BmOQ4OEvANzdt8VAwieJn6nr77ohrqJd/Co4cvspmwzvronejekdbAVc4yfw
X-ME-Proxy: <xmx:44oyakhQZ3Vb4QnTri9CQr_E9O35SIuroX_5a0NUVae2677PQADE4w>
    <xmx:44oyamcUv-53YBAWi7Q7wFL_QOjpUNoPeQqyauZ3b4qu0kWuhHBy-A>
    <xmx:44oyarqHOsOC-9apHZpa7EvTi-PHbq5PNaPs6Xz6wlUziqxGKjvc0Q>
    <xmx:44oyarD5P6n4_TdMRWwyJKYfakXB-lqIaZJ9HM694olZFZ-O8S2aKQ>
    <xmx:44oyasVGLRPF3WBuIeLWvoF2e8Zjo3wTlPByFzhXKLT4I0jhdL4xF_O0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 07:54:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] osxkeychain: fix build with Rust
In-Reply-To: <pull.2154.git.1781691074710.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Wed, 17 Jun 2026 10:11:13
	+0000")
References: <pull.2154.git.1781691074710.gitgitgadget@gmail.com>
Date: Wed, 17 Jun 2026 04:54:09 -0700
Message-ID: <xmqq8q8d1ixq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Without NO_RUST defined, the varint encoder/decoder lives in the
> RUST_LIB, which needs to be linked. Symptom:
>
> cc [... -o contrib/credential/osxkeychain/git-credential-osxkeychain [...]
> Undefined symbols for architecture x86_64:
>   "_decode_varint", referenced from:
>       _read_untracked_extension in libgit.a[x86_64][63](dir.o)
>       _read_untracked_extension in libgit.a[x86_64][63](dir.o)
>       _read_one_dir in libgit.a[x86_64][63](dir.o)
>       _read_one_dir in libgit.a[x86_64][63](dir.o)
>       _load_cache_entry_block in libgit.a[x86_64][174](read-cache.o)
>   "_encode_varint", referenced from:
>       _write_untracked_extension in libgit.a[x86_64][63](dir.o)
>       _write_untracked_extension in libgit.a[x86_64][63](dir.o)
>       _write_untracked_extension in libgit.a[x86_64][63](dir.o)
>       _write_one_dir in libgit.a[x86_64][63](dir.o)
>       _write_one_dir in libgit.a[x86_64][63](dir.o)
>       _do_write_index in libgit.a[x86_64][174](read-cache.o)
> ld: symbol(s) not found for architecture x86_64
>
> While it is curious why these functions are needed at all (osxkeychain
> does not read or write the index), the compile error is a real problem.
>
> Instead of trying to play games to add `GITLIBS` while filtering out
> `common-main.o`, replace the `$(LIB_FILE) $(EXTLIBS)` construct with the
> much shorter `$(LIBS)` construct that _already_ filters out
> `common-main.o` and adds the Rust library when needed.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Hmph, we do not build this at GitHub Actions based CI?  Just being
curious.

Let me take this directly to 'master' before tagging -rc1.  Thanks.

>     osxkeychain: fix build with Rust
