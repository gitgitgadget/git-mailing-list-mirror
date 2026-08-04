Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD85847F2EB
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863496; cv=none; b=I90qB/cN17Onurbm07qEabml8sN4tZtT6fcZAQW5c4kVaZ4DxWhU7+qjye9hvaNo0LiPxjqebqE2cNd8fRwwhgUtk61LyX8+m6Z6o6qqE/vbL6dKZ0xXkPkY8hdb8YJCXaV17ykBBaYM++fgjNN4g4qyy+zu/F4848LWf3Y8rUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863496; c=relaxed/simple;
	bh=hpc2h2I7hQijRBrAoM8qchBbqRuwNs8e07azJFdTjYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YjmSk8/EK1X5ivVCMUEXOB/NVuduonT5+Th8YhbSvqpmDeP3SniujPLcy9IvBXbmYvlYGijJ3eNv1xxl4D8jOrniH2bS8UJbB9dPPXyX+7/MwV37QrXr/YPlpM7GM3tspTTWvNW2oZ1p5CdGBG5Qf9+B82R+3dwAM//dUdXDllM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iqwq+PnD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bp0mgAJW; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iqwq+PnD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bp0mgAJW"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A72311D00084;
	Tue,  4 Aug 2026 13:11:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 04 Aug 2026 13:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785863485; x=1785949885; bh=zLVC2/fXzg
	rE6fiHN7NJ3ZRWUTtw6A9UAQ7JIo7i6iI=; b=iqwq+PnD4jCXalFhaMwHrHyXM9
	UkaOVpVnNRSs+furuExe8xH1tTIRig4uGchCNoujR6zNZiFqM+nvcLoIlTkNnNkr
	0r6g8x3IYJ27zybIet7fL0DZAA661/Wdgg3KhYO8wU+b0l+iMwuktWClw9AYCMUl
	ArcRFhFfCZQkBX15xLIw9NogH60nCfoTzzogwqaBIAbqcaZzxnhng3dA3MhmB8pq
	/q4/S5mBP60G9cNtGVYal+KEbbl7AmjI4E3M2YZ+d6jh7BwGefY7KV81VD3w1oNE
	lPdFH/uvGIvYr9xatXKvMZm2K/1P7eAdPjPG2k/l8avOJKPlsFvwEHrhETDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785863485; x=1785949885; bh=zLVC2/fXzgrE6fiHN7NJ3ZRWUTtw6A9UAQ7
	JIo7i6iI=; b=Bp0mgAJWPbF5bfEnyqO8JdvH+vQ4Tq5rsUowqf7uuCsS47uinCm
	7tqzQNnL7bKZleoj/kBfIDmmWDNcPZuTlWvaIvkR0Etz5EWDr6GbP+hvXtH/ej7B
	XHh7pfgUfwpXzw6ZEf2gL2Gwnon43JUBetFi7qJbpCuPYSsbKLFAFG3GLsdpQRTu
	2rX/qeC1EHB8k38W2JeSEN/gs3jjnc43vn35+xtx++HrzroNGb6F1mGqv7g5p7wJ
	/LeQd+v4Gc/W9MfAUauY6sFl7SYbP5WdHP3xI9TVqz/R42N6vs3AtQCm6240L8jV
	nspOp83E4m7V9yEvLDXItqNMfSYcH3i+3nA==
X-ME-Sender: <xms:PR1yajuVQj97Ufv5yvtQwvyVt84T5hE2T10rn1-Mb_URxCK3-uTyrQ>
    <xme:PR1yarVy_Zjpap_1bltD4H2CWUZ1O-8lGh3nJ-cJJdDK8wivQKdl-tXH2N2om8pDw
    cf7LuRJWe2VIH8i0Z9jNyuXKYa7KVE7A93QvRDFoeBRZMTNriBRtKg>
X-ME-Received: <xmr:PR1yavEH5zBTri-0hx-YQWjUFXDmZll66Bwf80ubcEvyJnqG4Fk5nPMbvWNnt71F62OYao4i1isuw3_9bSPZZO2i4akEhHPa4g>
X-ME-Proxy-Cause: dmFkZTET5z8NUmZfocL4nFs5gquCNqZ6hqsaasnSDT8M41q+kL2IMNSUosalQmrYiB3hst
    zQHnOk8529YMl6UZraSTNsVYO1N3eowLuqRk2RFzncw2AFxWec2H6xVP02o5FqAzeJ9Rnk
    IkBCbkOqDWCHkP71ZrormUQQzqtZd8BmmqKLmo2LkS7Zlxgz7rhkQC4ikJfUANry7vbL/r
    IQJsacPO+40JUCov6CspEb2NZOyprW7TP+dCXkrFTP3nNFPu0CoeSGDQoKktdG5fXgUILE
    IqYx6rxcfoBQwHBiUSGQUyIzXX/eTEkB8ynA0ZRLDVS/VKdtHW4M5s8LM7toXTVs48hCIp
    qQ0qeFXgL6gMv86jls/cwgJqgZDCD21x+iQ/mTcUlLj5lp2SwlSat/6/JUGwbrLJSVmtgS
    nJdVgo9H85t9e92W57wEh+xPdA9VK1IV9YbkzJ6bZvzZyzMBUv8GyC9vmFCOKdhuHvO/Df
    OPtpvFwpk6H1AazJjmEUq8+RZ0o0cJ9lrcq8MZRcMimxAU5kryubipUSKXEue1vQcp2iUP
    YiJrZTxwGPEiAztTV7uPRFsKNBNFqyzJeQDxtJ88wpOakbz6VkFn1mJx+Y+AD85oLi/QBA
    +LfGfRf6G2vMGiHN5DyE6R1Ap4iBubMQQfAkW5LdZs/Quc3F4JeYr0AD4gig
X-ME-Proxy: <xmx:PR1yat0RTjnG1uzxpU0wQyYebPD6POvWSzCpWdY1WdV6lnXi-JzSIw>
    <xmx:PR1yahPmG92kJwz8RhLf46REWAzMtNitoP2SvGuAteb-zUmjFBP-iA>
    <xmx:PR1yas5hFs0SznTLF16xrKolT36AVIHon-SvTCpJQdVdoadKvEqvNg>
    <xmx:PR1yar0AiJI1MgFnUy08ejxBUdYNya_nLJiWYeIP2O6q2ZUkFPLF5w>
    <xmx:PR1yaoQZUhN7jSaJ2zI2ZJzHl7v3A6Xe3fqX6jykbbF9SAsFlm6zDLin>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 13:11:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jacob Abel <jacobabel@nullpo.dev>,  Yoichi
 NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH] worktree add: shouldn't dwim if -b or -B is given
In-Reply-To: <pull.2192.git.1785852032626.gitgitgadget@gmail.com> (Yoichi
	NAKAYAMA via GitGitGadget's message of "Tue, 04 Aug 2026 14:00:31
	+0000")
References: <pull.2192.git.1785852032626.gitgitgadget@gmail.com>
Date: Tue, 04 Aug 2026 10:11:23 -0700
Message-ID: <xmqq33wtx138.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
>
> 'git worktree add <path> <branch>' DWIMs <branch> to a
> remote-tracking branch when neither -b, -B, nor --detach
> is given.
>
> However, 'git worktree add -b <new-branch> <path> <branch>' can
> still DWIM <branch>, causing <new-branch> to be ignored.
>
> This is a regression introduced in v2.42.0
> (128e5496b325640f0a09cc1d5b1e346c069b410f).
>
> Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> ---
>     worktree add: shouldn't dwim if -b or -B is given
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2192%2Fyoichi%2Fworktree-add-should-not-dwim-with-b-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2192/yoichi/worktree-add-should-not-dwim-with-b-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2192
>
>  builtin/worktree.c      |  2 +-
>  t/t2400-worktree-add.sh | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 654d27c3e1..3204afdb12 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -897,7 +897,7 @@ static int add(int ac, const char **av, const char *prefix,
>  
>  		/* DWIM: Infer --orphan when repo has no refs. */
>  		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
> -	} else if (ac == 2) {
> +	} else if (ac == 2 && !new_branch) {
>  		struct object_id oid;
>  		struct commit *commit;
>  		char *remote;

This part checks 'branch' (assigned from av[1] earlier) to see if it
names a commit.  When it does not, the code checks if it is the name
of a unique remote-tracking branch; if it is, the code uses that as
'branch', which is the origin to be used to fork 'new_branch' (av[1]
in this case) from.

Your observation is correct that this would overwrite 'new_branch'
if it were supplied.

Stepping back a bit, though, does this change the behavior when
'branch' *does* resolve to a commit (hence, the DWIM is already
bypassed and 'new_branch' or 'branch' are not nuked)?  When 'ac' is
equal to 2 and 'new_branch' is supplied, we used to call:

        if (!strcmp(branch, "HEAD"))
                can_use_local_refs(&opts);

inside the block you are now skipping.  It looks to me that this
patch also changes behavior when the user says:

        $ git worktree add -b <new-branch> <path> HEAD

by not calling can_use_local_refs(), whose only effect in this
context is that it may issue a warning() to the user.  I do not know
offhand what the ramifications of this difference are.

I wonder if we want to skip only the dwim part inside of this "else if"
arm, e.g.

diff --git i/builtin/worktree.c w/builtin/worktree.c
index 654d27c3e1..2205f4e9b2 100644
--- i/builtin/worktree.c
+++ w/builtin/worktree.c
@@ -898,6 +898,7 @@ static int add(int ac, const char **av, const char *prefix,
 		/* DWIM: Infer --orphan when repo has no refs. */
 		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
 	} else if (ac == 2) {
+	    if (!newbranch) {
 		struct object_id oid;
 		struct commit *commit;
 		char *remote;
@@ -910,6 +911,7 @@ static int add(int ac, const char **av, const char *prefix,
 				branch = new_branch_to_free = remote;
 			}
 		}
+	    }
 
 		if (!strcmp(branch, "HEAD"))
 			can_use_local_refs(&opts);

Note that above diff is with broken indentation to help reduce the
patch noise to illustrate where the new block boundary would be.

> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index 87b926728a..9cbf84861d 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -621,6 +621,16 @@ test_expect_success '"add" <path> <branch> dwims' '
>  	)
>  '
>  
> +test_expect_success '"add" <path> <branch> does not dwim with -b' '
> +	test_when_finished rm -rf repo_upstream repo_dwim foo &&
> +	setup_remote_repo repo_upstream repo_dwim &&
> +	git init repo_dwim &&
> +	(
> +		cd repo_dwim &&
> +		test_must_fail git worktree add -b branch ../foo foo
> +	)
> +'

Two comments.

 * You call setup_remote_repo(), which takes two names, runs
   'git init' on each of them, and prepares those repositories.  Do
   you need to run 'git init repo_dwim' to initialize it again?
   What for?

 * Expecting a failure to create a worktree may be fine, but can we
   say how we expect the command to fail as well?  Perhaps you can
   capture the error message while ensuring that the command fails,
   and then check the error message to make sure it failed in the
   expected way, or something like that.

Thanks.
