X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Enter interactive mode if no parameters are given to
 git-add
Date: Tue, 19 Dec 2006 11:04:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612191101490.3483@woody.osdl.org>
References: <200612191516.09606.andyparkins@gmail.com>
 <7vy7p3pxyr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 19:05:18 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vy7p3pxyr.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34842>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwkGo-0006Wz-Rg for gcvg-git@gmane.org; Tue, 19 Dec
 2006 20:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932894AbWLSTE4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 14:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932898AbWLSTE4
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 14:04:56 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55150 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932894AbWLSTEz
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 14:04:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBJJ4p2J025510
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 19
 Dec 2006 11:04:52 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBJJ4p7q007552; Tue, 19 Dec
 2006 11:04:51 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Tue, 19 Dec 2006, Junio C Hamano wrote:

> Andy Parkins <andyparkins@gmail.com> writes:
> 
> > git-add with no parameters previously adds every modified file.  This
> > patch instead makes git-add enter interactive mode.
> > ...
> > It seemed a bit nasty to add content without explicit instructions to do
> > so.
> 
> Does anybody rely on the current behaviour?

I don't know about "rely", but yes, it's what I normally do. When I import 
a tar-ball, I'll just do

	..untar..
	cd result-x.y.z
	git init-db
	git add
	git commit

and I don't usually use the "." at all, since it's unnecessary.

But hey, if it enters some interactive mode, maybe I can teach myself to 
either just do "git add .", or if the interactive mode has a choice of "a" 
for "all", then why not?

> While I think nobody should drive 'git add' from script, the
> behaviour to add everything when there is no explicit parameter
> (or fall back to interactive for that matter) has a problem if
> you say "some command | xargs git-add --" (you need "xargs -r"
> to fix it, which is GNU).

That's a really good argument against the current behaviour of "git add", 
so while I actually use it without any parameters, I will concur that we 
should probably change it.

