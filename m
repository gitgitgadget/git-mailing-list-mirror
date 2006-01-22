From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What is in git.git
Date: Sun, 22 Jan 2006 15:26:27 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601221512470.25300@iabervon.org>
References: <7v3bjiuhxb.fsf@assigned-by-dhcp.cox.net> <200601211636.02340.lan@ac-sw.com>
 <7vek31mkyg.fsf@assigned-by-dhcp.cox.net> <200601220033.26321.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0601221106330.25300@iabervon.org> <7vu0bwdo08.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 21:24:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0llF-0000PK-E4
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 21:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWAVUY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 15:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWAVUY1
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 15:24:27 -0500
Received: from iabervon.org ([66.92.72.58]:61196 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750914AbWAVUY0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2006 15:24:26 -0500
Received: (qmail 5180 invoked by uid 1000); 22 Jan 2006 15:26:28 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jan 2006 15:26:28 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0bwdo08.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15059>

On Sun, 22 Jan 2006, Junio C Hamano wrote:

> I have been thinking about this one, and having read that
> read-cache code I think the coding is not too involved.
> 
> My current inclination is to use the same version number (2) by
> default and promote it to a new version number (3) once you add
> subproject-binding information to the index file.  Then current
> tools would keep working on repositories created or operated
> upon with the new tools, as long as the project does not use the
> new feature.

I think bumping the index file version number shouldn't be too big a deal; 
index files are rarely used by different versions, except for the case 
where you've installed a new version of git, and that's generally a later 
version, not an earlier one.

It might make sense to add logic to make the stable series accept version 
3 files without special entries, though. And maybe future-proof by having 
it look for unexpected flags and give a "too new version" error for them, 
even if the version number is within range. (I.e., if we add more special 
entry types later, it would tell you if your index file uses a feature 
that the version of git you're using doesn't support, even if the version 
number hasn't changed, and we reserve changing the version number for 
things where the file wouldn't read right at all or something previously 
legal changes meaning.)

On a side topic, is there any reason not to convert ls-tree to use struct
tree, and kill the other tree-object-parsing code, which doesn't seem to 
be used by anything else?

	-Daniel
*This .sig left intentionally blank*
