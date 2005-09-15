From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree rename detection bug
Date: Wed, 14 Sep 2005 20:36:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509142032300.26803@g5.osdl.org>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
 <7vwtljjzc3.fsf@assigned-by-dhcp.cox.net> <59a6e583050914114054b1564d@mail.gmail.com>
 <Pine.LNX.4.58.0509141321180.26803@g5.osdl.org> <17192.56103.803096.526568@cargo.ozlabs.ibm.com>
 <17192.56292.867933.739867@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wayne Scott <wsc9tt@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 05:37:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFkXl-0001HS-BX
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 05:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVIODgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 23:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVIODgK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 23:36:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11239 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964914AbVIODgI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 23:36:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8F3a1Bo012411
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Sep 2005 20:36:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8F3a0np011165;
	Wed, 14 Sep 2005 20:36:01 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17192.56292.867933.739867@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8583>



On Thu, 15 Sep 2005, Paul Mackerras wrote:
> 
> I meant to say explicitly that it runs quite happily under a ppc64
> kernel, but only does 32-bit executables at present.

It works, but it does end up complaining about things like 

	==23756== Invalid read of size 4
	==23756==    at 0x25A38990: strlen (in /lib/libc-2.3.5.so)
	..
	==23756==  Address 0x25B86754 is 3 bytes after a block of size 17 alloc'd

which seems to be just strlen prefetching the next word or something like 
that. 

But it's still nicer than not having it at all, even if it appears I'll 
have to do some filtering of my own.

		Linus
