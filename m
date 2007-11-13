From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 04/11] Skip t3902-quoted.sh if the file system does not support funny names.
Date: Tue, 13 Nov 2007 21:04:59 +0100
Message-ID: <1194984306-3181-5-git-send-email-johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-4-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:06:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is21C-0001Be-3B
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762502AbXKMUFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762510AbXKMUFS
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:05:18 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49196 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762467AbXKMUFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:05:10 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 2E2AD10AC5F;
	Tue, 13 Nov 2007 21:05:08 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1592.g0d6db
In-Reply-To: <1194984306-3181-4-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64851>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 t/t3902-quoted.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 245fb3b..73da45f 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -20,6 +20,13 @@ LF='
 '
 DQ='"'
 
+echo foo > "Name and an${HT}HT"
+test -f "Name and an${HT}HT" || {
+	# since FAT/NTFS does not allow tabs in filenames, skip this test
+	say 'Your filesystem does not allow tabs in filenames, test skipped.'
+	test_done
+}
+
 for_each_name () {
 	for name in \
 	    Name "Name and a${LF}LF" "Name and an${HT}HT" "Name${DQ}" \
-- 
1.5.3.5.1592.g0d6db
