X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: using xdl_merge(), was Re: Resolving conflicts
Date: Wed, 6 Dec 2006 11:47:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061145220.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
 <456FDF24.1070001@saville.com> <Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
 <7vejri20mf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <4575B32F.5060108@ramsay1.demon.co.uk> <Pine.LNX.4.64.0612051023460.3542@woody.osdl.org>
 <Pine.LNX.4.63.0612051949290.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vac22glzz.fsf@assigned-by-dhcp.cox.net> <7vwt5573sy.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612061058360.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkll72no.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 10:47:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vlkll72no.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33432>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GruJH-0005Fa-00 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760467AbWLFKr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760468AbWLFKr2
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:47:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:39412 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1760466AbWLFKr1
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 05:47:27 -0500
Received: (qmail invoked by alias); 06 Dec 2006 10:47:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp048) with SMTP; 06 Dec 2006 11:47:25 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Originally, I thought that building in git-merge-one-file, and enhancing 
> > it to recognize by the parameters if it should act as a merge replacement, 
> > would be the way to go. Should I do this, or rather add 
> > builtin-merge-file?
> 
> All in-tree users of git-merge-one-file is of this pattern:
> 
> 	git merge-index -o git-merge-one-file -a
> 
> so I was hoping we can capture this whole thing as a single
> command (merge-index would fork+exec a merge-one-file per
> unmerged path), instead of doing merge-one-file as a built-in.

Yes, this was also my thinking. But notice how git-merge-one-file does 
much more than just merge? So, you end up rewriting it in C anyway, if you 
want to make merge-index not fork unless "-o cmd" is passed.

> In any case, the way your xdl-merge engine is done, it should be almost 
> trivial to write a pure 'RCS merge replacement' as a totally separate 
> program -- the bulk of the new code would be parsing parameters, opening 
> the three input files, populating mmfile structures and writing the 
> result out, and there would be almost no "smart" in that part of the 
> code you would want to share with the git-aware version.

Actually, I just did that. I will add some test cases (to reflect your 
option (3) in another thread), and submit.

Ciao,
Dscho
