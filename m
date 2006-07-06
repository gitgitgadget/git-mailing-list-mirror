From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Moving a topic branch forward: rebase vs. resolve
Date: Thu, 6 Jul 2006 14:24:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607061421100.3869@g5.osdl.org>
References: <20060706211008.GA6566@buici.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 06 23:24:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FybL1-0006hD-1s
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 23:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWGFVYf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 17:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWGFVYf
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 17:24:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750769AbWGFVYe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 17:24:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k66LOTnW032408
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 6 Jul 2006 14:24:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k66LOSWb012770;
	Thu, 6 Jul 2006 14:24:29 -0700
To: Marc Singer <woolie@cac.washington.edu>
In-Reply-To: <20060706211008.GA6566@buici.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.84__
X-MIMEDefang-Filter: osdl$Revision: 1.138 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23403>



On Thu, 6 Jul 2006, Marc Singer wrote:
> 
> So, I tried resolve which I would expect to apply the other direction,
> merging 234 onto C.  git-resolve finishes in a single pass leaving
> conflict markers in a number of files.  However, some of these are
> unexpected, conflicts in files that I've not and which I'd expect to
> merge cleanly.  For example
> 
>     diff --git a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
>     index 2975291..fea24ba 100644
>     --- a/Documentation/DocBook/Makefile
>     +++ b/Documentation/DocBook/Makefile
>     @@ -2,15 +2,21 @@ ###
>      # This makefile is used to generate the kernel documentation,
>      # primarily based on in-line comments in various source files.
>      # See Documentation/kernel-doc-nano-HOWTO.txt for instruction in how
>     -# to ducument the SRC - and how to read it.
>     +# to document the SRC - and how to read it.
>      # To add a new book the only step required is to add the book to the
>      # list of DOCBOOKS.
> 
>      DOCBOOKS := wanbook.xml z8530book.xml mcabook.xml videobook.xml \
> 		kernel-hacking.xml kernel-locking.xml deviceiobook.xml \
> 		procfs-guide.xml writing_usb_driver.xml \
>     +<<<<<<< .merge_file_arWYZk
> 		kernel-api.xml journal-api.xml lsm.xml usb.xml \
> 		gadget.xml libata.xml mtdnand.xml librs.xml rapidio.xml
>     +=======
>     +           kernel-api.xml journal-api.xml lsm.xml usb.xml \
>     +           gadget.xml libata.xml mtdnand.xml librs.xml rapidio.xml \
>     +           genericirq.xml
>     +>>>>>>> .merge_file_G8cSmh
> 
> We have a spelling fix and the addition of genericirq.xml.  What would
> cause these sorts of conflicts?  Is there someting I can do to
> eliminate them or resolve them properly?

Well, the spelling fix was already merged properly. I can't tell why it 
thinks it conflicted on the addition of genericirq.xml, but it _looks_ 
like you may have done some whitespace changes. The merge result seems 
obvious (pick the second hunk, possibly editing the whitespace to match).

If you wonder why a merge clashes, and you want to see what both branches 
did, see the email thread a few days ago called "A note on merging 
conflicts" on how to efficiently and easily see what the changes were in 
both branches.

			Linus
