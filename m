Received: from mail-yb1-f228.google.com (mail-yb1-f228.google.com [209.85.219.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9206D17D2
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741981390; cv=none; b=k2itcXgv8Fy6PBv4uPXsWhZFtDLv5PV6YiCrS7pPmPxyGdqWVEgQmsjiq+ix8Ju1C6ctE4F+jrKSUkRXtxlThapq9X0lHa0ui44RO6Y0LKUyydcUSNH6Np0Lp5Hx4Cu8xIMMpVQ+oclWs7g7yzrg42iqA7Zq2VIhzHoXdYmVV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741981390; c=relaxed/simple;
	bh=UP4QgtPI7/N+oXteC1y71kh83L7X5kaNBoBGEMgCLzk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UlRtSjgQDDz8wNH5hqkUSmSVEhQvlhWbqCUxZj5x5LaG8lhYE8UiQVDRMOHA5lMKW5aq+uDQzMoS8ikGbc+JTlIdMH6n3ajgUQA5Jxef7AsCuF+W6haBLeQarzRT+IFxAfwN1hzmF5G7H4I5mdOmwovEMMXdjZU6/azsBT4pT/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=rGLouwAu; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=VwljWQzL; arc=none smtp.client-ip=209.85.219.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="rGLouwAu";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="VwljWQzL"
Received: by mail-yb1-f228.google.com with SMTP id 3f1490d57ef6-e64096aa08fso55297276.2
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 12:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741981387; x=1742586187;
        h=content-transfer-encoding:message-id:references:in-reply-to:subject
         :cc:to:from:date:mime-version:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DretQbJm45tHa8G8OA2g2ysfOaH2FsTOP4ZWnHbJfo=;
        b=GJPS635IKbFg3E6t+5hzWkzP/QKvLefY2BF09y82wG2Pb0KjHSQEBrxsqXoro7gVjl
         furQS/lXLpKJhdaoj/7VrRkCaEB0hOcNSRpnfXLqe2YTWERMbjLsI5aDNGYHgLjY8sku
         ZcfPUfaJMyLEUXr73+JxdC6ZiIHzx7GjTrgxGyO9AJ8i8Ra4GcRN5Jpe9EcMITwWuoIO
         MkNrmDlKrXRoZUdF0isUMqsL0QtCUvuxcvOVm3nuXCZqKNlFLg78oTsCAM7WjgSHs8/k
         miFh7QZdMT0iW5BPZiAiS685Y4FntTDYP/ontr0I314IUKgUo+q8FTMPK9dN/AuHRozE
         Lt2Q==
X-Gm-Message-State: AOJu0YyHIHbI6KHesNT7YxfkDKldoQORrLG0wMqrAXG4asp50guTtGm+
	b974MOCzo1ADNTD1j5sOdTUKDJA+piD9Eb/NqowKM18J6TpZ8tmBezj/BeQGkk2c5gxWY38Avh3
	H81mr2T6QzP7AgClPW+Q8bVi4RWHdZRak
X-Gm-Gg: ASbGnctzno+Y62HxtNGTdGNKqGM9sPZpCuBFcWRsz2LcSHBgBGHcmTa4PET7jN07p7O
	ZNP5UOkBsm+QmzkTMswMlSMCauT/rRd3DUdPkCzi+O6Ed1qTL/kHXakPQxziCLRd12ShD9X7rvH
	c512DWRlDN81InlBbqApgdf9/RWEjgEeE5/beVOxGwP+u1mA5GdMJ2cqFzT6qgEYWKbAtfRwG5d
	Qe2aA2FU2yE7bHl27NNaHsmqP2v2bgvQMmJzK72qKChB1+C/rj/Uj1uh9usCzgrSVUNEuXoJeZ7
	BRkq52bdn4gLDvNPpaW1C5MvYLgdu25Q2jAWMtwADzCeS17RpLYXxLW5mg+HXUCE7CM5wnnY5wz
	BiLONnJMPZnSXBOO15zrHYDfkWYRveQ==
X-Google-Smtp-Source: AGHT+IGqwXRHVs/2kwcnJf+v2yoOlOzkjVuSvmicer2zX5srWR8MCNv8YgANk+eyOd2n2TsS+0736Nynsa+M
X-Received: by 2002:a05:690c:9a91:b0:6fd:3367:d743 with SMTP id 00721157ae682-6ff45f606cbmr49754857b3.14.1741981387399;
        Fri, 14 Mar 2025 12:43:07 -0700 (PDT)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org (pool-108-49-41-183.bstnma.fios.verizon.net. [108.49.41.183])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-6ff32c9b664sm1520477b3.66.2025.03.14.12.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 12:43:07 -0700 (PDT)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1741981386; h=mime-version : date
 : from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding : from;
 bh=UP4QgtPI7/N+oXteC1y71kh83L7X5kaNBoBGEMgCLzk=;
 b=rGLouwAuqwHquaF/HCR4V8kFnN7PgPDkwiaVZ5nIpWDEmedPFlPXekU2S4j2iIvsbanKV
 gkZR1cwS7gu2TCEAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1741981386; h=mime-version : date : from : to : cc : subject :
 in-reply-to : references : message-id : content-type :
 content-transfer-encoding : from;
 bh=UP4QgtPI7/N+oXteC1y71kh83L7X5kaNBoBGEMgCLzk=;
 b=VwljWQzLg4pP9usPytNW1Yw78xBUUAWW6QbJGwnJWo0MHMJlHgqlDf3vG0zNruYO7xGKb
 iDla6BlR0ZukX57JI+Lxo4miBaCHcoMfoDzStKA3EuIL0c7kCvJEpWipbRWgyN66BPkNcf2
 81yDd0lAIUuZo6TTNxORdPdnnQ/2MvTBd1Yelex1PjJPfAwRVVWs0HgHk2IKi42BqvgeyC1
 M4O8dQtGjPPQGPPh1nvdT1DlWM+lA8lTkQ8luyZJomkdX62fKz+3KY9xBAo1UqzTvL2/o4+
 0lDQ0ssMnXsTNjs3LD2dtcyJoHc0RyrTXomlXo6A9I1ZpiRUpC490/74mL7w==
Received: from webmail.mandelberg.org (mail-web-d031b246.virgo.mandelberg.org [10.0.6.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4ZDvt25Nx1zySJ;
	Fri, 14 Mar 2025 19:43:06 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Mar 2025 15:43:06 -0400
From: David Mandelberg <david@mandelberg.org>
To: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>, Junio C
 Hamano <gitster@pobox.com>, david@mandelberg.org
Subject: [PATCH v3 2/2] completion: fix bugs with slashes in remote names
In-Reply-To: <1587533591c81d38977e62165784f8eb@mandelberg.org>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <1587533591c81d38977e62165784f8eb@mandelberg.org>
Message-ID: <c80d20d93c92422437150084f402ac36@mandelberg.org>
X-Sender: david@mandelberg.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Previously, some calls to for-each-ref passed fixed numbers of path
components to strip from refs, assuming that remote names had no slashes
in them. This made completions like:

git push github/dseomn :com<Tab>

Result in:

git push github/dseomn :dseomn/completion-remote-slash

With this patch, it instead results in:

git push github/dseomn :completion-remote-slash

Signed-off-by: David Mandelberg <david@mandelberg.org>
---
 contrib/completion/git-completion.bash |  38 +++++-
 t/t9902-completion.sh                  | 180 ++++++++++++++++++++++---
 2 files changed, 189 insertions(+), 29 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5fdc71208e..c9d014070c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -790,16 +790,39 @@ __git_tags ()
 __git_dwim_remote_heads ()
 {
 	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
-	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
 
 	# employ the heuristic used by git checkout and git switch
 	# Try to find a remote branch that cur_es the completion word
 	# but only output if the branch name is unique
-	__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
-		--sort="refname:strip=3" \
-		${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
-		"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
-	uniq -u
+	local awk_script='
+	function casemap(s) {
+		if (ENVIRON["IGNORE_CASE"])
+			return tolower(s)
+		else
+			return s
+	}
+	BEGIN {
+		split(ENVIRON["REMOTES"], remotes, /\n/)
+		for (i in remotes)
+			remotes[i] = "refs/remotes/" casemap(remotes[i])
+		cur_ = casemap(ENVIRON["CUR_"])
+	}
+	{
+		ref_case = casemap($0)
+		for (i in remotes) {
+			if (index(ref_case, remotes[i] "/" cur_) == 1) {
+				branch = substr($0, length(remotes[i] "/") + 1)
+				print ENVIRON["PFX"] branch ENVIRON["SFX"]
+				break
+			}
+		}
+	}
+	'
+	__git for-each-ref --format='%(refname)' 'refs/remotes/**' |
+		PFX="$pfx" SFX="$sfx" CUR_="$cur_" \
+			IGNORE_CASE=${GIT_COMPLETION_IGNORE_CASE+1} \
+			REMOTES="$(__git_remotes | sort -r)" awk "$awk_script" |
+		sort | uniq -u
 }
 
 # Lists refs from the local (by default) or from a remote repository.
@@ -905,7 +928,8 @@ __git_refs ()
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
index 015289c776..343b8cd191 100755
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
@@ -674,6 +675,13 @@ test_expect_success 'setup for ref completion' '
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
@@ -686,6 +694,8 @@ test_expect_success '__git_refs - simple' '
 	other/HEAD
 	other/branch-in-other
 	other/main-in-other
+	remote/with/slash/HEAD
+	remote/with/slash/branch/with/slash
 	matching-tag
 	EOF
 	(
@@ -702,6 +712,8 @@ test_expect_success '__git_refs - full refs' '
 	refs/remotes/other/HEAD
 	refs/remotes/other/branch-in-other
 	refs/remotes/other/main-in-other
+	refs/remotes/remote/with/slash/HEAD
+	refs/remotes/remote/with/slash/branch/with/slash
 	refs/tags/matching-tag
 	EOF
 	(
@@ -767,6 +779,19 @@ test_expect_success '__git_refs - configured remote' '
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
@@ -909,17 +934,19 @@ test_expect_success '__git_refs - unique remote branches for git checkout DWIMer
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
@@ -939,6 +966,8 @@ test_expect_success '__git_refs - after --opt=' '
 	other/HEAD
 	other/branch-in-other
 	other/main-in-other
+	remote/with/slash/HEAD
+	remote/with/slash/branch/with/slash
 	matching-tag
 	EOF
 	(
@@ -955,6 +984,8 @@ test_expect_success '__git_refs - after --opt= - full refs' '
 	refs/remotes/other/HEAD
 	refs/remotes/other/branch-in-other
 	refs/remotes/other/main-in-other
+	refs/remotes/remote/with/slash/HEAD
+	refs/remotes/remote/with/slash/branch/with/slash
 	refs/tags/matching-tag
 	EOF
 	(
@@ -972,6 +1003,8 @@ test_expect_success '__git refs - excluding refs' '
 	^other/HEAD
 	^other/branch-in-other
 	^other/main-in-other
+	^remote/with/slash/HEAD
+	^remote/with/slash/branch/with/slash
 	^matching-tag
 	EOF
 	(
@@ -988,6 +1021,8 @@ test_expect_success '__git refs - excluding full refs' '
 	^refs/remotes/other/HEAD
 	^refs/remotes/other/branch-in-other
 	^refs/remotes/other/main-in-other
+	^refs/remotes/remote/with/slash/HEAD
+	^refs/remotes/remote/with/slash/branch/with/slash
 	^refs/tags/matching-tag
 	EOF
 	(
@@ -1015,6 +1050,8 @@ test_expect_success '__git_refs - do not filter refs unless told so' '
 	other/branch-in-other
 	other/main-in-other
 	other/matching/branch-in-other
+	remote/with/slash/HEAD
+	remote/with/slash/branch/with/slash
 	matching-tag
 	matching/tag
 	EOF
@@ -1135,6 +1172,8 @@ test_expect_success '__git_complete_refs - simple' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	matching-tag Z
 	EOF
 	(
@@ -1173,6 +1212,20 @@ test_expect_success '__git_complete_refs - remote' '
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
@@ -1181,9 +1234,11 @@ test_expect_success '__git_complete_refs - track' '
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
@@ -1228,6 +1283,8 @@ test_expect_success '__git_complete_refs - suffix' '
 	other/HEAD.
 	other/branch-in-other.
 	other/main-in-other.
+	remote/with/slash/HEAD.
+	remote/with/slash/branch/with/slash.
 	matching-tag.
 	EOF
 	(
@@ -1253,6 +1310,20 @@ test_expect_success '__git_complete_fetch_refspecs - simple' '
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
@@ -1333,8 +1404,8 @@ test_expect_success '__git_complete_worktree_paths with -C' '
 
 test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
 	test_completion "git switch " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -1480,8 +1551,8 @@ test_expect_success 'git-bisect - existing view subcommand is recognized and ena
 test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -1489,6 +1560,8 @@ test_expect_success 'git checkout - completes refs and unique remote branches fo
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1508,8 +1581,8 @@ test_expect_success 'git switch - with GIT_COMPLETION_CHECKOUT_NO_GUESS=1, compl
 
 test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete local branches and unique remote names for DWIM logic' '
 	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch --guess " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -1518,8 +1591,8 @@ test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_G
 
 test_expect_success 'git switch - a later --guess overrides previous --no-guess, complete local and remote unique branches for DWIM' '
 	test_completion "git switch --no-guess --guess " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -1542,14 +1615,16 @@ test_expect_success 'git checkout - with GIT_COMPLETION_NO_GUESS=1 only complete
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
@@ -1557,6 +1632,8 @@ test_expect_success 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1,
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1569,14 +1646,16 @@ test_expect_success 'git checkout - with --no-guess, only completes refs' '
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
@@ -1584,6 +1663,8 @@ test_expect_success 'git checkout - a later --guess overrides previous --no-gues
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1596,6 +1677,8 @@ test_expect_success 'git checkout - a later --no-guess overrides previous --gues
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1609,6 +1692,8 @@ test_expect_success 'git checkout - with checkout.guess = false, only completes
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1616,8 +1701,8 @@ test_expect_success 'git checkout - with checkout.guess = true, completes refs a
 	test_config checkout.guess true &&
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -1625,6 +1710,8 @@ test_expect_success 'git checkout - with checkout.guess = true, completes refs a
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1632,8 +1719,8 @@ test_expect_success 'git checkout - a later --guess overrides previous checkout.
 	test_config checkout.guess false &&
 	test_completion "git checkout --guess " <<-\EOF
 	HEAD Z
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -1641,6 +1728,8 @@ test_expect_success 'git checkout - a later --guess overrides previous checkout.
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1654,6 +1743,8 @@ test_expect_success 'git checkout - a later --no-guess overrides previous checko
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1666,6 +1757,8 @@ test_expect_success 'git switch - with --detach, complete all references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1678,6 +1771,8 @@ test_expect_success 'git checkout - with --detach, complete only references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1850,6 +1945,8 @@ test_expect_success 'git switch - with -d, complete all references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1862,6 +1959,8 @@ test_expect_success 'git checkout - with -d, complete only references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1870,11 +1969,15 @@ test_expect_success 'git switch - with --track, complete only remote branches' '
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
 
@@ -1883,11 +1986,15 @@ test_expect_success 'git checkout - with --track, complete only remote branches'
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
 
@@ -1907,6 +2014,8 @@ test_expect_success 'git checkout - with --no-track, complete only local referen
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1919,6 +2028,8 @@ test_expect_success 'git switch - with -c, complete all references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1931,6 +2042,8 @@ test_expect_success 'git switch - with -C, complete all references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1943,6 +2056,8 @@ test_expect_success 'git switch - with -c and --track, complete all references'
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1955,6 +2070,8 @@ test_expect_success 'git switch - with -C and --track, complete all references'
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1967,6 +2084,8 @@ test_expect_success 'git switch - with -c and --no-track, complete all reference
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1979,6 +2098,8 @@ test_expect_success 'git switch - with -C and --no-track, complete all reference
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -1991,6 +2112,8 @@ test_expect_success 'git checkout - with -b, complete all references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -2003,6 +2126,8 @@ test_expect_success 'git checkout - with -B, complete all references' '
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -2015,6 +2140,8 @@ test_expect_success 'git checkout - with -b and --track, complete all references
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -2027,6 +2154,8 @@ test_expect_success 'git checkout - with -B and --track, complete all references
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -2039,6 +2168,8 @@ test_expect_success 'git checkout - with -b and --no-track, complete all referen
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -2051,13 +2182,15 @@ test_expect_success 'git checkout - with -B and --no-track, complete all referen
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
@@ -2066,8 +2199,8 @@ test_expect_success 'git switch - for -c, complete local branches and unique rem
 
 test_expect_success 'git switch - for -C, complete local branches and unique remote branches' '
 	test_completion "git switch -C " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -2104,8 +2237,8 @@ test_expect_success 'git switch - for -C with --no-track, complete local branche
 
 test_expect_success 'git checkout - for -b, complete local branches and unique remote branches' '
 	test_completion "git checkout -b " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -2114,8 +2247,8 @@ test_expect_success 'git checkout - for -b, complete local branches and unique r
 
 test_expect_success 'git checkout - for -B, complete local branches and unique remote branches' '
 	test_completion "git checkout -B " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -2152,8 +2285,8 @@ test_expect_success 'git checkout - for -B with --no-track, complete local branc
 
 test_expect_success 'git switch - with --orphan completes local branch names and unique remote branch names' '
 	test_completion "git switch --orphan " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -2168,8 +2301,8 @@ test_expect_success 'git switch - --orphan with branch already provided complete
 
 test_expect_success 'git checkout - with --orphan completes local branch names and unique remote branch names' '
 	test_completion "git checkout --orphan " <<-\EOF
-	HEAD Z
 	branch-in-other Z
+	branch/with/slash Z
 	main Z
 	main-in-other Z
 	matching-branch Z
@@ -2185,6 +2318,8 @@ test_expect_success 'git checkout - --orphan with branch already provided comple
 	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
+	remote/with/slash/HEAD Z
+	remote/with/slash/branch/with/slash Z
 	EOF
 '
 
@@ -2199,7 +2334,8 @@ test_expect_success 'git restore completes modified files' '
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
-	git remote remove other
+	git remote remove other &&
+	git remote remove remote/with/slash
 '
 
 
-- 
2.47.2
