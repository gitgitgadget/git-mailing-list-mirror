Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E72F2580DE
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765309603; cv=none; b=VG7D27V5gSp+tH2jkGFGrEmi4g4YyZpHzddek6tecuYAYzjw/WNQovhicUiGZ2zmf9JwOGCzDOr9Hzlk+HC2Z1P7FF5KrEhlbPsRtloABuYbf6+dNXntTN/f5UwGg0K4R/hceggb8HtdRhCT+3I0kNqh2qI2eLE7HEsFzTgUikU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765309603; c=relaxed/simple;
	bh=EHhMMr2qriIpkj/LwIh58wWsnRMXPZv0hnOGC0JCYys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pz/MTTmwmxV9rmoqHSut/8/FiejkC6ljhJpVc5C0PAvt9sH/mm5F/gfsIsLQTUKq+aBUwzCWE/VvXTXGPi5yfwC20rZtWo2YWf2haCPhfUfkICB0U13JL8OOGEIPHqGnNR1wqoNxOW2MABrdB1Hqylki1e23+6yzc1RxMKQExtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaFPW5iB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaFPW5iB"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ba2450aba80so3476418a12.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 11:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765309601; x=1765914401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIudtBc+2rsyabVma9mvzTwALxor3rWXq9/UTMsuE+g=;
        b=OaFPW5iBYyeEVZyFMOR/S5qAx8SBXKFbSu+rJ4K8DdB4rQJassBtg8uycQUC7FM9ph
         H5hMjtIpzvxW/tJfqpC0cAzhgP/qV8lOvbIu8EfjU2B2drTKSMhy9dryKnLQ3Vz733sb
         TyQLE5ZjaoyQZwCfOWmu3+pEd21le3wpPZXsnhqb99lgEj/By67gZFfgFoOs9GfcU7Ny
         1WdNL7lqz9I5Lp1jHxu2HjGjz+ZDvQ0yMnQppsu84jHfNJ18eTQx08CFPJ4YwFUETxn0
         vKzzdDjL3rTdHnFg/ClOcAYog2uUZ17x5+OVi1p5wypTCs9AbV4bROXUDQpW9KnnVg7g
         9SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765309601; x=1765914401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lIudtBc+2rsyabVma9mvzTwALxor3rWXq9/UTMsuE+g=;
        b=oY5ZHYBe0U38q6SPHLvaRxpOzuns62nLTsb6tljr4jX7q+TTxgH/j16keqHvbvpe7I
         yOxiz0Hjd/77CU69m1I5kgiIQNd20TRFgZiKwm1dOThUnjIhJT5Lop4+a0m23NIG5WTz
         D1T91/dMH4eGxBl6lqvlm0kJ6XSViy5HgJWmuS9CHE6QNWS3/HfrdmNXFiMnF0ylRn8k
         65ovZ3jiEMJcQ9xebk4he3CfiCvFH/rAouWwxtPjsNpLdpdZrJ9PLgKTF+l+m7VLdEdv
         nD6HfnkPTxBlQ+Xkor+ivbMYK4eCFOJmbQcRjsmOozGR3yG8F52QhW2EDCgMYrcVzFao
         pCIA==
X-Gm-Message-State: AOJu0YzcrvCJoG19ZDXYoQIsIZp3n0f9b7Z1We/znNAY3rc9FXQHqcd6
	WUvcNk/o7W+l+gLnqwOZM6pHZyk2fKKuNtp5G/My9hsj/oYyAugE/wLc6ztqYQw4
X-Gm-Gg: ASbGncuzLmcAwRSEg8xzmV92VSmUV/G1DyCVub/AMUGwiFBvB5E0/3xqwsbyANxZg+m
	osfQf0KBdmzn/q4OEPE5Dpv8ZIfSAXajcJ5Lr0e5LptRx6Vc4RawuNCq6PRaZ1oX6+NjDCJCzYg
	el26g7IS6EhfXwkq7AO6oaeMmAOmQsnWWU5c4E1wMw/dcm4JBIHmaI6uIF8RUDcZqlNzpg17VaS
	I7QDL2pTYCUUbfagN3pdCw5h23P64o/Wkw2UQB3G2OHsAa7Y4l4xhbU5TbgS9/U152zYZDvYuIt
	EEGK+VEtWkD2hN3tpgHHhxCZmAiPGZ0c4NYhMZZJRQghhKje4pqfAgI5Zatbr9M6GVOgEWIY6mK
	2m/+OLnMwOgeqp1h5+IDkb0Uv8uqHhYA3+XHQYs8AD3xoF/dM4nvWnWb5chhG7UkxTHVYFpvxYL
	rbITCoGwhjULjF2OeT59ac8Wnnk9/reyhsOm4mW5UFQ0FG5xMEjlBai6icKRvA
X-Google-Smtp-Source: AGHT+IGTMTVuoS7aPyU0DgwJhN/lqNFrr2sS7U1NQL8dBz9S0NUI8cSNpBnaPv51Jxh2Ap217H06ew==
X-Received: by 2002:a05:7301:3034:b0:2a4:7697:a835 with SMTP id 5a478bee46e88-2ac054968b9mr98697eec.14.1765309600946;
        Tue, 09 Dec 2025 11:46:40 -0800 (PST)
Received: from localhost.localdomain ([177.118.148.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm71077271eec.1.2025.12.09.11.46.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Dec 2025 11:46:40 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 0/2] repo: add new flag --keys to git-repo-info
Date: Tue,  9 Dec 2025 16:36:01 -0300
Message-ID: <20251209194616.61620-1-lucasseikioshiro@gmail.com>
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

Hi!

This patch series adds a new flag --keys to git-repo-info. This new flag
only prints the available keys, without printing the corresponding
values.

The main change in this version is the compatibility with the flags -z
and --format, allowing the keys to be printed following the
null-terminated format.

This patch is based on top of master bdc5341ff6 (The sixth batch, 
2025-12-05) with lo/repo-struct-z merged.

Lucas Seiki Oshiro (2):
  repo: add a default output format to enum output_format
  repo: add new flag --keys to git-repo-info

 Documentation/git-repo.adoc | 11 ++++++++++
 builtin/repo.c              | 41 ++++++++++++++++++++++++++++++++++++-
 t/t1900-repo.sh             | 33 +++++++++++++++++++----------
 3 files changed, 73 insertions(+), 12 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  9eb2549806 repo: add a default output format to enum output_format
1:  1b9b7dceb7 ! 2:  c5b7ba8824 repo: add new flag --keys to git-repo-info
    @@ Metadata
      ## Commit message ##
         repo: add new flag --keys to git-repo-info
     
    -    Currently, if the user wants to find what are the available keys,
    -    they need to either check the documentation or to ask to all the
    -    key-value pairs by using --all.
    +    If the user wants to find what are the available keys, they need to
    +    either check the documentation or to ask for all the key-value pairs
    +    by using --all.
     
         Add a new flag --keys for listing only the available keys without
         listing the values.
    @@ Documentation/git-repo.adoc: SYNOPSIS
      --------
      [synopsis]
      git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
    -+git repo info --keys
    ++git repo info --keys [--format=(default|nul) | -z]
      git repo structure [--format=(table|keyvalue|nul) | -z]
      
      DESCRIPTION
    @@ Documentation/git-repo.adoc: supported:
      +
      `-z` is an alias for `--format=nul`.
      
    -+`info --keys`::
    -+List all the available keys, one per line.
    ++`info --keys [--format=(default|nul) | -z]`::
    ++	List all the available keys, one per line. The output format can be chosen
    ++	through the flag `--format`. The following formats are supported:
    +++
    ++`default`:::
    ++	output the keys one per line.
    ++
    ++`nul`:::
    ++	similar to `default`, but using a NUL character after each value.
     +
      `structure [--format=(table|keyvalue|nul) | -z]`::
      	Retrieve statistics about the current repository structure. The
    @@ builtin/repo.c
      
      static const char *const repo_usage[] = {
      	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
    -+	"git repo info --keys",
    ++	"git repo info --keys [--format=(default|nul) | -z]",
      	"git repo structure [--format=(table|keyvalue|nul) | -z]",
      	NULL
      };
    @@ builtin/repo.c: static int print_all_fields(struct repository *repo,
      	return 0;
      }
      
    -+static int print_keys(void)
    ++static int print_keys(enum output_format format)
     +{
    ++	char sep;
    ++
    ++	switch (format) {
    ++	case FORMAT_DEFAULT:
    ++		sep = '\n';
    ++		break;
    ++	case FORMAT_NUL_TERMINATED:
    ++		sep = '\0';
    ++		break;
    ++	default:
    ++		die(_("--keys can only be used with --format=default or --format=nul"));
    ++	}
    ++
     +	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
     +		const struct field *field = &repo_info_fields[i];
    -+		puts(field->key);
    ++		printf("%s%c", field->key, sep);
     +	}
     +
     +	return 0;
    @@ builtin/repo.c: static int print_all_fields(struct repository *repo,
      {
     @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char *prefix,
      {
    - 	enum output_format format = FORMAT_KEYVALUE;
    + 	enum output_format format = FORMAT_DEFAULT;
      	int all_keys = 0;
     +	int show_keys = 0;
      	struct option options[] = {
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
      	};
      
      	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
    + 
    ++	if (show_keys && (all_keys || argc))
    ++		die(_("--keys cannot be used with a <key> or --all"));
     +
     +	if (show_keys)
    -+		return print_keys();
    ++		return print_keys(format);
     +
    - 	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
    - 		die(_("unsupported output format"));
    + 	if (format == FORMAT_DEFAULT)
    + 		format = FORMAT_KEYVALUE;
      
     
      ## t/t1900-repo.sh ##
    @@ t/t1900-repo.sh: test_expect_success 'git repo info uses the last requested form
      	git repo info --all >actual &&
      	test_cmp expect actual
      '
    +@@ t/t1900-repo.sh: test_expect_success 'git repo info --all <key> aborts' '
    + 	test_cmp expect actual
    + '
    + 
    ++test_expect_success 'git repo info --keys --format=nul uses nul-terminated output' '
    ++	git repo info --keys --format=default >default &&
    ++	lf_to_nul <default > expect &&
    ++	git repo info --keys --format=nul >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'git repo info --keys aborts when using --format other than default or nul' '
    ++	echo "fatal: --keys can only be used with --format=default or --format=nul" >expect &&
    ++	test_must_fail git repo info --keys --format=keyvalue 2>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'git repo info --keys aborts when requesting keys' '
    ++	echo "fatal: --keys cannot be used with a <key> or --all" >expect &&
    ++	test_must_fail git repo info --keys --all 2>actual_all &&
    ++	test_must_fail git repo info --keys some.key 2>actual_key &&
    ++	test_cmp expect actual_all &&
    ++	test_cmp expect actual_key
    ++'
    + test_done
-- 
2.50.1 (Apple Git-155)

