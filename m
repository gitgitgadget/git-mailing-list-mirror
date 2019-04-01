Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F78520248
	for <e@80x24.org>; Mon,  1 Apr 2019 10:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDAKND (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 06:13:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38945 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDAKNC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 06:13:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so10660772wmk.4
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+zMDcnTQcGCYTh2LZVt7FEQOJ+o+y7J3z5jf5wTYIw=;
        b=mOi+8qCpgfulqpG3D6nSKZbgGNAmlJ03dv1ZlVDiSIue7eZ/VlGpKyG2Uvlh6qx2uU
         hLQNUs3XjpGEYp1AHGY32E0JgIj58uJAYDrNHYjH2XrC31e82C7cK7caGvctL+/fDsOF
         RbfRxmT6dv4dH+Has6J6S0qCsxTM3sKF4vddBwa8MASdb1zBbuUzzc3QxLV0RyPqwtYw
         aXiXWHA46lMeDS342UQVCVpR4fxUqd+dfw5EZoIM0BDwqlwFIlCBcYIXpU6FRWZvk402
         3iZIUZXocjKJwG9peW/QyjC5uF33ffSBNeRFMnL606fx2tqf+Kvr7gTG3EEXCvaLr6Vr
         E18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+zMDcnTQcGCYTh2LZVt7FEQOJ+o+y7J3z5jf5wTYIw=;
        b=it3uwln7MSZrbyeB/z8qsBJWMUd/SitzNu3l6ZRi9d0EDX7zlQZGwwvv0S4kmNVCtV
         +/mkYUpdCUzFipe6gFzouU2X0UYK94+mpcsx7PJ9KjPnlsERGmKkbPdMa+kX/lR85buQ
         0TbbZIlDhuiUQPiUGDdwQZSEIx0F3CNXeq4csSmtfoWpyrWa4p/AIq+TXI7oa84V4sqD
         JaCSjk6PcMu1woOO5jx6Pt2HeOHGayn4W1aBoENKaO5U7nIHgMxAc8A9ZyDeyhxNvjb3
         jEigmuqM3MSmlKpdwW1+JIz4NwQwi1rAcQJnqOjA+JqGyifScPTMS8ttioj0w3hEpMMi
         SOjg==
X-Gm-Message-State: APjAAAU7WuGKCfrHkqtVq0Ua/NjF4b1uyAtwn/WyZtxH3pT9Hbd2c3zp
        zFMtQk4KGszlD3BjlHIpyfuvHCOy964=
X-Google-Smtp-Source: APXvYqwl9quz53WdufztP3DT3jdjjuD4AIhB8AuMcTww81RSxFPKfDV26ByzHP4U1aRauY9OgD6XvQ==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr12471319wmb.39.1554113580695;
        Mon, 01 Apr 2019 03:13:00 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 204sm20466795wmc.1.2019.04.01.03.12.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Apr 2019 03:13:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] praise: make 'blameless' cultural enforcement configurable
Date:   Mon,  1 Apr 2019 12:12:46 +0200
Message-Id: <20190401101246.21418-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190401101246.21418-1-avarab@gmail.com>
References: <20190401101246.21418-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The culture shock of having a 'blameless' culture from day one might
be too much for some, so let's allow for setting
"blame.culture.enforcement=warning" to allow for easing into the
default of "error".

Also allow for excluding non-interactive users of "blame". There are
some automated users who use "blame" but don't use the "--porcelain"
format (which was already excluded). Those can set
e.g. "error:interactive" to only emit errors when "blame" is
interacting with a TTY.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/blame.txt | 12 ++++++++++++
 builtin/blame.c                | 27 ++++++++++++++++++++++++++-
 t/t8002-blame.sh               | 28 ++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
index c85b35de17..13570192cf 100644
--- a/Documentation/config/blame.txt
+++ b/Documentation/config/blame.txt
@@ -7,6 +7,18 @@ blame.culture::
 +
 Note that the `--porcelain` format for machine consumption is exempt
 from this enforcement to avoid breaking existing scripts.
++
+See `blame.culture.enforcement` below for tweaking the error behavior.
+
+blame.culture.enforcement::
+	When `blame.culture=blameless` is set invoking
+	linkgit:git-blame[1] becomes an `error` This variable can also
+	be set to `warning` to only warn, and to either
+	`error:interactive` or `warning:interactive` to only error out
+	or warn if stderr is connected to a TTY.
++
+This allows for enforcing a blameless culture on interactive users,
+while leaving any automated use alone.
 
 blame.blankBoundary::
 	Show blank commit object name for boundary commits in
diff --git a/builtin/blame.c b/builtin/blame.c
index 238b19db48..9f62950559 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -59,6 +59,12 @@ static size_t blame_date_width;
 
 static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 
+static enum {
+	BLAME_ENFORCE_ERROR		= 1<<0,
+	BLAME_ENFORCE_WARNING		= 1<<1,
+	BLAME_ENFORCE_INTERACTIVE	= 1<<2
+} blame_culture_enforcement = BLAME_ENFORCE_ERROR;
+
 #ifndef DEBUG
 #define DEBUG 0
 #endif
@@ -686,6 +692,19 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		blameless_culture = !strcmp(value, "blameless");
 		return 0;
 	}
+	if (!strcmp(var, "blame.culture.enforcement")) {
+		if (!strcmp(value, "error"))
+			blame_culture_enforcement = BLAME_ENFORCE_ERROR;
+		else if (!strcmp(value, "error:interactive"))
+			blame_culture_enforcement = (BLAME_ENFORCE_ERROR |
+						     BLAME_ENFORCE_INTERACTIVE);
+		else if (!strcmp(value, "warning"))
+			blame_culture_enforcement = BLAME_ENFORCE_WARNING;
+		else if (!strcmp(value, "warning:interactive"))
+			blame_culture_enforcement = (BLAME_ENFORCE_WARNING |
+						     BLAME_ENFORCE_INTERACTIVE);
+		return 0;
+	}
 	if (!strcmp(var, "blame.showemail")) {
 		int *output_option = cb;
 		if (git_config_bool(var, value))
@@ -897,7 +916,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		blame_date_mode.type = DATE_ISO8601;
 	} else if (!cmd_is_praise && blameless_culture &&
 		   !(output_option & OUTPUT_PORCELAIN)) {
-		die(_("must be invoked as 'git praise' with 'blame.culture=blameless' set!"));
+		if (!(blame_culture_enforcement & BLAME_ENFORCE_INTERACTIVE) ||
+		    isatty(2)) {
+			if (blame_culture_enforcement & BLAME_ENFORCE_ERROR)
+				die(_("must be invoked as 'git praise' with 'blame.culture=blameless' set!"));
+			else if (blame_culture_enforcement & BLAME_ENFORCE_WARNING)
+				warning(_("should be invoked as 'git praise' with 'blame.culture=blameless' set!"));
+		}
 	} else {
 		blame_date_mode = revs.date_mode;
 	}
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 2d59b856d1..09ef0bc440 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -2,6 +2,7 @@
 
 test_description='git blame'
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-terminal.sh"
 
 PROG='git blame -c'
 . "$TEST_DIRECTORY"/annotate-tests.sh
@@ -60,9 +61,36 @@ test_expect_success 'praise' '
 
 test_expect_success 'enforced praise' '
 	test_must_fail git -c blame.culture=blameless blame one 2>err &&
+	test_i18ngrep "must be.*git praise" err &&
+	test_must_fail git -c blame.culture=blameless \
+		-c blame.culture.enforcement=error blame one 2>err &&
 	test_i18ngrep "must be.*git praise" err
 '
 
+test_expect_success 'recommended praise' '
+	git -c blame.culture=blameless \
+		-c blame.culture.enforcement=warning blame one 2>err &&
+	test_i18ngrep "should be.*git praise" err
+'
+
+test_expect_success TTY 'interactive: praise blame.culture.enforcement=*:interactive' '
+	test_must_fail test_terminal git -c blame.culture=blameless \
+		-c blame.culture.enforcement=error:interactive blame one 2>err &&
+	test_i18ngrep "must be.*git praise" err &&
+	test_terminal git -c blame.culture=blameless \
+		-c blame.culture.enforcement=warning:interactive blame one 2>err &&
+	test_i18ngrep "should be.*git praise" err
+'
+
+test_expect_success TTY 'non-interactive: praise blame.culture.enforcement=*:interactive' '
+	git -c blame.culture=blameless \
+		-c blame.culture.enforcement=error:interactive blame one 2>err &&
+	test_i18ngrep ! "must be.*git praise" err &&
+	git -c blame.culture=blameless \
+		-c blame.culture.enforcement=warning:interactive blame one 2>err &&
+	test_i18ngrep ! "should be.*git praise" err
+'
+
 test_expect_success 'blame with showemail options' '
 	git blame --show-email one >blame1 &&
 	find_blame <blame1 >result &&
-- 
2.21.0.392.gf8f6787159e

