Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45556149DF0
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271798; cv=none; b=rmiIpoLRUtFfV2SwZTQ5xMVoz2nWlhLTJTBsJxpad/To98h0AZvOT9XtnS7pd2lgxI7QUvo8/pGzxokU6pHIHZjueIbQVoxr1Jgcz7zwVLdW8HmuodVENPFK2NfZFGUiWR3MqCx1kbmB7sCBCGzJy0BoGiIHlX9K4EVXufK3/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271798; c=relaxed/simple;
	bh=P58Hbfcl7fKWtXi1Z4PMq4w4cT0dY5IFczEQidsVSao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTynzY0SvK0/R5YwiT6tdSfc65KF+2vXgI22u54NhfcdqW8qR7N7EVSEz8rdSi4m40wn8qi1UMKpSw+MC5DAWnqHBN6Y76c7wLdVGLWlBtiKmuU9rtDL5b2FrvzNZkoRttoaloZTGhwGOHKCyH9y5gsWAMklsjQfDoFtmxaYXYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTAJbTNn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTAJbTNn"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso988258a91.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741271795; x=1741876595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1QTZG2XgD/1DB+3AsgPaTOWKhVTTBg+G1MRe+UmUQI=;
        b=kTAJbTNnbxa8lUv4JigzUY4Ox/ujhVGKA3bmUKv61ZMeL7AvLDUlT3oJVZmnYwcdVH
         0eWgJFqSZ+FL/TRBJ4tpQwpAuHEKY6feteeTBnhIohaTz8/szNacoNRFYkHst8yZi7fX
         i/q+GRj1c/q5joycl/+eRAlKwPcuD+BnJOwLeA7PZgy4KOKLWT/WZKXichdWaGdlXOTd
         gqNi0BZwMlhlTN7rZ3epfUd3jbcjAtsjzAtRui3h5JnUsp1l+rq8TIVYhVKjxOMIhcjo
         fqA5Uh2LS4wkGzRylh9tBGDZZAs9OY5Q2wsAKOX3p9Q0hTHZ0705hAnm+EmjibbBz3HO
         V+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271795; x=1741876595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1QTZG2XgD/1DB+3AsgPaTOWKhVTTBg+G1MRe+UmUQI=;
        b=gp8olRx8VmDs4SgFkN2h3vOy1+P2iYFn8CRuRAiwLrMEsJ5ZRy5Y/E8lgSnnH90FaN
         r09DqLgNVWmZuJYezD4H4vMIBTS3Llr1PSs/093Wn4PaTs6QuVkaaN+P4QZ4q1p+DiCa
         ivKzkRar2cDo/GfZTzbAYA2QIH7BzFgz2uUf2Ygqi0VgtQFhN/ktDr4mGSlHP8UCFOF7
         kmhufkb8EVMumUcbzWhEGdmHIqC8x92c+xTCc6+wz9/ncG2EBWUyGAFJ6+E7YIe+uGUW
         ele2IH+2KaiKK87I+c0CQ17ne6bSkpyBDg1gY03Q5rQmT0xVb+0bJxrx6eQdzTWcjCUF
         iQ2Q==
X-Gm-Message-State: AOJu0YwzWvJQmqhni+Ac5PB30H1pk6bl+ggkMW0RqTPYSi8gcLCOoLuP
	Uz/5kD5Fwt7sBvxcvzAUTub9J80UhcLRborihGEJwvYRw6WGIFGeiiqnd419
X-Gm-Gg: ASbGncs7JUk4APXGoOiYeSnd4m8W5KE0aKbtgUysgetFqy24YEsdl0hzpVFPPPBlEzf
	YXDGMCmGBCZqSokzamZW9mSnCddXQIDEAW+Dc8iG1vhJ6qmj/Pe4/W10NP25qqAUSi7LRbVFxjd
	MBPaoWwxWupobR6+RLR6V/idGFNOPKpU8yyZvlMQHFCdkztXQG7vptV1OJnDlrXcD9o4gEYAtfy
	uFeqxtHOSbNARgcD8g2FrviDxym1J6VhChkYc+p/iuMAZp2t6w4KDkPJMdVZd6/Vwi7zejhK19o
	DWd5FZM6eS445anLqN7jliqMZ68qPOis99CXwSbmkg0IT9MpO3ybzm3XnBbd3bMPLihe8w==
X-Google-Smtp-Source: AGHT+IFBHNbSltI43tww4ENOOjfqQpse1DaVYiRZ2emibLbgrWhd6v/r+OVHjqTGf08L0VuioBcDfA==
X-Received: by 2002:a17:90b:2b83:b0:2ee:db8a:2a01 with SMTP id 98e67ed59e1d1-2ff4981f6f2mr11146882a91.30.1741271794764;
        Thu, 06 Mar 2025 06:36:34 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff944sm3561184a91.34.2025.03.06.06.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:36:34 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [Outreachy PATCH v3 0/8] stop using the_repository global variable.
Date: Thu,  6 Mar 2025 20:05:44 +0530
Message-ID: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove `the_repository` global variable in favor of the repository
argument that gets passed in builtin commands. 

These sets of commands are commands that use only RUN_SETUP macro in "git.c".
Basically, When `-h` is passed to any of this command outside a Git repository,
the `run_builtin()` will call the `cmd_x()` function (where `x` is any
of the command from the sets of builtin commands that `the_repository` is removed
from) with `repo` set to NULL and then early in the function, `parse_options()`
or show_usage_with_options_if_asked() call will give the options help
and exit.

Some, functions also uses `the_repository` global internally, so, let's
let's refactor them and pass `struct repo` as one of the argument. 

As the `repo` value can be NULL if a builtin command is run outside
any repository. The current implementation of `repo_config()` will
fail if `repo` is NULL.
If the `repo` is NULL, the `repo_config()` can ignore the repository
configuration but it should read the other configuration sources like
the system-side configuration instead of failing.

Teach the `repo_config()` to allow `repo` to be NULL by calling the
`read_very_early_config()` which read config but only enumerate system
and global settings. This make it possible for us to savely replace
`git_config()` with `repo_config()`.

Changes since v2
================
- Remove preparatory patches that move the `git_config()` below the
`usage_with_options()`.
- Add a new preparatory patch that teach the `repo_config()` to accept
NULL value for `repo` variable.
- Add tests to each of the builtin function in this commit to ensure
`repo_config()` works as expected.
- Make changes to the commit messages. 

Usman Akinyemi (8):
  config: teach repo_config to allow `repo` to be NULL
  builtin/verify-tag: stop using `the_repository`
  builtin/verify-commit: stop using `the_repository`
  builtin/send-pack: stop using `the_repository`
  builtin/pack-refs: stop using `the_repository`
  builtin/ls-files: stop using `the_repository`
  builtin/for-each-ref: stop using `the_repository`
  builtin/checkout-index: stop using `the_repository`

 builtin/checkout-index.c        | 43 ++++++++++++++++-----------------
 builtin/for-each-ref.c          |  5 ++--
 builtin/ls-files.c              | 32 ++++++++++++------------
 builtin/pack-refs.c             |  8 +++---
 builtin/send-pack.c             |  7 +++---
 builtin/verify-commit.c         | 13 +++++-----
 builtin/verify-tag.c            |  7 +++---
 config.c                        |  4 +++
 config.h                        |  3 +++
 t/t0610-reftable-basics.sh      |  7 ++++++
 t/t2006-checkout-index-basic.sh |  7 ++++++
 t/t3004-ls-files-basic.sh       |  7 ++++++
 t/t5400-send-pack.sh            |  7 ++++++
 t/t6300-for-each-ref.sh         |  7 ++++++
 t/t7030-verify-tag.sh           |  7 ++++++
 t/t7510-signed-commit.sh        |  7 ++++++
 16 files changed, 110 insertions(+), 61 deletions(-)

Range-diff versus v2:

 1:  a313f9afb7 <  -:  ---------- builtin/verify-tag: refactor `cmd_verify_tag()`
 -:  ---------- >  1:  a5c69f3753 config: teach repo_config to allow `repo` to be NULL
 2:  f993160d90 !  2:  dfa0da4061 builtin/verify-tag: stop using `the_repository`
    @@ Commit message
         When `-h` is passed to the command outside a Git repository, the
         `run_builtin()` will call the `cmd_verify_tag()` function with `repo` set
         to NULL and then early in the function, `parse_options()` call will give
    -    the options help and exit, without having to consult much of the
    -    configuration file.
    +    the options help and exit.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
    @@ builtin/verify-tag.c: static const char * const verify_tag_usage[] = {
      	int i = 1, verbose = 0, had_error = 0;
      	unsigned flags = 0;
     @@ builtin/verify-tag.c: int cmd_verify_tag(int argc,
    - 		flags |= GPG_VERIFY_OMIT_STATUS;
    - 	}
    + 		OPT_END()
    + 	};
      
     -	git_config(git_default_config, NULL);
     +	repo_config(repo, git_default_config, NULL);
      
    - 	while (i < argc) {
    + 	argc = parse_options(argc, argv, prefix, verify_tag_options,
    + 			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
    +@@ builtin/verify-tag.c: int cmd_verify_tag(int argc,
      		struct object_id oid;
      		const char *name = argv[i++];
      
    @@ builtin/verify-tag.c: int cmd_verify_tag(int argc,
      			had_error = !!error("tag '%s' not found.", name);
      			continue;
      		}
    +
    + ## t/t7030-verify-tag.sh ##
    +@@ t/t7030-verify-tag.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + . ./test-lib.sh
    + . "$TEST_DIRECTORY/lib-gpg.sh"
    + 
    ++test_expect_success GPG 'verify-tag does not crash with -h' '
    ++	test_expect_code 129 git verify-tag -h >usage &&
    ++	test_grep "[Uu]sage: git verify-tag " usage &&
    ++	test_expect_code 129 nongit git verify-tag -h >usage &&
    ++	test_grep "[Uu]sage: git verify-tag " usage
    ++'
    ++
    + test_expect_success GPG 'create signed tags' '
    + 	echo 1 >file && git add file &&
    + 	test_tick && git commit -m initial &&
 3:  f2f785190d <  -:  ---------- builtin/verify-commit: refactor `cmd_verify_commit()`
 4:  5f8dc0c0ec !  3:  ade2d026cb builtin/verify-commit: stop using `the_repository`
    @@ Commit message
         When `-h` is passed to the command outside a Git repository, the
         `run_builtin()` will call the `cmd_verify_commit()` function with `repo`
         set to NULL and then early in the function, `parse_options()` call will
    -    give the options help and exit, without having to consult much of the
    -    configuration file.
    +    give the options help and exit.
     
         Pass the repository available in the calling context to `verify_commit()`
         to remove it's dependency on the global `the_repository` variable.
    @@ builtin/verify-commit.c: static int verify_commit(const char *name, unsigned fla
      	int i = 1, verbose = 0, had_error = 0;
      	unsigned flags = 0;
     @@ builtin/verify-commit.c: int cmd_verify_commit(int argc,
    - 	if (verbose)
    - 		flags |= GPG_VERIFY_VERBOSE;
    + 		OPT_END()
    + 	};
      
     -	git_config(git_default_config, NULL);
     +	repo_config(repo, git_default_config, NULL);
      
    - 	/* sometimes the program was terminated because this signal
    + 	argc = parse_options(argc, argv, prefix, verify_commit_options,
    + 			     verify_commit_usage, PARSE_OPT_KEEP_ARGV0);
    +@@ builtin/verify-commit.c: int cmd_verify_commit(int argc,
      	 * was received in the process of writing the gpg input: */
      	signal(SIGPIPE, SIG_IGN);
      	while (i < argc)
    @@ builtin/verify-commit.c: int cmd_verify_commit(int argc,
      			had_error = 1;
      	return had_error;
      }
    +
    + ## t/t7510-signed-commit.sh ##
    +@@ t/t7510-signed-commit.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + GNUPGHOME_NOT_USED=$GNUPGHOME
    + . "$TEST_DIRECTORY/lib-gpg.sh"
    + 
    ++test_expect_success GPG 'verify-commit does not crash with -h' '
    ++	test_expect_code 129 git verify-commit -h >usage &&
    ++	test_grep "[Uu]sage: git verify-commit " usage &&
    ++	test_expect_code 129 nongit git verify-commit -h >usage &&
    ++	test_grep "[Uu]sage: git verify-commit " usage
    ++'
    ++
    + test_expect_success GPG 'create signed commits' '
    + 	test_oid_cache <<-\EOF &&
    + 	header sha1:gpgsig
 5:  d79c3fc1ee <  -:  ---------- builtin/send-pack: refactor `cmd_send_pack()`
 6:  f280a9c387 !  4:  e3b58bc6cf builtin/send-pack: stop using `the_repository`
    @@ Commit message
         When `-h` is passed to the command outside a Git repository, the
         `run_builtin()` will call the `cmd_send_pack()` function with `repo` set
         to NULL and then early in the function, `parse_options()` call will give
    -    the options help and exit, without having to consult much of the
    -    configuration file.
    +    the options help and exit.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
    @@ builtin/send-pack.c: static int send_pack_config(const char *k, const char *v,
      	struct refspec rs = REFSPEC_INIT_PUSH;
      	const char *remote_name = NULL;
     @@ builtin/send-pack.c: int cmd_send_pack(int argc,
    - 	if (!dest)
    - 		usage_with_options(send_pack_usage, options);
    + 		OPT_END()
    + 	};
      
     -	git_config(send_pack_config, NULL);
     +	repo_config(repo, send_pack_config, NULL);
    - 
    - 	args.verbose = verbose;
    - 	args.dry_run = dry_run;
    + 	argc = parse_options(argc, argv, prefix, options, send_pack_usage, 0);
    + 	if (argc > 0) {
    + 		dest = argv[0];
     @@ builtin/send-pack.c: int cmd_send_pack(int argc,
      	set_ref_status_for_push(remote_refs, args.send_mirror,
      		args.force_update);
    @@ builtin/send-pack.c: int cmd_send_pack(int argc,
      
      	if (helper_status)
      		print_helper_status(remote_refs);
    +
    + ## t/t5400-send-pack.sh ##
    +@@ t/t5400-send-pack.sh: test_expect_success setup '
    + 	echo Rebase &&
    + 	git log'
    + 
    ++test_expect_success 'send-pack does not crash with -h' '
    ++	test_expect_code 129 git send-pack -h >usage &&
    ++	test_grep "[Uu]sage: git send-pack " usage &&
    ++	test_expect_code 129 nongit git send-pack -h >usage &&
    ++	test_grep "[Uu]sage: git send-pack " usage
    ++'
    ++
    + test_expect_success 'pack the source repository' '
    + 	git repack -a -d &&
    + 	git prune
 7:  df192a1b2c <  -:  ---------- builtin/pack-refs: refactor `cmd_pack_refs()`
 8:  845cd1ea7c !  5:  b11e99627c builtin/pack-refs: stop using `the_repository`
    @@ Commit message
         When `-h` is passed to the command outside a Git repository, the
         `run_builtin()` will call the `cmd_pack_refs()` function with `repo` set
         to NULL and then early in the function, `parse_options()` call will give
    -    the options help and exit, without having to consult much of the
    -    configuration file.
    +    the options help and exit.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
    @@ builtin/pack-refs.c: static char const * const pack_refs_usage[] = {
      	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
      	struct string_list included_refs = STRING_LIST_INIT_NODUP;
     @@ builtin/pack-refs.c: int cmd_pack_refs(int argc,
    - 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
    - 		usage_with_options(pack_refs_usage, opts);
    - 
    + 			N_("references to exclude")),
    + 		OPT_END(),
    + 	};
     -	git_config(git_default_config, NULL);
     +	repo_config(repo, git_default_config, NULL);
    - 	for_each_string_list_item(item, &option_excluded_refs)
    - 		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
    + 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
    + 		usage_with_options(pack_refs_usage, opts);
      
     @@ builtin/pack-refs.c: int cmd_pack_refs(int argc,
      	if (!pack_refs_opts.includes->nr)
    @@ builtin/pack-refs.c: int cmd_pack_refs(int argc,
      
      	clear_ref_exclusions(&excludes);
      	string_list_clear(&included_refs, 0);
    +
    + ## t/t0610-reftable-basics.sh ##
    +@@ t/t0610-reftable-basics.sh: export GIT_TEST_DEFAULT_REF_FORMAT
    + 
    + INVALID_OID=$(test_oid 001)
    + 
    ++test_expect_success 'pack-refs does not crash with -h' '
    ++	test_expect_code 129 git pack-refs -h >usage &&
    ++	test_grep "[Uu]sage: git pack-refs " usage &&
    ++	test_expect_code 129 nongit git pack-refs -h >usage &&
    ++	test_grep "[Uu]sage: git pack-refs " usage
    ++'
    ++
    + test_expect_success 'init: creates basic reftable structures' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
 9:  2aff17b09c !  6:  51c80f9273 builtin/ls-files: stop using `the_repository`
    @@ Commit message
         When `-h` is passed to the command outside a Git repository, the
         `run_builtin()` will call the `cmd_ls_files()` function with `repo` set
         to NULL and then early in the function, `show_usage_with_options_if_asked()`
    -    call will give the options help and exit, without having to consult much
    -    of the configuration file.
    +    call will give the options help and exit.
     
         Pass the repository available in the calling context to both
         `expand_objectsize()` and `show_ru_info()` to remove their
    @@ builtin/ls-files.c: int cmd_ls_files(int argc,
      
      	if (ps_matched && report_path_error(ps_matched, &pathspec)) {
      		fprintf(stderr, "Did you forget to 'git add'?\n");
    +
    + ## t/t3004-ls-files-basic.sh ##
    +@@ t/t3004-ls-files-basic.sh: test_expect_success 'ls-files -h in corrupt repository' '
    + 	test_grep "[Uu]sage: git ls-files " broken/usage
    + '
    + 
    ++test_expect_success 'ls-files does not crash with -h' '
    ++	test_expect_code 129 git ls-files -h >usage &&
    ++	test_grep "[Uu]sage: git ls-files " usage &&
    ++	test_expect_code 129 nongit git ls-files -h >usage &&
    ++	test_grep "[Uu]sage: git ls-files " usage
    ++'
    ++
    + test_expect_success SYMLINKS 'ls-files with absolute paths to symlinks' '
    + 	mkdir subs &&
    + 	ln -s nosuch link &&
10:  4cc9a4935a <  -:  ---------- builtin/for-each-ref: refactor `cmd_for_each_ref()`
11:  42c1a7ae74 !  7:  63bb89291f builtin/for-each-ref: stop using `the_repository`
    @@ Commit message
         When `-h` is passed to the command outside a Git repository, the
         `run_builtin()` will call the `cmd_for_each_ref()` function with `repo`
         set to NULL and then early in the function, `parse_options()` call will
    -    give the options help and exit, without having to consult much of the
    -    configuration file.
    +    give the options help and exit.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
    @@ builtin/for-each-ref.c: static char const * const for_each_ref_usage[] = {
      	struct ref_sorting *sorting;
      	struct string_list sorting_options = STRING_LIST_INIT_DUP;
     @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc,
    - 	if (verify_ref_format(&format))
    - 		usage_with_options(for_each_ref_usage, opts);
    + 
    + 	format.format = "%(objectname) %(objecttype)\t%(refname)";
      
     -	git_config(git_default_config, NULL);
     +	repo_config(repo, git_default_config, NULL);
    - 	sorting = ref_sorting_options(&sorting_options);
    - 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
    - 	filter.ignore_case = icase;
    + 
    + 	/* Set default (refname) sorting */
    + 	string_list_append(&sorting_options, "refname");
    +
    + ## t/t6300-for-each-ref.sh ##
    +@@ t/t6300-for-each-ref.sh: test_expect_success 'Check invalid atoms names are errors' '
    + 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
    + '
    + 
    ++test_expect_success 'for-each-ref does not crash with -h' '
    ++	test_expect_code 129 git for-each-ref -h >usage &&
    ++	test_grep "[Uu]sage: git for-each-ref " usage &&
    ++	test_expect_code 129 nongit git for-each-ref -h >usage &&
    ++	test_grep "[Uu]sage: git for-each-ref " usage
    ++'
    ++
    + test_expect_success 'Check format specifiers are ignored in naming date atoms' '
    + 	git for-each-ref --format="%(authordate)" refs/heads &&
    + 	git for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
12:  232cbef160 !  8:  8dfe6b40c8 builtin/checkout-index: stop using `the_repository`
    @@ Commit message
         When `-h` is passed to the command outside a Git repository, the
         `run_builtin()` will call the `cmd_checkout_index()` function with `repo`
         set to NULL and then early in the function, `show_usage_with_options_if_asked()`
    -    call will give the options help and exit, without having to consult much
    -    of the configuration file.
    +    call will give the options help and exit.
     
         Pass the repository available in the calling context to both `checkout_all()`
         and `checkout_file()` to remove their dependency on the global
    @@ builtin/checkout-index.c: int cmd_checkout_index(int argc,
      		die("Unable to write new index file");
      	return 0;
      }
    +
    + ## t/t2006-checkout-index-basic.sh ##
    +@@ t/t2006-checkout-index-basic.sh: test_expect_success 'checkout-index -h in broken repository' '
    + 	test_grep "[Uu]sage" broken/usage
    + '
    + 
    ++test_expect_success 'checkout-index does not crash with -h' '
    ++	test_expect_code 129 git checkout-index -h >usage &&
    ++	test_grep "[Uu]sage: git checkout-index " usage &&
    ++	test_expect_code 129 nongit git checkout-index -h >usage &&
    ++	test_grep "[Uu]sage: git checkout-index " usage
    ++'
    ++
    + test_expect_success 'checkout-index reports errors (cmdline)' '
    + 	test_must_fail git checkout-index -- does-not-exist 2>stderr &&
    + 	test_grep not.in.the.cache stderr

-- 
2.48.1

