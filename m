From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 07/10] t3510 (cherry-pick-sequencer): remove malformed sheet 2
Date: Wed, 14 Dec 2011 22:24:34 +0530
Message-ID: <1323881677-11117-8-git-send-email-artagnon@gmail.com>
References: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
 <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:55:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ras7D-0004kJ-04
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757626Ab1LNQzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 11:55:15 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61872 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757608Ab1LNQzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 11:55:13 -0500
Received: by mail-vx0-f174.google.com with SMTP id fk14so763696vcb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jTFRExzSJ5nrOpaMTff9AotRAyzWolto7BPHKbmLqRs=;
        b=u2KjNst+QcwysMlYUdIF2PmEGcWmVHJD6F4BSC1NJnrWLG6HpfcAMbk4XI5bJYJ3pT
         BCfkbfs8+JsNM/okF90dwdPCaDsi4LqTk6VZrRVpgBpTIJSxna8wXziqYAGDfMwNXidp
         0FJUGx0ydF9qvd2tSlu+C759KvERORtgIHltg=
Received: by 10.52.88.51 with SMTP id bd19mr5417971vdb.118.1323881713328;
        Wed, 14 Dec 2011 08:55:13 -0800 (PST)
Received: from localhost.localdomain ([122.174.116.246])
        by mx.google.com with ESMTPS id ir2sm2963127vdb.9.2011.12.14.08.55.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 08:55:12 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187152>

The next patch allows mixing "pick" and "revert" instruction in the
same instruction sheet.  By removing the "malformed instruction sheet
2" test in advance, it'll be easier to see the changes made by the
future patches that touch this file.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3510-cherry-pick-sequence.sh |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 163ce7d..1bfbe41 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -309,7 +309,7 @@ test_expect_success '--signoff is not automatically propagated to resolved confl
 	grep "Signed-off-by:" anotherpick_msg
 '
 
-test_expect_success 'malformed instruction sheet 1' '
+test_expect_success 'malformed instruction sheet, action' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick base..anotherpick &&
 	echo "resolved" >foo &&
@@ -320,18 +320,7 @@ test_expect_success 'malformed instruction sheet 1' '
 	test_expect_code 128 git cherry-pick --continue
 '
 
-test_expect_success 'malformed instruction sheet 2' '
-	pristine_detach initial &&
-	test_expect_code 1 git cherry-pick base..anotherpick &&
-	echo "resolved" >foo &&
-	git add foo &&
-	git commit &&
-	sed "s/pick/revert/" .git/sequencer/todo >new_sheet &&
-	cp new_sheet .git/sequencer/todo &&
-	test_expect_code 128 git cherry-pick --continue
-'
-
-test_expect_success 'malformed instruction sheet 3' '
+test_expect_success 'malformed instruction sheet, object name' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick base..anotherpick &&
 	echo "resolved" >foo &&
-- 
1.7.4.1
