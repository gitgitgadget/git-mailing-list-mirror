Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA243ED5B8
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684564; cv=none; b=A4cu5GWS0EdiHR4Zh8ln0fFjqJEktOXTgX4z2L5n0KTUe5+uvYykUuCwtCCXuOT2Q5TO5K/mpjZm1fxG4zxqwkTZeYotE6kZQDRIHbVqw2XCgjGiz0m26ZG7x+S/5xcXJHfMze96PzVXCoiHWeUoBLpnS5Q6CkgsFwNqlBKsC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684564; c=relaxed/simple;
	bh=og0t+/mrDpqul+DNqiVr2U8JEPf2fxdUoLo/p/uq8gg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qAg0sjPxgNf9pl47f8iBQvMlEE6AO+nNxbRi4hejwy9fE2gy7ITREYvc054Ju3+poMUb+cR5Frk6DDG6H9fCbjlN3U4tfRUR8wMcDyoiBqYrLM6upgWXlDwGgmeedZzGrMBY8EoTxbQ1bXLGtvcW/8q1TY5elV7YMad0Rj5seYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCqY/rvr; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCqY/rvr"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30749947917so4583357eec.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684563; x=1781289363; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYGjx7rgV6QN6PIKvomTbNGLBlrUcwrmT2n4c1NmrgI=;
        b=cCqY/rvr0jfAthHnOpBd2ufuNi2rqxxPwhD383XFWQP4yTYF1EH95qobQsN9d+dWer
         +v9VFIzCXVAD+hkIEoGMQdeIiMfHPkypr9mwBe8alAiCB3otCycYmS2P6g6Acz5iurbo
         giE5YabDUBGzW5TUoj0FZRcZWzG/zUXbzRrgPRlcL5Ewge5bKCWHSgWzbLOiW2M7E7Yo
         Y6lu8gPyFrRwsW87gFGTp5x905x0dpwPMXCAJq1O/9IhHHi1XrRDv1WXpNS9YeOqWzFo
         O/jd0GiU7i+K+BGxlcVyxJ62MmtFP50Ze+fwyf4Ryu+dpNuv2OQlO2oWFf70o5wuUsbA
         TmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684563; x=1781289363;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYGjx7rgV6QN6PIKvomTbNGLBlrUcwrmT2n4c1NmrgI=;
        b=EoAGlOUBs2XRoM4nkg3d3gfE4b5fB0RJNzDQvZnSf07OxF5jooKjNJ+rbdZ6j8+asK
         1tM54sLnfqnOwzOojVtAkJtWY1Q9fciEhtCvnVSXlCPrO35J53GnQkE8ZeeGRfpQRXgT
         0mPWF4luvVEKuCNDjMVfWKXQHBezuc58DrGdfESVJG9GbvKGEqXF6B9Nzmn0CqQUvwHv
         nyHs5ngQ4oHTXRs67cmis4II1CRUWTPwMcAH6WBsUvgTCwVogmeFRBY6U5g7DIooVtvh
         9iuRk/FCF50s9gK8EjOvGS+5+Ums2ArDQPuu3HrKYz44Jbi79zJWCmzC9czrdE4O+7Sb
         /9UQ==
X-Gm-Message-State: AOJu0YzjOW+kB/D3k7ztHaamKwQZrI3jzZrkmeH3D4sVcAjj59/io4bt
	6WVN8VKFhH+mgRGYaXBmKm1bqksLuk6L3i/tRbZKZKr7+CNvTTjt//98FNeIJn/3
X-Gm-Gg: Acq92OFNVHDnC6W5ZnFo9c3BLe29uuAoiwvDl17pry+B0xZESIDbHgOiOln8V23m3b1
	V1DOgZyA8EC5/axXQhYYmrevCbOaompNb4dahs9rHwLg3zDRXMQodXmnXs4Y4TutRx+H7UIrCsD
	+Ur0iBOA09wVcJk7FsyvMwqL6eUbuxYw2CLCI9zG8nRol538c1LWKnIfTXnT/hQ5YBDyRQq9Z26
	0b+yHqrQxxDT9zhlGDRQqstqOAI2vWGJE2+yJcnRt1rD6S6aTmgdJwGKPzaiMeRPyoJUUa3oTLJ
	NtemxhgFA96txaHM6naLGNvHROiqVbrjnZ7Y247PjIi2IbKT8TC8XHNHs54KbhPJsURoA2C8FF0
	kq2EwAdo8bIi5gIYHbN/0BmBeh9pPu8iRueP+7xeUtI+MFmNHRimir9m44ATieQwUyZAqBBVW84
	Sj/OA12j6Oi2M5F65TPb9nyn/wk/G6uD6xvyKYV9SYJcvTHw==
X-Received: by 2002:a05:7300:80c7:b0:2ed:e15:c926 with SMTP id 5a478bee46e88-3077b8b5007mr2760132eec.34.1780684562679;
        Fri, 05 Jun 2026 11:36:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df191d0sm12868588eec.21.2026.06.05.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:36:02 -0700 (PDT)
Message-Id: <8e9a735ffe00f3f3efa75110c4ba2594723a1417.1780684553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
References: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
	<pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Jun 2026 18:35:52 +0000
Subject: [PATCH v13 5/6] branch: add branch.<name>.pruneMerged opt-out
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Setting branch.<name>.pruneMerged=false exempts that branch from
"git branch --prune-merged", which is useful for a topic you want
to keep developing after an early round of it has been merged
upstream. Unless --quiet is given, each skip is reported so the
user knows why their topic was kept.

Explicit deletion with "git branch -d" still uses the normal merge
check and ignores this setting.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |  7 +++++++
 Documentation/git-branch.adoc    |  5 +++--
 builtin/branch.c                 | 14 ++++++++++++++
 t/t3200-branch.sh                | 30 ++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..6c1b5bb9cd 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -102,3 +102,10 @@ for details).
 	`git branch --edit-description`. Branch description is
 	automatically added to the `format-patch` cover letter or
 	`request-pull` summary.
+
+`branch.<name>.pruneMerged`::
+	If set to `false`, branch _<name>_ is exempt from
+	`git branch --prune-merged`.  Useful for a topic branch you
+	intend to develop further after an initial round has been
+	merged upstream.  Defaults to true.  Explicit deletion via
+	`git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index fdaccc9662..5c43dc55a8 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -217,9 +217,10 @@ the upstream refs refreshed.
 +
 A branch is left alone if any of the following holds:
 its upstream no longer resolves locally; it is checked out in any
-worktree; or its push destination (`<branch>@{push}`) equals its
+worktree; its push destination (`<branch>@{push}`) equals its
 upstream (`<branch>@{upstream}`), so it cannot be distinguished
-from a freshly pulled trunk that just looks "fully merged".
+from a freshly pulled trunk that just looks "fully merged"; or
+`branch.<name>.pruneMerged` is set to `false`.
 +
 Branches refused by the "fully merged" safety check are listed as
 warnings and skipped; pass them to `git branch -D` explicitly if
diff --git a/builtin/branch.c b/builtin/branch.c
index 7a26447b2a..be4218ded3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -739,6 +739,8 @@ static int prune_merged_branches(int argc, const char **argv,
 		const char *short_name;
 		struct branch *branch;
 		const char *upstream, *push;
+		struct strbuf key = STRBUF_INIT;
+		int opt_out;
 
 		if (!skip_prefix(full_name, "refs/heads/", &short_name))
 			continue;
@@ -753,6 +755,18 @@ static int prune_merged_branches(int argc, const char **argv,
 		if (!push || !strcmp(push, upstream))
 			continue;
 
+		strbuf_addf(&key, "branch.%s.prunemerged", short_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!quiet)
+				fprintf(stderr,
+					_("Skipping '%s' (branch.%s.pruneMerged is false)\n"),
+					short_name, short_name);
+			strbuf_release(&key);
+			continue;
+		}
+		strbuf_release(&key);
+
 		strvec_push(&deletable, short_name);
 	}
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 27ea1319bb..3f7b1fc3d6 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2010,4 +2010,34 @@ test_expect_success '--prune-merged takes positional <branch> arguments' '
 	test_must_fail git -C pm-positional rev-parse --verify refs/heads/two
 '
 
+test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
+	test_when_finished "rm -rf pm-optout" &&
+	git clone pm-upstream pm-optout &&
+	git -C pm-optout remote add fork ../pm-fork &&
+	test_config -C pm-optout remote.pushDefault fork &&
+	test_config -C pm-optout push.default current &&
+	git -C pm-optout branch one one-commit &&
+	git -C pm-optout branch --set-upstream-to=origin/next one &&
+	git -C pm-optout branch two two-commit &&
+	git -C pm-optout branch --set-upstream-to=origin/next two &&
+	test_config -C pm-optout branch.one.pruneMerged false &&
+
+	git -C pm-optout branch --prune-merged "origin/*" 2>err &&
+
+	git -C pm-optout rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-optout rev-parse --verify refs/heads/two &&
+	test_grep "Skipping .one." err
+'
+
+test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
+	test_when_finished "rm -rf pm-optout-d" &&
+	git clone pm-upstream pm-optout-d &&
+	git -C pm-optout-d branch one one-commit &&
+	git -C pm-optout-d branch --set-upstream-to=origin/next one &&
+	test_config -C pm-optout-d branch.one.pruneMerged false &&
+
+	git -C pm-optout-d branch -d one &&
+	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
+'
+
 test_done
-- 
gitgitgadget

