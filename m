Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B08F41F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 06:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeGKGux (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 02:50:53 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37234 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeGKGuw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 02:50:52 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so22640723ioh.4
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 23:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=46yYIJQiuOXatLnyWf4w1OrABsvS+FtqLhPje1yxg2M=;
        b=HYFYdI/aSQHM8Lic3kP+4AyWVSGTeNvr3pafGmnlP/FFxgMRZeEramMCkFUuxIBKMc
         HTREWQ2SjNwzVCpWRtp3aD0ZV9G5ieTtYgAOPPpCnjjOsjKWaV+Fl5o+J2LEvkVPNhkP
         SgmqMjL5+axRabw8Q4GC1x1aQHu+M6ykRmnHz123UzzNtQ+KS4prGC3r1eWqlTki6D58
         xuF844xdQJTzhfTyH3yM5cP5sNWSKadJ5MA6jZXq4wlPt8M52DwQ8enpP6IK+31iljbh
         Pjb6Qx1CgomDN6rn2PIxxUO0WG4U0E6Yu6wmsfb2nkAzIwV1VvQpAvBjEHDG/FwYMYJD
         kuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=46yYIJQiuOXatLnyWf4w1OrABsvS+FtqLhPje1yxg2M=;
        b=lQ/sVeOc0Xw9fWYBvQaBDZh18d/8fHKZLe4eN0Q2ZBlylgqFdZpI1Q+kFFStmE7Hyf
         QxoHHeieCIx1bb+OoRVesgh3653O6C6FNqykQBCOZeu7+LKK1IN8qwiryXCOYvfCto/o
         JCEiFjikFvIsHKWR+Ycu5nGomDXR9mvfdQiWmVH41NsJlV11y6FrrOpdRDjCkESPkcKF
         cTqDFBCqEmH2PeSC0JllJN3dTdDadzHLJ2rAuL3kgahmPxVpboEieymjaWZ11alNbHmW
         kgDkAbiNsWKgObz3fpmwVdzyLcmxj3TvT9SIrtmt8+ON4cAgS7vBWBv1OSMjbBy9zPL2
         JP5Q==
X-Gm-Message-State: AOUpUlGNT/9XbeJdKqMkmbAoYEqOy49ArbzEyzBmzgkyD0RKm5LKdgDY
        ezfy3gsISCaWmBhYKrLpi2cTxg==
X-Google-Smtp-Source: AAOMgpcrsR4IbLCpLJIBStKYG/n5/JvrZ9O++m/zEiwSuh+FdtEkXt2n/QOWakkgFk1HSWT9yVEG9w==
X-Received: by 2002:a6b:de09:: with SMTP id v9-v6mr2995431iog.10.1531291686333;
        Tue, 10 Jul 2018 23:48:06 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id b143-v6sm11308298ioe.66.2018.07.10.23.48.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 23:48:05 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 05/10] t/chainlint: add chainlint "one-liner" test cases
Date:   Wed, 11 Jul 2018 02:46:37 -0400
Message-Id: <20180711064642.6933-6-sunshine@sunshineco.com>
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
 t/chainlint/negated-one-liner.expect  |  5 +++++
 t/chainlint/negated-one-liner.test    |  7 +++++++
 t/chainlint/one-liner.expect          |  9 +++++++++
 t/chainlint/one-liner.test            | 12 ++++++++++++
 t/chainlint/subshell-one-liner.expect | 14 ++++++++++++++
 t/chainlint/subshell-one-liner.test   | 24 ++++++++++++++++++++++++
 6 files changed, 71 insertions(+)
 create mode 100644 t/chainlint/negated-one-liner.expect
 create mode 100644 t/chainlint/negated-one-liner.test
 create mode 100644 t/chainlint/one-liner.expect
 create mode 100644 t/chainlint/one-liner.test
 create mode 100644 t/chainlint/subshell-one-liner.expect
 create mode 100644 t/chainlint/subshell-one-liner.test

diff --git a/t/chainlint/negated-one-liner.expect b/t/chainlint/negated-one-liner.expect
new file mode 100644
index 0000000000..cf18429d03
--- /dev/null
+++ b/t/chainlint/negated-one-liner.expect
@@ -0,0 +1,5 @@
+! (foo && bar) &&
+! (foo && bar) >baz &&
+
+?!SEMI?!! (foo; bar) &&
+?!SEMI?!! (foo; bar) >baz
diff --git a/t/chainlint/negated-one-liner.test b/t/chainlint/negated-one-liner.test
new file mode 100644
index 0000000000..c9598e9153
--- /dev/null
+++ b/t/chainlint/negated-one-liner.test
@@ -0,0 +1,7 @@
+# LINT: top-level one-liner subshell
+! (foo && bar) &&
+! (foo && bar) >baz &&
+
+# LINT: top-level one-liner subshell missing internal "&&"
+! (foo; bar) &&
+! (foo; bar) >baz
diff --git a/t/chainlint/one-liner.expect b/t/chainlint/one-liner.expect
new file mode 100644
index 0000000000..237f227349
--- /dev/null
+++ b/t/chainlint/one-liner.expect
@@ -0,0 +1,9 @@
+(foo && bar) &&
+(foo && bar) |
+(foo && bar) >baz &&
+
+?!SEMI?!(foo; bar) &&
+?!SEMI?!(foo; bar) |
+?!SEMI?!(foo; bar) >baz
+
+(foo "bar; baz")
diff --git a/t/chainlint/one-liner.test b/t/chainlint/one-liner.test
new file mode 100644
index 0000000000..ec9acb9825
--- /dev/null
+++ b/t/chainlint/one-liner.test
@@ -0,0 +1,12 @@
+# LINT: top-level one-liner subshell
+(foo && bar) &&
+(foo && bar) |
+(foo && bar) >baz &&
+
+# LINT: top-level one-liner subshell missing internal "&&"
+(foo; bar) &&
+(foo; bar) |
+(foo; bar) >baz
+
+# LINT: ";" in string not misinterpreted as broken &&-chain
+(foo "bar; baz")
diff --git a/t/chainlint/subshell-one-liner.expect b/t/chainlint/subshell-one-liner.expect
new file mode 100644
index 0000000000..51162821d7
--- /dev/null
+++ b/t/chainlint/subshell-one-liner.expect
@@ -0,0 +1,14 @@
+(
+	(foo && bar) &&
+	(foo && bar) |
+	(foo && bar) >baz &&
+?!SEMI?!	(foo; bar) &&
+?!SEMI?!	(foo; bar) |
+?!SEMI?!	(foo; bar) >baz &&
+	(foo || exit 1) &&
+	(foo || exit 1) |
+	(foo || exit 1) >baz &&
+?!AMP?!	(foo && bar)
+?!AMP?!?!SEMI?!	(foo && bar; baz)
+	foobar
+>)
diff --git a/t/chainlint/subshell-one-liner.test b/t/chainlint/subshell-one-liner.test
new file mode 100644
index 0000000000..37fa643c20
--- /dev/null
+++ b/t/chainlint/subshell-one-liner.test
@@ -0,0 +1,24 @@
+(
+# LINT: nested one-liner subshell
+	(foo && bar) &&
+	(foo && bar) |
+	(foo && bar) >baz &&
+
+# LINT: nested one-liner subshell missing internal "&&"
+	(foo; bar) &&
+	(foo; bar) |
+	(foo; bar) >baz &&
+
+# LINT: nested one-liner subshell with "|| exit"
+	(foo || exit 1) &&
+	(foo || exit 1) |
+	(foo || exit 1) >baz &&
+
+# LINT: nested one-liner subshell lacking ending "&&"
+	(foo && bar)
+
+# LINT: nested one-liner subshell missing internal "&&" and lacking ending "&&"
+	(foo && bar; baz)
+
+	foobar
+)
-- 
2.18.0.203.gfac676dfb9

