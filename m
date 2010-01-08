From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 0/3] Support for command aliases
Date: Fri, 08 Jan 2010 12:35:53 +0000
Message-ID: <20100108123403.24161.3495.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 13:36:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTE4T-0007xi-RH
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 13:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144Ab0AHMf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 07:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112Ab0AHMf7
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 07:35:59 -0500
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40752 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750843Ab0AHMf6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 07:35:58 -0500
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id o08CZseI002292;
	Fri, 8 Jan 2010 12:35:54 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 8 Jan 2010 12:35:53 +0000
User-Agent: StGit/0.15-36-g53e3
X-OriginalArrivalTime: 08 Jan 2010 12:35:53.0927 (UTC) FILETIME=[1E5E4D70:01CA905F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136427>

Hi,

These patches add support for StGit command aliases via
stgit.alias.<cmd> config options. They also re-add previously removed
commands (add, rm, resolved) and a new one (mv).

stg help lists the present aliases.


Catalin Marinas (3):
      Populate the cached config options with the defaults
      Add support for command aliases
      Replace some git commands with stg aliases in test scripts


 stgit/commands/__init__.py     |    3 ++-
 stgit/config.py                |   37 +++++++++++++++++++++++--------------
 stgit/main.py                  |   35 ++++++++++++++++++++++++++++++++++-
 t/t0001-subdir-branches.sh     |    2 +-
 t/t0002-status.sh              |   12 ++++++------
 t/t1000-branch-create.sh       |    4 ++--
 t/t1002-branch-clone.sh        |    2 +-
 t/t1200-push-modified.sh       |    2 +-
 t/t1201-pull-trailing.sh       |    2 +-
 t/t1202-push-undo.sh           |    6 +++---
 t/t1203-push-conflict.sh       |    6 +++---
 t/t1204-pop-keep.sh            |    2 +-
 t/t1205-push-subdir.sh         |    6 +++---
 t/t1206-push-hidden.sh         |    2 +-
 t/t1207-push-tree.sh           |    2 +-
 t/t1300-uncommit.sh            |    4 ++--
 t/t1301-repair.sh              |    8 ++++----
 t/t1302-repair-interop.sh      |    2 +-
 t/t1500-float.sh               |   14 +++++++-------
 t/t1501-sink.sh                |   12 ++++++------
 t/t1600-delete-one.sh          |   12 ++++++------
 t/t1601-delete-many.sh         |    2 +-
 t/t1602-delete-spill.sh        |    2 +-
 t/t1700-goto-top.sh            |    2 +-
 t/t1701-goto-hidden.sh         |    2 +-
 t/t1800-import.sh              |    4 ++--
 t/t1900-mail.sh                |    2 +-
 t/t2000-sync.sh                |   12 ++++++------
 t/t2100-pull-policy-fetch.sh   |    4 ++--
 t/t2101-pull-policy-pull.sh    |    6 +++---
 t/t2102-pull-policy-rebase.sh  |    4 ++--
 t/t2200-rebase.sh              |    4 ++--
 t/t2300-refresh-subdir.sh      |    4 ++--
 t/t2400-diff.sh                |    2 +-
 t/t2500-clean.sh               |    2 +-
 t/t2600-squash.sh              |    2 +-
 t/t2700-refresh.sh             |    6 +++---
 t/t2701-refresh-p.sh           |    4 ++--
 t/t2702-refresh-rm.sh          |   10 +++++-----
 t/t2800-goto-subdir.sh         |    2 +-
 t/t3000-dirty-merge.sh         |    2 +-
 t/t3100-reset.sh               |    2 +-
 t/t3101-reset-hard.sh          |    2 +-
 t/t3102-undo.sh                |    2 +-
 t/t3103-undo-hard.sh           |    2 +-
 t/t3104-redo.sh                |    2 +-
 t/t3105-undo-external-mod.sh   |    6 +++---
 t/t3200-non-ascii-filenames.sh |    4 ++--
 t/t3300-edit.sh                |    2 +-
 t/t3400-pick.sh                |    8 ++++----
 t/t4100-publish.sh             |   12 ++++++------
 51 files changed, 169 insertions(+), 126 deletions(-)

-- 
Catalin
