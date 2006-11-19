X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Sun, 19 Nov 2006 20:06:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611191932270.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64dcbdgb.fsf@assigned-by-dhcp.cox.net> <ejpu4r$dsk$1@sea.gmane.org>
 <Pine.LNX.4.63.0611191729190.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <200611191931.32193.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 19:06:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200611191931.32193.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31854>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlrzZ-0007m9-2P for gcvg-git@gmane.org; Sun, 19 Nov
 2006 20:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932960AbWKSTGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 14:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933022AbWKSTGJ
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 14:06:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:9878 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S932960AbWKSTGI (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 14:06:08 -0500
Received: (qmail invoked by alias); 19 Nov 2006 19:06:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp040) with SMTP; 19 Nov 2006 20:06:06 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Sun, 19 Nov 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > I do not understand. What paths are handled by git-shortlog?
> 
> I was under (perhaps false) impression that somewhere in git-shortlog 
> there is shortening of
>   Merge branch 'master' of git://git.kernel.org/pub/scm/git/git
> messages, shortening the URL part.
> 
> Perhaps this was only other example of hard-coded git-for-Linux-ness.

I found it: git-shortlog.perl:28 says

        $desc =~ s#/pub/scm/linux/kernel/git/#/.../#g;

And in builtin-shortlog.c:90 you can read

        const char *dot3 = "/pub/scm/linux/kernel/git/";

and in lines 133--136:

        while ((p = strstr(buffer, dot3)) != NULL) {
                memcpy(p, "...", 3);
                strcpy(p + 2, p + sizeof(dot3) - 1);
        }

So, not only did I forget that git-shortlog has the path shortening, but I 
also forgot that I implemented it in the builtin shortlog, too.

Ciao,
Dscho

