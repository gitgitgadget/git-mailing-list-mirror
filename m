Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7271F406
	for <e@80x24.org>; Fri, 11 May 2018 03:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeEKDcn (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 23:32:43 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35337 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeEKDcm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 23:32:42 -0400
Received: by mail-wr0-f195.google.com with SMTP id i14-v6so3872205wre.2
        for <git@vger.kernel.org>; Thu, 10 May 2018 20:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qoeR+gbO2EhOObabc+RcQxU9vfyFhuzqR6n+8rHIojg=;
        b=O/wyQyUeA5M8PHXUwYuCcUKdVrTcsGtbQJ51QaDTLNPOxedGzBg1Nea05RCiGQ09+H
         wgQlLL+XnDsfG+KJOt0Ct2bWaH12DOLmWr/wyLQVz0qIVODvlzJtS5lxiwRHUcUy/VJD
         AoXZBV7LxF2xVsz2obko1VaypXsMW7yhY1NAiu3JBGCaTFnSZRalDgnhSmKla8Dd8bAZ
         qzub8vZOp9m8MM5s4KI0KabK+wLLTso4ECXdPuWJmKt98HJq5bNdoPrZi/SF4PqrbK4i
         18vMv1hqns32xjBMyl+n8aFBzs8tSJb/Eb2JeU1wS8YE83zMfch0QjBM3vYWKv30qjeM
         i+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qoeR+gbO2EhOObabc+RcQxU9vfyFhuzqR6n+8rHIojg=;
        b=d6Djf3xoQg9XdQijQyjJojdBLIh7p0Gr5XD21XAsZlBC2oEtflGSCnc2N4H9NB/kyN
         E716gkmrpyG1N2rk/NOJXkgkoi/M4U+1yJ1lbvGcZu687tm0GlcZcMYaXOuSjb10b3fi
         zL3KZH8ZYHIpoSUhQI+FIYjldEBOpBsVjPQBQygDpM1kr0t4ceE/gaiAyfNDIcbP/dto
         jAbY/hMbkk/kCl24zYJqgweKrKcFSdcMlOIpYR4trdV0VA2O3qFfRE0WVDHof73/sHcO
         z0lFWa8psXtCxFWoADWJ9ys1afROIo87Npjoxefu+ZfH84V/tP4FpGhdo2OY7UJ9wRRu
         F7JQ==
X-Gm-Message-State: ALKqPwcrMXc4/sb3GsAZW5T5EoI1shbkDlikmqsMnJDWvhXAyInmlHe7
        adiUT2GIl2E7HH4OjTJLNkc=
X-Google-Smtp-Source: AB8JxZplIgOUsD94RnZ2tOVb75va5Hues6DrOzvJ9xIFs6L7VYQJNOohSzYK+IO+T9uksVrB/IdLqw==
X-Received: by 2002:adf:dd03:: with SMTP id a3-v6mr3324857wrm.0.1526009560867;
        Thu, 10 May 2018 20:32:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g75-v6sm425301wmd.15.2018.05.10.20.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 20:32:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] t5516-fetch-push: fix 'push with dry-run' test
References: <20180510140154.30381-1-szeder.dev@gmail.com>
Date:   Fri, 11 May 2018 12:32:38 +0900
In-Reply-To: <20180510140154.30381-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 10 May 2018 16:01:53 +0200")
Message-ID: <xmqqmux6hnop.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> In a while-at-it cleanup replacing a 'cd dir && <...> && cd ..' with a
> subshell, commit 28391a80a9 (receive-pack: allow deletion of corrupt
> refs, 2007-11-29) also moved the assignment of the $old_commit
> variable to that subshell.  This variable, however, is used outside of
> that subshell as a parameter of check_push_result(), to check that a
> ref still points to the commit where it is supposed to.  With the
> variable remaining unset outside the subshell check_push_result()
> doesn't perform that check at all.

Sigh/Blush.  Thanks for finding an old screw-up.

>
> Use 'git -C <dir> cmd...', so we don't need to change directory, and
> thus don't need the subshell either when setting $old_commit.
>
> Furthermore, change check_push_result() to require at least three
> parameters (the repo, the oid, and at least one ref), so it will catch
> similar issues earlier should they ever arise.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  t/t5516-fetch-push.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 82239138d5..832b79ad40 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -94,6 +94,9 @@ mk_child() {
>  }
>  
>  check_push_result () {
> +	test $# -ge 3 ||
> +	error "bug in the test script: check_push_result requires at least 3 parameters"
> +
>  	repo_name="$1"
>  	shift
>  
> @@ -553,10 +556,7 @@ test_expect_success 'branch.*.pushremote config order is irrelevant' '
>  test_expect_success 'push with dry-run' '
>  
>  	mk_test testrepo heads/master &&
> -	(
> -		cd testrepo &&
> -		old_commit=$(git show-ref -s --verify refs/heads/master)
> -	) &&
> +	old_commit=$(git -C testrepo show-ref -s --verify refs/heads/master) &&
>  	git push --dry-run testrepo : &&
>  	check_push_result testrepo $old_commit heads/master
>  '
