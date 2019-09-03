Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBF261F461
	for <e@80x24.org>; Tue,  3 Sep 2019 22:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfICWS4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 18:18:56 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54485 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfICWS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 18:18:56 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 85C7AC0005;
        Tue,  3 Sep 2019 22:18:53 +0000 (UTC)
Date:   Wed, 4 Sep 2019 03:48:51 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-gui: Add hotkeys to set widget focus
Message-ID: <20190903221851.gkbbvnrl72szwydx@yadavpratyush.com>
References: <xmqqbmg13sxq.fsf@gitster-ct.c.googlers.com>
 <20190831122326.9071-1-birger.sp@gmail.com>
 <20190901113218.3lfu4ifsxhzrsw4g@yadavpratyush.com>
 <e2b35f49-5578-c58f-326d-3111333737a0@iee.email>
 <20190902122527.6cbcizo5dsewrl57@yadavpratyush.com>
 <ca5052b8-32ea-5d38-76ba-2389b5f95e45@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca5052b8-32ea-5d38-76ba-2389b5f95e45@iee.email>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/19 06:23PM, Philip Oakley wrote:
> On 02/09/2019 13:25, Pratyush Yadav wrote:
> > On 01/09/19 11:27PM, Philip Oakley wrote:
> > > Hi Pratyus,
[snip]
> > > Are there any plans or thoughts about creating a more inclusive 
> > > man page for
> > > the git-gui?
> > Having better documentation has been one of the things I have in my
> > future plans, but I can't really say when I can get to it depending on
> > my schedule and time available. I have a couple other topics active
> > which I'd like to get resolved first.
> > 
> > Of course, if someone else is willing to take the initiative, I'm happy
> > to help :)
> 
> The main aspect that would help for providing a contribution would be to at
> least decide the (rough) framework/format for a full Gui 'man page'. The
> existing one
> https://github.com/git/git/blob/master/Documentation/git-gui.txt is rather
> short. (would also need the sub-tree integration to be finessed)
> 
> e.g.
> 1. how much should it be done via 'include' files (like the git-config man
> page now does include::config.txt[] and onwards).
> 
> 2. Does it use the doc-book man-page format, or something akin to the former
> tutorial format? (everything appears to have shifted to the man page format,
> so looks like man format is the one.. [1,2,3,4]
> 
> I'm thinking that, as it is a big job, it will need the documentation to be
> split over a number of small include files so that more folk can be
> contributors.

What exactly do you think we should document?  From what I can see, the 
major topics are "options", "key bindings", and "tools".  Maybe also the 
blame viewer.

If we do options inside the dialog with tooltips, that leaves key 
bindings.  If there is not much else, we might as well do it in the one 
single man page we have, and worry about splitting later when it grows 
in size.

If you intend to have a more comprehensive documentation where we 
demonstrate the UI stuff, then using a man page will handicap us.  In 
that case a HTML page is a better idea.  Although I'm not too sure what 
warrants documentation is the general UI.  It all seems pretty intuitive 
to me, but them I am a "power user" so maybe I'm assuming too much.

> > For the options dialog, I think a "tooltip" (something like what you 
> > get
> > when you hover over a image in a browser) that describes the option is a
> > better idea than having a separate man page. I don't expect the option
> > descriptions to be too long or complicated. This approach has the added
> > benefit of not having to maintain a separate man page. Whenever someone
> > adds a new options, they have to add its description as well.
> A tool tip that says 'see git help config.. ' could be done. Any pointers to
> an existing one for trying a cookie cutter approach getting started on those
> ones?

The "Choose a revision" dialog shows a tooltip. You can get it by 
creating a tool with the "Ask the user to select a revision" option 
selected. Look in lib/choose_rev.tcl.

The blame viewer also uses tooltips. When you hover over a line, it 
shows the commit message of the last commit that touched it. Look in 
lib/blame.tcl.

Then there is Tk's tooltip package [0]. I haven't used it, so can't 
really say what the differences are, and which is better.

If you do end up using the tooltip implemented in choose_rev.tcl and 
blame.tcl, I think it is a good idea to move the common tooltip code in 
a "tooltip framework".

Although I understand that it is a lot of work (especially if you decide 
to refactor the existing tooltip code), and not exactly documentation, 
so it might not be what you want to do.

[0] https://core.tcl-lang.org/tklib/doc/trunk/embedded/www/tklib/files/modules/tooltip/tooltip.html

-- 
Regards,
Pratyush Yadav
