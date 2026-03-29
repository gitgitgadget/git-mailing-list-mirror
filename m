Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B136D1EA84
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774772895; cv=none; b=fxbbBaoX0gLZwIuTFjLuBtPtjAdeasy8e1Uq9VZWVqfFzhZipWdOu+rggcbZBFSLQb07aHNfPbP9Krb4hgnnog6g37FdQvJ3+sYvXAqrSQJBpK/OWLcwVjJd2LuWEQ+QXjDvI5AbxJx3VmULkY3P7t36diOl7EzCSeMX7YW/H/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774772895; c=relaxed/simple;
	bh=DEQfKg/CpGK9RqfHx4LQoUxQgLxCLFHb04zZh+CFOZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzXcHZmD7Abiuj7rGTIiijobP9S+OLjNssiS7Xy11NCs3Y5Qz2rNrTkw1HdnLehXgyAD+jiWtM+4d191Vd7da50q/ei1zyCQ3SuC5lBX9Bp3btAPclf0glrAR3jiDizS8TfUqB5WMuf5Brehw66hMAXfL3A1qsu4sXxa2/4BmWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXQHgUzr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXQHgUzr"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b24fdac394so1505125ad.3
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774772893; x=1775377693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlybE0n6PmV0mCHKbDk0oXpll88A5bXI5MwgmcvBpPU=;
        b=IXQHgUzrqQDluAtrw4yzr6JAXy3IFWm85V6M03jebvEYNYCSuFozIAC09OU+NiuhRi
         tmj/uuBnPUjwzIHwJPUl4MWtY6njAGqFxb/zzOsC98WvVWUhtgu15vFHvFJsgoIAIUOp
         QRmgU4wr6pkeuh6kD1kyuZVASoHb4ImAP0q5wQic9EpSG/0H83tnEBOnxGWjtZidr4yh
         U5YD1JcSuvJqAYWaOb2DYxmqBzoLWgEnazXSCfTQD8kTpRYYZh+kTfY+idqH4gGbcEZe
         67RfqHc5oqAuPXnEoBL+WID1GwFUe5Xu8oD0PNVbNeCZ2NEUlX27TKrLf9RMtjGKQCjm
         ek7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774772893; x=1775377693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HlybE0n6PmV0mCHKbDk0oXpll88A5bXI5MwgmcvBpPU=;
        b=MJTdFOdpAp5XxFqc+JFvEDOLnpvI+GFSO4h3HZnAxyxSyDjxFfxy93cyuoCSrCPkwl
         h8S2XZZ2m1uv6qxm3qhkKh6DUEXHx3YUboas/cuJMpJvVWN7NIpMl4rCmF8r6euQIZ3l
         IMzQHOTijEd4JUp8wtWzd4QMfqj6ATntgEsP0ATM/ykqU3ODCdUdSInXGy40yMRDkssl
         FzEMGHuouY96q3qWs+qsBhE2QGLGK/FT6CmheDfXKPJwatbcE9STp+3Rac7J8Q41yt6/
         k9Lx6L7nkHKhUpZIRtXZHT+uiak/OrKjrYDdeVecSJoJgZJrhYOiC0ORReoh87ToZQqy
         u8dg==
X-Gm-Message-State: AOJu0YzhdBqlYYibafZPdmLqaqx4k+k8gBsX0cDy0H+r4Cgj+xKlaVF0
	PaErHT4lJwzLJEEfeXAyVQG5jCM4pe0TtFbWmDYrWjSO8uTKFTzJTUbh9thKCA==
X-Gm-Gg: ATEYQzyMoHaJ7MkWEWIUz552mn7Nv7t1LFVy5cQynhhUXL4xXy+cARJFXjSqXwqMxQ7
	ZP0fvg47WVmCbU4XIc5m/5PGZuQRqZBXgu2P2CTshdi8kHNGDveLYZChsZvTD+IBM/WM6kS01qg
	H74/mJU3jaKfTxGttacbF+7+wNlq6pODjJavpr0QvR1wpHXbpy2MkLvEXMGdGyJaOOV/pAGbsci
	tNERZnB8nCePM2kmAffMIQ6HxMBHQOM4BGaHse1JEHyrTCS/kc8Lujdmkjbgvik4x464NwTlj4F
	GWdo0/2DnXvQn+p8HY7jtnHGFSNXlw/I7Cn1kme/p04Ionvhu3k0SIxHHyt/f+DgQ6YGpXtneg0
	/9ru3HSfA/jqTpcl9DW5ttPh6jkv0NGx1UvZDDto4alOqJTuRPyKFsQUPjNUHF/NLBJzusTx0Pg
	TvEWSm90LiyALTSOo/Op0cvp4w4RkPDa8hxh6q9UnNtZahpC/RZSI7PdRxMae9tpyfRD72
X-Received: by 2002:a17:902:c94c:b0:2b2:3dd9:c5f5 with SMTP id d9443c01a7336-2b23dd9c7c6mr71164235ad.36.1774772892584;
        Sun, 29 Mar 2026 01:28:12 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:e924:4f3e:5a3a:f1f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24264286fsm46120345ad.14.2026.03.29.01.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 01:28:12 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2 0/1] cat-file: add mailmap subcommand to --batch-command
Date: Sun, 29 Mar 2026 13:58:07 +0530
Message-ID: <20260329082808.12609-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260328203615.60402-1-siddharthasthana31@gmail.com>
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-cat-file(1)'s --batch-command works with the --use-mailmap option,
but this option needs to be set when the process is created. This means
we cannot change this option mid-operation.

At GitLab, Gitaly caches git-cat-file processes and it would be useful
if --batch-command supported toggling mailmap dynamically with existing
processes.

This patch adds a `mailmap` subcommand to --batch-command that takes
`yes` or `no` as its argument. When enabled, mailmap data is loaded from
disk on first use and kept in memory so that toggling back on does not
require reloading.

The series is based on top of 5361983c07 (The 22nd batch, 2026-03-21).

CI: https://gitlab.com/gitlab-org/git/-/pipelines/2416081861

Changes in v2:
- Replace two separate `use-mailmap` / `no-use-mailmap` zero-argument
  subcommands with a single `mailmap` subcommand that takes `yes` or
  `no` as its argument. This reduces the dispatch
  table to one entry and the implementation to one function.
- Link to v1: https://public-inbox.org/git/a4ec7bfa-f16b-4505-9b37-d3dd137e93cb@gmail.com/T/#m5c62fb6ad0fbcc99a706dba4c78b66359c247acd

Thanks,
Siddharth

---
Siddharth Asthana (1):
  cat-file: add mailmap subcommand to --batch-command

 Documentation/git-cat-file.adoc |  7 +++++
 builtin/cat-file.c              | 30 ++++++++++++++++++---
 t/t4203-mailmap.sh              | 48 +++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 4 deletions(-)

Range-diff versus v1:

1:  39f40e9cb7 ! 1:  936ca27419 cat-file: add use-mailmap/no-use-mailmap to --batch-command
    @@ Metadata
      Author: Siddharth Asthana <siddharthasthana31@gmail.com>

       ## Commit message ##
    -    cat-file: add use-mailmap/no-use-mailmap to --batch-command
    +    cat-file: add mailmap subcommand to --batch-command

         git-cat-file(1)'s --batch-command works with the --use-mailmap option,
         but this option needs to be set when the process is created. This means
    @@ Commit message
         if --batch-command supported toggling mailmap dynamically with existing
         processes.

    -    Add `use-mailmap` and `no-use-mailmap` as new subcommands to
    -    --batch-command. `use-mailmap` enables the mailmap mechanism for
    -    subsequent `contents` and `info` commands, lazily loading the mailmap
    -    data from disk on first invocation. `no-use-mailmap` disables it but
    -    keeps the data in memory so re-enabling doesn't require reloading.
    -
    -    The subcommand names mirror the existing --use-mailmap/--no-use-mailmap
    -    CLI options to keep the interface consistent.
    +    Add a `mailmap` subcommand to --batch-command that takes a single
    +    argument: `yes` to enable mailmap and `no` to disable it. When enabled,
    +    mailmap data is loaded from disk on first use and kept in memory so that
    +    toggling back on does not require reloading.

    +    Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>

    @@ Documentation/git-cat-file.adoc: flush::
      	is used, no output will come until a `flush` is issued. When `--buffer`
      	is not used, commands are flushed each time without issuing `flush`.
     +
    -+use-mailmap::
    -+	Enable mailmap for subsequent `contents` and `info` commands. If the
    -+	mailmap has not been loaded yet, it is read from disk at this point.
    -+
    -+no-use-mailmap::
    -+	Disable mailmap for subsequent `contents` and `info` commands. The
    -+	mailmap data is kept in memory so that a later `use-mailmap` command
    -+	does not need to reload it from disk.
    ++mailmap <yes|no>::
    ++	Enable or disable mailmap for subsequent `contents` and `info`
    ++	commands. When `yes` is given, mailmap data is loaded from disk on
    ++	first use and kept in memory; passing `yes` again does not reload it.
    ++	When `no` is given, mailmap is disabled but the data stays in memory
    ++	so that a later `mailmap yes` does not need to reload it from disk.
      --

    @@ builtin/cat-file.c: static void parse_cmd_info(struct batch_options *opt,
      	batch_one_object(line, output, opt, data);
      }

    -+static void parse_cmd_use_mailmap(struct batch_options *opt UNUSED,
    -+				  const char *line UNUSED,
    -+				  struct strbuf *output UNUSED,
    -+				  struct expand_data *data UNUSED)
    ++static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
    ++			      const char *line,
    ++			      struct strbuf *output UNUSED,
    ++			      struct expand_data *data UNUSED)
     +{
    -+	if (!mailmap_loaded) {
    -+		read_mailmap(the_repository, &mailmap);
    -+		mailmap_loaded = 1;
    ++	if (!strcmp(line, "yes")) {
    ++		if (!mailmap_loaded) {
    ++			read_mailmap(the_repository, &mailmap);
    ++			mailmap_loaded = 1;
    ++		}
    ++		use_mailmap = 1;
    ++	} else if (!strcmp(line, "no")) {
    ++		use_mailmap = 0;
    ++	} else {
    ++		die(_("mailmap: unknown argument '%s', expected 'yes' or 'no'"), line);
     +	}
    -+	use_mailmap = 1;
    -+}
    -+
    -+static void parse_cmd_disable_mailmap(struct batch_options *opt UNUSED,
    -+				      const char *line UNUSED,
    -+				      struct strbuf *output UNUSED,
    -+				      struct expand_data *data UNUSED)
    -+{
    -+	use_mailmap = 0;
     +}

    @@ builtin/cat-file.c: static const struct parse_cmd {
     +	{ "contents", parse_cmd_contents, 1 },
     +	{ "info", parse_cmd_info, 1 },
     +	{ "flush", NULL, 0 },
    -+	{ "use-mailmap", parse_cmd_use_mailmap, 0 },
    -+	{ "no-use-mailmap", parse_cmd_disable_mailmap, 0 },
    ++	{ "mailmap", parse_cmd_mailmap, 1 },
      };

    @@ t/t4203-mailmap.sh: test_expect_success 'git cat-file --batch-command returns co
     -+test_expect_success 'git cat-file --batch-command use-mailmap enables mailmap mid-stream' '
     ++test_expect_success 'git cat-file --batch-command mailmap yes enables mailmap mid-stream' '
     +	...
     -+	printf "info HEAD\nuse-mailmap\ninfo HEAD\n" | git cat-file --batch-command >actual &&
     ++	printf "info HEAD\nmailmap yes\ninfo HEAD\n" | git cat-file --batch-command >actual &&

     -+test_expect_success 'git cat-file --batch-command no-use-mailmap disables mailmap mid-stream' '
     ++test_expect_success 'git cat-file --batch-command mailmap no disables mailmap mid-stream' '
     +	...
     -+	printf "use-mailmap\ninfo HEAD\nno-use-mailmap\ninfo HEAD\n" | git cat-file --batch-command >actual &&
     ++	printf "mailmap yes\ninfo HEAD\nmailmap no\ninfo HEAD\n" | git cat-file --batch-command >actual &&

     -+test_expect_success 'git cat-file --batch-command use-mailmap works in --buffer mode' '
     ++test_expect_success 'git cat-file --batch-command mailmap works in --buffer mode' '
     +	...
     -+	printf "use-mailmap\ninfo HEAD\nno-use-mailmap\ninfo HEAD\nflush\n" | git cat-file --batch-command --buffer >actual &&
     ++	printf "mailmap yes\ninfo HEAD\nmailmap no\ninfo HEAD\nflush\n" | git cat-file --batch-command --buffer >actual &&

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.51.0

