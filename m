Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5469320A5EE
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171363; cv=none; b=TBChPNxHuLN78lC/n2Tdg45LAfMPtqjzqhdqiRw+A6wJZltkZzeOVHr7QY5ilU1FwTRYFP53T3Q6GYC2JI5HQ5/Rl488eVNArtemFUmLEwqsPb/2igp6KFRHV6UTSoLRpEido6oQ8a25IbEV4E/cLehPrALyIC0BNePITJ1D2qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171363; c=relaxed/simple;
	bh=KI3LWPnhF1eyyZ9iHpjn/u2EGIke/3h7TMJ/XjGAIsY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PHD8qcrOnl72XHm+P9a6hPqq4uCXErnroUiSPELI/moRU0SHS20wPQMUP/2mVx5QZ2C60bZkgosQibFNe1O8Knh7qQCGtwyskuqwggulrYkspWjeXCcKd8/x8D5AAgo9z5PzYrYOJ8KBnVlzKM3oTbFxw0bTBuRbvvfcfA/Lf78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX35HEaB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX35HEaB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bc4b1603fso19780285e9.0
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 02:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741171359; x=1741776159; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGibN8lwMETiRo7TSwdEgZo8tnhI/J2mndF8fnFO0LA=;
        b=GX35HEaBjhEuy1d6yx5jvwkXbB/coPbNy6QaaCu08HfMomnL6RfM0+ep0NupKnRz+K
         i4ugqPeAn2XvcsK8Exg/p8z/UZtm3Ps+z/NYNBGj1tgUIY5yrm67OilxQDB/PpSw6BS0
         K/znAwMXiccd9LT9xj5l3jDSKCOKXCon5/pDi4kV3aZQOm/BisA1dnw7gchs0P/Yt0kI
         KzvBv2WDAbMOVLMm8kwq7Dtp0CtSA/FQarHvWo/8VaS0eDsQ9I7+/UOfB2cOJoNfBl/M
         u9ZxbP9oh+Qnzr7Y+ERXddOVCH7Az3fZD/70M6DKJwUK2epIZXkm6KWT9Vlvp3BLLq9K
         kE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741171359; x=1741776159;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGibN8lwMETiRo7TSwdEgZo8tnhI/J2mndF8fnFO0LA=;
        b=NTD//FY0M4vuY+2LXlEFbK0q6DWmp3GywrMzaOnqTvXERuCJKlGfu/9qjGU/6pSlWq
         bj3SNE4hp5yy5JB3nKpBNmtym/hHvdLS5k1N6gFmCn0cohljkcn5BJsp9Itmrg84Y0EB
         V6TKpyHeI0GVSIlUgJmjRB5uPmAvYecHj9k05YVqyCQuBFqWFchY/0F1cp+ub8WeaLSU
         vKNd/HJILuECyoUjvD7ZCba0mSWMy+C4jVnLXFcq1WikTU0xDsDH9AG5sy1oLEM81VUL
         b+jH0xKhq/jcfda7PWwhlCVueZJe5WdVH48jy5Ubw8ZKOGL08N0JXTwvXmUo9leO7bLT
         du+Q==
X-Gm-Message-State: AOJu0YwT139qoWPPwK4+8Duy1cqgZLBqxFbn1YvvAd7XBgNGqGyuWPi1
	NF63mgvx5P0XcxBax2qJdoZAbEjeMiKbuHhZizyRVqPKxuN2BYU8Eyj6MA==
X-Gm-Gg: ASbGncv3wkNpRbyboVEmr1VV01XqzjhidhDzlzwTESp5H+HjpfZOin8ZlNwey7O5Sf/
	DLuNLx8L/fwrMyVXUHe4R8kd7/QjGLLguy9Xg+7lhI0dU40aqqPJ6IzsChIONjXPb7GPhQWPtzn
	qcP11hJOKOlKd9jKp6yrZtMLlO7Lghz4rNOq+/mTufTTROMjRePb4VsEcpie/RbTm73MPpfnbtL
	ar1UFk6FsSAo3jXu43qcoWOrVQRGYWTd+lErrvvIbcqUQG+/He5gGqUeBWMJP/Paee6qLGVufke
	/Bsap+UjLQMW7poMwwvQ1r9+dnyB2GMpByue4c61qOD+qA==
X-Google-Smtp-Source: AGHT+IG+mNGcNhsDrZEtsvjWg2whCDkxxoYv2DSmwJ5s3rRIOVvNJ2989hwyom2bm/m+ol1cOXUL5g==
X-Received: by 2002:a05:6000:154a:b0:390:d796:b946 with SMTP id ffacd0b85a97d-3911f7c229amr2364154f8f.44.1741171358930;
        Wed, 05 Mar 2025 02:42:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39123deda7asm885761f8f.77.2025.03.05.02.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:42:38 -0800 (PST)
Message-Id: <pull.1871.v2.git.1741171357627.gitgitgadget@gmail.com>
In-Reply-To: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Mar 2025 10:42:37 +0000
Subject: [PATCH v2] docs: fix repository-layout when building with breaking
 changes
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Since commit 8ccc75c2452 (remote: announce removal of "branches/" and
"remotes/", 2025-01-22) enabling WITH_BREAKING_CHANGES when building git
removes support for reading branches from ".git/branches" and remotes
from ".git/remotes". However those locations are still documented in
gitrepository-layout.adoc even though the build does not support them.

Rectify this by adding a new document attribute "with-breaking-changes"
and use it to make the inclusion of those sections of the documentation
conditional. Note that the name of the attribute does not match the test
prerequisite WITHOUT_BREAKING_CHANGES added in c5bc9a7f94a (Makefile:
wire up build option for deprecated features, 2025-01-22). This is to
avoid the awkward double negative ifndef::without_breaking_changes for
documentation that should be included when WITH_BREAKING_CHANGES is
enabled. The test prerequisite will be renamed to match the
documentation attribute in a future patch series.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    docs: fix repository-layout when building with breaking changes
    
    Thanks to Junio and Patrick for their comments on V1. I've renamed the
    attribute to with-breaking-changes as suggested. I'll add a patch to
    rename the test prerequisite to match this when I re-roll
    https://lore.kernel.org/git/pull.1863.git.1740149837.gitgitgadget@gmail.com/
    to use WITH_BREAKING_CHANGES.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1871%2Fphillipwood%2Fbreaking-changes-documentation-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1871/phillipwood/breaking-changes-documentation-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1871

Range-diff vs v1:

 1:  42877011c6d ! 1:  d8dcdca4c2b docs: fix repository-layout when building with breaking changes
     @@ Commit message
          from ".git/remotes". However those locations are still documented in
          gitrepository-layout.adoc even though the build does not support them.
      
     -    Rectify this by adding a new document attribute
     -    "without-breaking-changes" and use it to make the inclusion of those
     -    sections of the documentation conditional. The name of the attribute is
     -    based on the similar test prerequisite added in c5bc9a7f94a (Makefile:
     -    wire up build option for deprecated features, 2025-01-22).
     +    Rectify this by adding a new document attribute "with-breaking-changes"
     +    and use it to make the inclusion of those sections of the documentation
     +    conditional. Note that the name of the attribute does not match the test
     +    prerequisite WITHOUT_BREAKING_CHANGES added in c5bc9a7f94a (Makefile:
     +    wire up build option for deprecated features, 2025-01-22). This is to
     +    avoid the awkward double negative ifndef::without_breaking_changes for
     +    documentation that should be included when WITH_BREAKING_CHANGES is
     +    enabled. The test prerequisite will be renamed to match the
     +    documentation attribute in a future patch series.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ Documentation/Makefile: asciidoc.conf: asciidoc.conf.in FORCE
       	$(QUIET_GEN)$(call version_gen,"$(shell pwd)/..",$<,$@)
       endif
       
     -+ifndef WITH_BREAKING_CHANGES
     -+ASCIIDOC_EXTRA += -awithout-breaking-changes
     ++ifdef WITH_BREAKING_CHANGES
     ++ASCIIDOC_EXTRA += -awith-breaking-changes
      +endif
      +
       ASCIIDOC_DEPS += docinfo.html
     @@ Documentation/gitrepository-layout.adoc: config.worktree::
       	working directory in multiple working directory setup (see
       	linkgit:git-worktree[1]).
       
     -+ifdef::without-breaking-changes[]
     ++ifndef::with-breaking-changes[]
       branches::
       	A deprecated way to store shorthands to be used
       	to specify a URL to 'git fetch', 'git pull' and 'git push'.
     @@ Documentation/gitrepository-layout.adoc: branches::
       	"$GIT_COMMON_DIR/branches" will be used instead.
       +
       Git will stop reading remotes from this directory in Git 3.0.
     -+endif::without-breaking-changes[]
     ++endif::with-breaking-changes[]
       
       hooks::
       	Hooks are customization scripts used by various Git
     @@ Documentation/gitrepository-layout.adoc: info/sparse-checkout::
       	This file stores sparse checkout patterns.
       	See also: linkgit:git-read-tree[1].
       
     -+ifdef::without-breaking-changes[]
     ++ifndef::with-breaking-changes[]
       remotes::
       	Stores shorthands for URL and default refnames for use
       	when interacting with remote repositories via 'git fetch',
     @@ Documentation/gitrepository-layout.adoc: remotes::
       	"$GIT_COMMON_DIR/remotes" will be used instead.
       +
       Git will stop reading remotes from this directory in Git 3.0.
     -+endif::without-breaking-changes[]
     ++endif::with-breaking-changes[]
       
       logs::
       	Records of changes made to refs are stored in this directory.
     @@ Documentation/meson.build: elif docs_backend == 'asciidoctor'
         ]
       endif
       
     -+if not get_option('breaking_changes')
     -+   asciidoc_common_options += ['--attribute', 'without-breaking-changes']
     ++if get_option('breaking_changes')
     ++   asciidoc_common_options += ['--attribute', 'with-breaking-changes']
      +endif
      +
     - git = find_program('git', required: false)
     - xmlto = find_program('xmlto')
     + xmlto = find_program('xmlto', dirs: program_path)
       
     + cmd_lists = [


 Documentation/Makefile                  | 4 ++++
 Documentation/gitrepository-layout.adoc | 4 ++++
 Documentation/meson.build               | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c9a7cf662f0..671267a8ac7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -224,6 +224,10 @@ asciidoc.conf: asciidoc.conf.in FORCE
 	$(QUIET_GEN)$(call version_gen,"$(shell pwd)/..",$<,$@)
 endif
 
+ifdef WITH_BREAKING_CHANGES
+ASCIIDOC_EXTRA += -awith-breaking-changes
+endif
+
 ASCIIDOC_DEPS += docinfo.html
 
 SHELL_PATH ?= $(SHELL)
diff --git a/Documentation/gitrepository-layout.adoc b/Documentation/gitrepository-layout.adoc
index 6348ef1dcdf..7421ef956d3 100644
--- a/Documentation/gitrepository-layout.adoc
+++ b/Documentation/gitrepository-layout.adoc
@@ -152,6 +152,7 @@ config.worktree::
 	working directory in multiple working directory setup (see
 	linkgit:git-worktree[1]).
 
+ifndef::with-breaking-changes[]
 branches::
 	A deprecated way to store shorthands to be used
 	to specify a URL to 'git fetch', 'git pull' and 'git push'.
@@ -164,6 +165,7 @@ branches::
 	"$GIT_COMMON_DIR/branches" will be used instead.
 +
 Git will stop reading remotes from this directory in Git 3.0.
+endif::with-breaking-changes[]
 
 hooks::
 	Hooks are customization scripts used by various Git
@@ -231,6 +233,7 @@ info/sparse-checkout::
 	This file stores sparse checkout patterns.
 	See also: linkgit:git-read-tree[1].
 
+ifndef::with-breaking-changes[]
 remotes::
 	Stores shorthands for URL and default refnames for use
 	when interacting with remote repositories via 'git fetch',
@@ -241,6 +244,7 @@ remotes::
 	"$GIT_COMMON_DIR/remotes" will be used instead.
 +
 Git will stop reading remotes from this directory in Git 3.0.
+endif::with-breaking-changes[]
 
 logs::
 	Records of changes made to refs are stored in this directory.
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 0a0f2bfa14a..594546d68b1 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -284,6 +284,10 @@ elif docs_backend == 'asciidoctor'
   ]
 endif
 
+if get_option('breaking_changes')
+   asciidoc_common_options += ['--attribute', 'with-breaking-changes']
+endif
+
 xmlto = find_program('xmlto', dirs: program_path)
 
 cmd_lists = [

base-commit: db91954e18654eeebc54c900f44c704002e1866d
-- 
gitgitgadget
