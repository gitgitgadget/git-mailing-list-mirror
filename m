From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bootstraper for Git Dev Environment for Windows (Light version)
Date: Sun, 5 Aug 2007 13:27:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708051252130.14781@racer.site>
References: <2B8D8540264E4205BD1E4605770422BF@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mike Pape <dotzenlabs@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <J.Sixt@eudaptics.com>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 14:28:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHfDT-0006ue-Ho
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 14:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738AbXHEM2M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 08:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755876AbXHEM2M
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 08:28:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:54596 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755681AbXHEM2L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 08:28:11 -0400
Received: (qmail invoked by alias); 05 Aug 2007 12:28:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 05 Aug 2007 14:28:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0kRZnzOy0hVk7tZA5JtWa3Z2MDVpVOKnLW8TUWW
	G8iAqG4fv8nFjy
X-X-Sender: gene099@racer.site
In-Reply-To: <2B8D8540264E4205BD1E4605770422BF@ntdev.corp.microsoft.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55008>

Hi Dmitry,

[Mike, Marius and Hannes Cc:ed, since I reference their work]

On Sun, 5 Aug 2007, Dmitry Kakurin wrote:

> Please give it a try and tell me how it works for you:
> http://msysgit.googlecode.com/files/GitMe-1.exe (1.6 MB)

That file size is intriguing...  And I think you are on a good idea here.  
Yesterday I was a bit negative, but after sleeping over it, I think that 
you have a point there.

Some comments:

- It works very well!  Good job.

- we can have this bootstrap installer, the full package, snapshots 
  (Marius had this idea, and is probably going to install some cron job 
  of some sort or other), and an installer without the development 
  environment (code name WinGit?) for the end user.

- How about calling your package msysGit-netInstall-<version>.exe?

- I'd like to have the full package, too...

	- Partly for size reasons (msysGit.exe is an almost self-contained 
	  19MB package, while the pack in the repository is something like 
	  40 MB).  But in this sense, I would have to include the pack for 
	  mingw.git as well...  Still, on dial-up, 40MB or 60MB makes a 
	  difference, no?

	- Partly because I do not like net installers myself... I like to 
	  download a big installer and be done with it.

- There is one big caveat with your bootstrapper: things have been known 
  to break, and I think msysgit.git is no exception.  So I'd like to have 
  a fallback in case things go awry, also to have something that is tested 
  (for example, Mike tested msysGit-0.4.exe before releasing it).  Of 
  course, we could solve that issue by branching off of the last release 
  tag.

- I agree, though, that your approach is more convenient for us.

- Your work is very valuable: it is the first step towards WinGit, because 
  you already identified some parts that are necessary to run git.

- AFAICT it is possible to make nicer installers with 7-Zip, and also 
  smaller ones, and most importantly (for me), you can script it.  See for 
  example the script release-msysGit.sh which resides in /bin in 
  msysgit.git.  It's a hands-free no-hassle installer maker.

- my idea is to turn /git into a subproject, but I want to make sure 
  first, that it works, and that a transition is-subdirectory -> 
  is-submodule goes smooth.  (There is one more submodule that will be 
  nice to have in msysgit.git... a shell extension similar to TortoiseCVS 
  is finally gathering way... stay tuned!)

- I wanted to hold off a little, until Hannes can apply the fix-up patch 
  we need in mingw.git.  Because when he does, your bootstrap will run 
  into problems...

> If we want to stick with this installer here is what we need to do:
> * Remove /git directory from msysGit.git
> * Bring mingw.git up to date so we can remove patching step from installer

Sounds like a plan.  Hannes? (I know that Hannes was/is in holiday...)

> To repack just use any compressor that can create SFX archives that can 
> also start a file execution. I've used WinRAR. But the whole idea is 
> that this bootstrap download should require very little/no tweaking. All 
> changes should happen in msysgit.git and mingw.git.

Like I said, I prefer 7-Zip (if only because it is Open Source).  It would 
be nice to have insight in how you went about to identify what is needed?

Eventually, I'd like to have a script which creates that installer, in 
msysgit.git...

Ciao,
Dscho
