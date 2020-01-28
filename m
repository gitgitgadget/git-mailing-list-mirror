Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C7EC33CB2
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF0524683
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goKYHhmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgA1S1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:27:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37693 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgA1S0x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 13:26:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so17254551wru.4
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 10:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DxrJYJpH3S8elWu+k2UNvr3+ZBuJrRhBZVScRnz59WY=;
        b=goKYHhmqBZAEg4PzClUy3ENBUUlz24oEvpiq8a4WX7AMTvMFame5lVnWUjgz3P1YeS
         JRpCQpmtcXsxVTFmzVQyOKX+ivQ/kIIUC9AuGYhjIFb7IisEoXUP3oxjw1g3F1x3Qgk2
         lKoW61vS/IEjXFz7JIaAdn89hsVpS5oWyyLsLWawC8npdsar9BM8nrDyQbZRoxvWAk4Y
         6aa6vBodtloXfiyTmmmFYExZjCA9F7r9PJC0jfty/+3zXGoNsKGsjFSmAzpC3KPLMlcw
         BB0cmmzx1BL972YIPEnobcQybc7jcfO403fjcvm1hYbUfSkRVC6EZl0VgUwIGDNEuzXl
         nENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DxrJYJpH3S8elWu+k2UNvr3+ZBuJrRhBZVScRnz59WY=;
        b=f5RnrXnxcG6OKMQthSxvwCFi3VQ/Olwlsh8uxj46CG5m5FLVXo5Nzn/DiEoZTvTJb5
         6SOGajDVneWNHbdM4KhAFSeLM66M8aOZQfqxLs26ySgJwoTVYYfuBy6zRvaYgNC3Zkh7
         iLgOawLO5Z18M94Oelfz/2rh6/q/cdkrV80LHi5KYLA5/NzuUY7pFsQLmAs/sE6xWZ//
         3sVm99obWxa+DHnPiSmHTGyUnh2fEA571EOzvfPHr17wUE+XOjwpuX237caOw3lWBsxY
         DaPCOrrbch48v3nTGeCaZPBfbiJDmXaRGtTInplsa0E6MwvO1LmwsWnapq2Jk7D1UWId
         mj4w==
X-Gm-Message-State: APjAAAWmTQV120O9WDe87DCrgzuXh1Q1ClmOZJQk7Rw+LDD8Wn7JMG6K
        RppRS4OR/wividfn/QSCC1zBqHee
X-Google-Smtp-Source: APXvYqykIngmJj6szF93O9RhyZsviXSzu0M/YJxYPRpNGokwJcPtLdTi59/k7oGrwOTvCG2OP16lmQ==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr29812661wrn.245.1580236011390;
        Tue, 28 Jan 2020 10:26:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm4288635wme.41.2020.01.28.10.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:26:51 -0800 (PST)
Message-Id: <9ea69e90694e53842acd68d3ac85c9a00c4bd343.1580236003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
        <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jan 2020 18:26:40 +0000
Subject: [PATCH v3 09/12] sparse-checkout: properly match escaped characters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In cone mode, the sparse-checkout feature uses hashset containment
queries to match paths. Make this algorithm respect escaped asterisk
(*) and backslash (\) characters.

Create dup_and_filter_pattern() method to convert a pattern by
removing escape characters and dropping an optional "/*" at the end.
This method is available in dir.h as we will use it in
builtin/sparse-checkout.c in a later change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              | 31 +++++++++++++++++++++++++++---
 t/t1091-sparse-checkout-builtin.sh | 22 +++++++++++++++++----
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index 7cb78c8b87..579f274d13 100644
--- a/dir.c
+++ b/dir.c
@@ -630,6 +630,32 @@ int pl_hashmap_cmp(const void *unused_cmp_data,
 	return strncmp(ee1->pattern, ee2->pattern, min_len);
 }
 
+static char *dup_and_filter_pattern(const char *pattern)
+{
+	char *set, *read;
+	char *result = xstrdup(pattern);
+
+	set = result;
+	read = result;
+
+	while (*read) {
+		/* skip escape characters (once) */
+		if (*read == '\\')
+			read++;
+
+		*set = *read;
+
+		set++;
+		read++;
+	}
+	*set = 0;
+
+	if (*(read - 2) == '/' && *(read - 1) == '*')
+		*(read - 2) = 0;
+
+	return result;
+}
+
 static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern *given)
 {
 	struct pattern_entry *translated;
@@ -695,8 +721,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 			goto clear_hashmaps;
 		}
 
-		truncated = xstrdup(given->pattern);
-		truncated[given->patternlen - 2] = 0;
+		truncated = dup_and_filter_pattern(given->pattern);
 
 		translated = xmalloc(sizeof(struct pattern_entry));
 		translated->pattern = truncated;
@@ -730,7 +755,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 
 	translated = xmalloc(sizeof(struct pattern_entry));
 
-	translated->pattern = xstrdup(given->pattern);
+	translated->pattern = dup_and_filter_pattern(given->pattern);
 	translated->patternlen = given->patternlen;
 	hashmap_entry_init(&translated->ent,
 			   ignore_case ?
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 470900f6f4..0a21a5e15d 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -366,13 +366,27 @@ test_expect_success 'pattern-checks: starting "*"' '
 	check_read_tree_errors repo "a deep" "disabling cone pattern matching"
 '
 
-test_expect_success 'pattern-checks: escaped "*"' '
-	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
+	git clone repo escaped &&
+	TREEOID=$(git -C escaped rev-parse HEAD:folder1) &&
+	NEWTREE=$(git -C escaped mktree <<-EOF
+	$(git -C escaped ls-tree HEAD)
+	040000 tree $TREEOID	zbad\\dir
+	040000 tree $TREEOID	zdoes*exist
+	EOF
+	) &&
+	COMMIT=$(git -C escaped commit-tree $NEWTREE -p HEAD) &&
+	git -C escaped reset --hard $COMMIT &&
+	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" &&
+	git -C escaped sparse-checkout init --cone &&
+	cat >escaped/.git/info/sparse-checkout <<-\EOF &&
 	/*
 	!/*/
-	/does\*not\*exist/
+	/zbad\\dir/
+	/zdoes\*not\*exist/
+	/zdoes\*exist/
 	EOF
-	check_read_tree_errors repo "a" ""
+	check_read_tree_errors escaped "a zbad\\dir zdoes*exist"
 '
 
 test_done
-- 
gitgitgadget

