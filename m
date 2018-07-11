Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBADE1F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 06:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeGKGvA (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 02:51:00 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46229 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeGKGu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 02:50:56 -0400
Received: by mail-io0-f194.google.com with SMTP id i18-v6so6901773ioj.13
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 23:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=35aNHsTh507xLcuXx69wuQwfowH/kA/dLdrugGffNU4=;
        b=dfEeuZY5AyATWoSFN8m8Mzqs0ORdtQix2M7ZUgXbznP6zLaFP5hgmnqhHD0TFPE7rS
         xA/e9qDbQXWCFXr92mL9lJ4IwtyT4jwWl4pnUuYvyN1bQ/GYO6QTJWYniagT7WyK5tsf
         0Aj5uBBETdZPf7xJQ9QUxYtwBuk42aZklmBIMGkRkwnZDqYeeIhcxcrLsIvPIexHKbzw
         LJYWTJNdrLQJgQ9dX+sk4nItd60m4aYn4HsUf1VgQXHjU8fcTC8YsMf5lLKaFGv2pCVs
         9k0fthWM2/iv/TNxYJKR2ivO1auIYBXnp5YQfz1Tf6YJpagAXpPr+y4BJ6pvFrO65Kx7
         Ok4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=35aNHsTh507xLcuXx69wuQwfowH/kA/dLdrugGffNU4=;
        b=Mng/UVSFe++ymvyBz48KcZpW0KEeVzZOfrBEGR8HrdKAg6AsR9QgzngvDNUFk/a0ub
         moAswN9M3dFVGER5Ax0ACmz2Nv3buSELq7TXGH1dPALMYuyP0KRpmSul2RAqeAQGxVyM
         oVcHoydAozCZULJYcGuOWpe2owu14LCkYvdP2aIEXO/aMZRIPzzOjt4dV3uwR6qMp0NY
         uJRQ3UCrhe2L1SKnU3XSu5nBrkzKDr8mFJ9r+4bLjR/NN62z1j29RZOGURHgBTgofr/A
         wKk4abk362l11eM2cq1Qx6ZZdDp5cSrjOgsNeK6vwfu2f+wSWHOoXsN6eUy1DqxhTs7q
         lz0Q==
X-Gm-Message-State: AOUpUlG3LoDrxBt2G848slSZ0PpqHd2RiDYt/Klcsy52uFFwVO7xE0lO
        DQjf5H81Ac93wd+F/HG1ndULZQ==
X-Google-Smtp-Source: AAOMgpeW9YCbG+D1Wd8Knk3OSFisOAa/P9cuWKmIvW5sLnmO7JGW7GOrrjGknEt95dZDaEJRqsl93A==
X-Received: by 2002:a6b:3e46:: with SMTP id l67-v6mr22601970ioa.294.1531291690914;
        Tue, 10 Jul 2018 23:48:10 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id b143-v6sm11308298ioe.66.2018.07.10.23.48.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 23:48:10 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 10/10] t/chainlint: add chainlint "specialized" test cases
Date:   Wed, 11 Jul 2018 02:46:42 -0400
Message-Id: <20180711064642.6933-11-sunshine@sunshineco.com>
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
 t/chainlint/bash-array.expect  | 10 ++++++++++
 t/chainlint/bash-array.test    | 12 ++++++++++++
 t/chainlint/p4-filespec.expect |  4 ++++
 t/chainlint/p4-filespec.test   |  5 +++++
 4 files changed, 31 insertions(+)
 create mode 100644 t/chainlint/bash-array.expect
 create mode 100644 t/chainlint/bash-array.test
 create mode 100644 t/chainlint/p4-filespec.expect
 create mode 100644 t/chainlint/p4-filespec.test

diff --git a/t/chainlint/bash-array.expect b/t/chainlint/bash-array.expect
new file mode 100644
index 0000000000..c4a830d1c1
--- /dev/null
+++ b/t/chainlint/bash-array.expect
@@ -0,0 +1,10 @@
+(
+	foo &&
+	bar=(gumbo stumbo wumbo) &&
+	baz
+>) &&
+(
+	foo &&
+	bar=${#bar[@]} &&
+	baz
+>)
diff --git a/t/chainlint/bash-array.test b/t/chainlint/bash-array.test
new file mode 100644
index 0000000000..92bbb777b8
--- /dev/null
+++ b/t/chainlint/bash-array.test
@@ -0,0 +1,12 @@
+(
+	foo &&
+# LINT: ")" in Bash array assignment not misinterpreted as subshell-closing ")"
+	bar=(gumbo stumbo wumbo) &&
+	baz
+) &&
+(
+	foo &&
+# LINT: Bash array length operator not misinterpreted as comment
+	bar=${#bar[@]} &&
+	baz
+)
diff --git a/t/chainlint/p4-filespec.expect b/t/chainlint/p4-filespec.expect
new file mode 100644
index 0000000000..98b3d881fd
--- /dev/null
+++ b/t/chainlint/p4-filespec.expect
@@ -0,0 +1,4 @@
+(
+	p4 print -1 //depot/fiddle#42 >file &&
+	foobar
+>)
diff --git a/t/chainlint/p4-filespec.test b/t/chainlint/p4-filespec.test
new file mode 100644
index 0000000000..4fd2d6e2b8
--- /dev/null
+++ b/t/chainlint/p4-filespec.test
@@ -0,0 +1,5 @@
+(
+# LINT: Perforce revspec in filespec not misinterpreted as in-line comment
+	p4 print -1 //depot/fiddle#42 >file &&
+	foobar
+)
-- 
2.18.0.203.gfac676dfb9

