Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB81C4332F
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 15:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiJEPBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 11:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiJEPA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 11:00:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BA9B856
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 07:59:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso1197885wmc.0
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=U/V7X9cm9YDsr5OTtWkmys/L/Z25YilLpYhAYtSwsX0=;
        b=Q0kN4ljEniR9B638tQBjqUyjo+TmJuYmtBoVllEv0C3VCF7rVqAALo13ufY+d9dgH4
         ldjYJURCWspcyzxjXVsCQaT2msqD2VR9+WrQmwo4D8aN2EILfsYRijrygt6Hht/DRtH7
         Nd8LKnWzn8jyz7XDATDk1NXAmu+59VXQjFNFlAA/s671oq5PSlp4cEjD4W2z/0CnQD2M
         xmm6ZJOdj/v2/FNm93KXvU/FYxM6BpbwQmcFC2FvLSQOgnnjxosj8T1u/CbQYrPHQK8Q
         TRgP7zd8NRnaq8SCNi4YU6nrMWmTbj9cSW58jV5ur7TcZwTiabcS+lZqk9PBgGzOn+Fv
         LbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=U/V7X9cm9YDsr5OTtWkmys/L/Z25YilLpYhAYtSwsX0=;
        b=fU5Ujsu85fO1POGVgCMJaa/HM6jEqCu52zSTR803NjQ4l9ZdPDvauw3oLane2eSftb
         RSSQvdvq+e57BdEvBY8Ai+WfVVHhXB7j6aIvUCDX2mD47cWf7EruycqdHDjnzP9d8Kxy
         xkTKtVFVhGLqwb+ZwqbE43w1/75Z0sUtkzcCaht46u4MPFqzHWuJJ5BaQjk9JUlrOnfD
         l8tmBWh5QvtfgK3o0uIUAr2TPWPclTuq9rcQYY53S/bo4pcCf7KjqdXQoPv9Vv9OsSDD
         0srpwWoUedS0JrIXlaS5Rivl2aoKYLut/eyXP1cHmt7gnMpZ44bFs3SAIJP6IQQfX7rb
         FTUg==
X-Gm-Message-State: ACrzQf2AEzw8ETlXmqRm737010j37ehkl5NAImfNZO2Jej1C5ea47D1W
        0tzzL47+e2J8KL7+k75iNDJwE1Gea5U=
X-Google-Smtp-Source: AMsMyM5TMOkMQc2NkR1Ohy0hZmZD0V8osZYAN+jy7U/3n66eHX6HBtF5gOqfTDKRzGg4WVtMhskuDQ==
X-Received: by 2002:a05:600c:a47:b0:3a6:5848:4bde with SMTP id c7-20020a05600c0a4700b003a658484bdemr3584881wmq.189.1664981963736;
        Wed, 05 Oct 2022 07:59:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t189-20020a1c46c6000000b003a5537bb2besm2302816wma.25.2022.10.05.07.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:59:23 -0700 (PDT)
Message-Id: <408941e74006e711dd592bd8ba8a93901dbf99bf.1664981958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
        <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
From:   "Stefan Xenos via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Oct 2022 14:59:11 +0000
Subject: [PATCH v2 04/10] evolve: add support for parsing metacommits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Chris Poucet <poucet@google.com>,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@google.com>

This patch adds the get_metacommit_content method, which can classify
commits as either metacommits or normal commits, determine whether they
are abandoned, and extract the content commit's object id from the
metacommit.

Signed-off-by: Stefan Xenos <sxenos@google.com>
Signed-off-by: Chris Poucet <poucet@google.com>
---
 Makefile            |  1 +
 commit.c            | 13 ++++++
 commit.h            |  5 +++
 metacommit-parser.c | 97 +++++++++++++++++++++++++++++++++++++++++++++
 metacommit-parser.h | 19 +++++++++
 5 files changed, 135 insertions(+)
 create mode 100644 metacommit-parser.c
 create mode 100644 metacommit-parser.h

diff --git a/Makefile b/Makefile
index cac3452edb9..b2bcc00c289 100644
--- a/Makefile
+++ b/Makefile
@@ -999,6 +999,7 @@ LIB_OBJS += merge-ort.o
 LIB_OBJS += merge-ort-wrappers.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += merge.o
+LIB_OBJS += metacommit-parser.o
 LIB_OBJS += midx.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += negotiator/default.o
diff --git a/commit.c b/commit.c
index 89b8efc6116..3eabb66fb6b 100644
--- a/commit.c
+++ b/commit.c
@@ -623,6 +623,19 @@ struct commit_list *reverse_commit_list(struct commit_list *list)
 	return next;
 }
 
+struct commit *get_commit_by_index(struct commit_list *to_search, int index)
+{
+	while (to_search && index) {
+		to_search = to_search->next;
+		index--;
+	}
+
+	if (!to_search)
+		return NULL;
+
+	return to_search->item;
+}
+
 void free_commit_list(struct commit_list *list)
 {
 	while (list)
diff --git a/commit.h b/commit.h
index 21e4d25ce78..11861a5a78c 100644
--- a/commit.h
+++ b/commit.h
@@ -188,8 +188,13 @@ struct commit_list *copy_commit_list(struct commit_list *list);
 /* Modify list in-place to reverse it, returning new head; list will be tail */
 struct commit_list *reverse_commit_list(struct commit_list *list);
 
+/* Returns the commit at `index` or NULL if the index exceeds the `to_search`
+ * list */
+struct commit *get_commit_by_index(struct commit_list *to_search, int index);
+
 void free_commit_list(struct commit_list *list);
 
+
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 
 int has_non_ascii(const char *text);
diff --git a/metacommit-parser.c b/metacommit-parser.c
new file mode 100644
index 00000000000..baccfb4dd5c
--- /dev/null
+++ b/metacommit-parser.c
@@ -0,0 +1,97 @@
+#include "cache.h"
+#include "metacommit-parser.h"
+#include "commit.h"
+
+/*
+ * Search the commit buffer for a line starting with the given key. Unlike
+ * find_commit_header, this also searches the commit message body.
+ */
+static const char *find_key(const char *msg, const char *key, size_t *out_len)
+{
+	int key_len = strlen(key);
+	const char *line = msg;
+
+	while (line) {
+		const char *eol = strchrnul(line, '\n');
+
+		if (eol - line > key_len && !memcmp(line, key, key_len) &&
+		    line[key_len] == ' ') {
+			*out_len = eol - line - key_len - 1;
+			return line + key_len + 1;
+		}
+		line = *eol ? eol + 1 : NULL;
+	}
+	return NULL;
+}
+
+/*
+ * Writes the index of the content parent to "result". Returns the metacommit
+ * type. See the METACOMMIT_TYPE_* constants.
+ */
+static enum metacommit_type index_of_content_commit(const char *buffer, int *result)
+{
+	int index = 0;
+	int ret = METACOMMIT_TYPE_NONE;
+	size_t parent_types_size;
+	const char *parent_types = find_key(buffer, "parent-type",
+		&parent_types_size);
+	const char *end;
+	const char *enum_start = parent_types;
+	int enum_length = 0;
+
+	if (!parent_types)
+		return METACOMMIT_TYPE_NONE;
+
+	end = &parent_types[parent_types_size];
+
+	while (1) {
+		char next = *parent_types;
+		if (next == ' ' || parent_types >= end) {
+			if (enum_length == 1) {
+				char type = *enum_start;
+				if (type == 'c') {
+					ret = METACOMMIT_TYPE_NORMAL;
+					break;
+				}
+				if (type == 'a') {
+					ret = METACOMMIT_TYPE_ABANDONED;
+					break;
+				}
+			}
+			if (parent_types >= end)
+				return METACOMMIT_TYPE_NONE;
+			enum_start = parent_types + 1;
+			enum_length = 0;
+			index++;
+		} else {
+			enum_length++;
+		}
+		parent_types++;
+	}
+
+	*result = index;
+	return ret;
+}
+
+/*
+ * Writes the content parent's object id to "content".
+ * Returns the metacommit type. See the METACOMMIT_TYPE_* constants.
+ */
+enum metacommit_type get_metacommit_content(struct commit *commit, struct object_id *content)
+{
+	const char *buffer = get_commit_buffer(commit, NULL);
+	int index = 0;
+	enum metacommit_type ret = index_of_content_commit(buffer, &index);
+	struct commit *content_parent;
+
+	if (ret == METACOMMIT_TYPE_NONE)
+		return ret;
+
+	content_parent = get_commit_by_index(commit->parents, index);
+
+	if (!content_parent)
+		return METACOMMIT_TYPE_NONE;
+
+	oidcpy(content, &(content_parent->object.oid));
+	return ret;
+}
diff --git a/metacommit-parser.h b/metacommit-parser.h
new file mode 100644
index 00000000000..ef4a121d433
--- /dev/null
+++ b/metacommit-parser.h
@@ -0,0 +1,19 @@
+#ifndef METACOMMIT_PARSER_H
+#define METACOMMIT_PARSER_H
+
+#include "commit.h"
+#include "hash.h"
+
+enum metacommit_type {
+	/* Indicates a normal commit (non-metacommit) */
+	METACOMMIT_TYPE_NONE = 0,
+	/* Indicates a metacommit with normal content (non-abandoned) */
+	METACOMMIT_TYPE_NORMAL = 1,
+	/* Indicates a metacommit with abandoned content */
+	METACOMMIT_TYPE_ABANDONED = 2,
+};
+
+enum metacommit_type get_metacommit_content(
+	struct commit *commit, struct object_id *content);
+
+#endif
-- 
gitgitgadget

