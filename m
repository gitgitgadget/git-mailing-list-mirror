From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 7/8] Discard stderr output from git-rev-parse
Date: Mon, 08 Oct 2007 01:17:53 +0200
Message-ID: <20071007231753.12626.35320.stgit@yoghurt>
References: <20071007231446.12626.14259.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:18:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefOW-0003Sh-NW
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902AbXJGXR6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756777AbXJGXR5
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:17:57 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1378 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756902AbXJGXR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:17:57 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefNh-0000Lv-00; Mon, 08 Oct 2007 00:17:53 +0100
In-Reply-To: <20071007231446.12626.14259.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60246>

This gets rid of the annoying "fatal: Needed a single revision"
messages that were printed in addition to StGit's own error message.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/git.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


diff --git a/stgit/git.py b/stgit/git.py
index 0026fd8..812b77a 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -301,7 +301,8 @@ def rev_parse(git_id):
     """Parse the string and return a verified SHA1 id
     """
     try:
-        return GRun('git-rev-parse', '--verify', git_id).output_one_li=
ne()
+        return GRun('git-rev-parse', '--verify', git_id
+                    ).discard_stderr().output_one_line()
     except GitRunException:
         raise GitException, 'Unknown revision: %s' % git_id
=20
