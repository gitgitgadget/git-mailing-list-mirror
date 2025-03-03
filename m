Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D8D23BFBB
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018319; cv=none; b=QpFpPbQptmVaMpL5xMnfOWWIDCE9hqsaWFSeb4D09qg40yorCsYcWE40r9JDuouFl2QQTemoIpaQNELfmJU3hqsfTKQwm5bc+u47dU46cTgzQPymJfvnAiIzunAkX+d1hrFzHyAjby0kjx+HHQnAmvFvt+IfI24+8J97d54sy5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018319; c=relaxed/simple;
	bh=OhmJD+1lgtPti5EyxrR7HOMdazlnCYMmbOtJ/TS9jyg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=CQFzbTHzYEMAWYLz483PEd2JCMpbjDE8k20KIREErGaJqhgM4CCdVdOTg1fOnWA+it5yon/mIbAe4h2/n29TMbvzydeYfzZzcybaMOGW/kb4qFWOJg02hWKWNeMzCgDppfs2pssDeTba5gboQCzlzjkMMmXc5vRT5fpSYLiABmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZdWnan1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZdWnan1"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3910e101d0fso691483f8f.2
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 08:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741018312; x=1741623112; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lqj4aPvDcmmFs4zrdhb2+5Il4hyxZHpEREXZiiPJBu4=;
        b=MZdWnan17lXZ5B6VwIfZyCDEhAVmE155x++IydLB3AVPNHDSx4SmruzzPiwEigtzZz
         OZYrzZ+VuGLOTgS1UybSdWlPvNCYY3H4nkHuF+abbnhYytZXPC+H8QZVUt09aP3+xV/s
         MzUuxV5SqSyBOB8//EoRqa7ToITQHincE4NOD554QoAEBfz1FU7KPdzoYqo2sPw0gKMq
         acXlhuAJ3gdfb2x5ndsJBBRsC4t21DOAOXSoo0vsJPmuz1HdKMd1zDKdQtYKcOp1GiTq
         q79Wo4J7PQHQ+pEuxmNy9A8EdnVJA3JAYhOg1fBnXmMbTKO2jjWjHzupSafPjSOwTPEl
         xvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741018312; x=1741623112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lqj4aPvDcmmFs4zrdhb2+5Il4hyxZHpEREXZiiPJBu4=;
        b=lO5KIF/qq1rY2EN1NZkxalmAte6HUjh4bpDjjpDsDoy4sw2dbF8Zn3uuCbVxpJd2Oc
         oS0MyF7UmJLIwno3aar31d8q1xDREuaAnbhNZe0wr/z2Wtzk8NFwi03fUAMWDlxBtdUB
         GvBmDfcs0qM9m+EKk73PcSqGigFawZ8j6M9i/7K6FOZ/UrsdVPvDa2VpI/tYY4WGnhb5
         enUX5bc34jzlPy00pZgJ8yxpRregubVwZqE55rMra7J5iwgDyUjx5jbXlzlSBf2J04kn
         3UJeiwFjLtvUs1YJ1GXZDHnGlxO4osZm1AXy6j4iO5VDpfrsnSjFvPONV//JVGxXlpiU
         H38A==
X-Gm-Message-State: AOJu0Yy6k5YqZTO1MfmQf4itFdY4UCSZ1x0jhZPnpd5Ism0seStzS4pT
	ybEZy26gkCDXWtPLyo8RXbjPLJeck0u88E+YbQgjsc7oHTFkuDUKt/645g==
X-Gm-Gg: ASbGncuok5sYxMYSPnKDhqRGGn4K7/HOqFtOv8tvAHsPZMQjGg+ySeLttxGzvHGUDnQ
	DCHUQswcPvrZ0ZvO5NEShQ20mOYrXZrOWFRdVXHztZhA2e+3IlzwE79c2+AMT6sQZb2X4w+Lw4D
	shFcsEVundHWLNlXCdASsoK09VVHLOYjUh82oerEBwxV0TBthSBlhFOYwyzDeQqrF1cD/APgvPG
	7B5NqE8/zbnImhKGKpGaOeAQlSAtjcCOPBoWmpWLk6NfLSnl3wmSRlHZVUAAm8O6sb8QFkeSJa8
	WCPsHqN92ffI3mZlmhnN/mdy2WsDoVcQ6yOfWE/iKdf3bA==
X-Google-Smtp-Source: AGHT+IEJCAHazxPcuwDljsHboDpg6IQkCUT8yuBbKAbwVWJnm5psgzBkqpbGy26HwKJoSglXck/hBg==
X-Received: by 2002:a5d:47a7:0:b0:391:225:9521 with SMTP id ffacd0b85a97d-391022597dcmr6180604f8f.38.1741018311670;
        Mon, 03 Mar 2025 08:11:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e486eea3sm14669534f8f.101.2025.03.03.08.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:11:51 -0800 (PST)
Message-Id: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 03 Mar 2025 16:11:50 +0000
Subject: [PATCH] docs: fix repository-layout when building with breaking
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
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Since commit 8ccc75c2452 (remote: announce removal of "branches/" and
"remotes/", 2025-01-22) enabling WITH_BREAKING_CHANGES when building git
removes support for reading branches from ".git/branches" and remotes
from ".git/remotes". However those locations are still documented in
gitrepository-layout.adoc even though the build does not support them.

Rectify this by adding a new document attribute
"without-breaking-changes" and use it to make the inclusion of those
sections of the documentation conditional. The name of the attribute is
based on the similar test prerequisite added in c5bc9a7f94a (Makefile:
wire up build option for deprecated features, 2025-01-22).

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    docs: fix repository-layout when building with breaking changes
    
    I copied the name from the test prerequisite as I didn't want to have
    different names for condition used in the tests and documentation. I do
    have some reservations about the naming though as it means we end up
    having to use ifdef::!without-breaking-changes[] or test_expect_success
    !WITHOUT_BREAKING_CHANGES to document and test breaking changes which is
    a double negative.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1871%2Fphillipwood%2Fbreaking-changes-documentation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1871/phillipwood/breaking-changes-documentation-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1871

 Documentation/Makefile                  | 4 ++++
 Documentation/gitrepository-layout.adoc | 4 ++++
 Documentation/meson.build               | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a734c6d6243..53a05eb8030 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -221,6 +221,10 @@ asciidoc.conf: asciidoc.conf.in FORCE
 	$(QUIET_GEN)$(call version_gen,"$(shell pwd)/..",$<,$@)
 endif
 
+ifndef WITH_BREAKING_CHANGES
+ASCIIDOC_EXTRA += -awithout-breaking-changes
+endif
+
 ASCIIDOC_DEPS += docinfo.html
 
 SHELL_PATH ?= $(SHELL)
diff --git a/Documentation/gitrepository-layout.adoc b/Documentation/gitrepository-layout.adoc
index 6348ef1dcdf..62ef1c98c26 100644
--- a/Documentation/gitrepository-layout.adoc
+++ b/Documentation/gitrepository-layout.adoc
@@ -152,6 +152,7 @@ config.worktree::
 	working directory in multiple working directory setup (see
 	linkgit:git-worktree[1]).
 
+ifdef::without-breaking-changes[]
 branches::
 	A deprecated way to store shorthands to be used
 	to specify a URL to 'git fetch', 'git pull' and 'git push'.
@@ -164,6 +165,7 @@ branches::
 	"$GIT_COMMON_DIR/branches" will be used instead.
 +
 Git will stop reading remotes from this directory in Git 3.0.
+endif::without-breaking-changes[]
 
 hooks::
 	Hooks are customization scripts used by various Git
@@ -231,6 +233,7 @@ info/sparse-checkout::
 	This file stores sparse checkout patterns.
 	See also: linkgit:git-read-tree[1].
 
+ifdef::without-breaking-changes[]
 remotes::
 	Stores shorthands for URL and default refnames for use
 	when interacting with remote repositories via 'git fetch',
@@ -241,6 +244,7 @@ remotes::
 	"$GIT_COMMON_DIR/remotes" will be used instead.
 +
 Git will stop reading remotes from this directory in Git 3.0.
+endif::without-breaking-changes[]
 
 logs::
 	Records of changes made to refs are stored in this directory.
diff --git a/Documentation/meson.build b/Documentation/meson.build
index ead8e482131..4e4fca283c1 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -283,6 +283,10 @@ elif docs_backend == 'asciidoctor'
   ]
 endif
 
+if not get_option('breaking_changes')
+   asciidoc_common_options += ['--attribute', 'without-breaking-changes']
+endif
+
 git = find_program('git', required: false)
 xmlto = find_program('xmlto')
 

base-commit: 03944513488db4a81fdb4c21c3b515e4cb260b05
-- 
gitgitgadget
