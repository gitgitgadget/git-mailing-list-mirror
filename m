From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Unable to clone an ssh repository (with ugly installation-specific
 workaround)
Date: Tue, 12 Feb 2008 10:30:01 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802121028290.3870@racer.site>
References: <51419b2c0802111822k4600e06bp4167a09b30bf947a@mail.gmail.com> <m31w7iegk6.fsf@localhost.localdomain> <47B15ADC.8080309@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 12 11:30:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOsPM-0005rX-NR
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 11:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761770AbYBLK3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 05:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761169AbYBLK3z
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 05:29:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:59838 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761653AbYBLK3y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 05:29:54 -0500
Received: (qmail invoked by alias); 12 Feb 2008 10:29:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 12 Feb 2008 11:29:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18faulvf3cf2iAWm0oxxU0eK4fyNmKglGXf8jyUE2
	MLNpQ0ATNm2f7E
X-X-Sender: gene099@racer.site
In-Reply-To: <47B15ADC.8080309@viscovery.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73649>

Hi,

On Tue, 12 Feb 2008, Johannes Sixt wrote:

> Jakub Narebski schrieb:
> > "Elijah Newren" <newren@gmail.com> writes:
> > 
> >> I'm pretty sure this worked before, but with git-1.5.4, when trying 
> >> to clone a repository via ssh from a machine that does not have git 
> >> installed in a standard system path, I get the following:
> >>
> >> $ git clone -u /home/enewren/software/install/linux/git/bin/git-upload-pack
> >> ssh://enewren@remote/var/scratch/enewren/votd
> >> Initialized empty Git repository in /home/newren/devel/votd/.git/
> >> remote: fatal: exec pack-objects failed.
> > 
> > git-pull(1)
> > [...]
> >        --upload-pack <upload-pack>
> >               When  given,  and  the  repository  to  fetch from is handled by
> >               git-fetch-pack, --exec=<upload-pack> is passed to the command to
> >               specify non-default path for the command run on the other end.
> > 
> 
> The OP *did* use this option (rather, its short form, -u), see above.
> 
> The problem is that git-upload-pack (which is not a built-in) does not
> call setup_path() and so does not extend PATH to contain the special
> installation location. Now, when git-upload-pack tries to exec
> git-pack-objects, it fails since this is not in PATH.

So, let's make git-upload-pack a builtin, no?

> A quick work-around for Elijah is to add
> 
>    GIT_EXEC_PATH=/home/enewren/software/install/linux/git/bin
> 
> to .profile on the remote host.

I guess you meant .bashrc, as .profile is not sourced when using ssh 
transport (it does not spawn a shell) AFAIR.

Ciao,
Dscho
