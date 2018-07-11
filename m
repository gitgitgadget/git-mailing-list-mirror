Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA711F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 06:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeGKGu4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 02:50:56 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45396 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeGKGuz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 02:50:55 -0400
Received: by mail-io0-f193.google.com with SMTP id l25-v6so22630022ioh.12
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 23:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2KMz4Kx6aKkA0BZVKWd5XEUQLqyFiesJTugBm8FzlbA=;
        b=VXlCnPA533ShbGtmucImQL2XUi9Cjub0ybbOI8Y8wd32snoN1mSjnMqW1NShH6FqEJ
         6tp+vVjn3tTDZLQI5Wxhpj/XAk/eqasihMuEM7LbDjqFC/ZxvokyFy87v8ACCeI4krbq
         sUvqMvgZqCiqtL4SQ4fbPZrffC1B+mxVbELFBZzh3HrSKetuKH+MF+gQIERjl5wWHjHF
         BKiEQ06qo1FyyADNdS0mRl9Py4CE2y+NgWhfOi2zPW/L7Ia/KeJF0bfPSHr8w/DfAMdu
         pTpoyt5MP5/3Ci4Jn3OASqpBdv2YTDxex3EuyaDcZ3rMccsfKBGAjtVuiA9gNM2lwZyg
         3C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=2KMz4Kx6aKkA0BZVKWd5XEUQLqyFiesJTugBm8FzlbA=;
        b=hBVEtfEdi7N//HSl/4GZ3x3i21x+fMl4D1AQ3wLL/8xbFS75uDGUaU8uTQWEByl3n2
         w7sL2qbku8Q0rJoJ2Nd+JjhR93t7DD6p1h0M9vV+U6zxidlLISHl8BmXgHMQEZHnTIYM
         L1Coc8uIwj3VhPqrGIAQX8Tu0sgPe5HXI/vUjHiLEh7y7Kzr7px0+jVQbxgFiy/pgekD
         G2GOhfXgfqEr2VaSZC9uiSpBfOgWmYv4eeqdzFdpaDZWXAAHIlooWjy86eoCDZIyb++v
         hurZW4a5ADGG3DYKIZ0dN5qSWjNwL42SJ4WJFynq3MPUZTgTa1+GMU6rbEvsltU1UkDc
         5xeg==
X-Gm-Message-State: APt69E3SJoJuf46M2OyZMuzRGllntUs2yDYirIhR5DTzXYKgxOUGMu+f
        K/rmv0H5fq+FT2PLn2RNfAl5aQ==
X-Google-Smtp-Source: AAOMgpcqTEfbjYPpEYcKkCUPKAr8I+EqIcWHdvEWATQpc00v+6rPHub0kzB+7WP30FABc5lNmcLAww==
X-Received: by 2002:a6b:a58f:: with SMTP id o137-v6mr23336387ioe.63.1531291690045;
        Tue, 10 Jul 2018 23:48:10 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id b143-v6sm11308298ioe.66.2018.07.10.23.48.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 23:48:09 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 09/10] t/chainlint: add chainlint "complex" test cases
Date:   Wed, 11 Jul 2018 02:46:41 -0400
Message-Id: <20180711064642.6933-10-sunshine@sunshineco.com>
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
 .../close-nested-and-parent-together.expect       |  4 ++++
 t/chainlint/close-nested-and-parent-together.test |  3 +++
 t/chainlint/complex-if-in-cuddled-loop.expect     | 10 ++++++++++
 t/chainlint/complex-if-in-cuddled-loop.test       | 11 +++++++++++
 t/chainlint/if-in-loop.expect                     | 12 ++++++++++++
 t/chainlint/if-in-loop.test                       | 15 +++++++++++++++
 t/chainlint/loop-in-if.expect                     | 12 ++++++++++++
 t/chainlint/loop-in-if.test                       | 15 +++++++++++++++
 8 files changed, 82 insertions(+)
 create mode 100644 t/chainlint/close-nested-and-parent-together.expect
 create mode 100644 t/chainlint/close-nested-and-parent-together.test
 create mode 100644 t/chainlint/complex-if-in-cuddled-loop.expect
 create mode 100644 t/chainlint/complex-if-in-cuddled-loop.test
 create mode 100644 t/chainlint/if-in-loop.expect
 create mode 100644 t/chainlint/if-in-loop.test
 create mode 100644 t/chainlint/loop-in-if.expect
 create mode 100644 t/chainlint/loop-in-if.test

diff --git a/t/chainlint/close-nested-and-parent-together.expect b/t/chainlint/close-nested-and-parent-together.expect
new file mode 100644
index 0000000000..2a910f9d66
--- /dev/null
+++ b/t/chainlint/close-nested-and-parent-together.expect
@@ -0,0 +1,4 @@
+(
+cd foo &&
+	(bar &&
+>>>		baz))
diff --git a/t/chainlint/close-nested-and-parent-together.test b/t/chainlint/close-nested-and-parent-together.test
new file mode 100644
index 0000000000..72d482f76d
--- /dev/null
+++ b/t/chainlint/close-nested-and-parent-together.test
@@ -0,0 +1,3 @@
+(cd foo &&
+	(bar &&
+		baz))
diff --git a/t/chainlint/complex-if-in-cuddled-loop.expect b/t/chainlint/complex-if-in-cuddled-loop.expect
new file mode 100644
index 0000000000..9674b88cf2
--- /dev/null
+++ b/t/chainlint/complex-if-in-cuddled-loop.expect
@@ -0,0 +1,10 @@
+(
+for i in a b c; do
+   if test "$(echo $(waffle bat))" = "eleventeen" &&
+     test "$x" = "$y"; then
+     :
+   else
+     echo >file
+   fi
+> done) &&
+test ! -f file
diff --git a/t/chainlint/complex-if-in-cuddled-loop.test b/t/chainlint/complex-if-in-cuddled-loop.test
new file mode 100644
index 0000000000..571bbd85cd
--- /dev/null
+++ b/t/chainlint/complex-if-in-cuddled-loop.test
@@ -0,0 +1,11 @@
+# LINT: 'for' loop cuddled with "(" and ")" and nested 'if' with complex
+# LINT: multi-line condition; indented with spaces, not tabs
+(for i in a b c; do
+   if test "$(echo $(waffle bat))" = "eleventeen" &&
+     test "$x" = "$y"; then
+     :
+   else
+     echo >file
+   fi
+ done) &&
+test ! -f file
diff --git a/t/chainlint/if-in-loop.expect b/t/chainlint/if-in-loop.expect
new file mode 100644
index 0000000000..03d3ceb22d
--- /dev/null
+++ b/t/chainlint/if-in-loop.expect
@@ -0,0 +1,12 @@
+(
+	for i in a b c
+	do
+		if false
+		then
+?!AMP?!			echo "err"
+			exit 1
+?!AMP?!		fi
+		foo
+?!AMP?!	done
+	bar
+>)
diff --git a/t/chainlint/if-in-loop.test b/t/chainlint/if-in-loop.test
new file mode 100644
index 0000000000..daf22da164
--- /dev/null
+++ b/t/chainlint/if-in-loop.test
@@ -0,0 +1,15 @@
+(
+	for i in a b c
+	do
+		if false
+		then
+# LINT: missing "&&" on 'echo'
+			echo "err"
+			exit 1
+# LINT: missing "&&" on 'fi'
+		fi
+		foo
+# LINT: missing "&&" on 'done'
+	done
+	bar
+)
diff --git a/t/chainlint/loop-in-if.expect b/t/chainlint/loop-in-if.expect
new file mode 100644
index 0000000000..088e622c31
--- /dev/null
+++ b/t/chainlint/loop-in-if.expect
@@ -0,0 +1,12 @@
+(
+	if true
+	then
+		while true
+		do
+?!AMP?!			echo "pop"
+			echo "glup"
+?!AMP?!		done
+		foo
+?!AMP?!	fi
+	bar
+>)
diff --git a/t/chainlint/loop-in-if.test b/t/chainlint/loop-in-if.test
new file mode 100644
index 0000000000..93e8ba8e4d
--- /dev/null
+++ b/t/chainlint/loop-in-if.test
@@ -0,0 +1,15 @@
+(
+	if true
+	then
+		while true
+		do
+# LINT: missing "&&" on 'echo'
+			echo "pop"
+			echo "glup"
+# LINT: missing "&&" on 'done'
+		done
+		foo
+# LINT: missing "&&" on 'fi'
+	fi
+	bar
+)
-- 
2.18.0.203.gfac676dfb9

