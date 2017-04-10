Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E545B20966
	for <e@80x24.org>; Mon, 10 Apr 2017 12:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbdDJM7W (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 08:59:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34436 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbdDJM7W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 08:59:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id x75so9525106wma.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXJF1RZKnerO8fnE1AU3rIkxeO+FlQYXi7nZFHHMZGQ=;
        b=tSEgNkJsi8A6qJsVLg+/ECHo8OoghjCD0FuQwTNmV6Tz8KgbVJ6kMHANfXDQ2Mz2WN
         sviTQT+6IROw/f3i1lRfiEg91LrnKYC6QEi8JS+Bsdka0b2XB0U4jriQYLhhRaanQUB+
         BKzAo6ERZAbw4lr/zAcUQzvYa4StLtvBcQXZOQ8dzIr2MfXSv17cR5rKRoXNRGL0W4dP
         wAB5rAoUQfhD7j3dloAn4vREDc2IZY1WlnyxNTEHdhBAUZg1nLGJ1+xTaBLY9bwvoaSn
         DtKaPIviKSZLPYB5i9tKVqoq8UNrPz/Gx0h8hpVSUdSOqNSj5prlHja71rpg+JwDuPoV
         JUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXJF1RZKnerO8fnE1AU3rIkxeO+FlQYXi7nZFHHMZGQ=;
        b=mZwReQGRVMnW2MoCejYM8rSqNIhqxg8Q0yUZql5vON7n/VB/g65tyCHclrL7hyngEi
         XbF09CN/RHBmnM4IU67iIqPWWmRY1ppGZZwpN0pa8WHQS6PYAaenFMYA+nKWvI+xvj95
         a4eF8glsh25If3keEZcrFityxaf/cQX3dCrXJjZ1jB5li4mc6fPWtDdDPK4l9tpMCOHM
         Qloq5DsD/SunmD95HFZQHfk7b0/tLoJWFYrTHXJKqlP9Rgad3CI+nUjiLzDIaqkCx/li
         rsj/C2hplCUFK3xAp2NsXRJ+g6gDQKYUvWNMVji3MozwpUvpk81FMF8BY0F6syKfIBET
         3Tbw==
X-Gm-Message-State: AN3rC/6kvHVBEmkVA77I6y/vg46nQkRC7XcfDpe5NcyQLhr3nCJdkxSFEaE9MbYWExnJQA==
X-Received: by 10.28.98.66 with SMTP id w63mr9551477wmb.33.1491829160445;
        Mon, 10 Apr 2017 05:59:20 -0700 (PDT)
Received: from localhost.localdomain (x590cc874.dyn.telefonica.de. [89.12.200.116])
        by smtp.gmail.com with ESMTPSA id p38sm17387855wrb.31.2017.04.10.05.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 05:59:20 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t6500: don't run detached auto gc at the end of the test script
Date:   Mon, 10 Apr 2017 14:59:11 +0200
Message-Id: <20170410125911.6800-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.2.613.g9c5b79913
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last test in 't6500-gc', 'background auto gc does not run if
gc.log is present and recent but does if it is old', added in
a831c06a2 (gc: ignore old gc.log files, 2017-02-10), may sporadically
trigger an error message from the test harness:

  rm: cannot remove 'trash directory.t6500-gc/.git/objects': Directory not empty

The test in question ends with executing an auto gc in the backround,
which occasionally takes so long that it's still running when
'test_done' is about to remove the trash directory.  This 'rm -rf
$trash' in the foreground might race with the detached auto gc to
create and delete files and directories, and gc might (re-)create a
path that 'rm' already visited and removed, triggering the above error
when 'rm' attempts to remove its parent directory.

Commit bb05510e5 (t5510: run auto-gc in the foreground, 2016-05-01)
fixed the same problem in a different test script by simply
disallowing background gc.  Unfortunately, what worked there is not
applicable here, because the purpose of this test is to check the
behavior of a detached auto gc.

Move the detached auto gc execution further away from the end of the
test script by splitting the test in two: run the 'background auto gc
runs if an old gc.log is present' part first, leaving only the
aborting auto gc executions in the last test.  Run the first test's
detached auto gc in a dedicated sub-repository to prevent it from
interfering with the subseqent test's gc.  Also add a comment at the
end of the test script to warn developers of future tests about this
issue.

While this change doesn't completely eliminate the possibility of
this race, it significantly and seemingly sufficiently reduces its
probability.  Running t6500 in a loop while my box was under heavy CPU
and I/O load usually triggered the error under 15 seconds, but with
this patch it run overnight without incident.

(Alternatively, we could check the presence of the gc.pid file after
starting the detached auto gc, and wait while it's there.  However,
this would create a different race: the auto gc process creates the
pid file after it goes to the background, so our check in the
foreground might racily look for the pid file before it's even
created, and thus would not wait for the background gc to finish.
Furthermore, this would open up the possibility of the test hanging if
something were to go wrong with the gc process and the pid file were
not removed.)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6500-gc.sh | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 08de2e8ab..2dc202c9b 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -67,7 +67,27 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 	test_line_count = 2 new # There is one new pack and its .idx
 '
 
-test_expect_success 'background auto gc does not run if gc.log is present and recent but does if it is old' '
+test_expect_success 'background auto gc runs if an old gc.log is present' '
+	# The detached auto gc process can run long enough in the
+	# background to racily interfere with the gc execution in the
+	# subsequent test, hence the dedicated repository.
+	test_create_repo other &&
+	(
+		cd other &&
+		test_commit foo &&
+		git repack &&
+		test_commit bar &&
+		git repack &&
+		git config gc.autopacklimit 1 &&
+		git config gc.autodetach true &&
+		git config gc.logexpiry 2.days &&
+		echo fleem >.git/gc.log &&
+		test-chmtime =-345600 .git/gc.log &&	# 4 days
+		git gc --auto
+	)
+'
+
+test_expect_success 'background auto gc does not run if gc.log is present' '
 	test_commit foo &&
 	test_commit bar &&
 	git repack &&
@@ -77,10 +97,12 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
 	test_must_fail git gc --auto 2>err &&
 	test_i18ngrep "^error:" err &&
 	test_config gc.logexpiry 5.days &&
-	test-chmtime =-345600 .git/gc.log &&
-	test_must_fail git gc --auto &&
-	test_config gc.logexpiry 2.days &&
-	git gc --auto
+	test-chmtime =-345600 .git/gc.log &&	# 4 days
+	test_must_fail git gc --auto
 '
 
+# DO NOT leave a detached auto gc process running near the end of the
+# test script: it can run long enough in the background to racily
+# interfere with the cleanup in 'test_done'.
+
 test_done
-- 
2.12.2.613.g9c5b79913

