Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA7AF1F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 06:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeGKGu4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 02:50:56 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41110 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeGKGuy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 02:50:54 -0400
Received: by mail-io0-f193.google.com with SMTP id q9-v6so22633963ioj.8
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 23:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2I7OYueBaU/f8ltzSekxyPxjmldCQGi0kGgjwtn553k=;
        b=ZDwnULCipm8U9r5JOCYktsl5Ljd59P+XkmkI1p6NX2/gldBVp9djuyR1oMVwXD9+l1
         +6jsK1zVRqi6t/62uEfpq6J/gJHCmnos+3rBqzNBnXwAykUy5Wa6/F2KKP6/JZlAjAsI
         ZpUUt7VCHYAJ8gq5It+XHet6mLHSM82iLqFfTQY6ypN9owxTeaJwHnyLX3XAmcGtvHHj
         SI6KcijcgIa0O5/pGmItMWVs0t+NWmOAgh+c/WpnpFa/koIbFLNx9E1nhmGtc0cemLvs
         Qwzafd77gj6+9JaE+f2VMXwjKug0gdjjlgUXESDj5c6ON0W+/s7w3CzpvTmhCho6PF56
         VcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=2I7OYueBaU/f8ltzSekxyPxjmldCQGi0kGgjwtn553k=;
        b=bfokPmtazEKbjBG0/8H4l9E+jV5PKlGlm1wxCa4LhTeSEwFr5eqPYLJU6v79MOrmCZ
         7+cDR63ZYPCBu49BcFEAr2ITFhHERJY4n1IDIJK3k/POkG3LKCLnF6XnRoy0K9DJMRCj
         KOz+WLT9HCsdNqAguLZXeikwwW/RNqYOjaAozkFHLobd5lwHpbwki9mFwdDzXMztt+14
         h7izNB5hBu6UmAv5UETI9Ebtrc7SUf5xLh1uBYBTFIcVqtTJ2SCPVuVw65WudzuPZ0/L
         lA02hsLursNjeydgkAGs7L0iQvmf1nBIplfETkWWA6GNRubSLYtsR0CVvHaH32eoAJmX
         cziw==
X-Gm-Message-State: APt69E1VHgfo+Wv/wjEwbNs4eryFHx+2FTIXW18hfsQagb1KkGMUrJuJ
        B2BsxYOlTx18eTahMZZrfnKHOQ==
X-Google-Smtp-Source: AAOMgpcO9XiSicPMHhRo8GaN6m0JsA8wIiBIV/8YO2AiX1vG1FUiPiJYq++AS4njzJlMRWPm2NpLqQ==
X-Received: by 2002:a6b:bd43:: with SMTP id n64-v6mr24406503iof.254.1531291689120;
        Tue, 10 Jul 2018 23:48:09 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id b143-v6sm11308298ioe.66.2018.07.10.23.48.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 23:48:08 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 08/10] t/chainlint: add chainlint "cuddled" test cases
Date:   Wed, 11 Jul 2018 02:46:40 -0400
Message-Id: <20180711064642.6933-9-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180711064642.6933-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --chain-lint option uses heuristics and knowledge of shell syntax to
detect broken &&-chains in subshells by pure textual inspection. The
heuristics handle a range of stylistic variations in existing tests
(evolved over the years), however, they are still best-guesses. As such,
it is possible for future changes to accidentally break assumptions upon
which the heuristics are based. Protect against this possibility by
adding tests which check the linter itself for correctness.

In addition to protecting against regressions, these tests help document
(for humans) expected behavior, which is important since the linter's
implementation language ('sed') does not necessarily lend itself to easy
comprehension.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint/cuddled-if-then-else.expect |  7 +++++++
 t/chainlint/cuddled-if-then-else.test   |  7 +++++++
 t/chainlint/cuddled-loop.expect         |  5 +++++
 t/chainlint/cuddled-loop.test           |  7 +++++++
 t/chainlint/cuddled.expect              | 21 +++++++++++++++++++++
 t/chainlint/cuddled.test                | 23 +++++++++++++++++++++++
 6 files changed, 70 insertions(+)
 create mode 100644 t/chainlint/cuddled-if-then-else.expect
 create mode 100644 t/chainlint/cuddled-if-then-else.test
 create mode 100644 t/chainlint/cuddled-loop.expect
 create mode 100644 t/chainlint/cuddled-loop.test
 create mode 100644 t/chainlint/cuddled.expect
 create mode 100644 t/chainlint/cuddled.test

diff --git a/t/chainlint/cuddled-if-then-else.expect b/t/chainlint/cuddled-if-then-else.expect
new file mode 100644
index 0000000000..ab2a026fbc
--- /dev/null
+++ b/t/chainlint/cuddled-if-then-else.expect
@@ -0,0 +1,7 @@
+(
+if test -z ""; then
+    echo empty
+ else
+    echo bizzy
+> fi) &&
+echo foobar
diff --git a/t/chainlint/cuddled-if-then-else.test b/t/chainlint/cuddled-if-then-else.test
new file mode 100644
index 0000000000..eed774a9d6
--- /dev/null
+++ b/t/chainlint/cuddled-if-then-else.test
@@ -0,0 +1,7 @@
+# LINT: 'if' cuddled with "(" and ")"; indented with spaces, not tabs
+(if test -z ""; then
+    echo empty
+ else
+    echo bizzy
+ fi) &&
+echo foobar
diff --git a/t/chainlint/cuddled-loop.expect b/t/chainlint/cuddled-loop.expect
new file mode 100644
index 0000000000..8c0260d7f1
--- /dev/null
+++ b/t/chainlint/cuddled-loop.expect
@@ -0,0 +1,5 @@
+(
+ while read x
+  do foobar bop || exit 1
+>  done <file ) &&
+outside subshell
diff --git a/t/chainlint/cuddled-loop.test b/t/chainlint/cuddled-loop.test
new file mode 100644
index 0000000000..a841d781f0
--- /dev/null
+++ b/t/chainlint/cuddled-loop.test
@@ -0,0 +1,7 @@
+# LINT: 'while' loop cuddled with "(" and ")", with embedded (allowed)
+# LINT: "|| exit {n}" to exit loop early, and using redirection "<" to feed
+# LINT: loop; indented with spaces, not tabs
+( while read x
+  do foobar bop || exit 1
+  done <file ) &&
+outside subshell
diff --git a/t/chainlint/cuddled.expect b/t/chainlint/cuddled.expect
new file mode 100644
index 0000000000..b506d46221
--- /dev/null
+++ b/t/chainlint/cuddled.expect
@@ -0,0 +1,21 @@
+(
+cd foo &&
+	bar
+>) &&
+
+(
+?!AMP?!cd foo
+	bar
+>) &&
+
+(
+	cd foo &&
+>	bar) &&
+
+(
+cd foo &&
+>	bar) &&
+
+(
+?!AMP?!cd foo
+>	bar)
diff --git a/t/chainlint/cuddled.test b/t/chainlint/cuddled.test
new file mode 100644
index 0000000000..0499fa4180
--- /dev/null
+++ b/t/chainlint/cuddled.test
@@ -0,0 +1,23 @@
+# LINT: first subshell statement cuddled with opening "("; for implementation
+# LINT: simplicity, "(..." is split into two lines, "(" and "..."
+(cd foo &&
+	bar
+) &&
+
+# LINT: same with missing "&&"
+(cd foo
+	bar
+) &&
+
+# LINT: closing ")" cuddled with final subshell statement
+(
+	cd foo &&
+	bar) &&
+
+# LINT: "(" and ")" cuddled with first and final subshell statements
+(cd foo &&
+	bar) &&
+
+# LINT: same with missing "&&"
+(cd foo
+	bar)
-- 
2.18.0.203.gfac676dfb9

