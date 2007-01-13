From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 12:17:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701131204511.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
 <7virfct737.fsf@assigned-by-dhcp.cox.net> <slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx>
 <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net> <20070112210403.GB6262@xp.machine.xx>
 <7v7ivrpx9y.fsf@assigned-by-dhcp.cox.net> <20070113093322.GA4825@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 12:17:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5gt9-00027T-7h
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 12:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbXAMLRV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 06:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbXAMLRV
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 06:17:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:43158 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422635AbXAMLRU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 06:17:20 -0500
Received: (qmail invoked by alias); 13 Jan 2007 11:17:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 13 Jan 2007 12:17:18 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Peter Baumann <waste.manager@gmx.de>
In-Reply-To: <20070113093322.GA4825@xp.machine.xx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36749>

Hi,

On Sat, 13 Jan 2007, Peter Baumann wrote:

> On Fri, Jan 12, 2007 at 04:48:09PM -0800, Junio C Hamano wrote:
> > Peter Baumann <waste.manager@gmx.de> writes:
> > 
> > > ? What does it mean to "add" something to a project? It has 
> > > _nothing_ to do ? with "filenames". Yeah, the filename obviously 
> > > exists, but it's not ? something that exists on its own. You add the 
> > > ONLY thing that git tracks. ? ? You add CONTENT. ? ? When you do 
> > > "git add file.c" you aren't adding a filename to the list of ? files 
> > > that git knows about. Not even CLOSE. No. You are really adding ? 
> > > _content_ to the project you are tracking.
> > 
> > Read this again, please.  Ponder it if you may.
> > 
> 
> Yes. I am adding content. And not a file. But at least to me, it makes a
> *BIG* difference if I'm adding totally new content (reserving one more
> bucket where to place to content) or just replacing the content *in* one
> of those already reserved buckets.

Bzzzzt! Nope. "Reserved buckets" as you use it is nothing else than a 
file.

> And that has nothing to do with files (or at least the silly me can't 
> grok it).

Content: a byte stream with a label (so you can find it again). Of 
_course_ you don't want the byte stream vanish in a big black hole, so you 
_have_ to name it.

But git-add actually does two things: it adds a (completely new) object, 
which just holds the byte stream, being named by its content (the hash). 

But when committing, the _existing_ tree object is "updated", by writing a 
_new_ tree object. So, it is not an "updating" in the sense of "editing", 
rather "updating" as in copy-on-write.

So no, there are no "reserved buckets". You are very much _adding_ 
new information.

Another way to look at it: in git, you never "take away" anything. You 
only add things. Even if you remove a file from your working tree, and 
want to commit the change, it means that you _add_ information: The 
information that this file is no longer in the current revision. But the 
commit references the old revision (indeed, the _whole_ ancestry!), in 
which the file _was_ present, so you literally _added_ something _on top_ 
of the old revision.

Hth,
Dscho
