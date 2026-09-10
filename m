Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329A493D48
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047373; cv=none; b=lz78WMKoe/LBDUhkrk2TELEd8zdL6HejdaqNMyyfwuQuhFb3/HLyVuNqXOnS+Z7LOB4ujGzKz7CWJsAASnrO1wihRKnmFFRF/Hlpohm7ncoHovGT5RwwMuSPL3EzcE3Pvq+9RcoCfdBTBE0tQQtALjy/SpNEU9mLQS1qQNb5bSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047373; c=relaxed/simple;
	bh=b5JthBD4L85Dm2awJUAC3gssbeC/e9DOtF0PY1aateM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TxDYrB20hgH7laQlJqB6kJKyBdTneZyl6rkEYEMZK0E4KGPeSsx4QYADgPa+gtJ2OxOPwreVYMms0qbZEyzwOSO8db1iDX/6+3hZoejAsoVKgMFRPDVvnyu497cFlo8r88CXzrysNaFwnajLzqWIY1JvuLSEAAZEhJcl1BojOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=daRzrHE2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZfGFofdR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="daRzrHE2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZfGFofdR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AFD7BEC01E3;
	Thu, 10 Sep 2026 09:36:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 10 Sep 2026 09:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789047370; x=1789133770; bh=GW8Fmb9zuu
	mocg0am9FXggxypkAruMubLwCaiQ11HOY=; b=daRzrHE2JOcwUBkAIeVfZlQnxb
	hHvT5Yugfkbx6nCsqB5PwqBrptnseYEbbkAsSGiMtG1Ice9xzlUg3NjI8rkAdTGw
	r/r4M+tRgVLkZrg9PLOmxUa41p3yOJYg7AkYOjm4o/jPp18/mZUj4A8dAiLRcmqH
	U3bvvDrBCQgCsYtfFAgTJo19+8OZm/XRwpwkE/mwh4gUhWytTkurTigu43cnssKa
	MuYWau4GhCDn9gf4rJp+EEUaOqd3+a0FoC9eXCvR+fkIQh7Ftv0liP1Qc/fSXCoP
	vjMxr4NcWMzZ0MTSUlYqY9Fbxkb2qhcsi8H4zMNjixXPsdv7YP75F5hyIyIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789047370; x=1789133770; bh=GW8Fmb9zuumocg0am9FXggxypkAruMubLwC
	aiQ11HOY=; b=ZfGFofdRWfGnc5OguSA+tG1qaeCTzz6UW6zDUKF8EagiuHPtySB
	I02AYpTLH/iaRtpSGAVIYJUEIAgQ9eJc0Hw0drRaGfbgdP1OMLth33iNazC3pjPW
	7yrZhxLftnPLLcopJsqdqLmssOnPaGwKhmqFV8MiN6hD3ZWjJs+hVFFjSbwOMr34
	Vr83lXgSuCmMCtr+zIIKihi3IHkHQ0adYSjygriAK8ODqoXwCVz6Rlg5We7EcmqJ
	d+15ppBYotaxZqGIJXbTvgAfsOSOGgUqW/Dqhvj3oD3um41RW9671sCP2qXUBkIt
	blzYCcnOrqf4RO90f36cXxYYSlhn3q0S1sg==
X-ME-Sender: <xms:SrKiamuj-thUsrOIhWRKwlaYYt2wHj1FJv-ic2baXKmNfD_hlFosuA>
    <xme:SrKiavL3nvmnNS1tdhz6YTDuKU_7qmbCbzes-Ipb30F8HN-mZ4B5xFXofo75VAk8L
    TDe-pWeSV1nxeHPNQI97el_YYkWmLsSvbNWeoOBFN6HCAJb_EM_8sQ>
X-ME-Received: <xmr:SrKiarlYTtMm4jrNKe_dwXr_saze7OKBtEQEUtRKlIsM-OS-4y8uL1taaM9Winp_sgAzmAqf1AvQ2ZrHXN53i1tqmhXMlEwyy1_C>
X-ME-Proxy-Cause: dmFkZTGRizg86lPlc/IJCPPtM+YnVpRHJyxXt9WlOVnD+rF/SKVwBiCh7lhAW2K1NwDzTj
    uC19pnzbjkSFSpbNNGgHi4OPpQRsHk3h+BzH/l0rYZHgUn4t6I+MWdxkmcPVK481K5dgpX
    dnxxRE95hnLlnQjtmDm1MszBWN1aiz0nhnWJ/SM0sk6KV7c2q0atsxNl6NN1hJwtS4Bbjm
    Do1+o3Y+AJbTprv/fedKpP3mOZl4/mDmriSJIRzO2NHBVr0MpzHeLOpJDBoXNlbfgkiKmu
    fAf/ZjbcDoxKQLyeZ07e2H7oY9h1u2pK7ATZMt8daN6zEWCZZt1MuqzbhwsRb2wdn34hjE
    OUQyEQP/SVe78x6cggN5lhWnJW2SvwWILGHJ8Cn0R1d653QVmv025FZkryl/BN5n9qfu54
    Rkz9udC/arTyMEm9sZ5MfktMiEXdIhXYDYNtlcb5ihhTKTYm1u4BG7WJkj20HIYm/DJcRO
    fJ4Vwmafd1SWaS04FkPCaHO3tXpQiVskQqMDlFKlpOEUsFu94A3BfDPMWt1m2zy5kn07LY
    W6LHuIApAX+snEVM4h05vfusv76rAoHdwH78UEQTwR6ehEDlvhOpo/8sMqNY2TO/PZPugq
    RniFUNbzx34/+/fDm9HV/DVJRajVrRzLLNqIE9ggZdrWzjw+kYdbNC9DjBBQ
X-ME-Proxy: <xmx:SrKiaoJsi3jmv_KwW38-v0-VXJ380F1kalQ1PqbunV_a8JsYN6JI-w>
    <xmx:SrKiao7OJ8H3XB7ncs7gYedCt3Qyg8YyYjXpikR2L4T7TfM-b29p1A>
    <xmx:SrKiak2lnh9dmwdAMWAUSAEAPCB2bwLAF7ms0pZUUd6HyFmu64jy8w>
    <xmx:SrKiamcGFDZZB4i7Qpg4a5sfQkgceZ1Zxv92KqiYsigyeYYTVjBLOA>
    <xmx:SrKiajeU682U5RLyjm9y7BBzAuo9_in7U942Rwy8IyKP8kxq3yrKsMQV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 09:36:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Jeff King <peff@peff.net>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] builtin/history: unuse the commit buffer after use
In-Reply-To: <20260910114052.325683-1-kaartic.sivaraam@gmail.com> (Kaartic
	Sivaraam's message of "Thu, 10 Sep 2026 17:09:51 +0530")
References: <20260614141600.620272-1-kaartic.sivaraam@gmail.com>
	<20260910114052.325683-1-kaartic.sivaraam@gmail.com>
Date: Thu, 10 Sep 2026 06:36:09 -0700
Message-ID: <xmqq4ifxgree.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> While running `git history reword` on a commit with `SANITIZE` flag set
> to `address,leak`, we could observe the following leak being reported:
>
> -- 8< --
>
> =================================================================
> ==122337==ERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 263 byte(s) in 1 object(s) allocated from:
>     #0 0x7002c14fd9c7 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
>     #1 0x5cdd008ec077 in do_xmalloc /me/git/wrapper.c:55
>     #2 0x5cdd008ec185 in do_xmallocz /me/git/wrapper.c:89
>     #3 0x5cdd008ec1fa in xmallocz /me/git/wrapper.c:97
>     #4 0x5cdd005b99d8 in unpack_loose_rest /me/git/object-file.c:216
>     #5 0x5cdd005e45f4 in read_object_info_from_path odb/source-loose.c:174
>     #6 0x5cdd005e4ba0 in odb_source_loose_read_object_info odb/source-loose.c:235
>     #7 0x5cdd005d9f83 in odb_source_read_object_info odb/source.h:413
>     #8 0x5cdd005daaed in odb_source_files_read_object_info odb/source-files.c:93
>     #9 0x5cdd005d1c8c in odb_source_read_object_info odb/source.h:413
>     #10 0x5cdd005d5bdd in do_oid_object_info_extended /me/git/odb.c:592
>     #11 0x5cdd005d7080 in odb_read_object_info_extended /me/git/odb.c:747
>     #12 0x5cdd005d75d8 in odb_read_object /me/git/odb.c:793
>     #13 0x5cdd003d9af7 in repo_get_commit_buffer /me/git/commit.c:399
>     #14 0x5cdd006739ed in repo_logmsg_reencode /me/git/pretty.c:716
>     #15 0x5cdd0012287a in commit_tree_ext builtin/history.c:134
>     #16 0x5cdd00122f33 in commit_tree_with_edited_message builtin/history.c:190
>     #17 0x5cdd00126e44 in cmd_history_reword builtin/history.c:748
>     #18 0x5cdd0012b051 in cmd_history builtin/history.c:1209
>     #19 0x5cdcfffb8faf in run_builtin /me/git/git.c:510
>     #20 0x5cdcfffb9ac6 in handle_builtin /me/git/git.c:786
>     #21 0x5cdcfffba358 in run_argv /me/git/git.c:869
>     #22 0x5cdcfffbaea9 in cmd_main /me/git/git.c:990
>     #23 0x5cdd0030f27f in main /me/git/common-main.c:9
>     #24 0x7002c102a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>     #25 0x7002c102a28a in __libc_start_main_impl ../csu/libc-start.c:360
>     #26 0x5cdcfffb4134 in _start (/home/sivaraam/.local/bin/git+0x217134) (BuildId: 549c1036ab1f9f4fd55546e5bf31c7bd81b008fd)
>
> -- >8 --
>
> A deeper investigation on this reveals the following as the root cause.

I am not sure if you are going to explain the root cause in such a
way that is understandable by human readers, you would want to scare
them away with a stack trace.

> As part of rewording a commit in `git history`, we get the commit message
> buffer in the `commit_tree_ext` function. This in turn obtains the buffer
> from `repo_logmsg_reencode`. In this case, the buffer that we receive from
> `repo_logmsg_reencode` ends up always being obtained from a call to
> `repo_get_commit_buffer`. The buffer that `repo_get_commit_buffer` ends
> up to be one that is not cached in the commit slab but a fresh buffer
> that is returned from `odb_read_object`. This could be confirmed
> confirmed by the stacktrace in the leak. A plausible reason for us
> receiving an uncached buffer might be because the commit comes from the
> commit-graph.
>
> In any case, this uncached buffer is expected to be released with an
> accompanying call to `repo_unuse_commit_buffer` which takes care of
> free-ing it. This call is missing in the `commit_tree_ext` flow
> thus resulting in the leak.
>
> Fix this by ensuring we call `repo_unuse_commit_buffer` on the
> original_message buffer.
>
> For those who are curious, the following is a minimal way to
> reproduce the leak. I'm including this here as the leak does
> not happen when we get a cached commit obtained from the commit
> slab:

> -- 8< --
> $ git init scratch
> Initialized empty Git repository in /me/test-repos/scratch/.git/
> $ cd scratch/
> $ touch one && git add one && git commit -m "Commit one"
> [main (root-commit) 2182f9c] Commit one
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 one
> $ touch two && git add two && git commit -m "Commit two"
> [main 5550f33] Commit two
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 two
> $ git commit-graph write --reachable
> $ git history reword HEAD --dry-run
> update refs/heads/main eaded0872b14b3937605c77c0042429ca1e3bbe1 fd19e3776c75b8da9555c7c616ce0df9db7c6641
>
> =================================================================
> ==122337==ERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 263 byte(s) in 1 object(s) allocated from:
>
> ... snip ...
>
> SUMMARY: AddressSanitizer: 263 byte(s) leaked in 1 allocation(s).
> -- >8 --
>
> This leak could also be triggered in our test suite if we run
> t3451-history-reword.sh as follows:
>
> -- 8< --
> $ make SANITIZE=leak
> $ cd t
> $ GIT_TEST_COMMIT_GRAPH=1 ./t3451-history-reword.sh -v -i
> -- >8 --

Please do not abuse scissors line when you do not mean "discard all
of the above and exclude it from the resulting commit log message".

>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
> Changes since v2:
>
> Just updated the commit message to clarify the root cause
> more clearly. I haven't added an explicit test case as
> it wasn't clear if it is really worth it as Peff points out.
>
> Thank you, Peff, for your help with this!
>
> On a tangent, I noticed that the leak is only triggereable
> in the test suite, when we use `make SANITIZE=leak` and not
> when we use `make SANITIZE=address,leak`. It seems we
> intentionally disable leak detection in Asan via
> the following line in t/test-lib.sh:
>
>    prepend_var ASAN_OPTIONS : detect_leaks=0
>
> I noticed the comment above saying the following
>
>    # If we were built with ASAN, it may complain about leaks
>    # of program-lifetime variables. Disable it by default to lower
>    # the noise level.
>
> I wonder if it has become stale now as we are fine with the test
> suite reporting leaks when we build with `make SANITIZE=leak`.
>
> Would it be worth while to avoid turning off detect_leaks while
> using Asan?
>
>  builtin/history.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/history.c b/builtin/history.c
> index 091465a59e..0e9259b5d7 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -154,6 +154,7 @@ static int commit_tree_ext(struct repository *repo,
>  	free_commit_extra_headers(original_extra_headers);
>  	strbuf_release(&commit_message);
>  	free(original_author);
> +	repo_unuse_commit_buffer(repo, commit_with_message, original_message);
>  	return ret;
>  }
