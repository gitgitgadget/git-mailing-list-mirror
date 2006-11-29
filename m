X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: can I remove or move a tag in a remote repository?
Date: Wed, 29 Nov 2006 12:45:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611291220130.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87wt5rffbm.fsf@rho.meyering.net> <7virgz1bz7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611291040590.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <87u00imsin.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 11:46:03 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <87u00imsin.fsf@rho.meyering.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32635>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpNsm-00031p-Au for gcvg-git@gmane.org; Wed, 29 Nov
 2006 12:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935467AbWK2Lpj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 06:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935514AbWK2Lpj
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 06:45:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:35003 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S935467AbWK2Lpi (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 06:45:38 -0500
Received: (qmail invoked by alias); 29 Nov 2006 11:45:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp036) with SMTP; 29 Nov 2006 12:45:36 +0100
To: Jim Meyering <jim@meyering.net>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 29 Nov 2006, Jim Meyering wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > I also think that git-fetch silently updating tags is wrong. Rather, it
> > should warn that the tags are different. But I've been wrong before.
> 
> AFAIK, no one wants git-fetch to update tags _silently_. I expected it 
> give a diagnostic and fail by default -- and it already does that.

Umm. I just tested it, and it said "updating tag" without failing.

> Pushing moved tags is serious business.  I was hoping to be able to use 
> --force to override that fail-safe.

Hmmm. Probably Junio's patch is correct after all, since tags are special 
creatures: you do not expect them to change, but if, they can change 
arbitrarily (as opposed to branches, which should evolve linearly).

> My goal is to maintain a symbolic reference "cvs-head" that points
> to the newest git trunk node that's been mirrored to a CVS repository.

But is that not just tracking another branch?

> Without even considering any other option, I chose to use a lightweight
> tag for that purpose, since I have a conceptual view that it's a label I
> can move from one referent to another.  It strikes me as counter-intuitive
> to use a temporary git "branch" that way.  Would that even work, removing
> it and recreating it all the time?

Yes, it would. Remember: a branch in git is just a named ref. It 
literally used to be a 41-byte file pointing to the tip of the branch in 
the ancestor graph. And you can update it with git-update-ref.

So, a branch in git is very much the movable label you are looking for.

Ciao,
Dscho
