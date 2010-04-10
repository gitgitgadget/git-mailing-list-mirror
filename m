From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH v2 0/9] Improve handling of moving and removing submodules
Date: Sat, 10 Apr 2010 19:23:41 +0100
Message-ID: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 20:24:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0fLt-0007Ck-Kn
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043Ab0DJSXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 14:23:54 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:37784 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926Ab0DJSXx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 14:23:53 -0400
Received: from lapas.pcc.me.uk ([10.179.130.3])
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLV-0006qN-4B
	for git@vger.kernel.org; Sat, 10 Apr 2010 19:23:53 +0100
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLU-000366-5S
	for git@vger.kernel.org; Sat, 10 Apr 2010 19:23:52 +0100
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144561>

Changes since v1:
 - Generate a more user friendly unique ID
 - Added tests for "git rm" error cases (thanks Jonathan Nieder)

Peter Collingbourne (9):
      Generate unique ID for submodules created using "git submodule add"
      Implement "git mv" for submodules
      git rm: test failure behaviour for multiple removals
      git rm: display a warning for every unremovable file
      git rm: collect file modes
      Add a mode parameter to the remove_path function
      git rm: do not abort due to an initialised submodule
      git submodule: infrastructure for reading .gitmodules files in arbitrary locations
      git rm: remove submodule entries from .gitmodules

 Documentation/git-mv.txt        |    7 ++-
 Documentation/git-rm.txt        |    5 ++-
 Documentation/git-submodule.txt |    8 +++-
 builtin/apply.c                 |    2 +-
 builtin/mv.c                    |   33 +++++++++++--
 builtin/rm.c                    |   45 ++++++++++++++---
 dir.c                           |    4 +-
 dir.h                           |    2 +-
 git-submodule.sh                |   98 ++++++++++++++++++++++++++++++++++--
 merge-recursive.c               |   27 ++++++----
 t/t3600-rm.sh                   |   69 +++++++++++++++++++++++++
 t/t7403-submodule-sync.sh       |    2 +-
 t/t7405-submodule-merge.sh      |   13 +++++
 t/t7406-submodule-update.sh     |    6 +-
 t/t7407-submodule-foreach.sh    |   14 +++---
 t/t7409-submodule-mv-rm.sh      |  105 +++++++++++++++++++++++++++++++++++++++
 16 files changed, 395 insertions(+), 45 deletions(-)
