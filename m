From: Caleb Thompson <cjaysson@gmail.com>
Subject: [PATCH v3 1/5] commit test: Use test_config instead of git-config
Date: Mon, 26 May 2014 13:56:22 -0500
Message-ID: <1401130586-93105-2-git-send-email-caleb@calebthompson.io>
References: <20140525062427.GA94219@sirius.att.net>
 <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 20:57:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp04v-0001UC-KK
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 20:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbaEZS4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 14:56:42 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35914 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbaEZS4l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 14:56:41 -0400
Received: by mail-ig0-f179.google.com with SMTP id hn18so261643igb.12
        for <git@vger.kernel.org>; Mon, 26 May 2014 11:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ddqYb2TPGbjm79LefWN8xrnltXJaG/g9jyLnyeDXbMo=;
        b=X0mu4uyhWLezWo5HrPEd4W2vOKM6b5e7FiT89nS9OeZFnQUDdC2i5yS1BhXtH+PqDf
         LsseMUBU5gMylI4qr4/3ne8urwo/NW4HACck3nm2up5Q1o8TZQT9V0dMSlTeIfv58Za/
         j30ndFpyeV5JOS7KMXqfNU5j6pH9bXg8tBE0cfKUmXmRnpWrJI4bDSt/mUAgNrMMdz9B
         XgOzGa1xlhI52SqTsmlFGT9ezQlTglWxXbhr+7pr7ZTrenQoVOBe+90E+KjWtWbDUUWs
         OuHy4QnWy32ZwSeYehSo9kvXX9DYUkm6gNvEiGdvdOTKtKe32DBk29zHrQBuYqnAFMUO
         UJOA==
X-Received: by 10.42.30.138 with SMTP id v10mr5434045icc.21.1401130600673;
        Mon, 26 May 2014 11:56:40 -0700 (PDT)
Received: from sirius.att.net (107-216-44-113.lightspeed.austtx.sbcglobal.net. [107.216.44.113])
        by mx.google.com with ESMTPSA id ql7sm1708857igc.19.2014.05.26.11.56.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 11:56:40 -0700 (PDT)
X-Google-Original-From: Caleb Thompson <caleb@calebthompson.io>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250112>

Some of the tests in t/t7507-commit-verbose.sh were still using
git-config to set configuration. Change them to use the test_config
helper.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
---
 t/t7507-commit-verbose.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 2ddf28c..6d778ed 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -43,7 +43,7 @@ test_expect_success 'verbose diff is stripped out' '
 '
 
 test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
-	git config diff.mnemonicprefix true &&
+	test_config diff.mnemonicprefix true &&
 	git commit --amend -v &&
 	check_message message
 '
@@ -71,7 +71,7 @@ test_expect_success 'diff in message is retained with -v' '
 '
 
 test_expect_success 'submodule log is stripped out too with -v' '
-	git config diff.submodule log &&
+	test_config diff.submodule log &&
 	git submodule add ./. sub &&
 	git commit -m "sub added" &&
 	(
-- 
1.9.3
