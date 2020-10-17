Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96021C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 09:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526802074A
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 09:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437803AbgJQJhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 05:37:19 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37497 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437800AbgJQJhS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 05:37:18 -0400
X-Originating-IP: 103.82.80.226
Received: from localhost (unknown [103.82.80.226])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 5ED9F1BF204;
        Sat, 17 Oct 2020 09:37:15 +0000 (UTC)
Date:   Sat, 17 Oct 2020 15:07:13 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-gui blame: prevent tool tips from sticking around
 after Command-Tab
Message-ID: <20201017093713.ysk432l2n655go6k@yadavpratyush.com>
References: <20201013132643.3209-1-stefan@haller-berlin.de>
 <20201013151751.bq2raujl6dok2tvv@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013151751.bq2raujl6dok2tvv@yadavpratyush.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/10/20 08:47PM, Pratyush Yadav wrote:
> Hi Stefan,
> 
> > Subject: [PATCH] git-gui blame: prevent tool tips from sticking around
> Nitpick:                  ^ Add a ':' here.
> 
> On 13/10/20 03:26PM, Stefan Haller wrote:
> > On Mac, tooltips are not automatically removed when a window loses
> > focus. Furthermore, mouse-move events are only dispatched to the active
> > window, which means that if we Command-tab to another application while
> > a tool tip is showing, the tool tip will stay there forever (in front of
> > other applications). So we must hide it manually when we lose focus.
> > 
> > I'm doing this unconditionally here (i.e. without if {[is_MacOSX]}); it
> 
> Nitpick: s/I'm doing this/Do this/.
> 
> > shouldn't hurt on other platforms, even though they don't seem to have
> > this problem.
> 
> Yes, I don't have this problem on Linux. But this patch does not make 
> any visible difference/regressions either.
>  
> > Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> > ---
> >  lib/blame.tcl | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/lib/blame.tcl b/lib/blame.tcl
> > index 62ec083..8441e10 100644
> > --- a/lib/blame.tcl
> > +++ b/lib/blame.tcl
> > @@ -328,6 +328,7 @@ constructor new {i_commit i_path i_jump} {
> >  		bind $i <Any-Motion>  [cb _show_tooltip $i @%x,%y]
> >  		bind $i <Any-Enter>   [cb _hide_tooltip]
> >  		bind $i <Any-Leave>   [cb _hide_tooltip]
> > +		bind $i <Deactivate>  [cb _hide_tooltip]
> >  		bind_button3 $i "
> >  			[cb _hide_tooltip]
> >  			set cursorX %x
> 
> Will apply with the two nitpicks above fixed. No need to resend. Thanks.

Applied to git-gui/master. Thanks.

-- 
Regards,
Pratyush Yadav
