Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3894315A
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772428555; cv=none; b=Hp4BW26EsLv6szBmqIhfdHXP14LVzP+JYQ7waO4lggXTyEEqITbtUmHz9lX6Pi5PXyqFE1dlGcriG7c3Ng3lCDnk3N/ljk1gK/GJz4wxaz0UCWUvFDEOB2ZlnqjIj7SJhecmne8UJceu+SGlhGWZowQjA9FNxyHH1UUhCXe34QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772428555; c=relaxed/simple;
	bh=WazQA8RUDrf4NA2RcWiTkv5J62f2Z7RpPyzFhk/gnGA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fBr0ldiiY/q7GSIX0GVV8Od9LA83wOJWxfqLYFQyLvCPwGAnAuNns6a6Vyxi7CaxPlmnJjmRaqe2yMqlIckkKOzc/mVoY0M72VMtII8fjKqcUYANwieGRlFS3rGlq1FAGdjzJ686vHm1cxLQatpYGaBGCT+W+zEs+624orxTusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O586mG1N; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O586mG1N"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5069b3e0c66so71715271cf.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 21:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772428552; x=1773033352; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhTB2VVYsyg7/VNOOMihThqcLVi/L/jlk97cGlST3+4=;
        b=O586mG1NpMD43loTKOc3eZPnhDehkyQpwJl0ZvB9XOlXjeBfyrZO9uBM1UcktErsUu
         78bVHsUytR3sQa43YPt7gFt1qJao55j2to6gR57lSqbA+pBZpESynxl/5JQbDxqOzRre
         1CeTlfeHuM5czsX/UBG/ddxLbttWMm48M8WJkbcGXMHKxxDTafErhX1U+evrWzkcfDsq
         ueK9N06J8HxbT2MVbqR4D7FquwIZ56fW8DH/xKUMncDCNjjDiMn41e5XCbbA5/BafAwA
         InW34hJxRswMn5eb9z7/rvRcxlW+uLGbP+y7WYrRJk6wvxfQPj3htQk4c5X81EwLFhjX
         9kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772428552; x=1773033352;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zhTB2VVYsyg7/VNOOMihThqcLVi/L/jlk97cGlST3+4=;
        b=c6X5SGTio6kwcMs5j+Y908IzkI/t0GG1z7mkZ0b9IJQmbVNMe+66lIYSyf9TB2E/Hr
         dD7hrcLC2gYPSGJlIi++YAduG3VBy3MGvZbYEiz9y8Uxm0MGlQgRvQVeSTGIP0BU0V7h
         CKYasE2nRB+1q6BYJ6zFRNq7n7hIrfwUDusMDywu3EzHMIU9p6uhHm/QkwBEdSncxdER
         096vu7oY7L43noW+jwND8G0JFMG/iO5m+0SOVQySgxBJGe5eW35xEzWPDLHfRT5hLM/+
         n1Fqp0k3uIE9x1IlPV6loR5b/yhsFVvyC/AEB7106ySYdi+0SneFmJknXSZXVffkDUWP
         kuWg==
X-Gm-Message-State: AOJu0YzWbzW4c2R99/18XEMED0dRpBmA9RM2EXNxUZ4YkpNPHAkhX/NS
	XhwFRNt8M6jJOXGhYYI6W4S+6wAQ17E39gf3Lh+iTPUI9QxnYd8LCWMVtoeHwaTx
X-Gm-Gg: ATEYQzyqueCCPADEWUpI39UK1Mfg0RiXRQiK74hSGTgcDRc1Z6rUubY8AVKkmYkFPg0
	jSQHulhOZwJMV/QiqwV/mrBtWuSM27Fw06a5CUoN08rZ6Oq+szbRwHk7HLtYByRoZoU7cZ2KNTH
	IYohGiZBhTKQIsWsCTOjg3wB3ObZuUAXizwLJ7OBH3QQM8UUa23tG6nwvtGi3zcvW6i+RcSBeR2
	N76za+pCNb1FfnITTdIcxD//sJnZL1Nah9pK9zxYCN+ODBc5wuC3xP2A2MVjZl7xEnPVVCdnXU5
	7shIEJ1pdQMCwVvYuVv6eNcCX4RxdrYWqCdb7+lPx19wTApAlLEfXxYNmBz21oww9/MhQd7SGRu
	X4tfsrcSKgwk7CyEMU0vKBPDulhHqK3AgEbGMqdMyCCS5I/y5eyiRjq6WIjFuBiHAysg5vQzC6I
	r2xK28OeELqyZXTuBIq2E35FH6Fw==
X-Received: by 2002:a05:622a:1191:b0:4ee:17d8:b583 with SMTP id d75a77b69052e-507443e23a2mr160730021cf.27.1772428552554;
        Sun, 01 Mar 2026 21:15:52 -0800 (PST)
Received: from [127.0.0.1] ([172.183.95.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf732bc1sm1080307285a.46.2026.03.01.21.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:15:51 -0800 (PST)
Message-Id: <bddea1a22e56b7b2988f795e5e0556c6707a126c.1772428548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
References: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
	<pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 05:15:43 +0000
Subject: [PATCH v6 1/6] repo: introduce repo_info context plumbing
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Introduce a repo_info context and thread it through get_value_fn,
field lookup, and value-printing helpers.

This prepares repo info for fields that need invocation-specific
context in addition to the repository handle.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 6a62a6020a..e687d833b4 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -23,7 +23,12 @@ static const char *const repo_usage[] = {
 	NULL
 };
 
-typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
+struct repo_info {
+	struct repository *repo;
+	const char *prefix;
+};
+
+typedef int get_value_fn(struct repo_info *info, struct strbuf *buf);
 
 enum output_format {
 	FORMAT_TABLE,
@@ -36,27 +41,30 @@ struct field {
 	get_value_fn *get_value;
 };
 
-static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
+static int get_layout_bare(struct repo_info *info UNUSED, struct strbuf *buf)
 {
 	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
 	return 0;
 }
 
-static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
+static int get_layout_shallow(struct repo_info *info, struct strbuf *buf)
 {
+	struct repository *repo = info->repo;
 	strbuf_addstr(buf,
 		      is_repository_shallow(repo) ? "true" : "false");
 	return 0;
 }
 
-static int get_object_format(struct repository *repo, struct strbuf *buf)
+static int get_object_format(struct repo_info *info, struct strbuf *buf)
 {
+	struct repository *repo = info->repo;
 	strbuf_addstr(buf, repo->hash_algo->name);
 	return 0;
 }
 
-static int get_references_format(struct repository *repo, struct strbuf *buf)
+static int get_references_format(struct repo_info *info, struct strbuf *buf)
 {
+	struct repository *repo = info->repo;
 	strbuf_addstr(buf,
 		      ref_storage_format_to_name(repo->ref_storage_format));
 	return 0;
@@ -106,7 +114,7 @@ static void print_field(enum output_format format, const char *key,
 }
 
 static int print_fields(int argc, const char **argv,
-			struct repository *repo,
+			struct repo_info *info,
 			enum output_format format)
 {
 	int ret = 0;
@@ -124,7 +132,7 @@ static int print_fields(int argc, const char **argv,
 		}
 
 		strbuf_reset(&valbuf);
-		get_value(repo, &valbuf);
+		get_value(info, &valbuf);
 		print_field(format, key, valbuf.buf);
 	}
 
@@ -132,7 +140,7 @@ static int print_fields(int argc, const char **argv,
 	return ret;
 }
 
-static int print_all_fields(struct repository *repo,
+static int print_all_fields(struct repo_info *info,
 			    enum output_format format)
 {
 	struct strbuf valbuf = STRBUF_INIT;
@@ -141,7 +149,7 @@ static int print_all_fields(struct repository *repo,
 		const struct field *field = &repo_info_fields[i];
 
 		strbuf_reset(&valbuf);
-		field->get_value(repo, &valbuf);
+		field->get_value(info, &valbuf);
 		print_field(format, field->key, valbuf.buf);
 	}
 
@@ -195,6 +203,10 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
 	enum output_format format = FORMAT_NEWLINE_TERMINATED;
+	struct repo_info info = {
+		.repo = repo,
+		.prefix = prefix,
+	};
 	int all_keys = 0;
 	int show_keys = 0;
 	struct option options[] = {
@@ -225,9 +237,9 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 		die(_("--all and <key> cannot be used together"));
 
 	if (all_keys)
-		return print_all_fields(repo, format);
+		return print_all_fields(&info, format);
 	else
-		return print_fields(argc, argv, repo, format);
+		return print_fields(argc, argv, &info, format);
 }
 
 struct ref_stats {
-- 
gitgitgadget

