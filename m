X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch-pack: avoid fixing thin packs when unnecessary
Date: Mon, 18 Dec 2006 22:55:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612182251210.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <86y7p57y05.fsf@blue.stonehenge.com>
 <Pine.LNX.4.63.0612182154170.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0612182213020.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612181638220.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 18 Dec 2006 21:56:10 +0000 (UTC)
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0612181638220.18171@xanadu.home>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34740>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwQSk-0007GM-HC for gcvg-git@gmane.org; Mon, 18 Dec
 2006 22:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754655AbWLRVz4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 16:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbWLRVzz
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 16:55:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:48141 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1754655AbWLRVzz
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 16:55:55 -0500
Received: (qmail invoked by alias); 18 Dec 2006 21:55:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp049) with SMTP; 18 Dec 2006 22:55:53 +0100
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 18 Dec 2006, Nicolas Pitre wrote:

> On Mon, 18 Dec 2006, Johannes Schindelin wrote:
> 
> > 
> > When we know that there are no common commits, the pack must be
> > closed (i.e. non-thin) already. Avoid "fixing" it in that case.
> > 
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > 
> > ---
> > 
> > 	On Mon, 18 Dec 2006, Johannes Schindelin wrote:
> > 
> > 	> On Mon, 18 Dec 2006, Randal L. Schwartz wrote:
> > 	> 
> > 	> > But then it took nearly an *hour* at the next phase:
> > 	> > 
> > 	> >   Resolving 313037 deltas.
> > 	> >    100% (313037/313037) done
> > 	> 
> > 	> Ouch.
> > 	> 
> > 	> We try to avoid unpacking the thin packs received by git-fetch.
> > 	> This means completing that pack (since it can contain deltas 
> > 	> against objects which are part of another pack).
> > 	> 
> > 	> However, for the clone this is utter overkill. We really should 
> > 	> try to avoid resolving unnecessarily. This is really for the 
> > 	> clone case, since we do not have _any_ objects in the local 
> > 	> repository.
> > 	> 
> > 	> It happens that the other case -- fetching an independent branch 
> > 	> -- is easy enough: we already have the check for it in 
> > 	> fetch-pack.c:586.
> > 
> > 	... and here is a lightly tested fix.
> 
> NAK.
> 
> This fixes nothing.  See previous message.

You're completely right. My patch does what I say, but it does not fix the 
problem.

Ciao,
Dscho
