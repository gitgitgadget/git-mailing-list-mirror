From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Show branch information in short output of git status
Date: Wed, 12 May 2010 09:35:38 -0400
Message-ID: <20100512133537.GA28956@coredump.intra.peff.net>
References: <AANLkTikM3B-9wFBuUzwpP2j9FpT34p9yysX-oLg5hZRj@mail.gmail.com>
 <20100505050640.GC8779@coredump.intra.peff.net>
 <AANLkTikDkrNrzPmIhmcBRKtLKV70f4Kp8wTw6I6ctB4O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 12 15:35:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCC6C-0006vr-Lg
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 15:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441Ab0ELNfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 09:35:40 -0400
Received: from peff.net ([208.65.91.99]:49437 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345Ab0ELNfj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 09:35:39 -0400
Received: (qmail 4765 invoked by uid 107); 12 May 2010 13:35:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 12 May 2010 09:35:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 May 2010 09:35:38 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikDkrNrzPmIhmcBRKtLKV70f4Kp8wTw6I6ctB4O@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146948>

On Thu, May 06, 2010 at 02:24:41PM +0200, Knittl wrote:

>  - initial commit is also printed when there is tracking information
> (i still haven't managed to create a situation like that. `git branch
> oldmaster; rm .git/refs/heads/master; git branch master --set-upstream
> oldmaster` will reset branch master to oldmaster (a bug?))

Try:

  git branch oldmaster
  rm .git/refs/heads/master
  git config branch.master.remote .
  git config branch.master.merge refs/heads/oldmaster

That being said, I still get "Initial commit on master". I think that
stat_tracking_branch just gives up if the branch doesn't exist (which
does make some sense). So in practice, I think your original and this
one actually behave the same (sorry, I know that changing it was my
suggestion).

And no, the "--set-upstream" behavior is not a bug. At least not
according to the documentation. ;)

>  - colors to match output of `git branch` (green: current, red: remote)
>  - output format is copy-pasteable, ahead/behind information is in the
> same format as in `git branch -v`

I think it's much nicer, though the colors are a bit much for my liking.
Still, it's configurable, so I don't have to care. :)

>  - branch information is still printed by default, i have to look into
> commandline option parsing first. i was thinking of `git status -v -b`
> (as in `git checkout -b` to mean branch)

You may also want to have a configuration option if it is the output you
prefer all the time (similarly, if you are using "git status -s" all the
time, you might want a config option to make "git status" do what you
want).

> ---------8<----------------
> From 82b4481d38ae0cd62030aeea67160656b7c763e2 Mon Sep 17 00:00:00 2001
> From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
> Date: Tue, 20 Apr 2010 22:40:54 +0200
> Subject: [PATCH] Show branch information in short output of git status

This patch looks OK, but:

  1. I think for the final version you can just squash in part 2/2.

  2. Your patch has wrapped lines which make it impossible to apply
     without fixing up manually. This is a common gmail problem.  See
     the "gmail" section of SubmittingPatches.

-Peff
