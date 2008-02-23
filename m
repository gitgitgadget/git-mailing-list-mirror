From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 05:07:58 -0800 (PST)
Message-ID: <m3ablrddna.fsf@localhost.localdomain>
References: <200802221837.37680.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chase Venters <chase.venters@clientec.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 14:08:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSu7Q-0006Fz-7W
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 14:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbYBWNIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 08:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbYBWNIE
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 08:08:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:3893 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbYBWNIB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 08:08:01 -0500
Received: by fg-out-1718.google.com with SMTP id e21so569432fga.17
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 05:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=c913X/5jf+fPQ66yJyNAM1I3DLPXfSFLK36YHxWsFaE=;
        b=MAbQJXlfW21A3w/h2PPtSS19pzoyvpt3bvMBV+ZcDHGjqjHNUwLU+WWuBJL4hhB9CfmchiTfnBKGUrHTqtYJNwvhUazHiLVlkwwxs66VLRWR5Tn0vL5W5Ku7XPuX/HvtmdvwNfCOpsuFVWOtcm13J7OTcb8JOPx4bmgbhSiyvkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=F1FxPzzfvmbBrndU97YJ5WebPeimGsByIOSHpJfOTzzJ7xzcuvD/PiZ/oUnLEexkXPbVvvNDhuwQrkpIYUpUfSsVTFZDJ3/Ux+qt+4yxKQQT7M+WYWFfUUAga2XEhrw3mRins8BseQl74SaBroSWQoncTN+LTbz+WAQmFgkN9KI=
Received: by 10.82.175.17 with SMTP id x17mr744359bue.20.1203772079296;
        Sat, 23 Feb 2008 05:07:59 -0800 (PST)
Received: from localhost.localdomain ( [83.8.255.83])
        by mx.google.com with ESMTPS id b30sm4314190ika.11.2008.02.23.05.07.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Feb 2008 05:07:58 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1ND7tdj012652;
	Sat, 23 Feb 2008 14:07:55 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1ND7r12012649;
	Sat, 23 Feb 2008 14:07:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200802221837.37680.chase.venters@clientec.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74819>

[removed linux-kernel list from Cc]

Chase Venters <chase.venters@clientec.com> writes:

> My question is: If you're working on multiple things at once, do you
> tend to clone the entire repository repeatedly into a series of
> separate working directories and do your work there, then pull that
> work (possibly comprising a series of "temporary" commits) back into
> a separate local master respository with --squash, either into
> "master" or into a branch containing the new feature?

Alternate solution is to use multiple working trees (multiple working
directories) with single repository, although it is still a bit
fragile; you should take care to not checkout same branch multiple
times. IIRC when discussing ".git" as a file representing symlink,
there were some discussion on how to improve multiple-workspaces
workflow.
 
> Or perhaps you create a temporary topical branch for each thing you
> are working on, and commit arbitrary changes then checkout another
> branch when you need to change gears, finally --squashing the
> intermediate commits when a particular piece of work is done?

I personally prefer this workflow, but I do not work as a main
contributor nor maintainer of large project.

As to intermediate commits: if you feel the need to interrupt your
work which is not quite ready for final commit, you can either use
"git stash" command, or commit it as WIP commit, then when going back
just "git commit --amend" it.

Moreover, when working on some larger topic, which needs to be split
into individual commits for beter history clarity, and for better
bisectability, you usually rewrite history before submitting
(publishing) your changes. You usually have to reorder commits (for
example moving improvements to infrastructure before commits
introducing new feature), split commits (separating just noticed
bugfix from a feature commit), squash commits (joining feature commit
and its bugfix) etc. You can use "git rebase --interactive" for that,
or one of Quilt-like patch management interfaces for git: StGit (which
I personally use) or Guilt (idea based on mq: Mercurial queues
extension).

[...]

> It seems to me that having multiple working trees (effectively, cloning 
> the "master" repository every time I need to make anything but a trivial 
> change) would be most effective under git as well as it doesn't require 
> creating messy, intermediate commits in the first place (but allows for them 
> if they are used). But I wonder how that approach would scale with a project 
> whose git repo weighed hundreds of megs or more. (With a centralized rcs, of 
> course, you don't have to lug around a copy of the whole project history in 
> each working tree.)

You can always clone using --shared option to set-up alternates; this
way only new objects (new commits) would be stored in the clone. This
of course need for clone and source to be on the same filesystem.

By default git-clone on local filesystem uses hardlinks, so it also
should not be so hard on disk space.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
