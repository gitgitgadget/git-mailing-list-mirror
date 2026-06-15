Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2C23F431
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499109; cv=none; b=AwS94hzObmsOAKnYSHima/bTE6D4qcOKX8h7GRdnSlVpn0ZXU+IymrOwDF6OktNX+9TNMhWKShTdzO4eGw13PGFCyc1gRQ+dtCeJPyDRXBPH6p0wIz3gZWbPdWvqzj1uoT8HYI2BiM+d3eps4MeKE2xCpJtN/PH4N7BoM51gSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499109; c=relaxed/simple;
	bh=nazksgf4J2ArdDTWO9pre8XA4IKUQjRZiJ5vSJdbRfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhOFnIb+iaz/dHbukeydguvw8iV7aX2Bxdzw002BhPhKs8Sdz4fzcu5zdAGr+yhSvnpsNNaVkaRzls7OsWqvMBxDVRe1EpyCWYvXjb5DnbpnSMZ16e2/qryEm1YIVkj1SpGMg1ExcCt13A0Z6K+FHOZc3cTWhBsQGOEcux1lUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs6xs/Y8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs6xs/Y8"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0c2a68d01so18361165ad.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 21:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781499107; x=1782103907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvHe+Tqb1JBS4bKvHpoevrmRwP+M1L6O0nrq25NisHE=;
        b=Cs6xs/Y8EYBGXdKplsUQg3qoAcX3MQ7b6pINyWXHWJKk7QhFN9a83jXKTdt1rs1U8O
         iHDAnmaje6kZxAcAtmpmb0mhd2A/sA5+KBsZinCBIABP7wFXDaJAlGYklV7kT9P9UMpX
         nHI0hmUYEHjKprV2iLC6RNJc+40w5uFaZpZuA91Dredt02E5qN3SUwlNf5F/KwPmCFDx
         Sdpk0g0CUVWHnQX4/06HViOMFFIXZsNkuUlZBOvUIa6j2EDz8xC9KzJQFBhPjdbtYuY/
         V6q3k/jT5B9sws2/cd1gX3gkh4SNCaPpjnmyyz3AMu0EFnTvyE8fXxfn15kX/gtJlu1t
         VVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781499107; x=1782103907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UvHe+Tqb1JBS4bKvHpoevrmRwP+M1L6O0nrq25NisHE=;
        b=KyP1LV5utuYDrvPDHQ9SEreKpziQaqSBwdRqddF9ays85PkimOLNnWtHXGrPJf5719
         rj3ZLpG8ggBC87CuXF2P03Cu6YdNO48Qdpm58SmqTMmMqn4cqkvDm1zgy829mO4/5tTa
         OELmuOBFGT8L1WTeWCKq8oKPg/CS+w1CsOmgJ+G/2BlcpVd42YXMfzNcAQEirGs7rUYi
         F5AsMjIBGmfxrxG3VFCim8XigeZ84RTfCXbWs5H1h+T/8iO5ytA+W9rcq/SB1yf+VxNg
         8XAs+gV0ptgTdQS+Uc0YRcYwSNUxEI7I26vA8rWdVcRzwKxOqYyCUEHauVwSUD0K9SIr
         qtYg==
X-Gm-Message-State: AOJu0YwoqZVpB84E6sqUt3aRQAGVl/qJuCqsDs77UrFrCyZpTMSWcyC1
	n7DKzj1yu+9HHt8srP3ZmCG2lzRw5wr336u27qqvMZyUnRDlEHUdSZJ05mbBvQ==
X-Gm-Gg: Acq92OH2pxJBaXVkKANLAsge+6aNXSWALjq2BPpNPRI7qkOW/yJtwGErurht57QO5+T
	JzC71A/bwGOPVsu4X8LyTpkfuZQNMkXRFur2mIzgWueVk2vOs/wiZIaAjp8jQPPzqJOgLIHXWn0
	lD2YaUp/mV2ibrFTS27U/p3S64Rv5wktWzJk0qJMVtwt5JTlfHghotQ5Mvo9fxJxAM/jFa+lyBi
	r5KqZvmuuK5BhaomWs9YWtOPDRCR4/9nq7AfdA4S2t/ZoAR9zWlYLopqibjEA1jnDyNNkJVEtd7
	PMfw8eslDTEzEXjVkXSNXvJ+m3AyN4compv1VJHQXkL3rEar+5NXI57WUgelUiCMEjdaTT+1Xm0
	88+rHZPSkc8ASSG6nSekhCQ1sdGJ8jy4HCZJikHTbhnfhVd4+TWDM19ie1MBShNxGcGU2KQdSSZ
	L1Nw4PXEZ2X1sJIbyE1rEQrerJkv34FpS7oEY53uEhW3cVgu7pMOb9kiym2fqqyhLUlWyrf1MeF
	Luh30JjixTTtuyGwMNnX7kz1JNgrpW2fw==
X-Received: by 2002:a17:902:ef51:b0:2c1:2fd:47ea with SMTP id d9443c01a7336-2c40ff3977dmr148702995ad.4.1781499107295;
        Sun, 14 Jun 2026 21:51:47 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a4c1fsm85528075ad.53.2026.06.14.21.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 21:51:46 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: a3205153416@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kristofferhaugsbakk@fastmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch v4 0/4] teach git repo info to handle path keys
Date: Mon, 15 Jun 2026 10:21:08 +0530
Message-ID: <20260615045112.50686-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This series teaches `git repo info` to handle `path.*`
keys, allowing scripts to reliably discover core
repository paths without resorting to `git rev-parse`.

The patches are structured as follows:

1. path: Extract the localized path-formatting logic
   out of `rev-parse` and expose it globally via
   `path.h` using clear append semantics.

2. rev-parse: Refactor the command to leverage the
   newly shared path engine.

3. repo: Introduce `path.commondir.absolute` and
   `path.commondir.relative` alongside a robust,
   isolated test helper.

4. repo: Introduce `path.gitdir.absolute` and
   `path.gitdir.relative` using the same standardized
   formatting rules.

Since all the questions were answered
I have removed them from this cover letter.

Changes since v3:
* Removed unnecessary double quotes around the `..` argument when calling
  `test-tool path-utils real_path` in the `test_repo_info_path` helper,
  as suggested by Lucas.
* Retained the POSIX-compliant `ROOT="..." && export ROOT` syntax in the
  test setup. Combining them into `export ROOT="..."` triggered Git's
  strict `test-lint-shell-syntax` portability checks, so the separate
  assignment and export remains.

K Jayatheerth (4):
  path: introduce append_formatted_path() for shared path formatting
  rev-parse: use append_formatted_path() for path formatting
  repo: add path.commondir with absolute and relative suffix formatting
  repo: add path.gitdir with absolute and relative suffix formatting

 Documentation/git-repo.adoc |  15 ++++++
 builtin/repo.c              |  50 +++++++++++++++++
 builtin/rev-parse.c         | 103 ++++++++----------------------------
 path.c                      |  70 ++++++++++++++++++++++++
 path.h                      |  36 +++++++++++++
 t/t1900-repo-info.sh        |  68 ++++++++++++++++++++++++
 6 files changed, 262 insertions(+), 80 deletions(-)

Range-diff against v3:
1:  d276ac145e = 1:  a396b4f8e6 path: introduce append_formatted_path() for shared path formatting
2:  5dba41bcb3 = 2:  16198f96d1 rev-parse: use append_formatted_path() for path formatting
3:  b21c97f5d9 ! 3:  b45c6f0d12 repo: add path.commondir with absolute and relative suffix formatting
    @@ t/t1900-repo-info.sh: test_expect_success 'git repo info -h shows only repo info
     +	test_expect_success "absolute: $label" '
     +		(
     +			cd "$absolute_root/sub" &&
    -+			ROOT="$(test-tool path-utils real_path "..")" && export ROOT &&
    ++			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
     +			eval "$init_command" &&
     +			expect_path="$ROOT${expect_absolute_suffix:+/$expect_absolute_suffix}" &&
     +			echo "path.$field_name.absolute=$expect_path" >expect &&
    @@ t/t1900-repo-info.sh: test_expect_success 'git repo info -h shows only repo info
     +	test_expect_success "relative: $label" '
     +		(
     +			cd "$relative_root/sub" &&
    -+			ROOT="$(test-tool path-utils real_path "..")" && export ROOT &&
    ++			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
     +			eval "$init_command" &&
     +			echo "path.$field_name.relative=$expect_relative" >expect &&
     +			git repo info "path.$field_name.relative" >actual &&
4:  fd7a899788 = 4:  b5234ffe3e repo: add path.gitdir with absolute and relative suffix formatting
-- 
2.54.0
