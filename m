Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3C7C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 19:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7392389F
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 19:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgLQTqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 14:46:23 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:9962 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgLQTqW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 14:46:22 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4CxjCR53JTz5tlF;
        Thu, 17 Dec 2020 20:45:39 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CE789246;
        Thu, 17 Dec 2020 20:45:38 +0100 (CET)
Subject: Re: [PATCH 0/2] git-gui: Auto-rescan on activate
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     me@yadavpratyush.com, git@vger.kernel.org
References: <20201101170505.71246-1-stefan@haller-berlin.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e5f6753b-10b3-1291-1b39-34af63792037@kdbg.org>
Date:   Thu, 17 Dec 2020 20:45:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201101170505.71246-1-stefan@haller-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.11.20 um 18:05 schrieb Stefan Haller:
> Do an automatic rescan whenever the git-gui window receives focus. Most other
> GUI tools do this, and it's very convenient; no more pressing F5 manually.
> 
> People who don't like this behavior can turn it off using
> "git config gui.autorescan false".
> 
> Stefan Haller (2):
>   git-gui: Delay rescan until idle time
>   git-gui: Auto-rescan on activate
> 
>  git-gui.sh | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 

I've been using these patches in the past days.

I am still a bit ambivalent on whether I like the behavior. I do switch
among windows *a lot* and there is a short flicker on every rescan. And
there is muscle memory...

I observe a bug and a half:

It is unclear which file is selected automatically when there are
unstaged changes. But there is one misbehavior: after I have invoked the
merge tool, resolved the conflict, and then switch back to Git GUI, the
conflicted file is not selected anymore when it is not the first file in
the list. That is *very* annoying.

And then there is the following use-case. While Git GUI is not active
(think Git GUI and Gitk side-by-side and Gitk active), I click on a
particular file that is not at the top of the list; then Git GUI becomes
active and rescans, but also forgets on which file I have clicked. But I
expected the clicked-on file to become visible, which it doesn't, and I
have to click again. This is mildly annoying.

-- Hannes
