Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF843C471
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472183; cv=none; b=PGDhUp6kuoTqG9nal0gWBhd7U+PkWnPlL047j3T7KlYSc7ELsdl5pubidln7NvXwb790F50E26va8+AeEzWN3CROulwb50wyWZ1I/3S5i3pAvBDGAinhiImjl93u5kdb9tAc25du0DJRRwxjbBtDTBMUzbSOqLa2vJ84gfOpI7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472183; c=relaxed/simple;
	bh=qs2JfaacomBYZSJbBIC0nQLE5azEC+6LeTMFhMZ7orA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nWsA9I6daTcV3VxXoiz9EEQTOQKx9BsqKtQikg4hDeb6rR5fWhiX4152QXVBKTb9o7+1S19EMjABIEtT/kjhqOTmF9wq2vOCRRIN5pYV3ZPpE77iNsBEhMdHn+7QwZ3PxM6Z8fJIaZaTUo+4LgJgYTHnlJs6VXTm3i6ndculrCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeJttMQa; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeJttMQa"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3392b045e0aso1904980f8f.2
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 12:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706472179; x=1707076979; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI8Axo9a8gsIKHPMBImKiuAar+merz8URnLTsQpVhl4=;
        b=eeJttMQaR3ie7i0NNAev3TV5OgoL5Oj0GKrafth8N3FLLIkPeM8E6JQO00Jz0JgiMb
         xVb8ZE/+Jo6Q4AdZnaHDwrpYTG8DzTDMuvdQCmozNAy5nCNB/AT+QJY/QNviVRvNQmPJ
         HTpXeo4EqdLNWHYkteHn3vKBYv0yM7D+ILqlh0uaGZi5UkODBN6L6J5yhw2HjMHRfcu0
         /os/RZsv0As/cCSr/SahuNhNVWWvNpMprSFGgymOQ8hQUdkSaXtWQgyP1Cp/p8NAEuhl
         5entDW7inHX67DAb5j3aYJMX3jVLwJSWntmj4S9tm0CnAVzD2V/574tFVM7Qf+WBUiGE
         wQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706472179; x=1707076979;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pI8Axo9a8gsIKHPMBImKiuAar+merz8URnLTsQpVhl4=;
        b=cEvCn6+Kvu0wvJ6wwyYvURW+xcTF1lXxdPWmd5fTOsIIpmXNYJOsHQXjh0u+6lSRfn
         icAkTcSB8lIyD5J6JYwde+SJG8qc3rtRF9FXUSyewerEAM9yz2W91zJ+29fElZwuO+vC
         0DF9l0ZjMiPRQU2tMgBMsJjbypSNi5gb/ELLLvEc0ajj7e2upL60/neqHLqmsFZS1dNr
         r5DEckma/ac8fMSds5YxR/eKyNlxK4q3U+ZgixYfFVbp2h0h56W1Zx970Xd1Hk8e83C4
         BGV/qvCtdnGUPE4XCCFEAeSPxh4/m0z7ZG6nX1xWsZ3v9AGIoBs2ahsJIhb3AkggnDRO
         LF2Q==
X-Gm-Message-State: AOJu0Yzxuo/60CnRr/j8X9p+WAkSLGhw5X74/XoL244AAv2SX/QQswkk
	AIrvA2/b91LnvCTpiI2y9mC1wQjdYrvwKoVQoGwVascXR7Bb9xlkrfCDpYiT
X-Google-Smtp-Source: AGHT+IEzRBRbvjVQ0FSBv/lg31Xku2CLjdzKfodWFaLfEsolNUCnF10eM6poTX7DmcLrbxDQOHfqkA==
X-Received: by 2002:adf:f145:0:b0:33a:df29:eba2 with SMTP id y5-20020adff145000000b0033adf29eba2mr2867515wro.65.1706472179325;
        Sun, 28 Jan 2024 12:02:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2-20020adfa1c2000000b0033921f48044sm6305822wrv.55.2024.01.28.12.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 12:02:59 -0800 (PST)
Message-ID: <b41844cd86e74a7d4af84487d4a6f9cb72655e47.1706472173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jan 2024 20:02:53 +0000
Subject: [PATCH 5/5] completion: add an use
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
