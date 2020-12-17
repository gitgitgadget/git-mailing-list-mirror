Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7BAC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 20:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13FC1239FF
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 20:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgLQULg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 15:11:36 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58437 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgLQULg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 15:11:36 -0500
X-Originating-IP: 103.82.80.43
Received: from localhost (unknown [103.82.80.43])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id AE81440002;
        Thu, 17 Dec 2020 20:10:53 +0000 (UTC)
Date:   Fri, 18 Dec 2020 01:40:51 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Haller <stefan@haller-berlin.de>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] git-gui: Auto-rescan on activate
Message-ID: <20201217201051.am33p6h2xu6wq34s@yadavpratyush.com>
References: <20201101170505.71246-1-stefan@haller-berlin.de>
 <e5f6753b-10b3-1291-1b39-34af63792037@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5f6753b-10b3-1291-1b39-34af63792037@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 17/12/20 08:45PM, Johannes Sixt wrote:
> Am 01.11.20 um 18:05 schrieb Stefan Haller:
> > Do an automatic rescan whenever the git-gui window receives focus. Most other
> > GUI tools do this, and it's very convenient; no more pressing F5 manually.
> > 
> > People who don't like this behavior can turn it off using
> > "git config gui.autorescan false".
> > 
> > Stefan Haller (2):
> >   git-gui: Delay rescan until idle time
> >   git-gui: Auto-rescan on activate
> > 
> >  git-gui.sh | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> > 
> 
> I've been using these patches in the past days.
> 
> I am still a bit ambivalent on whether I like the behavior. I do switch
> among windows *a lot* and there is a short flicker on every rescan. And
> there is muscle memory...

This is part of the reason I am a little uneasy enabling it by default, 
and why I insist on having a loud and clear warning to the users about 
what is going on.
 
> I observe a bug and a half:
> 
> It is unclear which file is selected automatically when there are
> unstaged changes. But there is one misbehavior: after I have invoked the
> merge tool, resolved the conflict, and then switch back to Git GUI, the
> conflicted file is not selected anymore when it is not the first file in
> the list. That is *very* annoying.

Haven't had a chance to try this out yet but AFAIK the last file should 
be correctly remembered. See below.
 
> And then there is the following use-case. While Git GUI is not active
> (think Git GUI and Gitk side-by-side and Gitk active), I click on a
> particular file that is not at the top of the list; then Git GUI becomes
> active and rescans, but also forgets on which file I have clicked. But I
> expected the clicked-on file to become visible, which it doesn't, and I
> have to click again. This is mildly annoying.

Hmm, I don't see that on my system on Linux. The code to remember last 
open file is there in 'rescan_done'. So I don't understand why this 
becomes a problem on your system.

-- 
Regards,
Pratyush Yadav
