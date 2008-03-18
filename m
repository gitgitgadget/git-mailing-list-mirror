From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: git svn rebase horror
Date: Tue, 18 Mar 2008 21:51:10 +0300
Message-ID: <c6c947f60803181151k63e9ce26oca97b36c0d542593@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 21:01:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4Sp-0001jY-E4
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758547AbYCSTpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755724AbYCSTpO
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:45:14 -0400
Received: from rn-out-0910.google.com ([64.233.170.188]:23916 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758536AbYCSTpL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:45:11 -0400
Received: by rn-out-0910.google.com with SMTP id v46so520462rnb.15
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 12:45:10 -0700 (PDT)
Received: by 10.115.58.1 with SMTP id l1mr2234086wak.110.1205866270277;
        Tue, 18 Mar 2008 11:51:10 -0700 (PDT)
Received: by 10.115.111.4 with HTTP; Tue, 18 Mar 2008 11:51:10 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77526>

Hi, list!

Okay, I know I've done it against all recommendations and must face
the consequences.

My repo is created with git svn init -s. My master branch is thus a
clone of "upstream" svn repo trunk.

Couple of weeks ago I branched from master to what I thought would be
a small feature branch. I often use such branches, implement a small
feature there, merge it back to master and delete the branch. This
helps task switching, usually works fine and git svn rebase rarely
conflicts.

When I rose my sight from the code I found that my "small" feature
branch is now +10/-3 KLOC to the master and consists of about 220
commits. I've regularly merged in new changes from the master to my
feature branch, and occasionally cherry-picked an urgent commit or two
from the branch to the master.

Now the dreaded time came when this feature is done and I have to
merge it back to master and dcommit it to svn. I successfully merged
(fast-forward) from branch to master, but, as expected, when I do git
svn rebase it spits conflicts at every third patch.  (Without svn
rebase, svn dcomit would complain that it does not know how to commit
a merge.) From previous encounters I know that to tame that beast I
have to spend at least a day beating conflicts (git rerere and git
mergetool help a lot, but still require manual work on confirmation).
Also the chances to mess something up during dumb manual conflict
resolution are quite high.

The git merge --squash is an option. However I obviously  do not want
to commit it as whole 10KLOC blob. To split that amount of changes to
individual "feature-commits" is an intense and time-consuming manual
work (while more pleasant then conflict resolving). I'd prefer to have
an automated solution.

Frankly (as I'm quite a dilettante with git), I do not completely
understand the reasons for all the conflicts. The "endpoint" version
of code is already known -- since I've successfully merged two
branches. All steps to get that version must be known as well -- full
history tree is available. Except, as I think, that SHA1 for
cherry-picked commits are different -- due to that git-svn-id: thingy.
But perhaps merge process can be taught to handle it? Or does the
reason for the conflicts lurk somewhere else?

Or, perhaps I need some "their" merge strategy (as opposed to "ours")?

Any advise?

Thanks in advance,
Alexander.
