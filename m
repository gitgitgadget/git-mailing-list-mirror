Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E551D5151
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772318691; cv=none; b=HzAzSO8Q59/y5p6AJ2ck3JeftbUXpMzgxP+FThYs4eXJm9/e1TL/i1WcwZQr1+uEJETF20hNrXPfueI3YENX1LBwPL+w12cUXM+Mvn+L2ApDAIeftkRUQzBFNV/eQEfu6GMZ7PsWzEjY960e18h0IFBJNX8tqm8fS/wAXDa3aO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772318691; c=relaxed/simple;
	bh=KIde4HF/qrdILG6PR/L/i4XT3ekwf5kynsrgbfo0ZXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+bZQPVmoriCumaNpaKyezLbLeNGr306vAkVGSitk9SWo/4KyFJzF6+Q8cweUvpv84/G77b5m7nRBHLNHa9um/aRQKqYn/WAljmescnKaVZ476zDdKh7M66iCHg6ZFK9MIJC8zTMWFG4nXmbqpvx1ORhL939ICuuel7DIuHS21U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9mprc9X; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9mprc9X"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56a9076813bso1266550e0c.3
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 14:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772318688; x=1772923488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXwFWt642qrhYHWZWf8G6dtGIcW/1ioQBUVi6cw3eo8=;
        b=h9mprc9Xc1CT2Mh4Onbfby6T15VV6pQ75JjUhKDSDaAP/djGI0vj5IfIPNlJvkiaub
         oxKsFFmPzPUENFhoCzlcpGDFRteZCQBa+EqcI0SewV490uM9iIUlTfGsjG6unQZxmFmj
         E0snG7iPKuvAKtmbgVYEeHTKF2S29BpI9vgyRnp0oChQpVha3QB/Zp7Uc3UnXzJ0a5rS
         +QH5OrQfgY0Dm4VN1sd/Z3SP5Iu7GHQFcAPJHvKOhrPW2rN3i+nJPFfwiOUf/kd5G6Dc
         sKPrhvjmzrkRyvgkgcJGbP9npV8tu8wfwf99EwNxOi00qa3ZRXLkKFJyOo1fFIBqnD9v
         T4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772318688; x=1772923488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kXwFWt642qrhYHWZWf8G6dtGIcW/1ioQBUVi6cw3eo8=;
        b=XPdLkxvVeuh25Du+Hqh6y4lp6gAijew9D9swuckQKb1dyUzeGaZArFnkgEk0AnRmOo
         YBhewwYc4rDm+ZfZyWEFott34s7GvY95fVLXaJV59SifaJy2YqAMQvCceeKUJxcudCay
         NQR1ZLFmT/gxB939qe9cHBMAy0W+UvpMaBkEfZZMl5pm2mD9YsFQnXB2p8Bwd6fpVLXY
         cgZYjlbikwK5i4tfgSq+VFgZsCsjY19ulLeLm5zt9gaMf23nZv6zFW1/lSSWwfC9l3GM
         irZJgeut6KgXamXnELXnKYPQgGE7gvlZY79YYM0RwA5bqOp/Fsd/5QSFPpU3UcPiDGyE
         M9mA==
X-Gm-Message-State: AOJu0YwsFmP2wQvNNpvlGUgMwW2lAU4eOBAdK6mIcRSkR4H1dG50ifur
	OPo2m0NvYuHJZluqb8qAFJPupkckagl2avApkh1dWNTVkJMWwzwEc2hkVkjGWXK4
X-Gm-Gg: ATEYQzw0CfyopGHJiaaaipETrtyCOzUla9DbIfVEHpcq2mkRZoHojhBXoVEuMoSmzE4
	+VL/HTaAur3fGs44aZ3sYBM63+cV95XwrYw4j2LT8Zd5Lo9gISMBk8qmfnFdrdlVqR/vwJ0wKFL
	mF357/IF7xWJLE4gBu2LIapykztjhVqFZPwdWnIbWuTNTw5RNHMI5TrB2IJBeFnJ0vkuCEjq/C9
	tDQTS+eSiPQZiBk/pdHTRD70aubTZFXWB3jqZGL2vGqBl7Zzt9Wo2QHvZ9l1srmnWQWTsCefKkd
	SNeif1RfyQXMO27B4zdS4eGdVIOW0O+KoQGhaM/4jwPHA65E/JcI1IUK7oOqmlkD4xGX/XhUnLx
	oUuRYeBQ2ruTYa1RPf0cDur7cwDBlOdagFZe/3Y9QrUDbQW6PcAtH5mkUiWxs6j8JFfRPUL7gUp
	dxyoVDUG2UtLWFRY0p+qYjtxRBJHru85TE+tOcWJo5ZAnff/pJ8gC3BrhVH3AE2y25eec=
X-Received: by 2002:a05:6122:1b05:b0:55f:c6c9:e4ba with SMTP id 71dfb90a1353d-56aa0ac3b1fmr3222962e0c.13.1772318688381;
        Sat, 28 Feb 2026 14:44:48 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:c4:89c7:617e:ea24:9d26:4bc7])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91659421sm11739094e0c.0.2026.02.28.14.44.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 14:44:48 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	jayatheerthkulkarni2005@gmail.com,
	valusoutrik@gmail.com,
	pushkarkumarsingh1970@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH 4/4] repo: add the field path.toplevel
Date: Sat, 28 Feb 2026 19:05:58 -0300
Message-ID: <20260228224252.72788-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flag `--show-toplevel` from git-rev-parse is used for retrieving
the top level directory path of the repository. This way, it is used for
querying repository metadata, fitting in the purpose of git-repo-info.

Add a new field `path.toplevel` to the git-repo-info subcommand
containing that information.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo.c       | 47 +++++++++++++++++++++++++--------
 t/t1900-repo-info.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 11 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index cff4c6db9b..61cd539e05 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -22,7 +22,8 @@ static const char *const repo_usage[] = {
 	NULL
 };
 
-typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
+typedef int get_value_fn(struct repository *repo, struct strbuf *buf,
+			 const char *prefix, enum path_format_type format);
 
 enum output_format {
 	FORMAT_TABLE,
@@ -35,26 +36,46 @@ struct repo_info_field {
 	get_value_fn *get_value;
 };
 
-static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
+static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf,
+			   const char *prefix UNUSED,
+			   enum path_format_type format UNUSED)
 {
 	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
 	return 0;
 }
 
-static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
+static int get_layout_shallow(struct repository *repo, struct strbuf *buf,
+			      const char *prefix UNUSED,
+			      enum path_format_type format UNUSED)
 {
 	strbuf_addstr(buf,
 		      is_repository_shallow(repo) ? "true" : "false");
 	return 0;
 }
 
-static int get_object_format(struct repository *repo, struct strbuf *buf)
+static int get_object_format(struct repository *repo, struct strbuf *buf,
+			     const char *prefix UNUSED,
+			     enum path_format_type format UNUSED)
 {
 	strbuf_addstr(buf, repo->hash_algo->name);
 	return 0;
 }
 
-static int get_references_format(struct repository *repo, struct strbuf *buf)
+static int get_path_toplevel(struct repository *repo, struct strbuf *buf,
+			     const char *prefix, enum path_format_type format)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+	if (work_tree)
+		strbuf_add_path(buf, work_tree, prefix, format,
+				PATH_DEFAULT_UNMODIFIED);
+	else
+		return error(_("this operation must be run in a work tree"));
+	return 0;
+}
+
+static int get_references_format(struct repository *repo, struct strbuf *buf,
+				 const char *prefix UNUSED,
+				 enum path_format_type format UNUSED)
 {
 	strbuf_addstr(buf,
 		      ref_storage_format_to_name(repo->ref_storage_format));
@@ -66,6 +87,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.toplevel", get_path_toplevel },
 	{ "references.format", get_references_format },
 };
 
@@ -108,8 +130,9 @@ static void print_field(enum output_format format, const char *key,
 
 static int print_fields(int argc, const char **argv,
 			struct repository *repo,
+			const char *prefix,
 			enum output_format format,
-			enum path_format_type path_format UNUSED)
+			enum path_format_type path_format)
 {
 	int ret = 0;
 	struct strbuf valbuf = STRBUF_INIT;
@@ -124,7 +147,7 @@ static int print_fields(int argc, const char **argv,
 		}
 
 		strbuf_reset(&valbuf);
-		field->get_value(repo, &valbuf);
+		field->get_value(repo, &valbuf, prefix, path_format);
 		print_field(format, key, valbuf.buf);
 	}
 
@@ -133,7 +156,9 @@ static int print_fields(int argc, const char **argv,
 }
 
 static int print_all_fields(struct repository *repo,
-			    enum output_format format)
+			    const char *prefix,
+			    enum output_format format,
+			    enum path_format_type path_format)
 {
 	struct strbuf valbuf = STRBUF_INIT;
 
@@ -141,7 +166,7 @@ static int print_all_fields(struct repository *repo,
 		const struct repo_info_field *field = &repo_info_field[i];
 
 		strbuf_reset(&valbuf);
-		field->get_value(repo, &valbuf);
+		field->get_value(repo, &valbuf, prefix, path_format);
 		print_field(format, field->key, valbuf.buf);
 	}
 
@@ -239,9 +264,9 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 		die(_("--all and <key> cannot be used together"));
 
 	if (all_keys)
-		return print_all_fields(repo, format);
+		return print_all_fields(repo, prefix, format, path_format);
 	else
-		return print_fields(argc, argv, repo, format, path_format);
+		return print_fields(argc, argv, repo, prefix, format, path_format);
 }
 
 struct ref_stats {
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index f5c76067cb..4985a9cc70 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -38,6 +38,53 @@ test_repo_info () {
 	'
 }
 
+test_repo_info_path () {
+	label=$1
+	repo_name=$2
+	key=$3
+	relative_path=$4
+	default=$5
+
+	absolute_path=$(cd "$relative_path"; pwd)/"$repo_name"
+
+	case $default in
+	absolute)
+		expected_value="$absolute_path"
+		;;
+	relative)
+		expected_value="$relative_path"
+		;;
+	esac
+
+	test_expect_success "setup: $label" '
+		git init "$repo_name"
+	'
+
+	test_expect_success "nul: $label" '
+		printf "%s\n%s\0" "$key" "$expected_value" >expected &&
+		git -C "$repo_name" repo info --format=nul "$key" >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "default: $label" '
+		echo "$key=$expected_value" > expected &&
+		git -C "$repo_name" repo info "$key" >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "absolute: $label" '
+		echo "$key=$absolute_path" > expected &&
+		git -C "$repo_name" repo info --path-format=absolute "$key" >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "relative: $label" '
+		echo "$key=$relative_path" > expected &&
+		git -C "$repo_name" repo info --path-format=relative "$key" >actual &&
+		test_cmp expected actual
+	'
+}
+
 test_repo_info 'ref format files is retrieved correctly' \
 	'git init --ref-format=files' 'format-files' 'references.format' 'files'
 
@@ -69,6 +116,21 @@ test_repo_info 'object.format = sha1 is retrieved correctly' \
 test_repo_info 'object.format = sha256 is retrieved correctly' \
 	'git init --object-format=sha256' 'sha256' 'object.format' 'sha256'
 
+test_repo_info_path 'toplevel is retrieved correctly' \
+	'toplevel' 'path.toplevel' './' 'absolute'
+
+test_expect_success 'git-repo-info fails if an invalid key is requested' '
+	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
+	test_must_fail git repo info foo 2>actual_err &&
+	test_cmp expected_err actual_err
+'
+
+test_expect_success 'git-repo-info outputs data even if there is an invalid field' '
+	echo "references.format=$(test_detect_ref_format)" >expected &&
+	test_must_fail git repo info foo references.format bar >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'values returned in order requested' '
 	cat >expect <<-\EOF &&
 	layout.bare=false
-- 
2.50.1 (Apple Git-155)

