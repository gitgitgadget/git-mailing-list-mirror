From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage,
 dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 13:16:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601191309130.3240@g5.osdl.org>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
 <20060119052914.GC8121@trixie.casa.cgf.cx> <7vlkxciodu.fsf@assigned-by-dhcp.cox.net>
 <20060119161000.GA27888@trixie.casa.cgf.cx> <20060119203428.GA5090@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 22:16:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezh97-00054O-Dd
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 22:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161428AbWASVQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 16:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161432AbWASVQc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 16:16:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161428AbWASVQb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 16:16:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0JLGNDZ012698
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 Jan 2006 13:16:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0JLGHjV027759;
	Thu, 19 Jan 2006 13:16:21 -0800
To: Christopher Faylor <me@cgf.cx>
In-Reply-To: <20060119203428.GA5090@trixie.casa.cgf.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14932>



On Thu, 19 Jan 2006, Christopher Faylor wrote:
> 
> Btw, we're looking to roll out a new release of cygwin which fixes the
> embarrassing typo in sockaddr_storage.  It is fixed in cygwin snapshots:
> 
> http://cygwin.com/snapshots/

Quick question for cygwin people (I asked this at an earlier point, but I 
don't think there was any reply): would cygwin prefer using "vfork()" over 
"fork()", or is there no advantage? With vfork(), I could imagine that you 
might avoid a lot of strange VM games.. 

I think almost all of the git fork usage is of the type where "vfork()" 
would work fine (git-daemon in non-inetd form is an exception, perhaps the 
only one).

So if using vfork() is preferable, we probably should do that. It tends to 
be a small performance improvement on Linux too, although on Linux it's 
really pretty much in the noise.

Alternatively, is there anything else we can do that makes things easier?

			Linus
