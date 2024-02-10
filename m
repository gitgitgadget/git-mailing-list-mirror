Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ACA5F541
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707589951; cv=none; b=srW0PAY/O6dhFlxQHVhnNNyZdOuPd32mzHRfDVpTzPS/GofYzJB6DDZzdZYgAOkWDdqiiTJhDvqufeBDCnkzSqWZa7x+8dvptvqylemBV/R0KZG5z1a46h8sH3zZSxmcACO1OKa51AAYlfDZBkTsPubwk8uSSPqcyOh+wqo13y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707589951; c=relaxed/simple;
	bh=1B7nMQQLgndswKoqVcty1DD3R04c/2YZwxQqakYNx3A=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jK2epjrDnYCCgADnKiaElZ8+DWUBK/FYipOepFW+A2SY5AK4lP8SIL1432HmTWJPGVrVQS/8+VUu7iKmlRrsLQgR9bFuYjSV/7PGtk3WO07Z8yLvQMSYM6DkYh5i1HsTQVwiMawepP8p9qyEuMULDkL6IuIau1//xYNekJAzCsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3SUiu8q; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3SUiu8q"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33934567777so1204646f8f.1
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 10:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707589947; x=1708194747; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqcjWz8xooQ3K/z64XDV+HCnX2km7HdlTTng5E39nX0=;
        b=A3SUiu8qlkZTy6TDTSW9dt4MMdQAjoy9BBBcQ/NFg3OoCN7tnXaFmNvxkl77w7oTD0
         s/tRK4N9GlW/tdKU7plSbxAkBOjItg0jrPGUkG2hP55PyGBo4vIQ8vqUqcHXRiTrFFX4
         mOZzerhK7I0Aph7RoaHBXrQVqM6lQgaxio7WKurMuVFkamSzbW40TIDQeUftKMdcKFgd
         32u2RskGxmxFfpYzQQ47VD6PaQ/asMR+1/TcsTuttfLs0XilSeDiYJqU/2qbgj9BWkKH
         sDGf9VrAx+aBiGZrJ9adV7OBRWAWyriDb8Z1gbpsm9WFkRDbJAh+WtyCtmPw8NnFWT9C
         OeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707589947; x=1708194747;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqcjWz8xooQ3K/z64XDV+HCnX2km7HdlTTng5E39nX0=;
        b=LLEyFnUBdPjP2NvZTRXTYw1rFg2rOH8Lzwd5vAkWGKUXMON8MjAFwCZjJNovvE8WYI
         DgUrICvD7E6pCCTfyMU+nJ+ssneOP+awJRs5pVRfE2hgLDrNhMFdlrp5newRlX6PrAaP
         1+D5Bw941szN90Nj6tdm3FieI1Pk/qdAgyokqMnZ+m7u5B1klcbpbEuGKccu5MB3vLJr
         6HQxlI8PWukJhMy323s/gGV6T0MxNV+KeO9uie8X38a/YLbGYLoGZhIdNrSO38H8mGKd
         I9u2xHZHun7Gewi0QV6WycWKdr712uKT0UnEEbxVwb0nGAohElM2bMAHxRPaE8o3HP0+
         vSHw==
X-Gm-Message-State: AOJu0Yzl1NBqCDiFyPqzJ0pGPfyqYlembSUlQ/T5o1wu36Qw86Fpl1XS
	iD3JbAhpbtZz7/ug8NSzP9fZVVr2A1unD/96L4YUrpIf1xrwDSN7dDWA0XID
X-Google-Smtp-Source: AGHT+IHuBp0MtEaoI5cPukLCk+BQ37kPE1QVyzDNCLJ3ClOJ9vww5WKldVI3G/S+IWTaHOIq9trNUw==
X-Received: by 2002:adf:fcd0:0:b0:33b:2d46:74e with SMTP id f16-20020adffcd0000000b0033b2d46074emr1906261wrs.55.1707589947330;
        Sat, 10 Feb 2024 10:32:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpwgWrKfy5/PaBqu0jd98nKoC1EkIR0pyJS0vkuoouU1+HLDNdrbwAgZGr8NAa1CN5WBXNAvKGPPvFHXmxGmo5GSPRZarxhhwMY+jV5A==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d428c000000b0033b4d603e13sm2432673wrq.51.2024.02.10.10.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 10:32:26 -0800 (PST)
Message-ID: <69fc02bb6b493451f092c81a0cceedfc38d59f7f.1707589943.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.v3.git.git.1707589943.gitgitgadget@gmail.com>
References: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
	<pull.1660.v3.git.git.1707589943.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Feb 2024 18:32:23 +0000
Subject: [PATCH v3 4/4] completion: add and use
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

In a previous commit we removed some hardcoded config variable names from
function __git_complete_config_variable_name in the completion script by
introducing a new function,
__git_compute_first_level_config_vars_for_section.

The remaining hardcoded config variables are "second level"
configuration variables, meaning 'branch.<name>.upstream',
'remote.<name>.url', etc. where <name> is a user-defined name.

Making use of the new existing --config flag to 'git help', add a new
function, __git_compute_second_level_config_vars_for_section. This
function takes as argument a config section name and computes the
corresponding second-level config variables, i.e. those that contain a
'<' which indicates the start of a placeholder. Note that as in
__git_compute_first_level_config_vars_for_section added previsouly, we
use indirect expansion instead of associative arrays to stay compatible
with Bash 3 on which macOS is stuck for licensing reasons.

As explained in the previous commit, we use the existing pattern in the
completion script of using global variables to cache the list of
variables for each section.

Use this new function and the variables it defines in
__git_complete_config_variable_name to remove hardcoded config
variables, and add a test to verify the new function.  Use a single
'case' for all sections with second-level variables names, since the
code for each of them is now exactly the same.

Adjust the name of a test added in a previous commit to reflect that it
now tests the added function.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 71 ++++++++------------------
 t/t9902-completion.sh                  |  2 +-
 2 files changed, 22 insertions(+), 51 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 57a8da7ca1a..87678a5bb36 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2596,6 +2596,13 @@ __git_compute_config_vars ()
 	__git_config_vars="$(git help --config-for-completion)"
 }
 
+__git_config_vars_all=
+__git_compute_config_vars_all ()
+{
+	test -n "$__git_config_vars_all" ||
+	__git_config_vars_all="$(git --no-pager help --config)"
+}
+
 __git_compute_first_level_config_vars_for_section ()
 {
 	local section="$1"
@@ -2605,6 +2612,15 @@ __git_compute_first_level_config_vars_for_section ()
 	printf -v "__git_first_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars" | grep -E "^${section}\.[a-z]" | awk -F. '{print $2}')"
 }
 
+__git_compute_second_level_config_vars_for_section ()
+{
+	local section="$1"
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
index 8600b9e0dd9..64031a9eff8 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2601,7 +2601,7 @@ test_expect_success 'git config - variable name - submodule and __git_compute_fi
 	EOF
 '
 
-test_expect_success 'git config - variable name - submodule names' '
+test_expect_success 'git config - variable name - __git_compute_second_level_config_vars_for_section' '
 	test_completion "git config submodule.sub." <<-\EOF
 	submodule.sub.url Z
 	submodule.sub.update Z
-- 
gitgitgadget
