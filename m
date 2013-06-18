From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 04/13] bash prompt: add a test for symbolic link symbolic
 refs
Date: Tue, 18 Jun 2013 04:16:57 +0200
Message-ID: <1371521826-3225-5-git-send-email-szeder@ira.uka.de>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:18:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolUe-0006DB-Ac
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917Ab3FRCR4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 22:17:56 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:62634 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab3FRCRz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:17:55 -0400
Received: from localhost6.localdomain6 (f052037223.adsl.alicedsl.de [78.52.37.223])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MIgBs-1UmZd52Xu4-002YtG; Tue, 18 Jun 2013 04:17:47 +0200
X-Mailer: git-send-email 1.8.3.1.487.g8f4672d
In-Reply-To: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:hSygSmnHwwAiWHTKiJSYQDv45MHbFjTMyxqsFKuNWR3
 Y4Oq4JBjp2WVEv7Sbz3SxYP0fRezJCm3xPdUI+NzxjPHddaC7k
 eOeHUfMwQYtTyyI9AnkByyIITGAOwjhb+2sLDK/PZS+rEtLk6b
 42xKFw+N0dVh6KYRy0Cuc2NTDsJgluSp3TvH6GZEkRNWrHtOLF
 80SOt6Zq/Ti9V04IeK2Qb11crpRzz43fyy7buPwBhWsjsV1KU9
 zRQLklzGrTmwtQL+P5M3Li+8wtp8caqnK1/TWwCPVAQX2GQ/2R
 5jAdwjvnRZlq4V+iuZt7U9uuuVR+bbm3/clIODXkVZL1eQfaDo
 oHFWW70P8wMxhDeS9/HI520mCOEcC0Rp/YvYTb1PEYsldUVzWW
 98BgC4xVkHKJw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228136>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9903-bash-prompt.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 1047c664..48460ef6 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -40,6 +40,15 @@ test_expect_success 'prompt - branch name' '
 	test_cmp expected "$actual"
 '
=20
+test_expect_success SYMLINKS 'prompt - branch name - symlink symref' '
+	printf " (master)" >expected &&
+	test_when_finished "git checkout master" &&
+	test_config core.preferSymlinkRefs true &&
+	git checkout master &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success 'prompt - detached head' '
 	printf " ((%s...))" $(git log -1 --format=3D"%h" b1^) >expected &&
 	git checkout b1^ &&
--=20
1.8.3.1.487.g8f4672d
