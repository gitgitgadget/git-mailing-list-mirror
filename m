From: Jon Nelson <jnelson-git@jamponi.net>
Subject: Re: Fixing author/email fields in commit messages
Date: Sun, 19 Feb 2006 17:34:17 -0600 (CST)
Message-ID: <Pine.LNX.4.63.0602191729100.6352@gheavc.wnzcbav.cig>
References: <43F8BCB1.2010701@gmail.com> <Pine.LNX.4.63.0602191634480.6352@gheavc.wnzcbav.cig>
 <Pine.LNX.4.63.0602191651340.6352@gheavc.wnzcbav.cig> <43F9005E.30901@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 00:34:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAy4N-0006Rx-Hu
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 00:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWBSXeU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 18:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWBSXeU
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 18:34:20 -0500
Received: from mxsf33.cluster1.charter.net ([209.225.28.158]:43144 "EHLO
	mxsf33.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932409AbWBSXeU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 18:34:20 -0500
Received: from mxip34a.cluster1.charter.net (mxip34a.cluster1.charter.net [209.225.28.249])
	by mxsf33.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id k1JNYI9u023301
	for <git@vger.kernel.org>; Sun, 19 Feb 2006 18:34:18 -0500
Received: from 24-183-46-83.dhcp.mdsn.wi.charter.com (HELO turnip.jamponi.pvt) ([24.183.46.83])
  by mxip34a.cluster1.charter.net with ESMTP; 19 Feb 2006 18:34:19 -0500
Received: by turnip.jamponi.pvt (Postfix, from userid 1000)
	id 1410EC09E; Sun, 19 Feb 2006 17:34:18 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by turnip.jamponi.pvt (Postfix) with ESMTP id 06000C09D
	for <git@vger.kernel.org>; Sun, 19 Feb 2006 17:34:18 -0600 (CST)
In-Reply-To: <43F9005E.30901@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16461>

On Mon, 20 Feb 2006, Jacob Kroon wrote:

> Jon Nelson wrote:
> 
> > >I modified git-convert-objects to perform just that task.
> > >I'll see if I can dig it up (I'm not able to do so right now).
> > >    
> > >
> >
> >Attached. Notes:
> >
> >1. it's ugly
> >2. it's indented funny
> >3. it didn't seem to break anything for me, but no guarantees
> >4. it probably smells of elderberries
> >5. set your GIT_* environment up properly first or you'll wonder why it
> >doesn't work like I did.
> >
> >  
> >
> Hi Jon,
> 
> I've applied your patch to the latest git sources, and it compiles, but I'm
> not quite sure how to
> invoke the command. I've setup GIT_* env. variables, and git-convert-objects
> needs a sha1 identifier.
> I've tried passing "HEAD", and some other commit id's, but they don't seem to
> make any difference.
> Am I doing things right ? How exactly do I invoke the command to clean up the
> commit messages ?
> 
> At least I don't get any error messages.

If I recall properly, it should be sufficient to invoke it with the sha1 
of the HEAD branch.  

Thus, you could use:

git-convert-objects $(git-rev-list --max-count=1 HEAD)

To do /all/ of the branches:

for branch in $(cat .git/refs/heads/* | sort | uniq); do
  git-convert-objects ${branch}
done

It should work on tags, too, although I only tested on my own git stuff 
which was converted from cvs.

--
Jon Nelson <jnelson-git@jamponi.net>
