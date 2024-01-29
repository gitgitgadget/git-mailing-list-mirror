Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1CE64CC7
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534912; cv=none; b=uu6ADSx/aW2Lt4k6F/0xGxwIc8Zj4HeIsl638kx5bcYSrVlzgQUZ2qLdbWp7WQaP/R+VL9H1uvEZAi6cRU+OI/6jMAmrf3fdUA+DgiX31KvKYgFx6um8iRgBQIR6L0X37KcwxCUTHa55RGsh4LEE5Th6hwCj2TudLxcOIfjdpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534912; c=relaxed/simple;
	bh=qs2JfaacomBYZSJbBIC0nQLE5azEC+6LeTMFhMZ7orA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aCJ3skk6doUq4QjUNNXiNUGsXRcew0SjYgzYzbnYofF12mDpC4sbb74huwu2H7WTmcq3dI5+9FW4Tv3TXCe47yDbFhRxwYJyXUhMTE4rKT8F4Tr982Wkzrq0J5DViue94Ah7MQ8Mw4ANW3rvSh/5tTXYc35o0bQddouZCQuM+qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkPk5A3j; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkPk5A3j"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3392b045e0aso2263878f8f.2
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 05:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706534908; x=1707139708; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI8Axo9a8gsIKHPMBImKiuAar+merz8URnLTsQpVhl4=;
        b=hkPk5A3jUDLmdCtH62FyuQnzHBuq9MTbg3D/ArLKqBHPcnBir1LkmjRvorDKtM7RLu
         tmSyIodTEgk/Qsdu1Cf22pwKGcec8/y9kK1R3pSHay88ApRs7Ttkp1ke7bHUSW188XJD
         3698U9d/N9FjphTUtyhWi413fW4uHJFJcK5qdtt41iKKrbdMoLCFYA86vE2V446DjT4a
         v+sqg4deEM43IqyBdNF25qbayvzn7spqGxkpfG2nEr8Yjzr4/+jk9rHEXnnWLXOMQI6c
         49eZ/P4l3yZZq+1gD1QKboKZLugaytBp8VXxpcf1rIzgcFexnn4UcOjnlRrchG4ptyg3
         LRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534908; x=1707139708;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pI8Axo9a8gsIKHPMBImKiuAar+merz8URnLTsQpVhl4=;
        b=SlmagE3rVh4pM9ffcCNguHRPgU/eKrUo+7dDPowlGWW5bAexvnOvrUjNyoisLmtIIi
         K92l5ebCW4a6G7a9zn+rysdhFVdFyILwrKRbn0WdzQj1ZBxVLbf3F7f8LElTih9TiJjC
         XfJvnv97BoA/UMLS/r/aqo++WHQHqAx3tN6SCfv6Q8iRJnho+swbSbImi/osCMTU+N0F
         MLUQNfx2WOabINJlCEZRWalSzYDPH2BAqxPU4gD1KhrBwbqioGx9yOjSymm+L6F183Fq
         NN2f6jDOj/Z+rNC6UojaywKJ0wTQeGBvh+ClTHIYBCoy26TwBORqY/35yK3a0hZrDR48
         RHyQ==
X-Gm-Message-State: AOJu0Yx7JwpElGvkTqtJ+DMi46EorXMkdzyED4bLeplx3G64/2PvNO0w
	Tsk5wQJfYwZEsiwKsooOb2QwJ45oL4/rZcVZ8G5APG6pyvg9CA3/rnSORybJ
X-Google-Smtp-Source: AGHT+IGbYljSnfoeHcyxJqyM0Cc9LOOc11YQvW7mgJMAwPnJEQkUP6Jn2YDxab6mobu3Us57r8bNdw==
X-Received: by 2002:ac2:4bc9:0:b0:510:12e5:c6a8 with SMTP id o9-20020ac24bc9000000b0051012e5c6a8mr5096471lfq.47.1706534888121;
        Mon, 29 Jan 2024 05:28:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c444c00b0040ee7175eb1sm8850880wmn.9.2024.01.29.05.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:28:07 -0800 (PST)
Message-ID: <a2e792c911e1b9fa77d27ec327f6a9dfe06d4de4.1706534882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
	<pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Jan 2024 13:28:01 +0000
Subject: [PATCH v2 5/5] completion: add an use
 __git_compute_second_level_config_vars_for_section
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

In a previous commit we removed some hardcoded config variable names from
function __git_complete_config_variable_name in the completion script by
introducing a new function,
__git_compute_first_level_config_vars_for_section.

The remaining hardcoded config variables are "second level"
configuration variables, meaning 'branch.<name>.upstream',
'remote.<name>.url', etc. where <name> is a user-defined name.

Making use of the new --config-all-for-completion flag to 'git help'
introduced in the previous commit, add a new function,
__git_compute_second_level_config_vars_for_section. This function takes
as argument a config section name and computes the corresponding
second-level config variables, i.e. those that contain a '<' which
indicates the start of a placeholder. Note that as in
__git_compute_first_level_config_vars_for_section added previsouly, we
use indirect expansion instead of associative arrays to stay compatible
with Bash 3 on which macOS is stuck for licensing reasons.

Use this new function and the variables it defines in
__git_complete_config_variable_name to remove hardcoded config
variables, and add a test to verify the new function.  Use a single
'case' for all sections with second-level variables names, since the
code for each of them is now exactly the same.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 71 ++++++++------------------
 t/t9902-completion.sh                  | 10 ++++
 2 files changed, 31 insertions(+), 50 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2934ceb7637..0e8fd63bfdb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2596,6 +2596,13 @@ __git_compute_config_vars ()
 	__git_config_vars="$(git help --config-for-completion)"
 }
 
+__git_config_vars_all=
+__git_compute_config_vars_all ()
+{
+	test -n "$__git_config_vars_all" ||
+	__git_config_vars_all="$(git help --config-all-for-completion)"
+}
+
 __git_compute_first_level_config_vars_for_section ()
 {
 	section="$1"
@@ -2605,6 +2612,15 @@ __git_compute_first_level_config_vars_for_section ()
 	printf -v "__git_first_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars" | grep -E "^${section}\.[a-z]" | awk -F. '{print $2}')"
 }
 
+__git_compute_second_level_config_vars_for_section ()
+{
+	section="$1"
+	__git_compute_config_vars_all
+	local this_section="__git_second_level_config_vars_for_section_${section}"
+	test -n "${!this_section}" ||
+	printf -v "__git_second_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars_all" | grep -E "^${section}\.<" | awk -F. '{print $3}')"
+}
+
 __git_config_sections=
 __git_compute_config_sections ()
 {
@@ -2749,10 +2765,13 @@ __git_complete_config_variable_name ()
 	done
 
 	case "$cur_" in
-	branch.*.*)
+	branch.*.*|guitool.*.*|difftool.*.*|man.*.*|mergetool.*.*|remote.*.*|submodule.*.*|url.*.*)
 		local pfx="${cur_%.*}."
 		cur_="${cur_##*.}"
-		__gitcomp "remote pushRemote merge mergeOptions rebase" "$pfx" "$cur_" "$sfx"
+		local section="${pfx%.*.}"
+		__git_compute_second_level_config_vars_for_section "${section}"
+		local this_section="__git_second_level_config_vars_for_section_${section}"
+		__gitcomp "${!this_section}" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	branch.*)
@@ -2765,33 +2784,6 @@ __git_complete_config_variable_name ()
 		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
-	guitool.*.*)
-		local pfx="${cur_%.*}."
-		cur_="${cur_##*.}"
-		__gitcomp "
-			argPrompt cmd confirm needsFile noConsole noRescan
-			prompt revPrompt revUnmerged title
-			" "$pfx" "$cur_" "$sfx"
-		return
-		;;
-	difftool.*.*)
-		local pfx="${cur_%.*}."
-		cur_="${cur_##*.}"
-		__gitcomp "cmd path" "$pfx" "$cur_" "$sfx"
-		return
-		;;
-	man.*.*)
-		local pfx="${cur_%.*}."
-		cur_="${cur_##*.}"
-		__gitcomp "cmd path" "$pfx" "$cur_" "$sfx"
-		return
-		;;
-	mergetool.*.*)
-		local pfx="${cur_%.*}."
-		cur_="${cur_##*.}"
-		__gitcomp "cmd path trustExitCode" "$pfx" "$cur_" "$sfx"
-		return
-		;;
 	pager.*)
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
@@ -2799,15 +2791,6 @@ __git_complete_config_variable_name ()
 		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
-	remote.*.*)
-		local pfx="${cur_%.*}."
-		cur_="${cur_##*.}"
-		__gitcomp "
-			url proxy fetch push mirror skipDefaultUpdate
-			receivepack uploadpack tagOpt pushurl
-			" "$pfx" "$cur_" "$sfx"
-		return
-		;;
 	remote.*)
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
@@ -2818,12 +2801,6 @@ __git_complete_config_variable_name ()
 		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
-	submodule.*.*)
-		local pfx="${cur_%.*}."
-		cur_="${cur_##*.}"
-		__gitcomp "url update branch fetchRecurseSubmodules ignore active" "$pfx" "$cur_" "$sfx"
-		return
-		;;
 	submodule.*)
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
@@ -2834,12 +2811,6 @@ __git_complete_config_variable_name ()
 		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
-	url.*.*)
-		local pfx="${cur_%.*}."
-		cur_="${cur_##*.}"
-		__gitcomp "insteadOf pushInsteadOf" "$pfx" "$cur_" "$sfx"
-		return
-		;;
 	*.*)
 		__git_compute_config_vars
 		__gitcomp "$__git_config_vars" "" "$cur_" "$sfx"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f28d8f531b7..24ff786b273 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2593,6 +2593,16 @@ test_expect_success 'git config - variable name - __git_compute_first_level_conf
 	submodule.recurse Z
 	EOF
 '
+test_expect_success 'git config - variable name - __git_compute_second_level_config_vars_for_section' '
+	test_completion "git config branch.main." <<-\EOF
+	branch.main.description Z
+	branch.main.remote Z
+	branch.main.pushRemote Z
+	branch.main.merge Z
+	branch.main.mergeOptions Z
+	branch.main.rebase Z
+	EOF
+'
 
 test_expect_success 'git config - value' '
 	test_completion "git config color.pager " <<-\EOF
-- 
gitgitgadget
