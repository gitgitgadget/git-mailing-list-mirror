Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC925C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 22:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70422064B
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 22:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfKWWIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 17:08:51 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:38524 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbfKWWIu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 17:08:50 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5CC6D1F463;
        Sat, 23 Nov 2019 22:08:50 +0000 (UTC)
Date:   Sat, 23 Nov 2019 22:08:50 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] git-svn: drop support for `--preserve-merges`
Message-ID: <20191123220850.GA29423@dcvr>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <b7ba83969da8fd2db4e6074d5044938c05b992fd.1574542243.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7ba83969da8fd2db4e6074d5044938c05b992fd.1574542243.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> We already passed the `--rebase-merges` option to `git rebase` instead,
> now we make this move permanent.

> diff --git a/git-svn.perl b/git-svn.perl
> index 4aa208ff5f..f1fa1bc7f7 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -271,7 +271,6 @@ sub _req_svn {
>  			  'fetch-all|all' => \$_fetch_all,
>  			  'dry-run|n' => \$_dry_run,
>  			  'rebase-merges|p' => \$_rebase_merges,
> -			  'preserve-merges|p' => \$_rebase_merges,
>  			  %fc_opts } ],
>  	'commit-diff' => [ \&cmd_commit_diff,
>  	                   'Commit a diff between two trees',

Nack, it breaks existing usages.   Why the urgency with removal?

I don't know a whole lot about this rebase feature in
particular, but deprecation periods should be measured in years
or even decades because of LTS distros.  Not months, especially
for things which have been around for a long while.
