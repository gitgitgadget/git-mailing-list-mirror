Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AFAC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 14:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiGOOeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 10:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiGOOeB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 10:34:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7B510FDA
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 07:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657895635;
        bh=FBYza/m5azF4reqX0WkOy+N2cuZB+OLh+oLrV3N+KOs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XcS4ro6ui/0dOEdxuB2rFnXokkdqNO3uhYtpk9aF75x072Ll5x3djIsghQ32CQu/s
         cV4sklolLoN6xMlUFZdkH2qyPTmlona/xlzqStK/P5owsqUZDUM8IFSLZr5Ii/8K/d
         RVuV3KVmohmJkz9Kws1HsHN6eWRnGDeKRuJyFZyI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.23.67] ([89.1.215.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1nN0ej323T-00stw0; Fri, 15
 Jul 2022 16:33:55 +0200
Date:   Fri, 15 Jul 2022 16:33:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] Allow debugging unsafe directories' ownership
In-Reply-To: <xmqqy1wv2x1n.fsf@gitster.g>
Message-ID: <8rqqnqp1-q613-ron6-6q8s-n7sq57o980q9@tzk.qr>
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com> <3480381b8b99142bcc0213957a43d68a962c52d9.1657700238.git.gitgitgadget@gmail.com> <xmqq5yk0dcvk.fsf@gitster.g> <xmqqy1wv2x1n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BcdNi3iIuu6jYsaiPy6NfMfhntwwnL5WUHD+6tQ8/Hw2qW/YaHc
 ZNeFuYacFRZSledT3xjJ8MI7PEwuF0ne4ZhmW07c1bbtSNVY3ozwSLAKFOXxJr3j6SEuFYa
 Z7pyf1JLyOZeLRorXGeDqSdQ6boEUTejP3rFbBlGewj2ghTCkhuJdGdwnRjxk7mKB3XS968
 KWlrvfxL82LaSPchS8GLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ijO6VW/iEAQ=:ubKda3G0hneP5MK7Fsour+
 hfZMrMJxyGGiF5gMr2ZJSKGRJ0wxKEsW6XXEZUj8ZbCHhk2lfPWZ+Y1PmCRa8lGtF0gFvEpVd
 M4aTRdLmcEmZfr+yq4a/6tvqIlqPvxe18yM7ER1HdD5RIntkTLK3BXUekbGWdQAYPB9iOOfKH
 h4BLlKrjGNxuMI1HVub4iPNwTppCLn4zdt5UVy9MZ+VgCjoDn4pks2Z8+RPURGP9M1AcPIH6j
 IGkNM8aGpUerHpTtDKH9k7aNZ0jWACVZesMZgTZ8dwblA/mgTpWP3cyJpHCMUq9ZlWzWWt6+H
 RdOvXuBpOSbWHD9iPB+GPNGyZizVELVTZX4phdqC+7VJvkL/0OGemI2JTZ9H6GhPAlTl0aSA9
 ptds/zGE+Ra/+7OPm3J8EaJou5dHsRuwrkzRk2nSpB2BFGlYaOPdsKa4pOUvSWY6JZJj5A7oS
 xPGDloCzhW56kli0v0whNEcWkkJdSr9Wk0Y/Y1bRCtEDdsPptpqOM0ySIhw7iFEH3bw0tqLjY
 O+Re9BeqbkIPISIw7PhxHb6lV0X/4KIsPp3kgQ3hTJckdwmgo/7yFmaz3EGkRVkh4idhaAVn1
 KZye3pXRJ/Jmfz4CZCCuej6WAwcNgaDVIubRnbWobrGRh1NLPs0elrtacpRglQkZxv1i3P1xk
 9C0+U8cCqp9ufw8H0VlY7HxZ1dc2gYuAi4xWBs6Ff+WE3FvZvKrd7ZBnSXnuaqdv0tH8zyr56
 4YypEurUhKQB9JIGVzPo2Z0TRv20syEofqswBWsEwpuqPbinyAsKQi/8d9FWmZrJzYuh6VWVo
 QMbgdxaZUtVPybzLbEk3jUbjgRsyFEZYrs1LMyw0/7/Rs+64pFX5fyAM1j2kt3gqtovWXbvkD
 1oT7UzTUPSYIFg+PoCOWJZ8906qmLZL1op4wxmjyq2j6tHDHYZJOU8P6ULFHgRz5fUhKPfur+
 ILy1Y+mFwhpK8jBcacmKJDGv409X9zRj9+yTAAr6ED3RbSGl1Z77SXIJrWjObDBl814Ve8Q0I
 vSz6cR2c6gAFl0ypv4pvGW+EWYzWJL4+ImraRfAjwczrtbSCMyVilUfjp2rxIUj1xxP6vKu6D
 A2FewxwxoUYlhXXlpzh6CtG5RBwqW2z7YsadWtnSTlAX9EnqJicjnJzfw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 14 Jul 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > ... I am not sure about this part.  Do we have any other codepath to
> > show "to debug, run the program with this" suggestion?  Adding it in
> > the documentation is probably good, but this is an extra message
> > that is much larger than the "owned by X but you are Y" message that
> > would be shown.  With or without the environment set, the output
> > will become noisier with this patch.  I wonder if we are better off
> > giving the information that is given in the warning (in compat/ part
> > of the patch) _unconditionally_ in the message, which would make it
> > less noisy overall.
>
> I am wondering if passing a struct to allow is_path_owned_by*()
> helper(s) to report the detail of the failures they discover a
> cleaner way to do this.  To illustrate what I meant, along the
> lines of the following patch, with any additional code to actually
> stuff messages in the strbuf report, in the is_path_owned_by*()
> implementation.

I like it! Let me play with this, after this coming week (during which I
plan to be mostly offline).

Thanks,
Dscho

>
> I am perfectly OK if we make it a debug-only option by hiding this
> behind an environment variable, but if we were to do so, I do not
> want to see us advertize the environment variable in the die()
> message (a debug-only option can be documented, but not worth
> surfacing in and contaminating the usual UI output).
>
> Comments?
>
>  compat/mingw.c    |  2 +-
>  git-compat-util.h |  3 ++-
>  setup.c           | 12 +++++++++---
>  3 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git c/compat/mingw.c w/compat/mingw.c
> index 2607de93af..f12b7df16d 100644
> --- c/compat/mingw.c
> +++ w/compat/mingw.c
> @@ -2673,7 +2673,7 @@ static PSID get_current_user_sid(void)
>  	return result;
>  }
>
> -int is_path_owned_by_current_sid(const char *path)
> +int is_path_owned_by_current_sid(const char *path, struct strbuf *repor=
t)
>  {
>  	WCHAR wpath[MAX_PATH];
>  	PSID sid =3D NULL;
> diff --git c/git-compat-util.h w/git-compat-util.h
> index 58d7708296..de34b0ea7e 100644
> --- c/git-compat-util.h
> +++ w/git-compat-util.h
> @@ -487,7 +487,8 @@ static inline void extract_id_from_env(const char *e=
nv, uid_t *id)
>  	}
>  }
>
> -static inline int is_path_owned_by_current_uid(const char *path)
> +struct strbuf;
> +static inline int is_path_owned_by_current_uid(const char *path, struct=
 strbuf *report)
>  {
>  	struct stat st;
>  	uid_t euid;
> diff --git c/setup.c w/setup.c
> index 09b6549ba9..ed823585f7 100644
> --- c/setup.c
> +++ w/setup.c
> @@ -1143,12 +1143,18 @@ static int ensure_valid_ownership(const char *gi=
tfile,
>  	struct safe_directory_data data =3D {
>  		.path =3D worktree ? worktree : gitdir
>  	};
> +	struct strbuf report =3D STRBUF_INIT;
>
>  	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
> -	   (!gitfile || is_path_owned_by_current_user(gitfile)) &&
> -	   (!worktree || is_path_owned_by_current_user(worktree)) &&
> -	   (!gitdir || is_path_owned_by_current_user(gitdir)))
> +	    (!gitfile || is_path_owned_by_current_user(gitfile, &report)) &&
> +	    (!worktree || is_path_owned_by_current_user(worktree, &report)) &&
> +	    (!gitdir || is_path_owned_by_current_user(gitdir, &report))) {
> +		if (report.len) {
> +			fputs(report.buf, stderr);
> +			strbuf_release(&report);
> +		}
>  		return 1;
> +	}
>
>  	/*
>  	 * data.path is the "path" that identifies the repository and it is
>
