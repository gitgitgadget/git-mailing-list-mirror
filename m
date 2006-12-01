X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 16:21:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611301618490.3513@woody.osdl.org>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
 <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org> <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org> <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org> <Pine.LNX.4.64.0611301521320.9647@xanadu.home>
 <7vhcwgiqer.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611301624430.9647@xanadu.home>
 <7vlklsfsgz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611301520370.3513@woody.osdl.org>
 <873b80tqvv.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 00:22:48 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Theodore Tso <tytso@mit.edu>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <873b80tqvv.wl%cworth@cworth.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32839>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpwAq-0004ug-Or for gcvg-git@gmane.org; Fri, 01 Dec
 2006 01:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031642AbWLAAWi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 19:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031644AbWLAAWi
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 19:22:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:21943 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1031642AbWLAAWh (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 19:22:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB10LwjQ021979
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 16:21:59 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB10LuU4025664; Thu, 30 Nov
 2006 16:21:57 -0800
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Carl Worth wrote:
> >
> > So you can do
> >
> > 	echo a > file-a
> > 	echo b > file-b
> > 	git add file-a file-b
> >
> > 	git commit file-a
> 
> But, wait a second. What if I do my typo fix to file-a in between that
> "git add" and the "git commit". Why should "git commit" insist so
> vehemently on committing the _old_ state of file-a while "git commit
> file-a" so happily commits the _new_ state?

Because that's what "git commit filename" means.

It means "commit the changes to this file".

> I'm really not seeing conceptual consistency to what "commit <files>"
> does compared to "commit".

Exactly what the command says. "git commit" says "commit everything I've 
told you to commit". While "git commit filename" says "commit the changes 
that I've made to this file".

Yes, they are two totally different cases, but nobody sane can claim that 
it is strange. Exactly _because_ you explicitly list the filename, that 
also means that you want the file content AT THAT TIME. If you don't list 
the filename, you obviously must be talking about committing something you 
did earlier.

