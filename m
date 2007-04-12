From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-branch, older repos and more confusion
Date: Thu, 12 Apr 2007 17:05:24 +1200
Message-ID: <46a038f90704112205g53ab4750s673f449ee40165b4@mail.gmail.com>
References: <46a038f90704112114t520374b2qea4f860575c21bce@mail.gmail.com>
	 <20070412042308.GA22539@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 07:05:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbrUu-0003tp-Jv
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 07:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030694AbXDLFFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 01:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030716AbXDLFFZ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 01:05:25 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:42630 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030694AbXDLFFY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 01:05:24 -0400
Received: by wx-out-0506.google.com with SMTP id h31so441339wxd
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 22:05:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PEYCFFvogvHjQasYyJA7h4nULBqp864TTMCilxiCWnVPO4RY9gRy8zFgQG+ghF/c1cwyLUUvrr+D1fmfMZCirI4ZMw4JTjGRo7ALrp5zw0y0T3BbB17M7WjBxzqtH4zaGqPRB9NgLYRlJLwx2ABi/xxkNQOxG8LoVMs2WIgbd8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KdUcwjXufmeIur+Zg6CVc9eJ38eu1juUCiHL44iiSqA2wTgRG4AtiNm/n/156EQZq+1Lh2M2Hpz45hSFTc/3cCGrpbLeTC14vIBpeSyGLV3APfdw62kR58uHXY4m5kMiIz6oqukYDPaQ8DU+hu/CBz/FvoZWWSWCGGNAnlH/xqs=
Received: by 10.90.25.3 with SMTP id 3mr1341457agy.1176354324047;
        Wed, 11 Apr 2007 22:05:24 -0700 (PDT)
Received: by 10.90.120.11 with HTTP; Wed, 11 Apr 2007 22:05:24 -0700 (PDT)
In-Reply-To: <20070412042308.GA22539@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44320>

On 4/12/07, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 12, 2007 at 04:14:06PM +1200, Martin Langhoff wrote:
>
> > My git tracking repo is still using the .git/remotes/origin
> > infrastructure, and now it turns out I can't seem to do a git-pull and
> > then a git-format-patch of my local 'master' for patches to go on top
> > of junio's master. I am using 1.5.1.106.ga32037
>
> What doesn't work? IIRC, you might have some problems with doing a
> 'pull' with no parameters, since you don't have the right magic in
> .git/config. Have you tried an explicit "git-pull origin master"?

Sorry - I should have been clearer here... what I can't seem to do is
git-format-patch origin/master..master - but I've resolved that.

> > Alas - I think support for it seems to be going the away... what I am
> > missing is a clear way to say git-clone <repo>#branch that has the
> > same properties that `cg-clone <repo>#branch` has. Namely, once you
> > are done, there are clear names for your "local tip" and "remote tip",
> > and push and pull do the right thing without extra params.
>
> I don't think there is a way to clone _just_ that branch, but if you're
> OK with fetching all of the branches, then you should be able to do
> just:
>
> git-clone <repo>
> git-branch --track branch origin/branch
> git-checkout branch

True - that's the hint you gave me yesterday. It doesn't work on 1.4.x
or 1.5.0 either. Requires 1.5.1+, which is a bit awkward -- I can (and
will) move my team to using this, but we have git installs we don't
control directly, like external collaborators, remote servers where we
use git to manage deployments, etc.

Which means I'll have to write a little list that goes "if your git is
version X, do this, if it's version Y do that". :-(

> Yours is 'branch' and remote is 'origin/branch'. If that branch is
> master, then I believe git-clone should set you up already (and you can
> even still refer to 'origin', which is a synonym for origin/HEAD).
>
> Or am I not understanding your problem?

No. You're spot on. Using this trick however, a few idioms that used
to work for us don't quite work anymore.

For example, creating a new "custom" branch on the repo used to be
trivial and left us with a setup that was simple and safe. For
example, if you wanted to work on a custom v1.9:

 - cg-clone <repo>#v1.9-maint mydir
 - cd mydir
 - cg-branch-chg origin <repo>#1.9-clientname
 - cg-push     ## this creates the new head on the repo
 - cg-branch-add v1.9-maint <repo>#v1.9-maint mydir

and from there onwards cg-update / cg-push worked on the custom
branch, and cg-update v1.9-maint would merge from the maint branch.

Any hints as to how to run such workflow on v1.5.x?

cheers,



m
