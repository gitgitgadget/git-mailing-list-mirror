From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv7 6/6] add tests of commit --squash
Date: Tue, 2 Nov 2010 13:59:12 -0600
Message-ID: <1288727952-57498-7-git-send-email-patnotz@gmail.com>
References: <1288727952-57498-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 02 21:00:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDN1e-0007yP-4F
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 21:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242Ab0KBT7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 15:59:45 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:39709 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab0KBT7n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 15:59:43 -0400
X-WSS-ID: 0LB9WVF-0C-073-02
X-M-MSG: 
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1E24C47FD9F
	for <git@vger.kernel.org>; Tue,  2 Nov 2010 13:59:38 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Tue, 02 Nov 2010 13:59:24 -0600
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id oA2Jx5mu000560 for
 <git@vger.kernel.org>; Tue, 2 Nov 2010 13:59:14 -0600
Received: from localhost.localdomain (134.253.98.198) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Tue, 2 Nov 2010 13:59:14 -0600
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1288727952-57498-1-git-send-email-patnotz@gmail.com>
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.11.2.195116
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODY_SIZE_3000_3999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS
 0, DATE_TZ_NA 0, __CT 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0,
 __FRAUD_WEBMAIL 0, __FRAUD_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HAS_MSGID
 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0,
 __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0, __STOCK_PHRASE_7 0,
 __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0,
 __URI_NS '
X-TMWD-Spam-Summary: TS=20101102195928; ID=1; SEV=2.3.1;
 DFV=B2010110219; IFV=NA; AIF=B2010110219; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230382E34434430364441302E303043343A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAJsKIgAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010110219_5.03.0010
X-WSS-ID: 60CEB2163KK1977248-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160548>

t7500: test expected behavior of commit --squash
t3415: test interaction of commit --squash with rebase --autosquash
t3900: test commit --squash with i18n encodings

Signed-off-by: Pat Notz <patnotz@gmail.com>
---
 t/t3415-rebase-autosquash.sh |    4 +++
 t/t3900-i18n-commit.sh       |    2 +
 t/t7500-commit.sh            |   47 ++++++++++++++++++++++++++++++++++++++++++
 t/t7500/edit-content         |    4 +++
 4 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100755 t/t7500/edit-content

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index b77a413..0028533 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -115,4 +115,8 @@ test_expect_success 'use commit --fixup' '
 	test_auto_commit_flags fixup 1
 '
 
+test_expect_success 'use commit --squash' '
+	test_auto_commit_flags squash 2
+'
+
 test_done
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index f4775ee..c06a5ee 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -160,4 +160,6 @@ test_commit_autosquash_flags () {
 
 test_commit_autosquash_flags eucJP fixup
 
+test_commit_autosquash_flags ISO-2022-JP squash '-m "squash message"'
+
 test_done
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index a41b819..162527c 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -238,10 +238,57 @@ test_expect_success 'commit --fixup provides correct one-line commit message' '
 	commit_msg_is "fixup! target message subject line"
 '
 
+test_expect_success 'commit --squash works with -F' '
+	commit_for_rebase_autosquash_setup &&
+	echo "log message from file" >msgfile &&
+	git commit --squash HEAD~1 -F msgfile  &&
+	commit_msg_is "squash! target message subject linelog message from file"
+'
+
+test_expect_success 'commit --squash works with -m' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --squash HEAD~1 -m "foo bar\nbaz" &&
+	commit_msg_is "squash! target message subject linefoo bar\nbaz"
+'
+
+test_expect_success 'commit --squash works with -C' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --squash HEAD~1 -C HEAD &&
+	commit_msg_is "squash! target message subject lineintermediate commit"
+'
+
+test_expect_success 'commit --squash works with -c' '
+	commit_for_rebase_autosquash_setup &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/edit-content &&
+	git commit --squash HEAD~1 -c HEAD &&
+	commit_msg_is "squash! target message subject lineedited commit"
+'
+
+test_expect_success 'commit --squash works with -C for same commit' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --squash HEAD -C HEAD &&
+	commit_msg_is "squash! intermediate commit"
+'
+
+test_expect_success 'commit --squash works with -c for same commit' '
+	commit_for_rebase_autosquash_setup &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/edit-content &&
+	git commit --squash HEAD -c HEAD &&
+	commit_msg_is "squash! edited commit"
+'
+
+test_expect_success 'commit --squash works with editor' '
+	commit_for_rebase_autosquash_setup &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
+	git commit --squash HEAD~1 &&
+	commit_msg_is "squash! target message subject linecommit message"
+'
+
 test_expect_success 'invalid message options when using --fixup' '
 	echo changes >>foo &&
 	echo "message" >log &&
 	git add foo &&
+	test_must_fail git commit --fixup HEAD~1 --squash HEAD~2 &&
 	test_must_fail git commit --fixup HEAD~1 -C HEAD~2 &&
 	test_must_fail git commit --fixup HEAD~1 -c HEAD~2 &&
 	test_must_fail git commit --fixup HEAD~1 -m "cmdline message" &&
diff --git a/t/t7500/edit-content b/t/t7500/edit-content
new file mode 100755
index 0000000..08db9fd
--- /dev/null
+++ b/t/t7500/edit-content
@@ -0,0 +1,4 @@
+#!/bin/sh
+sed -e "s/intermediate/edited/g" <"$1" >"$1-"
+mv "$1-" "$1"
+exit 0
-- 
1.7.3.2
