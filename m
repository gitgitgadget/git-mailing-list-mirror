Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914326ED41
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770345129; cv=none; b=u8n88e0kFBu7FJ3yx/hCM/ElXsOJpC8MfvI5ydYDj4TZNb1GdTxTD+4pgZPthzI6UwKjGH3AWP6vpIFh8vPJ/RX+Y5Slkajd+kfftFlpfWFOtkodp4uryq9a4sXxlJL5Pz/KIbgjZkTcUk0zaZRomgBZVMGIL8XbnlhGR6bHFm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770345129; c=relaxed/simple;
	bh=jvGos0F5iWopsEFl4ZKTPVRbNqOBwsPWVwIDXMP5/eo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FduN2VmkJf6sxN8TQnnGj+sdd55Orj1rLiXzMliZQW1R2UfHxULlgweTiaTbJBPeehEeDfEST8hbyKB6Vn6TAiL/EC6QtLfj5YeL30E0ahuoyiFbqkRwoCzjF5VcsXhQy0aoere4ldP1UQCWFCDI5HfSPInnwQcMhXx9h24NUFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8Sg2Qab; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8Sg2Qab"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b704f08e73so942715eec.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 18:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770345128; x=1770949928; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N+KQH7lkAQmYwgkg5BZsb6v75YTdREmrEu7xz7yiCs=;
        b=N8Sg2QabcDWcdfaKDo8KB9oSiESSlCnCGueUCzeiFMEC7Ud0UhvM4/HQictTN23RbY
         OQANKu1+dVPUS7XpfC0fhkOX97slrG/FJHxO8aMAsKoFP7hm/ZFUI7rtxonElyvIkq/N
         eoNxxuo+BBTyYZnL8LgnzbfCT/6fkdVqfXSj1KcnT1Mwx7aBFzjn3lfm//NYOvE0aKg0
         Pln3jIZ4ge1HfPcRjvxSUNUomJI4hJOzBgxFZjhauAlu4ti0aDe5ev6JdUvr/AOehw09
         esaYZ6rObRUtoQVQwxxzmfVSm+dQlYwZDxmplD6rEp4l1V6QjRmAWel2SI4g00RWVm9Q
         8WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770345128; x=1770949928;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3N+KQH7lkAQmYwgkg5BZsb6v75YTdREmrEu7xz7yiCs=;
        b=ct/VG6cwcxmmZ+PQCTsvZuormBQPJXBX9B6HKWRmk2ZLWyEkGoAVZeyIypSz8RXGPX
         Rl0rkKKghAQsvS7CjxvhxrRoU6II28EqCxTEaVeRbSPs9X/7IjstPHtYZYdjOCVO29aH
         XPvwIOsfpGI0giNr1WFVAU+BCzwsLgAKgRysd/bUtQ2vGrRNtT4QrV474heRst09ZMF6
         pfRAcWYZENS+2aimv+0X10wG23ghIztqVObMD3moFwNf9u8Y0UCV5KZp9IZ9QkKaEMiy
         wo0USsWkUt1PDO+c7U1tGKRbdvchOuNOlVqqD0qtHA1EfMemfKYqbWGq8//syyTd4gTz
         1P/Q==
X-Gm-Message-State: AOJu0YzjKJ+l0WLw1g/E42Mme6U+9SwEiRQLmPUZgZNdZ9RKtjVoTwvv
	lEpbkcUr3sK/N/UvV/cspTA6SDCGkhHRFIVMkGHQizYYDwIpu4/khO7b2HtgaK9c
X-Gm-Gg: AZuq6aL/JMkm0rXqNtwFWHv8h0ujQ+l7I89N17kmg0h50e1YlfZMMcofKT95y7BDMmM
	Jk2wYEXJ6v5LobBcPa+Ac51Hp41/tq8V5WKdgVxv08vw4TZv1s4ZnZZ9t7K0GnnjDhz1lSw2Igl
	sfJl1isxQUPGOjkSpijPIeA3snHfVFeslFjmz2LMumWh8JD41OpnymetkXCTBmOuiCgHk3dX3m0
	LfAyYVyPQsxS6+O2AWWbHEGc2whEO1TUV74Sp6Fakq35mjX0Ncyz3+7iwAbvA4R4ZolVumJuIlV
	LJZ7QZXALoBihqkmOE8MblTBRRxyFhs3PVsdy7KDi4zwXzXZmwXrg3ywwCuC2/4vXF9pNLnPP4H
	2GXu9+cM1d4C1HxSjYfiBM/MlW1UJYsU885FTvAuQJcEV9kgutlijTY+SNeHCZGOwtqIrh4F4Hy
	KioRWsA3t1fQ==
X-Received: by 2002:a05:7300:dc8c:b0:2b8:49cc:7318 with SMTP id 5a478bee46e88-2b855c7ad8bmr555691eec.11.1770345128360;
        Thu, 05 Feb 2026 18:32:08 -0800 (PST)
Received: from [127.0.0.1] ([20.163.4.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855b1a6d3sm807227eec.15.2026.02.05.18.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 18:32:07 -0800 (PST)
Message-Id: <20b9e0bf6e2b12eea1ff50b14d0d2809c601a943.1770345124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2189.git.git.1770345124.gitgitgadget@gmail.com>
References: <pull.2189.git.git.1770345124.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 02:32:04 +0000
Subject: [PATCH 2/2] merge-ours: integrate with sparse-index
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
Cc: Sam Bostock <sam@sambostock.ca>,
    Sam Bostock <sam@sambostock.ca>

From: Sam Bostock <sam@sambostock.ca>

The merge-ours builtin reads the index only to compare it against HEAD
via index_differs_from(), whose diff machinery (run_diff_index) is
already sparse-aware.

Teach merge-ours to opt out of requiring a full index by setting
command_requires_full_index to 0. Because merge-ours is invoked as a
subprocess by "git merge -s ours" and never previously read config,
the global variables core_apply_sparse_checkout and
core_sparse_checkout_cone remained unset, causing
is_sparse_index_allowed() to return false and the index to be expanded
anyway. Add a repo_config() call with git_default_config to populate
these globals.

Add tests to t1092 verifying that "git merge -s ours" produces
identical results across full-checkout, sparse-checkout, and
sparse-index modes, including verifying the resulting merge commit
structure, and that the sparse index is not expanded during the
operation.

Signed-off-by: Sam Bostock <sam@sambostock.ca>
---
 builtin/merge-ours.c                     |  6 ++++++
 t/t1092-sparse-checkout-compatibility.sh | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 2312e58ab3..405b2989f7 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -10,6 +10,8 @@
 
 #include "git-compat-util.h"
 #include "builtin.h"
+#include "config.h"
+#include "environment.h"
 #include "diff.h"
 
 static const char builtin_merge_ours_usage[] =
@@ -22,6 +24,10 @@ int cmd_merge_ours(int argc,
 {
 	show_usage_if_asked(argc, argv, builtin_merge_ours_usage);
 
+	repo_config(repo, git_default_config, NULL);
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
+
 	/*
 	 * The contents of the current index becomes the tree we
 	 * commit.  The index must match HEAD, or this merge cannot go
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index b0f691c151..d98cb4ac11 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2559,4 +2559,18 @@ test_expect_success 'cat-file --batch' '
 	ensure_expanded cat-file --batch <in
 '
 
+test_expect_success 'merge -s ours' '
+	init_repos &&
+
+	test_all_match git rev-parse HEAD^{tree} &&
+	test_all_match git merge -s ours merge-right &&
+	test_all_match git rev-parse HEAD^{tree} &&
+	test_all_match git rev-parse HEAD^2
+'
+
+test_expect_success 'sparse-index is not expanded: merge-ours' '
+	init_repos &&
+	ensure_not_expanded merge -s ours merge-right
+'
+
 test_done
-- 
gitgitgadget
