From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 09:56:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 18:56:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HArmy-0002AO-Fq
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 18:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbXA0R40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 12:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbXA0R40
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 12:56:26 -0500
Received: from smtp.osdl.org ([65.172.181.24]:58227 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304AbXA0R4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 12:56:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0RHuI1m015202
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 Jan 2007 09:56:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0RHuHGH013526;
	Sat, 27 Jan 2007 09:56:18 -0800
In-Reply-To: <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.505 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37977>



On Sat, 27 Jan 2007, Linus Torvalds wrote:
> 
> Here's a patch. Use "git blame --incremental filename" to get the blame 
> output in a nicely parseable format that you can now write a simple 
> graphical viewer for. 

Btw, the more I play with this, the more I curse the fact that I don't 
know tcltk enough to actually enjoy the full effect.

But in the kernel, with the patch I just sent out, try

	PAGER= git blame -C --incremental block/ll_rw_blk.c

(because using a pager for the output just detracts from the whole 
experience.

I think it's really cool how it notices the chunks coming in from the 
rename, and starts giving different names - and for some reason I didn't 
delve into it actually seems to find some of the changes from the old 
location before it have pinpointed all of the changes from the new one 
etc..

(That's a fairly expensive file to check, so it takes almost ten seconds 
for me to generate blame for. But with the incremental output, you really 
don't mind, because it finds the "new changes" immediately, so it's really 
the old and relatively uninteresting stuff that will only be found at the 
end).

This should be an example of how important interfaces can be to what feels 
"slow".

Btw, Junio - even if nobody writes a graphical front-end for that 
"--incremental" flag, this should be in 1.5.0. If only so that people 
could write those front-ends and not have to patch git to get the blame 
information out of it.

The exact format for the output of this thing is obviously very debatable: 
it might well be worthwhile to use a more verbose thing that also gives 
the commit name and date etc information (since git-blame knows it), so 
that any graphical front-end doesn't need to look up every commit as it 
comes out of the incremntal blame engine. I just wrote it as a quick 
"proof of concept" thing, and the output is obviously pretty minimalistic 
right now.

		Linus
