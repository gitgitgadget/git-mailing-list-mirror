From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 00/10] --left/right-only and --cherry-mark
Date: Thu, 10 Mar 2011 15:44:53 +0100
Message-ID: <cover.1299767412.git.git@drmicha.warpmail.net>
References: <4D78AC8B.7010308@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 15:48:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxhAW-0007SI-Oq
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 15:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab1CJOsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 09:48:40 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:49155 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752091Ab1CJOsj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 09:48:39 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3A91F20D36;
	Thu, 10 Mar 2011 09:48:39 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 10 Mar 2011 09:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=JCkqlrBc0XOHhnbAN51tEnYd94E=; b=HfLMx7gAHxUwbZXKVZSwd/HMr4uQco6MTtbA+CbrwD0glnrztqQReBSNhPMZauj0uPwtTFPaZDwozm5SmVN01Ohb0d+EsZWLcNVIveI7JwSwo+XMJr9bR+cGv4izlXm3iLOlKgaBQIAXEM6h6OjD4TScx3hWi5w3lIm6SlZ2XSw=
X-Sasl-enc: G1zzSEcbfkh2/xpP/z6j59RKK+CzjGWYkcPfKrsnPhSS 1299768518
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A7E8C40D3AF;
	Thu, 10 Mar 2011 09:48:38 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.317.gf445f
In-Reply-To: <4D78AC8B.7010308@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168816>

Anyway, this is what it looks like with "Y" (even though I prefer "X"
because of the option to flag correspondence.

v3 is v2 plus what we have discussed (pu had v2 plus Junio's amends).
In addition, 6 and 9 use "Y" rather than "X".

To make it less boring, I added 10 which changes the output format with
commit marks. See an example there and below. (10 is independent of the
choice of X vs. Y, of course.)

All together, this gives output (from my branch) like:

git-log --oneline --cherry origin/pu...

+ dfe27d4 git-log: put space after commit mark
= ca14e3f t6007: test rev-list --cherry
+ e5a72f0 log --cherry: a synonym
= fd5b652 rev-list: documentation and test for --cherry-mark
+ c17a824 revision.c: introduce --cherry-mark
= 3d5377a rev-list/log: factor out revision mark generation


git-log --oneline --graph --cherry origin/pu...

* dfe27d4 git-log: put space after commit mark
= ca14e3f t6007: test rev-list --cherry
* e5a72f0 log --cherry: a synonym
= fd5b652 rev-list: documentation and test for --cherry-mark
* c17a824 revision.c: introduce --cherry-mark
= 3d5377a rev-list/log: factor out revision mark generation


git-log --oneline --graph --cherry-mark origin/pu...

* dfe27d4 git-log: put space after commit mark
= ca14e3f t6007: test rev-list --cherry
* e5a72f0 log --cherry: a synonym
= fd5b652 rev-list: documentation and test for --cherry-mark
* c17a824 revision.c: introduce --cherry-mark
= 3d5377a rev-list/log: factor out revision mark generation
*   0cb35e5 Merge branch 'mm/maint-log-n-with-diff-filtering' into pu
|\  
| * 251df09 log: fix --max-count when used together with -S or -G
* |   803ba88 Merge branch 'jk/edit-notes-in-commit-log' into pu
...
|  / / / / / / / / / /  
* | | | | | | | | | |   f1b3ae0 Merge branch 'mg/rev-list-one-side-only' into pu
|\ \ \ \ \ \ \ \ \ \ \  
| = | | | | | | | | | | fe3b59e t6007: test rev-list --cherry
| * | | | | | | | | | | 94f605e log --cherry: a synonym
| = | | | | | | | | | | cb56e30 rev-list: documentation and test for --cherry-mark
| * | | | | | | | | | | adbbb31 revision.c: introduce --cherry-mark
| = | | | | | | | | | | 1df2d65 rev-list/log: factor out revision mark generation

And all this in beautiful color (and full log interface), of course! Compare with:

git cherry origin/pu -v
- 3d5377ae86c22a73bdce7896abe2953019039e0e rev-list/log: factor out revision mark generation
+ c17a82478307a5a29455de09232087b17435c52a revision.c: introduce --cherry-mark
- fd5b65227573cb8d5ff7c8087814f9b8f8e0851e rev-list: documentation and test for --cherry-mark
+ e5a72f0ddc0ddc9b6087c08143b188043f3bea1f log --cherry: a synonym
- ca14e3fb22b91653086fbd8c8600f2f93409a0a6 t6007: test rev-list --cherry
+ dfe27d480258ab4af4fa50628a9bbaff33ba6860 git-log: put space after commit mark

Let the bike-shedding begin!

Junio C Hamano (1):
  rev-list: --left/right-only are mutually exclusive

Michael J Gruber (9):
  revlist.c: introduce --left/right-only for unsymmetric picking
  t6007: Make sure we test --cherry-pick
  rev-list: documentation and test for --left/right-only
  rev-list/log: factor out revision mark generation
  revision.c: introduce --cherry-mark
  rev-list: documentation and test for --cherry-mark
  log --cherry: a synonym
  t6007: test rev-list --cherry
  git-log: put space after commit mark

 Documentation/git-rev-list.txt       |    3 +
 Documentation/rev-list-options.txt   |   26 ++++++++
 builtin/rev-list.c                   |   14 +----
 git-svn.perl                         |    2 +-
 graph.c                              |   17 +-----
 log-tree.c                           |   28 +-------
 pretty.c                             |    6 +--
 revision.c                           |   81 +++++++++++++++++++++++-
 revision.h                           |    8 ++-
 t/t6007-rev-list-cherry-pick-file.sh |  113 +++++++++++++++++++++++++++++++---
 10 files changed, 230 insertions(+), 68 deletions(-)

-- 
1.7.4.1.317.gf445f
