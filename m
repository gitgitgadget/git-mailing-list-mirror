X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 8 Dec 2006 08:35:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
 <45744FA3.7020908@zytor.com> <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org>
 <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org>
 <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org>
 <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
 <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org>
 <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>
 <45798FE2.9040502@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 8 Dec 2006 16:36:55 +0000 (UTC)
Cc: Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45798FE2.9040502@zytor.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33703>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsiiK-0007gx-F6 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 17:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760769AbWLHQgl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 11:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760770AbWLHQgl
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 11:36:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59921 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760769AbWLHQgk
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 11:36:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB8GZNID014454
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 8
 Dec 2006 08:35:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB8GZMru026849; Fri, 8 Dec
 2006 08:35:23 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org



On Fri, 8 Dec 2006, H. Peter Anvin wrote:
> 
> This goes back to the "gitweb needs native caching" again.

It should be fairly easy to add a caching layer, but I wouldn't do it 
inside gitweb itself - it gets too mixed up. It would be better to have 
it as a separate front-end, that just calls gitweb for anything it doesn't 
find in the cache.

I could write a simple C caching thing that just hashes the CGI arguments 
and uses a hash to create a cache (and proper lock-files etc to serialize 
access to a particular cache object while it's being created) fairly 
easily, but I'm pretty sure people would much prefer a mod_perl thing just 
to avoid the fork/exec overhead with Apache (I think mod_perl allows 
Apache to run perl scripts without it), and that means I'm not the right 
person any more.

Not that I'm the right person anyway, since I don't have a web server set 
up on my machine to even test with ;)
	
		Linus
