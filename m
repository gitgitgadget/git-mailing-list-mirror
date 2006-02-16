From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Fake linear history in a deterministic manner.
Date: Fri, 17 Feb 2006 12:29:13 +1300
Message-ID: <46a038f90602161529r6e1855a5l41a2dbfdea7ee2a0@mail.gmail.com>
References: <46a038f90602121746v5adb448ej73cc2be6dd3745ce@mail.gmail.com>
	 <20060216222956.GA5818@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Feb 17 00:31:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9sb8-0002xd-Pt
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 00:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWBPXbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 18:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWBPXbj
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 18:31:39 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:41016 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932518AbWBPXbj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 18:31:39 -0500
Received: by wproxy.gmail.com with SMTP id i34so13179wra
        for <git@vger.kernel.org>; Thu, 16 Feb 2006 15:31:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eNttkfBfpsszzN4jht5Q+sUL+Ut6fVXhg6uqTHI+O6euOglXeXH4cKMi2fz0CpSP26rS1JOSPMmUQbIemlCIlIOj6ian57aUU57AqJKQQtMXtcYl3lqarbXup/FIM/saWQPAiZSvKEOxy+Zxd8L+d/9rXzkclA5Z7t1XteoHMpQ=
Received: by 10.54.66.12 with SMTP id o12mr320760wra;
        Thu, 16 Feb 2006 15:29:14 -0800 (PST)
Received: by 10.54.71.8 with HTTP; Thu, 16 Feb 2006 15:29:13 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060216222956.GA5818@Muzzle>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16316>

On 2/17/06, Eric Wong <normalperson@yhbt.net> wrote:
> Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > To emulate `cvs log somepath` I need to munge history to look linear.
> > I am working on the theory that I will tell the cvs client about *one*
> > linear history, and show merges from parallel histories as a merge
> > commit, "flattened" so to speak, and with a commit message where I'll
> > list the hash and first line of each commit that it involves.
>
> I'd be interested in exporting from git to SVN with something like this.

We're hoping to release the code soon, but the truth is that it's
really trivial. It was more agonizing over the fact that there's no
"good" (aka "stable") algorithm for this.

> > I thought briefly about delaying the decision until I see the merge,
> > and pick the leftmost, or rightmost, if there is some bias in
> > git-merge or cg-merge on putting whatever origin has on a particular
> > side. It'd mean running backwards through history and that the very
> > last merge can flip the decision entirely. Hmmm... any strategy I can
> > come up with means that each new merge throws the dice again entirely.
> >
> > Ideas?
>
> I'd actually like to do this interactively in gitk.  Just browse history
> visually and pick the path you want to choose each time there's a merge,
> and then having it output the revisions to stdout or saved to a file
> after you're done picking.  Ideally you'd be able to use saved output
> interactively, as well.

It's cool to be able to pick, but if it's for a git-svnserver
implementation, you can't change your (fake) history you tell after
clients have seen. So a merge that gets pushed to the repo later may
contain more interesting paths, but you're bound to the lies you've
told.

cheers,


martin
