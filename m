Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9D14315F
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271795; cv=none; b=JxEWKjxVMW7l2nC+B6n49pNttTHBFO8ohQDuue0BfR+GwSXn0aD1B/d6B0GBpzuhwIflBYcnNaQz8yN9EncJ0pKw5/wA+1bWSDqbpJc7wCJXJ3SDJm95fFu8G2aicf8IJxzlcr7iMqjDVR826SbQzOlMA3jBAlHhKKkojYXpKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271795; c=relaxed/simple;
	bh=QIl6585eVT1IfApKXOmiSw8sn6OchGFhWVTYVGzEcy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HIhkngheGH5fPgVD/e/+G5FyCaOFr0pwD3XcKLjdv+7ZR3Me2bzPqeJYpz8O1uTff5+04Sq9i49u84xQHC4YoOrz43wsxQOLxvv0UTFCPpr/GoGIfxVhrS9wqbtSv+9NZWynIntcOO3JT9KzejjJxe+NvVunQXktx8qtY8y9ozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV3vdx9v; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV3vdx9v"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea94c7dso2616186b3a.2
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755271792; x=1755876592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EijxG5zyFPJODfUKQstc2Nw/L+Tn9rvrEGodTIe2sgo=;
        b=KV3vdx9vB80Umrt3Xtm3zy+4IzavIIxMHy7Q9DfTIUTyKkSpA/gkcx42Y9Bbtt01s3
         A4ebNJxNIa2CVzYqjLH+k4YgoTgJK6y01Z7sY1quWyiWPBWwcl0bQsipDGNd1m38+u90
         7G1+dlkFM2ShG6OTTqRxCCuzEGjc+N3rSm7EsQssCl8pySj6x6++8zPuMrHyPqzqmlcq
         Nk2U1EM83Y7T+OYXSmOorrd7ysHCUQAiDsnZKd0HJFbTlCeg1PgJpdYr4zxorHX/tp7a
         +gOlNV5bykYx28Y4FKwyAbkHdLWh8aD0eoELI9EXPi8nju2itFRAdCfzoFMlrgwRjvwF
         ZmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271792; x=1755876592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EijxG5zyFPJODfUKQstc2Nw/L+Tn9rvrEGodTIe2sgo=;
        b=kjSriL2/xa3Ps+otSwgLy6rI+VZqk63103hy388Kb57HjRFMDhZQZq00e7LCVipNhb
         4UVmDA4JJx5qJRuj1DYNq+k3q1Ji2QrXBxB0n04e7BhNlYY8Si39Ze5jkh5745rCLUJn
         3JpO+nIK+mUDSYD5hqB9nGrRnShunwDsTOW4a4SctK85XpX3Ms5VNe9eu/fLSab8VV9m
         jHF1yElkorVKow0nbe8mn2WoIKOSqmnFOADYHPZ5uTsb8SOJh8QqMeo4djxtUk0nJ2YJ
         jXurMMAf9lPBR6z89Iq1DUBGtrVDwXcyB9DDPk9KTImjaR4R3tWKhpSOAh4U08eT/EyV
         nr+Q==
X-Gm-Message-State: AOJu0Yxhb0xnhrLtcEUmz61V9/ZWC/7WWtvv+s+BGOjB6ohXwBOS1v+2
	HqnSZ/fbscVqsvMriV/cXL0q1/dc2zWaFQCtlriV/RazjKDnVAxE7TD8X/9flg==
X-Gm-Gg: ASbGncudtVOvlgnB/HRux1GOLLepe3W3E+/CzUNH6suMoISvISp/LuSPx9g8o0y+NRj
	Tml5FG8cAyd9/p+wcAhe5bhi8H7/vYLI8aMVRIoxk4YWtOkkln7y2pXsqW3EKxsOtXSySwud9Am
	21VHcCqY9bosl5iIEJhQFqI4Rvbc2fukOnUVHSRaQ98SZtiJVbl+WWWxZ2LRRAZQMPUvA8V0uOS
	7fNu4GH8oV4RlhSO+eMmVTNQbBwlqFpUoau93f9gM0UZaLQ9mbH2pLjQ/6Q1EA6XphjR5WByFcl
	bwrmMdVrmUprPSOfgkkeKxHPi3ovBv5nawqyLNMscWSH/45u+5AgNRcrNGbQG3h5vY4eqrtJMfm
	PbQhTnqoxGe5VXeJ7KlwWN8FXBVMpuEYQhBpIXi5q39IBAPwLaSJigkjvT+PvSsqHVf4vkj0j
X-Google-Smtp-Source: AGHT+IGrPXoz+aTrAvQ74Di3jcn142iY6Ny3AZcsijBti4RgjgTfSjZ4dPUKf/IqV7qSo0wjl5gIyA==
X-Received: by 2002:a05:6a00:22c4:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-76e44790570mr3504870b3a.12.1755271792279;
        Fri, 15 Aug 2025 08:29:52 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8e83:7089:f932:3359:f50e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e452666besm1393260b3a.1.2025.08.15.08.29.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 Aug 2025 08:29:51 -0700 (PDT)
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
Subject: [GSoC PATCH v10 0/5] repo: declare the repo command
Date: Fri, 15 Aug 2025 10:55:16 -0300
Message-Id: <20250815135521.44044-1-lucasseikioshiro@gmail.com>
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

Hi!

The only major change in this v10 is that git-repo-info now returns the
values following the same order as they were requested instead of
sorting the keys. In past versions, the sorting existed for dropping
duplicated keys, but after the discussion with Eric, Phillip and Junio,
we agreed that returning the values following the keys order was more
important than removing the duplications, which weren't exactly a bad
thing. Consequently, the duplication checks were also removed.

Other minor issues pointed by Eric were also addressed.

Thanks!

Here's the range-diff versus v9:

1:  3c2ede66be = 1:  6767028da3 repo: declare the repo command
2:  b18e74763d ! 2:  c44e2d1619 repo: add the field references.format
    @@ Documentation/git-repo.adoc: COMMANDS
      	the requested data will be returned based on their keys (see "INFO KEYS"
      	section below).
     ++
    -+The returned data is lexicographically sorted by the keys.
    ++The values are returned in the same order in which their respective keys were
    ++requested.
     ++
     +The output format consists of key-value pairs one per line using the `=`
     +character as the delimiter between the key and the value. Values containing
     +"unusual" characters are quoted as explained for the configuration variable
    -+`core.quotePath` (see linkgit:git-config[1]). This is the default.
    ++`core.quotePath` (see linkgit:git-config[1]).
     +
     +INFO KEYS
     +---------
    @@ builtin/repo.c
      	return 0;
      }
      
    -+/* repo_info_fields keys should be in lexicographical order */
    ++/* repo_info_fields keys must be in lexicographical order */
     +static const struct field repo_info_fields[] = {
     +	{ "references.format", get_references_format },
     +};
    @@ builtin/repo.c
     +	return found ? found->get_value : NULL;
     +}
     +
    -+static int qsort_strcmp(const void *va, const void *vb)
    -+{
    -+	const char *a = *(const char **)va;
    -+	const char *b = *(const char **)vb;
    -+
    -+	return strcmp(a, b);
    -+}
    -+
     +static int print_fields(int argc, const char **argv, struct repository *repo)
     +{
     +	int ret = 0;
    -+	const char *last = "";
     +	struct strbuf valbuf = STRBUF_INIT;
     +	struct strbuf quotbuf = STRBUF_INIT;
     +
    -+	QSORT(argv, argc, qsort_strcmp);
    -+
     +	for (int i = 0; i < argc; i++) {
     +		get_value_fn *get_value;
     +		const char *key = argv[i];
     +
    -+		strbuf_reset(&valbuf);
    -+		strbuf_reset(&quotbuf);
    -+
    -+		if (!strcmp(key, last))
    -+			continue;
    -+
    -+		last = key;
     +		get_value = get_value_fn_for_key(key);
     +
     +		if (!get_value) {
    @@ builtin/repo.c
     +			continue;
     +		}
     +
    ++		strbuf_reset(&valbuf);
    ++		strbuf_reset(&quotbuf);
    ++
     +		get_value(repo, &valbuf);
     +		quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
     +		printf("%s=%s\n", key, quotbuf.buf);
    @@ t/t1900-repo.sh (new)
     +
     +# Test whether a key-value pair is correctly returned
     +#
    -+# Usage: test_repo_info <label> <init command> <key> <expected value>
    ++# Usage: test_repo_info <label> <init command> <repo_name> <key> <expected value>
     +#
     +# Arguments:
     +#   label: the label of the test
    @@ t/t1900-repo.sh (new)
     +	'
     +}
     +
    -+test_repo_info 'ref format files is retrieved correctly' '
    -+	git init --ref-format=files' 'format-files' 'references.format' 'files'
    ++test_repo_info 'ref format files is retrieved correctly' \
    ++	'git init --ref-format=files' 'format-files' 'references.format' 'files'
     +
    -+test_repo_info 'ref format reftable is retrieved correctly' '
    -+	git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
    ++test_repo_info 'ref format reftable is retrieved correctly' \
    ++	'git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
     +
     +test_expect_success 'git-repo-info fails if an invalid key is requested' '
     +	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
    @@ t/t1900-repo.sh (new)
     +	test_cmp expected actual
     +'
     +
    -+test_expect_success 'only one value is returned if the same key is requested twice' '
    -+	val=$(git rev-parse --show-ref-format) &&
    -+	echo "references.format=$val" >expect &&
    -+	git repo info references.format references.format >actual &&
    -+	test_cmp expect actual
    -+'
    -+
     +test_done
3:  35916b210e ! 3:  e3009a85e1 repo: add the field layout.bare
    @@ builtin/repo.c: struct field {
      	strbuf_addstr(buf,
     @@ builtin/repo.c: static int get_references_format(struct repository *repo, struct strbuf *buf)
      
    - /* repo_info_fields keys should be in lexicographical order */
    + /* repo_info_fields keys must be in lexicographical order */
      static const struct field repo_info_fields[] = {
     +	{ "layout.bare", get_layout_bare },
      	{ "references.format", get_references_format },
    @@ builtin/repo.c: static int get_references_format(struct repository *repo, struct
      
     
      ## t/t1900-repo.sh ##
    -@@ t/t1900-repo.sh: test_repo_info 'ref format files is retrieved correctly' '
    - test_repo_info 'ref format reftable is retrieved correctly' '
    - 	git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
    +@@ t/t1900-repo.sh: test_repo_info 'ref format files is retrieved correctly' \
    + test_repo_info 'ref format reftable is retrieved correctly' \
    + 	'git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
      
     +test_repo_info 'bare repository = false is retrieved correctly' \
     +	'git init' 'nonbare' 'layout.bare' 'false'
    @@ t/t1900-repo.sh: test_repo_info 'ref format files is retrieved correctly' '
     +test_repo_info 'bare repository = true is retrieved correctly' \
     +	'git init --bare' 'bare' 'layout.bare' 'true'
     +
    - test_expect_success 'git-repo-info fails if an invalid key is requested' '
    - 	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
    - 	test_must_fail git repo info foo 2>actual_err &&
    -@@ t/t1900-repo.sh: test_expect_success 'only one value is returned if the same key is requested twi
    - 	test_cmp expect actual
    - '
    - 
    -+test_expect_success 'output is returned correctly when two keys are requested' '
    -+	cat >expected <<-\EOF &&
    ++test_expect_success 'values returned in order requested' '
    ++	cat >expect <<-\EOF &&
     +	layout.bare=false
     +	references.format=files
    ++	layout.bare=false
     +	EOF
    -+	git init --ref-format=files two-keys &&
    -+	git -C two-keys repo info layout.bare references.format >actual &&
    -+	test_cmp expected actual
    ++	git init --ref-format=files ordered &&
    ++	git -C ordered repo info layout.bare references.format layout.bare >actual &&
    ++	test_cmp expect actual
     +'
     +
    - test_done
    + test_expect_success 'git-repo-info fails if an invalid key is requested' '
    + 	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
    + 	test_must_fail git repo info foo 2>actual_err &&
4:  91fc5c4e50 ! 4:  3837899c32 repo: add the field layout.shallow
    @@ builtin/repo.c: static int get_layout_bare(struct repository *repo UNUSED, struc
      {
      	strbuf_addstr(buf,
     @@ builtin/repo.c: static int get_references_format(struct repository *repo, struct strbuf *buf)
    - /* repo_info_fields keys should be in lexicographical order */
    + /* repo_info_fields keys must be in lexicographical order */
      static const struct field repo_info_fields[] = {
      	{ "layout.bare", get_layout_bare },
     +	{ "layout.shallow", get_layout_shallow },
    @@ t/t1900-repo.sh: test_repo_info 'bare repository = false is retrieved correctly'
     +test_repo_info 'shallow repository = false is retrieved correctly' \
     +	'git init' 'nonshallow' 'layout.shallow' 'false'
     +
    -+test_repo_info 'shallow repository = true is retrieved correctly' \
    -+	'git init remote &&
    ++test_expect_success 'setup remote' '
    ++	git init remote &&
     +	echo x >remote/x &&
     +	git -C remote add x &&
    -+	git -C remote commit -m x &&
    -+	git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
    ++	git -C remote commit -m x
    ++'
    ++
    ++test_repo_info 'shallow repository = true is retrieved correctly' \
    ++	'git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
     +
    - test_expect_success 'git-repo-info fails if an invalid key is requested' '
    - 	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
    - 	test_must_fail git repo info foo 2>actual_err &&
    + test_expect_success 'values returned in order requested' '
    + 	cat >expect <<-\EOF &&
    + 	layout.bare=false
5:  8af32d7066 ! 5:  19fdfce646 repo: add the --format flag
    @@ Documentation/git-repo.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHAN
      	Retrieve metadata-related information about the current repository. Only
      	the requested data will be returned based on their keys (see "INFO KEYS"
      	section below).
    - +
    - The returned data is lexicographically sorted by the keys.
    +@@ Documentation/git-repo.adoc: COMMANDS
    + The values are returned in the same order in which their respective keys were
    + requested.
      +
     -The output format consists of key-value pairs one per line using the `=`
     -character as the delimiter between the key and the value. Values containing
     -"unusual" characters are quoted as explained for the configuration variable
    +-`core.quotePath` (see linkgit:git-config[1]).
     +The output format can be chosen through the flag `--format`. Two formats are
     +supported:
     ++
     +* `keyvalue`: output key-value pairs one per line using the `=` character as
     +the delimiter between the key and the value. Values containing "unusual"
     +characters are quoted as explained for the configuration variable
    - `core.quotePath` (see linkgit:git-config[1]). This is the default.
    - 
    ++`core.quotePath` (see linkgit:git-config[1]). This is the default.
    ++
     +* `nul`: similar to `keyvalue`, but using a newline character as the delimiter
     +between the key and the value and using a null character after each value.
     +This format is better suited for being parsed by another applications than
     +`keyvalue`. Unlike in the `keyvalue` format, the values are never quoted.
    -+
    + 
      INFO KEYS
      ---------
     -
    @@ builtin/repo.c
      struct field {
      	const char *key;
      	get_value_fn *get_value;
    -@@ builtin/repo.c: static int qsort_strcmp(const void *va, const void *vb)
    - 	return strcmp(a, b);
    +@@ builtin/repo.c: static get_value_fn *get_value_fn_for_key(const char *key)
    + 	return found ? found->get_value : NULL;
      }
      
     -static int print_fields(int argc, const char **argv, struct repository *repo)
    @@ builtin/repo.c: static int qsort_strcmp(const void *va, const void *vb)
     +			enum output_format format)
      {
      	int ret = 0;
    - 	const char *last = "";
    + 	struct strbuf valbuf = STRBUF_INIT;
     @@ builtin/repo.c: static int print_fields(int argc, const char **argv, struct repository *repo)
    - 		}
    + 		strbuf_reset(&quotbuf);
      
      		get_value(repo, &valbuf);
     -		quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
    @@ t/t1900-repo.sh: test_repo_info () {
     +	'
      }
      
    - test_repo_info 'ref format files is retrieved correctly' '
    -@@ t/t1900-repo.sh: test_repo_info 'bare repository = true is retrieved correctly' \
    - test_repo_info 'shallow repository = false is retrieved correctly' \
    - 	'git init' 'nonshallow' 'layout.shallow' 'false'
    - 
    --test_repo_info 'shallow repository = true is retrieved correctly' \
    --	'git init remote &&
    -+test_expect_success 'setup remote' '
    -+	git init remote &&
    - 	echo x >remote/x &&
    - 	git -C remote add x &&
    --	git -C remote commit -m x &&
    --	git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
    -+	git -C remote commit -m x
    -+'
    -+
    -+test_repo_info 'shallow repository = true is retrieved correctly' \
    -+	'git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
    - 
    - test_expect_success 'git-repo-info fails if an invalid key is requested' '
    - 	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
    -@@ t/t1900-repo.sh: test_expect_success 'output is returned correctly when two keys are requested' '
    + test_repo_info 'ref format files is retrieved correctly' \
    +@@ t/t1900-repo.sh: test_expect_success 'git-repo-info outputs data even if there is an invalid fiel
      	test_cmp expected actual
      '
      
     +test_expect_success 'git-repo-info aborts when requesting an invalid format' '
    -+	echo "fatal: invalid format '\'foo\''" >expected &&
    ++	echo "fatal: invalid format ${SQ}foo${SQ}" >expected &&
     +	test_must_fail git repo info --format=foo 2>err &&
     +	test_cmp expected err
     +'


Lucas Seiki Oshiro (5):
  repo: declare the repo command
  repo: add the field references.format
  repo: add the field layout.bare
  repo: add the field layout.shallow
  repo: add the --format flag

 .gitignore                  |   1 +
 Documentation/git-repo.adoc |  82 ++++++++++++++++++++
 Documentation/meson.build   |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/repo.c              | 150 ++++++++++++++++++++++++++++++++++++
 command-list.txt            |   1 +
 git.c                       |   1 +
 meson.build                 |   1 +
 t/meson.build               |   1 +
 t/t1900-repo.sh             |  96 +++++++++++++++++++++++
 11 files changed, 336 insertions(+)
 create mode 100644 Documentation/git-repo.adoc
 create mode 100644 builtin/repo.c
 create mode 100755 t/t1900-repo.sh

-- 
2.39.5 (Apple Git-154)

