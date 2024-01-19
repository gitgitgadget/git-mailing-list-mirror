Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829563DF
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705644813; cv=none; b=TEj3JpH2dy5jOSIIl35AGiLYSFc3y/dDqt1FdesyHR9tLBegkEJpedopxdjq7l4k71QVg6NlKnPHijEyh8UHJkNH9xXmUTdkzz2tPDVLgT06baBCuflAwignR1sadFzaANsU2hlBuO+w6NpctPLrFFEPCZUon9lX2XaXWo8ikyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705644813; c=relaxed/simple;
	bh=FnmPdNV9qkpK5L/Hm9TCBTtRlyiJZM2n1V+TheRynpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/PtixhOZ2JXuO1CT/2iT8A7MTeRjPWudiT3RQ+xAo7kSYvmuXtVqRvl9LgtVpEKztXjcsHheDc0D14WLSzxuDLB+qSSoftaaf2Mo0wBgv3PUb6BPWgE6jFWgYSFlMRBNl4kd+9CYZGB3yIeVbc3JDYz42ipbGZSb9jfdNnzbvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdabDEHJ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdabDEHJ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a0ba5098bso2619521cf.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 22:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705644810; x=1706249610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wyqa2iSO+8kP6nLxiKuM+LrUX2b7H7/BR8XaDr6eyZ4=;
        b=fdabDEHJkJs3NP94eB3j1jG0LJ+yvYmN/sx2T1qdc1FXWAksy+cWIr3ccLwEq0AQpN
         tIJJnR78hNf9zQmS5EMexZfiOUO4PX2UVSfszhrKCyjKX2A8FvCu/xd+kfmvM9IbSyAq
         BknW0dGfeY+I4gPAtmye5UsIrK+2QgNocpep4x9Y+UfpncSRN8QdD4JEBOdjbWtMTwu6
         Oj4DcJvS0kPimfiUWk5cZxM7XPOnnRxrsOPhPgK+Kr3Mcj+2akQWHcjTroU7rR9tDBik
         +A2+l8X+2g2e6L4pZ1tvZa0teCricnNqaoRGTvohjIylAqXqltbzHO48wUhD2T7OYI1u
         hqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705644810; x=1706249610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wyqa2iSO+8kP6nLxiKuM+LrUX2b7H7/BR8XaDr6eyZ4=;
        b=ghvy4nSB6o+uzLb+nDnctS7lvm5zmg7PQCNaYMnT8wOnpmumJj7JeKsWUcZyVtSYmF
         6tK8QHtCQ9xaCVKPoGONW5oXxuxticKWpRfgi9zTSWeao3OT+igAMmQ8+SzHDYPR4KfH
         /k6UAWcQiDY8lN6hVV4n0pKfX91oHAUHqgIkeDLFDUxmLI6mA3fAVgdDVYrbHlsBpPsO
         jYCBAXr0Hgkw9JU0I7S/7mHOm/jbEh8J6zeGUN7SgoiDZbM8MGXEnR0v+dJP+VAdntHj
         /KCDPAVPaOvoSb0ynxypJh2yjzymtoQDiH0owvJTghzft1H17XOsp0Q/HykVRYRP3GjQ
         8Ivw==
X-Gm-Message-State: AOJu0YwKIiMWbWFD4enTbleBkCloxmTcxPhob+wO72NuD/kQvW26WFli
	/MG+wI+DTGZisNUzCPxtvOxyn6K7f27ONZhJMOrDbhyA+VJLlB5+bminKqQa
X-Google-Smtp-Source: AGHT+IGKRGp3NrCcGYweIrOGqjJy9kAGzzxdbx0GX6mx5aJRc1SyvxLEVg+yhcrg7fYYErxpp7mewQ==
X-Received: by 2002:a05:6214:400b:b0:681:2bf:2053 with SMTP id kd11-20020a056214400b00b0068102bf2053mr2113600qvb.112.1705644809708;
        Thu, 18 Jan 2024 22:13:29 -0800 (PST)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id op23-20020a056214459700b0068189a17598sm1365062qvb.72.2024.01.18.22.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 22:13:28 -0800 (PST)
From: brianmlyles@gmail.com
To: git@vger.kernel.org
Cc: me@ttaylorr.com,
	newren@gmail.com,
	Brian Lyles <brianmlyles@gmail.com>
Subject: [PATCH 3/4] rebase: Update `--empty=ask` to `--empty=drop`
Date: Thu, 18 Jan 2024 23:59:19 -0600
Message-ID: <20240119060721.3734775-4-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Lyles <brianmlyles@gmail.com>

When `git-am` got its own `--empty` option in 7c096b8d61 (am: support
--empty=<option> to handle empty patches, 2021-12-09), `stop` was used
instead of `ask`. `stop` is a more accurate term for describing what
really happens, and consistency is good. This commit updates
`git-rebase` to also use `stop`, while keeping `ask` as a deprecated
synonym.

In a future commit, we'll be adding a new `--empty` option for
`git-cherry-pick` as well, making the consistency even more relevant.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/git-rebase.txt |  8 +++++---
 builtin/rebase.c             | 12 ++++++------
 t/t3424-rebase-empty.sh      | 17 ++++++++++++++---
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 3ee85f6d86..fe74d0c367 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -289,7 +289,7 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---empty=(drop|keep|ask)::
+--empty=(drop|keep|stop)::
 	How to handle commits that are not empty to start and are not
 	clean cherry-picks of any upstream commit, but which become
 	empty after rebasing (because they contain a subset of already
@@ -300,12 +300,14 @@ See also INCOMPATIBLE OPTIONS below.
 	The empty commit will be dropped. This is the default behavior.
 `keep`;;
 	The empty commit will be kept.
-`ask`;;
+`stop`;;
 	The rebase will halt when the empty commit is applied, allowing you to
 	choose whether to drop it, edit files more, or just commit the empty
 	changes. This option is implied when `--interactive` is specified.
 	Other options, like `--exec`, will use the default of drop unless
 	`-i`/`--interactive` is explicitly specified.
+`ask`;;
+	A deprecated synonym of `stop`.
 --
 +
 Note that commits which start empty are kept (unless `--no-keep-empty`
@@ -702,7 +704,7 @@ be dropped automatically with `--no-keep-empty`).
 Similar to the apply backend, by default the merge backend drops
 commits that become empty unless `-i`/`--interactive` is specified (in
 which case it stops and asks the user what to do).  The merge backend
-also has an `--empty=(drop|keep|ask)` option for changing the behavior
+also has an `--empty=(drop|keep|stop)` option for changing the behavior
 of handling commits that become empty.
 
 Directory rename detection
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 043c65dccd..1fb9d8263d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -62,7 +62,7 @@ enum empty_type {
 	EMPTY_UNSPECIFIED = -1,
 	EMPTY_DROP,
 	EMPTY_KEEP,
-	EMPTY_ASK
+	EMPTY_STOP
 };
 
 enum action {
@@ -963,10 +963,10 @@ static enum empty_type parse_empty_value(const char *value)
 		return EMPTY_DROP;
 	else if (!strcasecmp(value, "keep"))
 		return EMPTY_KEEP;
-	else if (!strcasecmp(value, "ask"))
-		return EMPTY_ASK;
+	else if (!strcasecmp(value, "stop") || !strcasecmp(value, "ask"))
+		return EMPTY_STOP;
 
-	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"ask\"."), value);
+	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"stop\"."), value);
 }
 
 static int parse_opt_keep_empty(const struct option *opt, const char *arg,
@@ -1145,7 +1145,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				 "instead of ignoring them"),
 			      1, PARSE_OPT_HIDDEN),
 		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
-		OPT_CALLBACK_F(0, "empty", &options, "(drop|keep|ask)",
+		OPT_CALLBACK_F(0, "empty", &options, "(drop|keep|stop)",
 			       N_("how to handle commits that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
 		OPT_CALLBACK_F('k', "keep-empty", &options, NULL,
@@ -1562,7 +1562,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.empty == EMPTY_UNSPECIFIED) {
 		if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
-			options.empty = EMPTY_ASK;
+			options.empty = EMPTY_STOP;
 		else if (options.exec.nr > 0)
 			options.empty = EMPTY_KEEP;
 		else
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index 5e1045a0af..e3ddec88a2 100755
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
 
-- 
2.41.0

