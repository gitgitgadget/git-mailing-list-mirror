Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 504A01F461
	for <e@80x24.org>; Sun, 25 Aug 2019 11:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfHYL5d (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 07:57:33 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:34221 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfHYL5d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 07:57:33 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C0DCD20002;
        Sun, 25 Aug 2019 11:57:29 +0000 (UTC)
Date:   Sun, 25 Aug 2019 17:27:27 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/4] git-gui: Add ability to revert selected hunks and
 lines
Message-ID: <20190825115726.okwwala7y5wt6gzl@localhost.localdomain>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190822220107.4153-1-me@yadavpratyush.com>
 <xmqq4l28ommg.fsf@gitster-ct.c.googlers.com>
 <20190822225143.3blolae3f65z6zqq@localhost.localdomain>
 <CAKPyHN27Pz8BtzdUCewZMd2wi5hx8LyJTfJqwkyTbbQLJk+=VA@mail.gmail.com>
 <20190823164409.q23sxkfsmhvne4ud@localhost.localdomain>
 <CAKPyHN0QbCDzcG8=zPP4-WHKqMk3R0sJ0BjXDR=zak3OfEa2bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPyHN0QbCDzcG8=zPP4-WHKqMk3R0sJ0BjXDR=zak3OfEa2bg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/08/19 11:12PM, Bert Wesarg wrote:
> On Fri, Aug 23, 2019, 18:44 Pratyush Yadav <me@yadavpratyush.com> wrote:
> 
> > On 23/08/19 08:04AM, Bert Wesarg wrote:
> > > On Fri, Aug 23, 2019 at 12:51 AM Pratyush Yadav <me@yadavpratyush.com>
> > wrote:
> > > >
> > > > On 22/08/19 03:34PM, Junio C Hamano wrote:
> > [...]
> > > as I'm the one who use this feature for more than 7 years, I can only
> > > object to this. I'm happy to have the confirmation dialog for the
> > > whole-file revert (the current state) but having the dialog also for
> > > partial revert would be too disruptive. And disabling both at the same
> > > time would not be an option for me.
> > >
> > > The thing is, that the partial revert "just don't happen by accident".
> > > Here are the minimum user actions needed to get to this dialog:
> > >
> > > 1. whole-file revert
> > >
> > > - do a Ctrl+J, more or less anywhere in the GUI
> >
> > Hmm, have to agree with you on this. It is kind of easy to trigger. But
> > read below why I think partial reverts are just as easy to trigger.
> >
> > > 2. hunk revert/revert one unselected line
> > >
> > > - right click anywhere in the diff pane (thats around 60% of the window
> > area)
> > > - move the mouse pointer down 3/4 menu items
> > > - click this menu item
> >
> > But what if you wanted to click "Stage hunk", and instead click "Revert
> > hunk" instead. This is what I mean by "accidentally".
> >
> > This is even more a risk in the current layout of the buttons, which are
> > in the order:
> >
> > Stage Hunk
> > Revert Hunk
> > Stage Lines
> > Revert Lines
> >
> 
> but this is your current layout! my layout in the patch from 2012 was (and
> still is in my git-gui):
> 
> Stage Hunk
> Stage Line
> ----------
> Revert Hunk
> Revert Line
> 
> 
> thats a separator inbetween!
 
Looking at how this discussion has been going, I see that people really 
don't like the dialog, even with a config option. So I will send a 
re-roll with this layout of buttons and ability to undo last revert. I 
hope that will satisfy most people.

> bert
> 
> 
> 
> > In this layout, if you wanted to click Stage, you might end up clicking
> > Revert instead, losing part of your work. Even if we switch up the
> > layout a bit, I feel like the potential of "mis-aiming" your mouse is
> > there, but it can certainly be improved.
> >
> > > 3. partially revert selected lines
> > >
> > > - select some content in the diff pane by starting by pressing and
> > > holding a left click
> > > - end the selection by releasing the left click
> > > - move the mouse pointer down 3/4 menu items
> > > - click this menu item
> > >
> > > Thats always at least 2 user actions more than the whole-file revert.
> > > Thus this cannot happen by accident quite easily in comparison to the
> > > whole-file revert. And thats the reason why this dialog exists, from
> > > my point of view.
> > >
> > > I can see the need to disable the dialog for the whole-file revert,
> > > and IIRC that was also requested a long time ago on this list. But I
> > > don't see a reason to have this dialog also for the partial reverts as
> > > a safety measure.
> >
> > I do (not too strongly, but I do), as I explained why above.
> >
> > It shouldn't be too difficult to have separate knobs for whole-file and
> > partial reverts, but they will add two config options. Not necessarily a
> > bad thing, I just thought the people who wanted to disable partial
> > reverts would also want to disable whole-file reverts.
> >
> > But I have another suggestion in mind. I'll reply to one of the other
> > emails in this thread about it. Please read it there, I'd rather not
> > type it twice.
> >
> > --
> > Regards,
> > Pratyush Yadav
> >

-- 
Regards,
Pratyush Yadav
