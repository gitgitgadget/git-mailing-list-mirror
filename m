Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EFA14E2E6
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084147; cv=none; b=And5oD8vKqWgYJ7CwhQkoY2uNMUgb/ZXsv/NvRTskYXH48oFsjBxLV1aXyMX4h5hTrvVyL6Uw/13cZFbsTSQmaf0P+Xqan4Gze3pAFpvxogszD2F17D9ysDfwLypd474JvbE076faPcRoX7dvU4pgZ0yGWjelDs/16ms7gpop5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084147; c=relaxed/simple;
	bh=h1GxEopTEHAIozgR2tIvzEUZc8Sz+zs4a95yrSnSc0U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CF3Dfl2Hp4gEI+Vx2xyN0a+0Cpenu2Ut2OcBRJDF0ylfc1ln1KB4o/1+fMxQ7vlJMT+CqR6HWTlSj1qGS7lQRfvk6RJ3fLUVqgo7nAJJSh+3R0nFr9kBOIJakyAtRZ1ktoK6hSHJR/VJB/9wyjaa+/jMLv0oVY8Q2u0f4MiQdrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzTYY0cD; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzTYY0cD"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so436517066b.0
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728084143; x=1728688943; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uLuleRH6kmBXXjf2tgctsV8mhLkdmO/MMK4eH0w4Y8=;
        b=jzTYY0cDVg7JDDbI0PHfgjSmBXomRFC4ajTWuw+zyaP+xYSgv817c87dY9MvwEqiiK
         PbicuxxnFEpApj+LCByFADX8wdBDxBlrATa1NOMqHujkL8fIN/dMnaPS0rGX2yeXMo58
         bZg8NbdZiBpWfQxNI6IezvmLhamnMpP6vbqh5HSxthhgr5xXGiKSkTJzf2cCuGUUORIX
         n5bkQOHMfdybRiWDmPG+umxK4R4yM/xsfoYGeh7YSY7+wuADtX2o7E+gHle/wVtx0LCs
         kZZJkHjxNqnUaeOUSM/AEvw2nezafxOejx/F2nYzvwzSoSySa6+cUaU9jFlE9T1HXVXC
         meaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728084143; x=1728688943;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uLuleRH6kmBXXjf2tgctsV8mhLkdmO/MMK4eH0w4Y8=;
        b=tld11pzBw78mS0BWGy/OhpWn+IV+UKhxfkLAhlONUBnFPkPgP/JrhmqKq3yQ74JcsU
         f6qfQbu2SfSu64i1BEwO9zX29VtrqsjOLrqJN7HawCk1CxjaJa4s9wfKCgAFME/MRqkE
         3iTYv5y9lRVXGARMPenb8U88RsTJJw0Eoxg24v4auhe39vRee0vzMQprTIE+6kotdmwo
         zHQvrod181HO1iIMuArBOxvtTc7go+uHw3bx3A6ZOdYNNjiNzo0Q5XG0W0W45y9YDqYp
         4wxUIAXpMvyePcSc2jJf+B/iSZZU6WkyVRXacvHOnTtDwAUXMhWbKLQeF1P/FYaqUv3t
         fjaQ==
X-Gm-Message-State: AOJu0YxkfDctohlmoict57BWcfZhg6ajTtGo0f4eP1GTlvwjAxuqjRGp
	rXwx12ZWkUxEBarehDIzxKvsclziPxBbTW0Nwv/cNdjDoQZ1QS0OCNO9Rg==
X-Google-Smtp-Source: AGHT+IEqvkvn+Pu4sqmeJ6sDqN+N/l+pjrTQNNEurfexMM3pbtPugVas9kTr1oValgA4wseTTVyOgQ==
X-Received: by 2002:a17:906:7946:b0:a80:f840:9004 with SMTP id a640c23a62f3a-a991bce3fa6mr389601466b.12.1728084143130;
        Fri, 04 Oct 2024 16:22:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e5ba3c2sm54686966b.10.2024.10.04.16.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 16:22:22 -0700 (PDT)
Message-Id: <167418d10d137cbcd278a98c95168150df10627d.1728084140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
References: <pull.1784.git.git.1726943880.gitgitgadget@gmail.com>
	<pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
From: "Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Oct 2024 23:22:19 +0000
Subject: [PATCH v2 2/3] rebase-update-refs: extract load_branch_decorations
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Nicolas Guichard <nicolas@guichard.eu>,
    Nicolas Guichard <nicolas@guichard.eu>

From: Nicolas Guichard <nicolas@guichard.eu>

Extract load_branch_decorations from todo_list_add_update_ref_commands so
it can be re-used in make_script_with_merges.

Since it can now be called multiple times, use non-static lists and place
it next to load_ref_decorations to re-use the decoration_loaded guard.

Signed-off-by: Nicolas Guichard <nicolas@guichard.eu>
---
 log-tree.c  | 21 +++++++++++++++++++++
 log-tree.h  |  1 +
 sequencer.c | 11 +----------
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index cd57de2424e..5c17aff2265 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -248,6 +248,27 @@ void load_ref_decorations(struct decoration_filter *filter, int flags)
 	}
 }
 
+void load_branch_decorations(void)
+{
+	if (!decoration_loaded) {
+		struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
+		struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
+		struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
+		struct decoration_filter decoration_filter = {
+			.include_ref_pattern = &decorate_refs_include,
+			.exclude_ref_pattern = &decorate_refs_exclude,
+			.exclude_ref_config_pattern = &decorate_refs_exclude_config,
+		};
+
+		string_list_append(&decorate_refs_include, "refs/heads/");
+		load_ref_decorations(&decoration_filter, 0);
+
+		string_list_clear(&decorate_refs_exclude, false);
+		string_list_clear(&decorate_refs_exclude_config, false);
+		string_list_clear(&decorate_refs_include, false);
+	}
+}
+
 static void show_parents(struct commit *commit, int abbrev, FILE *file)
 {
 	struct commit_list *p;
diff --git a/log-tree.h b/log-tree.h
index 94978e2c838..ebe491c543c 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -33,6 +33,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     int *need_8bit_cte_p,
 			     int maybe_multipart);
 void load_ref_decorations(struct decoration_filter *filter, int flags);
+void load_branch_decorations(void);
 
 void fmt_output_commit(struct strbuf *, struct commit *, struct rev_info *);
 void fmt_output_subject(struct strbuf *, const char *subject, struct rev_info *);
diff --git a/sequencer.c b/sequencer.c
index 8d01cd50ac9..97959036b50 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6403,14 +6403,6 @@ static int add_decorations_to_list(const struct commit *commit,
 static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
 {
 	int i, res;
-	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
-	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
-	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
-	struct decoration_filter decoration_filter = {
-		.include_ref_pattern = &decorate_refs_include,
-		.exclude_ref_pattern = &decorate_refs_exclude,
-		.exclude_ref_config_pattern = &decorate_refs_exclude_config,
-	};
 	struct todo_add_branch_context ctx = {
 		.buf = &todo_list->buf,
 		.refs_to_oids = STRING_LIST_INIT_DUP,
@@ -6419,8 +6411,7 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
 	ctx.items_alloc = 2 * todo_list->nr + 1;
 	ALLOC_ARRAY(ctx.items, ctx.items_alloc);
 
-	string_list_append(&decorate_refs_include, "refs/heads/");
-	load_ref_decorations(&decoration_filter, 0);
+	load_branch_decorations();
 
 	for (i = 0; i < todo_list->nr; ) {
 		struct todo_item *item = &todo_list->items[i];
-- 
gitgitgadget

