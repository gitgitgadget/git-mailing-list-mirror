Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0FE41C2E4
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607970; cv=none; b=JrQ3sF5pUHigtD238bAkQUdKowjtY0UF7Z48d+Mlhe/2Y5+OdBos8jQsSdlXFfKdPLoLccgQNS3bzihoAwODilvYdddPyppoWJOgoYrY/D5veg0pbmT7BL0LhbBOhaVOGrdh9iyej3rlgCk/WQK3QvVKW1KD5EfFUOokN6cwrBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607970; c=relaxed/simple;
	bh=x5saMQqW7dpbgZWsLIAFIlR+jj2nA7VaK4HjtL4gU5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcmm1kLQScsGmyu+hmkmhywatWiU1kpHFxTDWGYuCLQSGNagLXJoUOKQNUpZWop4EmVv8CrLZwJzlf4SLRKwTTPUCosWvl5PCvIiX1VjBIfsYIfrcX6AqI6u3ut1TpuG6y/YgMM/0t6uggrYA6DlKOh/0ffMJCFF0HlmLhkg1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l7ZqBQ+c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lz55jZaC; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l7ZqBQ+c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lz55jZaC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CF5F1D00156;
	Thu, 13 Aug 2026 03:59:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 13 Aug 2026 03:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786607964; x=1786694364; bh=tldBmM3RWp
	TUdUrJQxhFpbC9jumpYZHzSAGI+fRlr4s=; b=l7ZqBQ+cAJSMWi7hmukvH/NIHP
	D9ULlximq8JdkCFh9oWQMS4D7/wZDQZ0BG7a/ng8j0vftiLK/1EOoQAt0dQgTHYy
	ZH3QGEiZehaMWzNiJhHNUbUdTEZJm7cM5EQd7x+AkOAZnTf96/r/zdVkpbDz+Epd
	XDol7OTnfG6aLJtFGGGxMKsryhh8ibs74Nsvvew3Gxhq3sSk+39Is1mzqlJGk1n+
	V9TF/DVhC2fjOBfOtlHouMhmW6jZ/6ZgwXYsrfj1VZkBKuk2YeIb0leKLGPCZSZo
	+Mz2+3824QT1YPsVtwr318BsLB8s264bjAdr7MAZoxADxnNETvj8z+yfdRsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786607964; x=1786694364; bh=tldBmM3RWpTUdUrJQxhFpbC9jumpYZHzSAG
	I+fRlr4s=; b=lz55jZaCrAwxt7Bxa/u2zkY4rxYy1JscbvRh21N+SV1mEJGx4QI
	8ORZJkXVHPN8iUt0ttODjq/CcS711eALCMHnMe47MFd7i6VI2MuUHsXQE3gWuxss
	cBjuQwQgZD6Z/fPRU6gMP/1Fkhi59CYdNwKEIvozWcqf8DlHt3hliKI62qrhJ/Sq
	gkvbvigC7d79YZ51oQF42QspPBVKkD5yTEF7LumkVyRBBvwLJFEqhdS3JN4Rcfrw
	RfOGWsNr1WSIVfJ5MXWqYjsWjdX2CwcWDVLjpPEmqnyO7eiqJYebD0Q9BBCfOyBh
	kOVzr/cpy0wMuThYd2dqyZbGzFi09Wr7mMQ==
X-ME-Sender: <xms:XHl9ajzrvM1qeaARlTK49J2IAvZ4S6RoiXfVL5j05U75XbCCjSj6lg>
    <xme:XHl9ahSwqxCPwa5Gs2tCCPQU5QI-Pbl66Hgd4Efn35SAqQufzFAPEnLbsV72jS_WJ
    1uXdt_j6CsfdgLM5GHdXtt3wZpXYIwDpuUGkChQvwxeCm1-KJwXjg>
X-ME-Received: <xmr:XHl9aq_mBDjlmzEkgZWqqJgYJlopM0Qxu5fFOD1jgDGNHNU-cvEDeCpMTO638hTMpT0CcrbBFj4WDjYkZKp7p7fmdfdmkf19gYgjOvP-UJ3g>
X-ME-Proxy-Cause: dmFkZTFEgMXvN+l8NhOZpQYviglG34aMDU5f/C/2JBW9mthR0DjwcVRR/Xp+pJmDjNuxFV
    r/svXDvoX46LQyrqzk2mRJVigQf3cMWASCBG6WhJICWIAd4ppPG/4G+hbtqTrq0AFIw+OI
    bWVRuyvxG3T26TFfndq4ghEHaaX3CTdrqNagHvQYKFHciKHhFJGAaiLZ29t0zInZDxJT1V
    G0Pd9lOZKuMKiqcl9ZcrGMfrpCP9H2TZTuycy3xFP2xr7shDn/cTy0J2K4FLmH+LUsp4Dy
    vcrC7zxxZw8f393TCZ7TWaRRHpCU0pJ2IkSGQJDNR3CEEUPsmLJn/94ObtSsPSsi1GvFqf
    ZrZ7tcIeeKQ1jHFMWBczwj9quu2IgimCQ0+kfsPfguG2WT/VRuNDJyDzS9ShIem7A+6FQ9
    aIFQLiV8IqEGc9sSyJ3JZKI1fVHIYFojQdtjNWdDccZFw7i7H522ob+F4rbqmNYrUq3I7N
    ZSfLOtqEgVEpNd3puUjPzekEwWSKgr1LymSV/ix45a7WEouzL7JmUrvg2ing9AwySJr9HP
    ShoaVbR5315S1NGsBdyF+7FCqI5v2BcxrBD4noLd9VQWw8x4jyGu+Nl0ZfcCr6dJoXO4NR
    JQga1cAwIwCEgozODEjDSfX5twrwTnThDpIDSv8Cr8HCyQ7570jWt2DqK/3Q
X-ME-Proxy: <xmx:XHl9aoq7hdSOMIw5QxBWQLGbLvVlLwVbVmOjf4O6XtuQ0I1AmhgkWw>
    <xmx:XHl9anlTbRzMKYre8X36oYyhqIJZtKQM5Cqz0pMIg0JXeQ-M7spgzA>
    <xmx:XHl9avIrr9JI0UzodRCBMoCpnz3agb_mkY9nIkCgO8E6nufSb0H09w>
    <xmx:XHl9aszUvVCpHmIkMmqvLH-zkX0XlFqMy_a6cLUVJ-U6co2ooynI0A>
    <xmx:XHl9anJHdDNaQR3qbRUSJEys3sgW0_TptqfZEgL8vR6AITq-4RNmlpIB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 03:59:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 303639b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 07:59:21 +0000 (UTC)
Date: Thu, 13 Aug 2026 09:59:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2026, #05)
Message-ID: <an15Vvcfudlz69TM@pks.im>
References: <xmqqcxvmvda1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcxvmvda1.fsf@gitster.g>

On Wed, Aug 12, 2026 at 09:45:58PM -0700, Junio C Hamano wrote:
> * cc/git-shallow-file-wo-value (2026-08-11) 1 commit
>  - git: avoid segfault on "git --shallow-file" without a value
> 
>  The '--shallow-file' option of 'git' command requires a value, but the
>  code did not check the presence of a value and instead segfaulted
>  without one, which has been corrected.
> 
>  Will merge to 'next'?
>  cf. <anxXbnuRt4I4uPdI@pks.im>
>  source: <20260811121446.2080190-1-christian.couder@gmail.com>

This version looks good to me.

> * en/sequencer-lose-pretty-given (2026-08-11) 1 commit
>  - sequencer: remove unnecessary variable setting
> 
>  The setting of a now-unused member revs.pretty_given in the
>  sequencer machinery has been removed.
> 
>  Will merge to 'next'?
>  cf. <xmqqa4qrxneq.fsf@gitster.g>
>  source: <pull.1922.git.1786516959130.gitgitgadget@gmail.com>

Yeah, this patch looks sensible to me.

> * ps/odb-streams (2026-08-05) 8 commits
>  - odb/streaming: unify function names to create new streams
>  - odb/streaming: rename `struct input_zstream_data`
>  - odb/streaming: rename `struct read_object_fd_data`
>  - odb/streaming: consolidate read and write streams
>  - odb/streaming: rename `struct odb_read_stream`
>  - odb/streaming: support streaming arbitrary object types
>  - odb/streaming: drop `is_finished` field
>  - odb/streaming: track write stream size in the structure
> 
>  The 'struct odb_read_stream' and 'struct odb_write_stream'
>  structures have been consolidated into a single unified 'struct
>  odb_stream' structure, simplifying object database streaming APIs
>  and enabling streaming of arbitrary object types.
> 
>  Will merge to 'next'?
>  cf. <anuBdm29ye_qV_Rq@denethor>
>  source: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>

Yup, I think this series should be ready.

> * js/coverity-unchecked-returns-fix (2026-08-12) 12 commits
>  - bisect: handle dup() failure when redirecting stdout
>  - bisect: check get_terms return at all call sites
>  - bisect: check strbuf_getline_lf return when reading terms
>  - transport-helper: warn when export-marks file cannot be finalized
>  - transport-helper: check dup() return in get_exporter
>  - compat/pread: check initial lseek for errors
>  - last-modified: handle repo_parse_commit() failures
>  - reftable tests: check reftable_table_init_ref_iterator() return
>  - reftable/block: check deflateInit() return value
>  - reftable: handle block-writer initialization errors
>  - config: propagate launch_editor() failure in show_editor()
>  - http: die on curl_easy_duphandle failure in get_active_slot
> 
>  A handful of code paths have been corrected to check return values
>  from functions like curl_easy_duphandle(), deflateInit(), lseek(),
>  dup(), and strbuf_getline_lf(), resolving several Coverity warnings
>  about unchecked returns.
> 
>  Will merge to 'next'?
>  cf. <xmqq5x1fxn5u.fsf@gitster.g>
>  cf. <20260812213438.GC152730@coredump.intra.peff.net>
>  source: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>

I think this series should be ready.

> * tb/send-pack-no-ref-delta (2026-07-12) 4 commits
>  - send-pack: honor `no-ref-delta` capability
>  - pack-objects: support reuse with `--no-ref-delta`
>  - pack-objects: introduce `--no-ref-delta`
>  - t/helper: teach pack-deltas to list delta entries
> 
>  'git send-pack' has been taught to refrain from sending 'REF_DELTA'
>  encoded packfiles when the other side asks it to.
> 
>  Needs review.
>  source: <alQ7WKITYDXfiVn9@com-79390>

In <an0EkMZGEbg6LERc@com-79390> we've agreed that this series can be
evicted for now in favor of
<20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>, as Taylor
still needs some more time to rethink the approach in there.

> * tb/midx-incremental-custom-base (2026-06-12) 3 commits
>  - midx-write: include packs above custom incremental base
>  - midx: pass custom '--base' through incremental writes
>  - t5334: expose shared `nth_line()` helper
> 
>  The 'git multi-pack-index write --incremental' command has been
>  corrected to properly honor the '--base' option.  Previously, the
>  custom base was ignored by the normal write path; packs from layers
>  above the selected base were incorrectly skipped by the pack exclusion
>  logic, and reachability closure for bitmaps was broken.
> 
>  Needs review.
>  source: <cover.1781294771.git.me@ttaylorr.com>

I'll try to have a look at this series later today.

Thanks!

Patrick
