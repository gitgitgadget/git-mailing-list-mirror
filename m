From: Petr Baudis <pasky@suse.cz>
Subject: [RFC][PATCH 0/7] Submodule support in git mv, git rm
Date: Wed, 16 Jul 2008 21:11:02 +0200
Message-ID: <20080716190753.19772.93357.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 21:13:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCQ4-0000m3-LB
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbYGPTLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754149AbYGPTLJ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:11:09 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:64249 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752219AbYGPTLI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:11:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id BB8F12ACC76;
	Wed, 16 Jul 2008 21:11:02 +0200 (CEST)
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88720>

The following series implements submodule support in git mv and git rm,
plus enhancing the submodules testsuite a bit. I'd appreciate comments,
especially on the git mv change, since the index_path_src_sha1 is
really a horrible hack.

The pinnacle of this series was supposed to be merge-recursive support
for submodule-somethingelese conflicts, however that seems a bit more
complicated than I expected, so I decided to first send the rest for
a review.

---

Petr Baudis (7):
      t7403: Submodule git mv, git rm testsuite
      git rm: Support for removing submodules
      git mv: Support moving submodules
      submodule.*: Introduce simple C interface for submodule lookup by path
      git submodule add: Fix naming clash handling
      t7400: Add short "git submodule add" testsuite
      git-mv: Remove dead code branch


 Documentation/git-rm.txt   |    6 +
 Makefile                   |    2 
 builtin-mv.c               |   67 ++++++++++--
 builtin-rm.c               |   65 ++++++++++--
 cache.h                    |    2 
 git-submodule.sh           |   15 ++-
 sha1_file.c                |   10 ++
 submodule.c                |   50 +++++++++
 submodule.h                |    8 +
 t/t7400-submodule-basic.sh |   39 +++++++
 t/t7403-submodule-mvrm.sh  |  242 ++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 476 insertions(+), 30 deletions(-)
 create mode 100644 submodule.c
 create mode 100644 submodule.h
 create mode 100755 t/t7403-submodule-mvrm.sh
