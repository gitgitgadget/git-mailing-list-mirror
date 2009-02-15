From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 7/8] Test rev-list --parents/--children
Date: Sun, 15 Feb 2009 23:25:44 +0100
Message-ID: <e10e841375043b44bb5ca37773a60e80c849046e.1234736374.git.trast@student.ethz.ch>
References: <cover.1234736374.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 23:27:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYpSx-0004VH-2U
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 23:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbZBOW0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 17:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753613AbZBOW0N
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 17:26:13 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:11608 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960AbZBOW0J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 17:26:09 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:56 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:55 +0100
X-Mailer: git-send-email 1.6.2.rc0.335.g1a2b
In-Reply-To: <cover.1234736374.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 15 Feb 2009 22:25:55.0241 (UTC) FILETIME=[5E1DE190:01C98FBC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110069>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

rev-list doesn't really belong in diff-various, but it can be done
very easily in the existing framework, and there are log tests too...


 t/t4013-diff-various.sh               |    3 +++
 t/t4013/diff.rev-list_--children_HEAD |    7 +++++++
 t/t4013/diff.rev-list_--parents_HEAD  |    7 +++++++
 3 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 t/t4013/diff.rev-list_--children_HEAD
 create mode 100644 t/t4013/diff.rev-list_--parents_HEAD

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index e5715f3..0f359ca 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -205,6 +205,9 @@ log -SF master
 log -SF -p master
 log --decorate --all
 
+rev-list --parents HEAD
+rev-list --children HEAD
+
 whatchanged master
 whatchanged -p master
 whatchanged --root master
diff --git a/t/t4013/diff.rev-list_--children_HEAD b/t/t4013/diff.rev-list_--children_HEAD
new file mode 100644
index 0000000..e7f17d5
--- /dev/null
+++ b/t/t4013/diff.rev-list_--children_HEAD
@@ -0,0 +1,7 @@
+$ git rev-list --children HEAD
+59d314ad6f356dd08601a4cd5e530381da3e3c64
+c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a 59d314ad6f356dd08601a4cd5e530381da3e3c64
+9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 59d314ad6f356dd08601a4cd5e530381da3e3c64
+1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+444ac553ac7612cc88969031b02b3767fb8a353a 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+$
diff --git a/t/t4013/diff.rev-list_--parents_HEAD b/t/t4013/diff.rev-list_--parents_HEAD
new file mode 100644
index 0000000..65d2a80
--- /dev/null
+++ b/t/t4013/diff.rev-list_--parents_HEAD
@@ -0,0 +1,7 @@
+$ git rev-list --parents HEAD
+59d314ad6f356dd08601a4cd5e530381da3e3c64 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a 444ac553ac7612cc88969031b02b3767fb8a353a
+9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 444ac553ac7612cc88969031b02b3767fb8a353a
+444ac553ac7612cc88969031b02b3767fb8a353a
+$
-- 
1.6.2.rc0.335.g1a2b
