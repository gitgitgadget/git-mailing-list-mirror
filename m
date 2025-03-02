Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927EA1D5CC6
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740901534; cv=none; b=jtjsQV7uztGZ06Se5+eACiSqJqUCFO9WmNvO9cWAHthqjflf1JBPNf77YT5esrhzsMqnsEwq8zmk09rOc4IsVPVqpQIdD7DgBekjIS9kef8aMxgZYi93Eid5gZcqbze2N86FWfRSbXl2W7kQW/sCo+HhCf4mt1/ABxmBKh6UePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740901534; c=relaxed/simple;
	bh=Nxg+iHI7LLZIZDZUqUUsMQiKPz3hq2iriFivUZKw2YA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RXT1vSMsiq1sW+IIPujpmui97+cjrLOUoBvfjfWICDRDukl4M4m7VtPqCu5ZidW80MDZyMv+lzX3jYdAtgH+cH3OFSrLA3Ug88TsQZBlZWVJUM3Wxv3Q6l4VKnrvZ4DD46HTdI6fqfwUPN+nbIAzIwN0iN2KUHrBCiIZDCoqV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKI13ZfD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKI13ZfD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439a2780b44so21360535e9.1
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 23:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740901529; x=1741506329; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BhkRO3rnuqSGnUAFMPwYz5UBybkTVV/cQjnv9IwQwc=;
        b=EKI13ZfDQvr22lf0QtKC8PCOPzmdEEwFVTeooiitxBy0bIHvJQW/JBY2M4GFiwVOzF
         0CF4r6IpubQnsrawb7Kpv/vcZ+9uUug7lnbDciJHZviUGVaZ5oME5skGm3VKc1MfHY90
         bGkFqU4jMpSXx6x3/54SGFq0rMlRwa+/aDoHpICWQca+aPzA2Qf9sr3ShJhVORDEJo9C
         9eoSlKZF7qM4WrGB60Bpwt9Bwtk8bVIBtctUok5J5FrM9bSKZI0enEebhZ1h2g5Dv1Xi
         AKEoaLdlVuDpDSphRBdmisT8QCdVmXqf/jEhxelCEhSHt+UqoD93jEFSi0iQYEF62gFP
         u4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740901529; x=1741506329;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BhkRO3rnuqSGnUAFMPwYz5UBybkTVV/cQjnv9IwQwc=;
        b=IgPZPCPYjSlzx2qjVpxGNSQQ+gieiCpazgeGIt4p7jQa6jUEGQxb32OYI7sZ0SI9/E
         93JMcY5znmLR60ATnLq3Quf3D0oi7zVKg553qoM4kI7yK9cdReweV8R3q8Vkkd3skjPb
         461TnGoTAuGw0+46xgtM1redHC2LKgvKfyYQYwpmpfMsj7fapOo+14gLSd++CpRt9ujV
         OdAkgkzpJaBCekHxXGx90iz+WRXSXkGn1H+FUkhhhwGPMQU/dqo6dcGsMhqRFQ32sniK
         qGnuAbQ9lAaKtJKTrCjzblF7Mt/SRZmOugwHmzPWUpwkoSfzkgiM6qexe4HZ+xRItnq7
         5yvA==
X-Gm-Message-State: AOJu0YxZ+iRQThZuRzxIARKlpKjUo9st1NuAFvV0F5uqjjsBTnuXOkXO
	EJiDiOTKtAGAQcIDHuDRxzowMKQWfXG//89GU12+hB1QOLt9pTvhZsf7jA==
X-Gm-Gg: ASbGncsZiGG9sNsdeP7FuspvTVeDw4qMyaWqqo/WDtIBse7Epz8Lfdu/xsu4tvhKp0I
	7qaWNoERpQ5Y5De6LwujpbcX3pPjtS+6rvPzNIoASrEhwjZ3pworUYbo+PNt5eeSZVXiCBY+uaY
	aLddzJ8jJchvnHXCG+WUaxryn7kKBpCZh1WKHLiEzFlALZIMngLBmmwHi1aKs0Gpd0HB1ExK2Id
	WCb9lyouyhLYtksW+c2hAFz8utRPYBlarUQgsEwd2OlAvnU6nAZsLiFKmrVEMJq+hdwcmposNlw
	e6LfRHKA5PUqXb+CzOq00uvZ6l/nk1zeBY3GVoCK9qv/qw==
X-Google-Smtp-Source: AGHT+IHixIVrK9Ulry3IGe/qyaBI6W3ZLfxHmuitfg330Eq3S81qh8Ljng18nKcNuGZ/X9Ci6zZz2A==
X-Received: by 2002:a05:600c:384b:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-43ba675ae8emr81902965e9.30.1740901529448;
        Sat, 01 Mar 2025 23:45:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27ab9fsm113054555e9.25.2025.03.01.23.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 23:45:28 -0800 (PST)
Message-Id: <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
From: "David Mandelberg via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 02 Mar 2025 07:45:25 +0000
Subject: [PATCH 3/3] completion: fix bugs with slashes in remote names
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
Cc: Jacob Keller <jacob.keller@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    David Mandelberg <david@mandelberg.org>,
    David Mandelberg <david@mandelberg.org>

From: David Mandelberg <david@mandelberg.org>

Previously, some calls to for-each-ref passed fixed numbers of path
components to strip from refs, assuming that remote names had no slashes
in them. This made completions like:

git push github/dseomn :com<Tab>

Result in:

git push github/dseomn :dseomn/completion-remote-slash

With this patch, it instead results in:

git push github/dseomn :completion-remote-slash

In addition, the change to __git_dwim_remote_heads() restricts it to
only list remote branches, not HEAD. I think that actually improves the
completion where it's used though, since HEAD doesn't seem to be valid
anyway:

$ git switch HEAD
fatal: a branch is expected, got 'HEAD'

Signed-off-by: David Mandelberg <david@mandelberg.org>
---
 contrib/completion/git-completion.bash |  17 ++-
 t/t9902-completion.sh                  | 180 ++++++++++++++++++++++---
 2 files changed, 169 insertions(+), 28 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 17c044f7d60..5f4407be37f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -807,11 +807,15 @@ __git_dwim_remote_heads ()
 	# employ the heuristic used by git checkout and git switch
 	# Try to find a remote branch that cur_es the completion word
 	# but only output if the branch name is unique
-	__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
-		--sort="refname:strip=3" \
-		${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
-		"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
-	uniq -u
+	local remote
+	for remote in $(__git_remotes); do
+		local base="$(__git_escape_fnmatch "refs/remotes/$remote")"
+		local strip="$(__git_count_path_components "$base")"
+		__git for-each-ref \
+			--format="$fer_pfx%(refname:strip=$strip)$sfx" \
+			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
+			"$base/$cur_*" "$base/$cur_*/**"
+	done | sort | uniq -u
 }
 
 # Lists refs from the local (by default) or from a remote repository.
@@ -917,7 +921,8 @@ __git_refs ()
 			case "HEAD" in
 			$match*|$umatch*)	echo "${pfx}HEAD$sfx" ;;
 			esac
-			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
+			local strip="$(__git_count_path_components "refs/remotes/$remote")"
+			__git for-each-ref --format="$fer_pfx%(refname:strip=$strip)$sfx" \
 				${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
 				"refs/remotes/$remote/$match*" \
 				"refs/remotes/$remote/$match*/**"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 0219408358c..0c41ef9d5b1 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -149,7 +149,8 @@ fi
 test_expect_success 'setup for __git_find_repo_path/__gitdir tests' '
 	mkdir -p subdir/subsubdir &&
 	mkdir -p non-repo &&
-	git init -b main otherrepo
+	git init -b main otherrepo &&
+	git init -b main slashrepo
 '
 
 test_expect_success '__git_find_repo_path - from command line (through $__git_dir)' '
@@ -681,6 +682,13 @@ test_expect_success 'setup for ref completion' '
 	) &&
 	git remote add other "$ROOT/otherrepo/.git" &&
 	git fetch --no-tags other &&
+	(
+		cd slashrepo &&
+		git commit --allow-empty -m initial &&
+		git branch -m main branch/with/slash
+	) &&
+	git remote add remote/with/slash "$ROOT/slashrepo/.git" &&
+	git fetch --no-tags remote/with/slash &&
 	rm -f .git/FETCH_HEAD &&
 	git init thirdrepo
 '
@@ -693,6 +701,8 @@ test_expect_success '__git_refs - simple' '
 	other/HEAD
 	other/branch-in-other
 	other/main-in-other
+	remote/with/slash/HEAD
+	remote/with/slash/branch/with/slash
 	matching-tag
 	EOF
 	(
@@ -709,6 +719,8 @@ test_expect_success '__git_refs - full refs' '
 	refs/remotes/other/HEAD
 	refs/remotes/other/branch-in-other
 	refs/remotes/other/main-in-other
+	refs/remotes/remote/with/slash/HEAD
+	refs/remotes/remote/with/slash/branch/with/slash
 	refs/tags/matching-tag
 	EOF
 	(
@@ -774,6 +786,19 @@ test_expect_success '__git_refs - configured remote' '
 	test_cmp expected "$actual"
 '
 
+test_expect_success '__git_refs - configured remote - with slash' '
+	cat >expected <<-EOF &&
+	HEAD
+	HEAD
+	branch/with/slash
+	EOF
+	(
+		cur= &&
+		__git_refs remote/with/slash >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success '__git_refs - configured remote - full refs' '
 	cat >expected <<-EOF &&
 	HEAD
@@ -916,17 +941,19 @@ test_expect_success '__git_refs - unique remote branches for git checkout DWIMer
 	other/ambiguous
 	other/branch-in-other
 	other/main-in-other
-	remote/ambiguous
-	remote/branch-in-remote
+	remote/with/slash/HEAD
+	remote/with/slash/ambiguous
+	remote/with/slash/branch-in-remote
+	remote/with/slash/branch/with/slash
 	matching-tag
-	HEAD
 	branch-in-other
 	branch-in-remote
+	branch/with/slash
 	main-in-other
 	EOF
 	for remote_ref in refs/remotes/other/ambiguous \
-		refs/remotes/remote/ambiguous \
-		refs/remotes/remote/branch-in-remote
+		refs/remotes/remote/with/slash/ambiguous \
+		refs/remotes/remote/with/slash/branch-in-remote
 	do
 		git update-ref $remote_ref main &&
 		test_when_finished "git update-ref -d $remote_ref" || return 1
@@ -946,6 +973,8 @@ test_expect_success '__git_refs - after --opt=' '
 	other/HEAD
 	other/branch-in-other
 	other/main-in-other
+	remote/with/slash/HEAD
+	remote/with/slash/branch/with/slash
 	matching-tag
 	EOF
 	(
@@ -962,6 +991,8 @@ test_expect_success '__git_refs - after --opt= - full refs' '
 	refs/remotes/other/HEAD
 	refs/remotes/other/branch-in-other
 	refs/remotes/other/main-in-other
+	refs/remotes/remote/with/slash/HEAD
+	refs/remotes/remote/with/slash/branch/with/slash
 	refs/tags/matching-tag
 	EOF
 	(
@@ -979,6 +1010,8 @@ test_expect_success '__git refs - excluding refs' '
 	^other/HEAD
 	^other/branch-in-other
 	^other/main-in-other
+	^remote/with/slash/HEAD
+	^remote/with/slash/branch/with/slash
 	^matching-tag
 	EOF
 	(
@@ -995,6 +1028,8 @@ test_expect_success '__git refs - excluding full refs' '
 	^refs/remotes/other/HEAD
 	^refs/remotes/other/branch-in-other
 	^refs/remotes/other/main-in-other
+	^refs/remotes/remote/with/slash/HEAD
+	^refs/remotes/remote/with/slash/branch/with/slash
 	^refs/tags/matching-tag
 	EOF
 	(
@@ -1022,6 +1057,8 @@ test_expect_success '__git_refs - do not filter refs unless told so' '
 	other/branch-in-other
 	other/main-in-other
 	other/matching/branch-in-other
+	remote/with/slash/HEAD
+	remote/with/slash/branch/with/slash
 	matching-tag
 	matching/tag
 	EOF
@@ -1142,6 +1179,8 @@ test_expect_success '__git_complete_refs - simple' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	matching-tag Z
 	EOF
 	(
@@ -1180,6 +1219,20 @@ test_expect_success '__git_complete_refs - remote' '
 	test_cmp expected out
 '
 
+test_expect_success '__git_complete_refs - remote - with slash' '
+	sed -e "s/Z$//" >expected <<-EOF &&
+	HEAD Z
+	HEAD Z
+	branch/with/slash Z
+	EOF
+	(
+		cur= &&
+		__git_complete_refs --remote=remote/with/slash &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
 test_expect_success '__git_complete_refs - track' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	HEAD Z
@@ -1188,9 +1241,11 @@ test_expect_success '__git_complete_refs - track' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	matching-tag Z
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main-in-other Z
 	EOF
 	(
@@ -1235,6 +1290,8 @@ test_expect_success '__git_complete_refs - suffix' '
 	other/HEAD.
 	other/branch-in-other.
 	other/main-in-other.
+	remote/with/slash/HEAD.
+	remote/with/slash/branch/with/slash.
 	matching-tag.
 	EOF
 	(
@@ -1260,6 +1317,20 @@ test_expect_success '__git_complete_fetch_refspecs - simple' '
 	test_cmp expected out
 '
 
+test_expect_success '__git_complete_fetch_refspecs - with slash' '
+	sed -e "s/Z$//" >expected <<-EOF &&
+	HEAD:HEAD Z
+	HEAD:HEAD Z
+	branch/with/slash:branch/with/slash Z
+	EOF
+	(
+		cur= &&
+		__git_complete_fetch_refspecs remote/with/slash &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
 test_expect_success '__git_complete_fetch_refspecs - matching' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	branch-in-other:branch-in-other Z
@@ -1340,8 +1411,8 @@ test_expect_success '__git_complete_worktree_paths with -C' '
 
 test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
 	test_completion "git switch " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -1487,8 +1558,8 @@ test_expect_success 'git-bisect - existing view subcommand is recognized and ena
 test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -1496,6 +1567,8 @@ test_expect_success 'git checkout - completes refs and unique remote branches fo
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1515,8 +1588,8 @@ test_expect_success 'git switch - with GIT_COMPLETION_CHECKOUT_NO_GUESS=1, compl
 
 test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete local branches and unique remote names for DWIM logic' '
 	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch --guess " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -1525,8 +1598,8 @@ test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_G
 
 test_expect_success 'git switch - a later --guess overrides previous --no-guess, complete local and remote unique branches for DWIM' '
 	test_completion "git switch --no-guess --guess " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -1549,14 +1622,16 @@ test_expect_success 'git checkout - with GIT_COMPLETION_NO_GUESS=1 only complete
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
 test_expect_success 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1, complete refs and unique remote branches for DWIM' '
 	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git checkout --guess " <<-\EOF
 	HEAD Z
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -1564,6 +1639,8 @@ test_expect_success 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1,
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1576,14 +1653,16 @@ test_expect_success 'git checkout - with --no-guess, only completes refs' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
 test_expect_success 'git checkout - a later --guess overrides previous --no-guess, complete refs and unique remote branches for DWIM' '
 	test_completion "git checkout --no-guess --guess " <<-\EOF
 	HEAD Z
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -1591,6 +1670,8 @@ test_expect_success 'git checkout - a later --guess overrides previous --no-gues
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1603,6 +1684,8 @@ test_expect_success 'git checkout - a later --no-guess overrides previous --gues
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1616,6 +1699,8 @@ test_expect_success 'git checkout - with checkout.guess = false, only completes
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1623,8 +1708,8 @@ test_expect_success 'git checkout - with checkout.guess = true, completes refs a
 	test_config checkout.guess true &&
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -1632,6 +1717,8 @@ test_expect_success 'git checkout - with checkout.guess = true, completes refs a
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1639,8 +1726,8 @@ test_expect_success 'git checkout - a later --guess overrides previous checkout.
 	test_config checkout.guess false &&
 	test_completion "git checkout --guess " <<-\EOF
 	HEAD Z
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -1648,6 +1735,8 @@ test_expect_success 'git checkout - a later --guess overrides previous checkout.
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1661,6 +1750,8 @@ test_expect_success 'git checkout - a later --no-guess overrides previous checko
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1673,6 +1764,8 @@ test_expect_success 'git switch - with --detach, complete all references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1685,6 +1778,8 @@ test_expect_success 'git checkout - with --detach, complete only references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1857,6 +1952,8 @@ test_expect_success 'git switch - with -d, complete all references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1869,6 +1966,8 @@ test_expect_success 'git checkout - with -d, complete only references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1877,11 +1976,15 @@ test_expect_success 'git switch - with --track, complete only remote branches' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 	test_completion "git switch -t " <<-\EOF
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1890,11 +1993,15 @@ test_expect_success 'git checkout - with --track, complete only remote branches'
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 	test_completion "git checkout -t " <<-\EOF
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1914,6 +2021,8 @@ test_expect_success 'git checkout - with --no-track, complete only local referen
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1926,6 +2035,8 @@ test_expect_success 'git switch - with -c, complete all references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1938,6 +2049,8 @@ test_expect_success 'git switch - with -C, complete all references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1950,6 +2063,8 @@ test_expect_success 'git switch - with -c and --track, complete all references'
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1962,6 +2077,8 @@ test_expect_success 'git switch - with -C and --track, complete all references'
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1974,6 +2091,8 @@ test_expect_success 'git switch - with -c and --no-track, complete all reference
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1986,6 +2105,8 @@ test_expect_success 'git switch - with -C and --no-track, complete all reference
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1998,6 +2119,8 @@ test_expect_success 'git checkout - with -b, complete all references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -2010,6 +2133,8 @@ test_expect_success 'git checkout - with -B, complete all references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -2022,6 +2147,8 @@ test_expect_success 'git checkout - with -b and --track, complete all references
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -2034,6 +2161,8 @@ test_expect_success 'git checkout - with -B and --track, complete all references
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -2046,6 +2175,8 @@ test_expect_success 'git checkout - with -b and --no-track, complete all referen
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -2058,13 +2189,15 @@ test_expect_success 'git checkout - with -B and --no-track, complete all referen
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
 test_expect_success 'git switch - for -c, complete local branches and unique remote branches' '
 	test_completion "git switch -c " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -2073,8 +2206,8 @@ test_expect_success 'git switch - for -c, complete local branches and unique rem
 
 test_expect_success 'git switch - for -C, complete local branches and unique remote branches' '
 	test_completion "git switch -C " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -2111,8 +2244,8 @@ test_expect_success 'git switch - for -C with --no-track, complete local branche
 
 test_expect_success 'git checkout - for -b, complete local branches and unique remote branches' '
 	test_completion "git checkout -b " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -2121,8 +2254,8 @@ test_expect_success 'git checkout - for -b, complete local branches and unique r
 
 test_expect_success 'git checkout - for -B, complete local branches and unique remote branches' '
 	test_completion "git checkout -B " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -2159,8 +2292,8 @@ test_expect_success 'git checkout - for -B with --no-track, complete local branc
 
 test_expect_success 'git switch - with --orphan completes local branch names and unique remote branch names' '
 	test_completion "git switch --orphan " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -2175,8 +2308,8 @@ test_expect_success 'git switch - --orphan with branch already provided complete
 
 test_expect_success 'git checkout - with --orphan completes local branch names and unique remote branch names' '
 	test_completion "git checkout --orphan " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -2192,6 +2325,8 @@ test_expect_success 'git checkout - --orphan with branch already provided comple
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -2206,7 +2341,8 @@ test_expect_success 'git restore completes modified files' '
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
-	git remote remove other
+	git remote remove other &&
+	git remote remove remote/with/slash
 '
 
 
-- 
gitgitgadget
