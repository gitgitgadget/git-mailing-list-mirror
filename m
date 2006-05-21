From: Jim Meyering <jim@meyering.net>
Subject: Re: synchronizing incremental git changes to cvs
Date: Sun, 21 May 2006 23:31:57 +0200
Message-ID: <87irnzhxo2.fsf@rho.meyering.net>
References: <87mzdcjqey.fsf@rho.meyering.net>
	<7v3bf3jl15.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 21 23:32:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhvWz-0005Ro-Jm
	for gcvg-git@gmane.org; Sun, 21 May 2006 23:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWEUVb7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 17:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWEUVb7
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 17:31:59 -0400
Received: from mx.meyering.net ([82.230.74.64]:5021 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S964935AbWEUVb6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 17:31:58 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 8497B34AF3; Sun, 21 May 2006 23:31:57 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bf3jl15.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 21 May 2006 11:21:58 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20461>

Junio C Hamano <junkio@cox.net> wrote:
> Jim Meyering <jim@meyering.net> writes:
>> I'd like to develop using git, and have a commit hook mirror the
>> day-to-day changes (tags/commits) made in the git repo to a
>> cvs repository.  The idea is that the only way changes get into
>> the cvs repo is via the git commit hook.
>
> I do not use the automated tools myself, but I sync the day-job
> work in my git repository to CVS at work.  I do not develop with
> CVS but use it merely as a publishing medium.  Although other
> people can make commits into CVS in which case I have to slurp
> the change back into my git repository.
>
>  (0) Bootstrap.  I did use git-cvsimport myself (this repository
...
>  (1) Beginning of the day.  In case other people did work on
...

Thank you for describing the process you use.
However, since I don't have to allow independent cvs commits,
I hope to bend git-cvsexportcommit to my needs.
It already does almost everything I want.

> using git-cvsimport), as I do not offhand know how exportcommit
> works.  The commits on the git side you would want to push back
> are the ones on "master" but not on "origin", which you can get
> from "git rev-list origin..master", so I presume if you feed
> that to exportcommit things all magically work?

I haven't yet tried to restrict the mirroring to commits on a specific
git branch.  So far, in the toy example I'm using to test things,
I have this in .git/hooks/post-commit:

#!/bin/sh
sha1_id=$(git-rev-parse --verify HEAD)
cvsdir=/var/tmp/work-c
cd $cvsdir && GIT_DIR=/var/tmp/git-experiment/work-g/.git \
    git-cvsexportcommit -v -c -p $sha1_id

I'll clean up and post the changes I've made to git-cvsexportcommit
this week.

> By the way, I met Paul a few days ago and he mentioned that you
> have some quick audit results on our code from your evaluation.
> Can we expect fixes or at least pointing-out-problems from you
> sometime soon please?

I'll send one report separately.
