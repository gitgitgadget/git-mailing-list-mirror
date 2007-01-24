From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Wed, 24 Jan 2007 10:18:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701241012030.3606@woody.linux-foundation.org>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <eovccc$usc$1@sea.gmane.org>
 <Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17846.20498.635623.173653@lisa.zopyra.com>
 <Pine.LNX.4.64.0701231157430.32200@woody.linux-foundation.org>
 <45B79D68.6040200@greenwoodsoftware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Nudelman <markn@greenwoodsoftware.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 19:21:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9mjy-0000XA-BF
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 19:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbXAXSUu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 13:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbXAXSUu
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 13:20:50 -0500
Received: from smtp.osdl.org ([65.172.181.24]:48692 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbXAXSUt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 13:20:49 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0OIItpa019801
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 Jan 2007 10:18:55 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0OIIqVP023828;
	Wed, 24 Jan 2007 10:18:53 -0800
In-Reply-To: <45B79D68.6040200@greenwoodsoftware.com>
X-Spam-Status: No, hits=-1.152 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.171 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37665>



On Wed, 24 Jan 2007, Mark Nudelman wrote:
>
> The first issue that you mention (that we move to the bottom of the screen
> before printing the first line) is behavior that has always existed in less.
>
> BTW, this issue is documented as enhancement request #112 at
> http://www.greenwoodsoftware.com/less/bugs.html.

I don't dispute that the "move to the bottom of the screen" is probably a 
good feature in general, but it is _not_ a good feature when -F is in 
effect (similar to the init/exit sequence being a horrible thing to do 
when -F is in effect).

So the problem is that it basically makes -F largely useless.. The whole 
_point_ of anybody using -F is that it turns off the "pager" feature for 
small output that fits on a page, wouldn't you say?

(The reason the init/exit sequence doesn't mix with -F is that many 
terminal descriptions basically have a "switch to secondary screen" for 
init, and "switch back" for exit, which means that together with -F, small 
output simply won't be shown at all - or perhaps it just flickers too 
quickly for the user to see it).

So this really is only a -F issue.

Now, for the init/exit sequence, at least we have -X to turn that off (and 
git does indeed default to using "FRSX" if the user doesn't have any LESS 
environment variable set), so perhaps the "move to end of screen" could 
also get another flag? That way it would be something that users can 
control - but see above on why I pretty much guarantee that anybody who 
uses -F would want to use the new flag too.

> Your second issue is definitely a bug.  Less's handling of -F and eof in
> general is indeed rather baroque and confusing, and probably needs a complete
> revision.  Some of the complexity comes from being portable to many (not
> necessarily Unix-like) systems.

Yeah, I tried to look at the sources, and ran awya screaming ;)

		Linus
