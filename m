Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3798D2E36E7
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 06:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253002; cv=none; b=ae/7vdDUI4lyiXoXdDXYk57EnhnWfNq3T5ulbwGPcK+4vFMXD3GMTtWM/7uuBlnSzi35bZo+8gVbOmwmV+RHsUO5ADphOzlH4mrt3PH4fad/Ne4z4vecO04bddea6VEFkDvWi8jS+vsMz4Gy2P84NMlpart9+kmf2oOtF5rtJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253002; c=relaxed/simple;
	bh=n3Lx+tXZpACra+4+mnwzgn+EpMF0++/bgy5upzAExNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ny0Mzsx9wnSDna7018m1qFjRvz8AeWXf6Q1hiktKAHzMLA8+nbbwJr8fhEU24qhVk3kjbTt98yv12nScthb21NGJsREqOoNSED86vAFGZx2UypJwwdtFW/T5UngJWkQXMzKn27v+kLqgCVIbURJ6a6dDJROOHjCgfp4oiK6xZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLjN1uSO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLjN1uSO"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7426c44e014so5792877b3a.3
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 23:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753253000; x=1753857800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GpB/f/utxANJcw1ZgtiLiRqyTauXpDKS3yU0mppyts=;
        b=VLjN1uSOWRBYDqWDy9hroSspthrOSw6gdJZ/Dm9M8747NDk9urbDKek//cYtDxoFTG
         FeTMwa3WwKyVChwzoHl5ZfzsjdSJf2Yx1UND+YsTT4YUE2QnmOjwkfN79w4YGyJmKFnx
         9oqZ0qhRKX/0ACfej5ThcpwTEs5W7xTnmB+/gNxs4gUeMBpfk57o8pgtjRzOoSziQMcH
         9CHHaK1S+HotnWlHXm5cTv1HPoN8o0YR/edQYiUcOkWkGAWvYIQJUDxWtW6Vgy27LQaJ
         my8UfrGzZTJHBKtmN0BInueqxbPwhqHxRvSnsd7hZ1kQfwCIyJmeQd6RZNjutypx8J0l
         wodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753253000; x=1753857800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GpB/f/utxANJcw1ZgtiLiRqyTauXpDKS3yU0mppyts=;
        b=ho9NDqDmKkPXfWETcorYXnxAxN4R2iJ3FwEDFQKFfEl9feHDWNoRb4has73oLSHaIp
         og25O45s4y/svgyoVrEPUeGWOOPRxW6CoEJgPWBS1NFxc9+jfPVx7NGYcPoK1jT3Tt4m
         a/VhWFlGDXTiRL+lSGMN+GwGHuoTG6RVQ5MMoEriEnHzFG9TngNh9galApuplgUCiD80
         iXEfzQ9RZQnUD2r7ah4inZ7rdnaXo6ZX5vpvPY9HQz2qTOTkO8+SpHgy9XOgaMjg3GeP
         dz3HkhlGxvm4GR+bukL8kRelpUCI+eMKNbsDk7NL1pqW8QLTQsDJM1lxoLte9lVNAxDI
         +6Xw==
X-Gm-Message-State: AOJu0YwOq4LzWwheWlO3KSrVkRTHjlv5XENnsoKWyxoegQutMKRXT5hY
	3LsLSKspzDNIW5ZvhCsnMLEq8OU4cGmJiYctx+5jZaqgfSFil8agozmDEHlB/xtU
X-Gm-Gg: ASbGnct2k6Osv2WqrmJh7cHaJe0Q43SdEn8uRG+a6wVl8Sd7VKqPRfwI6Sk/W6QOh8K
	fTtziCuVqfWfsfSvMazh1vDeUM+bjArQZCI/YwdvrNFZmZi0I9eIUEygu5/bitBby6PBB6+q9BU
	4GK91jqqpa0kacqMZIljfyxrMbCTs2FQn+T+vGH4YLDVcipvmCiJD0ptMohHPxg3Y9aFtqmzbuc
	l9LQfkWTju2xDvGpemhbEfCZhx1hSE+2zVFkzzoeI9h8EeeqrSrCOyYlGfPPZrQpyrfcIq3zaip
	kHjGDd7G3nTyvgonauv36KBHujEsM9KRqskU06gTFE5STxakDEsNxo9n76GOWVmSaDqCB0WNU8q
	opQMuFox+gijRMRgEqs39xEnfFWdRIA==
X-Google-Smtp-Source: AGHT+IGBskEbrCR2nHzKmoDD0fqjCOvh6ClDcVOsqu5VBg/flts99jI8sFHdOCCm9v+aU5nEwibP5g==
X-Received: by 2002:a05:6a00:1705:b0:748:f3b0:4db6 with SMTP id d2e1a72fcca58-760357fa254mr2778185b3a.11.1753253000214;
        Tue, 22 Jul 2025 23:43:20 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2b48sm8996354b3a.19.2025.07.22.23.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 23:43:19 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][RFC PATCH v3 0/3] Add refs list subcommand
Date: Wed, 23 Jul 2025 12:13:10 +0530
Message-Id: <20250723064313.29866-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717075009.26262-1-meetsoni3017@gmail.com>
References: <20250717075009.26262-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

This is the third version of the patch series that introduces the `git
refs list` subcommand as a modern alternative to `git for-each-ref`.

Thank you to everyone who provided valuable feedback on the patch
series.

Changes in v3:
  - Restructured the patch series from two commits into three, providing
    a cleaner separation between the feature implementation, the test
    refactoring, and the new test itself.

  - Reworked the testing approach to follow the established pattern for
    shared tests (like git-blame/annotate). The core test logic now
    resides in a shared file (`for-each-ref-tests.sh`), which is sourced
    by both the original `t6300-for-each-ref.sh` and the new
    `t1461-refs-list.sh` test drivers.

  - Adopted the suggested `$git_for_each_ref` variable convention in the
    test suite for better clarity and to demonstrate the drop-in
    compatibility.

  - Removed unwanted comment.

---

(v1 cover-letter text)

This patch series introduces `git refs list` as a modern replacement for
`git for-each-ref`, as part of an effort to consolidate ref-related
functionality under a unified `git refs` command.

Git's ref-related operations are currently handled by several distinct
commands, such as `git show-ref`, `git for-each-ref`, `git update-ref`,
`git pack-refs`, etc. This distribution has a few practical drawbacks:

- Users need to rely on multiple commands for related tasks involving
  refs.

- The commands may differ slightly in behavior and option syntax,
  leading to inconsistency.

We propose a long-term consolidation effort to bring ref-related
subcommands under the umbrella of a single command: `git refs`.

The implementation of `git refs list` is functionally identical to `git
for-each-ref`. It reuses the same internal logic (cmd_for_each_ref) to
ensure complete backward compatibility. The purpose of this patch is not
to introduce new behavior but to provide an alternate entry point under
the consolidated `git refs` namespace.

The motivation behind this change is twofold:

- Consolidation: Centralizing ref-related operations makes them easier
  to discover, use, and maintain.

- Evolution: While the initial goal is parity with existing commands,
  this consolidation allows for careful reconsideration of which
  features are essential. Over time, we can:

  - Remove legacy or obscure options that are no longer needed.
  - Add improvements that wouldn't make sense to bolt onto legacy
    commands.
  - Offering a more consistent and user-friendly surface.

To verify backward compatibility, this patch also includes a test
`t/t1461-refs-list.sh`, which runs the full `t6300-for-each-ref.sh` test
using `git refs list`. The test uses ${GIT_REFS_LIST_CMD:-for-each-ref}
to allow substitution without duplicating tests.

This patch is deliberately conservative: it introduces no behavioral
changes and leaves `for-each-ref` untouched. The goal is to lay
groundwork and demonstrate viability of ref consolidation within `git
refs`.

Going forward, I'd like to initiate a discussion on what the ideal
surface of `git refs list` should look like. Which options and features
from `for-each-ref` should be carried over? Are there any that are
obsolete or overly niche? What improvements might be worth considering
now that we have a new, consolidated interface?

Feedback on this, especially from those who rely on `for-each-ref` in
scripts or tooling would be very helpful.

Meet Soni (3):
  builtin/refs: add list subcommand
  t6300: refactor tests to be shareable
  t: add test for git refs list subcommand

 Documentation/git-for-each-ref.adoc  |   80 +-
 Documentation/git-refs.adoc          |   16 +
 Documentation/refs-list-options.adoc |   79 +
 builtin/for-each-ref.c               |   24 +-
 builtin/refs.c                       |   35 +
 t/for-each-ref-tests.sh              | 2141 ++++++++++++++++++++++++++
 t/meson.build                        |    1 +
 t/t1461-refs-list.sh                 |    8 +
 t/t6300-for-each-ref.sh              | 2140 +------------------------
 9 files changed, 2303 insertions(+), 2221 deletions(-)
 create mode 100644 Documentation/refs-list-options.adoc
 create mode 100644 t/for-each-ref-tests.sh
 create mode 100755 t/t1461-refs-list.sh

Range-diff against v2:
1:  b2d3026520 ! 1:  547b0bbf8f builtin/refs: add list subcommand
    @@ Documentation/git-refs.adoc: The following options are specific to 'git refs ver
     
      ## Documentation/refs-list-options.adoc (new) ##
     @@
    -+// Shared options for for-each-ref and refs list
     +<pattern>...::
     +	If one or more patterns are given, only refs are shown that
     +	match against at least one pattern, either using fnmatch(3) or
2:  2d6534841f < -:  ---------- t: add test for git refs list subcommand
-:  ---------- > 2:  5d5057ff98 t6300: refactor tests to be shareable
-:  ---------- > 3:  b9cb9cdf48 t: add test for git refs list subcommand
-- 
2.34.1

