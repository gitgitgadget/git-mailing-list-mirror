Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA4207A0B
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759095016; cv=none; b=jbVeAeW4UDy75YWjVxpPLu17JLPqQ5PBC5f+tLRa/SwAUHuSPYYxEGv+htBHcBd9PwCG1jbmeRvgerAG6xs21ik/Ot/KoXO4qbeeAR4/m/2GEMedEm9mJLrAy1oEsJCVII4C3CTzbKMquSmnUGcdqseGPHIrnsBtOigyNkrR+lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759095016; c=relaxed/simple;
	bh=VYeJtCA8B7f1qxjxIhPCZvkRaaRfzz7Lc2Z+5HHC+Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qg1cS5IorhmdhkCCKtjRIRSEHSRNksECw29Oy2fi3pp8tV/d1U6VHIWsNxmXxo2fEnR0hfp9e47FA0dWRdJuJZrQdgSlr/TmyplxLXgtbO2ig/ddfbjuRjOsAwn2FTNbzQ+ZfkMzGrlw0d9/5vqraxF89zawz5Of53ldF8vwC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnzlNnrj; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnzlNnrj"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-76c144b06fdso33749377b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 14:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759095013; x=1759699813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KoXgkummiHJw5F1C//BfmqLhKaNzvqJ6N1fjXm17nc=;
        b=NnzlNnrj4RxZtDKEpdS4AqhAXKFsxyvkLtU7PYjb3QzhbG40EgB8W3H3PjrOR1ovLv
         NV4+EFQbV6KPjjo/3eV3bmsgFaN3Cw+ByBGiKv8EARWV5Z7At60iJUD/bbLH/yfB211y
         zlaO+MwzIa0fCxaVZ32f5jCfSmBm2rM0tUsdlcF5SzWIGfrtmUsWOVzXK73p2K2tvcqC
         oCzVlO8DEGhoORQXDlNzOZ/kwOaXJdcPJ4IfcBxzn/2vBA5EeIsyiad9TEKPWt51Yoei
         vg9j+0xSKXOxMGdOCRKE0UBMdIKsxwdkju+YchtIn4oAU4fQmmQJ6tQCs6IcH2T8JSGu
         g2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759095013; x=1759699813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1KoXgkummiHJw5F1C//BfmqLhKaNzvqJ6N1fjXm17nc=;
        b=wG3gYioiezXOLvwVD/Ad3z0sd+3iQ2CI/k5gMuv2mulXGSQfZnX5U7A59lmxSOQlgo
         9ZndmTi3md5BPbxtI7TsX3KHbGicSjS8d/cZNGzo6hSf0M78AbmhF7xmLVtAu3aO/610
         hi4n4bYX+1vo4BCj4ut14+AjoO4smqX2PDmms1b9BS9aWPeR76b0C+EolRKZnsMRQfrF
         DkD2Z6B02otBK8K8ffQwG1tuYTXFWb56sVFqU08VxCKNrnHm4xgLXtOepZjLfP1Uuq7a
         8tYhblQYlR9KlGj8QwWhsDccH/xToMgKIdbMth1b7j04/VmNcfymzekqJj1Kz3GHH4IW
         tY2Q==
X-Gm-Message-State: AOJu0Yw2L+Fv1LbggYlXX9RVX+9CWRMMYDxqE5iUIR6AYUUWpCFm9Aml
	GSnJ25I86e+yw6o9FLTJQaNZEnLoO7jIOZPsjUqHVfwqPOWNOwZJk7dZzONtOSao
X-Gm-Gg: ASbGnctgRCa9bxYnhxq19pdicT3pk7ikGKjBUSW6KuECsSwQEbGjcYfLWaThtQrVgUc
	DneNOBpHVhInYo560w2VZypOVzAVV/jx9vUKfvS5iAZVxrwGCJqeaPTgaja627LYzFIax+L/qaC
	QDUtYvgvPun7Oj4sj7sy4DpyvENWi6Ut9uQhqk3Cqv23LTcyHBBi6YJ9Efa3ThPJMpGlAlzYV5V
	SuPODcYTJV4E2a9+y+o+cjQ773oOkWgidJqwCcnPS82i/Rzzw2qXTxNzIAN3P5oM2YxqHAX+Uki
	HrDHLaC73UlX3DURpTKhmom4NEg4YGYphVT+6cItcjKTNf2MiZPg5+rDSv19KoxvC3i8RzsOj0N
	wto00j5T4vIYekvbPVuPASc9nhy/15SstDZs0Tsu2KhH0CyUPQ1LgNI8Q3R4+rQJbB44DAWs=
X-Google-Smtp-Source: AGHT+IHvhvN4pbQUyChK4J4znPmKPSGyHWPA+zNGcUtqyRSQBrCvM7tLXlr0+X4CfdOKKZ2LNoWAug==
X-Received: by 2002:a05:690c:62c4:b0:730:b9f4:bb15 with SMTP id 00721157ae682-763f87777cemr141888017b3.7.1759095012808;
        Sun, 28 Sep 2025 14:30:12 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:488:b20c:c605:ba83])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63ad64e5d45sm51448d50.29.2025.09.28.14.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 14:30:12 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Noah Pendleton <noah.pendleton@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Thranur Andul <thranur@gmail.com>,
	Michael Grosser <grosser.michael@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/3] Support :(optional) filepaths
Date: Sun, 28 Sep 2025 17:29:13 -0400
Message-ID: <cover.1759094936.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250501214057.371711-1-gitster@pobox.com>
References: <20250501214057.371711-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Notes:
- Based on commit 2da08f2c3d (parseopt: values of pathname type can be
  prefixed with :(optional), 2024-10-14) (broken-out/wip/optional-path)
- Rebased on v2.51.0
- I'm least sure of the 3rd patch and am happy to drop it in support of
  the first 2. I think it might be better to (a) integrate :(optional)
  support as pathspec magic and (b) use pathspec magic in parse-options
  when getting filenames. But I'm not sure, and this has other
  ramifications I'm not prepared to deal with. (For example: `git grep
  path <file>… :(optional)non-existent` could pretend like
  `non-existent` was never given?)
- The parsing is not exactly a "clean API," but I wasn't sure how to
  make it cleaner :)

Changes in v2:
- Only check for missing files, not empty files
- Move a test change to the appropriate commit
- Document optional magic in options in gitcli(1)

This series adds support for optional filepaths in config and
parse-options, which supports use-cases such as missing commit templates
or blame.ignoreRevsFile values without erroring.

v1: https://lore.kernel.org/git/20250501214057.371711-1-gitster@pobox.com/

Junio C Hamano (3):
  t7500: make each piece more independent
  config: values of pathname type can be prefixed with :(optional)
  parseopt: values of pathname type can be prefixed with :(optional)

 Documentation/config.adoc                 |  4 ++-
 Documentation/gitcli.adoc                 | 14 +++++++++
 config.c                                  | 16 +++++++++--
 parse-options.c                           | 31 +++++++++++++-------
 t/t7500-commit-template-squash-signoff.sh | 35 +++++++++++++++++------
 wrapper.c                                 | 13 +++++++++
 wrapper.h                                 |  4 ++-
 7 files changed, 94 insertions(+), 23 deletions(-)

Diff-intervalle contre v1 :
1:  82d283c626 ! 1:  63b2b24d42 t7500: make each piece more independent
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## t/t7500-commit-template-squash-signoff.sh ##
    +@@ t/t7500-commit-template-squash-signoff.sh: commit_msg_is ()
    + 	(
    + 		GIT_EDITOR="echo hello >\"\$1\"" &&
    + 		export GIT_EDITOR &&
    +-		test_must_fail git commit
    ++		test_must_fail git commit --allow-empty
    + 	)
    + '
    + 
     @@ t/t7500-commit-template-squash-signoff.sh: commit_msg_is ()
      TEMPLATE="$PWD"/template
      
2:  dbafaff13b ! 2:  5c97f580a9 config: values of pathname type can be prefixed with :(optional)
    @@ Commit message
         pathname wants to signal such an optional file, it can be marked by
         prepending ":(optional)" in front of it.  Such a setting that is
         marked optional would avoid getting the command barf for a missing
    -    file, as an optional configuration setting that names a missing or
    -    an empty file is not even seen.
    +    file, as an optional configuration setting that names a missing
    +    file is not even seen.
     
         cf. <xmqq5ywehb69.fsf@gitster.g>
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    - ## Documentation/config.txt ##
    -@@ Documentation/config.txt: compiled without runtime prefix support, the compiled-in prefix will be
    +
    + ## Notes ##
    +    The 2nd paragraph in this commit is wrapped strangely
    +
    +    I've kept the strange wrapping length for now, but can reflow it if
    +    desired.
    +
    + ## Documentation/config.adoc ##
    +@@ Documentation/config.adoc: compiled without runtime prefix support, the compiled-in prefix will be
      substituted instead. In the unlikely event that a literal path needs to
      be specified that should _not_ be expanded, it needs to be prefixed by
      `./`, like so: `./%(prefix)/bin`.
     -
     ++
     +If prefixed with `:(optional)`, the configuration variable is treated
    -+as if it does not exist, if the named path does not exist or names an
    -+empty file.
    ++as if it does not exist, if the named path does not exist.
      
      Variables
      ~~~~~~~~~
    @@ config.c: int git_config_string(char **dest, const char *var, const char *value)
     +	if (!path)
      		die(_("failed to expand user dir in: '%s'"), value);
     +
    -+	if (is_optional && is_empty_or_missing_file(path)) {
    ++	if (is_optional && is_missing_file(path)) {
     +		free(path);
     +		return 0;
     +	}
    @@ t/t7500-commit-template-squash-signoff.sh: commit_msg_is ()
      # From now on we'll use a template file that exists.
      TEMPLATE="$PWD"/template
      
    +
    + ## wrapper.c ##
    +@@ wrapper.c: int xgethostname(char *buf, size_t len)
    + 	return ret;
    + }
    + 
    ++int is_missing_file(const char *filename)
    ++{
    ++	struct stat st;
    ++
    ++	if (stat(filename, &st) < 0) {
    ++		if (errno == ENOENT)
    ++			return 1;
    ++		die_errno(_("could not stat %s"), filename);
    ++	}
    ++
    ++	return 0;
    ++}
    ++
    + int is_empty_or_missing_file(const char *filename)
    + {
    + 	struct stat st;
    +
    + ## wrapper.h ##
    +@@ wrapper.h: void write_file_buf(const char *path, const char *buf, size_t len);
    + __attribute__((format (printf, 2, 3)))
    + void write_file(const char *path, const char *fmt, ...);
    + 
    +-/* Return 1 if the file is empty or does not exists, 0 otherwise. */
    ++/* Return 1 if the file does not exist, 0 otherwise. */
    ++int is_missing_file(const char *filename);
    ++/* Return 1 if the file is empty or does not exist, 0 otherwise. */
    + int is_empty_or_missing_file(const char *filename);
    + 
    + enum fsync_action {
3:  2da08f2c3d ! 3:  5f7057c236 parseopt: values of pathname type can be prefixed with :(optional)
    @@ Commit message
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    + ## Documentation/gitcli.adoc ##
    +@@ Documentation/gitcli.adoc: $ git describe --abbrev=10 HEAD  # correct
    + $ git describe --abbrev 10 HEAD  # NOT WHAT YOU MEANT
    + ----------------------------
    + 
    ++
    ++Magic filename options
    ++~~~~~~~~~~~~~~~~~~~~~~
    ++Options that take a filename allow a prefix `:(optional)`. For example:
    ++
    ++----------------------------
    ++git commit -F :(optional)COMMIT_EDITMSG
    ++# if COMMIT_EDITMSG does not exist, equivalent to
    ++git commit
    ++----------------------------
    ++
    ++Like with configuration values, if the named file is missing Git behaves as if
    ++the option was not given at all. See "Values" in linkgit:git-config[1].
    ++
    + NOTES ON FREQUENTLY CONFUSED OPTIONS
    + ------------------------------------
    + 
    +
      ## parse-options.c ##
     @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
      {
    - 	const char *s, *arg;
    + 	const char *arg;
      	const int unset = flags & OPT_UNSET;
     -	int err;
      
    @@ t/t7500-commit-template-squash-signoff.sh: commit_msg_is ()
      test_expect_success 'nonexistent template file in config should return error' '
      	test_config commit.template "$PWD"/notexist &&
      	(
    - 		GIT_EDITOR="echo hello >\"\$1\"" &&
    - 		export GIT_EDITOR &&
    --		test_must_fail git commit
    -+		test_must_fail git commit --allow-empty
    - 	)
    - '
    - 

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.48.1

