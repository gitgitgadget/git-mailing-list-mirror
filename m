Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B07C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C6B8233EA
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbhAHJ0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbhAHJ0a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 04:26:30 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327D9C0612F6
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 01:25:50 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q7so5395326pgm.5
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 01:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XVazqsLii5/Yx5E37iI8kmGavf3SZpF0w4rTci7EMX4=;
        b=YaUWKGVkUPmBGSSMLulKoAEo2+cYnVDRE35WJpQsWcBBaEZy4XnK9xbA0uhnukSEXa
         yBHYBwNcRBUerzBDbbVUaZ8d1KE1OhGelahMprR+bObH2iN53pRDSil1LMy4bCYlsSVm
         DYSHV62UP452nZtVLg0V5MG/OnUcWiTplb6pIx2LC70qGjUsHXr12KN3Iz3GJaniAKIq
         NwmzvIZlKVCUS3Tfs0ALqgklZ7e6lJho9UjSMgzs+ATukuY0xGZLnyOtWe8qqpp0abkE
         uFCc7TjXJjIMYEdQXtIy6ExN/EzKvc/mT2vWpneZdUbesfGIxxxkF/8lGHoLkq3v+hb5
         YPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVazqsLii5/Yx5E37iI8kmGavf3SZpF0w4rTci7EMX4=;
        b=TkwetO3WwEHGYXYGDrlBOLBnMXrUifwYOgPfwkTRX9nQzGJ9gTHccvU27n8khzpoC/
         Aj14p1LEZ4GHehw92i6PbTMaTCa8waCpJhOdt+8wxViOT1WeSBwOCqLoxnuwrcoWT+08
         Exn5OnGfxHnV/xTNv4EzR10wB2leVDtShPoxeOnQKGKLTTW+0YVvFHfGM4sbn4GBXsXN
         Q1lS3WyZG2xRr3Z754Nr8YgOce5ICkulNy6WQE/0rn2BQwa4zNDm+RD6iJ4oNaEi8mx/
         kdi7tu/haxO98lfWjn7OfxyJGzOKsxp1NtYwL0lyg1XoYlSOnCXfYdHV/ol6zlJPEgS+
         B8ow==
X-Gm-Message-State: AOAM532A5yWqYb9Sl/jtXWlnQwj2Q1a+sWCRDZbIRs7axaStFe9pHIqG
        gMgNWTZs9GNkhz6AbizOI0lvfr3PIymfNw==
X-Google-Smtp-Source: ABdhPJx8EZZVdQFgoOP7hk4phJNMZ5tEnF4lKJgAXzxHger4LeZDMoi6Tsszz3c+Jtj9xMTrBxG5hQ==
X-Received: by 2002:aa7:93cf:0:b029:19d:e287:b02b with SMTP id y15-20020aa793cf0000b029019de287b02bmr2920217pff.66.1610097949493;
        Fri, 08 Jan 2021 01:25:49 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:e06:7e2e:2d21:e266:30b:8fc])
        by smtp.googlemail.com with ESMTPSA id 6sm8384234pfj.216.2021.01.08.01.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 01:25:49 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood@dunelm.org.uk,
        Johannes.Schindelin@gmx.de, Charvi Mendiratta <charvi077@gmail.com>
Subject: [RFC PATCH 3/9] rebase -i: comment out squash!/fixup! subjects from squash message
Date:   Fri,  8 Jan 2021 14:53:41 +0530
Message-Id: <20210108092345.2178-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210108092345.2178-1-charvi077@gmail.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When squashing commit messages the squash!/fixup! subjects are not of
interest so comment them out to stop them becoming part of the final
message.

This change breaks a bunch of --autosquash tests which rely on the
"squash! <subject>" line appearing in the final commit message. This is
addressed by adding a second line to the commit message of the "squash!
..." commits and testing for that.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c                  | 25 ++++++++++++++++++++++++-
 t/t3415-rebase-autosquash.sh | 27 +++++++++++++--------------
 t/t3900-i18n-commit.sh       |  4 ----
 3 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5062976d10..b050a9a212 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1718,15 +1718,38 @@ static int is_pick_or_similar(enum todo_command command)
 	}
 }
 
+static size_t subject_length(const char *body)
+{
+	size_t i, len = 0;
+	char c;
+	int blank_line = 1;
+	for (i = 0, c = body[i]; c; c = body[++i]) {
+		if (c == '\n') {
+			if (blank_line)
+				return len;
+			len = i + 1;
+			blank_line = 1;
+		} else if (!isspace(c)) {
+			blank_line = 0;
+		}
+	}
+	return blank_line ? len : i;
+}
+
 static void append_squash_message(struct strbuf *buf, const char *body,
 				  struct replay_opts *opts)
 {
+	size_t commented_len = 0;
+
 	unlink(rebase_path_fixup_msg());
+	if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
+		commented_len = subject_length(body);
 	strbuf_addf(buf, "\n%c ", comment_line_char);
 	strbuf_addf(buf, _("This is the commit message #%d:"),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
-	strbuf_addstr(buf, body);
+	strbuf_add_commented_lines(buf, body, commented_len);
+	strbuf_addstr(buf, body + commented_len);
 }
 
 static int update_squash_messages(struct repository *r,
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 7bab6000dc..45fe6a227e 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -81,8 +81,7 @@ test_auto_squash () {
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "squash! first" &&
-
+	git commit -m "squash! first" -m "extra para for first" &&
 	git tag $1 &&
 	test_tick &&
 	git rebase $2 -i HEAD^^^ &&
@@ -139,7 +138,7 @@ test_expect_success 'auto squash that matches 2 commits' '
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "squash! first" &&
+	git commit -m "squash! first" -m "extra para for first" &&
 	git tag final-multisquash &&
 	test_tick &&
 	git rebase --autosquash -i HEAD~4 &&
@@ -192,7 +191,7 @@ test_expect_success 'auto squash that matches a sha1' '
 	git add -u &&
 	test_tick &&
 	oid=$(git rev-parse --short HEAD^) &&
-	git commit -m "squash! $oid" &&
+	git commit -m "squash! $oid" -m "extra para" &&
 	git tag final-shasquash &&
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
@@ -203,7 +202,7 @@ test_expect_success 'auto squash that matches a sha1' '
 	git cat-file blob HEAD^:file1 >actual &&
 	test_cmp expect actual &&
 	git cat-file commit HEAD^ >commit &&
-	grep squash commit >actual &&
+	grep "extra para" commit >actual &&
 	test_line_count = 1 actual
 '
 
@@ -213,7 +212,7 @@ test_expect_success 'auto squash that matches longer sha1' '
 	git add -u &&
 	test_tick &&
 	oid=$(git rev-parse --short=11 HEAD^) &&
-	git commit -m "squash! $oid" &&
+	git commit -m "squash! $oid" -m "extra para" &&
 	git tag final-longshasquash &&
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
@@ -224,7 +223,7 @@ test_expect_success 'auto squash that matches longer sha1' '
 	git cat-file blob HEAD^:file1 >actual &&
 	test_cmp expect actual &&
 	git cat-file commit HEAD^ >commit &&
-	grep squash commit >actual &&
+	grep "extra para" commit >actual &&
 	test_line_count = 1 actual
 '
 
@@ -233,7 +232,7 @@ test_auto_commit_flags () {
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit --$1 first-commit &&
+	git commit --$1 first-commit -m "extra para for first" &&
 	git tag final-commit-$1 &&
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
@@ -261,11 +260,11 @@ test_auto_fixup_fixup () {
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "$1! first" &&
+	git commit -m "$1! first" -m "extra para for first" &&
 	echo 2 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "$1! $2! first" &&
+	git commit -m "$1! $2! first" -m "second extra para for first" &&
 	git tag "final-$1-$2" &&
 	test_tick &&
 	(
@@ -326,12 +325,12 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
 	git add -u &&
 	test_tick &&
 	oid=$(git rev-parse --short HEAD^) &&
-	git commit -m "squash! $oid" &&
+	git commit -m "squash! $oid" -m "extra para for first" &&
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
 	subject=$(git log -n 1 --format=%s HEAD~2) &&
-	git commit -m "squash! $subject" &&
+	git commit -m "squash! $subject" -m "second extra para for first" &&
 	git tag final-squash-instFmt &&
 	test_tick &&
 	git rebase --autosquash -i HEAD~4 &&
@@ -342,8 +341,8 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
 	git cat-file blob HEAD^:file1 >actual &&
 	test_cmp expect actual &&
 	git cat-file commit HEAD^ >commit &&
-	grep squash commit >actual &&
-	test_line_count = 2 actual
+	grep first commit >actual &&
+	test_line_count = 3 actual
 '
 
 test_expect_success 'autosquash with empty custom instructionFormat' '
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index d277a9f4b7..bfab245eb3 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -226,10 +226,6 @@ test_commit_autosquash_multi_encoding () {
 		git rev-list HEAD >actual &&
 		test_line_count = 3 actual &&
 		iconv -f $old -t UTF-8 "$TEST_DIRECTORY"/t3900/$msg >expect &&
-		if test $flag = squash; then
-			subject="$(head -1 expect)" &&
-			printf "\nsquash! %s\n" "$subject" >>expect
-		fi &&
 		git cat-file commit HEAD^ >raw &&
 		(sed "1,/^$/d" raw | iconv -f $new -t utf-8) >actual &&
 		test_cmp expect actual
-- 
2.29.0.rc1

