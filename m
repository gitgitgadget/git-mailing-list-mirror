Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698B1E98E6
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751844009; cv=none; b=NbARLdzyttHZa0fBiCoQT29/gBGIpxLwn1s7efzOcDzPLm+lHsAUpbpflYXQCHEgey3dy6a27G5JoIthrww4/7w9bKqozSOYoK0Ct9L2zyKtzByrqTqtWRQA3KxG6tRaoHubiDTT9CNOJ3f7gOU4U3G0IsBlyT9Y+yacc9DaYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751844009; c=relaxed/simple;
	bh=QaJADD/pG4Jz9VPPQHx9EpdBhcZYRV1W/tY86Q4vkRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IvR3IWO8P+BFhI0YbXoXYQJ2oVwAVULxjOdR+lE21RAHI7ycrhzBYyEXdQR1kjql5grUrKZAWGVYB11CDhfNaVWD0czdkGO7GMt9gBojRaVzSqRaLG70xQV62yfb3KkyygfqyiQBQQbgaWPq0zytChZY37JcdMrqqoKa8KjJqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4iZMgWm; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4iZMgWm"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-700fee04941so26827856d6.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 16:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751844007; x=1752448807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gChkoHaZsVmDTKnsE54bvQFotiLdTu6K6gU84Ktlis8=;
        b=T4iZMgWmuqSpIpYBSV3OsDghDtg41HnnvPTc2uxTRk5265QuPDjMQKygQKfROr1Q8v
         iK1grDGESYiVqqv+OCpH0SJUHjoNmoJu51M80cThj8Wh5YUCzx7zWmx3YMu9OVWpUGsT
         alk18pOToRrNVuNTj1bTFMQl6zqQZBmHRbSYfRpcbiFyo52BvFZJtlNJrcSSaAw5ZDQx
         dq0vI6M4AEBE4kyUhR6ZMNSKXKou4gN6Jza0yC+IIIEyqo9nCi5plhrA5yhOmuOILRZl
         jkMSGaIhq5UhU6tee4bRJktpkT0nSuM/N5npEe8Sd5XV8qpOv5EmFmRzd89bB7Wob6Yd
         6CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751844007; x=1752448807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gChkoHaZsVmDTKnsE54bvQFotiLdTu6K6gU84Ktlis8=;
        b=Gy33X/3a72HOfvxnnpXzsmh953c7a5q/8K+NoKRRD6k8/6CNntTHlnzwBEvTxdEtSH
         qfoAamSkaGuJ0ohFjn210HtMv5R/swPM4R8il3Fitck+ULUIK3T7rXTP9g+SLHg4bFN/
         EqsGvkqPT3l87K6ZbEVK9FYq6kbYfz82A08GdLpuZVsC9MI1MoYnkvZQpuGZG5tMgJHp
         FX9YMSgSX9hOE320ZllSbf1cAghCDKT6v6N1b3G88d8uEgXR6dcy5XfowDBImCRVTlZ3
         4NxTtf8AphtEcb/S+o9Bw7HtXB0pHP/jIhce5yDUENoZknp3EhbG4JNmuocDSF9sW4Yc
         2Mgg==
X-Gm-Message-State: AOJu0YxnRIXupwrZ5PVBjp7QgW22kQmfpi6LDPlxJEoWHmAoZ7s3E0D+
	IhHNzKdBcyiLR32HuyQpr702490qYj46W+B24awITqm8rp6TXcOcKK5e8ryq8w==
X-Gm-Gg: ASbGncv+eypkG62th3uLh2MqctLd9rNnhpFQPKVIE+sBj55+ZtMbDfE0B0tuR1M46TK
	L6DTIB8Y4HZr8P5jxyA3rkMVzi+PKkwGEGgMLwwf6niacsuVV3BqLm9pgcS9U3jcxb4Ro6VADO6
	gNekpAERUayPaPcJ7yZlfekH/P4wDhQSl1mpjcqiUsvkaQqEJhlz4K9JLqvd5rBlsaIXj2qH6Va
	WeQCs6X7H47Pf6OjbOnWWPqBWIs5tPTGsL3uAK2LXU+i4D13GLBMM9utdJ4QbcNNgH6tXU2Az0A
	YtPq2hXJ3VJgXd4dDoTNSIXf8tDviY/fXmPP+qbSc8EFVk+YzS9lmjSSSHAbO9c7+JGHXuNJgNs
	RK3Cbb+yHFadu/ixWdb/j2mn/2D/hL/b+WZub
X-Google-Smtp-Source: AGHT+IF9yC83bcQDpiNZ/+ybYl2Z9LVZAyrnATu1v5hnoykaOc8CEZVo2w0dEfURQXxqrLPlF7Mvdg==
X-Received: by 2002:a05:6214:1d28:b0:702:d840:299 with SMTP id 6a1803df08f44-702d84002dfmr73309106d6.38.1751844006742;
        Sun, 06 Jul 2025 16:20:06 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:934a:8cb5:107d:e42b:6887])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d50947sm49891716d6.78.2025.07.06.16.20.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Jul 2025 16:20:06 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v3 0/5] repo-info: add new command for retrieving repository info
Date: Sun,  6 Jul 2025 20:19:33 -0300
Message-Id: <20250706231938.16113-1-lucasseikioshiro@gmail.com>
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

This is the third version of the patchset introducing the new Git command
called `repo-info`, which will return repository information currently stored
under git-rev-parse using machine-readable formats.

The main changes since v2 are:

- Documentation for git-repo-info has been added.
- The `--allow-empty` flag was removed. In this version, repo-info no longer
  returns a default set of data when called without parameters. However, an
  `--all` flag is planned for a future version.
- The `plaintext` format was replaced by a null-terminated format, following
  the syntax of `git config --list -z`.

Here is the rangediff from v2 to v3:

1:  102b5ce90a ! 1:  3f9ef00413 repo-info: declare the repo-info command
    @@ Metadata
      ## Commit message ##
         repo-info: declare the repo-info command

    -    Create a new Git subcommand called repo-info. `git repo-info` will query
    -    metadata from the current repository and outputs it as JSON or plaintext.
    +    Currently, `git rev-parse` covers a wide range of functionality not
    +    directly related to parsing revisions, as its name says. Over time,
    +    many features like parsing datestrings, options, paths, and others
    +    were added to it because there wasn't a more appropriated command
    +    to place them.
    +
    +    Create a new Git subcommand called `repo-info`. `git repo-info` will
    +    bring the functionality of retrieving repository-related information
    +    currently returned by `rev-parse`, displaying them in
    +    machine-readable formats (JSON or a null-terminated format).

         Also add entries for this new command in:

    -    - the build files (Makefile and meson.build)
    +    - the build files (Makefile, meson.build, Documentation/meson.build)
         - builtin.h
         - git.c
         - .gitignore
    +    - command-list.txt
    +    - Documentation

    -    In option parsing, use PARSE_OPT_KEEP_UNKNOWN_OPT to allow the users
    -    specify after the flags the information that they want to retrieve.
    -
    +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    -    Mentored-by Patrick Steinhardt <ps@pks.im>
    +    Mentored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>

      ## .gitignore ##
    @@ .gitignore
      /git-rerere
      /git-reset

    + ## Documentation/git-repo-info.adoc (new) ##
    +@@
    ++git-repo-info(1)
    ++================
    ++
    ++NAME
    ++----
    ++git-repo-info - Retrieve information about a repository
    ++
    ++SYNOPSIS
    ++--------
    ++[synopsis]
    ++git repo-info
    ++
    ++DESCRIPTION
    ++-----------
    ++Retrieve information about the current repository in a machine-readable format.
    ++
    ++`git repo-info` will be the primary tool to query repository-specific
    ++information, which currently can also be done by calling `git rev-parse` (see
    ++linkgit:git-rev-parse[1]). `git repo-info` doesn't query information unrelated
    ++to the current repository or that is already retrieved by a specialized command,
    ++for example, `git config` (see linkgit:git-config[1]) or `git var` (see
    ++linkgit:git-var[1]).
    ++
    ++THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
    ++
    ++OPTIONS
    ++-------
    ++
    ++`<key>`::
    ++Key of the value that will be retrieved. It should be in the format
    ++`<category>.<field>`. See the "CATEGORIES AND FIELDS" section below.
    ++
    ++CATEGORIES AND FIELDS
    ++---------------------
    ++
    ++The set of data that `git repo-info` can return is divided into
    ++categories. Each category is composed by one or more fields.
    ++
    ++SEE ALSO
    ++--------
    ++linkgit:git-rev-parse[1]
    ++
    ++GIT
    ++---
    ++Part of the linkgit:git[1] suite
    +
    + ## Documentation/meson.build ##
    +@@ Documentation/meson.build: manpages = {
    +   'git-repack.adoc' : 1,
    +   'git-replace.adoc' : 1,
    +   'git-replay.adoc' : 1,
    ++  'git-repo-info.adoc' : 1,
    +   'git-request-pull.adoc' : 1,
    +   'git-rerere.adoc' : 1,
    +   'git-reset.adoc' : 1,
    +
      ## Makefile ##
     @@ Makefile: BUILTIN_OBJS += builtin/remote.o
      BUILTIN_OBJS += builtin/repack.o
    @@ builtin/repo-info.c (new)
     +	};
     +
     +	argc = parse_options(argc, argv, prefix, options, repo_info_usage,
    -+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
    ++			     0);
     +
     +	return 0;
     +}

    + ## command-list.txt ##
    +@@ command-list.txt: git-remote                              ancillarymanipulators           complete
    + git-repack                              ancillarymanipulators           complete
    + git-replace                             ancillarymanipulators           complete
    + git-replay                              plumbingmanipulators
    ++git-repo-info                           plumbinginterrogators
    + git-request-pull                        foreignscminterface             complete
    + git-rerere                              ancillaryinterrogators
    + git-reset                               mainporcelain           history
    +
      ## git.c ##
     @@ git.c: static struct cmd_struct commands[] = {
      	{ "repack", cmd_repack, RUN_SETUP },
2:  1cc1184663 < -:  ---------- repo-info: add the --format flag
3:  a329825387 < -:  ---------- repo-info: add plaintext as an output format
4:  3b6c27b68d < -:  ---------- repo-info: add the --allow-empty flag
5:  4b1e99cac4 < -:  ---------- repo-info: add the field references.format
6:  0cd72e5ebf < -:  ---------- repo-info: add field layout.bare
7:  274dfbde86 < -:  ---------- repo-info: add field layout.shallow
-:  ---------- > 2:  33c3d5e665 repo-info: add the --format flag
-:  ---------- > 3:  e6331b18d4 repo-info: add the field references.format
-:  ---------- > 4:  6a6825c4df repo-info: add field layout.bare
-:  ---------- > 5:  938be682d2 repo-info: add field layout.shallow

Lucas Seiki Oshiro (5):
  repo-info: declare the repo-info command
  repo-info: add the --format flag
  repo-info: add the field references.format
  repo-info: add field layout.bare
  repo-info: add field layout.shallow

 .gitignore                       |   1 +
 Documentation/git-repo-info.adoc |  84 ++++++++++++
 Documentation/meson.build        |   1 +
 Makefile                         |   1 +
 builtin.h                        |   1 +
 builtin/repo-info.c              | 229 +++++++++++++++++++++++++++++++
 command-list.txt                 |   1 +
 git.c                            |   1 +
 meson.build                      |   1 +
 t/meson.build                    |   1 +
 t/t1900-repo-info.sh             |  84 ++++++++++++
 11 files changed, 405 insertions(+)
 create mode 100644 Documentation/git-repo-info.adoc
 create mode 100644 builtin/repo-info.c
 create mode 100755 t/t1900-repo-info.sh

-- 
2.39.5 (Apple Git-154)

