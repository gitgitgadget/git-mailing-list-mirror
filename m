From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: More Beginning Git Questions
Date: Sat, 24 Sep 2011 18:59:52 -0400
Message-ID: <201109242259.p8OMxqIM026259@no.baka.org>
References: <4E7C9AAD.7060209@gmail.com> <m3ipojqhpm.fsf@localhost.localdomain> <4E7CCCA0.50909@gmail.com> <14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net> <op.v2byz2p80aolir@keputer.lokaal>
        <1m2c90ds9e46c.7agk88pbgjl8$.dlg@40tude.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: tactical <a5158017@nepwk.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 01:07:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7bJT-0001gG-EK
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 01:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664Ab1IXXGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 19:06:49 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:42944 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522Ab1IXXGs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 19:06:48 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Sep 2011 19:06:48 EDT
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id p8OMxqkL012639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 24 Sep 2011 18:59:53 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id p8OMxqIM026259;
	Sat, 24 Sep 2011 18:59:52 -0400
In-reply-to: <1m2c90ds9e46c.7agk88pbgjl8$.dlg@40tude.net>
Comments: In reply to a message from "tactical <a5158017@nepwk.com>" dated "Sat, 24 Sep 2011 23:17:35 +0100."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182049>


In message <1m2c90ds9e46c.7agk88pbgjl8$.dlg@40tude.net>, tactical writes:

    Frans Klaver wrote:

    >> Mercurial allows this, and it's a very powerful feature.  After reading
    >> this thread, I could not believe Git didn't pulling with local changes,
    >> and so I tried it, and also asked on IRC -- and it seems that Git really
    >> doesn't.
    >
    > Git doesn't do it implicitly. Be explicit about it
    >
    > $ git stash
    > $ git pull
    > $ git stash pop
    >
    > seems to do exactly what you want.

    Does popping the stash allow for a three-way merge?  If not, this doesn't
    really solve the problem.

As I explained on IRC, you can use the following workflow to create a
three way merge.

git stash
git fetch
git merge @{u} stash
git mergetool
git stash drop

You can then do whatever other work you want.  You can repeat this
workflow as often as you want.  When you are done, then you can
commit:

git commit -a -m "My important work"

This is of course easily scriptable so it becomes one command to you.
And since you mentioned it, if the merge went poorly and you wanted to
start over (only before you dropped the stash of course), you can:

git reset --hard HEAD
git merge @{u} stash

And then continue with the rest of the workflow above.


Of course, I would recommend you consider some of the more gitish
workflows.  Commit early and often.  `git pull --rebase` as often as
you want, and then use `git rebase -i @{u}^` to squash all of your
in-progress commits together.  With appropriate in-progress commit
message crafting, you can use the --autosquash functionality of
git-rebase to make this process easier.

					-Seth Robertson
