Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7EF3563C7
	for <git@vger.kernel.org>; Thu, 21 May 2026 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403214; cv=none; b=g2NsstZtlu7RnLmZ+fYMnxkx6+Ov0NGeE1pvnYJQ3GSOdvE3a7FL2GX/1lNpYchyGLVlhk6DmLvvi42E1xhg4ZYK3p4WBB3eVxsfFULZRIq8vVK+EjVm0RaV8WpMcfC2tccukL0p+2UYfWcc9UyT/hjm0HQMnjwiT+8kxJ+5G+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403214; c=relaxed/simple;
	bh=jPGLVU8QNJaYvAQMC35Qh1vbuD8ZrCvhi8caG47nrqo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ic/n6t726JTUCDrukFaq+oX6f+NTEsr1wMCgi7mE2T15tNlfNinGGX90KPeuo+HRygT97WJzm0AAaeZHft5h9S6T+FE87SpSUksnPIpqJVFq/myMBsWkTp9OcRIt7y8d997DJlAULPHcjOc/Esx+OJlmJsLSs6TlqjE2alLBOLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBNM5Mwp; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBNM5Mwp"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso4724693eec.0
        for <git@vger.kernel.org>; Thu, 21 May 2026 15:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779403211; x=1780008011; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPvXra4n1EpVsRzNZbMA7Hka0+dRSeGicyxtbf55EE8=;
        b=bBNM5MwpipyOFipQVirBYrlnLJAJqH3+qjAP6lGYtfS33snGhJ4pcJuxP6O7GYqvky
         crwjvEq9WAKvhNZShwB5e2dBM/fsvxU3TliYxFkrNY61eb52c1zsZ7D0owp7jJsSykaa
         s4mFOfi57ap19wa2e9SiqRBhJ5ZztAdNt+vfjhBow8gaaLi2dipUIajXhuaHex9S5vy3
         uA1pfZAoF64Aa6oq7BnWJAKQLFn1XR4DYx3aOEBx5MMUMPicCFOYGpKcx+r90k8fNz0/
         e4F6Jw5Dw108T2XQZB1b2DIIiNeT0Nxyxne7oojGEG7NyXEx6k4edb6h/cYTAvElkpW0
         7PwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779403211; x=1780008011;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CPvXra4n1EpVsRzNZbMA7Hka0+dRSeGicyxtbf55EE8=;
        b=NoSQs4IeGwGSJzb3Nv8B9/OrmG3jfAyv4/kjnZgIV0NXVn+Ner16z3P6udpuKVl343
         WJmc0j+0fiUyiqPgmQYVH6n/zyCu2TAXwnuliUg4ImMDG68Z2zBJeHyiYYZ3SROda+ot
         voSRDj9p5X+LeWisQ4NVHXtTh+Twefc0TBI89mUoQMP4CouKk4Ziis7ajnQHgVkClW80
         UuzsYVZqsf+VF5cGBroM8zmgAnXge29ylv5EQ1yQhafXrDLEgmflMGQQe5g0omF/Y+ht
         E0qKM5BxGqgvTXhASIJMvtO5q5HI/flO7k75wd8qNtLaWWB311d/msAtw2EMk6nJ9iF1
         2w/g==
X-Gm-Message-State: AOJu0Yyuc0fvGSkLgizDMCcGHjmd+aDBOYkh7E55UdcclMF3JjIu9J/H
	NC5RDmqdVjhhDDSovNlDi7jRDySacz+HQ5DRqLkWS6+D3r+tjXSDbG7dG4g5dQ==
X-Gm-Gg: Acq92OF6f3ZXVskApl9VNAHmST65dhfKDKlLbmlCn6mEYYjPXUn1OZfcPcppMyYsZPd
	Phf9vAZz1THZ6Fu8IBA1dAednhaeHunt24+dIMtrB//C72EbPTAw3SDUvULftlAa/kV7NDqsEhw
	4N7x1kNiDJSP5ILvbylkWl0GMAq3yXZrpS8ilE0jtVeyi3CcEGSe4x++DHt9gZQhajEmC3TtOU+
	JWIgG0XBob/YK9hpSioyAOYnJuHelXHw5NpZUQCZCIOSw/KTrlY7TedeIAAPA4VNkgD9pVv5Lt6
	qUB8pEIIt+BEFzP8nSiiD6t+Jm40sq1skoVKxSCJ2yZLYn2mzNS5G4+LdE3CvPPy4MxjOJGUwww
	ohEXO8sew00/xWbQeCdqEljtsku4h6FCToxEHEZ2os5xEpiNj2Xez/GmM2+YZcXttTIj5tDW3Ni
	XVtJJev1PQvLFDWRNkDFAw0QvotA==
X-Received: by 2002:a05:693c:2c84:b0:2f3:b7b2:cbd3 with SMTP id 5a478bee46e88-3044a41b206mr418594eec.5.1779403211431;
        Thu, 21 May 2026 15:40:11 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.62.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3044b94cc2csm332603eec.22.2026.05.21.15.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:40:10 -0700 (PDT)
Message-Id: <6e38d7af3a08a774f33fdf3e5ab5e22a530ff5dd.1779403204.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
	<pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 May 2026 22:40:03 +0000
Subject: [PATCH v10 3/4] branch: add branch.<name>.pruneMerged opt-out
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

Setting branch.<name>.pruneMerged=false exempts that branch
from --prune-merged. Useful for topic branches you intend to
develop further after an initial round has been merged
upstream.

Explicit deletion via 'git branch -d' is unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |  5 +++++
 Documentation/git-branch.adoc    |  1 +
 builtin/branch.c                 | 13 +++++++++++++
 t/t3200-branch.sh                | 27 +++++++++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..6402b78a73 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -102,3 +102,8 @@ for details).
 	`git branch --edit-description`. Branch description is
 	automatically added to the `format-patch` cover letter or
 	`request-pull` summary.
+
+`branch.<name>.pruneMerged`::
+	If set to `false`, branch _<name>_ is exempt from
+	`git branch --prune-merged`. Defaults to true. Explicit
+	deletion via `git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index a7c0e29e94..247e4daeb8 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -224,6 +224,7 @@ The following branches are always preserved:
   any configured remote (the target of
   `refs/remotes/<remote>/HEAD`) -- typically `main` or
   `master`;
+* any branch with `branch.<name>.pruneMerged` set to `false`;
 * any branch whose upstream no longer resolves locally.
 --
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 29d38e9060..f995f257f0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -822,6 +822,7 @@ static int prune_merged_branches(int argc, const char **argv, int quiet)
 	for_each_string_list_item(item, &candidates) {
 		const char *short_name = item->string;
 		const char *upstream = item->util;
+		int prune_allowed = 1;
 
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "refs/heads/%s", short_name);
@@ -835,6 +836,18 @@ static int prune_merged_branches(int argc, const char **argv, int quiet)
 		if (!refs_ref_exists(refs, upstream))
 			continue;
 
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "branch.%s.prunemerged", short_name);
+		if (!repo_config_get_bool(the_repository, buf.buf,
+					  &prune_allowed) &&
+		    !prune_allowed) {
+			if (!quiet)
+				fprintf(stderr, _("Skipping '%s' "
+						  "(branch.%s.pruneMerged is false)\n"),
+					short_name, short_name);
+			continue;
+		}
+
 		strvec_push(&deletable, short_name);
 	}
 	strbuf_release(&buf);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c8589cd3a6..b35189ce84 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1937,4 +1937,31 @@ test_expect_success '--prune-merged requires at least one <branch>' '
 	test_grep "at least one <branch>" err
 '
 
+test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
+	test_when_finished "rm -rf pm-optout" &&
+	git clone pm-upstream pm-optout &&
+	git -C pm-optout branch one one-commit &&
+	git -C pm-optout branch --set-upstream-to=origin/next one &&
+	git -C pm-optout branch two two-commit &&
+	git -C pm-optout branch --set-upstream-to=origin/next two &&
+	git -C pm-optout config branch.one.pruneMerged false &&
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
+	git -C pm-optout-d config branch.one.pruneMerged false &&
+
+	git -C pm-optout-d branch -d one &&
+	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
+'
+
 test_done
-- 
gitgitgadget

