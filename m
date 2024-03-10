Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7339FF2
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096421; cv=none; b=ON4QFDf2kosb37HAbxaUVotm7Ip60ocOmgjqMPpZQYR8uOqrnBIv93qVl/B8xlyAVoEFlaPsSVny9dTbT+zAuSTKGpwrwwrr8uWJ0M+naoGHhWDHkj+z0zDJ+31n21qr6H7Zwm5nIqrWgYy/ZdNI0fIoMHju/AakdeV9fCF9KE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096421; c=relaxed/simple;
	bh=gdyQppQKtCSq/8vYTiPDA7ZnBOru0GYFa+eCGINXKxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbnC7Tm3kSNzMCvYkFot3skMcPF3x/WGqvqaethlWeOx+gNiNI5Euhg10+RCm5dAptWWWh6Bx3e0VzIDHMbn6WX2dtPlk24zksJP3/N+awpxvI/3WtZWnZoiTnKXya3x4+Zm5qI3htjB6AMg3L58wgdUoH6AyFKOtWUjoY/22X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkRQEq84; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkRQEq84"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e4e8be9c85so1858972a34.3
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710096417; x=1710701217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8k1COni+XqQIzsgD7xyUzZ7OREDsONoTKinpbIKpCe8=;
        b=MkRQEq846nr4QE9guUYq5DV9mbHJ/Gc36aDQi03xeaJwmoeEJHcxLoymHgpx1/fqgq
         KC5goF8SRXWiHwdjKrwLikvEbHhWk3YpfHzKQl8MqtpCj7AiBZQLgLbJK7wdFIxGFejx
         ST1bJHdleUaYt4CbsqHbdK9ymbsBsQpRxDayvHPK3+r/hoAM/iLDo7yPblfDxBrtykGq
         RIZT92/qwJ+eUzFJYiwsN8FOOXTfOzrG5MruXwk/yXRd6bzIiuOqx+oQpeFRzF0Xadfl
         3p82U5xp1ECx7aaPDLA2yNCCwQKPQav/2i6hBKH9TAIDNJskz8ydx6ohaAZXXw3UpJH4
         MM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710096417; x=1710701217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8k1COni+XqQIzsgD7xyUzZ7OREDsONoTKinpbIKpCe8=;
        b=OvtYPmVV+hAzj6AXSGSkTbXZUIsKxyCcPK9uJSMR2a01IQ5W+fZIPBoBydoDIhOanS
         Xt6NRhCZTHDpOUPZbwwSBk11O3sbNxlEzsJohVTkmnPjxhxWF8Cq90M2qtEnAaAtnwWO
         Fqt4bX40ALIIvtXS5Fa1mcrDlQerM4ssnt0B12U4hwlXQvPxnLeuEVouYHeJZs9sHafM
         2iFZYzuJFE+uAL36+4jVOGjMwTq8isthsccuHcDdCZMbyuJPyAXLi8WLGVMltpDbIel/
         hTi+7grx+hSTMOYP3ueh0LxXf76h7ohdPtUzE6LF2NAhsZBJNaSJyRwCgOvFrPmTD51g
         5WMw==
X-Gm-Message-State: AOJu0YxAQ9VzlW92d5x9pNnnILiXZYSHiISPvqVqZEtDY43l3IzJVCxg
	EyucT8a0vAYAHLh88vBWAFZZyDSxsKCEGirr49n449pf3TyW/60VSqGzaWNi2f0=
X-Google-Smtp-Source: AGHT+IHe2gg1CAo+Ki3GWkt6emJmGNfxK+uX3wO6aul92p7Nv/PSUqfmMWROCeQ8hKce2NHkej+log==
X-Received: by 2002:a05:6830:349b:b0:6e4:fa76:9eb with SMTP id c27-20020a056830349b00b006e4fa7609ebmr7530126otu.11.1710096417682;
        Sun, 10 Mar 2024 11:46:57 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id l8-20020a0568302b0800b006e4c97ec1f4sm742131otv.69.2024.03.10.11.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:46:56 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v3 3/7] rebase: update `--empty=ask` to `--empty=stop`
Date: Sun, 10 Mar 2024 13:42:02 -0500
Message-ID: <20240310184602.539656-4-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-am(1) got its own `--empty` option in 7c096b8d61 (am: support
--empty=<option> to handle empty patches, 2021-12-09), `stop` was used
instead of `ask`. `stop` is a more accurate term for describing what
really happens, and consistency is good.

Update git-rebase(1) to also use `stop`, while keeping `ask` as a
deprecated synonym. Update the tests to primarily use `stop`, but also
ensure that `ask` is still allowed.

In a future commit, we'll be adding a new `--empty` option for
git-cherry-pick(1) as well, making the consistency even more relevant.

Reported-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/git-rebase.txt | 15 ++++++++-------
 builtin/rebase.c             | 16 ++++++++++------
 t/t3424-rebase-empty.sh      | 21 ++++++++++++++++-----
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0b0d0ccb80..67dd0a533e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -289,23 +289,24 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---empty=(ask|drop|keep)::
+--empty=(drop|keep|stop)::
 	How to handle commits that are not empty to start and are not
 	clean cherry-picks of any upstream commit, but which become
 	empty after rebasing (because they contain a subset of already
 	upstream changes):
 +
 --
-`ask`;;
-	The rebase will halt when the commit is applied, allowing you to
-	choose whether to drop it, edit files more, or just commit the empty
-	changes. This option is implied when `-i`/`--interactive` is
-	specified.
 `drop`;;
 	The commit will be dropped. This is the default behavior.
 `keep`;;
 	The commit will be kept. This option is implied when `--exec` is
 	specified unless `-i`/`--interactive` is also specified.
+`stop`;;
+`ask`;;
+	The rebase will halt when the commit is applied, allowing you to
+	choose whether to drop it, edit files more, or just commit the empty
+	changes. This option is implied when `-i`/`--interactive` is
+	specified. `ask` is a deprecated synonym of `stop`.
 --
 +
 Note that commits which start empty are kept (unless `--no-keep-empty`
@@ -711,7 +712,7 @@ be dropped automatically with `--no-keep-empty`).
 Similar to the apply backend, by default the merge backend drops
 commits that become empty unless `-i`/`--interactive` is specified (in
 which case it stops and asks the user what to do).  The merge backend
-also has an `--empty=(ask|drop|keep)` option for changing the behavior
+also has an `--empty=(drop|keep|stop)` option for changing the behavior
 of handling commits that become empty.
 
 Directory rename detection
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b086f651a..a4916781ce 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -58,7 +58,7 @@ enum empty_type {
 	EMPTY_UNSPECIFIED = -1,
 	EMPTY_DROP,
 	EMPTY_KEEP,
-	EMPTY_ASK
+	EMPTY_STOP
 };
 
 enum action {
@@ -951,10 +951,14 @@ static enum empty_type parse_empty_value(const char *value)
 		return EMPTY_DROP;
 	else if (!strcasecmp(value, "keep"))
 		return EMPTY_KEEP;
-	else if (!strcasecmp(value, "ask"))
-		return EMPTY_ASK;
+	else if (!strcasecmp(value, "stop"))
+		return EMPTY_STOP;
+	else if (!strcasecmp(value, "ask")) {
+		warning(_("--empty=ask is deprecated; use '--empty=stop' instead."));
+		return EMPTY_STOP;
+	}
 
-	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"ask\"."), value);
+	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"stop\"."), value);
 }
 
 static int parse_opt_keep_empty(const struct option *opt, const char *arg,
@@ -1133,7 +1137,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				 "instead of ignoring them"),
 			      1, PARSE_OPT_HIDDEN),
 		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
-		OPT_CALLBACK_F(0, "empty", &options, "(drop|keep|ask)",
+		OPT_CALLBACK_F(0, "empty", &options, "(drop|keep|stop)",
 			       N_("how to handle commits that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
 		OPT_CALLBACK_F('k', "keep-empty", &options, NULL,
@@ -1550,7 +1554,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.empty == EMPTY_UNSPECIFIED) {
 		if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
-			options.empty = EMPTY_ASK;
+			options.empty = EMPTY_STOP;
 		else if (options.exec.nr > 0)
 			options.empty = EMPTY_KEEP;
 		else
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index 73ff35ced2..1ee6b00fd5 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -72,6 +72,17 @@ test_expect_success 'rebase --merge --empty=keep' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase --merge --empty=stop' '
+	git checkout -B testing localmods &&
+	test_must_fail git rebase --merge --empty=stop upstream &&
+
+	git rebase --skip &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rebase --merge --empty=ask' '
 	git checkout -B testing localmods &&
 	test_must_fail git rebase --merge --empty=ask upstream &&
@@ -101,9 +112,9 @@ test_expect_success 'rebase --interactive --empty=keep' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase --interactive --empty=ask' '
+test_expect_success 'rebase --interactive --empty=stop' '
 	git checkout -B testing localmods &&
-	test_must_fail git rebase --interactive --empty=ask upstream &&
+	test_must_fail git rebase --interactive --empty=stop upstream &&
 
 	git rebase --skip &&
 
@@ -112,7 +123,7 @@ test_expect_success 'rebase --interactive --empty=ask' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase --interactive uses default of --empty=ask' '
+test_expect_success 'rebase --interactive uses default of --empty=stop' '
 	git checkout -B testing localmods &&
 	test_must_fail git rebase --interactive upstream &&
 
@@ -194,9 +205,9 @@ test_expect_success 'rebase --exec uses default of --empty=keep' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase --exec --empty=ask' '
+test_expect_success 'rebase --exec --empty=stop' '
 	git checkout -B testing localmods &&
-	test_must_fail git rebase --exec "true" --empty=ask upstream &&
+	test_must_fail git rebase --exec "true" --empty=stop upstream &&
 
 	git rebase --skip &&
 
-- 
2.43.0

