X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface
 warts)
Date: Thu, 16 Nov 2006 23:21:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611162315110.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
 <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
 <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 22:22:18 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31628>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkpcT-0004g9-5Q for gcvg-git@gmane.org; Thu, 16 Nov
 2006 23:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424748AbWKPWV7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 17:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424746AbWKPWV7
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 17:21:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:29374 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1424745AbWKPWV6 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 17:21:58 -0500
Received: (qmail invoked by alias); 16 Nov 2006 22:21:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp028) with SMTP; 16 Nov 2006 23:21:56 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 16 Nov 2006, Linus Torvalds wrote:

> On Thu, 16 Nov 2006, Han-Wen Nienhuys wrote:
> > 
> > * why are objects downloaded twice?  If I do
> > 
> >   git --bare fetch git://git.sv.gnu.org/lilypond.git web/master
> > 
> > it downloads stuff, but I don't get a branch.
> 
> A "fetch" by default won't actually generate a local branch unless you 
> told it to.

This is actually a perfect example for

- a script that is porcelain as well as plumbing (you are supposed to use 
it directly, or via pull), and for

- a terrible UI.

_If_ you use git-fetch directly you virtually always want to store the 
result. I was tempted quite often to submit a patch which adds a command 
line switch --no-warn, which is passed to git-fetch by git-pull, and 
without which git-fetch complains if the branch-to-be-fetched is not 
stored right away (and refuses to go along).

_Also_, git-pull not storing the fetched branches at least temporarily 
often annoyed me: the pull did not work, and the SHA1 was so far away I 
could not even scroll to it. The result: I had to pull (and fetch!) the 
whole darned objects again. Again, I was tempted quite often to submit a 
patch which makes git-pull fetch the branches into refs/fetch-temp/* and 
only throw them away when the merge succeeded.

Ciao,
Dscho
