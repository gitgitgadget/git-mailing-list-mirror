Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBB7A1FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 22:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbdDLWHd (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 18:07:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35640 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbdDLWHc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 18:07:32 -0400
Received: by mail-wr0-f193.google.com with SMTP id l44so6160088wrc.2
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 15:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fxIPC0EMZCCfdcvo84TCRW8zNMHo6MftWTRbuWYJwVw=;
        b=XmbhrZSGyBjaBuYDB3TuuXmdTs87LqW6zsAuG2S7Hl7oUHgCNGAeyAj0AJtWDA1hvY
         I1Ah61qp+qcMIb89PAgSYCrSRj3pdEngHyPf+DXJ6GLL9Na8ADf27UhaIAQshO8ljVx4
         HzJKd1Ws2PcRyojYIS4g17lCkFVlwSn83QPoV6nj44ugWNTX+kmNNRo6PPcY+7G+jfkH
         9v69NjuoTiuoIs43xEJ0cVkJXKUQ12M1Pz86jzATC7KfeFO9b5wkvOBEEN8OJaiJV7Qo
         E1hivi2dPp4yqCr7rMAbUX+qQ5SHEBeDEhf8dvEhxozri3lxI31cxAwot7fkRCMBnkeE
         rbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fxIPC0EMZCCfdcvo84TCRW8zNMHo6MftWTRbuWYJwVw=;
        b=F3M7q95Y9b3ln4mSAHGZkJ+yS+IG+gbs1Qxzpe0EbP9zZQU7ObJMZdbWH5ubcLtJo4
         PxzVTuwrs4XuDlIxpjmF+06yyC1Fw66VU6dpR4HFqcb5V63JItl5QwgSTPgn8/xll52u
         9yHAyYFdHq8kqJqvo7qCzDiBEUIOEy52oyuzss//LjzXRSKwDpV8TjgN5ZB9L0UF0Ota
         lREDpWqVBZtnBt6GWIg7KMZStJzduWGCz6VvMzY1+pf2ukU6/ZSaq8UlAt3Qg/A1krUq
         EXkuyXNmwD4RXzdw2suOVh/v24pqlE1Pu0bDc91T2jhUR3cqgSsq9r1V56PiF+agXW+E
         n+Yw==
X-Gm-Message-State: AN3rC/6eBiPQ2kGmmRPyxRuUXcX00ewiU0x8DflsDGUzCouqccVI3HbM0MzclgbTFu8Dig==
X-Received: by 10.223.178.225 with SMTP id g88mr4658484wrd.126.1492034850462;
        Wed, 12 Apr 2017 15:07:30 -0700 (PDT)
Received: from localhost.localdomain (x590d786b.dyn.telefonica.de. [89.13.120.107])
        by smtp.gmail.com with ESMTPSA id 201sm8144430wmr.5.2017.04.12.15.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Apr 2017 15:07:29 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2] t6500: don't run detached auto gc at the end of the test script
Date:   Thu, 13 Apr 2017 00:07:17 +0200
Message-Id: <20170412220717.7357-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.2.613.g9c5b79913
In-Reply-To: <CAM0VKjkuoCotm8FB5qdTQsC0SaJiwBA9dXmdLJdSs8NwLdY8fQ@mail.gmail.com>
References: <CAM0VKjkuoCotm8FB5qdTQsC0SaJiwBA9dXmdLJdSs8NwLdY8fQ@mail.gmail.com>
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
message when 'rm' attempts to remove its parent directory.

Commit bb05510e5 (t5510: run auto-gc in the foreground, 2016-05-01)
fixed the same problem in a different test script by simply
disallowing background gc.  Unfortunately, what worked there is not
applicable here, because the purpose of this test is to check the
behavior of a detached auto gc.

Make sure that the test doesn't continue before the gc is finished in
the background with a clever bit of shell trickery:

  - Open fd 9 in the shell, to be inherited by the background gc
    process, because our daemonize() only closes the standard fds 0,
    1 and 2.
  - Duplicate this fd 9 to stdout.
  - Read 'git gc's stdout, and thus fd 9, through a command
    substitution.  We don't actually care about gc's output, but this
    construct has two useful properties:
  - This read blocks until stdout or fd 9 are open.  While stdout is
    closed after the main gc process creates the background process
    and exits, fd 9 remains open until the backround process exits.
  - The variable assignment from the command substitution gets its
    exit status from the command executed within the command
    substitution, i.e. a failing main gc process will cause the test
    to fail.

Note, that this fd trickery doesn't work on Windows, because due to
MSYS limitations the git process only inherits the standard fds 0, 1
and 2 from the shell.  Luckily, it doesn't matter in this case,
because on Windows daemonize() is basically a noop, thus 'git gc
--auto' always runs in the foreground.

And since we can now continue the test reliably after the detached gc
finished, check that there is only a single packfile left at the end,
i.e. that the detached gc actually did what it was supposed to do.
Also add a comment at the end of the test script to warn developers of
future tests about this issue of long running detached gc processes.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6500-gc.sh | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 08de2e8ab..cc7acd101 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -67,6 +67,16 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 	test_line_count = 2 new # There is one new pack and its .idx
 '
 
+run_and_wait_for_auto_gc () {
+	# We read stdout from gc for the side effect of waiting until the
+	# background gc process exits, closing its fd 9.  Furthermore, the
+	# variable assignment from a command substitution preserves the
+	# exit status of the main gc process.
+	# Note: this fd trickery doesn't work on Windows, but there is no
+	# need to, because on Win the auto gc always runs in the foreground.
+	doesnt_matter=$(git gc --auto 9>&1)
+}
+
 test_expect_success 'background auto gc does not run if gc.log is present and recent but does if it is old' '
 	test_commit foo &&
 	test_commit bar &&
@@ -80,7 +90,13 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
 	test-chmtime =-345600 .git/gc.log &&
 	test_must_fail git gc --auto &&
 	test_config gc.logexpiry 2.days &&
-	git gc --auto
+	run_and_wait_for_auto_gc &&
+	ls .git/objects/pack/pack-*.pack >packs &&
+	test_line_count = 1 packs
 '
 
+# DO NOT leave a detached auto gc process running near the end of the
+# test script: it can run long enough in the background to racily
+# interfere with the cleanup in 'test_done'.
+
 test_done
-- 
2.12.2.613.g9c5b79913

