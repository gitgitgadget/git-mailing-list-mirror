Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F444DB9D
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220645; cv=none; b=mTaxO10whQA7nyPv785wSyEkvihRo8QFI8xLz0OQOP+pBRYJXjbzv3AE7Xwf65CZgrDj4FEYy9qLXjasu4oTEvqtMH0w8gnvBk2tAPs6Zr46BRK0vYMhi0vhzNIVrveKMB+gkcsn0USXynFhFh4D9Hof5D7VIb/En0LfQm179Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220645; c=relaxed/simple;
	bh=Br9fh4xYZp/0+MMbJVSZzLA+hlTvy+PAmwgycQT9I3I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ops3Q4Oef+N7vlYbdPhQvcRRPyVf81ewWLfqybN7SakQile3Pt+l8nsHIAt1t2ppGvSScnXXvPJeS60XpfCs8nYUqzaqrdOWUDiumKPwBP8cT+7/HnZJTF784w3LGVrqfwPWW4elZE5OIT0UMVMSaU3rCvW2J6dZWZUKa7fV/mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIy1K7Yr; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIy1K7Yr"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12732165d1eso2648895c88.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772220643; x=1772825443; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyHey4t4KqYE+27pGtOhB2Kz5WT8ieoG1Bb3LiW+6fE=;
        b=QIy1K7Yr4aaAV+s3NCPLhmQ5svLwrzz7v5Zf6D8ft6c0zr+EjB9bF4jTjgN8Y/YpL5
         3jswKNQg4RLm6cay55EdNmsB+AhCid77SRPKHJ5Rk/adB+kpxXHuDxGs135DT9W5Z/S/
         Gj/H7Cqhztlm4HHJIxrpsChFmJNsaI375LLwwsT4cjTvz8FdzrJ3gKgCk5ODDUjNxom9
         ynuNHILiJ+l9B8ImUqai4RDjwGFkb/MgbESVaVyvNq4U+imyexhh3Oknq0FNdB7NB5b5
         yfLYg4GrjsShKRaNs0RgnD9urfZtvqsG6UmpTKNnXGtAzz5hh5RnnbFt1Khy6tNKyTcx
         YOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220643; x=1772825443;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dyHey4t4KqYE+27pGtOhB2Kz5WT8ieoG1Bb3LiW+6fE=;
        b=xNd03tp2ZY+la3L0vsbsoEHVB6fGRrZ8Nf7poG7y/YcOmZfQcvbreX8Mox92kITWpK
         x30+c9/5PW/u0E/Dtsce8X/TeYFpupgwWKQ6nNOVuytrSPnAZpwZ4b5+vfs9OUjQAKRE
         kKe9A054rMD1faEdqun1rcBA/CodBu525Z1CIq8En5flLeM2Vcp2Sv+4emM36RIvvwxC
         RjiB25Myu8pqKFmw5SLyl+TxtPnpQTlm+oQbP7ZjcwqOz/IwX/QND2PrhK7pkBsKDFvf
         CxL5cYTb3sDmpOfHtRUhAQ+X0PNtaGibCwpArygjryeuoQAhyhVFzIOtDe9EyWjdVrru
         GQBw==
X-Gm-Message-State: AOJu0YxW2IJwcE21WeghxyV00gblpGAqjTi+oMh1Cnf+5gphfawttMvP
	GnTq0xRTblV4RstPU/vDgKZO576seb9KM3q5E1YhGqoQVcFwdTfE+Bxda5VG8A==
X-Gm-Gg: ATEYQzzYHyhthf6XAMvG4arv/Ur02/URGrzY5jPnWt5v8fWenJiiDzrjGVRaqt6Rozk
	nUAjxSsuVvmJRjqUmCUD0ZoQERb+StTF/Z9UHU+rmR5K1grFu/fwcGFtn3XpyDhFLGHYZ3JAUug
	MkN9VY9TIRJ+C76DwVJfAHYb7QnUJU8pDIvGIrgQQ+z3J40pLPOaZWh2ajh5haNEaA1qMhu7RH2
	S8ChI/sqhuKbnsyoA5scsyQnmwkmLmFvHGxEynWBf7AP5OKw5nOBQDVVHKwqc884a3KHlP2coGs
	7+VqmlMW5XjH4FxH3haa0de+uPXOX9AgfnOg+C7vckYpI6wQrMKI/zMaKoKPVdKEQH8z4CqS9YX
	dkLoLSKD/jIS3F9nuAoOJeZ6Z3WJ3s0OES2KlfspfMfLdKiR9KjFDPjhzn68O/tYrhlJLaRhllg
	FdbW7CYehiTnsay9/MRIPO1dLBjEQ=
X-Received: by 2002:a05:7022:1e0f:b0:127:c88:d597 with SMTP id a92af1059eb24-1278fc0dbb6mr1683823c88.10.1772220643131;
        Fri, 27 Feb 2026 11:30:43 -0800 (PST)
Received: from [127.0.0.1] ([172.184.191.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899d49c1sm7364772c88.1.2026.02.27.11.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:30:42 -0800 (PST)
Message-Id: <99c8058298d403508ab2a23ed06c36b8707989d0.1772220640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 19:30:30 +0000
Subject: [PATCH v5 01/11] repo: teach info context and category keys
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
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Introduce an explicit repo_info context for the repo info codepath
and thread it through value lookups and field printing.

This removes direct coupling from these helpers to ad-hoc
repository globals and makes key retrieval logic easier to extend
safely.

Also teach git repo info to accept category names (for example,
layout) and expand them to matching key.* entries in request
order.

This improves script ergonomics while preserving existing behavior
for explicit keys and clear errors for unknown names.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 70 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..e34914a9a7 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -22,7 +22,12 @@ static const char *const repo_usage[] = {
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
@@ -35,27 +40,30 @@ struct field {
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
@@ -87,6 +95,33 @@ static get_value_fn *get_value_fn_for_key(const char *key)
 	return found ? found->get_value : NULL;
 }
 
+static void print_field(enum output_format format, const char *key,
+			const char *value);
+
+static int print_category_fields(const char *category,
+				 struct repo_info *info,
+				 enum output_format format,
+				 struct strbuf *valbuf)
+{
+	int found = 0;
+	size_t category_len = strlen(category);
+
+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
+		const struct field *field = &repo_info_fields[i];
+
+		if (!starts_with(field->key, category) ||
+		    field->key[category_len] != '.')
+			continue;
+
+		strbuf_reset(valbuf);
+		field->get_value(info, valbuf);
+		print_field(format, field->key, valbuf->buf);
+		found = 1;
+	}
+
+	return found;
+}
+
 static void print_field(enum output_format format, const char *key,
 			const char *value)
 {
@@ -105,7 +140,7 @@ static void print_field(enum output_format format, const char *key,
 }
 
 static int print_fields(int argc, const char **argv,
-			struct repository *repo,
+			struct repo_info *info,
 			enum output_format format)
 {
 	int ret = 0;
@@ -117,21 +152,22 @@ static int print_fields(int argc, const char **argv,
 
 		get_value = get_value_fn_for_key(key);
 
-		if (!get_value) {
-			ret = error(_("key '%s' not found"), key);
+		if (get_value) {
+			strbuf_reset(&valbuf);
+			get_value(info, &valbuf);
+			print_field(format, key, valbuf.buf);
 			continue;
 		}
 
-		strbuf_reset(&valbuf);
-		get_value(repo, &valbuf);
-		print_field(format, key, valbuf.buf);
+		if (!print_category_fields(key, info, format, &valbuf))
+			ret = error(_("key '%s' not found"), key);
 	}
 
 	strbuf_release(&valbuf);
 	return ret;
 }
 
-static int print_all_fields(struct repository *repo,
+static int print_all_fields(struct repo_info *info,
 			    enum output_format format)
 {
 	struct strbuf valbuf = STRBUF_INIT;
@@ -140,7 +176,7 @@ static int print_all_fields(struct repository *repo,
 		const struct field *field = &repo_info_fields[i];
 
 		strbuf_reset(&valbuf);
-		field->get_value(repo, &valbuf);
+		field->get_value(info, &valbuf);
 		print_field(format, field->key, valbuf.buf);
 	}
 
@@ -171,6 +207,10 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
 	enum output_format format = FORMAT_KEYVALUE;
+	struct repo_info info = {
+		.repo = repo,
+		.prefix = prefix,
+	};
 	int all_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
@@ -192,9 +232,9 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
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

