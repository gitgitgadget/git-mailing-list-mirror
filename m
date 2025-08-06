Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA32BCF4A
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510159; cv=none; b=s5RH79htxK8bnt4eSLkLwcrx1107GmqtyDAsswKPxuDKTGcgNEVPwDsRKyjFWRvEsXNMtW5L8PjkMWQW9exumZAjB7W6NBsbZ8BmEvPvYQAxNOUE4IPewEry8vXDPtKqUzZodaTgFf8l/aFSLBi9Vel5Srnt+5jXF/hHf+0ql3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510159; c=relaxed/simple;
	bh=PtrkCaag26Yn5/KtJI7bffJst//j4mEdBrDuYA1dDrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LmYpNL+3sYcOwO2GQ8p5C1Loxpd9Fc6Z2jnt5CO6AfnZNNEpCEoXU2a7iTntdW8u7Iv8fOg2FzixkatTx2mBqXRnbGT2o72hMbSfaa6vu+naNqRPJo7LHw70YgfSgSX1pDNNY9Uq8OYnAPF75EjQuA6hNfnYQFItFOJ7RPM8e6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye93vqhp; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye93vqhp"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bc55f6612so306507b3a.0
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754510157; x=1755114957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuNvENTSeGJMMHwALwk7aaBgpCe8vliTYrJowEImjmg=;
        b=Ye93vqhpOj09kQxpK72eYMFKKvDomcoQzkl2Nnbq9A3HCI6axFJjV9MxPcUh/yjdFB
         FVIpEtL3CXQjPfig9BZBzo0oDkniT3TDcnrKmBzpsapgeHjQ94HNKHz7+AN3xlCy4AMw
         Hvx/4AT5wBFxoy5K46aW6k0cv5jtOpqCHveMI60ZMG9YUaAGRmG6aQgp1FM3cHQBgDIS
         Yd5RRQ+jzqntKvqL/eMYoK26tEz0/XWBR8s3+5eNmNunkwvTnjpYz8xDxwOwMk55w/Xu
         b5YkEfAwTWxCeOFg/2lge1DYB2EOtqzYJGSu2rsooUfCYRk+Oewfd0BH1nkBJbdURgrX
         z0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510157; x=1755114957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuNvENTSeGJMMHwALwk7aaBgpCe8vliTYrJowEImjmg=;
        b=s43YQEk48N/BATYMHadIALCkWv2qyV5FvxgVwyJ+08RkY/ZQOxCxuqVhzaGLxtjT2s
         oZR0bCkKg7ah5X3z9xWYW9XAk+I+2lUEInQgpCuP2F6z9qNEE/cGN2K7cHqYkMpU2cQH
         6zQOQMonoRJWSce69gl6jT3o1KPAiNxtr3j9hlYQv4RksK4oDS/GE91esNCLfAa3xPDc
         kDSryMdZiXtmtLrmkhokLdzpJeNc/xfKRm7rJnsSnLE4jFXVmCexl/xA+cUbPdUg0CUv
         I7at2uQ8NaFLgxameHRyN+TEqxESBTYLFr8Neeh4+SUvfPSYaSx28TIg7d6lw8kF4p7M
         2PnA==
X-Gm-Message-State: AOJu0YwIEGM0MbTXOoDaU8JjlyNF4d5jA486gsGGC2Yp/ZD9MJ6meV81
	JPxcIukTvJ8NDNF99SD0erS4thZvEVXkCUVLW+QbdqwLf9hcxvPpbaw2vlr5lt30
X-Gm-Gg: ASbGncuaOWuhSNmCRs2rEe8Q85ClcKW8H7tXDdpa9aqKHGSlLXW8CQ5lxQ2k3N8MT3Q
	ZeTLMy21JG75kLbNyESJPHw8qIqm3cjOBMxw7+a17p7NhLGNoVhBlcOMhnIlUgI0Rj2dhcMEmTJ
	pN8hBJqOrdDn2cHPe5KRQJk9udM+i+qCOSGdHtIXmsCGSLjjIN1K45TfNW969g1txEYHq9xRWDB
	rwJNlW1HKdh+fCle5W5IuCvf3Y2JvclCSvvTctdZypbrFZblDG+DWvDi0HXBsy/EG2QMfT6NxZd
	3yli3kBp+cyf7nqLuauFI+CEyQh3Zv4b0atrRPmoCBC4TSSCKeq3OSGM1Em1+3ijFpmvQOXzRpU
	UXHJxvQY5y0bR/ov1tIOHIqipYvAsrsov8pyVXLgs7tTyhrKoUlcg5F7cz4mjlmM=
X-Google-Smtp-Source: AGHT+IH/wazZtlgkpPX5ef1BxXY/H8XuWqxJmeHRVNVP4XSuQrhyyOKjGutPFlDjXAZZ0kU8pASulg==
X-Received: by 2002:a05:6a00:62c9:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-76c3737ab47mr660165b3a.9.1754510156796;
        Wed, 06 Aug 2025 12:55:56 -0700 (PDT)
Received: from localhost.localdomain (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd026dsm16212400b3a.95.2025.08.06.12.55.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Aug 2025 12:55:56 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	jn.avila@free.fr,
	sunshine@sunshineco.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v8 0/5] repo: add new command for retrieving repository info
Date: Wed,  6 Aug 2025 16:55:32 -0300
Message-Id: <20250806195537.93302-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi again!

This 8th version of `git-repo` basically address minor issues from the 7th
version:

- A test wasn't passing in the CI because it assumed that the ref
  format was files by default. I fixed that.

- t0450 wasn't passing because the documentation didn't match the
  usage string. I fixed that.

- A test generated the output and the expected value but wasn't
  comparing them. I also fixed that.

- strbuf management: now we have two strbufs for printing values:
  one for unquoted values and other for quoted values

- Test codestyle: now it's ending test case liness with \ instead of
  open strings

- Documentation: this version documents that we escape the value in
  the `keyvalue` format.

Here's the range-diff versus v7:

1:  51b20490e2 = 1:  3c2ede66be repo: declare the repo command
2:  8be77db9e5 ! 2:  396bee171a repo: add the field references.format
    @@ Documentation/git-repo.adoc: COMMANDS
      	section below).
     ++
     +The returned data is lexicographically sorted by the keys.
    +++
    ++The output format consists of key-value pairs one per line using the `=`
    ++character as the delimiter between the key and the value. Values containing
    ++"unusual" characters are quoted as explained for the configuration variable
    ++`core.quotePath` (see linkgit:git-config[1]). This is the default.
     +
     +INFO KEYS
     +---------
    @@ builtin/repo.c
     +{
     +	int ret = 0;
     +	const char *last = "";
    -+	struct strbuf sb = STRBUF_INIT;
    ++	struct strbuf valbuf = STRBUF_INIT;
    ++	struct strbuf quotbuf = STRBUF_INIT;
     +
     +	QSORT(argv, argc, qsort_strcmp);
     +
     +	for (int i = 0; i < argc; i++) {
     +		get_value_fn *get_value;
     +		const char *key = argv[i];
    -+		char *value;
    ++
    ++		strbuf_reset(&valbuf);
    ++		strbuf_reset(&quotbuf);
     +
     +		if (!strcmp(key, last))
     +			continue;
     +
    ++		last = key;
     +		get_value = get_value_fn_for_key(key);
     +
     +		if (!get_value) {
    @@ builtin/repo.c
     +			continue;
     +		}
     +
    -+		strbuf_reset(&sb);
    -+		get_value(repo, &sb);
    -+
    -+		value = strbuf_detach(&sb, NULL);
    -+		quote_c_style(value, &sb, NULL, 0);
    -+		free(value);
    -+
    -+		printf("%s=%s\n", key, sb.buf);
    -+		last = key;
    ++		get_value(repo, &valbuf);
    ++		quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
    ++		printf("%s=%s\n", key, quotbuf.buf);
     +	}
     +
    -+	strbuf_release(&sb);
    ++	strbuf_release(&valbuf);
    ++	strbuf_release(&quotbuf);
     +	return ret;
     +}
     +
    @@ t/t1900-repo.sh (new)
     +#
     +# Arguments:
     +#   label: the label of the test
    -+#   init command: a command which creates a repository named with its first argument,
    -+#      accordingly to what is being tested
    ++#   init_command: a command which creates a repository
    ++#   repo_name: the name of the repository that will be created in init_command
     +#   key: the key of the field that is being tested
    -+#   expected value: the value that the field should contain
    ++#   expected_value: the value that the field should contain
     +test_repo_info () {
     +	label=$1
     +	init_command=$2
    @@ t/t1900-repo.sh (new)
     +'
     +
     +test_expect_success 'git-repo-info outputs data even if there is an invalid field' '
    -+	echo "references.format=files" >expected &&
    ++	echo "references.format=$(test_detect_ref_format)" >expected &&
     +	test_must_fail git repo info foo references.format bar >actual &&
     +	test_cmp expected actual
     +'
3:  c93aeafb05 ! 3:  4dbc83c64c repo: add the field layout.bare
    @@ builtin/repo.c: struct field {

     +static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
     +{
    -+	strbuf_addstr(buf,
    -+		      is_bare_repository() ? "true" : "false");
    ++	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
     +	return 0;
     +}
     +
    @@ t/t1900-repo.sh: test_repo_info 'ref format files is retrieved correctly' '
      test_repo_info 'ref format reftable is retrieved correctly' '
      	git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'

    -+test_repo_info 'bare repository = false is retrieved correctly' '
    -+	git init' 'bare' 'layout.bare' 'false'
    ++test_repo_info 'bare repository = false is retrieved correctly' \
    ++	'git init' 'nonbare' 'layout.bare' 'false'
     +
    -+test_repo_info 'bare repository = true is retrieved correctly' '
    -+	git init --bare' 'nonbare' 'layout.bare' 'true'
    ++test_repo_info 'bare repository = true is retrieved correctly' \
    ++	'git init --bare' 'bare' 'layout.bare' 'true'
     +
      test_expect_success 'git-repo-info fails if an invalid key is requested' '
      	echo "error: key '\'foo\'' not found" >expected_err &&
    @@ t/t1900-repo.sh: test_expect_success 'only one value is returned if the same key
      '

     +test_expect_success 'output is returned correctly when two keys are requested' '
    -+	cat >expect <<-\EOF &&
    ++	cat >expected <<-\EOF &&
     +	layout.bare=false
     +	references.format=files
     +	EOF
     +	git init --ref-format=files two-keys &&
    -+	git -C two-keys repo info layout.bare references.format
    ++	git -C two-keys repo info layout.bare references.format > actual &&
    ++	test_cmp expected actual
     +'
    ++
      test_done
4:  4463b85193 ! 4:  5c65a24df4 repo: add the field layout.shallow
    @@ builtin/repo.c: static int get_references_format(struct repository *repo, struct


      ## t/t1900-repo.sh ##
    -@@ t/t1900-repo.sh: test_repo_info 'bare repository = false is retrieved correctly' '
    - test_repo_info 'bare repository = true is retrieved correctly' '
    - 	git init --bare' 'nonbare' 'layout.bare' 'true'
    +@@ t/t1900-repo.sh: test_repo_info 'bare repository = false is retrieved correctly' \
    + test_repo_info 'bare repository = true is retrieved correctly' \
    + 	'git init --bare' 'bare' 'layout.bare' 'true'

    -+test_repo_info 'shallow repository = false is retrieved correctly' '
    -+	git init' 'nonshallow' 'layout.shallow' 'false'
    ++test_repo_info 'shallow repository = false is retrieved correctly' \
    ++	'git init' 'nonshallow' 'layout.shallow' 'false'
     +
    -+test_repo_info 'shallow repository = true is retrieved correctly' '
    -+	git init remote &&
    ++test_repo_info 'shallow repository = true is retrieved correctly' \
    ++	'git init remote &&
     +	echo x >remote/x &&
     +	git -C remote add x &&
     +	git -C remote commit -m x &&
    @@ t/t1900-repo.sh: test_repo_info 'bare repository = false is retrieved correctly'
      test_expect_success 'git-repo-info fails if an invalid key is requested' '
      	echo "error: key '\'foo\'' not found" >expected_err &&
      	test_must_fail git repo info foo 2>actual_err &&
    -@@ t/t1900-repo.sh: test_expect_success 'output is returned correctly when two keys are requested' '
    - 	git init --ref-format=files two-keys &&
    - 	git -C two-keys repo info layout.bare references.format
    - '
    -+
    - test_done
5:  90427acf54 ! 5:  dc8ea099f5 repo: add the --format flag
    @@ Documentation/git-repo.adoc: git-repo - Retrieve information about the repositor
      --------
      [synopsis]
     -git repo info [<key>...]
    -+git repo info [--format=<keyvalue|nul>] [<key>...]
    ++git repo info [--format=(keyvalue|nul)] [<key>...]

      DESCRIPTION
      -----------
    @@ Documentation/git-repo.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHAN
      COMMANDS
      --------
     -`info [<key>...]`::
    -+`info [--format=<keyvalue|nul>] [<key>...]`::
    ++`info [--format=(keyvalue|nul)] [<key>...]`::
      	Retrieve metadata-related information about the current repository. Only
      	the requested data will be returned based on their keys (see "INFO KEYS"
      	section below).
      +
      The returned data is lexicographically sorted by the keys.
    -++
    + +
    +-The output format consists of key-value pairs one per line using the `=`
    +-character as the delimiter between the key and the value. Values containing
    +-"unusual" characters are quoted as explained for the configuration variable
     +The output format can be chosen through the flag `--format`. Two formats are
     +supported:
     ++
     +* `keyvalue`: output key-value pairs one per line using the `=` character as
    -+the delimiter between the key and the value. This is the default.
    -+
    ++the delimiter between the key and the value. Values containing "unusual"
    ++characters are quoted as explained for the configuration variable
    + `core.quotePath` (see linkgit:git-config[1]). This is the default.
    +
     +* `nul`: similar to `keyvalue`, but using a newline character as the delimiter
     +between the key and the value and using a null character after each value.
     +This format is better suited for being parsed by another applications than
    -+`keyvalue`.
    -
    ++`keyvalue`. Unlike in the `keyvalue` format, the values are never quoted.
    ++
      INFO KEYS
      ---------
    +
     @@ Documentation/git-repo.adoc: The reference storage format. The valid values are:
      +
      include::ref-storage-format.adoc[]
    @@ builtin/repo.c

      static const char *const repo_usage[] = {
     -	"git repo info [<key>...]",
    -+	"git repo info [--format=<keyvalue|nul>] [<key>...]",
    ++	"git repo info [--format=(keyvalue|nul)] [<key>...]",
      	NULL
      };

    @@ builtin/repo.c: static int qsort_strcmp(const void *va, const void *vb)
      {
      	int ret = 0;
      	const char *last = "";
    - 	struct strbuf sb = STRBUF_INIT;
    +@@ builtin/repo.c: static int print_fields(int argc, const char **argv, struct repository *repo)
    + 		}

    -+	char kv_sep;
    -+	char field_sep;
    -+
    -+	switch (format) {
    -+	case FORMAT_KEYVALUE:
    -+		kv_sep = '=';
    -+		field_sep = '\n';
    -+		break;
    -+	case FORMAT_NUL_TERMINATED:
    -+		kv_sep = '\n';
    -+		field_sep = '\0';
    -+		break;
    -+	}
    + 		get_value(repo, &valbuf);
    +-		quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
    +-		printf("%s=%s\n", key, quotbuf.buf);
     +
    - 	QSORT(argv, argc, qsort_strcmp);
    -
    - 	for (int i = 0; i < argc; i++) {
    - 		get_value_fn *get_value;
    - 		const char *key = argv[i];
    --		char *value;
    -
    - 		if (!strcmp(key, last))
    - 			continue;
    -@@ builtin/repo.c: static int print_fields(int argc, const char **argv, struct repository *repo)
    - 		strbuf_reset(&sb);
    - 		get_value(repo, &sb);
    -
    --		value = strbuf_detach(&sb, NULL);
    --		quote_c_style(value, &sb, NULL, 0);
    --		free(value);
    -+		if (format == FORMAT_KEYVALUE) {
    -+			char *value;
    -+			value = strbuf_detach(&sb, NULL);
    -+			quote_c_style(value, &sb, NULL, 0);
    -+			free(value);
    ++		switch (format) {
    ++		case FORMAT_KEYVALUE:
    ++			quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
    ++			printf("%s=%s\n", key, quotbuf.buf);
    ++			break;
    ++		case FORMAT_NUL_TERMINATED:
    ++			printf("%s\n%s%c", key, valbuf.buf, '\0');
    ++			break;
    ++		default:
    ++			BUG("%d: not a valid output format", format);
     +		}
    -
    --		printf("%s=%s\n", key, sb.buf);
    -+		printf("%s%c%s%c", key, kv_sep, sb.buf, field_sep);
    - 		last = key;
      	}

    + 	strbuf_release(&valbuf);
     @@ builtin/repo.c: static int print_fields(int argc, const char **argv, struct repository *repo)
      	return ret;
      }
    @@ t/t1900-repo.sh: test_repo_info () {

     -	test_expect_success "$label" '
     -		eval "$init_command $repo_name" &&
    -+	test_expect_success "keyvalue: $label" '
    -+		eval "$init_command keyvalue-$repo_name" &&
    - 		echo "$key=$expected_value" >expected &&
    +-		echo "$key=$expected_value" >expected &&
     -		git -C $repo_name repo info "$key" >actual &&
    -+		git -C keyvalue-$repo_name repo info "$key" >actual &&
    -+		test_cmp expected actual
    -+	'
    ++	repo_name_keyvalue="$repo_name"-keyvalue
    ++	repo_name_nul="$repo_name"-nul
     +
    -+	test_expect_success "nul: $label" '
    -+		eval "$init_command nul-$repo_name" &&
    -+		printf "%s\n%s\0" "$key" "$expected_value" >expected &&
    -+		git -C nul-$repo_name repo info --format=nul "$key" >actual &&
    ++	test_expect_success "keyvalue: $label" '
    ++		eval "$init_command $repo_name_keyvalue" &&
    ++		echo "$key=$expected_value" > expected &&
    ++		git -C "$repo_name_keyvalue" repo info "$key" >actual &&
      		test_cmp expected actual
      	'
    ++
    ++	test_expect_success "nul: $label" '
    ++		eval "$init_command $repo_name_nul" &&
    ++		printf "%s\n%s\0" "$key" "$expected_value" >expected &&
    ++		git -C "$repo_name_nul" repo info --format=nul "$key" >actual &&
    ++		test_cmp_bin expected actual
    ++	'
      }
    -@@ t/t1900-repo.sh: test_repo_info 'shallow repository = false is retrieved correctly' '
    - 	git init' 'nonshallow' 'layout.shallow' 'false'

    - test_repo_info 'shallow repository = true is retrieved correctly' '
    -+	test_when_finished "rm -rf remote" &&
    - 	git init remote &&
    + test_repo_info 'ref format files is retrieved correctly' '
    +@@ t/t1900-repo.sh: test_repo_info 'bare repository = true is retrieved correctly' \
    + test_repo_info 'shallow repository = false is retrieved correctly' \
    + 	'git init' 'nonshallow' 'layout.shallow' 'false'
    +
    +-test_repo_info 'shallow repository = true is retrieved correctly' \
    +-	'git init remote &&
    ++test_expect_success 'setup remote' '
    ++	git init remote &&
      	echo x >remote/x &&
      	git -C remote add x &&
    +-	git -C remote commit -m x &&
    +-	git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
    ++	git -C remote commit -m x
    ++'
    ++
    ++test_repo_info 'shallow repository = true is retrieved correctly' \
    ++	'git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
    +
    + test_expect_success 'git-repo-info fails if an invalid key is requested' '
    + 	echo "error: key '\'foo\'' not found" >expected_err &&
     @@ t/t1900-repo.sh: test_expect_success 'output is returned correctly when two keys are requested' '
    - 	git -C two-keys repo info layout.bare references.format
    + 	test_cmp expected actual
      '

     +test_expect_success 'git-repo-info aborts when requesting an invalid format' '
    -+	test_when_finished "rm -f err expected" &&
     +	echo "fatal: invalid format '\'foo\''" >expected &&
     +	test_must_fail git repo info --format=foo 2>err &&
     +	test_cmp expected err

Lucas Seiki Oshiro (5):
  repo: declare the repo command
  repo: add the field references.format
  repo: add the field layout.bare
  repo: add the field layout.shallow
  repo: add the --format flag

 .gitignore                  |   1 +
 Documentation/git-repo.adoc |  81 ++++++++++++++++++
 Documentation/meson.build   |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/repo.c              | 165 ++++++++++++++++++++++++++++++++++++
 command-list.txt            |   1 +
 git.c                       |   1 +
 meson.build                 |   1 +
 t/meson.build               |   1 +
 t/t1900-repo.sh             | 102 ++++++++++++++++++++++
 11 files changed, 356 insertions(+)
 create mode 100644 Documentation/git-repo.adoc
 create mode 100644 builtin/repo.c
 create mode 100755 t/t1900-repo.sh

-- 
2.39.5 (Apple Git-154)

