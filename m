From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Test "stg status" with -M in stgit.diff-opts
Date: Tue, 08 Jul 2008 21:57:20 +0200
Message-ID: <20080708195720.25030.94355.stgit@yoghurt>
References: <20080708195508.25030.46828.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 21:58:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGJKP-00060w-O7
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 21:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbYGHT5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 15:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753475AbYGHT5Z
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 15:57:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1619 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbYGHT5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 15:57:24 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KGJJQ-0003zD-00; Tue, 08 Jul 2008 20:57:20 +0100
In-Reply-To: <20080708195508.25030.46828.stgit@yoghurt>
User-Agent: StGIT/0.14.3.194.gbf3df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87795>

It used to fail, before the recent merge of the -O/--diff-opts
removal, since the default value of that option was taken from
stgit.diff-opts and passed on to stgit.git.tree_status() which
couldn't handle it.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t0002-status.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)


diff --git a/t/t0002-status.sh b/t/t0002-status.sh
index 5e1e8ca..86ff419 100755
--- a/t/t0002-status.sh
+++ b/t/t0002-status.sh
@@ -186,4 +186,10 @@ test_expect_success 'Status after renaming a file'=
 '
     test_cmp expected.txt output.txt
 '
=20
+test_expect_success 'Status after renaming a file (with rename detecti=
on)' '
+    git config stgit.diff-opts -M &&
+    stg status > output.txt &&
+    test_cmp expected.txt output.txt
+'
+
 test_done
