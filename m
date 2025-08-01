Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757C33D8
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053885; cv=none; b=keYvL9qQMlQyXTE/P56QUMXD7/AL/FwJb0lN52FJyMdlTb9+3ZYfhFlj74mm9Tf0Rj8ktbd05D/Ty4VIeS6trmOFfUQPoStBoGOxSGnPghKoOeprfv9aI281qau/ggmHFosoMyS4LnPP7uamiPIrVkMo7KJgkxwHSyrtK/mqKig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053885; c=relaxed/simple;
	bh=Jto0JxXSPQ/umWOcy2EbG9Kpf2+Cl0mHWvrpjbt3AHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJMtWChkiXG30UtAOOzdAuKsiRCq+mpWThYpCrgcCpZoo5bnLEHUlBB+AV12nwLr0zkOwe5irMOgNgZLxbhPFxA9g4Kg4sjMCzAt/r8CufSOzUnzgiERysz47a44d0gIFm6k1ELa8AERkksUEPOo83bIgL95nF0cJR+68siiVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvZ5+vHb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvZ5+vHb"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so864843a91.2
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754053882; x=1754658682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnr0IecxFNL1PQv21m9dS+9+YX30ZpviIrkmaMERlF8=;
        b=GvZ5+vHbOrNrdeFz6ltzMMQuaH0yMvMHhHMRMMTtBPO0F8nHLdz7XpXZUYH96Oq1hT
         qoIiQZepPzuQoOr+d2VpPwmMEDzSeHBRf3AV6kLHbEBdq8UdrMdBGcCuPgeLnYgYW14o
         +DG/rB5K21NamIzpAkDFrgPnzoDbQWnLXyXu5jiVNWS5LpHOZozGb4ZcUxrA5M+Ddfi9
         V17YfBJ09VCzDrhJH4paddzH4Dqh+Ckl5hW+AoDqaEQLMy/2PDfy9X2DtH6sC8PjERJH
         asDCx5s5HI7BvK7Ho+z9bbZtoWEFS9SoOxkzTii13hULSrs/VAVrmXDE3sYEl+qIahh4
         DO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754053882; x=1754658682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnr0IecxFNL1PQv21m9dS+9+YX30ZpviIrkmaMERlF8=;
        b=ofQWcGj31NIILiyjMQnwBj6Jwwye/bPJFa+INr7xrLAc04MHbTuvfHiIYgyOS9YbZ+
         d+qYKRaTVScAtOwTv9Lzd3ulDHOOz1uOEMW8oTY1wkvdCJ7PYyEocGKNs1AW+ZgrHbDS
         +7YAip2YmwHoY3mPNw7qRsklaVgIAEnhf+7/IKkbCrhkDH34lp+bXJtB4lTsz07bIsMT
         W5oaO1AfBL9lNg7FML7s6TCDyWqnqKQZi+dpVeGBIDgU3WCwtHxYfNY+44WLYUQ9L4o8
         7Q7+J+R06jLVqnqmpxtrqwI8nvEaZM9RK6kkdM4xtbeBXDjQ7CyIdOAF3DOouPgeNWx3
         MdHA==
X-Gm-Message-State: AOJu0YxRB1jGF+VZN+2qch1QCVDTNQqV8yBLRIyTxq2JQTRchmdL7WA0
	nWduGdxdesUzvBf783BJhJK2Hhm4Sa8yuY7IIwEJhHA/dXa2B3eqDcJxQlgj6E2x
X-Gm-Gg: ASbGncthVwlgIi0MjHd14HHFswbI28VvTdh4JS6cojLXTr/UQ8USATT4vwMuSzOuDsN
	Sl7q1/iTuzED180/c1lsrbmirslot+Wt7cus77KqdN2tkIiOpL6PmdI4Kr11Gc6sp/Xxx6Mbs/0
	xGwgzwuhgjxHPvgtEbdDi1GsUYHzyiXLmNk6QsSmmCncJHHf65zY3TUpt28z5UYkEKaA6e6mioz
	m9Uc70QwKKmHeVwrdYWs0ofF61AskYIdJI3ci9bFQDlBze2Bv0sNekjHvjQoAqcD9sRD4OiODtw
	uwWPBnEuAyA3M7N2PqoZnKHcNmmR5AA4g6q+mia2DCWEumHAdU4zlDL1FI2kU7DceMFO+nFaOch
	qxhghV4zYDwFL6fqVJOseqDWt8OUzLQnXAZ9Y+/jgwDwRjXTJh8TtQyA59DM9f3SV5g==
X-Google-Smtp-Source: AGHT+IGmrHundsjO972DJ2PHKtFTXRy26nNmXIt+VDrgjJ8v/GZuV9bNwO0RlCO6Q6XlyukLjXzQFQ==
X-Received: by 2002:a17:90b:1ccc:b0:31e:d2a5:c099 with SMTP id 98e67ed59e1d1-31f5ea4a331mr15116200a91.30.1754053881695;
        Fri, 01 Aug 2025 06:11:21 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8c1d:878:ec5d:4583:4785])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7e4fc1sm3542272a12.28.2025.08.01.06.11.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Aug 2025 06:11:21 -0700 (PDT)
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
Subject: [GSoC PATCH v7 0/5] repo: add new command for retrieving repository info
Date: Fri,  1 Aug 2025 10:11:05 -0300
Message-Id: <20250801131111.8115-1-lucasseikioshiro@gmail.com>
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

These are the changes of this 7th version of `git repo`:

- The tests were refactored (thanks Eric for your careful revision!)

- The documentation has been improved: now it is a little more
  descriptive about the keys. I'm also including more information about
  the values

- The documentation now contains examples

- If an invalid key is requested, the command fails, however, now it
  returns all the valid fields that were requested

- Now, I'm using `quote_c_style` in the key=value format

Thanks!

Range-diff versus v6:

1:  bc6f19ba8e ! 1:  b4f063b177 repo: declare the repo command
    @@ Commit message
         will bring the functionality of retrieving repository-related
         information currently returned by `rev-parse`.

    -    Add the required tests, documentation and build changes to enable
    -    usage of this subcommand.
    +    Add the required documentation and build changes to enable usage of
    +    this subcommand.

         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Helped-by: Justin Tobler <jltobler@gmail.com>
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
    @@ Documentation/git-repo.adoc (new)
     +
     +NAME
     +----
    -+git-repo - Retrieve information about a repository
    ++git-repo - Retrieve information about the repository
     +
     +SYNOPSIS
     +--------
    @@ Documentation/git-repo.adoc (new)
     +
     +DESCRIPTION
     +-----------
    -+This command retrieve repository level information.
    ++Retrieve information about the repository.
     +
     +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
     +
    @@ Documentation/git-repo.adoc (new)
     +	the requested data will be returned based on their keys (see "INFO KEYS"
     +	section below).
     +
    -+INFO KEYS
    -+---------
    -+
    -+The set of data that `git repo` can return is grouped into the following
    -+categories:
    -+
     +SEE ALSO
     +--------
     +linkgit:git-rev-parse[1]
    @@ builtin/repo.c (new)
     +#include "builtin.h"
     +#include "parse-options.h"
     +
    ++static const char *const repo_usage[] = {
    ++	"git repo info [<key>...]",
    ++	NULL
    ++};
    ++
     +static int repo_info(int argc UNUSED, const char **argv UNUSED,
     +		     const char *prefix UNUSED, struct repository *repo UNUSED)
     +{
    @@ builtin/repo.c (new)
     +	     struct repository *repo)
     +{
     +	parse_opt_subcommand_fn *fn = NULL;
    -+	const char *const repo_usage[] = {
    -+		"git repo info [<key>...]",
    -+		NULL
    -+	};
     +	struct option options[] = {
     +		OPT_SUBCOMMAND("info", &fn, repo_info),
     +		OPT_END()
2:  2b0e91f94d ! 2:  56cb05ecb2 repo: add the field references.format
    @@ Commit message
         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Helped-by: Justin Tobler <jltobler@gmail.com>
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>

      ## Documentation/git-repo.adoc ##
    -@@ Documentation/git-repo.adoc: INFO KEYS
    - The set of data that `git repo` can return is grouped into the following
    - categories:
    +@@ Documentation/git-repo.adoc: COMMANDS
    + 	Retrieve metadata-related information about the current repository. Only
    + 	the requested data will be returned based on their keys (see "INFO KEYS"
    + 	section below).
    +++
    ++The returned data is lexicographically sorted by the keys.
    ++
    ++INFO KEYS
    ++---------
    ++
    ++In order to obtain a set of values from `git repo info`, you should provide
    ++the keys that identify them. Here's a list of the available keys and the
    ++values that they return:
    ++
    ++`references.format`::
    ++The reference storage format. The valid values are:
    +++
    ++include::ref-storage-format.adoc[]

    -+`references`::
    -+Reference-related data:
    -+* `format`: the reference storage format
    -+
      SEE ALSO
      --------
    - linkgit:git-rev-parse[1]

      ## builtin/repo.c ##
     @@
      #include "builtin.h"
      #include "parse-options.h"
    ++#include "quote.h"
     +#include "refs.h"
     +#include "strbuf.h"

    + static const char *const repo_usage[] = {
    + 	"git repo info [<key>...]",
    + 	NULL
    + };
    +
     -static int repo_info(int argc UNUSED, const char **argv UNUSED,
     -		     const char *prefix UNUSED, struct repository *repo UNUSED)
     +typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
    @@ builtin/repo.c
     +};
     +
     +static int get_references_format(struct repository *repo, struct strbuf *buf)
    -+{
    + {
     +	strbuf_addstr(buf,
     +		      ref_storage_format_to_name(repo->ref_storage_format));
    -+	return 0;
    -+}
    -+
    + 	return 0;
    + }
    +
     +/* repo_info_fields keys should be in lexicographical order */
     +static const struct field repo_info_fields[] = {
     +	{ "references.format", get_references_format },
    @@ builtin/repo.c
     +}
     +
     +static int qsort_strcmp(const void *va, const void *vb)
    - {
    ++{
     +	const char *a = *(const char **)va;
     +	const char *b = *(const char **)vb;
     +
    @@ builtin/repo.c
     +
     +static int print_fields(int argc, const char **argv, struct repository *repo)
     +{
    ++	int ret = 0;
     +	const char *last = "";
    ++	struct strbuf sb = STRBUF_INIT;
     +
     +	QSORT(argv, argc, qsort_strcmp);
     +
     +	for (int i = 0; i < argc; i++) {
     +		get_value_fn *get_value;
     +		const char *key = argv[i];
    -+		struct strbuf value;
    ++		char *value;
     +
     +		if (!strcmp(key, last))
     +			continue;
     +
    -+		strbuf_init(&value, 64);
     +		get_value = get_value_fn_for_key(key);
     +
     +		if (!get_value) {
    -+			strbuf_release(&value);
    -+			return error(_("key '%s' not found"), key);
    ++			ret = error(_("key '%s' not found"), key);
    ++			continue;
     +		}
     +
    -+		get_value(repo, &value);
    -+		printf("%s=%s\n", key, value.buf);
    ++		strbuf_reset(&sb);
    ++		get_value(repo, &sb);
    ++
    ++		value = strbuf_detach(&sb, NULL);
    ++		quote_c_style(value, &sb, NULL, 0);
    ++		free(value);
    ++
    ++		printf("%s=%s\n", key, sb.buf);
     +		last = key;
    -+		strbuf_release(&value);
     +	}
     +
    - 	return 0;
    - }
    -
    ++	strbuf_release(&sb);
    ++	return ret;
    ++}
    ++
     +static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
     +		     struct repository *repo)
     +{
    @@ t/t1900-repo.sh (new)
     +
     +. ./test-lib.sh
     +
    -+# Test if a field is correctly returned in the null-terminated format
    ++# Test whether a key-value pair is correctly returned
     +#
     +# Usage: test_repo_info <label> <init command> <key> <expected value>
     +#
     +# Arguments:
     +#   label: the label of the test
    -+#   init command: a command that creates a repository called 'repo', configured
    ++#   init command: a command which creates a repository named with its first argument,
     +#      accordingly to what is being tested
     +#   key: the key of the field that is being tested
     +#   expected value: the value that the field should contain
     +test_repo_info () {
     +	label=$1
     +	init_command=$2
    -+	key=$3
    -+	expected_value=$4
    ++	repo_name=$3
    ++	key=$4
    ++	expected_value=$5
     +
     +	test_expect_success "$label" '
    -+		test_when_finished "rm -rf repo" &&
    -+		eval "$init_command" &&
    -+		echo "$expected_value" >expected &&
    -+		git -C repo repo info "$key" >output &&
    -+		cut -d "=" -f 2 <output >actual &&
    ++		eval "$init_command $repo_name" &&
    ++		echo "$key=$expected_value" >expected &&
    ++		git -C $repo_name repo info "$key" >actual &&
     +		test_cmp expected actual
     +	'
     +}
     +
     +test_repo_info 'ref format files is retrieved correctly' '
    -+	git init --ref-format=files repo' 'references.format' 'files'
    ++	git init --ref-format=files' 'format-files' 'references.format' 'files'
     +
     +test_repo_info 'ref format reftable is retrieved correctly' '
    -+	git init --ref-format=reftable repo' 'references.format' 'reftable'
    ++	git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
    ++
    ++test_expect_success 'git-repo-info fails if an invalid key is requested' '
    ++	echo "error: key '\'foo\'' not found" >expected_err &&
    ++	test_must_fail git repo info foo 2>actual_err &&
    ++	test_cmp expected_err actual_err
    ++'
     +
    -+test_expect_success 'git-repo-info aborts if an invalid key is requested' '
    -+	test_when_finished "rm -rf expected err" &&
    -+	echo "error: key '\'foo\'' not found" >expected &&
    -+	test_must_fail git repo info foo 2>err &&
    -+	test_cmp expected err
    ++test_expect_success 'git-repo-info outputs data even if there is an invalid field' '
    ++	echo "references.format=files" >expected &&
    ++	test_must_fail git repo info foo references.format bar >actual &&
    ++	test_cmp expected actual
     +'
     +
    -+test_expect_success "only one value is returned if the same key is requested twice" '
    -+	test_when_finished "rm -f expected_key expected_value actual_key actual_value output" &&
    -+	echo "references.format" >expected_key &&
    -+	git rev-parse --show-ref-format >expected_value &&
    -+	git repo info references.format references.format >output &&
    -+	cut -d "=" -f 1 <output >actual_key &&
    -+	cut -d "=" -f 2 <output >actual_value &&
    -+        test_cmp expected_key actual_key &&
    -+        test_cmp expected_value actual_value
    ++test_expect_success 'only one value is returned if the same key is requested twice' '
    ++	val=$(git rev-parse --show-ref-format) &&
    ++	echo "references.format=$val" >expect &&
    ++	git repo info references.format references.format >actual &&
    ++	test_cmp expect actual
     +'
     +
     +test_done
3:  733d3533d8 ! 3:  fc4c70d9b7 repo: add field layout.bare
    @@ Metadata
     Author: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>

      ## Commit message ##
    -    repo: add field layout.bare
    +    repo: add the field layout.bare

         This commit is part of the series that introduces the new subcommand
         git-repo-info.
    @@ Commit message
         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Helped-by: Justin Tobler <jltobler@gmail.com>
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>

      ## Documentation/git-repo.adoc ##
    -@@ Documentation/git-repo.adoc: categories:
    - Reference-related data:
    - * `format`: the reference storage format
    +@@ Documentation/git-repo.adoc: In order to obtain a set of values from `git repo info`, you should provide
    + the keys that identify them. Here's a list of the available keys and the
    + values that they return:

    -+`layout`::
    -+Information about the how the current repository is represented:
    -+* `bare`: `true` if this is a bare repository, otherwise `false`.
    ++`layout.bare`::
    ++`true` if this is a bare repository, otherwise `false`.
     +
    - SEE ALSO
    - --------
    - linkgit:git-rev-parse[1]
    + `references.format`::
    + The reference storage format. The valid values are:
    + +

      ## builtin/repo.c ##
     @@
    @@ builtin/repo.c
      #include "builtin.h"
     +#include "environment.h"
      #include "parse-options.h"
    + #include "quote.h"
      #include "refs.h"
    - #include "strbuf.h"
     @@ builtin/repo.c: struct field {
      	get_value_fn *get_value;
      };
    @@ builtin/repo.c: static int get_references_format(struct repository *repo, struct
      ## t/t1900-repo.sh ##
     @@ t/t1900-repo.sh: test_repo_info 'ref format files is retrieved correctly' '
      test_repo_info 'ref format reftable is retrieved correctly' '
    - 	git init --ref-format=reftable repo' 'references.format' 'reftable'
    + 	git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'

     +test_repo_info 'bare repository = false is retrieved correctly' '
    -+	git init repo' 'layout.bare' 'false'
    ++	git init' 'bare' 'layout.bare' 'false'
     +
     +test_repo_info 'bare repository = true is retrieved correctly' '
    -+	git init --bare repo' 'layout.bare' 'true'
    ++	git init --bare' 'nonbare' 'layout.bare' 'true'
     +
    - test_expect_success 'git-repo-info aborts if an invalid key is requested' '
    - 	test_when_finished "rm -rf expected err" &&
    - 	echo "error: key '\'foo\'' not found" >expected &&
    + test_expect_success 'git-repo-info fails if an invalid key is requested' '
    + 	echo "error: key '\'foo\'' not found" >expected_err &&
    + 	test_must_fail git repo info foo 2>actual_err &&
    +@@ t/t1900-repo.sh: test_expect_success 'only one value is returned if the same key is requested twi
    + 	test_cmp expect actual
    + '
    +
    ++test_expect_success 'output is returned correctly when two keys are requested' '
    ++	cat >expect <<-\EOF &&
    ++	layout.bare=false
    ++	references.format=files
    ++	EOF
    ++	git init --ref-format=files two-keys &&
    ++	git -C two-keys repo info layout.bare references.format
    ++'
    + test_done
4:  fa17719ebc ! 4:  f35704442a repo: add field layout.shallow
    @@ Metadata
     Author: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>

      ## Commit message ##
    -    repo: add field layout.shallow
    +    repo: add the field layout.shallow

         This commit is part of the series that introduces the new subcommand
         git-repo-info.
    @@ Commit message
         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Helped-by: Justin Tobler <jltobler@gmail.com>
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>

      ## Documentation/git-repo.adoc ##
    -@@ Documentation/git-repo.adoc: Reference-related data:
    - `layout`::
    - Information about the how the current repository is represented:
    - * `bare`: `true` if this is a bare repository, otherwise `false`.
    -+* `shallow`: `true` if this is a shallow repository, otherwise `false`.
    +@@ Documentation/git-repo.adoc: values that they return:
    + `layout.bare`::
    + `true` if this is a bare repository, otherwise `false`.

    - SEE ALSO
    - --------
    ++`layout.shallow`::
    ++`true` if this is a shallow repository, otherwise `false`.
    ++
    + `references.format`::
    + The reference storage format. The valid values are:
    + +

      ## builtin/repo.c ##
     @@
    - #include "parse-options.h"
    + #include "quote.h"
      #include "refs.h"
      #include "strbuf.h"
     +#include "shallow.h"

    - typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
    -
    + static const char *const repo_usage[] = {
    + 	"git repo info [<key>...]",
     @@ builtin/repo.c: static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
      	return 0;
      }
    @@ builtin/repo.c: static int get_references_format(struct repository *repo, struct
      ## t/t1900-repo.sh ##
     @@ t/t1900-repo.sh: test_repo_info 'bare repository = false is retrieved correctly' '
      test_repo_info 'bare repository = true is retrieved correctly' '
    - 	git init --bare repo' 'layout.bare' 'true'
    + 	git init --bare' 'nonbare' 'layout.bare' 'true'

     +test_repo_info 'shallow repository = false is retrieved correctly' '
    -+	git init repo' 'layout.shallow' 'false'
    ++	git init' 'nonshallow' 'layout.shallow' 'false'
     +
     +test_repo_info 'shallow repository = true is retrieved correctly' '
     +	git init remote &&
    -+	cd remote &&
    -+	echo x >x &&
    -+	git add x &&
    -+	git commit -m x &&
    -+	cd .. &&
    -+	git clone --depth 1 "file://$PWD/remote" repo &&
    -+	rm -rf remote
    -+	' 'layout.shallow' 'true'
    ++	echo x >remote/x &&
    ++	git -C remote add x &&
    ++	git -C remote commit -m x &&
    ++	git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
     +
    - test_expect_success 'git-repo-info aborts if an invalid key is requested' '
    - 	test_when_finished "rm -rf expected err" &&
    - 	echo "error: key '\'foo\'' not found" >expected &&
    -@@ t/t1900-repo.sh: test_expect_success "only one value is returned if the same key is requested twi
    -         test_cmp expected_value actual_value
    + test_expect_success 'git-repo-info fails if an invalid key is requested' '
    + 	echo "error: key '\'foo\'' not found" >expected_err &&
    + 	test_must_fail git repo info foo 2>actual_err &&
    +@@ t/t1900-repo.sh: test_expect_success 'output is returned correctly when two keys are requested' '
    + 	git init --ref-format=files two-keys &&
    + 	git -C two-keys repo info layout.bare references.format
      '
    -
    -+test_expect_success 'output is returned correctly when two keys are requested' '
    -+	test_when_finished "rm -f expect" &&
    -+	printf "layout.bare=false\nlayout.shallow=false\n" >expect &&
    -+	git repo info layout.shallow layout.bare >actual &&
    -+	test_cmp expect actual
    -+'
     +
      test_done
5:  b72a61b73b ! 5:  8931b12eca repo: add the --format flag
    @@ Commit message
         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Helped-by: Justin Tobler <jltobler@gmail.com>
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
    @@ Documentation/git-repo.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHAN
      COMMANDS
      --------
     -`info [<key>...]`::
    -+`info [--format=<format>] [<key>...]`::
    ++`info [--format=<keyvalue|nul>] [<key>...]`::
      	Retrieve metadata-related information about the current repository. Only
      	the requested data will be returned based on their keys (see "INFO KEYS"
      	section below).
    + +
    + The returned data is lexicographically sorted by the keys.
     ++
     +The output format can be chosen through the flag `--format`. Two formats are
     +supported:
    @@ Documentation/git-repo.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHAN

      INFO KEYS
      ---------
    +@@ Documentation/git-repo.adoc: The reference storage format. The valid values are:
    + +
    + include::ref-storage-format.adoc[]
    +
    ++
    ++Examples
    ++--------
    ++
    ++* Retrieves the reference format of the current repository:
    +++
    ++------------
    ++git repo info references.format
    ++------------
    +++
    ++
    ++* Retrieves whether the current repository is bare and whether it is shallow
    ++using the `nul` format:
    +++
    ++------------
    ++git repo info --format=nul layout.bare layout.shallow
    ++------------
    ++
    + SEE ALSO
    + --------
    + linkgit:git-rev-parse[1]

      ## builtin/repo.c ##
     @@
    + #include "shallow.h"
    +
    + static const char *const repo_usage[] = {
    +-	"git repo info [<key>...]",
    ++	"git repo info [--format=<keyvalue|nul>] [<key>...]",
    + 	NULL
    + };

      typedef int get_value_fn(struct repository *repo, struct strbuf *buf);

    @@ builtin/repo.c: static int qsort_strcmp(const void *va, const void *vb)
     +			struct repository *repo,
     +			enum output_format format)
      {
    + 	int ret = 0;
      	const char *last = "";
    + 	struct strbuf sb = STRBUF_INIT;
    +
     +	char kv_sep;
     +	char field_sep;
     +
    @@ builtin/repo.c: static int qsort_strcmp(const void *va, const void *vb)
     +		field_sep = '\0';
     +		break;
     +	}
    -
    ++
      	QSORT(argv, argc, qsort_strcmp);

    + 	for (int i = 0; i < argc; i++) {
    + 		get_value_fn *get_value;
    + 		const char *key = argv[i];
    +-		char *value;
    +
    + 		if (!strcmp(key, last))
    + 			continue;
     @@ builtin/repo.c: static int print_fields(int argc, const char **argv, struct repository *repo)
    - 		}
    + 		strbuf_reset(&sb);
    + 		get_value(repo, &sb);
    +
    +-		value = strbuf_detach(&sb, NULL);
    +-		quote_c_style(value, &sb, NULL, 0);
    +-		free(value);
    ++		if (format == FORMAT_KEYVALUE) {
    ++			char *value;
    ++			value = strbuf_detach(&sb, NULL);
    ++			quote_c_style(value, &sb, NULL, 0);
    ++			free(value);
    ++		}

    - 		get_value(repo, &value);
    --		printf("%s=%s\n", key, value.buf);
    -+		printf("%s%c%s%c", key, kv_sep, value.buf, field_sep);
    +-		printf("%s=%s\n", key, sb.buf);
    ++		printf("%s%c%s%c", key, kv_sep, sb.buf, field_sep);
      		last = key;
    - 		strbuf_release(&value);
      	}
    +
     @@ builtin/repo.c: static int print_fields(int argc, const char **argv, struct repository *repo)
    - 	return 0;
    + 	return ret;
      }

     -static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
    @@ builtin/repo.c: static int print_fields(int argc, const char **argv, struct repo
     -	return print_fields(argc - 1, argv + 1, repo);
     +	const char *format_str = "keyvalue";
     +	enum output_format format;
    -+	const char *const repo_info_usage[] = {
    -+		"git repo info [<key>...]",
    -+		NULL
    -+	};
     +	struct option options[] = {
     +		OPT_STRING(0, "format", &format_str, N_("format"),
     +			   N_("output format")),
     +		OPT_END()
     +	};
     +
    -+	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);
    ++	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
     +
     +	if (!strcmp(format_str, "keyvalue"))
     +		format = FORMAT_KEYVALUE;
    @@ builtin/repo.c: static int print_fields(int argc, const char **argv, struct repo

      ## t/t1900-repo.sh ##
     @@ t/t1900-repo.sh: test_repo_info () {
    - 	key=$3
    - 	expected_value=$4
    + 	key=$4
    + 	expected_value=$5

     -	test_expect_success "$label" '
    -+	test_expect_success "null-terminated: $label" '
    -+		test_when_finished "rm -rf repo" &&
    -+		eval "$init_command" &&
    -+		echo "$expected_value" | lf_to_nul >expected &&
    -+		git -C repo repo info --format=nul "$key" >output &&
    -+		tail -n 1 output >actual &&
    +-		eval "$init_command $repo_name" &&
    ++	test_expect_success "keyvalue: $label" '
    ++		eval "$init_command keyvalue-$repo_name" &&
    + 		echo "$key=$expected_value" >expected &&
    +-		git -C $repo_name repo info "$key" >actual &&
    ++		git -C keyvalue-$repo_name repo info "$key" >actual &&
     +		test_cmp expected actual
     +	'
     +
    -+	test_expect_success "key-value: $label" '
    - 		test_when_finished "rm -rf repo" &&
    - 		eval "$init_command" &&
    - 		echo "$expected_value" >expected &&
    --		git -C repo repo info "$key" >output &&
    -+		git -C repo repo info --format=keyvalue "$key" >output &&
    - 		cut -d "=" -f 2 <output >actual &&
    ++	test_expect_success "nul: $label" '
    ++		eval "$init_command nul-$repo_name" &&
    ++		printf "%s\n%s\0" "$key" "$expected_value" >expected &&
    ++		git -C nul-$repo_name repo info --format=nul "$key" >actual &&
      		test_cmp expected actual
      	'
    + }
    +@@ t/t1900-repo.sh: test_repo_info 'shallow repository = false is retrieved correctly' '
    + 	git init' 'nonshallow' 'layout.shallow' 'false'
    +
    + test_repo_info 'shallow repository = true is retrieved correctly' '
    ++	test_when_finished "rm -rf remote" &&
    + 	git init remote &&
    + 	echo x >remote/x &&
    + 	git -C remote add x &&
     @@ t/t1900-repo.sh: test_expect_success 'output is returned correctly when two keys are requested' '
    - 	test_cmp expect actual
    + 	git -C two-keys repo info layout.bare references.format
      '

     +test_expect_success 'git-repo-info aborts when requesting an invalid format' '

Lucas Seiki Oshiro (5):
  repo: declare the repo command
  repo: add the field references.format
  repo: add the field layout.bare
  repo: add the field layout.shallow
  repo: add the --format flag

 .gitignore                  |   1 +
 Documentation/git-repo.adoc |  81 +++++++++++++++++
 Documentation/meson.build   |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/repo.c              | 173 ++++++++++++++++++++++++++++++++++++
 command-list.txt            |   1 +
 git.c                       |   1 +
 meson.build                 |   1 +
 t/meson.build               |   1 +
 t/t1900-repo.sh             |  97 ++++++++++++++++++++
 11 files changed, 359 insertions(+)
 create mode 100644 Documentation/git-repo.adoc
 create mode 100644 builtin/repo.c
 create mode 100755 t/t1900-repo.sh

-- 
2.39.5 (Apple Git-154)

