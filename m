From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH 00/12] Improve handling of moving and removing submodules
Date: Fri, 26 Mar 2010 15:25:28 +0000
Message-ID: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 16:27:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBRB-0006Hb-1d
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab0CZPZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:25:55 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:55532 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab0CZPZy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:25:54 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Mar 2010 11:25:54 EDT
Received: from [10.179.145.9] (helo=lapas.pcc.me.uk)
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ1-0001o1-QN
	for git@vger.kernel.org; Fri, 26 Mar 2010 15:25:53 +0000
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ0-000232-Qp
	for git@vger.kernel.org; Fri, 26 Mar 2010 15:25:52 +0000
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143250>

This patch series deals with a number of issues associated with moving
and removing submodules.  Specifically it improves submodule support
in the following subcommands: apply merge mv rm

This series was inspired by an earlier unmerged series [1] by Petr
Baudis.

[1] http://kerneltrap.org/mailarchive/git/2008/7/16/2533024

 Documentation/git-mv.txt        |    8 ++-
 Documentation/git-rm.txt        |    5 ++-
 Documentation/git-submodule.txt |    8 +++-
 builtin/apply.c                 |    8 +--
 builtin/mv.c                    |   33 +++++++++++--
 builtin/rm.c                    |   45 ++++++++++++++---
 dir.c                           |    4 +-
 dir.h                           |    2 +-
 git-compat-util.h               |    9 +++
 git-submodule.sh                |   95 +++++++++++++++++++++++++++++++++--
 merge-recursive.c               |   27 ++++++----
 t/t4134-apply-submodule.sh      |   38 ++++++++++++++
 t/t7403-submodule-sync.sh       |    2 +-
 t/t7405-submodule-merge.sh      |   13 +++++
 t/t7406-submodule-update.sh     |    6 +-
 t/t7407-submodule-foreach.sh    |   14 +++---
 t/t7409-submodule-mv-rm.sh      |  105 +++++++++++++++++++++++++++++++++++++++
 unpack-trees.c                  |   12 +----
 wrapper.c                       |   22 ++++++--
 19 files changed, 390 insertions(+), 65 deletions(-)
