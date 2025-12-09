Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C8304985
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765309608; cv=none; b=KW70hiJz8bNbcp+S+3K2wBWSlXyU3CYklGB59THX/P/hc45mAPfmU2nEfjxjryc0p3x8hdcf+XwaRE4Eep4jp9J3daC9ZU1H36z2yl6Tp/OfxAjPsykoeTjco0WEQt9PsC2iCCA07lu6shlsYFTTvnrmrFQOt39lQOgvJPtDZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765309608; c=relaxed/simple;
	bh=dWwhKLQEaK1+hF1JLMWSmp9fhZLy0J+ea7Fb0n90xws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSX43orY6jJ7pJBG5UexWTDsL7d6Sci3vfHsCva5CC6nReq2gvVuh2T5FYpEIV/089K99U/rqNdUkh6tNsH5J36CqGmrPPRSDU35m1glyAZC+LAUuUiB1psfoWGyx/K3yzSo7my7n5yIW9mjtHE00KwsDXKyVRh3gK8fqgc5OEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrTILw73; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrTILw73"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c03eb31db80so1403172a12.2
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 11:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765309606; x=1765914406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtyDyskvkn4xukCU5BCMRRi27KSD+u65e6p95R6Aw7A=;
        b=mrTILw73p8Q4B1ax+ArPeWPfSP2wnfK0yNsZ5vlN/C1LKE+wlYwQLGQEL0schA3jII
         u9wMssT+hwTdP018N0ujtzR9M4uqQmAjP7M9Ywzr4K5fTKbDSFRoaj6LrgpflkXzfYL/
         k1qIIOFpxIaqhFSLQrWcYmazk5Rmjoho1HcAA8156vi1TXwCk9zyhRhnGAGX7NpsUOXx
         ZrBCSvMPLqPpWYtNI99HYFxrbwxZE8ykrZ9EBCUDSPMdWcyB19slR5tHWTdawUeHn7j1
         Hq6bII+U/IGf+m65//yBszKQpMCX6WUFG0H2i4rLYe/enOG8aKiJxBc+keCs7VN0fhfF
         LLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765309606; x=1765914406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NtyDyskvkn4xukCU5BCMRRi27KSD+u65e6p95R6Aw7A=;
        b=mrOdBMLzW55zkHDoQgUNI6duhi8IROGVzoQFYTvfdalIdRmHvOlpwaCNLp85izKTuk
         OXX3PSlv4E0/FTFZxy6q8QjM0yVlHvNDAqzWzlo44OSvUsqY0hKQk9NLUNC4QwOZdMBZ
         3FkUcOj2B96ieP6TETsSrzduzxuZ0ZHE8IpPmIOqRYmoioJMMfAJNyb0HqRkdsP/DQIq
         M7/A951UYYX6DR6sI4wDR65hdwEjLV5YsBKXp5ZNGbcIzvAYFhFZHnAbVvzVfh8c7awo
         me/2GWGFi5a59Oscvh5Z/CKkFS4Z/TNvszwnYgu2dNuHnZGMHQV2maMJqk8vL9e5kzEg
         KT/w==
X-Gm-Message-State: AOJu0YxwQ85HqnLpctU7w4Mh2+lOfn3+JDXSnL9readiy6Vf+JyxQduU
	AVjFrIzajmUQTYGyulEiaLNxzy7W3eW7yvbXrXLhXBTruLrJbotxvAIzckC+8Yep
X-Gm-Gg: AY/fxX532CNdQTIg7GNWLD5Sk3yn/OgvRyJUY2p26xAPupf71SegculKveOpblebsxr
	IgfbHAGaoMYuRsNw5Avp5MAX1ckuR2L8Uu6/Pc68Mq/hUSjJfjTiq/D7Pwckdzz83BM/ltfFsQ4
	URGRQqEpLwqX24YwukukhZ3pyocMjge7OTKycPwP5m/4xRZcZKcZzjDYZKlVWXXy1/mUZFaYe2G
	6QjpP5TWCPX2tobeJeC1x+CHRNZmjcam/X6jFghO41Ow+1Zk6Gr3Nh6Ow7LJa6/ix2mUheu0VQ2
	5a9w2sZi9CoU7kh38vAsaut+um2aLhkRGAwAwZ16LXdYRGOlK7NtW9F6WlpSp26CrHOwfCSFTYZ
	Kgl+bEDJN7ehxwq65WgHgd25/jvm2rbsGVS87EV6Hu2fkUVUXnAWHNeLsoOiG9P8ngWvwp10jgs
	+darKazoFM8AK9+vhK4dDa39AdbklPU055/RsKonjHYGEWYrDpyg==
X-Google-Smtp-Source: AGHT+IGAyswF7phJmcngccZeXcCcWY5i05gX0/jGd8OjSB7LO9VW7KTIF7FaHEV4gKm3v+wPGQmCRg==
X-Received: by 2002:a05:7301:6408:b0:2a4:630b:c789 with SMTP id 5a478bee46e88-2ac05653f5fmr85026eec.37.1765309605895;
        Tue, 09 Dec 2025 11:46:45 -0800 (PST)
Received: from localhost.localdomain ([177.118.148.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm71077271eec.1.2025.12.09.11.46.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Dec 2025 11:46:45 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 2/2] repo: add new flag --keys to git-repo-info
Date: Tue,  9 Dec 2025 16:36:03 -0300
Message-ID: <20251209194616.61620-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209194616.61620-1-lucasseikioshiro@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20251209194616.61620-1-lucasseikioshiro@gmail.com>
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
 t/t1900-repo.sh             | 33 ++++++++++++++++++++++-----------
 3 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index c4a78277df..fd0683631c 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
+git repo info --keys [--format=(default|nul) | -z]
 git repo structure [--format=(table|keyvalue|nul) | -z]
 
 DESCRIPTION
@@ -44,6 +45,16 @@ supported:
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
 `structure [--format=(table|keyvalue|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
diff --git a/builtin/repo.c b/builtin/repo.c
index 1cd12e7eea..48341f9245 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -16,6 +16,7 @@
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
+	"git repo info --keys [--format=(default|nul) | -z]",
 	"git repo structure [--format=(table|keyvalue|nul) | -z]",
 	NULL
 };
@@ -147,6 +148,29 @@ static int print_all_fields(struct repository *repo,
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
@@ -173,6 +197,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 {
 	enum output_format format = FORMAT_DEFAULT;
 	int all_keys = 0;
+	int show_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -182,11 +207,18 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
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
index 51d55f11a5..e8802413a6 100755
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
@@ -131,4 +122,24 @@ test_expect_success 'git repo info --all <key> aborts' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git repo info --keys --format=nul uses nul-terminated output' '
+	git repo info --keys --format=default >default &&
+	lf_to_nul <default > expect &&
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
 test_done
-- 
2.50.1 (Apple Git-155)

