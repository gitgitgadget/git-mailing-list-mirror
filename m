Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860C3DFC6A
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959079; cv=none; b=SNUiBLMZzWdIa94Aoodm/VSW5Nslbnf3KdyVEGBqaPfR5ZQoIymWAJa7JNABczqZUSgF4nu3kZzY+FyD67j61qxq2GHl4Q1UVunKoav6iiy6dNFiG2gDELrNTlxfMzUkZTV7ymgy0p6LB79LHpnGOLSSZQh2FIjyVDoN4HbmsCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959079; c=relaxed/simple;
	bh=PCssKMjfxmD8LN86d9BnTECrCt4t1EmMdbhAlSToHy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSTLSWiuWmZa+UYB+7eQu8aKfqgmC5kQcAAYqKzChKykwtooMTyL7c1vehYyRHzIySb5UsSwfVNfK2Hfd6TsThA/h8vBV3ebhFrSnge7iezSDlcuTd1y6l8SIfxJ7zg/BeMVnnHNTbH+4yT0640RGQaffaLaDhzl1gdNDe7CAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrWeHrsM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrWeHrsM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab39b111b9so23804535ad.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774959077; x=1775563877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ9Ex9/ZMKzLYaJOmOY6H210unHo+4LXyAZ89WO8wQY=;
        b=OrWeHrsMWwqKn4gqrjFb10/ARumEy3tEhYZgm2wU4G6kSV2/RZdtpcoUE2gv5kAVDx
         gSll2+YrqT2PL5hnHp12VMR4dKHtdS0vayB7E/mErOV56Rs82EqWQtM/AwCGTMx83MRp
         2f+oF/RkQs+pYHDrETY+L/JGMGX5TjsHxaGObCopUaWZYVg+o3wx17H1iIrsRpQ3RtFw
         wFt2AcbLh3opoBKihIubdHq+AJvylgKpIxASlz4/HIw9TZJVAQsuHkmdCU2bywJZIJNh
         ox5YXNYqhxM7fQP77gKsoEI8Mmmrsf8OTfu55B2iBkROCNN0Smd19yCOSASv2WKOPXr6
         437g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774959077; x=1775563877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJ9Ex9/ZMKzLYaJOmOY6H210unHo+4LXyAZ89WO8wQY=;
        b=EUJ9G6fQqxx5ood2cl/xbHaeMcPiY8DrUAJ+znpSywSLZ8D+RiKH5v/zZQxT7oX6HW
         EQeRuhb1WvevnV7WTBh/84NSwOfOKK3jClj2tD45lwc8MFN/gu2uy+xz3FdTW/FnBTM8
         r2faq2eJIwsOINt2shUQTTXfnBrMmmsyc4IOK3EsRpxqRAJTeeRQQhgMGL9DHW+iRs0+
         O0aWBZs2lHt8eK9d2xda1DPXqXDKj3HaWBLqKd5YP6OI43+V+4UmWpDA6UqHe8DcVEiH
         RSxEotx3whMok5U5GZMqgK1BzyOmRndzmsmpdLefcdgpmrSTHXNyQ1RoV6FKfu15upAt
         FsBg==
X-Gm-Message-State: AOJu0YyXnDWj1jFSx3G6On8tAxgWXD3R2WqXVPbrf1mdJKWTNMZGcS0j
	s/g3+UqnFuzqwT8/0kwRQc8yRavVi7MFhN05CjBRX8Acoyg0RohMWAHK1UQRDw==
X-Gm-Gg: ATEYQzzTGXwbUg/KlXIfqZbHS1VnIwhF0cLP00WMAgXgzZZOw3l5p+09TvWQyDc7rJl
	FLNbUs/aav2mBqzb0EfMKzq0HYbm2Y62S5QgEhAexjdq92hBExEApEmyC1DTdGsGDYMuGNgvPNG
	S8qijCFBL0wB76z6TSoiqPm2IEezZ0w/AXJyIf/VpMlEX4SHXQZekLPeuV2Dv+gV+GXE4+D3dg+
	H4B4bmeG6vqEPKmJdrq8FIV2iHrCsIrAU0uvTEsMDsEoYwmyRC0qbNTur5t4gimnK/M9BLHgsrD
	9AgCMvSxXgWnWX76l+MxfB0sLXjv5LLq9Yp8DJgHL3AJbp5ZpyFBqTE4L9FH4UACA6ILZFyhbiX
	24uwl0pX4pHdGFvMBZ8qEDhNL6TIFXQStBIQ68xl+P8C2NFsKuTJvSmXzDgeBgcNizz0QTOKL5N
	4Z2+V0TDz7YXWIKtvrCi7U5b73p+gNZEX0uSEDh7zTAevqkl5cohMDv4IRUr9rn3BQHVcx
X-Received: by 2002:a17:903:19ee:b0:2b0:6885:f1d4 with SMTP id d9443c01a7336-2b0cdcdc514mr159607285ad.39.1774959077202;
        Tue, 31 Mar 2026 05:11:17 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:c5eb:1e90:2258:6d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24266e487sm109891855ad.24.2026.03.31.05.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 05:11:16 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 0/1] cat-file: add mailmap subcommand to --batch-command
Date: Tue, 31 Mar 2026 17:41:10 +0530
Message-ID: <20260331121111.9614-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329082808.12609-1-siddharthasthana31@gmail.com>
References: <20260329082808.12609-1-siddharthasthana31@gmail.com>
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

At GitLab, Gitaly keeps interacting with a long-lived git-cat-file
process and it would be useful if --batch-command supported toggling
mailmap dynamically on an existing process.

This patch adds a `mailmap` subcommand to --batch-command that accepts
a boolean argument and toggles mailmap dynamically for subsequent
commands.

The series is based on top of 5361983c07 (The 22nd batch, 2026-03-21).

CI: https://gitlab.com/gitlab-org/git/-/pipelines/2419600519

Changes in v3:
- Use "keeps interacting with a long-lived git-cat-file process" wording
  in the commit message and cover letter.
- Drop the `Suggested-by` trailer.
- Avoid style-only churn in the `commands[]` table by keeping existing
  initializer style and only adding the new command entry.
- Introduce a `load_mailmap()` helper used by both startup and
  `parse_cmd_mailmap()`.
- Parse `mailmap <bool>` using `git_parse_maybe_bool()` instead of
  handling only `yes`/`no`.
- Update docs to describe `mailmap <bool>` and reference Git's boolean
  syntax from `git-config(1)`.
- Add tests for startup option interaction (`--mailmap`/`--no-mailmap`),
  accepted boolean values (`true`/`false`), and invalid boolean input.
- Link to v2: https://public-inbox.org/git/20260329082804.53400-1-siddharthasthana31@gmail.com/
- Link to v1: https://public-inbox.org/git/a4ec7bfa-f16b-4505-9b37-d3dd137e93cb@gmail.com/T/#m5c62fb6ad0fbcc99a706dba4c78b66359c247acd

Thanks,
Siddharth

---
Siddharth Asthana (1):
  cat-file: add mailmap subcommand to --batch-command

 Documentation/git-cat-file.adoc |   7 +++
 builtin/cat-file.c              |  32 ++++++++++--
 t/t4203-mailmap.sh              | 105 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 4 deletions(-)

Range-diff versus v2:

1:  936ca27419 ! 1:  df446d7ca3 cat-file: add mailmap subcommand to --batch-command
    @@ Commit message
         but this option needs to be set when the process is created. This means
         we cannot change this option mid-operation.
     
    -    At GitLab, Gitaly caches git-cat-file processes and it would be useful
    -    if --batch-command supported toggling mailmap dynamically with existing
    -    processes.
    +    At GitLab, Gitaly keeps interacting with a long-lived git-cat-file
    +    process and it would be useful if --batch-command supported toggling
    +    mailmap dynamically on an existing process.
     
    -    Add a `mailmap` subcommand to --batch-command that takes a single
    -    argument: `yes` to enable mailmap and `no` to disable it. When enabled,
    -    mailmap data is loaded from disk on first use and kept in memory so that
    -    toggling back on does not require reloading.
    +    Add a `mailmap` subcommand to --batch-command that takes a boolean
    +    argument. The command now uses `git_parse_maybe_bool()` and supports all
    +    standard Git boolean values. Mailmap data is loaded lazily and kept in
    +    memory, while a helper centralizes the one-time load path used both at
    +    startup and from the batch-command handler.
    +
    +    Extend tests to cover runtime toggling, startup option interactions
    +    (`--mailmap`/`--no-mailmap`), accepted boolean forms, and invalid values.
     
    -    Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Documentation/git-cat-file.adoc ##
    @@ Documentation/git-cat-file.adoc: flush::
      	is used, no output will come until a `flush` is issued. When `--buffer`
      	is not used, commands are flushed each time without issuing `flush`.
     +
    -+mailmap <yes|no>::
    -+	Enable or disable mailmap for subsequent `contents` and `info`
    -+	commands. When `yes` is given, mailmap data is loaded from disk on
    -+	first use and kept in memory; passing `yes` again does not reload it.
    -+	When `no` is given, mailmap is disabled but the data stays in memory
    -+	so that a later `mailmap yes` does not need to reload it from disk.
    ++mailmap <bool>::
    ++	Enable or disable mailmap for subsequent commands.
    +++
    ++The `<bool>` argument accepts the same boolean values as
    ++linkgit:git-config[1]. When enabled, mailmap data is loaded on first
    ++use and kept in memory until the process exits.
      --
     
      ## builtin/cat-file.c ##
    +@@ builtin/cat-file.c: static int use_mailmap;
     +
     +static void load_mailmap(void)
     +{
     +	if (mailmap.strdup_strings)
     +		return;
     +
     +	read_mailmap(the_repository, &mailmap);
     +}
     +
     @@ builtin/cat-file.c: static void parse_cmd_info(struct batch_options *opt,
      	batch_one_object(line, output, opt, data);
      }
    @@ builtin/cat-file.c: static void parse_cmd_info(struct batch_options *opt,
     +{
    -+	if (!strcmp(line, "yes")) {
    -+		if (!mailmap_loaded) {
    -+			read_mailmap(the_repository, &mailmap);
    -+			mailmap_loaded = 1;
    -+		}
    -+		use_mailmap = 1;
    -+	} else if (!strcmp(line, "no")) {
    -+		use_mailmap = 0;
    -+	} else {
    -+		die(_("mailmap: unknown argument '%s', expected 'yes' or 'no'"), line);
    -+	}
    ++	int value = git_parse_maybe_bool(line);
    ++
    ++	if (value < 0)
    ++		die(_("mailmap: invalid boolean '%s'"), line);
    ++
    ++	if (value > 0)
    ++		load_mailmap();
    ++	use_mailmap = value;
     +}
     +
    @@ builtin/cat-file.c: static const struct parse_cmd {
    -+	{ "use-mailmap", parse_cmd_use_mailmap, 0 },
    -+	{ "no-use-mailmap", parse_cmd_disable_mailmap, 0 },
    ++	{ "mailmap", parse_cmd_mailmap, 1 },
     +};
     
     @@ builtin/cat-file.c: int cmd_cat_file(int argc,
      	if (use_mailmap)
    -+		read_mailmap(the_repository, &mailmap);
    ++		load_mailmap();

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.53.0
