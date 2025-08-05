Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD3A21CC62
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386088; cv=none; b=SjfmdVl+B7FrPdWi1uOJ4rF75zNyimHjG/Z3fh7vQxkiYJSBbmv9ZOXUvPyCQ/JqDKCvJDPZ2IE2zUrhXaYEBrPGV/+/ihiVaW8tas+NOr5iSq6epEhv7xjA0wxw7mVgNn+9LzDuoP3kHWDu9YtlVlqu6SUXYEznmmVw4yaoyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386088; c=relaxed/simple;
	bh=Oh8dUEQCJKfdNmue2b0CesizRER3kfd3G69pTJHQFQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+6AxdcJUreOyw8oTolnMyneV6uALnasIHr+a1iCB6GG7F3xAiATdOT0mL/tK94cBVuHwER8ORTsLVya0aUT6Qc00OahHai329dZ2igcH7una/VnX3ftzJszjSu/QyoqL9T5UuILb8/br0bU7ZyCwAm0KN+TtUbzCnksKLil4hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9U5By6U; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9U5By6U"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7426c44e014so4801775b3a.3
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 02:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754386086; x=1754990886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkDHOVeVlBEqkcXxh6qbbhhJuhwO6kRioNiP9CWQMoo=;
        b=W9U5By6UnJ2l9p20u2zgSE6r1NrfKePwmxPDRLQCdKWZpMDEnld5WlA4CGANs/ItdH
         1oZs4QNZV8UQfH/2OtXST7Pb02IT34b5TgYBykSaSt0WnQc/JtFvEhWBTCJ2HxjVUKWS
         bme7iiIIPmZfjockdSJVSVbKWslFPkr+gd34EXA9p2Qm1ba430bbKPI2D3qggwx8WzWq
         Z8NDSMcgezDrOEpn8HJFkZl8zYfAsSYvk6hgq1kP7zik0g2RbMk4b0I3rkUrbb2yKMhi
         1hBttAzBbgt7OhYcRVVbVUYQqxUa3NgE1XefKBKQJisWUvKPgCFnsBb/bvIuode1HcsY
         0Pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754386086; x=1754990886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkDHOVeVlBEqkcXxh6qbbhhJuhwO6kRioNiP9CWQMoo=;
        b=OQRKfaLD0d78YssGGX+LTWCjjii2NSzs30pA12ELQ4FVNKONjNlohclkUwcxedAOU+
         KcgFOsXii0s8+ncihIPQY/CykGf1TX46+TWa9Q+yQs6rdbDYyAf+J1MZfUgjA6U33USX
         n+yHf77oHeKSxbpk8ORZ20bT0AjoNiThfCLbj7ozIWBLvS5WfCQrFwDf7+UdBasJdoLp
         oh+IR92Mo9WzY31g+yCuyxy2626izoWPzLAqip9EXIqugSw1rfe/jVJEiM6CJLbspXPm
         SujGo9sm86DpAOcfLVCg8IKbGouN1buu2LyP/74zXLS0ch7bnGWXysYfiIKhLNY+Qlaq
         vX9g==
X-Gm-Message-State: AOJu0YxqgWXpjrGH09RBc1usVExK3CxtgZjQ98vfQRj1ALE43TDQ1r/s
	6K1K3EU9+cxS4k+MX4/Cbwt/tIAde8OmQzJI+I3Vkd3/sTDcL8RhZr7FEnyKag==
X-Gm-Gg: ASbGnctmslNeq7tNDaH8iptTyUzvBPLZz1SiJ97OlfT+cyR1vqR6eLYx32mRghDd3N3
	dZV04f3g8bPP2CNuazTKv/EDG43HIHHx4V9I2wTBaCd/vh5r/l6PA9YZv8Xg3YG2pE9cGb2R2n3
	j2vK6i53PQHssWdFvSbneOwiwi4k9DI2XiPekDP4QlQypY9GVaWl/PnvkR7BMxudm40m/A+TYAL
	pjLoLon9rAHfBFTRT6WnuNzmwwVbgC+Lwf2WNNU36Rw1rOtjfvCp5ZZlZzYfXm3Xz/d6aLHUOLj
	+EZvKQvTIUnKExOg3dn0PWFy0aAUwnrhDhYlV60q4S3kAosGMPuKBragsGWQ5myGcWl2nap7/61
	f2M0Dv+Bjsln5mdxQlK0=
X-Google-Smtp-Source: AGHT+IEU40itavDqQOmhsshHT353asmdxBOQPbj41Nf+h4jtQXMRZ9OC9Bb8rDEM5qLI8APoV1Oilw==
X-Received: by 2002:a05:6a20:9151:b0:240:27be:bb9e with SMTP id adf61e73a8af0-24027bebd12mr1016931637.37.1754386085547;
        Tue, 05 Aug 2025 02:28:05 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcceab592sm12465691b3a.58.2025.08.05.02.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:28:05 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	phillip.wood123@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v6 0/6] Add refs list subcommand
Date: Tue,  5 Aug 2025 14:57:52 +0530
Message-Id: <20250805092758.5321-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804092255.1092973-1-meetsoni3017@gmail.com>
References: <20250804092255.1092973-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

This is the sixth version of the patch series that introduces the git
refs list subcommand.

changes in v6:
  - rebased onto v2.51.0-rc0

Meet Soni (6):
  doc: factor out common option
  builtin/for-each-ref: align usage string with the man page
  builtin/for-each-ref: factor out core logic into a helper
  builtin/refs: add list subcommand
  t6300: refactor tests to be shareable
  t: add test for git refs list subcommand

 Documentation/for-each-ref-options.adoc |   88 +
 Documentation/git-for-each-ref.adoc     |   89 +-
 Documentation/git-refs.adoc             |   16 +
 builtin/for-each-ref.c                  |   36 +-
 builtin/refs.c                          |   14 +
 for-each-ref.h                          |   26 +
 t/for-each-ref-tests.sh                 | 2141 +++++++++++++++++++++++
 t/meson.build                           |    1 +
 t/t0450/adoc-help-mismatches            |    1 -
 t/t1461-refs-list.sh                    |    8 +
 t/t6300-for-each-ref.sh                 | 2140 +---------------------
 11 files changed, 2316 insertions(+), 2244 deletions(-)
 create mode 100644 Documentation/for-each-ref-options.adoc
 create mode 100644 for-each-ref.h
 create mode 100644 t/for-each-ref-tests.sh
 create mode 100755 t/t1461-refs-list.sh

Range-diff against v5:
1:  d2fa47a2b9 ! 1:  fd4959594c doc: factor out common option
    @@ Documentation/for-each-ref-options.adoc (new)
     +
     +--include-root-refs::
     +	List root refs (HEAD and pseudorefs) apart from regular refs.
    ++
    ++--start-after=<marker>::
    ++    Allows paginating the output by skipping references up to and including the
    ++    specified marker. When paging, it should be noted that references may be
    ++    deleted, modified or added between invocations. Output will only yield those
    ++    references which follow the marker lexicographically. Output begins from the
    ++    first reference that would come after the marker alphabetically. Cannot be
    ++    used with `--sort=<key>` or `--stdin` options, or the _<pattern>_ argument(s)
    ++    to limit the refs.
     
      ## Documentation/git-for-each-ref.adoc ##
     @@ Documentation/git-for-each-ref.adoc: host language allowing their direct evaluation in that language.
    @@ Documentation/git-for-each-ref.adoc: host language allowing their direct evaluat
     -
     ---include-root-refs::
     -	List root refs (HEAD and pseudorefs) apart from regular refs.
    +-
    +---start-after=<marker>::
    +-    Allows paginating the output by skipping references up to and including the
    +-    specified marker. When paging, it should be noted that references may be
    +-    deleted, modified or added between invocations. Output will only yield those
    +-    references which follow the marker lexicographically. Output begins from the
    +-    first reference that would come after the marker alphabetically. Cannot be
    +-    used with `--sort=<key>` or `--stdin` options, or the _<pattern>_ argument(s)
    +-    to limit the refs.
     +include::for-each-ref-options.adoc[]
      
      FIELD NAMES
2:  48a006dca9 ! 2:  1ed0717f6b builtin/for-each-ref: align usage string with the man page
    @@ builtin/for-each-ref.c
     +#define COMMON_USAGE_FOR_EACH_REF \
     +	"[--count=<count>] [--shell|--perl|--python|--tcl]\n" \
     +	"                         [(--sort=<key>)...] [--format=<format>]\n" \
    -+	"                         [--include-root-refs] [ --stdin | <pattern>... ]\n" \
    -+	"                         [--points-at=<object>]\n" \
    ++	"                         [--include-root-refs] [--points-at=<object>]\n" \
     +	"                         [--merged[=<object>]] [--no-merged[=<object>]]\n" \
     +	"                         [--contains[=<object>]] [--no-contains[=<object>]]\n" \
    -+	"                         [--exclude=<pattern> ...]"
    ++	"                         [(--exclude=<pattern>)...] [--start-after=<marker>]\n" \
    ++	"                         [ --stdin | <pattern>... ]"
     +
      static char const * const for_each_ref_usage[] = {
     -	N_("git for-each-ref [<options>] [<pattern>]"),
     -	N_("git for-each-ref [--points-at <object>]"),
     -	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
     -	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
    +-	N_("git for-each-ref [--start-after <marker>]"),
     +	"git for-each-ref " COMMON_USAGE_FOR_EACH_REF,
      	NULL
      };
3:  b7788d477a ! 3:  69f147aa12 builtin/for-each-ref: factor out core logic into a helper
    @@ Commit message
     
      ## builtin/for-each-ref.c ##
     @@
    - #include "builtin.h"
      #include "commit.h"
      #include "config.h"
    + #include "environment.h"
     +#include "for-each-ref.h"
      #include "gettext.h"
      #include "object.h"
    @@ builtin/for-each-ref.c
     -#define COMMON_USAGE_FOR_EACH_REF \
     -	"[--count=<count>] [--shell|--perl|--python|--tcl]\n" \
     -	"                         [(--sort=<key>)...] [--format=<format>]\n" \
    --	"                         [--include-root-refs] [ --stdin | <pattern>... ]\n" \
    --	"                         [--points-at=<object>]\n" \
    +-	"                         [--include-root-refs] [--points-at=<object>]\n" \
     -	"                         [--merged[=<object>]] [--no-merged[=<object>]]\n" \
     -	"                         [--contains[=<object>]] [--no-contains[=<object>]]\n" \
    --	"                         [--exclude=<pattern> ...]"
    +-	"                         [(--exclude=<pattern>)...] [--start-after=<marker>]\n" \
    +-	"                         [ --stdin | <pattern>... ]"
     -
     -static char const * const for_each_ref_usage[] = {
     -	"git for-each-ref " COMMON_USAGE_FOR_EACH_REF,
    @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc,
     -		usage_with_options(for_each_ref_usage, opts);
     +		usage_with_options(usage, opts);
      
    - 	sorting = ref_sorting_options(&sorting_options);
    - 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
    + 	if (filter.start_after && sorting_options.nr > 1)
    + 		die(_("cannot use --start-after with custom sort options"));
     @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc,
      	strvec_clear(&vec);
      	return 0;
    @@ for-each-ref.h (new)
     +#define COMMON_USAGE_FOR_EACH_REF \
     +	"[--count=<count>] [--shell|--perl|--python|--tcl]\n" \
     +	"                         [(--sort=<key>)...] [--format=<format>]\n" \
    -+	"                         [--include-root-refs] [ --stdin | <pattern>... ]\n" \
    -+	"                         [--points-at=<object>]\n" \
    ++	"                         [--include-root-refs] [--points-at=<object>]\n" \
     +	"                         [--merged[=<object>]] [--no-merged[=<object>]]\n" \
     +	"                         [--contains[=<object>]] [--no-contains[=<object>]]\n" \
    -+	"                         [--exclude=<pattern> ...]"
    ++	"                         [(--exclude=<pattern>)...] [--start-after=<marker>]\n" \
    ++	"                         [ --stdin | <pattern>... ]"
     +
     +/*
     + * The core logic for for-each-ref and its clones.
4:  97088dab96 ! 4:  4195415eb5 builtin/refs: add list subcommand
    @@ Documentation/git-refs.adoc: SYNOPSIS
      git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
      git refs verify [--strict] [--verbose]
     +git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
    -+	      [(--sort=<key>)...] [--format=<format>]
    -+	      [--include-root-refs] [ --stdin | <pattern>... ]
    -+	      [--points-at=<object>]
    -+	      [--merged[=<object>]] [--no-merged[=<object>]]
    -+	      [--contains[=<object>]] [--no-contains[=<object>]]
    -+	      [--exclude=<pattern> ...]
    ++		   [(--sort=<key>)...] [--format=<format>]
    ++		   [--include-root-refs] [--points-at=<object>]
    ++		   [--merged[=<object>]] [--no-merged[=<object>]]
    ++		   [--contains[=<object>]] [--no-contains[=<object>]]
    ++		   [(--exclude=<pattern>)...] [--start-after=<marker>]
    ++		   [ --stdin | <pattern>... ]
      
      DESCRIPTION
      -----------
5:  abe9df9c4f = 5:  d3da47e950 t6300: refactor tests to be shareable
6:  a037a47dcd = 6:  df2c3fc720 t: add test for git refs list subcommand
-- 
2.34.1

