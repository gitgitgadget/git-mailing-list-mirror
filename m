From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 0/3] merge -Xindex-only
Date: Sun, 7 Jul 2013 20:02:37 +0200
Message-ID: <cover.1373219466.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 07 20:03:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvtIV-0000NE-AX
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 20:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab3GGSCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 14:02:51 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:57195 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528Ab3GGSCt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 14:02:49 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 7 Jul
 2013 20:02:34 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 7 Jul
 2013 20:02:46 +0200
X-Mailer: git-send-email 1.8.3.2.908.gbd0dbd0
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229787>

[Michael, sorry for the double mail -- I typoed the list address on
the first round.]

I recently looked into making merge-recursive more useful as a modular
piece in various tasks, e.g. Michael's git-imerge and the experiments
I made in showing evil merges.

This miniseries is the extremely low-hanging fruit.  If it makes a
good first step for git-imerge, perhaps it can go in like this.  It's
not a big speedup (about 2.2s vs 2.4s in a sample conflicting merge in
git.git), but it does feel much cleaner to avoid touching the worktree
unless actually necessary.

Otherwise it's probably not worth it just yet; for what I want to do
with it, we need some more reshuffling of things.



Thomas Rast (3):
  merge-recursive: remove dead conditional in update_stages()
  merge-recursive: untangle double meaning of o->call_depth
  merge-recursive: -Xindex-only to leave worktree unchanged

 Documentation/merge-strategies.txt |  4 ++++
 merge-recursive.c                  | 46 +++++++++++++++++++++-----------------
 merge-recursive.h                  |  1 +
 t/t3030-merge-recursive.sh         | 13 +++++++++++
 4 files changed, 43 insertions(+), 21 deletions(-)

-- 
1.8.3.2.908.gbd0dbd0
