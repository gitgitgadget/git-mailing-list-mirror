Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A53A8C1
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742764017; cv=none; b=tEkrKheuroNzq6Qsw7cEoESPxP2zbtM8gRA4wtOPXkRJ0WPRY///X3RfXyyU4RWV5xjBvWFS8TLan8+aqHsk7gFNNt7KbpOfS60kdYOCJWEP/sOJnsxC1fQYESymhTApMToGq6nRgo4AXyiXhLp327WL6JDXnhaE0HowuT5C88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742764017; c=relaxed/simple;
	bh=bTjV7mJZoegj1S7XGvlqoskgUjFhYNqotXQyzNapGmk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jf+Y7eqjz1saHvOQ7qPJtOsudwt3GD1JkNT8v0Gu4si4FGlLe+cqjmIZ3pQeIajlB9mq8sFv89XZG+S5VFTChM7vuzjao8yosblx4ZQHsW/kX1abwFbFkpGzzp16sIwjNmgvx7WN5Q3Mpl2IO9vO53HMXGruUV2223SMHEFFCWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=+sNTkqhr; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=RaktgCfn; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="+sNTkqhr";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="RaktgCfn"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-6e8fca43972so39829656d6.1
        for <git@vger.kernel.org>; Sun, 23 Mar 2025 14:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742764014; x=1743368814;
        h=content-transfer-encoding:message-id:references:in-reply-to:subject
         :cc:to:from:date:mime-version:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6g3T6JSREy+tCBy+D9aeFrst04uiyH3BwXAeuM0PBMU=;
        b=bAoG550UJCV4rpEYCZdh5ACfAoez9VsbSibJKSUeBTvz0pElWP06/iLNz6pS1q01ZY
         KcRe+3u+QLKEDHB4PoOuZ2K25qNTqJ+OtQbtkwx5PBZS1ni0WHP571QmUse7xWlwrqGD
         Q3h48M0m5S+CkrhFWfwqMaYU3qaIH1wOREtEQ1FoVKySDSdROByUuvLalW12vwIAf8zj
         UbTXHe/TiW26SioJr0pKLj2FlPC0ScRZfbQKkAMr54qVWjVM9+FCKcKiuWswXVJotAOd
         hRHYAG5nhUcOR3dob7Xy8jwqV1U7JDXhU7h1dAplZruSpKGy4qhUwwTe0+c+B0cKDc4d
         oK7A==
X-Gm-Message-State: AOJu0YwLNrnrESG4OKJYUMwuCs/98CNdT5kTtCoUCNFDnjfmJpyspNMk
	SCfyuLEgUajQ4eSfMWqC5A+N2gzex6nbqubKddnYO1r46Wp1i6Jt/EdfZyUaG208NuxW/LnbsV7
	vZ6IaPMzZF16VR/1UpvtQHBd/lowvS3dsr7jpGSgTYayoV0Ew
X-Gm-Gg: ASbGncu05IeGFx37ernof4xJPOkCqR435Wz9BOAAs9dABkhVuBgvhP0lRWIGBSVUXi6
	44nIEsLxMYQRA/t1UfZRTNt4+J0mVUYo7OCVoVkWlBPc1sFyd6wevMQdPR3/hyqVuar3z18tHnR
	RMmtEzXNABVcNl8lehgmUD4URkYxedGZWRnpy5dsfON36BuU9rn6vLlkXHSN4X4z/LLaS42nB1T
	1Z9FGFDQ0e3OSPuEmhe6Z2rmcEr7ztSI6X29potv+mwkLE1Zv/JnRYe0lrnqzRUKazsM3S2o8uw
	dpKDJNLO79aYAEv0WGGovji1piyoB+1e2eg18Eqv
X-Google-Smtp-Source: AGHT+IENsyG57m4Tqd4lRjKLaYjXMQBxXFiPIQZbm6SbagLOV4hHAhd8UhV/hnyIOmP5i5NI7z3LH9c22Ctb
X-Received: by 2002:a05:6214:494b:b0:6ec:f76f:64fa with SMTP id 6a1803df08f44-6ecf76f6876mr31693666d6.44.1742764014424;
        Sun, 23 Mar 2025 14:06:54 -0700 (PDT)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org ([2600:4040:52f1:f606::8])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6eb3efaa2edsm3319016d6.37.2025.03.23.14.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 14:06:54 -0700 (PDT)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1742764013; h=mime-version : date
 : from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding : from;
 bh=bTjV7mJZoegj1S7XGvlqoskgUjFhYNqotXQyzNapGmk=;
 b=+sNTkqhrKhoTxiYtXsAZhbAQNgDmcBYAjeZ3sYZPJY4Ke4xNt3aJg4FXw+asqIyE9zcHu
 QRYxKiWm9CF05OEDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1742764013; h=mime-version : date : from : to : cc : subject :
 in-reply-to : references : message-id : content-type :
 content-transfer-encoding : from;
 bh=bTjV7mJZoegj1S7XGvlqoskgUjFhYNqotXQyzNapGmk=;
 b=RaktgCfn3UJyWfleASk7Jj6V6eqc/PLElSYxCsi21Iolxv+UTXDVSA2RJAWVdYmleLI0D
 ZYYmeK/rtTcCJzej6oP3VShfLtUKUStlkghbbYu9ICzVDK732S2t3gKj0q6Xv5bsC5JXzh/
 n15OBHNMgr1uA2h4ILBVt9tV0Z5MBzZL2MnkXHH7UdSfa5KjNrmjnGzcpIjLyZQOtEsFTBZ
 fZwOqkghrVqCPSs8IaMowxTYvQHgM+q03cwLZaY5hZ3b2YLIcywhMSgrR35KdSHbWLe9G9r
 8cm5R2j+WfnSVgByXQnOjoC/l13mFZt0NwuCUbyn5OhlIpQMzL4e2yaeH0aQ==
Received: from webmail.mandelberg.org (mail-web-d031b246.virgo.mandelberg.org [10.0.6.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4ZLTJY6XQhz10dZ;
	Sun, 23 Mar 2025 21:06:53 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Mar 2025 17:06:53 -0400
From: David Mandelberg <david@mandelberg.org>
To: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>, Junio C
 Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/2] completion: fix bugs with slashes in remote names
In-Reply-To: <17274df2746d304db876ebd82ad8d932@mandelberg.org>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <17274df2746d304db876ebd82ad8d932@mandelberg.org>
Message-ID: <e12bfdb6a864eecaf11bfb6bdb3f7bd4@mandelberg.org>
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
index 5fdc71208e..e3d88b0672 100644
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
+	__git for-each-ref --format='%(refname)' refs/remotes/ |
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
