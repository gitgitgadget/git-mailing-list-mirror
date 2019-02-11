Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4CFC1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 19:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfBKT6M (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 14:58:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33479 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfBKT6M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 14:58:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id h22so636668wmb.0
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 11:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4j81pa3fWP7QITVDfky91jNczRYwLh3+371HGbizSfE=;
        b=hk4I1Hyj/DnYZsVhw7XLiiXZZPin652Xdat9oIQSN+/3PQScDl91FK8imv66/0Wqqp
         XqqbWFnu1nDFNbyy8+XggeKf0ZN8lgoNkjRtlZ3FbUWc7phxHT+QvcUCT4qpmtcnUNSy
         VimsELz1IJgVAsSDz+ULB2StFI5nw/cqjdHvLGqpfazPnohnLFOYZNLF6VtBzGeYTFGg
         iMAvRbFJvdokQt6q9/9ecuyqJiRUIjcX3p2EfCKWnNSuVXH8hV4L5WNUXTd2ODZQsMGi
         GXp60chTSUMi5RxFf4mHjTOIu11CY74R/Z/6EQj4jAq28rj4PPKo+musE/Yvt12xJ/J6
         jpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4j81pa3fWP7QITVDfky91jNczRYwLh3+371HGbizSfE=;
        b=Za9KUL9WC4Cp3Tl+F0I7G4dTpoK1XJeNZG7C/f5M/3moQfKtPRICWc9OzVv8609WzI
         qGUk5ZJCZsfJSOMV+rGzAfj/ciivPJYK5792UXrnboD3ka8245SqaK/ZWw9AHN05IinH
         MSZn1JjsY0ECyjJgTtsE8AVsHC7mcQdw+dTpY8Er5xgACS3TxVZthn1S54wf2DJI8Wvu
         YPLyoKRrm+1xRYA++16VjdnTZ3gSRxH83VD0px9CWx6HHDBr2L+VjKXsrZ+XTPOKKLAu
         BaN0HcIbIwhSrVwSJ4Kjz+PaNvJSr2Gy9ZgOHSOJ4o2TbZ3/If857JmnUVK4SenGpgfU
         ORLg==
X-Gm-Message-State: AHQUAub8YFNHqZ2RuhToiBu7mMXcYCTQb02TfAL/i57DDhEGKBlQkFDQ
        xpLVeAZub+pzzMDLk+uS/SA6+S2V
X-Google-Smtp-Source: AHgI3IZnrJsoKGj3/nzEVkueDqSZ9q7NzvPlT2zZWF6WlcURhrFfCK6esBUCoWhxhdCa/IWxeRQURA==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr881002wme.134.1549915090674;
        Mon, 11 Feb 2019 11:58:10 -0800 (PST)
Received: from localhost.localdomain (x4dbe9d5f.dyn.telefonica.de. [77.190.157.95])
        by smtp.gmail.com with ESMTPSA id 2sm27504231wrg.89.2019.02.11.11.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 11:58:09 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] test-lib: fix non-portable pattern bracket expressions
Date:   Mon, 11 Feb 2019 20:58:03 +0100
Message-Id: <20190211195803.1682-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.405.g6226d63c89
In-Reply-To: <20190208115045.13256-1-szeder.dev@gmail.com>
References: <20190208115045.13256-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a '!' character to start a non-matching pattern bracket
expression, as specified by POSIX in Shell Command Language section
2.13.1 Patterns Matching a Single Character [1].

I used '^' instead in three places in the previous three commits, to
verify that the arguments of the '--stress=' and '--stress-limit='
options and the values of various '*_PORT' environment variables are
valid numbers.  With certain shells, at least with dash (upstream and
in Ubuntu 14.04) and mksh, this led to various undesired behaviors:

  # error message in case of a valid number
  $ ~/src/dash/src/dash ./t3903-stash.sh --stress=8
  error: --stress=<N> requires the number of jobs to run

  # not the expected error message
  $ ~/src/dash/src/dash ./t3903-stash.sh --stress=foo
  ./t3903-stash.sh: 238: test: Illegal number: foo

  # no error message at all?!
  $ mksh ./t3903-stash.sh --stress=foo
  $ echo $?
  0

Some other shells, e.g. Bash (even in posix mode), ksh, dash in Ubuntu
16.04 or later, are apparently happy to accept '^' just as well.

[1] http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_13

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Should go on top of 'sg/stress-test'.


 t/test-lib-functions.sh | 2 +-
 t/test-lib.sh           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 92cf8f812c..969e2ba6da 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1289,7 +1289,7 @@ test_set_port () {
 			port=$(($port + 10000))
 		fi
 		;;
-	*[^0-9]*|0*)
+	*[!0-9]*|0*)
 		error >&7 "invalid port number: $port"
 		;;
 	*)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 77eff04c92..4e7cb52b57 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -144,7 +144,7 @@ do
 	--stress=*)
 		stress=${opt#--*=}
 		case "$stress" in
-		*[^0-9]*|0*|"")
+		*[!0-9]*|0*|"")
 			echo "error: --stress=<N> requires the number of jobs to run" >&2
 			exit 1
 			;;
@@ -155,7 +155,7 @@ do
 	--stress-limit=*)
 		stress_limit=${opt#--*=}
 		case "$stress_limit" in
-		*[^0-9]*|0*|"")
+		*[!0-9]*|0*|"")
 			echo "error: --stress-limit=<N> requires the number of repetitions" >&2
 			exit 1
 			;;
-- 
2.21.0.rc0.405.g6226d63c89

