From: THILLOSEN Andreas <thillosen@free.fr>
Subject: Git: Having trouble merging two repositories by interweaving their
 histories
Date: Mon, 09 Sep 2013 23:26:42 +0200
Message-ID: <522E3D12.4090004@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 23:26:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ8yz-0007ja-Hq
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 23:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575Ab3IIV0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 17:26:50 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:47847 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755426Ab3IIV0t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 17:26:49 -0400
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Sep 2013 17:26:48 EDT
Received: from [192.168.1.100] (unknown [88.178.152.236])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 161364C80A5
	for <git@vger.kernel.org>; Mon,  9 Sep 2013 23:26:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130901 Thunderbird/17.0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234380>

Hi,

I recently stumbled over problems, while trying to merge two
repositories (RepA and RepB) into a single one (RepM).
I must mention that indexed files in RepA are totally distinct from
indexed files in RepB, thus no conflict shall appear.
The problem is that I never manage to get the exact result I'm hoping for:

1] RepM should have the entire commit histories of both RepA and RepB.
2] In RepM, indexed files should be separated in two directories:  DirA
(for files associated to RepA), and DirB (for files associated to RepB).
3] I should be able to bissect easily within the history of RepM, even
for old commits. It implies that if I checkout a particular commit
(initially associated to RepA), indexed files initially associated to
RepA and RepB should get updated (and not only files associed to RepA).
It implies "interweaving" their histories, so that I can get a "state"
of both RepA and RepB around a same time period of time.

For my scenario, I used these kinds of commands (from a git bash
launched within an initialized repository RepM):

git remote add RepA /path/RepA
git fetch RepA
git checkout -b RepA/master
git merge -s recursive -Xsubtree=DirA RepA/master

git remote add RepB /path/RepB
git fetch RepB
git checkout -b RepB/master
git merge -s recursive -Xsubtree=DirB RepB/master

With these commands, only my first point 1] is satisfied (I can see the
full history associated to RepA and RepB).

If I checkout RepM to an old commit, the files indexed by RepA or RepB
are updated by ignoring the directories DirA and DirB (point 2] is not
satisfied).

Moreover, only files associated to either RepA or RepB (depending on the
origin of the commit) get updated (point 3] is not satisfied).
In history, commits from RepA are all appearing at the beginning, and
commits from RepB are appearing at the end (they are clearly being
separated).
Should "rebase" help me to solve this? With what kind of parameters?

Greetings,

Andreas THILLOSEN.
