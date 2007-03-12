From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] Make gc a builtin.
Date: Mon, 12 Mar 2007 12:14:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703121202560.9690@woody.linux-foundation.org>
References: <11736508181273-git-send-email-jbowes@dangerouslyinc.com>
 <20070312025736.GA28505@thunk.org> <Pine.LNX.4.63.0703121222350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070312133612.GD4372@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:14:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQpyR-0008E5-PL
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbXCLTOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbXCLTOU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:14:20 -0400
Received: from smtp.osdl.org ([65.172.181.24]:37776 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254AbXCLTOU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:14:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2CJE7o4020432
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Mar 2007 12:14:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2CJE4xF011661;
	Mon, 12 Mar 2007 11:14:05 -0800
In-Reply-To: <20070312133612.GD4372@thunk.org>
X-Spam-Status: No, hits=-0.936 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,OSDL_NIGERIAN_GOLD
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42060>



On Mon, 12 Mar 2007, Theodore Tso wrote:
> 
> I'm not sure I understand the portability argument?  All of the
> platforms that git currently supports will handle shell scripts,
> right?  

Git "supports" MinGW, or at least wants to. And yes, you can put bash in 
there, but we'd be *so* much better off if we had no shell scripting at 
all.

Another thing I find annoying (even as a UNIX user) is that whenever I do 
any tracing for performance data, shell is absolutely horrid. It's *so* 
much nicer to do 'strace' on built-in programs that it's not even funny.

It's also sad how many performance issues we've had with shell, just 
because even something really simple (like a few hundred refs) is just too 
slow for shell scripting.

> Heck, git-commit is still a shell script, and that's a rather, ah,
> fundamental command, isn't it? 

Yeah, and that's probably my pet peeve. I'd love to see a built-in "git 
commit" and "git fetch". The "fetch--tool" thing in next gets rid of some 
of the latter (and apparently the worst performance problems), but it's 
sad how we have a really nice builtin "push", but our "fetch" is still 
mostly really hairy shell-code (not just "git-fetch.sh" itself, but 
"git-parse-remote.sh".

A gold star for whoever gets rid of any of of commit/clone/fetch or 
ls-remote

(ls-remote isn't that big or hairy, but I mention it because it's a user 
of "parse-remote", so making even just ls-remote built-in is probably 
going to help with fetch/clone eventually).

		Linus
