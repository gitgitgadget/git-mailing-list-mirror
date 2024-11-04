Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D041CBA04
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730746972; cv=none; b=lvsPjdCKJZFm3nI6Cw+KYFmDBRpCcM5prcC2/+VAxFwH+JPeFhwKColmkhTZz0LdbIxZp97a7FfKyD+bGv1P13lx6odMuJXVc/Ea2FFUMovVwqUGfWavPiJOvEikngE2tE0UeDWChfji23yL3EYuOiFnrBF2S7u3bzcci0k3vJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730746972; c=relaxed/simple;
	bh=WqNuaxMfp0eFNUEabXhMzeEHCMyqoEuvGLr8oHjlqD0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j6T3yyIXKLknN7+AnMsHQG90CE65B8qqQ0E6KEppIhBFsBU5n7Q6+L9Oziea1qGJfw7egACZySTvjtDKdnyaZ6UW1Rjo9GIXxsmI0cAquSWqqZQ5z9cRbWDptEw8jsiN69QcWhUC807y2v3WuxpKADq+hPYbIweGjc58yhnF8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmpeNCUr; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmpeNCUr"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53b34ed38easo4476241e87.0
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 11:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730746968; x=1731351768; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COZO8z5tG8xj1lNwpmyqcrvTNX7W0LWOgiM6PxLUXIE=;
        b=BmpeNCUrDOuY9r///PblDWEimedUywVgu8t/zn8w3Sxgw01og0m2eX6Wt7BIR9zknT
         YCAK86EZR+rY5vMzLd72LfKcoHP/FRzSHA4H3rytJBaTCExjSrydNY1x9cNl596yer2O
         jArom5xVFK135gQaogfQdj7f4EKYH+id/KOD6HNBCIZ1NIq1tV8DHg6ft++XexOkrdyK
         DEBmY5R1woPUw+BR73TW4WIEh4LPWhwSJyoWJOjDYiZ/HIPE/vcYfGdsQHNXuOrYpTQm
         ve2xo3pJfo4ILyqPPKQxQd0xiXtX6JXRMpm0/k9n72/she5MHnNvgH+Zaznbn4uPsah+
         QPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730746968; x=1731351768;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COZO8z5tG8xj1lNwpmyqcrvTNX7W0LWOgiM6PxLUXIE=;
        b=jg8Gb9sJrGA6MjEr1movJIoNDfR9855BK3cJVAaik1H2K8c2tnef4K+aXC34ma7/lC
         OWnXRPoGx3wRBsPIVSdbKD8ymSaYZ//oM8bqXOtd/Zi1HcaIhhWt90EHaK9aUc6u2xOj
         mZ6J/xqzTUODnIo00gc/snPbGggpsqMclFmLlUYtBbGaQTazgrYJbR7KZ/B+D4j3+5wz
         ZeSSV/3yJZlkxe46ajdXCR8lgAvF4DT3PGeVdIJN9eUTYEP3neSbSRBeohkgt7a7OL3b
         Jw4TkSDGjTcbybCPI4+2hJhywZvU2S2xD0DtUfpTyogfKf0zk+mHT2R4807V/7fewaw0
         8Enw==
X-Gm-Message-State: AOJu0Yxd/7Rq4t8jYA5LZA/bEFlE3o/h54BKTaZrJfae3BXDj4B8Y8cJ
	rGyXrLgih4U7JHqht+EDSz+aZ5EyftUJcaT2h4wPmMz5uVIpb6tdtypxwg==
X-Google-Smtp-Source: AGHT+IErjskhcIQg9mbLFz8l1mMNQC1PSeKQz8+edqtGODdrinQJFf7iCD8j/mCNILzn4nb/KOWfNg==
X-Received: by 2002:a05:6512:3d1b:b0:539:f9b9:e6d2 with SMTP id 2adb3069b0e04-53b348e73camr15262106e87.35.1730746967752;
        Mon, 04 Nov 2024 11:02:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7a9esm13909321f8f.21.2024.11.04.11.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 11:02:47 -0800 (PST)
Message-Id: <4c7f2dba686266be50cf11420beca633e1691dd4.1730746964.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1822.git.1730746964.gitgitgadget@gmail.com>
References: <pull.1822.git.1730746964.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 Nov 2024 19:02:44 +0000
Subject: [PATCH 2/2] doc: correct misleading descriptions for
 --shallow-exclude
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The documentation for the --shallow-exclude option to clone/fetch/etc.
claims that the option takes a revision, but it does not.  As per
upload-pack.c's process_deepen_not(), it passes the option to
expand_ref() and dies if it does not find exactly one ref matching the
name passed.  Further, this has always been the case ever since these
options were introduced by the commits merged in a460ea4a3cb1 (Merge
branch 'nd/shallow-deepen', 2016-10-10).  Fix the documentation to
match the implementation.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/fetch-options.txt  | 2 +-
 Documentation/git-clone.txt      | 2 +-
 Documentation/git-fetch-pack.txt | 2 +-
 builtin/clone.c                  | 2 +-
 builtin/fetch.c                  | 4 ++--
 builtin/pull.c                   | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 9dc7ac8dbdc..b01372e4b3c 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -29,7 +29,7 @@
 	Deepen or shorten the history of a shallow repository to
 	include all reachable commits after <date>.
 
---shallow-exclude=<revision>::
+--shallow-exclude=<ref>::
 	Deepen or shorten the history of a shallow repository to
 	exclude commits reachable from a specified remote branch or tag.
 	This option can be specified multiple times.
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 116ad648201..7acb4cb1761 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -255,7 +255,7 @@ corresponding `--mirror` and `--no-tags` options instead.
 `--shallow-since=<date>`::
 	Create a shallow clone with a history after the specified time.
 
-`--shallow-exclude=<revision>`::
+`--shallow-exclude=<ref>`::
 	Create a shallow clone with a history, excluding commits
 	reachable from a specified remote branch or tag.  This option
 	can be specified multiple times.
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index b3467664d30..b5223576a75 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -91,7 +91,7 @@ be in a separate packet, and the list must end with a flush packet.
 	Deepen or shorten the history of a shallow repository to
 	include all reachable commits after <date>.
 
---shallow-exclude=<revision>::
+--shallow-exclude=<ref>::
 	Deepen or shorten the history of a shallow repository to
 	exclude commits reachable from a specified remote branch or tag.
 	This option can be specified multiple times.
diff --git a/builtin/clone.c b/builtin/clone.c
index 59fcb317a68..93fe6d69659 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -147,7 +147,7 @@ static struct option builtin_clone_options[] = {
 		    N_("create a shallow clone of that depth")),
 	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
 		    N_("create a shallow clone since a specific time")),
-	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("revision"),
+	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("ref"),
 			N_("deepen history of shallow clone, excluding rev")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
diff --git a/builtin/fetch.c b/builtin/fetch.c
index d9027e4dc92..18eff4e5fa1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2216,8 +2216,8 @@ int cmd_fetch(int argc,
 			   N_("deepen history of shallow clone")),
 		OPT_STRING(0, "shallow-since", &deepen_since, N_("time"),
 			   N_("deepen history of shallow repository based on time")),
-		OPT_STRING_LIST(0, "shallow-exclude", &deepen_not, N_("revision"),
-				N_("deepen history of shallow clone, excluding rev")),
+		OPT_STRING_LIST(0, "shallow-exclude", &deepen_not, N_("ref"),
+				N_("deepen history of shallow clone, excluding ref")),
 		OPT_INTEGER(0, "deepen", &deepen_relative,
 			    N_("deepen history of shallow clone")),
 		OPT_SET_INT_F(0, "unshallow", &unshallow,
diff --git a/builtin/pull.c b/builtin/pull.c
index 388ef3d1306..edc56907aa2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -218,8 +218,8 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU_ARGV(0, "shallow-since", &opt_fetch, N_("time"),
 		N_("deepen history of shallow repository based on time"),
 		0),
-	OPT_PASSTHRU_ARGV(0, "shallow-exclude", &opt_fetch, N_("revision"),
-		N_("deepen history of shallow clone, excluding rev"),
+	OPT_PASSTHRU_ARGV(0, "shallow-exclude", &opt_fetch, N_("ref"),
+		N_("deepen history of shallow clone, excluding ref"),
 		0),
 	OPT_PASSTHRU_ARGV(0, "deepen", &opt_fetch, N_("n"),
 		N_("deepen history of shallow clone"),
-- 
gitgitgadget
