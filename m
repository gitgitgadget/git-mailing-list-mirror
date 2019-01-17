Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B091F454
	for <e@80x24.org>; Thu, 17 Jan 2019 20:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfAQUzP (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:55:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35454 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAQUzO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:55:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so12600384wrb.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 12:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4ky6kJxXhBzlTnkVdgPxHoDx0WDpqcDS1o92Q3eG6Vw=;
        b=LNrBs2xea3FyR1vdVcc0C7h/24lSpDjECoualdIF5HjCI7944DUCzTQ00AIi8Hr2pP
         bI1FYip51D87xvzOfAdqyhdbWCv+igFySo9pitVNDAMpGyrQnRttZJngc3fuknDX8fsO
         K66BM2OuaZBOAiYLbmXqoWl7vYDvrrd9CjdWeTy05SwyAXOMIfldMoLBrBs37qp+DNbh
         2A7YK5iOqwBxMaElgoIJ7E3Lkbdtg8DCgRUjKO42Xb6T22asxjJkRleE212wH4VJ2Z1b
         35+YCpIuDevtw+jefVIeeSwfW0x2Ns/csnKMVV3qwTr1rZOnetJ0EMLfpJEi6clf2Xe/
         33fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4ky6kJxXhBzlTnkVdgPxHoDx0WDpqcDS1o92Q3eG6Vw=;
        b=PztZbfVPNxma6xCTqc0umg4pbEJMuvtq7ANJRq+QDe/Eyy1EuPoYCmNSFeMkE96TgW
         xfMRzfilBs6qpEcfH3sytgNQLmyij8UqKO+sIjEeeGD1RdrK4Ssaw/8dUPPdia0C5/rk
         5bBEqb7K8UlwtrymdURCHff5/VZ6PaVMyfDa3lCPl7b0a0EaXkOZ5MPpatTARlSquVpZ
         vn7NjlIcc75OmL4jW7YjR9YtfV9SKSNexw4jnnxrP20610tu7gzsl2zjB2PHQZLGSRK4
         rYmC451010TWbanyRoztbmOFW8teN7FS9kwWM3GeMspPY4qTAJLnEhMFTh0Zei/5cLpr
         YtDQ==
X-Gm-Message-State: AJcUukfWTxzk0ndpOdSYWpEzV1Fz6lDrWg5hgbw+KZ119MxO21wxEGbz
        scdC/JJHmaawgjQut8XuJ40=
X-Google-Smtp-Source: ALg8bN7NlLSNzT2OSo1UeVa8wHYT13R0cUdofEIzkVCG2IqeqxG6MyHC+Z9nie6TvRXSgolgQ31huw==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr13453726wro.35.1547758513036;
        Thu, 17 Jan 2019 12:55:13 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s5sm25721654wmh.37.2019.01.17.12.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 12:55:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 01/21] travis: fix skipping tagged releases
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
        <75ec97b3921f3ed346e9ab119ebff2546f03fade.1547645770.git.gitgitgadget@gmail.com>
Date:   Thu, 17 Jan 2019 12:55:11 -0800
In-Reply-To: <75ec97b3921f3ed346e9ab119ebff2546f03fade.1547645770.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 16 Jan 2019
        05:36:11 -0800 (PST)")
Message-ID: <xmqqsgxrm2c0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When building a PR, TRAVIS_BRANCH refers to the *target branch*.
> Therefore, if a PR targets `master`, and `master` happened to be tagged,
> we skipped the build by mistake.

Good spotting.

>
> Fix this by using TRAVIS_PULL_REQUEST_BRANCH (i.e. the *source branch*)
> when available, falling back to TRAVIS_BRANCH (i.e. for CI builds, also
> known as "push builds").
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/lib-travisci.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
> index 69dff4d1ec..d9d4f1a9d7 100755
> --- a/ci/lib-travisci.sh
> +++ b/ci/lib-travisci.sh
> @@ -1,5 +1,9 @@
>  # Library of functions shared by all CI scripts
>  
> +# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
> +# want here. We want the source branch instead.
> +TRAVIS_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"

To those who are familiar with Travis [*1*], I suspect that
TRAVIS_BRANCH has a specific meaning (e.g. with PR, it is target
branch), and assigning a different value that is taken from another
variable with different meanings to TravisCI would confuse them.

Perhaps introduce a new variable, like so...

	BRANCH_TO_BUILD="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"

and then s/TRAVIS_BRANCH/BRANCH_TO_BUILD/g on the body of the
skip_branch_tip_with_tag helper function.

Thanks.


[Footnote]

*1* I obviously am not among them; otherwise we would have caught
this while reviewing 09f5e974 ("travis-ci: skip a branch build if
equal tag is present", 2017-09-10).




>  skip_branch_tip_with_tag () {
>  	# Sometimes, a branch is pushed at the same time the tag that points
>  	# at the same commit as the tip of the branch is pushed, and building
