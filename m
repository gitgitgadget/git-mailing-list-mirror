Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF1A91F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 06:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeGKGuv (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 02:50:51 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37232 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeGKGuu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 02:50:50 -0400
Received: by mail-io0-f196.google.com with SMTP id z19-v6so22640672ioh.4
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9a1mZM/cE0EmvoO4MNbZvpdjhywZGD0T3WxD+FQ+a2M=;
        b=fJj72hbzZ3D3fevX94COlcBEDWRAIJR/gOSoyhnAEC/QacmE7KCTd0omkbNv4H2uP7
         f6Ow4VI+gNmTKZ2UWSz/Kknr66ceywT50jVCDuFJDxJ4JRCWnNJDOmCFQkUGRqB9sXuS
         7uXxkZBLy1p3hlC1O2qCV3yFwZJ8d40sCd0f9sudFjGgS+xHY7Uhc1ZvVrK0oA1TQl+M
         NSeoYrdXUtdRmDUM5fs/OBhd5XyLvz5/dMPEHOMlULX8z+aWvE8rkyd1R5HDIblyOHYg
         LEEGYZm2OBWAqWsh6W8JVXNZc9Y1jRTlFAZJUZuSxtkRfK9fPawk9Ocd0PIZZABzx5nz
         deQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=9a1mZM/cE0EmvoO4MNbZvpdjhywZGD0T3WxD+FQ+a2M=;
        b=JS/6pP4ogTOUkp0cqdkh+j0T9RxMGcocDt/70VZKqkm2C9uD65jeB4Cox5OBya76AX
         wEOUalS67ke5oSkvcxXE3mKGoIqNXWkPRf/+gbY7fbhcaD3OSFonLXM42/RcQKSB5sAi
         QR987o8Nx+l5j8H+UDB6R0yBrJS1W8bAzpPGghdTu7Y8Qt6hUoWT3R68s4q8e0NrEodI
         tDNQ5+9fkKZXDHUUovWImvCKcZFprP8XTpFnDMzgxcxe/aqf8JcIvOIbE5bh//++FDwd
         4FiDa2FqlkNTKq0Mc5ShH/dZSGjdMwgDkN7eQH29ZIDHwz4wsRqkks7eXc3EimxSLIrq
         i/ww==
X-Gm-Message-State: APt69E2WzwQ6CWjigPwyGArxgBnLsA6Cfjj+5rowB4pP3u7wL9+sCPeg
        NmBqSqosboJW60BiFBEUFRXQmg==
X-Google-Smtp-Source: AAOMgpeQADtsB4iw+hLaKZ0diXO/9UHTQCAcjtbIp7sBpn5qpf1+b9Ia4yrn172zx1SovqIn1iz7BQ==
X-Received: by 2002:a6b:9145:: with SMTP id t66-v6mr24158541iod.59.1531291684476;
        Tue, 10 Jul 2018 23:48:04 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id b143-v6sm11308298ioe.66.2018.07.10.23.48.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 23:48:04 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 03/10] t/chainlint: add chainlint "basic" test cases
Date:   Wed, 11 Jul 2018 02:46:35 -0400
Message-Id: <20180711064642.6933-4-sunshine@sunshineco.com>
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
 t/chainlint/arithmetic-expansion.expect |  9 +++++++++
 t/chainlint/arithmetic-expansion.test   | 11 ++++++++++
 t/chainlint/broken-chain.expect         |  6 ++++++
 t/chainlint/broken-chain.test           |  8 ++++++++
 t/chainlint/close-subshell.expect       | 25 +++++++++++++++++++++++
 t/chainlint/close-subshell.test         | 27 +++++++++++++++++++++++++
 t/chainlint/command-substitution.expect |  9 +++++++++
 t/chainlint/command-substitution.test   | 11 ++++++++++
 t/chainlint/exit-subshell.expect        |  5 +++++
 t/chainlint/exit-subshell.test          |  6 ++++++
 t/chainlint/multi-line-string.expect    |  9 +++++++++
 t/chainlint/multi-line-string.test      | 15 ++++++++++++++
 t/chainlint/pipe.expect                 |  8 ++++++++
 t/chainlint/pipe.test                   | 12 +++++++++++
 t/chainlint/semicolon.expect            | 20 ++++++++++++++++++
 t/chainlint/semicolon.test              | 25 +++++++++++++++++++++++
 16 files changed, 206 insertions(+)
 create mode 100644 t/chainlint/arithmetic-expansion.expect
 create mode 100644 t/chainlint/arithmetic-expansion.test
 create mode 100644 t/chainlint/broken-chain.expect
 create mode 100644 t/chainlint/broken-chain.test
 create mode 100644 t/chainlint/close-subshell.expect
 create mode 100644 t/chainlint/close-subshell.test
 create mode 100644 t/chainlint/command-substitution.expect
 create mode 100644 t/chainlint/command-substitution.test
 create mode 100644 t/chainlint/exit-subshell.expect
 create mode 100644 t/chainlint/exit-subshell.test
 create mode 100644 t/chainlint/multi-line-string.expect
 create mode 100644 t/chainlint/multi-line-string.test
 create mode 100644 t/chainlint/pipe.expect
 create mode 100644 t/chainlint/pipe.test
 create mode 100644 t/chainlint/semicolon.expect
 create mode 100644 t/chainlint/semicolon.test

diff --git a/t/chainlint/arithmetic-expansion.expect b/t/chainlint/arithmetic-expansion.expect
new file mode 100644
index 0000000000..09457d3196
--- /dev/null
+++ b/t/chainlint/arithmetic-expansion.expect
@@ -0,0 +1,9 @@
+(
+	foo &&
+	bar=$((42 + 1)) &&
+	baz
+>) &&
+(
+?!AMP?!	bar=$((42 + 1))
+	baz
+>)
diff --git a/t/chainlint/arithmetic-expansion.test b/t/chainlint/arithmetic-expansion.test
new file mode 100644
index 0000000000..16206960d8
--- /dev/null
+++ b/t/chainlint/arithmetic-expansion.test
@@ -0,0 +1,11 @@
+(
+	foo &&
+# LINT: closing ")" of $((...)) not misinterpreted as subshell-closing ")"
+	bar=$((42 + 1)) &&
+	baz
+) &&
+(
+# LINT: missing "&&" on $((...))
+	bar=$((42 + 1))
+	baz
+)
diff --git a/t/chainlint/broken-chain.expect b/t/chainlint/broken-chain.expect
new file mode 100644
index 0000000000..55b0f42a53
--- /dev/null
+++ b/t/chainlint/broken-chain.expect
@@ -0,0 +1,6 @@
+(
+	foo &&
+?!AMP?!	bar
+	baz &&
+	wop
+>)
diff --git a/t/chainlint/broken-chain.test b/t/chainlint/broken-chain.test
new file mode 100644
index 0000000000..3cc67b65d0
--- /dev/null
+++ b/t/chainlint/broken-chain.test
@@ -0,0 +1,8 @@
+(
+	foo &&
+# LINT: missing "&&" from 'bar'
+	bar
+	baz &&
+# LINT: final statement before closing ")" legitimately lacks "&&"
+	wop
+)
diff --git a/t/chainlint/close-subshell.expect b/t/chainlint/close-subshell.expect
new file mode 100644
index 0000000000..184688718a
--- /dev/null
+++ b/t/chainlint/close-subshell.expect
@@ -0,0 +1,25 @@
+(
+	foo
+>) &&
+(
+	bar
+>) >out &&
+(
+	baz
+>) 2>err &&
+(
+	boo
+>) <input &&
+(
+	bip
+>) | wuzzle &&
+(
+	bop
+>) | fazz 	fozz &&
+(
+	bup
+>) |
+fuzzle &&
+(
+	yop
+>)
diff --git a/t/chainlint/close-subshell.test b/t/chainlint/close-subshell.test
new file mode 100644
index 0000000000..508ca447fd
--- /dev/null
+++ b/t/chainlint/close-subshell.test
@@ -0,0 +1,27 @@
+# LINT: closing ")" with various decorations ("&&", ">", "|", etc.)
+(
+	foo
+) &&
+(
+	bar
+) >out &&
+(
+	baz
+) 2>err &&
+(
+	boo
+) <input &&
+(
+	bip
+) | wuzzle &&
+(
+	bop
+) | fazz \
+	fozz &&
+(
+	bup
+) |
+fuzzle &&
+(
+	yop
+)
diff --git a/t/chainlint/command-substitution.expect b/t/chainlint/command-substitution.expect
new file mode 100644
index 0000000000..ad4118e537
--- /dev/null
+++ b/t/chainlint/command-substitution.expect
@@ -0,0 +1,9 @@
+(
+	foo &&
+	bar=$(gobble) &&
+	baz
+>) &&
+(
+?!AMP?!	bar=$(gobble blocks)
+	baz
+>)
diff --git a/t/chainlint/command-substitution.test b/t/chainlint/command-substitution.test
new file mode 100644
index 0000000000..3bbb002a4c
--- /dev/null
+++ b/t/chainlint/command-substitution.test
@@ -0,0 +1,11 @@
+(
+	foo &&
+# LINT: closing ")" of $(...) not misinterpreted as subshell-closing ")"
+	bar=$(gobble) &&
+	baz
+) &&
+(
+# LINT: missing "&&" on $(...)
+	bar=$(gobble blocks)
+	baz
+)
diff --git a/t/chainlint/exit-subshell.expect b/t/chainlint/exit-subshell.expect
new file mode 100644
index 0000000000..bf78454f74
--- /dev/null
+++ b/t/chainlint/exit-subshell.expect
@@ -0,0 +1,5 @@
+(
+	foo || exit 1
+	bar &&
+	baz
+>)
diff --git a/t/chainlint/exit-subshell.test b/t/chainlint/exit-subshell.test
new file mode 100644
index 0000000000..4e6ab69b88
--- /dev/null
+++ b/t/chainlint/exit-subshell.test
@@ -0,0 +1,6 @@
+(
+# LINT: "|| exit {n}" valid subshell escape without hurting &&-chain
+	foo || exit 1
+	bar &&
+	baz
+)
diff --git a/t/chainlint/multi-line-string.expect b/t/chainlint/multi-line-string.expect
new file mode 100644
index 0000000000..8334c4cc8e
--- /dev/null
+++ b/t/chainlint/multi-line-string.expect
@@ -0,0 +1,9 @@
+(
+	x=line 1		line 2		line 3" &&
+?!AMP?!	y=line 1		line2'
+	foobar
+>) &&
+(
+	echo "there's nothing to see here" &&
+	exit
+>)
diff --git a/t/chainlint/multi-line-string.test b/t/chainlint/multi-line-string.test
new file mode 100644
index 0000000000..14cb44d51c
--- /dev/null
+++ b/t/chainlint/multi-line-string.test
@@ -0,0 +1,15 @@
+(
+	x="line 1
+		line 2
+		line 3" &&
+# LINT: missing "&&" on assignment
+	y='line 1
+		line2'
+	foobar
+) &&
+(
+# LINT: apostrophe (in a contraction) within string not misinterpreted as
+# LINT: starting multi-line single-quoted string
+	echo "there's nothing to see here" &&
+	exit
+)
diff --git a/t/chainlint/pipe.expect b/t/chainlint/pipe.expect
new file mode 100644
index 0000000000..211b901dbc
--- /dev/null
+++ b/t/chainlint/pipe.expect
@@ -0,0 +1,8 @@
+(
+	foo |
+	bar |
+	baz &&
+	fish |
+?!AMP?!	cow
+	sunder
+>)
diff --git a/t/chainlint/pipe.test b/t/chainlint/pipe.test
new file mode 100644
index 0000000000..e6af4de916
--- /dev/null
+++ b/t/chainlint/pipe.test
@@ -0,0 +1,12 @@
+(
+# LINT: no "&&" needed on line ending with "|"
+	foo |
+	bar |
+	baz &&
+
+# LINT: final line of pipe sequence ('cow') lacking "&&"
+	fish |
+	cow
+
+	sunder
+)
diff --git a/t/chainlint/semicolon.expect b/t/chainlint/semicolon.expect
new file mode 100644
index 0000000000..1d79384606
--- /dev/null
+++ b/t/chainlint/semicolon.expect
@@ -0,0 +1,20 @@
+(
+?!AMP?!?!SEMI?!	cat foo ; echo bar
+?!SEMI?!	cat foo ; echo bar
+>) &&
+(
+?!SEMI?!	cat foo ; echo bar &&
+?!SEMI?!	cat foo ; echo bar
+>) &&
+(
+	echo "foo; bar" &&
+?!SEMI?!	cat foo; echo bar
+>) &&
+(
+?!SEMI?!	foo;
+>) &&
+(
+cd foo &&
+	for i in a b c; do
+?!SEMI?!		echo;
+>	done)
diff --git a/t/chainlint/semicolon.test b/t/chainlint/semicolon.test
new file mode 100644
index 0000000000..d82c8ebbc0
--- /dev/null
+++ b/t/chainlint/semicolon.test
@@ -0,0 +1,25 @@
+(
+# LINT: missing internal "&&" and ending "&&"
+	cat foo ; echo bar
+# LINT: final statement before ")" only missing internal "&&"
+	cat foo ; echo bar
+) &&
+(
+# LINT: missing internal "&&"
+	cat foo ; echo bar &&
+	cat foo ; echo bar
+) &&
+(
+# LINT: not fooled by semicolon in string
+	echo "foo; bar" &&
+	cat foo; echo bar
+) &&
+(
+# LINT: unnecessary terminating semicolon
+	foo;
+) &&
+(cd foo &&
+	for i in a b c; do
+# LINT: unnecessary terminating semicolon
+		echo;
+	done)
-- 
2.18.0.203.gfac676dfb9

