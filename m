Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B458A18756D
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460708; cv=none; b=rodhZoKMN1kHFcLnPO6awahtCMp9FBrjM4Gp+fPfTgywqA15YS9VoS596tO8VawjJCefyyIIc3sO2m1nJgmAAXZHIoG6fkbIW3DA1KB8Ktip79PYri6yG2T6azjdeBe2fcunWiRvINIqYgD6TGK1pXkikzbyhbTMcWUPI3a+neU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460708; c=relaxed/simple;
	bh=UzUkw+lEkUC3fXwqsucIoM7DC2PfblCNaKUFZm2RFcY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Vj8h8GxbGKVS1ZnuUCIC3+u/qdYRYbjKNSoyeU+TOaWqi9aSCwDKRyZk1Z9gHHiGceoNAGU1XdROf2HFQxMCjE/ldsl/qgtBfo4gfLoUGIHtBxeAW7iu5xP+n+EeTeiHsM8BzdJstSBEt8awPqvrhRFwefIp8xsAi/d7zuaT0is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9NZbE7g; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9NZbE7g"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a993302fa02so506841366b.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 00:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728460705; x=1729065505; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsHe18VBI10BDW/fSoPKanp4k8unG/pui4QBSPjAWaQ=;
        b=R9NZbE7gaMCn7rbucQUBL9jd5ONFzYrKRsh2DZbO6mxGGZ8SzXGEY2eRwvk+ztSKB5
         uwzmehj6bIJRPesXSJC60dWmG2Wqi83tdS2LpQI+v1ITAsML3tpOef/ieDrwOlIhZ/rZ
         WSYp+O8kAiiEFXkYm+vsT8rWY4JhF6eLqXz0bVWexj9n6+hoMDofdjaY2RqC58VEYI8t
         16OHNgA+0P+trBxz7cTj1qriqclmPSujRWucsRfGICxGqlTn72vjzpUZQMi6jZOJ6oDp
         gXikGdG3T1BMOpBpx3pLxsnAAC9EImRttak+vQVEk1QhkQ79l7uZzLK5b2DyG3spdgXY
         ToHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460705; x=1729065505;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsHe18VBI10BDW/fSoPKanp4k8unG/pui4QBSPjAWaQ=;
        b=AOLrFQRpzf5F0acDhIgrUgR3hL5QCtckUFAK2gbawEDmvokvrGYIgU1eeadfpFjbuX
         P1WxxchwvwO94tKyK+sx3i3l4ddh0CBqE78AoTTwuzQ/i0fD7fi377+kypd70ZqvT/X+
         +19Rf9DfCBH+aI17FLQsaD8uGH2+NpSp0tpgzmzhyLZAe6TJs7EX38TN/2mSaaMmw1Yi
         sPFITo2mV+RtgtQReJpZ3ADcgmTy3H3mP6Jm8pm3rSDhq//8VBJdwDmWK+DCkiFVUiL+
         z4HzqvwRbqTZBjKGAu3VUCBK41CW0VlJcs1MmrirWQ/06bGYKBLiM4ZBmPJ6b7AtSsyL
         +6RQ==
X-Gm-Message-State: AOJu0Ywtg5sUSL6fCGIiQ5vJplDtxMn//EzFB5OoX8AyPwGSlfpr7PX1
	4IHbT82zcqM+wD9HPzpGzSA+jIh8q76ZlQKMuDSwDtmFXEsofvZmpK8Yrg==
X-Google-Smtp-Source: AGHT+IFWx4p0I0q0zQlnPaOJt9gm0kRBydDrLvWl0Gr2nyxrOtyAJ9+TzEmcEnsZjqgRq1IxP5gBhg==
X-Received: by 2002:a17:907:e8b:b0:a99:7c14:9197 with SMTP id a640c23a62f3a-a998d3856ecmr120965166b.64.1728460703712;
        Wed, 09 Oct 2024 00:58:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9957d955f8sm356466566b.74.2024.10.09.00.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:58:23 -0700 (PDT)
Message-Id: <1dad6096eb7f329d8b43390f1a445e28d0e609d9.1728460700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1784.v3.git.git.1728460700.gitgitgadget@gmail.com>
References: <pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
	<pull.1784.v3.git.git.1728460700.gitgitgadget@gmail.com>
From: "Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Oct 2024 07:58:19 +0000
Subject: [PATCH v3 2/3] rebase-update-refs: extract load_branch_decorations
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
    Eric Sunshine <sunshine@sunshineco.com>,
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
index c65ebd29202..bf6d2ae40c8 100644
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
+		string_list_clear(&decorate_refs_exclude, 0);
+		string_list_clear(&decorate_refs_exclude_config, 0);
+		string_list_clear(&decorate_refs_include, 0);
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

