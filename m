From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: workflow for working on feature branches and incrementally
 incorporating "master" changes
Date: Fri, 13 Aug 2010 16:38:56 -0400
Message-ID: <AANLkTi=tJ1i6C5WANY0qP1Zz1aa5HBAq7+-Ft4sa=+TE@mail.gmail.com>
References: <AANLkTi=h2MbSKmQk9p6w44WORAa8XzkpF0nBXKOgJ4T1@mail.gmail.com>
	<AANLkTi=vscGSErrV_6xBqmryc1hFqi4bjmyOTVgTLNsS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Chris Mear <chrismear@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 22:39:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok11y-0006Kq-PB
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714Ab0HMUjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 16:39:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59347 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755543Ab0HMUi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:38:59 -0400
Received: by fxm13 with SMTP id 13so2008884fxm.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:38:57 -0700 (PDT)
Received: by 10.239.152.75 with SMTP id u11mr116407hbb.113.1281731936825; Fri,
 13 Aug 2010 13:38:56 -0700 (PDT)
Received: by 10.239.179.5 with HTTP; Fri, 13 Aug 2010 13:38:56 -0700 (PDT)
In-Reply-To: <AANLkTi=vscGSErrV_6xBqmryc1hFqi4bjmyOTVgTLNsS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153492>

Thanks for the explanation Chris! That definitely helps.

> > If you're working on a feature branch by yourself, what is a good
> > workflow for keeping the branch in up-to-date with "master" as you're
> > developing on the feature branch or is this unnecessary? Should you
> > just wait until you want to officially integrate the feature branch
> > into the "master"?
> >
> > We were doing:
> >
> > commit to local feature branch
> > push to remote feature branch
> > ... repeat....
> > rebase from master (occasionally)
> > push to remote
> >
> > but at this point the branches have diverged.
> >
> > We're coming at this from SVN, so we might just be thinking about this
> > the wrong way.
>
> Git's rebase feature is a *very* nice, clean way to keep a feature
> branch up to date with the master branch. But, as you've seen,
> rebasing can make things a bit confusing you need to push that feature
> branch to other people.
>
> I've found that a good rule of thumb is to never rewrite (i.e. rebase)
> branches that have already been shared with others. Of course there's
> nothing impossible or fundamentally bad about pushing rewritten
> branches like this. But, unless people are expecting it to happen and
> know how to deal with it when they pull, it can cause confusion,
> particularly on teams that are just getting acquainted with Git.

Two questions here.

First, the command to rebase based off another branch that is *not*
the upstream branch involves --onto, correct? For example, if I've
been working on branch awesome_feature and I want to rebase using all
the work that's been done in master since my branch was created, would
I use: "git rebase --onto master <upstream_repo_name>"

Secondly, as someone pulling a branch that has been rewritten, do I
use the --force flag: "git pull --force" or will rebasing suffice?

> Instead, if a feature branch is going to be shared with others, and
> it's going to be long-lived, then we keep it up-to-date by merging
> from master every now and again, rather than rebasing.
>
> On the other hand, if I'm working on a feature branch by myself, and I
> haven't shared it with anyone yet, I frequently rebase against master
> to keep things clean. I also use interactive rebase a lot to tidy up
> commits. But as soon as I've shared my branch with the team, I no
> longer do any rebasing/rewriting.
>
> If there are Git wizards on your team, it is true that they may find
> this an inflexible way of working. But I've found it to be a good
> compromise between ease of pulling and maintaining a clean commit
> history.
>
> Chris
