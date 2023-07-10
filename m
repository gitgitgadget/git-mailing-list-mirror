Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01660EB64D9
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 16:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjGJQhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 12:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGJQht (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 12:37:49 -0400
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22621E8
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 09:37:47 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4R08n43JD7z5tl9;
        Mon, 10 Jul 2023 18:37:44 +0200 (CEST)
Message-ID: <9a498c81-82b4-d441-6b5d-78ba3043b5a9@kdbg.org>
Date:   Mon, 10 Jul 2023 18:37:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/2] fix resize issues on large screens
To:     =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>
References: <20230708105546.2945446-2-georgmueller@gmx.net>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20230708105546.2945446-2-georgmueller@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.07.23 um 12:55 schrieb Georg Müller:
> When opening gitk in a multi-monitor setup with different resolutions,
> the resize factor causes the first columns of the layout get bigger and
> bigger while the other columns (author, date in upper pane, file list in
> lower pane) shrink to a minimum size.
> 
> The following setup triggers the problem on Fedora 38/Gnome 44:
> * primary screen 1 has a FHD resolution (1920x1080)
> * secondary screen 2 has a QHD resolution (2560x1440)
> 
> Every time gitk opens at screen 2, the resize is triggered and the columns
> are shifted 1.33x to the right (2560/1920 = 1.33).
> After multiple rounds of closing/opening gitk, the columns are at their
> minimum size and the contents are not visible or only a minimum is
> visible.
> 
> The following patches are two approaches to fix the problem. Maybe the
> hard-coded values could be variables, this is a first shot to solve the
> problem.

Since you haven't stated it explicitly, I assume that with "the problem
solved" the resizing does not happen anymore. That's fine, but could be
stated explicitly.

When you say "two approaches", do you mean that the patches are
independent and either one solves the problem? And only one of them
should be taken?

I've not read the code changes (because I don't know a lot of Tcl/Tk).
But I've seen the commit messages of the patches. They are mostly empty.
This cover letter has a pretty good explanation of the problem. Please
copy everything that is relevant for each commit to the commit message,
because the cover letter won't be available in the commit history.

Thanks,
-- Hannes

> 
> Georg Müller (2):
>   gitk: limit factor scaling on resize to widths below 1900px
>   gitk: keep author and date colums to a minimal width on resize
> 
>  gitk-git/gitk | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> --
> 2.41.0
> 
> 

