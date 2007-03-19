From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 16:44:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0703191628100.6485@iabervon.org>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
 <45FED31B.8070307@midwinter.com> <alpine.LFD.0.83.0703191427140.18328@xanadu.home>
 <45FEE629.8030606@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, John Goerzen <jgoerzen@complete.org>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:45:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTOj5-0006lm-Bh
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 21:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbXCSUpB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 16:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbXCSUpB
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 16:45:01 -0400
Received: from iabervon.org ([66.92.72.58]:1194 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948AbXCSUo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 16:44:59 -0400
Received: (qmail 8806 invoked by uid 1000); 19 Mar 2007 16:44:57 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Mar 2007 16:44:57 -0400
In-Reply-To: <45FEE629.8030606@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42671>

On Mon, 19 Mar 2007, Steven Grimm wrote:

> Nicolas Pitre wrote:
> > So maybe, just maybe, at the end of the day getting renames right 100% of
> > the time instead of 99% is not such a big thing after all.
> 
> For me personally, that is true -- but I'd still prefer that extra 1%.

I think the discussion of 99% is misleading here. The heuristics aren't 
random; it's not like if you do 2000 renames, you can expect 20 of them to 
be mishandled. What's actually going on is that git will get 100% on 
unambiguous cases; it'll get 100% on slight ambiguities; it'll get 100% on 
mostly clear cases. On the ~2% of cases where the correct result is 
arguable, git will choose differently from you half of the time. If you do 
a rename and have to change most of the lines of the file, git might 
decide that you rewrote it from scratch. On the other hand, you might have 
had an easier time rewriting it from scratch. Even more extreme, if you 
use git-mv to rename a file, and then you totally replace the file with 
some other content, git will treat it as a remove and an add, rather than 
a rename and a total rewrite. But making it a remove and an add is the 
sensible interpretation of the change, anyway.

I'd actually guess that git's analysis is at least as likely to be useful 
as the reference human analysis that the 1% error rate is measured 
against.

	-Daniel
*This .sig left intentionally blank*
