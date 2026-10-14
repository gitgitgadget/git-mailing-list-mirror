Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26F563280
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001786; cv=none; b=HqTWcy8/amtTGPgELEtcEyZ6mYBpzlO0VlunW0SEfjWdJzK8/bft6f2CGh6y3YWIv6JkmwmmVqM4tVNNSCVL8gDSZVtQi4BHPW6M/EPoO1/6PDGbigsKye0dUe2eBje0kHxUwv+DlUIcpQrcmsBaZIl34V8hhsjXMFuzPVbwtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001786; c=relaxed/simple;
	bh=8SkwE1t0iPcITGpe+9KVBdG+swDOKXSPH0LXnDCZOxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QKd07Jcjofj8ciIpYQmYtDcz/4pFLaU1dV7MF2GC5sxIB3mQXdeUzK9OgvTeKQ2Urn2mZob6mAn3WaXSseUAAC32lO4mYQpXKr9GrIxDcRMYn15UNC8mbHe02J99WS1Z4Uim4aN+vZGmex0uMcKufD3RNwlDVycLxtpwwzVe/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FWg/Gg6Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HbuBlWd+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FWg/Gg6Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HbuBlWd+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05F0D14000A4
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:16:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 14 Oct 2026 14:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792001784; x=1792088184; bh=9lfor7lcq+
	KxzB7CeMv6+E+uR0HEi7s3mnXy397B//A=; b=FWg/Gg6YSoS+n9zklc2c0aNouZ
	Y+cHc8Ofx1r1VPvNNXizUkFjXns0m3iFcbqqRA4hkcStbK+abSrt6UnJ6tEUZ+TS
	M1BD+Y9sapRDglWlk1c4IPpG8oo60L4azeZdu6ynTXWpeP1irIsctw/upp3Qq5YR
	wRmmByINXVapkUJP4DsvKtsPvtc4wUQ4/aaoc150f3pBa2EJRRf+kApm3wGRjI8J
	xjQoUly2sojISvrc63ds4XrKg6qCrcnwS24CUGz15G0laEv2Ew3di0aeCgICfn9P
	m3L/5QdGMVPFjBFjTUA/Tud9z3Gl0fn50YJwCdnygjbR5MXBgqFaRsHclROQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792001784; x=1792088184; bh=9lfor7lcq+KxzB7CeMv6+E+uR0HEi7s3mnX
	y397B//A=; b=HbuBlWd+c17YVvsPDED7v0O1N0WNjvrgaiHka33AfjQUxu00n6v
	sDV3HG+vr9mSH9MLttqdpfJicPnfX0VbvefzDOH0eOpuApXp4i7TVMed3kFV1Ntz
	CnjugVfH7xgqO24qCUvut77DgIKIANRrsvGQNV4iyTzC3rxAx4Zm5+7mRN9PriC7
	Dxju+RpECsHYsGklUzIOLuokK01NEdzxy9tkbVcFg1VqDwwCI1dbFWNH5AiwkdVd
	szGFEDJXFxpA1Lc6mSxJkbiX1cceokG/tn1BQdZxHFPzWLNC/VCl+wL07/Mxc8MD
	4kMp8xTflsdp+pqndXMSctboR8MfZFBdqXw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792001784; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:B94PMf0VmDYTJpQKLygYVahI69t5FAyo97Akdu7L2CmUtN/
	xhiI1rzQhiNrYqAO97k+mEQeS3VVLV7uM9mprLMgw/7HmyqK47+IK2WAwRO0bNgs
	v0DfM6L3zABOzdSxGKQ6Y6AtOH4SqvLApb9RxNXhHvUdWpmcF+9ypjmdydx2gHKz
	Wl4h/UfCmsX22LXwY0VQ7Yy4Kw68OrX/bSin45IDn2kncVsqKKxJjZALtbmtd4W1
	7LprPRTMBBcEDpQcXmigYxXcKTxI6Zy4h8RN4O8IfI3eN0m9a0Ry/JuLtbr1bJEx
	1RsWMagaMFpavvIY9gXxhFvwRxn81rcTuM1dZ1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CCHlANvTLoFQodSS3YekfliPjDJBq/cICpamxbe2ADo=:8SkwE1t0iPcITGpe+9KVBdG+swDOKXSPH0LXnDCZOxU=;
X-ME-Sender: <xms:98bPausNrk3ncGn9j4erbv2TUfmDQJEbYJoXaKDKgT4VUUXOe5iSQg>
    <xme:98bPaqfPb3UMzcJild5wRQu3lu8aQrVEGvPJnV9ck4q_durMYLhCZ9QCzsCumnnEo
    ndQk0Zdod0JAYhjVSlS2ePliPSS5c8n_r8l4qyQGYsPmRe842-A>
X-ME-Received: <xmr:98bPauyBCSNCFMGFFiSPdbZ6j-XqCyBbMt8zXAN1L8ssKYZCsVCcWq0NTprQzQk_2oQVzjmkdt1AQBwJiK83F9Ey9c_RY-At3Yu7>
X-ME-Proxy-Cause: dmFkZTELRZ5BKuWu1unXmDoDvR2E0qGd9MtPuHBemCD/cv1wVdC9Vpi/pJ3wv3xVneEJuF
    6jU0AWkfX07HombR2IUnqkU2X0R4RoKzt6TyvNBu7AOMObjxG3hiMu0Y/HLmsGS0aOWvrO
    cfXAaxc8Jn+3Ckgo+frxc7s2UG1tFO7GOw8kVgSgzV3dj7bFM4fgtrwY/Hc7CKM+yeJ0Cw
    tssJrz9ZjrOuWZKEe5ST1BW7Z4M8QBJfmBCRjdnaVARKV6oLI48oXJa6Lo8XgeQlMWY8sU
    gKw/K3hsdl7TQN59f0I+6BIvDk6LvHLZTroxAhw2cLNkFVSoqnKC6h5qA0NzJ3L8kE5KS8
    wpfN9w3SFKktw0hZ3kVQ9+S59p9V/EvUtI7gSHoqBFKYXNVmpU0M8uTKVDaNlCN/P/6iuj
    ynS8A6fH/c8gJV6WBwIT3+YkYiZRz69q94oUj3hNCE02LN4yrJvKXktzY5bi22oVJyqX0s
    zbe+0eJyp509a8KPbMaO/OWUN3smqqi2SA3UyutnLNtViJXu7FYqA2nzolLLkRKhL5pUiZ
    C77NgmyjtPvwa1acXzh7C1xSEeaC9YeUcYcmK3NYIdqy8yXbwGc9Ckd/rQR+TMEUU9wYII
    2Tu0Ggxc4qwncc8epgLef2URZszjmLdgeqScbjPWyqnmEAsvhIutv+TgedXw
X-ME-Proxy: <xmx:98bPaoFndryCVS-RJeBBCGYO_Ed9QCx-q0fDoy1zLLLMGUzH-SPpoA>
    <xmx:98bPaqwtlZU-4DWRGAwV3E_pYZzzGC24639-S0k1k2Eu6TzegnjN4w>
    <xmx:98bPahtIs0h0M7-fBQsARuaU2xADv-i_zYFFOq_Zn6wBNV9NXwFT5Q>
    <xmx:98bPav0I7XGx0mzUJP3LHfwLQVFDhrB6zC1i1hXagyga-W0B7gFSZg>
    <xmx:-MbPapQcs6htj7N8F9whUF09bxWpx2Z5Sa-IKHow7clReIlqfWkJbwdW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 14:16:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
Subject: Re: [PATCH v2 5/7] stash create: rework temporary index creation
In-Reply-To: <f799d86f52796cc1b83788460568cc0d9849bed9.1791992404.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Wed, 14 Oct 2026 16:40:17 +0100")
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
	<cover.1791992404.git.phillip.wood@dunelm.org.uk>
	<f799d86f52796cc1b83788460568cc0d9849bed9.1791992404.git.phillip.wood@dunelm.org.uk>
Date: Wed, 14 Oct 2026 11:16:22 -0700
Message-ID: <xmqqtsmorvux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Use create_index_from_tree() instead of reset_tree() when we create a
> temporary index file to stash the working tree changes. This matches
> what we do for "git stash push -p" and means we can avoid messing with
> set_alternate_index_output(). Add a new parameter to control whether
> the index is reset, as we need to merge the index rather than reset
> it so that we still detect intent-to-add entries. We do not alter the
> in-memory index so we can remove the call to repo_read_index_preload()
> which saves one lstat() call per changed path.

It is unclear what problem we are trying to solve.  Obviously we can
enhance create_index_from_tree() and replace reset_tree() just fine,
but the proposed log message should make it clear why we are doing so.

Please follow the usual pattern to state "observation" (e.g., "we
use reset_tree() when we do X"), "problem" (e.g., "use of
reset_tree() is undesirable because ..."), and "solution" (e.g, "we
can improve by replacing reset_tree() with create_index_from_tree()
because the latter has these desirable characteristics") in this
order, perhaps in separate paragraphs for extra readability.



> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/stash.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index b4fe7465e4..ddeb5a5d2a 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -374,7 +374,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
>  }
>  
>  static int create_index_from_tree(const struct object_id *tree_id,
> -				  const char *index_path)
> +				  const char *index_path, bool reset)
>  {
>  	int nr_trees = 1;
>  	int ret = 0;
> @@ -403,7 +403,7 @@ static int create_index_from_tree(const struct object_id *tree_id,
>  	opts.src_index = the_repository->index;
>  	opts.dst_index = &dst_istate;
>  	opts.merge = 1;
> -	opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
> +	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
>  	opts.fn = oneway_merge;
>  
>  	if (unpack_trees(nr_trees, t, &opts)) {
> @@ -1399,7 +1399,7 @@ static enum create_result stash_patch(struct stash_info *info,
>  		goto done;
>  	}
>  
> -	if (create_index_from_tree(head_tree, stash_index_path.buf)) {
> +	if (create_index_from_tree(head_tree, stash_index_path.buf, true)) {
>  		ret = CREATE_ERROR;
>  		goto done;
>  	}
> @@ -1458,22 +1458,15 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
>  	repo_init_revisions(the_repository, &rev, NULL);
>  	copy_pathspec(&rev.prune_data, ps);
>  
> -	set_alternate_index_output(stash_index_path.buf);
> -	if (reset_tree(&info->i_tree, 0, 0)) {
> +	if (create_index_from_tree(&info->i_tree, stash_index_path.buf, false)) {
>  		ret = -1;
>  		goto done;
>  	}
> -	set_alternate_index_output(NULL);
>  
>  	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>  	rev.diffopt.format_callback = add_diff_to_buf;
>  	rev.diffopt.format_callback_data = &diff_output;
>  
> -	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
> -		ret = -1;
> -		goto done;
> -	}
> -
>  	add_pending_object(&rev, parse_object(the_repository, &info->b_commit),
>  			   "");
>  	run_diff_index(&rev, 0);
