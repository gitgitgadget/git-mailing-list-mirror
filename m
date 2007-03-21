From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Rename handling
Date: Wed, 21 Mar 2007 01:25:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703210120230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
 <45FED31B.8070307@midwinter.com> <200703191903.20005.andyparkins@gmail.com>
 <45FEE2B2.6050904@midwinter.com> <etpson$qih$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 01:26:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HToeb-0000y7-34
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 01:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932854AbXCUAZq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 20:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbXCUAZq
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 20:25:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:54924 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752284AbXCUAZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 20:25:44 -0400
Received: (qmail invoked by alias); 21 Mar 2007 00:25:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp011) with SMTP; 21 Mar 2007 01:25:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9LBdUUqL9UCiotlmqzV7mxSBcbq0EuSmIu22uDw
	LzlxWJAA7sk1wu
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <etpson$qih$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42770>

Hi,

On Wed, 21 Mar 2007, Jakub Narebski wrote:

> Steven Grimm wrote:
> 
> > The following is actually my biggest beef with git's rename tracking, 
> > and it has nothing whatsoever to do with git-log (though I agree git-log 
> > needs to track renames too):
> > 
> > $ ls
> > dir1
> > $ ls dir1
> > file1 file2 file3
> > $ echo "#include file1" > dir1/file4
> > $ git add dir1/file4
> > $ git commit
> > $ git pull
> > $ ls
> > dir1 dir2
> > $ ls dir1
> > file4
> > $ ls dir2
> > file1 file2 file3
> > 
> > That's just plain broken in my opinion. One can perhaps contrive a test 
> > case or two where that's the desired behavior, but in the real world it 
> > is almost never what you actually want.
> > 
> > By the way, I don't think fixing that is necessarily related to how 
> > renames get detected, so in some sense it's a different bug report / 
> > feature request than the rename hints one. It would be possible to 
> > figure out the directory had been renamed based purely on content 
> > analysis; a bunch of files all individually renamed to the same places 
> > under a new directory, and a lack of any files at all left in the old 
> > one, probably means the directory got renamed. The content-based rename 
> > detector could handle this case.
>  
> Actually this came out in some earlier talk about recording renames 
> and renames detection (IIRC in the big thread about VCS comparison which
> used to be on Bazaar-NG wiki). And one of the arguments about why directory
> rename doesn't work as _you_ expected is (beside that it is not that
> easy to code) the fact that the alternate solution (new files going
> to old subdir) can be correct and expected by _others_.

By now, there have been enough arguments _for_ automatic rename detection, 
but I'll add another one.

A colleague of mine worked on a certain file in a branch, where he copied 
the file to another location, and heavily modified it. He did that in a 
branch, and when he was satisfied with the result, he deleted the old 
file, since he liked the new location better.

Now, when I pulled, imagine my surprise (knowing the history of the file), 
when the pull reported a rename with a substantial similarity!

So, the automatic renamer did an awesome job.

Ciao,
Dscho

P.S.: It would be so nice if somebody (preferably someone who previously 
thought manual renames were a pretty clever thing) to write up the 
arguments, and add that to the "why automatic renaming?" section of the 
FAQ...
 
