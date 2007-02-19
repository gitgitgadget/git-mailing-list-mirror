From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Publishing Question: First time Pushing to nonexsiting directory
Date: Mon, 19 Feb 2007 03:10:10 -0500
Message-ID: <20070219081010.GC30030@spearce.org>
References: <20070219073526.GA26531@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon Feb 19 09:10:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ3bJ-0000nT-GI
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 09:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbXBSIKQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 03:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbXBSIKQ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 03:10:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53654 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbXBSIKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 03:10:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJ3b9-0002aj-6o; Mon, 19 Feb 2007 03:10:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 69A0520FBAE; Mon, 19 Feb 2007 03:10:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070219073526.GA26531@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40103>

Thomas Glanzmann <thomas@glanzmann.de> wrote:
> I thought that there is a command available which I can use to push a
> repository to a remote nonexisting location (that gets created on the
> fly) like in the following scenario:
> 
>         - Create a git project on my laptop
>         - Check in a few files
>         - Publish the git repository to 
> 
>         (thinkpad) [~/work/astro-tg] git push 131.188.30.59:/home/cip/adm/sithglan/work/repositories/private/astro/
>         fatal: '/home/cip/adm/sithglan/work/repositories/private/astro': unable to chdir or not a git archive
>         fatal: The remote end hung up unexpectedly
> 
> I thought that I read a comment from Linus(?) long time ago to how to obtain
> that. But I am unable to find the e-mail in my archives. If there is no
> standard way, how do you do it? Just rsync the files and change the
> 'origin'?

SSH into the remote system that you want to push to, then run
init-db there:

  $ ssh 131.188.30.59 git --git-dir=/home/cip/adm/sithglan/work/repositories/private/astro.git init-db

Configure that as a remote, e.g. origin:

  $ git remote add origin 131.188.30.59:/home/cip/adm/sithglan/work/repositories/private/astro.git

Now push to there:

  $ git push origin master:master

And maybe fetch back to create the tracking branches:

  $ git fetch


Note that in my examples above I added ".git" to the end of the
repository path, as this is rather typical for a 'bare repository'
(that is, a repository without a working directory attached).
You usually don't want to push into a repository with a working
directory, but it is supported and a lot of folks do it.

I also assumed Git 1.5.0 on your thinkpad end, as git-remote was
recently added in that version.  Handy tool.  :)

-- 
Shawn.
