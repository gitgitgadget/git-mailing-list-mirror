X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Fri, 15 Dec 2006 11:20:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612151118270.3849@woody.osdl.org>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com> 
 <200612112128.06485.Josef.Weidendorfer@gmx.de>  <Pine.LNX.4.64.0612111238560.3515@woody.osdl.org>
  <200612112154.56166.Josef.Weidendorfer@gmx.de>  <Pine.LNX.4.64.0612111258050.3515@woody.osdl.org>
 <e5bfff550612151045q5782e1f2j8686ccab24dbf566@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 15 Dec 2006 19:21:33 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550612151045q5782e1f2j8686ccab24dbf566@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34542>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvIcZ-0002ig-Lr for gcvg-git@gmane.org; Fri, 15 Dec
 2006 20:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753256AbWLOTVL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 14:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753257AbWLOTVL
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 14:21:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37057 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1753256AbWLOTVK
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 14:21:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBFJKxID001235
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 15
 Dec 2006 11:21:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBFJKlPU027004; Fri, 15 Dec
 2006 11:20:52 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Fri, 15 Dec 2006, Marco Costalba wrote:
> 
> Warmed-up cache
> QProcess 7632ms (500ms data read interval)
> QProcess 7972ms (100ms data read interval)

Why do you even bother posting numbers, when multiple people have told you 
that the numbers you post are meaningless?

As long as you throttle the writer by not reading data in a timely fashion 
(by using poll() or select() in the main loop and reading when it's 
available), and you continue to talk about "data read intervals", all your 
numbers are CRAP.

OF COURSE a temp-file will work better, because then you basically have an 
infinite buffer, and data read intervals don't _matter_. But we've tried 
to tell you that this is not because temp-files are better, but because 
your reader artificially throttles the writer for a pipe.

