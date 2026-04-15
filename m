Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F753DC4CF
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265792; cv=none; b=usMG2l1bxgxRT4ffh+ygGMa5k+Y6q276/GbBv/K7K8uRcpQBFhZIeF/30tL2CEZbsRdygy/o94gaKvs8JWikeP89ecKIhUvMzpjfm+iXA3EOw1EgexZQqXmekmV7Jc/89wztQphuBdxlpa9ILwHe06uAow+OruRxQV7mq3ryGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265792; c=relaxed/simple;
	bh=O4/5DL+GhIXqW/QiXJEAmgbzylElhEPwctgDOE/oIew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqm6bDMb30YoSe2mxGtdTXdAIBIK3IMTkwujY0NCmfWQ1+/pqDid1rtlsn7PyWx61WrSYnkmthXtk8Yd9/n37LcRKyTUvLJQGxon2phcoyIqXWI7dR46uyHkA5Gn6JHR70pkeu+eitWI9KaucwHKeB0qaVaSYGLvmP7Npy8H64U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHHindvk; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHHindvk"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so4814686a12.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776265790; x=1776870590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5fwWffCH0GtrqVUv0PDwbx+A/tGHKJdxHj4PgfR5mE=;
        b=GHHindvkXB1TmQUUlBhGd58IDlMkT21bzFC6wkt/easOWyHgx1W+4WNmz2O/3NQlwJ
         veU3lLHCoOIu0rjvM6UQpuwxx626X6qZHMhwt05MppnpCMaq+ljQPNd+RflN4jxCUH3K
         irrxRMJWqQK4YYELf0xXcpnf66raMEtClBSG5s43l/9+WIeKh6j/9lgLi0mfam/CR4eL
         q0dzzIbTTSjd9NZPs27VCNLUxTHy9N2kesbwMioL8Wh2PupBMfDgyHXhBHlp1NKAVAUz
         8KNJ3cI9tTP6EVu1prD1JjzE1hMvK0B/HE1E+TxrmvLvTBhsKS7w0WchSy8+GQM1vz75
         Gt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265790; x=1776870590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J5fwWffCH0GtrqVUv0PDwbx+A/tGHKJdxHj4PgfR5mE=;
        b=ZUK/d9qPqJPdaEpuaIM3py+XJ9BBcNGO9Wo5XN21tyuzetPE5MQ6XZhUgJ7DdvSDG3
         QTMr3moiqnQ/qCQtg4uH/N9f/7e9FxbKM8Y/m34cDUghPEWLijgjtS9R/Z9TVBh42bGt
         BQVUuwCEyrnWX4UJODozdOkIjftKrXROZz9mAEE/CzC6L/OmJq3jeQm9KLPWZNZYKEIM
         EHrjhktQqdNp9JMbElXyNEtHtgtgEmLqlSavpvqIXBw4buEpNylH/0yBbLI3Dda6oTP9
         sODuL+KnftmCV9gekBWFfvWoycEAy/pFnxNEBI4GxIWwUOhlMJJkbYZ0PZHCt0DZmhqu
         AI+w==
X-Gm-Message-State: AOJu0YxU0qt6Il29mmZEEAnTYiMJiw8Nox4pZ22aXTzCjvj6PosdyILp
	KjFJeDiNuOFhN344nzxke7SQzBwTRbsIGqVW8mSp5it+r1iLghfxdoZrff04nw==
X-Gm-Gg: AeBDievs9sbtjvDWyurWeI2NbgpaVzL6eBpCErsb9F1+EwAl/wQwkrPu8X3p8nkjJPP
	VLL9fMtz36vaEeVbQRykU8up6vOr4jm/HffNZ63T8emL0ghzFwbrpneOfrxku0RCv2svvWTMZAj
	gUvJTfJCpmZKhrEJ+HPkmzBDCSw3OPPJC4ZNb8tM0oilIIFBLU/oh1f1Vn0mVGudyH1MQ6v1HUa
	zdQc31mJ3k6ZTPYdApEj8wlQzva5wBMAIHaa4YLcbTpd/oSd27SSacNzlhmg70I0YxJWTfz648T
	UkCJeO+LwbNeiPKZk3iVqdoyZom+GMYrEMudhG0kPJhPwcj8wVq6bnljlVWb5yW9L4Y5kimf3FK
	JWrUjQIWtXT1LzZwtVlHhOHpDfv+wzlOFrQw9wC+otWWAOyZL93dbdRkPBYPAAQ6eWbQCbwOQ47
	XOwH97olCxrY7WrxqD6edNtBO+aA6HRJipY+XPv8DT+CjPtd6/KofyH7iRU3bjiKN9annd
X-Received: by 2002:a05:6300:8e10:b0:39c:787:f185 with SMTP id adf61e73a8af0-39fe3f3fb2amr17360422637.29.1776265789488;
        Wed, 15 Apr 2026 08:09:49 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:31fb:732b:7e92:ae8c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7957ecee03sm2923286a12.2.2026.04.15.08.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:09:48 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	toon@iotcl.com,
	jn.avila@free.fr,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v4 0/1] cat-file: add mailmap subcommand to --batch-command
Date: Wed, 15 Apr 2026 20:39:42 +0530
Message-ID: <20260415150943.40493-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331121111.9614-1-siddharthasthana31@gmail.com>
References: <20260331121111.9614-1-siddharthasthana31@gmail.com>
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

CI: https://gitlab.com/gitlab-org/git/-/pipelines/2455043368

Changes in v4:
- Reword commit message: describe boolean support without mentioning
  internal function names, following Junio's suggestion.
- Add an in-code comment explaining why `mailmap.strdup_strings` can be
  used as the "already loaded" check in `load_mailmap()`.
- Drop local `value` variable in `parse_cmd_mailmap()` and assign
  directly to `use_mailmap`.
- Fix documentation syntax: place the closing backtick before `::`
  and break the description into a `;;` sub-list for `true`/`false`
  effects.
- Link to v3: https://lore.kernel.org/git/xmqqv7dyoei6.fsf@gitster.g/T/#m0a109f3eb5129e619ecec5f2d58ead0c5a49a4f3
- Link to v2: https://lore.kernel.org/git/xmqqv7dyoei6.fsf@gitster.g/T/#m445eab3b309bded92d1b130d225b882c73988ff2
- Link to v1: https://public-inbox.org/git/a4ec7bfa-f16b-4505-9b37-d3dd137e93cb@gmail.com/T/#m5c62fb6ad0fbcc99a706dba4c78b66359c247acd

Thanks,
Siddharth

---
Siddharth Asthana (1):
  cat-file: add mailmap subcommand to --batch-command

 Documentation/git-cat-file.adoc |  12 +++++
 builtin/cat-file.c              |  37 ++++++++++++--
 t/t4203-mailmap.sh              | 105 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 4 deletions(-)

Range-diff versus v3:

1:  dbc1a003a5 ! 1:  25ebffe39e cat-file: add mailmap subcommand to --batch-command
    @@ Commit message
         mailmap dynamically on an existing process.
     
         Add a `mailmap` subcommand to --batch-command that takes a boolean
    -    argument. The command now uses `git_parse_maybe_bool()` and supports all
    -    standard Git boolean values. Mailmap data is loaded lazily and kept in
    -    memory, while a helper centralizes the one-time load path used both at
    -    startup and from the batch-command handler.
    +    argument (usual ways you can specify a boolean value like 'yes', 'true',
    +    etc., are supported). Mailmap data is loaded lazily and kept in memory,
    +    while a helper centralizes the one-time load path used both at startup
    +    and from the batch-command handler.
     
         Extend tests to cover runtime toggling, startup option interactions
         (`--mailmap`/`--no-mailmap`), accepted boolean forms, and invalid values.
    @@ Documentation/git-cat-file.adoc: flush::
      	is used, no output will come until a `flush` is issued. When `--buffer`
      	is not used, commands are flushed each time without issuing `flush`.
     +
    -+mailmap <bool>::
    -+	Enable or disable mailmap for subsequent commands.
    ++`mailmap (<bool>)`::
    ++	Enable or disable mailmap for subsequent commands. The `<bool>`
    ++	argument accepts the same boolean values as linkgit:git-config[1].
    ++	Possible effects are:
     ++
    -+The `<bool>` argument accepts the same boolean values as
    -+linkgit:git-config[1]. When enabled, mailmap data is loaded on first
    -+use and kept in memory until the process exits.
    ++`true`;;
    ++	Mailmap data is loaded on first use and kept in memory until the
    ++	process exits. Passing `true` again does not reload the data.
    ++`false`;;
    ++	Mailmap replacements are disabled for subsequent commands, but data
    ++	already loaded stays in memory.
      --
      +
      
    @@ builtin/cat-file.c: static int use_mailmap;
      
      static char *replace_idents_using_mailmap(char *, size_t *);
      
    ++/*
    ++ * The mailmap is initialized with .strdup_strings set to 0,
    ++ * but read_mailmap() sets the bit to 1 (this is true even when
    ++ * not a single mailmap entry is read), so it can be used for
    ++ * lazy loading.
    ++ */
     +static void load_mailmap(void)
     +{
     +	if (mailmap.strdup_strings)
    @@ builtin/cat-file.c: static void parse_cmd_info(struct batch_options *opt,
     +			      struct strbuf *output UNUSED,
     +			      struct expand_data *data UNUSED)
     +{
    -+	int value = git_parse_maybe_bool(line);
    ++	use_mailmap = git_parse_maybe_bool(line);
     +
    -+	if (value < 0)
    ++	if (use_mailmap < 0)
     +		die(_("mailmap: invalid boolean '%s'"), line);
     +
    -+	if (value > 0)
    ++	if (use_mailmap)
     +		load_mailmap();
    -+	use_mailmap = value;
     +}
     +
      static void dispatch_calls(struct batch_options *opt,

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.53.0
