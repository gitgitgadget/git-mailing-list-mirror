Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86AD120A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 22:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeLIW4p (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 17:56:45 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:37489 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeLIW4p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 17:56:45 -0500
Received: by mail-wm1-f43.google.com with SMTP id g67so9328203wmd.2
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 14:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MlfKRqVZk1Wb/i/mdqD73Au+RG2j0lofWh+SpHb+YhU=;
        b=CycrDY81KGMQ7M9sRXVOycY8jF759UHnlCp86lHMpa6/XdjEFjhWm8VujHX+Tkv5Xk
         R/UfINSgQUasX7eYL6QN2heRnj+LZLR+mZBEZdw+AkNcY2JuX7un0HHeYppQRrOn7ZCY
         rOUWoFtwPNuYgHvXJFxc9pWmr/hk5IMoxmII08/q+9lar1vWO7gStqe4xXAOUpnS3W2M
         /y81TfoRMrj4aCYxW3w807HoRSc6OwXSeeuvJfBhqbEcCrUr+Odwd3RXWIHR7pnR2t/I
         sIO+AxHiGu8S4JBCGfRbYJAfEmPdXweMJRQjvwAOuHTHE124wRblEV6+vHkYY+dcpKos
         5o+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlfKRqVZk1Wb/i/mdqD73Au+RG2j0lofWh+SpHb+YhU=;
        b=RrHJZqnrIhs/tIjQmkr/wZ476BL028nXafujEcGMd71YzIa4z9gMnwY4CexWEHTXWm
         eDUPvv7TFms6yMLfIrZskdBz/osrJ9USf5gEPeqSlxFGyNDMuZv/3cnsCRlFrOoxiI3W
         elbFTg//pzCB99wF5p7SJIMA+w9V/oUapYlxSsBH8DcwHD18k7sLxJp8hcrUilfon/Lm
         Kx/vHTZGOCYaexcg93fZ2Jm60TxzgurZwnUh++RPZBZnOE2REIBnvtcEtWiDcveodtdl
         8Bid7MD062yiD5jTfrqRXcFlmxbfS/+6nxHtr09WBMsI5pFLJccb7iqHclG/QKvFmpTN
         +XZQ==
X-Gm-Message-State: AA+aEWYJVquLxnl57y4+PmK7TcN9MNCsUm0rqO7NN4C2mV9RSfcaOcL/
        mRepU/g1+QIAVsh59uTALTitQUZY
X-Google-Smtp-Source: AFSGD/WW/c3TT4tZOfxSL16Ch+yaHvzvpMXR66GQnNLy0KvKqwZd+QI7EsGVrpW8Zz48oa9s2B+ZRA==
X-Received: by 2002:a1c:8302:: with SMTP id f2mr9179655wmd.9.1544396202791;
        Sun, 09 Dec 2018 14:56:42 -0800 (PST)
Received: from localhost.localdomain (x4db97970.dyn.telefonica.de. [77.185.121.112])
        by smtp.gmail.com with ESMTPSA id w6sm12581807wme.46.2018.12.09.14.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 14:56:42 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 5/7] test-lib: extract Bash version check for '-x' tracing
Date:   Sun,  9 Dec 2018 23:56:26 +0100
Message-Id: <20181209225628.22216-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.156.g5a9fd2ce9c
In-Reply-To: <20181209225628.22216-1-szeder.dev@gmail.com>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181209225628.22216-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of our test scripts can't be reliably run with '-x' tracing
enabled unless executed with a Bash version supporting BASH_XTRACEFD
(since v4.1), and we have a lengthy condition to disable tracing if
such a test script is not executed with a suitable Bash version.

Move this check out from the option parsing loop, so other options can
imply '-x' by setting 'trace=t', without missing this Bash version
check.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ea1cd34013..d55d158580 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -333,24 +333,7 @@ do
 		GIT_TEST_CHAIN_LINT=0
 		shift ;;
 	-x)
-		# Some test scripts can't be reliably traced  with '-x',
-		# unless the test is run with a Bash version supporting
-		# BASH_XTRACEFD (introduced in Bash v4.1).  Check whether
-		# this test is marked as such, and ignore '-x' if it
-		# isn't executed with a suitable Bash version.
-		if test -z "$test_untraceable" || {
-		     test -n "$BASH_VERSION" && {
-		       test ${BASH_VERSINFO[0]} -gt 4 || {
-			 test ${BASH_VERSINFO[0]} -eq 4 &&
-			 test ${BASH_VERSINFO[1]} -ge 1
-		       }
-		     }
-		   }
-		then
-			trace=t
-		else
-			echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
-		fi
+		trace=t
 		shift ;;
 	--tee|\
 	-V|--verbose-log|\
@@ -373,6 +356,24 @@ then
 	test -z "$verbose_log" && verbose=t
 fi
 
+if test -n "$trace" && test -n "$test_untraceable"
+then
+	# '-x' tracing requested, but this test script can't be reliably
+	# traced, unless it is run with a Bash version supporting
+	# BASH_XTRACEFD (introduced in Bash v4.1).
+	if test -n "$BASH_VERSION" && {
+	     test ${BASH_VERSINFO[0]} -gt 4 || {
+	       test ${BASH_VERSINFO[0]} -eq 4 &&
+	       test ${BASH_VERSINFO[1]} -ge 1
+	     }
+	   }
+	then
+		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
+	else
+		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
+		trace=
+	fi
+fi
 if test -n "$trace" && test -z "$verbose_log"
 then
 	verbose=t
-- 
2.20.0.rc2.156.g5a9fd2ce9c

