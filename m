Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436F31B133
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993969; cv=none; b=WLDAR5i/TKM5M9+b+AYm7LHqyvWgKkPbQoWzgBu5nt+CgP4cZGHz7YLT9cPaFrjluten6EOHL2lwlAaVEIybPNGZ7c2IiCIxRcBYiJoKw4dveR31CVykAuH2pqbxWOfhR9XnxxUX/Z+dYX8753BsV116pncCQqDzf2vKif/MmbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993969; c=relaxed/simple;
	bh=3BGJyVlopkU4x9TgcqrSPfnGbo6LKG+RJwec8p9NP3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jADTOan6dSdNWeOhj6x70pBukulQA3JWacaXM8FYZHVBm2Ur/sT0D/til/hucKvP4EqBIwSwBLXIL1p3bPxm54z6ADsxkYPO7NwYcmnQjte92rWEPiXvFl9WHqCfxmI3xdvfP0EnzzLb0/WYMPFozkS5iKPgEEFp39l6AmqN3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwMvE21K; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwMvE21K"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5635f6cb32fso688138e0c.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 13:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767993966; x=1768598766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZslhFlnGBvvnVCHg0KqRwqSH0v3Bzaktc0Rh7Cr6Mw=;
        b=HwMvE21Ka/SNBVaf4r06Lk7HHN7293VoGtBSClAD2Kf3QK6K36xFhDhlEO0uu6rCcd
         vA+ZwlEa4Ibs+lRU1n00whKGfpfd/67JyX9zUnWmGirjRzOEYqFJAdwUhUxbyvawfUar
         RJoNLBH6Kpqh9BR4XcQzpCC8WY4aQ/VQ5Gf1tWhcXwFuCvUE+43nn81FjxMovDaRUqJj
         lrPEF96RkRr6a7VWUi6ypfsp20mzZSvu0p1Yzkh6Ry0E3ZkVUX9itPmVdXRbEolAk8L9
         t+IZu3E6qUH/I8qnMAUmTuwoRvhUETU15+yjU78HODHmi3/7/MOaEmYOZ1GsJDNWCHCQ
         hHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767993966; x=1768598766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KZslhFlnGBvvnVCHg0KqRwqSH0v3Bzaktc0Rh7Cr6Mw=;
        b=ZMG5A3Co+4qP2d5roNmK1rG8V4Fg9+N4hX6Y++416oG1L7AnjDsO/lduGuer7/2GXn
         gziebbEB4bJl1+SfWRa5xq0jQ4V1ZS5RPUTxczStEjhZIJa7XA9+TKYkf7N7tAi8wznO
         mT+RWY0x5DxbC6rKoy9NTQXMESATwFn8DBSPg0769TVic3vAWWgfgs7ttSSdRyGkshCq
         lCNZfN6tLdTA4fkE2QtMZNuw6l1OvEe4UpxN+5iDuu/lA1NSeVlrktr5JuBiqrLST7v6
         INvK1eqA2QXWo9vYatDVR0DayhgbgBoCa7tsRdWQWcyVSyjdK3HlYaB67bkbRNE25RCX
         xvnQ==
X-Gm-Message-State: AOJu0YwGas+2qVfP1j4W6FPPyZWEyF7wYn1TlFKQGNRJ/5WUolQhYym+
	NPtn09yYtIALvhcI8WNJ0PTxCHkHc9nPpLW6JoWwCVxbKZuubJAs5inHLAJ1yQ==
X-Gm-Gg: AY/fxX7Kx+QiVjo9u4O6dKglxumKXVDAVdU8zbqE4ffZwr0PoN0h0vB1xjTdpK5J0sz
	IksaPQPphfAVuqWi2sok48Kk9sTMxEz6kgdormfeTeAwu/t9Q9xhww4NpErYeInKiHCwewzuEyM
	0p68EItHX5xXiCS5L8d2dD5Rh9BDzF2Znw9hE/R6dCZ+6dbvmN0BLHvItLo2t1UqnQNUc7PYxK8
	RDKtlnC/300iGx5sCmkq0G84Zg9XbFJ7JjBocFgNEWQ+rWhKrayEeBk9jr4acO1Z2fI9dh+RAUK
	zGD6ZLESNBARgMXBJFZUo5AYV+Jyw+076pnhGTjSpKRZkeG0sJ1J1fz1pvBNRY1/G4tAv3wDOdz
	uKELw/oumJcxm10HxG0wwUMjBH5CEisFAXDeiqebeH6YC2w9OJF63Fq9PSi64H+RvgJugBI2uA+
	i/gu8HtEGgH1a2liyEIoFh0UUWznt7ddN6DwBXSymtBtCQBiOrNQjWA8vS
X-Google-Smtp-Source: AGHT+IGuvcUSaVc87vuVT6GctNfo4Ja82XeEBsxFUXz5Dm7lBsVzFtPSB6mq3MO2a5AX1huI+1pegA==
X-Received: by 2002:a05:6122:8b18:b0:559:eef7:39f with SMTP id 71dfb90a1353d-56347fc97ffmr3322049e0c.12.1767993966153;
        Fri, 09 Jan 2026 13:26:06 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:b77d:586:c136:4246:ee92:fdfb])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a443e32sm10595955e0c.22.2026.01.09.13.26.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Jan 2026 13:26:05 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v3 2/2] repo: add new flag --keys to git-repo-info
Date: Fri,  9 Jan 2026 17:31:53 -0300
Message-ID: <20260109211554.90828-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the user wants to find what are the available keys, they need to
either check the documentation or to ask for all the key-value pairs
by using --all.

Add a new flag --keys for listing only the available keys without
listing the values.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 11 +++++++++++
 builtin/repo.c              | 32 ++++++++++++++++++++++++++++++++
 t/t1900-repo.sh             | 34 +++++++++++++++++++++++-----------
 3 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index fa0e6600af..4471816cc8 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]
+git repo info --keys [--format=(default|nul) | -z]
 git repo structure [--format=(default|table|keyvalue|nul) | -z]
 
 DESCRIPTION
@@ -47,6 +48,16 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
+`info --keys [--format=(default|nul) | -z]`::
+	List all the available keys, one per line. The output format can be chosen
+	through the flag `--format`. The following formats are supported:
++
+`default`:::
+	output the keys one per line.
+
+`nul`:::
+	similar to `default`, but using a NUL character after each value.
+
 `structure [--format=(default|table|keyvalue|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
diff --git a/builtin/repo.c b/builtin/repo.c
index 306d3fa2df..bc10b2da0b 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -18,6 +18,7 @@
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]",
+	"git repo info --keys [--format=(default|nul) | -z]",
 	"git repo structure [--format=(default|table|keyvalue|nul) | -z]",
 	NULL
 };
@@ -149,6 +150,29 @@ static int print_all_fields(struct repository *repo,
 	return 0;
 }
 
+static int print_keys(enum output_format format)
+{
+	char sep;
+
+	switch (format) {
+	case FORMAT_DEFAULT:
+		sep = '\n';
+		break;
+	case FORMAT_NUL_TERMINATED:
+		sep = '\0';
+		break;
+	default:
+		die(_("--keys can only be used with --format=default or --format=nul"));
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
+		const struct field *field = &repo_info_fields[i];
+		printf("%s%c", field->key, sep);
+	}
+
+	return 0;
+}
+
 static int parse_format_cb(const struct option *opt,
 			   const char *arg, int unset UNUSED)
 {
@@ -175,6 +199,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 {
 	enum output_format format = FORMAT_DEFAULT;
 	int all_keys = 0;
+	int show_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -184,11 +209,18 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
 		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
+		OPT_BOOL(0, "keys", &show_keys, N_("show keys")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
 
+	if (show_keys && (all_keys || argc))
+		die(_("--keys cannot be used with a <key> or --all"));
+
+	if (show_keys)
+		return print_keys(format);
+
 	if (format == FORMAT_DEFAULT)
 		format = FORMAT_KEYVALUE;
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index e6670f0f58..14533b95a0 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -4,15 +4,6 @@ test_description='test git repo-info'
 
 . ./test-lib.sh
 
-# git-repo-info keys. It must contain the same keys listed in the const
-# repo_info_fields, in lexicographical order.
-REPO_INFO_KEYS='
-	layout.bare
-	layout.shallow
-	object.format
-	references.format
-'
-
 # Test whether a key-value pair is correctly returned
 #
 # Usage: test_repo_info <label> <init command> <repo_name> <key> <expected value>
@@ -119,8 +110,8 @@ test_expect_success 'git repo info uses the last requested format' '
 	test_cmp expected actual
 '
 
-test_expect_success 'git repo info --all returns all key-value pairs' '
-	git repo info $REPO_INFO_KEYS >expect &&
+test_expect_success 'git repo info --all and git repo info $(git repo info --keys) output the same data' '
+	git repo info $(git repo info --keys) >expect &&
 	git repo info --all >actual &&
 	test_cmp expect actual
 '
@@ -143,4 +134,25 @@ test_expect_success '--format=default resets the format' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git repo info --keys --format=nul uses nul-terminated output' '
+	git repo info --keys --format=default >default &&
+	lf_to_nul <default >expect &&
+	git repo info --keys --format=nul >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git repo info --keys aborts when using --format other than default or nul' '
+	echo "fatal: --keys can only be used with --format=default or --format=nul" >expect &&
+	test_must_fail git repo info --keys --format=keyvalue 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git repo info --keys aborts when requesting keys' '
+	echo "fatal: --keys cannot be used with a <key> or --all" >expect &&
+	test_must_fail git repo info --keys --all 2>actual_all &&
+	test_must_fail git repo info --keys some.key 2>actual_key &&
+	test_cmp expect actual_all &&
+	test_cmp expect actual_key
+'
+
 test_done
-- 
2.50.1 (Apple Git-155)

