From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] t/t5800: skip if python version is older than 2.5
Date: Wed,  2 Jun 2010 18:23:16 -0500
Message-ID: <injaoVtrfs7Li4aYBNxEQeawf3YbhxcYbL79Jvef2ML9502YRtjqEol2RVKBzXfH_PfbMep0lvU@cipher.nrlssc.navy.mil>
References: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
Cc: gitster@pobox.com, srabbelier@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 01:24:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJxIU-0005ck-2d
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 01:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758906Ab0FBXYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 19:24:04 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36393 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757895Ab0FBXYD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 19:24:03 -0400
Received: by mail.nrlssc.navy.mil id o52NNbso028521; Wed, 2 Jun 2010 18:23:37 -0500
In-Reply-To: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
X-OriginalArrivalTime: 02 Jun 2010 23:23:37.0249 (UTC) FILETIME=[A09C6110:01CB02AA]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148279>

From: Brandon Casey <drafnel@gmail.com>

This test script depends on the git-remote-testgit python script.  The
git-remote-testgit script makes use of the hashlib module which was
released in python version 2.5.  So, check the python version and skip this
test if it's too old.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


By the way, I don't have python 2.5 or newer to test this. :p

-brandon


 t/t5800-remote-helpers.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 75a0163..2e5efe6 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -7,9 +7,13 @@ test_description='Test remote-helper import and export commands'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PYTHON
+if ! test_have_prereq PYTHON || ! "$PYTHON_PATH" -c '
+import sys
+if sys.hexversion < 0x02050000:
+    sys.exit(1)
+'
 then
-	say 'skipping git remote-testgit tests: requires Python support'
+	say 'skipping git remote-testgit tests: requires Python 2.5 or newer'
 	test_done
 fi
 
-- 
1.6.6.2
