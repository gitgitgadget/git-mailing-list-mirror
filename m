From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 5/7] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Mon,  3 Nov 2014 11:12:30 -0800
Message-ID: <1415041952-19637-6-git-send-email-sahlberg@google.com>
References: <1415041952-19637-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:12:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlN3Z-0006P7-1v
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbaKCTMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:12:39 -0500
Received: from mail-pa0-f74.google.com ([209.85.220.74]:41386 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbaKCTMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:12:35 -0500
Received: by mail-pa0-f74.google.com with SMTP id kx10so1999936pab.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZND2vS7YeWX2SD4Oyz5sS+i4iKJsGJ6fmlAEf5M+tpU=;
        b=IaMMf/071DVnwf+1wymFGfSyKP3eQoxRzDrplH8Ioppi3X/muhtj9V2k4Fz63/L5tS
         tXX2cySwH+KQi4slFstXQnRqIvoUrNnFt6JbHZyidf8PGD7Nn3E8jQrMgAktxDklTaZB
         9F2oPq3FUXGS4f9nahIiejfBJGH2j2o1+lZvuOSqp2GFvVnpKuJyeCnKkYUyj3Ap0aof
         g4A7v39+yBW574DQKLWdmjLCLqm5eV2/Tg10wdnsByxYiivP07WC1F2zPFfme1mjYKvw
         POoDHCFnIfQYLvlQbbmHBaXCcgiNr/4svclE7JpKX7dZRUvLLwSm01zhz/4XPRm1Cmiv
         xR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZND2vS7YeWX2SD4Oyz5sS+i4iKJsGJ6fmlAEf5M+tpU=;
        b=keYssoH3K9d6zp2o8GxQHlgqLOPrNFQeXUFG1sbl6DqMimn2qWUVrXKaiqXAL/LS5H
         gk22P1jG6pbMStxqiR2i7d7ayr5Ksg5T3LHGyn9rezEu09dpIg9y87FPFBmMgVn7vhBe
         83BdgMyIgSXpVy8kEqRb2yl5vVHQR+CTlE+t376YYIYy5SWSRAqCtEbzfMx6Yr+2GWbZ
         TerVgtK6Gumqr+9B268C0LAAYBywvbVFdafecjvOQ6b/eyh7Vc0A9DoRbCM31nDOD1IZ
         l6IHQEg3hGIaWf7ZESnfce3bOroLtPTqeE5u3NEE2zR3VWc/H/p1l9KZqYqPRi4fSPgn
         u59w==
X-Gm-Message-State: ALoCoQmhJ+4QiXiW846GhZmSwvUcUGNQ7Zebr5yH/Vh1IDmfVjcoK6I7TvHc70HgNoWiiSpp3WOe
X-Received: by 10.66.248.8 with SMTP id yi8mr33470391pac.26.1415041954957;
        Mon, 03 Nov 2014 11:12:34 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id e24si976466yhe.3.2014.11.03.11.12.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:12:34 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id vnANg6LV.1; Mon, 03 Nov 2014 11:12:34 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 26F60E0804; Mon,  3 Nov 2014 11:12:34 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041952-19637-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 t/t5543-atomic-push.sh | 101 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100755 t/t5543-atomic-push.sh

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
new file mode 100755
index 0000000..4903227
--- /dev/null
+++ b/t/t5543-atomic-push.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='pushing to a mirror repository'
+
+. ./test-lib.sh
+
+D=`pwd`
+
+invert () {
+	if "$@"; then
+		return 1
+	else
+		return 0
+	fi
+}
+
+mk_repo_pair () {
+	rm -rf master mirror &&
+	mkdir mirror &&
+	(
+		cd mirror &&
+		git init &&
+		git config receive.denyCurrentBranch warn
+	) &&
+	mkdir master &&
+	(
+		cd master &&
+		git init &&
+		git remote add $1 up ../mirror
+	)
+}
+
+
+test_expect_success 'atomic push works for a single branch' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git push --mirror up
+		echo two >foo && git add foo && git commit -m two &&
+		git push --atomic-push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" = "$mirror_master"
+
+'
+
+test_expect_success 'atomic push works for two branches' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git branch second &&
+		git push --mirror up
+		echo two >foo && git add foo && git commit -m two &&
+		git checkout second &&
+		echo three >foo && git add foo && git commit -m three &&
+		git checkout master &&
+		git push --atomic-push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" = "$mirror_master"
+
+	master_second=$(cd master && git show-ref -s --verify refs/heads/second) &&
+	mirror_second=$(cd mirror && git show-ref -s --verify refs/heads/second) &&
+	test "$master_second" = "$mirror_second"
+'
+
+# set up two branches where master can be pushed but second can not
+# (non-fast-forward). Since second can not be pushed the whole operation
+# will fail and leave master untouched.
+test_expect_success 'atomic push fails if one branch fails' '
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git branch second &&
+		git checkout second &&
+		echo two >foo && git add foo && git commit -m two &&
+		echo three >foo && git add foo && git commit -m three &&
+		echo four >foo && git add foo && git commit -m four &&
+		git push --mirror up
+		git reset --hard HEAD~2 &&
+		git checkout master
+		echo five >foo && git add foo && git commit -m five &&
+		! git push --atomic-push --all up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" != "$mirror_master" &&
+
+	master_second=$(cd master && git show-ref -s --verify refs/heads/second) &&
+	mirror_second=$(cd mirror && git show-ref -s --verify refs/heads/second) &&
+	test "$master_second" != "$mirror_second"
+'
+
+test_done
-- 
2.1.0.rc2.206.gedb03e5
