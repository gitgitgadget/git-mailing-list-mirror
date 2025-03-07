Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28C33DF
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390551; cv=none; b=I+U5itBEPoGv3HPxPxpUr2SO2yxHSulqxfMTV3fQ2vqIEWaAnXYdIRYhATixhjqfmeV0TwBlmgrnRkLI6/ttFDls/ML0ZxmDrcP4HLA1I1ENPGagAXWarXZzzNNe8CTYmAMBWGLlDMeZ+EbAKsoL8zVysGd/pdBvpjzm9yInkj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390551; c=relaxed/simple;
	bh=TTwyT7xZ7+HzvAWraxaoCCfpOuuBMDPC2InLWSdISmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIiYmGrlfT+lNpp/JhZgOmcBjODnJ1uxdlvL1e7jwH9QEn2UNaezqlM6UzZRKXrrs1pkuewOUT/jqFPGxHmBlqPz9UAGH7FxyemD4Ix9IRDbHVk55vNtmk+i5uCw6mJBlqC2lsZLxMr4hDPzmXH8SpcVR1gc+7zAB2fPf+FkzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOjAik9H; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOjAik9H"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22349bb8605so46663375ad.0
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390549; x=1741995349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VtqKMwUrFEjSDDpN1kN4lqkD0VCSe75jW8OnYyJ2dw=;
        b=FOjAik9H0N+LnfcRN27RDtwBIF6tOaLuYGJKdVvMR6xR4JOgEOXbl+fy2uH05j+HKU
         BRgsjaexcoUg2QfYX0YTJoGL0/mRE1VKVMc9HU0linnXVl6+U2qJceG0cHiDUjOQ7B/M
         TSdHUp7o5P0jiEEaCwaMbHu5+jYoxqY5ABBg3C6bwfDz21yepRqAd2gVZpuT0gihvbhl
         Hs3O2M9jF8nY9reUtghE6d+I/SUCaPyCWLc9fbqwt1OaxragdsbnGMWY/INVJTBwS8M7
         yN+QxjbUMKmq/GWmQUylAT2qH+hpP6bwJAxQTmgkl7m03HwGMChve8d5o1dYwkemgeo/
         MwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390549; x=1741995349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VtqKMwUrFEjSDDpN1kN4lqkD0VCSe75jW8OnYyJ2dw=;
        b=w0ttdDQmx180IUM8In1NO01U0EjVj+Ysx/yGKmzn75bsbZgbVFnwPRt1PzpC8HjF7Q
         CmEgcZwfzZTXS6vnidjPMPQ87l/4dS7UbxJ3MZ0f6MkByb6NTST/T4YvUX4xgIhrWM8q
         9MMyd5DCnq3pv1HI2WFqk0/3dSNlIr2BjM10RPng/RB9Dj6wof7dYG4XD+48UBu/YZ2O
         SayvQUYx1RsCvXJlNsJA1CukIR0oXWmKxn+z5zrZWJ4gIbcXQuXI5w8yROrOJEyppP0e
         BC4QMLZg0jsfU1iCjA2MbbwEIDj2RprZIMC7/28wXV4K43+O/1kK1QDvyyKztFtPry7w
         muAw==
X-Gm-Message-State: AOJu0Yz9bim/6ScWyABt8b9R1RRBXVlx73Z+M3qK2isJbCO6U6/BL9qO
	OxquS+BADVuklIo8E3VbwgmzZV7teP0CjCh6b4DB1gvajtyguPxDL+bI03R6
X-Gm-Gg: ASbGncupv3dA4fCYUyIqcIjDjTbG6qUNRuAxPcOJnB4bH2F9Um8OpjEvRb8s65dFCpO
	EEfSXMB+mo/25qp6QqXtlySmTehBLh81qD8tnZ5M5+AWyPBz9lpbB65AqTkvxPcNY47vVAOA+fw
	869eaivk2g7bmMXZMwNlNRgnfc7dkxfKHgI8vJocm0bJacwLSQnoT2jf3d5XdUNp3Ij1qirF+9X
	JSBQiEJQPN7QEHt453HseBBhLBmKBFVMqFbBya7BllbJ9bpcIt8Eagd8m7UNOYZY5smHSR8e/r/
	7gnMOw35IL4rPQ8UTWbFjWH1magYW9X1c6O/iskWWvaeezalrxoRvjIiwu+Gd9yrF53n5w==
X-Google-Smtp-Source: AGHT+IFBCFRjSCQtcHkASYrmUDW6LAvHU5vwWR8dgXqZCWCTwIF1fRShfy6Y9hb0nYtPChvBPg0kSw==
X-Received: by 2002:a05:6a00:928b:b0:736:5dc6:a14b with SMTP id d2e1a72fcca58-736aaa1ace3mr7994650b3a.13.1741390548699;
        Fri, 07 Mar 2025 15:35:48 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bcb8de04sm423880b3a.154.2025.03.07.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:35:48 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com
Subject: [Outreachy PATCH v4 0/8] stop using the_repository global variable.
Date: Sat,  8 Mar 2025 05:04:59 +0530
Message-ID: <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
References: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
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

Some functions also uses `the_repository` global internally, so, let's
let's refactor them and pass `struct repo` as one of the argument. Some
functions only need an instance of "struct index_state", so, let's pass
it to such functions.

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

Changes since v3
================
- Add a comment to describe why we teach `repo_config()` to take NULL
repo value and what we intend to achieve.
- Pass "struct index_state" instead of repo in functions inside
"builtin/checkout-index.c"
- Fix some typo.

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
 config.h                        |  9 +++++++
 t/t0610-reftable-basics.sh      |  7 ++++++
 t/t2006-checkout-index-basic.sh |  7 ++++++
 t/t3004-ls-files-basic.sh       |  7 ++++++
 t/t5400-send-pack.sh            |  7 ++++++
 t/t6300-for-each-ref.sh         |  7 ++++++
 t/t7030-verify-tag.sh           |  7 ++++++
 t/t7510-signed-commit.sh        |  7 ++++++
 16 files changed, 116 insertions(+), 61 deletions(-)

Range-diff versus v3:

1:  a5c69f3753 ! 1:  f53677cbd6 config: teach repo_config to allow `repo` to be NULL
    @@ config.h: void read_very_early_config(config_fn_t cb, void *data);
       * value is left at the end).
       *
     + * In cases where the repository variable is NULL, repo_config() will
    -+ * call read_early_config().
    ++ * skip the per-repository config but retain system and global configs
    ++ * by calling read_very_early_config() which also ignores one-time
    ++ * overrides like "git -c var=val". This is to support handling "git foo -h"
    ++ * (which lets git.c:run_builtin() to pass NULL and have the cmd_foo()
    ++ * call repo_config() before calling parse_options() to notice "-h", give
    ++ * help and exit) for a command that ordinarily require a repository
    ++ * so this limitation may be OK (but if needed you are welcome to fix it).
     + *
       * Unlike git_config_from_file(), this function respects includes.
       */
2:  dfa0da4061 = 2:  6560218b7a builtin/verify-tag: stop using `the_repository`
3:  ade2d026cb = 3:  22681bad00 builtin/verify-commit: stop using `the_repository`
4:  e3b58bc6cf = 4:  a2a97b10a6 builtin/send-pack: stop using `the_repository`
5:  b11e99627c = 5:  b88e45e795 builtin/pack-refs: stop using `the_repository`
6:  51c80f9273 = 6:  d976fab012 builtin/ls-files: stop using `the_repository`
7:  63bb89291f = 7:  6a44666310 builtin/for-each-ref: stop using `the_repository`
8:  8dfe6b40c8 ! 8:  677e088e55 builtin/checkout-index: stop using `the_repository`
    @@ Commit message
         set to NULL and then early in the function, `show_usage_with_options_if_asked()`
         call will give the options help and exit.
     
    -    Pass the repository available in the calling context to both `checkout_all()`
    -    and `checkout_file()` to remove their dependency on the global
    -    `the_repository` variable.
    +    Pass an instance of "struct index_state" available in the calling
    +    context to both `checkout_all()` and `checkout_file()` to remove their
    +    dependency on the global `the_repository` variable.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
    @@ builtin/checkout-index.c: static void write_tempfile_record(const char *name, co
      }
      
     -static int checkout_file(const char *name, const char *prefix)
    -+static int checkout_file(struct repository *repo, const char *name, const char *prefix)
    ++static int checkout_file(struct index_state *index, const char *name, const char *prefix)
      {
      	int namelen = strlen(name);
     -	int pos = index_name_pos(the_repository->index, name, namelen);
    -+	int pos = index_name_pos(repo->index, name, namelen);
    ++	int pos = index_name_pos(index, name, namelen);
      	int has_same_name = 0;
      	int is_file = 0;
      	int is_skipped = 1;
    @@ builtin/checkout-index.c: static int checkout_file(const char *name, const char
      
     -	while (pos <the_repository->index->cache_nr) {
     -		struct cache_entry *ce =the_repository->index->cache[pos];
    -+	while (pos < repo->index->cache_nr) {
    -+		struct cache_entry *ce =repo->index->cache[pos];
    ++	while (pos < index->cache_nr) {
    ++		struct cache_entry *ce = index->cache[pos];
      		if (ce_namelen(ce) != namelen ||
      		    memcmp(ce->name, name, namelen))
      			break;
    @@ builtin/checkout-index.c: static int checkout_file(const char *name, const char
      }
      
     -static int checkout_all(const char *prefix, int prefix_length)
    -+static int checkout_all(struct repository *repo, const char *prefix, int prefix_length)
    ++static int checkout_all(struct index_state *index, const char *prefix, int prefix_length)
      {
      	int i, errs = 0;
      	struct cache_entry *last_ce = NULL;
      
     -	for (i = 0; i < the_repository->index->cache_nr ; i++) {
     -		struct cache_entry *ce = the_repository->index->cache[i];
    -+	for (i = 0; i < repo->index->cache_nr ; i++) {
    -+		struct cache_entry *ce = repo->index->cache[i];
    ++	for (i = 0; i < index->cache_nr ; i++) {
    ++		struct cache_entry *ce = index->cache[i];
      
      		if (S_ISSPARSEDIR(ce->ce_mode)) {
      			if (!ce_skip_worktree(ce))
    @@ builtin/checkout-index.c: static int checkout_all(const char *prefix, int prefix
      			if (ignore_skip_worktree) {
     -				ensure_full_index(the_repository->index);
     -				ce = the_repository->index->cache[i];
    -+				ensure_full_index(repo->index);
    -+				ce = repo->index->cache[i];
    ++				ensure_full_index(index);
    ++				ce = index->cache[i];
      			}
      		}
      
    @@ builtin/checkout-index.c: int cmd_checkout_index(int argc,
      			die("git checkout-index: don't mix '--stdin' and explicit filenames");
      		p = prefix_path(prefix, prefix_length, arg);
     -		err |= checkout_file(p, prefix);
    -+		err |= checkout_file(repo, p, prefix);
    ++		err |= checkout_file(repo->index, p, prefix);
      		free(p);
      	}
      
    @@ builtin/checkout-index.c: int cmd_checkout_index(int argc,
      			}
      			p = prefix_path(prefix, prefix_length, buf.buf);
     -			err |= checkout_file(p, prefix);
    -+			err |= checkout_file(repo, p, prefix);
    ++			err |= checkout_file(repo->index, p, prefix);
      			free(p);
      		}
      		strbuf_release(&unquoted);
    @@ builtin/checkout-index.c: int cmd_checkout_index(int argc,
      
      	if (all)
     -		err |= checkout_all(prefix, prefix_length);
    -+		err |= checkout_all(repo, prefix, prefix_length);
    ++		err |= checkout_all(repo->index, prefix, prefix_length);
      
      	if (pc_workers > 1)
      		err |= run_parallel_checkout(&state, pc_workers, pc_threshold,

-- 
2.48.1

