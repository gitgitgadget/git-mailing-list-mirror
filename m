Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCC6C83011
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 18:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFBB207F7
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 18:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgK3SJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 13:09:26 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:33907 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387955AbgK3SJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 13:09:25 -0500
X-Originating-IP: 103.82.80.216
Received: from localhost (unknown [103.82.80.216])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 834B440007;
        Mon, 30 Nov 2020 18:08:42 +0000 (UTC)
Date:   Mon, 30 Nov 2020 23:38:27 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     serg.partizan@gmail.com
Cc:     Stefan Haller <stefan@haller-berlin.de>, git@vger.kernel.org
Subject: Re: [PATCH] git-gui: use gray selection background for inactive
 text?? widgets
Message-ID: <20201130180827.2oimhr3vmjq7tzaq@yadavpratyush.com>
References: <DZJ7KQ.UXACXR9SWDQI3@gmail.com>
 <20201123114805.48800-1-stefan@haller-berlin.de>
 <1a42781d-0e4c-6478-f26d-5eccbd9c6205@haller-berlin.de>
 <WC3MKQ.KLJ4EJGGRQYY2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <WC3MKQ.KLJ4EJGGRQYY2@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have not had the time to go through these patches. I'll try to do it 
in a couple days.

On 30/11/20 03:41PM, serg.partizan@gmail.com wrote:
> 
> 
> On Sun, Nov 29, 2020 at 18:40, Stefan Haller <stefan@haller-berlin.de>
> wrote:
> > After spending quite a while single-stepping through lots of Tk code, I
> > found the reason. On Mac, disabled text widgets simply don't draw the
> > selection background. [1]
> > 
> > I can see three options for solving this:
> > 
> > 1) Don't use "state focus" and "state !focus" on the text widgets, but
> >    instead set the selection color manually using "text conf sel
> >    -background". Disadvantage: have to calculate the disabled color
> >    using a heuristic like I did for the file lists in my v2 patch.
> > 
> > 2) Don't use "configure -state disabled" to make the diff text widget
> >    read-only; instead, use one of the other methods from [2].
> >    Disadvantage: quite a big change, and seems complex to me.
> > 
> > 3) Enable the the diff widget when it loses focus, and disable it again
> >    when it gets focus. I tried this in a quick prototype, and it works
> >    very well. It just *feels* wrong to enable a read-only text widget
> >    while it is unfocused; but I couldn't find any situation where it
> >    would behave wrong, because as soon as you try to interact with it,
> >    the first thing that happens is that it gets disabled again.
> > 
> > I tend towards option 3, because it's reasonably simple and works. I'll
> > work on a patch tomorrow unless anybody has objections.
> > 
> 
> I don't like any of this options, as it makes code complicated. I personally
> would prefer to not implement this feature at all, but that's just me.

That is my first thought as well. All 3 alternatives are less than 
ideal. I don't think the problem is big enough to warrant adding hacks 
like this. They will come back to bite us sooner or later.

If you _really_ want to fix this, maybe try convincing the Tk devs about 
fixing it.
 
> Maybe Pratyush can say something reasonable about this, as maintainer.
> 
> I propose to wait a week or two for other opinions, before starting to write
> a patch.
> 
> 

-- 
Regards,
Pratyush Yadav
