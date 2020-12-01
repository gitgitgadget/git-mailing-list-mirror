Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89CDC64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A4D2151B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbgLATNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:13:30 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49349 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLATN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 14:13:26 -0500
X-Originating-IP: 103.82.80.86
Received: from localhost (unknown [103.82.80.86])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D56D8240009;
        Tue,  1 Dec 2020 19:12:43 +0000 (UTC)
Date:   Wed, 2 Dec 2020 00:42:41 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Cc:     Martin =?utf-8?B?U2Now7Zu?= <Martin.Schoen@loewensteinmedical.de>
Subject: Re: [PATCH v2 0/2] git-gui: Use commit message template
Message-ID: <20201201191241.6cdzrdcihdzoylwo@yadavpratyush.com>
References: <20201127145927.26222-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201127145927.26222-1-me@yadavpratyush.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/11/20 08:29PM, Pratyush Yadav wrote:
> Hi,
> 
> This series is a revival of [0] which was pointed to me by [1]. I have
> made some changes to the patch by Martin.
> 
> - The rescan call in proc commit_committree is removed. git-gui goes to
>   great lengths to avoid a rescan after commit by calculating the status
>   of the files in memory. It makes sense to keep it that way. The
>   purpose of the rescan was to reload the commit template in the buffer
>   after a commit. The rescan path handles that, but we can do that
>   manually as well.
> 
> - Add a call to load the commit message template in 'rescan' directly
>   instead of relying on 'run_prepare_commit_msg_hook' to do it when the
>   commit-msg hook does not exist.
> 
> In addition, patch 1/2 fixes a small bug in the commit message buffer
> backup logic that would be exposed by using the template mechanism. If
> you load git-gui, do some things, and exit it. Then if you change the
> commit message template (or even remove it), and open git-gui again it
> will use the previous message for the first commit and then use the new
> one from the next commit onwards.
> 
> This happens because if the commit message buffer in not empty, git-gui
> saves the contents to save accidental loss of data. And when opening it
> again, the saved message (which is the older template) obviously gets
> priority.
> 
> [0] https://public-inbox.org/git/1530608011429.41203@loewensteinmedical.de/T/
> [1] https://github.com/prati0100/git-gui/issues/24

Series merged to git-gui/master.
 
> Martin Schön (1):
>   git-gui: use commit message template
> 
> Pratyush Yadav (1):
>   git-gui: Only touch GITGUI_MSG when needed
> 
>  git-gui.sh     | 12 +++++++++---
>  lib/commit.tcl |  1 +
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> --
> 2.29.2
> 

-- 
Regards,
Pratyush Yadav
