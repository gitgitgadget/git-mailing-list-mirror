From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Newbie using git -- need a little help
Date: Sun, 17 Jun 2007 22:30:46 +0200
Message-ID: <20070617203046.GG21291@cip.informatik.uni-erlangen.de>
References: <2218.85747.qm@web57401.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Robert Smith <wolf1boy79@yahoo.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 22:30:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I01Ob-00045w-En
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 22:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760727AbXFQUas (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 16:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760710AbXFQUas
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 16:30:48 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:55410 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760661AbXFQUar (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jun 2007 16:30:47 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 69DB33F438; Sun, 17 Jun 2007 22:30:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2218.85747.qm@web57401.mail.re1.yahoo.com>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50372>

Hello Robert,

> The /home/cip/adm/sithglan/work/repositories/private/astro.git is
> simply a .git directory located on the "server", and it doesn't
> actually contain any working code (yet), right?

Right.

(faui02) [~/work/repositories/private/astro.git] ls
HEAD  branches/  config  description  hooks/  info/  objects/  refs/  remotes/

> So what this command is doing is telling git where the "origin" is --
> on the remote server, correct?  Also, is the default protocol (since
> all you typed was 131.188.30.102:/.../astro.git) is SSH correct?

The default protocol is git over ssh. And it adds a shorthand called
origin that points to the repository at the server you can now say:

        git push origin
        git pull origin

Since origin is the default, you can also say:

        git push
        git pull

Note when you do a "git clone ip:/path/to/dir.git", git will
automatically set up the reference to origin. You don't have to do it
yourself. In my initial example you had to do it yourself, because at
the time you started with the new project there was no origin because
you just started it.

> I'm a little lost on what 'origin' refers to precisely.  Is origin
> considered the "root" of all the changes (the workspace as it was
> originally before any patches)?  Or is it a location for the working
> files?  You give a definition below in your e-mail but I'm still not
> completely sure what it is referring to.

"origin" is a shorthand for the remote repository. If you say git pull
git fetches the objects that are reference in the remote repository by
the head "master" (by default) and puts that in a local file called
.git/refs/remotes/origin/master:

(faui02) [~/work/blastwave] ls -al .git/refs/remotes/origin/master
-rw-r--r-- 1 sithglan icipguru 41 Jun 14 18:35 .git/refs/remotes/origin/master
(faui02) [~/work/blastwave] cat !$
cat .git/refs/remotes/origin/master
50da5cf500b8b57e32720ffe80fbabaadd7c8c9f

After that it tries to merge that remote head into your local branches
head.  Most of the time that is .git/refs/heads/master

If you type in only "git fetch" it gets the objects but doesn't do any
merging.

So to answer your question. Origin is a copy of the repository you
pull/push by default. The objects of these tree are in your object store
but the actualy HEAD commit object is in the file I "cat" earlier in
this e-Mail.

        Thomas
