Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4C217709
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638706; cv=none; b=d/MtOj6rMLZeGgH5bP0YQysHywnFl6QS07o60UddbidEo+KmOWO6wg5BeHaS7ucI7z9nzeVhuzRIwIf5WRHDfHUiD4WUONWOO1Xd2bw2BlpLysm3ex54mU96zxd0Gy/KJhKd983M5xxFqAYRHlJUi6zmZDSszrcHmJYWLbBF+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638706; c=relaxed/simple;
	bh=2EUwWCIiI96iBrLLEzG9jn4F68syz68vgZBJ+/2RQ5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qpac/HoJ4tq6iK9xdjq7l/tYRpl65/dAmFmU6cdL4eEjYqFtDCsi4ujz7CunbjN+opPZxbqT7OGEam1X/6FnTXW2rchlFpwRPLkzeJQGLL+EFJtQGqDQSoqz1yD0mzQ32ydUTBvlVMUJ465+wrE01iAwImNm63lR4QwwJLB65rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrIK17PP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrIK17PP"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b390d09e957so3991869a12.1
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753638700; x=1754243500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSDW0PA7zLEALxzDmuJuF6jkciP906aeL94Jzi3sRrg=;
        b=RrIK17PPyHcE1K75qF1x97RyKdryyBj48VXFHldqkPLqE8FNwBpOKqzLt2Zn7Jav8Q
         1rLcjD05bWvdYZcPe2SKt1kiwPQ2EujhYlfYVu4qxYEMz3OwmRW8JGBk2O4M530ngwVa
         mVIkRIJ+ATmLWHPDmohb23zRoynQLa+aslCICcEmLTKva2GKA6Olg+d9fWH/kZGg8SNF
         GVp4Lo6tRoISALuTla66J5BgLLR8IppcJlXX4frMYJeK9rdYDTYf8cWsSBgF4wBuTObU
         A1l+EJrt5XJibT7nJVk9St6NkjrM3BdR3gjcrRPItIDNly9gbtkws/31AvAPK5MaV2wh
         uvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753638700; x=1754243500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSDW0PA7zLEALxzDmuJuF6jkciP906aeL94Jzi3sRrg=;
        b=gqHurUSoN3GLzXzkY4zeusdxociAGTeQsl0dJNBKCDwshYJb4nScAoXoSEE6qsYgs6
         xBWwY05iJ/HOar79hQTSY2wEljFxF7Tz93c74nF9b+2Xp2euEUFSYDzv8fYDbaEet3XS
         OLhBtVkqYW/eVnf4hIbkhQVgdB+AhVrMDWV8r551GaHbRQ/jMxXcigurDWgPkrseKpTQ
         2y20qWSXohq3QvaNprsFzV4n4XsKA6e0sOJG2f9zGIc7fSaZMoGRPn7iEJWkLU6mA94N
         NKUNaNPZvT3/BwaNSE9m18izVo3XZ8rmW3LR3XFxwttuq+5LzXdIQF5IbLCf3MOkBWHa
         JAqQ==
X-Gm-Message-State: AOJu0YyujLlvEoGOEKWblUI5tfpRyWw+snjjA8+F+IeojeI+kNhaCUAX
	Eg4USEKEvpSvfYC73lL3l3kdOnh5NtC1ivymhS1BjcnyH7QWrzFZysTRCAOyHg==
X-Gm-Gg: ASbGncseFepeFsNjkUp9Yad7wu2T2VwmkIf8dCHTJPEcjvUetFUviMygo287H4rvQcW
	/kB16KdK3hwbpqG8YUyIHASExhbI/JiOeOUuZibKcZF1bjplXEJUNsHZ7Qfgpl1FGzdCOJHLBxV
	JR9AW259/lzvJo01HGM91X3+UOUKpxkl92+oZFhaucBcldFfQwGQBPV9nkvpuCpWPfVSbcKBdZC
	3DCgNmyGAXgfOl+PRQJmSWVvlo9e4kyUTAWeTTTnvIKWHkuVypSbtlGlGQpCicVIg3mShzRKeKH
	FhrneROOFHvXc3zz18V2peuLXW3rYscrBYqBU+ukuHbxpKvtsv8Z8AoN7x9PpvivdL0DR+sh1Mq
	h3th5mot53DnrflocnfJVYNnHItV7LK87OBqV6i21a74mzRY/65LwzSkhQpAt95Y+vWzjmhzu6M
	hR6/NP/kMXErqKVcbhmFpOCw==
X-Google-Smtp-Source: AGHT+IGqa6GlA7e3W4h9P0rgd92gW9aCC3tEefAOURXFzVH4+Jy2xf7XpwZ+ZoWsyvcaD0YRPMa1MA==
X-Received: by 2002:a17:90b:1e08:b0:311:ea13:2e70 with SMTP id 98e67ed59e1d1-31e77a3e9f7mr13696776a91.14.1753638699579;
        Sun, 27 Jul 2025 10:51:39 -0700 (PDT)
Received: from localhost.localdomain (201-1-210-243.dsl.telesp.net.br. [201.1.210.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58bec0sm3392488a12.17.2025.07.27.10.51.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Jul 2025 10:51:39 -0700 (PDT)
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
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v5 0/5] repo: add new command for retrieving repository info
Date: Sun, 27 Jul 2025 14:51:05 -0300
Message-Id: <20250727175110.84770-1-lucasseikioshiro@gmail.com>
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

This v6 contains small fixes pointed in v5.

The main changes were:

- The functions that retrieve the values now add a string to a strbuf
  instead of returning the string

- The null-terminated format is now identified as "nul"

- Two test cases were added, covering invalid input values in the CLI

In v5, Patrick and Junio were discussing about quoting the values in the
key=value format using `quote_c_style` [1]. Given that it wouldn't affect
this patchset and it's a simple change that can be done later, I didn't
change it and I'll leave for further discussion when I start to deal
with paths.

Thanks!

[1] https://lore.kernel.org/git/aIHRCz_qswp7RgSy@pks.im/

Range-diff versus v5:

1:  396cfc256a ! 1:  bc6f19ba8e repo: declare the repo command
    @@ Commit message

         Create a new Git command called `repo`. `git repo` will be the main
         command for obtaining the information about a repository (such as
    -    metadata and metrics), returning them in a machine readable format
    -    following the syntax "field<LF>value<NUL>".
    +    metadata and metrics).

         Also declare a subcommand for `repo` called `info`. `git repo info`
         will bring the functionality of retrieving repository-related
    @@ Documentation/git-repo.adoc (new)
     +
     +COMMANDS
     +--------
    -+info [<key>...]::
    ++`info [<key>...]`::
     +	Retrieve metadata-related information about the current repository. Only
     +	the requested data will be returned based on their keys (see "INFO KEYS"
     +	section below).
2:  28f4c21a96 ! 2:  b1c0627af8 repo: add the field references.format
    @@ Commit message
         used for querying repository metadata, fitting in the purpose of
         git-repo-info.

    -    Then, add a new field `references.format` to the repo-info subcommand
    +    Add a new field `references.format` to the repo-info subcommand
         containing that information.

         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    @@ builtin/repo.c
      #include "builtin.h"
      #include "parse-options.h"
     +#include "refs.h"
    ++#include "strbuf.h"

     -static int repo_info(int argc UNUSED, const char **argv UNUSED,
     -		     const char *prefix UNUSED, struct repository *repo UNUSED)
    -+typedef const char *get_value_fn(struct repository *repo);
    ++typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
     +
     +struct field {
     +	const char *key;
    -+	get_value_fn *add_field_callback;
    ++	get_value_fn *get_value;
     +};
     +
    -+static const char *get_references_format(struct repository *repo)
    ++static int get_references_format(struct repository *repo, struct strbuf *buf)
     +{
    -+	return ref_storage_format_to_name(repo->ref_storage_format);
    ++	strbuf_addstr(buf,
    ++		      ref_storage_format_to_name(repo->ref_storage_format));
    ++	return 0;
     +}
     +
     +/* repo_info_fields keys should be in lexicographical order */
    @@ builtin/repo.c
     +	return strcmp(a->key, b->key);
     +}
     +
    -+static get_value_fn *get_value_callback(const char *key)
    - {
    ++static get_value_fn *get_value_fn_for_key(const char *key)
    ++{
     +	const struct field search_key = { key, NULL };
     +	const struct field *found = bsearch(&search_key, repo_info_fields,
     +					    ARRAY_SIZE(repo_info_fields),
    -+					    sizeof(struct field),
    ++					    sizeof(*found),
     +					    repo_info_fields_cmp);
    -+	return found ? found->add_field_callback : NULL;
    ++	return found ? found->get_value : NULL;
     +}
     +
     +static int qsort_strcmp(const void *va, const void *vb)
    -+{
    + {
     +	const char *a = *(const char **)va;
     +	const char *b = *(const char **)vb;
     +
    @@ builtin/repo.c
     +	QSORT(argv, argc, qsort_strcmp);
     +
     +	for (int i = 0; i < argc; i++) {
    -+		get_value_fn *callback;
    ++		get_value_fn *get_value;
     +		const char *key = argv[i];
    -+		const char *value;
    ++		struct strbuf value;
    ++		strbuf_init(&value, 64);
     +
     +		if (!strcmp(key, last))
     +			continue;
     +
    -+		callback = get_value_callback(key);
    ++		get_value = get_value_fn_for_key(key);
     +
    -+		if (!callback)
    -+			return error("key %s not found", key);
    ++		if (!get_value)
    ++			die(_("key '%s' not found"), key);
     +
    -+		value = callback(repo);
    -+		printf("%s=%s\n", key, value);
    ++		get_value(repo, &value);
    ++		printf("%s=%s\n", key, value.buf);
     +		last = key;
    ++		strbuf_release(&value);
     +	}
     +
      	return 0;
    @@ t/t1900-repo.sh (new)
     +test_repo_info 'ref format reftable is retrieved correctly' '
     +	git init --ref-format=reftable repo' 'references.format' 'reftable'
     +
    ++test_expect_success 'git-repo-info aborts if an invalid key is requested' '
    ++	test_when_finished "rm -rf expected err" &&
    ++	echo "fatal: key '\'foo\'' not found" >expected &&
    ++	test_must_fail git repo info foo 2>err &&
    ++	test_cmp expected err
    ++'
    ++
     +test_expect_success "only one value is returned if the same key is requested twice" '
     +	test_when_finished "rm -f expected_key expected_value actual_key actual_value output" &&
     +	echo "references.format" >expected_key &&
3:  b8001ae87e ! 3:  d002401587 repo: add field layout.bare
    @@ builtin/repo.c
     +#define USE_THE_REPOSITORY_VARIABLE
     +
      #include "builtin.h"
    ++#include "environment.h"
      #include "parse-options.h"
      #include "refs.h"
    -+#include "environment.h"
    -
    - typedef const char *get_value_fn(struct repository *repo);
    -
    + #include "strbuf.h"
     @@ builtin/repo.c: struct field {
    - 	get_value_fn *add_field_callback;
    + 	get_value_fn *get_value;
      };

    -+static const char *get_layout_bare(struct repository *repo UNUSED)
    ++static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
     +{
    -+	return is_bare_repository() ? "true" : "false";
    ++	strbuf_addstr(buf,
    ++		      is_bare_repository() ? "true" : "false");
    ++	return 0;
     +}
     +
    - static const char *get_references_format(struct repository *repo)
    + static int get_references_format(struct repository *repo, struct strbuf *buf)
      {
    - 	return ref_storage_format_to_name(repo->ref_storage_format);
    -@@ builtin/repo.c: static const char *get_references_format(struct repository *repo)
    + 	strbuf_addstr(buf,
    +@@ builtin/repo.c: static int get_references_format(struct repository *repo, struct strbuf *buf)

      /* repo_info_fields keys should be in lexicographical order */
      static const struct field repo_info_fields[] = {
    @@ t/t1900-repo.sh: test_repo_info 'ref format files is retrieved correctly' '
     +test_repo_info 'bare repository = true is retrieved correctly' '
     +	git init --bare repo' 'layout.bare' 'true'
     +
    - test_expect_success "only one value is returned if the same key is requested twice" '
    - 	test_when_finished "rm -f expected_key expected_value actual_key actual_value output" &&
    - 	echo "references.format" >expected_key &&
    + test_expect_success 'git-repo-info aborts if an invalid key is requested' '
    + 	test_when_finished "rm -rf expected err" &&
    + 	echo "fatal: key '\'foo\'' not found" >expected &&
4:  bceba54e8b ! 4:  6eaac3f9c3 repo: add field layout.shallow
    @@ builtin/repo.c
     @@
      #include "parse-options.h"
      #include "refs.h"
    - #include "environment.h"
    + #include "strbuf.h"
     +#include "shallow.h"

    - typedef const char *get_value_fn(struct repository *repo);
    + typedef int get_value_fn(struct repository *repo, struct strbuf *buf);

    -@@ builtin/repo.c: static const char *get_layout_bare(struct repository *repo UNUSED)
    - 	return is_bare_repository() ? "true" : "false";
    +@@ builtin/repo.c: static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
    + 	return 0;
      }

    -+static const char *get_layout_shallow(struct repository *repo)
    ++static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
     +{
    -+	return is_repository_shallow(repo) ? "true" : "false";
    ++	strbuf_addstr(buf,
    ++		      is_repository_shallow(repo) ? "true" : "false");
    ++	return 0;
     +}
     +
    - static const char *get_references_format(struct repository *repo)
    + static int get_references_format(struct repository *repo, struct strbuf *buf)
      {
    - 	return ref_storage_format_to_name(repo->ref_storage_format);
    -@@ builtin/repo.c: static const char *get_references_format(struct repository *repo)
    + 	strbuf_addstr(buf,
    +@@ builtin/repo.c: static int get_references_format(struct repository *repo, struct strbuf *buf)
      /* repo_info_fields keys should be in lexicographical order */
      static const struct field repo_info_fields[] = {
      	{ "layout.bare", get_layout_bare },
    @@ t/t1900-repo.sh: test_repo_info 'bare repository = false is retrieved correctly'
     +	rm -rf remote
     +	' 'layout.shallow' 'true'
     +
    - test_expect_success "only one value is returned if the same key is requested twice" '
    - 	test_when_finished "rm -f expected_key expected_value actual_key actual_value output" &&
    - 	echo "references.format" >expected_key &&
    + test_expect_success 'git-repo-info aborts if an invalid key is requested' '
    + 	test_when_finished "rm -rf expected err" &&
    + 	echo "fatal: key '\'foo\'' not found" >expected &&
     @@ t/t1900-repo.sh: test_expect_success "only one value is returned if the same key is requested twi
              test_cmp expected_value actual_value
      '
5:  f4a2b0a04e ! 5:  69c7554bf3 repo: add the --format flag
    @@ Commit message
         Add the --format flag to git-repo-info. By using this flag, the users
         can choose the format for obtaining the data they requested.

    -    Given that this command can be used for generating input for another
    +    Given that this command can be used for generating input for other
         applications and for being read by end users, it requires at least two
         formats: one for being read by humans and other for being read by
         machines. Some other Git commands also have two output formats, notably
    @@ Documentation/git-repo.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHAN

      COMMANDS
      --------
    --info [<key>...]::
    -+info [--format=<format>] [<key>...]::
    +-`info [<key>...]`::
    ++`info [--format=<format>] [<key>...]`::
      	Retrieve metadata-related information about the current repository. Only
      	the requested data will be returned based on their keys (see "INFO KEYS"
      	section below).
    @@ Documentation/git-repo.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHAN
     +* `keyvalue`: output key-value pairs one per line using the `=` character as
     +the delimiter between the key and the value. This is the default.
     +
    -+* `null`: similar to `keyvalue`, but using a newline character as the delimiter
    ++* `nul`: similar to `keyvalue`, but using a newline character as the delimiter
     +between the key and the value and using a null character after each value.
     +This format is better suited for being parsed by another applications than
     +`keyvalue`.
    @@ Documentation/git-repo.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHAN
      ## builtin/repo.c ##
     @@

    - typedef const char *get_value_fn(struct repository *repo);
    + typedef int get_value_fn(struct repository *repo, struct strbuf *buf);

     +enum output_format {
     +	FORMAT_KEYVALUE,
    -+	FORMAT_NULL_TERMINATED,
    ++	FORMAT_NUL_TERMINATED,
     +};
     +
      struct field {
      	const char *key;
    - 	get_value_fn *add_field_callback;
    + 	get_value_fn *get_value;
     @@ builtin/repo.c: static int qsort_strcmp(const void *va, const void *vb)
      	return strcmp(a, b);
      }
    @@ builtin/repo.c: static int qsort_strcmp(const void *va, const void *vb)
     +		kv_sep = '=';
     +		field_sep = '\n';
     +		break;
    -+	case FORMAT_NULL_TERMINATED:
    ++	case FORMAT_NUL_TERMINATED:
     +		kv_sep = '\n';
     +		field_sep = '\0';
     +		break;
    @@ builtin/repo.c: static int qsort_strcmp(const void *va, const void *vb)
      	QSORT(argv, argc, qsort_strcmp);

     @@ builtin/repo.c: static int print_fields(int argc, const char **argv, struct repository *repo)
    - 			return error("key %s not found", key);
    + 			die(_("key '%s' not found"), key);

    - 		value = callback(repo);
    --		printf("%s=%s\n", key, value);
    -+		printf("%s%c%s%c", key, kv_sep, value, field_sep);
    + 		get_value(repo, &value);
    +-		printf("%s=%s\n", key, value.buf);
    ++		printf("%s%c%s%c", key, kv_sep, value.buf, field_sep);
      		last = key;
    + 		strbuf_release(&value);
      	}
    -
    +@@ builtin/repo.c: static int print_fields(int argc, const char **argv, struct repository *repo)
      	return 0;
      }

    @@ builtin/repo.c: static int print_fields(int argc, const char **argv, struct repo
     +
     +	if (!strcmp(format_str, "keyvalue"))
     +		format = FORMAT_KEYVALUE;
    -+	else if (!strcmp(format_str, "null"))
    -+		format = FORMAT_NULL_TERMINATED;
    ++	else if (!strcmp(format_str, "nul"))
    ++		format = FORMAT_NUL_TERMINATED;
     +	else
    -+		die("invalid format %s", format_str);
    ++		die(_("invalid format '%s'"), format_str);
     +
     +	return print_fields(argc, argv, repo, format);
      }
    @@ t/t1900-repo.sh: test_repo_info () {
     +		test_when_finished "rm -rf repo" &&
     +		eval "$init_command" &&
     +		echo "$expected_value" | lf_to_nul >expected &&
    -+		git -C repo repo info --format=null "$key" >output &&
    ++		git -C repo repo info --format=nul "$key" >output &&
     +		tail -n 1 output >actual &&
     +		test_cmp expected actual
     +	'
    @@ t/t1900-repo.sh: test_repo_info () {
      		cut -d "=" -f 2 <output >actual &&
      		test_cmp expected actual
      	'
    +@@ t/t1900-repo.sh: test_expect_success 'output is returned correctly when two keys are requested' '
    + 	test_cmp expect actual
    + '
    +
    ++test_expect_success 'git-repo-info aborts when requesting an invalid format' '
    ++	test_when_finished "rm -f err expected" &&
    ++	echo "fatal: invalid format '\'foo\''" >expected &&
    ++	test_must_fail git repo info --format=foo 2>err &&
    ++	test_cmp expected err
    ++'
    ++
    + test_done

Lucas Seiki Oshiro (5):
  repo: declare the repo command
  repo: add the field references.format
  repo: add field layout.bare
  repo: add field layout.shallow
  repo: add the --format flag

 .gitignore                  |   1 +
 Documentation/git-repo.adoc |  58 +++++++++++++
 Documentation/meson.build   |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/repo.c              | 165 ++++++++++++++++++++++++++++++++++++
 command-list.txt            |   1 +
 git.c                       |   1 +
 meson.build                 |   1 +
 t/meson.build               |   1 +
 t/t1900-repo.sh             | 100 ++++++++++++++++++++++
 11 files changed, 331 insertions(+)
 create mode 100644 Documentation/git-repo.adoc
 create mode 100644 builtin/repo.c
 create mode 100755 t/t1900-repo.sh

-- 
2.39.5 (Apple Git-154)

