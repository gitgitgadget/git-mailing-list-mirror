Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84EB664
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740865644; cv=none; b=SJ5Ve7l8YzPZyewKEhoBbfnYJxRDONDrqI53PL0P78fxRWUKpoHgAasndErzJeTxJEeuPV8dQR1Azw5dt16gh4niH4CBeLnq/M4/fT+iZEyF2dLfz+89gKLUC6iASv0b8lYucmOHsqLBEfdW294kI1SBjz8QQWkZzlequ3sUU5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740865644; c=relaxed/simple;
	bh=eG5zQTHbuugYiWmO93VE94RHA5059LM24dKHS1E7oEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sZbnJmSnTSeTaVkxdVhRY/hibEBNgptJoUzBlzkV/RjWaah0+uF7tItgn0mRcVl/BrqptWJsJQSUpR4zBdu+XFA6cpIPDeLbbqZKi3WwGzMUuyIhM+D2PgT3p5LXaT2zgdUQ2OKcM5V6EJryYts+11Rnk6smg5ML03wzjK7I4KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qko7XfiM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qko7XfiM"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390ec449556so2039395f8f.1
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 13:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740865641; x=1741470441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xuH5/lmp5sBANAD/tgRkTiEqGz190be1phqYB260Sjs=;
        b=Qko7XfiMCwpWGoHhRvSrbRI8a5O570LyM2b/7TAuyy6idpCQWy+lntUfe4QBzan1O1
         e8L1y3M2tbIyAw6AAX+GUdkW1dhnfCw025Ubq/6YM/E8eTqkRiR53uOgyYA68fQAMIrQ
         6nffOiUp21zQxsuTmhEckVtak0VQGnD3PpkxwwhUJUnKMwSl1fbLTlZhUG/Yqx2uqiNF
         2kEI6A629Gdty5d1juT4f5qkQDVqgPVPGwTbPQasXS10PspdI/gou/3/HtaABzaBtHqW
         CEM2mDOnKYyiio6sh6sG1EqnNyoDJ4rpzUvDYMw9QflbatPbuBPrfYk0c7tNyq39Lwis
         5KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740865641; x=1741470441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuH5/lmp5sBANAD/tgRkTiEqGz190be1phqYB260Sjs=;
        b=hnwBFMB84iCRPmD3sxTkebv1rn2ApEyppBhs1xwIZx3FNvJtSHHFt3JrD8PTcE6Wlg
         OzRR4Xb+40uaGvvdJbHgBNNfM34NALvUBPogsivln17QjkyQME6Opts6+XWzmrGimnHg
         Ss3qcCYBACOPjXT6oYvSw5RG4CIKXXShUZM4tktmlVC1m53W4/3mIykv/1jAZMc82Qat
         7Xpa+Ng8gWFZ5GSNQhiNM09z39Bc76LerVnPTD0K3OzUmrhCcKdBWrnA3T0hR0XY81dc
         J3ZApOFvgNfP5vPUGQVwdUqoulEdWANESjWqb7wmrMfXon+sVVANlAN/7NKfmLP8ovDx
         EZAA==
X-Gm-Message-State: AOJu0YxFAU3PRz25Kqreuq/b5JChOjw0x7xKnhmbirWnIQRbd5vbVo88
	DS4l5sPgCyA6wsv9eAyNj9v/fprcOM2Vf4zDyX/krjFSb8Wgb2ZAwj4Dj7bq
X-Gm-Gg: ASbGnctpdR2fMMxm64Pw3qm/KEyf6qiQd++vMxMlGA5P4hdThakJXEKd21QLwL+lorq
	d139oMM0CF+E0ZIcPBdRhfepEiqXue5w6fYSFn8onHreRdgTgCeXFP45ZhHIAKo/cpESGzk42/z
	bSHNv2pfvutH/qd9UgqAsM/0yjs5/RKw5VhXi+tfyUiOq8nTo83I1qiiyh6Y0WyMBVWr4w4YvLr
	2odQNjmdE5V9ZVQ4fkXmHU8Koiq24uGMeOIBfJVPur8Rw1nStn/ySPSOEapeLlSsbcmlv21FvdS
	En2DbYjQp2Jd64rDCT0eA46McVRbZVBYjIknY23v0oqlRCGhOo+x8zd2wegtlPkKsXOAhS4pP5N
	iud07
X-Google-Smtp-Source: AGHT+IGXfBT8/H8x1qV103hbnIY0EQ9TWjSg2SOc+9YmYKfa/Up++vqj4kvzdAqCap0pFj8SUWcQ0A==
X-Received: by 2002:a05:6000:381:b0:391:212:459a with SMTP id ffacd0b85a97d-391021246f6mr445541f8f.22.1740865640813;
        Sat, 01 Mar 2025 13:47:20 -0800 (PST)
Received: from aleksbgbg.communityfibre.co.uk ([103.205.25.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a72d5sm9603474f8f.31.2025.03.01.13.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 13:47:20 -0800 (PST)
From: Aleks Todorov <aleks.todorov.1337@gmail.com>
To: git@vger.kernel.org
Cc: Aleks Todorov <aleks.todorov.1337@gmail.com>
Subject: [PATCH 0/7] Add Format Specifier for Blame
Date: Sat,  1 Mar 2025 21:44:59 +0000
Message-ID: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

As previously discussed, this patch series implements a `--format`
option for `git-blame`, re-using the existing implementation from
`git-log`.

My motivation for this is that I use git blame quite often when
debugging, and find myself checking the commit subject for a large
number of lines that I look at. Instead, it would speed up my workflow
if I could see the commit subject next to each line in the blame output.

Since this is a personal preference and each git user probably has their
own personal preference for what kind of output they want to see, as per
Junio's suggestion, by implementing a generic format option, we serve a
variety of use cases all at the same time.

For context, we can now use a command like:

  git blame builtin/blame.c -F '%h %<(17,trunc)%F (%<(20,trunc)%an %ai %>(4)%L) '

to see output like:

  df8738116f7 builtin/blame.c   (Ævar Arnfjörð Bjar.. 2022-10-13 17:39:20 +0200   40) static char annotate_usage[] = N_("git annotate [<options>] [<rev-opts>] [<rev>] [--] <file>");
  5817da01434 builtin-blame.c   (Pierre Habouzit      2008-07-08 15:19:34 +0200   41)
  5817da01434 builtin-blame.c   (Pierre Habouzit      2008-07-08 15:19:34 +0200   42) static const char *blame_opt_usage[] = {
  5817da01434 builtin-blame.c   (Pierre Habouzit      2008-07-08 15:19:34 +0200   43)     blame_usage,
  5817da01434 builtin-blame.c   (Pierre Habouzit      2008-07-08 15:19:34 +0200   44)     "",

However, one key feature I could not find an easy way to implement was
to include a length specifier that auto-detects the minimum column width
required to display a placeholder without trimming the output. As a
result, I could not re-implement the existing options using the
formatting syntax.

Nevertheless, these patches serve my purpose, are self-contained, and
could be extended in the future to complete the plan.

I've made my best effort to include clear atomic commits, write
conforming code, include tests, and add documentation. However, as this
is my first submission here, I expect that I may have missed something -
so please let me know what can be improved and whether this patch series
is suitable for integration.

A short logical summary of the patches:

  1. Add --format / -F option
  2. Add format config option
  3. Add %F and %L format specifiers (blame-only) to allow the filename
     and line number to be emitted
  4. Call into pretty.c to expand the provided format string
  5. Add tests
  6. Refactor documentation structure
  7. Add documentation specific to `git blame --format`

Patches are based on main.

Thanks,
Aleks

Aleks Todorov (7):
  builtin/blame: Accept a user-specified format
  builtin/blame: Add blame.format config option
  pretty: Add F and L format specifiers
  builtin/blame: Expand format when available
  t8015: Add tests for git blame -F
  Documentation: Move placeholders to separate file
  Documentation: Add docs for blame format

 Documentation/config/blame.adoc   |   5 +
 Documentation/git-blame.adoc      |  16 ++
 Documentation/placeholders.adoc   | 242 ++++++++++++++++++++++++++++++
 Documentation/pretty-formats.adoc | 239 +----------------------------
 builtin/blame.c                   | 119 +++++++++------
 pretty.c                          |  14 ++
 pretty.h                          |   5 +
 t/meson.build                     |   1 +
 t/t8015-blame-format.sh           |  39 +++++
 9 files changed, 395 insertions(+), 285 deletions(-)
 create mode 100644 Documentation/placeholders.adoc
 create mode 100755 t/t8015-blame-format.sh

-- 
2.43.0

