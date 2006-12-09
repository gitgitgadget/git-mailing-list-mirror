X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: Easy shell question: how to make a script killing all his childs when killed?
Date: Sat, 9 Dec 2006 22:39:37 +0100
Message-ID: <20061209213937.GB12373@steel.home>
References: <e5bfff550612090716p215167b9r2277b09c09b18894@mail.gmail.com> <20061209173703.GA12373@steel.home> <e5bfff550612090951l43a83a00o7ea2e244ca562c77@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 21:39:50 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <e5bfff550612090951l43a83a00o7ea2e244ca562c77@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-ID: rPJ9CcZVre1omfkxP+1SxxtG-6OD+OuMDRXrFVsDBezrS69fiorFYQ
X-TOI-MSGID: 88ed215c-6819-44b1-b07a-fa27a414c92c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33838>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt9vA-0005lb-P5 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 22:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757289AbWLIVjq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 16:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757674AbWLIVjq
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 16:39:46 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:59622 "EHLO
 mailout09.sul.t-online.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1757289AbWLIVjp (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 16:39:45 -0500
Received: from fwd34.aul.t-online.de  by mailout09.sul.t-online.com with smtp
  id 1Gt9v5-00029K-02; Sat, 09 Dec 2006 22:39:43 +0100
Received: from tigra.home
 (rPJ9CcZVre1omfkxP+1SxxtG-6OD+OuMDRXrFVsDBezrS69fiorFYQ@[84.163.113.204]) by
 fwd34.sul.t-online.de with esmtp id 1Gt9v0-1fcgfg0; Sat, 9 Dec 2006 22:39:38
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id E1D00277AF; Sat,  9 Dec 2006 22:39:37 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1Gt9uz-0003gE-I5; Sat, 09 Dec 2006 22:39:37 +0100
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

Marco Costalba, Sat, Dec 09, 2006 18:51:57 +0100:
> >> P.S: I have no way to exec the script in fancy ways, I can just start
> >> it and get is PID.
> >
> >Which is "fancy" enough. What do you mean "start"? Starting a new
> >process usually and notably involves forking and execing (even if the
> >first thing to exec will be your shell).
> 
> By 'start' I mean it is done inside Qt QProcess class back box ;-)
> 
> Anyway I have written an homegrown 'wanna be hacker' launching script:
> 
> git rev-list --header --boundary --parents --topo-order HEAD >
> /tmp/qgit_136224752.txt &
> echo $!
> wait
> 
> With this I can get the pid of git-rev-list from my QProcess interface
> so to be able to kill it when needed with another command ('kill'
> BTW).

Why do you need to save it in temporary file at all? Why don't you
read the output like gitk does?  You can take a look at popen(3). It's
known to be portable among operating systems and libc's.  Or, BTW, why
don't you just read qprocess.h, use processIdentifier()/pid(),
read*()-methods and the like?  (though, looking at the QProcess in
