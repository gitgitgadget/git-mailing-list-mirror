From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Segfault in xdl_merge is back
Date: Tue, 26 Dec 2006 22:49:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612262245250.4473@woody.osdl.org>
References: <20061227041644.GA22449@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 07:49:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzSbf-0004LO-ID
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 07:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbWL0Gte (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 01:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbWL0Gte
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 01:49:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34082 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932934AbWL0Gtd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 01:49:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBR6nO2J019689
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Dec 2006 22:49:25 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBR6nNTQ003599;
	Tue, 26 Dec 2006 22:49:24 -0800
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061227041644.GA22449@spearce.org>
X-Spam-Status: No, hits=-0.657 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.165 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35446>



On Tue, 26 Dec 2006, Shawn Pearce wrote:
> 
> I'm suspecting this is actually some sort of memory corruption in
> the heap (due to a bad malloc/free) as the bug seems to rear its
> head only based on the data we are allocating/have allocated.

Can you try to reproduce it under Linux and use "valgrind" to run the 
thing that SIGSEGV's? That tends to be a pretty good way to debug bad 
allocations..

So instead of bisecting it on cygwin, try to use the build that broke on 
Linux too (ie undo the 5caf9232 "fix") and when you can reproduce it under 
Linux, compiel withour -O2 and with debug information, and gdb will be a 
lot more useful, but also run it with valgrind..

		Linus
