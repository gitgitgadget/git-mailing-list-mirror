X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Overwriting bare repositories' master
Date: Sun, 29 Oct 2006 23:43:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0610292338300.26682@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061029210333.GG12285@localhost.localdomain>
 <7vslh6zstt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 29 Oct 2006 22:43:28 +0000 (UTC)
Cc: Sylvain Beucler <beuc@gnu.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vslh6zstt.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30470>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeJN3-0000jB-UT for gcvg-git@gmane.org; Sun, 29 Oct
 2006 23:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030402AbWJ2WnK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 17:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWJ2WnK
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 17:43:10 -0500
Received: from mail.gmx.de ([213.165.64.20]:46051 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1030402AbWJ2WnJ (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 17:43:09 -0500
Received: (qmail invoked by alias); 29 Oct 2006 22:43:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp039) with SMTP; 29 Oct 2006 23:43:07 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Sun, 29 Oct 2006, Junio C Hamano wrote:

> Sylvain Beucler <beuc@gnu.org> writes:
> 
> > I tried and I found something that doesn't seem to follow the
> > documentation:
> >
> > [...]
> > error: denying non-fast forward; you should pull first
> >
> > From man git-push:
> > "If the optional plus + is used, the remote ref is updated even if it
> > does not result in a fast forward update."
> >
> > [...]
> >
> > Is this by design? Or should it work?
> 
> I suspect (because I cannot see your .git/config in the
> repository; which would say "[core] sharedrepository = 1" if my
> suspicion is correct) that this is fairly new heavyhanded safety
> valve added by the list around mid September, with this:
> 
>     commit 11031d7e9f34f6a20ff4a4bd4fa3e5e3c0024a57
>     Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>     Date:   Thu Sep 21 01:07:54 2006 +0200
> 
>         add receive.denyNonFastforwards config variable
> [...]

I still think the forced updates of pu still lose too many useful bits in 
git's history.

Having said that, if receive.denyNonFastforwards indeed is the culprit: 
git-shell allows you to do something like this:

	ssh user@git.gnu.org \
	  "git-repo-config --unset receive.denyNonFastforwards"

After that, forced pushes should succeed. By the same account,

	ssh user@git.gnu.org \
	  "git-repo-config --bool receive.denyNonFastforwards"

should tell you if Junio's suggestion is right (in this case, it will 
output "true").

Hth,
Dscho
