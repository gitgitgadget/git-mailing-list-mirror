Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70BD42036D
	for <e@80x24.org>; Thu, 23 Nov 2017 11:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbdKWLww (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 06:52:52 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41856 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbdKWLwv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 06:52:51 -0500
Received: by mail-wr0-f194.google.com with SMTP id z14so17348858wrb.8
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 03:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JT4O6Am9XM/5+dmDjYrThCYnDnt98zRbDBBcxGqzRFo=;
        b=DM0KBUgqfAlm201sF9VRuro7/63/C7G+vGZ28pWXvj2d9p2EWlSGYUfdrvtW8jmlSm
         G3/dolBD8hMkOTfb5aVAAkjIXbSAnShTE7tzHvgOxtPoriwQVBt0QqL3Y+BwMWY2GKtl
         ZJC3jqcbQ/dbb2JwSvGRVBsrDb6GH/Z7CwTJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JT4O6Am9XM/5+dmDjYrThCYnDnt98zRbDBBcxGqzRFo=;
        b=fpLgx0u1jV6IEX5WfkaShyZbd712zE/EmFVqX1FEqU7Rgp38AQSCCuAMHNeA3k49rn
         wS/VucxGarK43Rs1ph0g00Wuhk/N1IiRM1IseEHGooqI/oydFuTRV7htnB/eIlAptMAl
         0VBs6IiqpKaffMT4aeUfpnP2Vps51fSTZdXOoVtd1ymJzI+IkRgDqxGXlCCD4FBCfGBM
         t/8ahb0yAFjUk3oReLC0S302hpwize1MIMmmms6T9761clThOo9LE5c6RWLRcI9B4yfH
         vuWD3KGk0STkISbmp0Ogv1+R96RLr+ui5znorYPSO4YaPLjTjHPdEfvcosZumr1MenhX
         gJGg==
X-Gm-Message-State: AJaThX5ciAbTtJ0muLv8hRvyqIwuotbf5jcdVgFtqfDETqEFdEYuulV7
        ifuwp8XiUV87UAIrgkVgyhjbfw==
X-Google-Smtp-Source: AGs4zMb1i0NHhBOqNA96r3xRBK+sdfq6y5zjwduxYSqImQKyr04GF5jlpAG4MeMKOpG6Uanv2YrMfQ==
X-Received: by 10.223.166.103 with SMTP id k94mr20951527wrc.22.1511437969804;
        Thu, 23 Nov 2017 03:52:49 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id 2sm14529369wre.17.2017.11.23.03.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Nov 2017 03:52:48 -0800 (PST)
Date:   Thu, 23 Nov 2017 11:52:46 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 00/33] Add directory rename detection to git
Message-ID: <20171123115246.GV20681@dinwoodie.org>
References: <20171121080059.32304-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171121080059.32304-1-newren@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday 21 November 2017 at 12:00 am -0800, Elijah Newren wrote:
> <snip>
> 
>  merge-recursive.c                   | 1243 +++++++++++-
>  merge-recursive.h                   |   17 +
>  t/t3501-revert-cherry-pick.sh       |    5 +-
>  t/t6043-merge-rename-directories.sh | 3821 +++++++++++++++++++++++++++++++++++
>  t/t7607-merge-overwrite.sh          |    7 +-
>  unpack-trees.c                      |    4 +-
>  unpack-trees.h                      |    4 +
>  7 files changed, 4985 insertions(+), 116 deletions(-)
>  create mode 100755 t/t6043-merge-rename-directories.sh

The new t6043.44 introduced in this branch is failing on my Cygwin
system.  I can't immeditely see what's causing the failure, but I've
copied the relevant verbose + shell tracing output below in the hope it
makes more sense to you:

expecting success:
        (
                cd 7b &&

                git checkout A^0 &&

                test_must_fail git merge -s recursive B^0 >out &&
                test_i18ngrep "CONFLICT (rename/rename)" out &&

                test 4 -eq $(git ls-files -s | wc -l) &&
                test 2 -eq $(git ls-files -u | wc -l) &&
                test 3 -eq $(git ls-files -o | wc -l) &&

                git rev-parse >actual \
                        :0:y/b :0:y/c :2:y/d :3:y/d &&
                git rev-parse >expect \
                        O:z/b O:z/c O:w/d O:x/d &&
                test_cmp expect actual &&

                test ! -f y/d &&
                test -f y/d~HEAD &&
                test -f y/d~B^0 &&

                git hash-object >actual \
                        y/d~HEAD y/d~B^0 &&
                git rev-parse >expect \
                        O:w/d O:x/d &&
                test_cmp expect actual
        )

++ cd 7b
++ git checkout 'A^0'
Note: checking out 'A^0'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

HEAD is now at 0808992 A
++ test_must_fail git merge -s recursive 'B^0'
++ case "$1" in
++ _test_ok=
++ git merge -s recursive 'B^0'
++ exit_code=1
++ test 1 -eq 0
++ test_match_signal 13 1
++ test 1 = 141
++ test 1 = 269
++ return 1
++ test 1 -gt 129
++ test 1 -eq 127
++ test 1 -eq 126
++ return 0
++ test_i18ngrep 'CONFLICT (rename/rename)' out
++ test -n ''
++ test 'x!' = 'xCONFLICT (rename/rename)'
++ grep 'CONFLICT (rename/rename)' out
CONFLICT (rename/rename): Rename w/d->y/d in HEAD. Rename x/d->y/d in B^0
+++ git ls-files -s
+++ wc -l
++ test 4 -eq 4
+++ git ls-files -u
+++ wc -l
++ test 2 -eq 2
+++ git ls-files -o
+++ wc -l
++ test 3 -eq 3
++ git rev-parse :0:y/b :0:y/c :2:y/d :3:y/d
++ git rev-parse O:z/b O:z/c O:w/d O:x/d
++ test_cmp expect actual
++ diff -u expect actual
++ test '!' -f y/d
+ test_eval_ret_=1
+ want_trace
+ test t = t
+ test t = t
+ set +x
error: last command exited with $?=1
not ok 44 - 7b-check: rename/rename(2to1), but only due to transitive rename
