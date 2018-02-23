Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF361F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbeBWXkN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:40:13 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:38825 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbeBWXkL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:40:11 -0500
Received: by mail-wr0-f181.google.com with SMTP id n7so15699075wrn.5
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nc4LkXqHBpD4+tgQgi/ds42E0nJ8a5pC1Zw1ektLNxk=;
        b=Vj511UqsA4gWKkl91fKd5Eo/Lg95ZiPjobyGAhaIUcolY0W8e90Y08MnTFMPgxJdqi
         xpElWqhF3PCfDLp38aUfMUUfO9mPInauix3nyQdvUO6rs9IZV8c+Uk5B/SVlb7Jfp8aJ
         m8xCwKyF4AjfNJsPr+8Z7Vzz1ze7HgaYtYBRkuYOC8BP6eeGiKT50b+2QpyRWunRauTt
         TEVIaXC0xyBf4aD8X+BEubcDmfG53TlAnPnKVecqlVFEKBPLzWQsr1MQnERR6oc5s9dd
         aE6635+286gua8kcXoEvGB8AgiTstY/W3gDnijbc4CPtRe4C7Bhzx+QZFP7+uNShVu9g
         T0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nc4LkXqHBpD4+tgQgi/ds42E0nJ8a5pC1Zw1ektLNxk=;
        b=Qt3xbfbwGf7DIdaWstHn5mPPUOYY+D9U1SwZLLxrE8qvs0jSCEkk6ACXu9tc9b6Ezj
         ZkzmF87Ys8cYjEP3weqlo/7jhWPHRVtXl/5oSUsutcoEBR8J6wGG8ZvhtCVMe5ihxyoc
         b5GUUwzcp6AVKadWWNvZFq360qJdG9dknb6SGM5LxlUZBEcOOleM/MUltPpePvIiqFPw
         S34LyWyZWum5MNLTzbNA0KSTKNb+4UeSGi3SLYGeuUAur0+wqjeRYUytHoDN3gCzsdyl
         hcfDtudj1NDFjpJznte4js8ZhqfS3sf5mL64q4waNak5vw1fZdlxC7rcYRee5cpBtfnA
         l/NQ==
X-Gm-Message-State: APf1xPALuYSJo7zqQSjVWDOn8Mxr7dyQgALvfxxG/XTZ1fgpi2wcXsYG
        +wP+tM9iMyjA74e7l2RKJou3Ig==
X-Google-Smtp-Source: AH8x226ue/eerasVoLowusZwu4Y4DD2JaPxfnF9f36Ix8b697sD4BfuBeR/nLr2EUnCFW74Vc6rBxQ==
X-Received: by 10.223.184.26 with SMTP id h26mr3318373wrf.65.1519429210463;
        Fri, 23 Feb 2018 15:40:10 -0800 (PST)
Received: from localhost.localdomain (x590e551c.dyn.telefonica.de. [89.14.85.28])
        by smtp.gmail.com with ESMTPSA id c14sm7028939wmh.2.2018.02.23.15.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 15:40:10 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 02/11] t: add means to disable '-x' tracing for individual test scripts
Date:   Sat, 24 Feb 2018 00:39:42 +0100
Message-Id: <20180223233951.11154-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.400.g911b7cc0da
In-Reply-To: <20180223233951.11154-1-szeder.dev@gmail.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous patch resolved most of the test failures caused by
running our test suite with '-x' tracing and /bin/sh, and the
following patches in this series will resolve almost all of the
remaining failures.  Unfortunately, not yet all.

Add means to disable '-x' tracing for individual test scripts by
setting the $test_untraceable variable to a non-empty value in the
test script before sourcing 'test-lib.sh'.  However, since '-x'
tracing is not an issue with recent Bash versions supporting
BASH_XTRACEFD, i.e. v4.1 and later, don't disable tracing when the
test script is run with such a Bash version even when
$test_untraceable is set.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/README      |  3 +++
 t/test-lib.sh | 19 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index b3f7b449c3..c430e9c52c 100644
--- a/t/README
+++ b/t/README
@@ -87,6 +87,9 @@ appropriately before running "make".
 	themselves. Implies `--verbose`. Note that in non-bash shells,
 	this can cause failures in some tests which redirect and test
 	the output of shell functions. Use with caution.
+	Ignored in test scripts that set the variable 'test_untraceable'
+	to a non-empty value, unless it's run with a Bash version
+	supporting BASH_XTRACEFD, i.e. v4.1 or later.
 
 -d::
 --debug::
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 33f6ce26f6..732213ef1b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,7 +263,24 @@ do
 		GIT_TEST_CHAIN_LINT=0
 		shift ;;
 	-x)
-		trace=t
+		# Some test scripts can't be reliably traced  with '-x',
+		# unless the test is run with a Bash version supporting
+		# BASH_XTRACEFD (introduced in Bash v4.1).  Check whether
+		# this test is marked as such, and ignore '-x' if it
+		# isn't executed with a suitable Bash version.
+		if test -z "$test_untraceable" || {
+		     test -n "$BASH_VERSION" && {
+		       test ${BASH_VERSINFO[0]} -gt 4 || {
+			 test ${BASH_VERSINFO[0]} -eq 4 &&
+			 test ${BASH_VERSINFO[1]} -ge 1
+		       }
+		     }
+		   }
+		then
+			trace=t
+		else
+			echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
+		fi
 		shift ;;
 	--verbose-log)
 		verbose_log=t
-- 
2.16.2.400.g911b7cc0da

