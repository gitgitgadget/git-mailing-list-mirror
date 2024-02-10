Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C25F471
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707589950; cv=none; b=MIiMWOOIq20ZwSSWt7fcq19ETa42vyg/PJlgOhbIBuZlVXlQa1ykA3RiB7zKdkRM8nRhdLoK5D2XmzRGUlxd5N44AJrCGomnu9XhnhDlblComrLhQMWNzkI4bW5WmOmQ+fjqJDdBsskhM660UcNiKbBkpM97gNTNoWpETp69Lx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707589950; c=relaxed/simple;
	bh=alQ3/w+LGgEE6dsb8l5wpj01Dn77OLwasMFlY5L2dP0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IaIhSUdRS6lBqZ5Mz7R5PSm1j9DMUHRvUg5n3JB0VEvH0ml2xjr1bbGD1WfzPv73WMPXteFPLOg+DIUUKzVUZ9j+t342LmZ8f5XTmB6YqeD5SIuKfnMobuWiuhEVeqT6EnmgkfG5AfvngXLUjeWvHzy8DOKTzyT50EkdsYm334o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3uyDsw9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3uyDsw9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40efcb37373so16126185e9.2
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 10:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707589946; x=1708194746; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQ/8Hg8nCWkcgC2FQbIZVtX/5ooTLnq/aOnHP59eQ8E=;
        b=K3uyDsw9+QTnLb4sejGdCH4vG2dWiUGDyYFIHc56OIJuAQb3ejKv1uvFIUB1EVdnic
         Eti3dv0i0REm7IOlMmY95nYIUJoBYhlMhWkmDV65ip1prxb+Mr/IqAVrcohwEayVLTWT
         qPyar5hwiPDKLN4TeiojmyY126zo+hcWQY0XgLtZI7k8MaLlxfu2Vgl3rG0VTHqY5bTv
         2nPO2iNxT/w9Uvo+ayGp/uKF/6WSP8PV1pLqCqsYJrHxzyem3AKDGx3jOrvBowDkKdoC
         bUwTH/njPpjqplHOZ2yEi4ymnSynS6TULz4qiFtfZ9C0Va8BOBDiwBzCk20X3/ia/XCb
         DbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707589946; x=1708194746;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ/8Hg8nCWkcgC2FQbIZVtX/5ooTLnq/aOnHP59eQ8E=;
        b=R93atIEZmB6+OVVzxwT7weX5WwtUex27ez92y2A/whR5u6G5leV+4Tx3fg70gOFxyg
         cFgMkNe+NTeOcUa86N85Ot9s6nNf1+9KdYbbt+VlxQ1/r1rWFgW1XV2Tx4JwzXecMhj1
         oHqD4u4ignBCmGuvyzVU1In/0ovw/JqBYqeXwv+mZZo6gBrVholVE/F8eTC/43JH7ymP
         KTQj0I1eTMZveTj/sdVWylm0qpt1g9Id6vKBIZrFRV5eunxsjPlI/TZMtCFNT2dCzyuE
         hLwakjGKabRGUVteyr5vyRH/tTmezi0HDWZ7uiiiqBkKKJ2NvoRTCI4Ryka6PqWBTi+r
         gQIg==
X-Gm-Message-State: AOJu0YylYWTc1TKi2RSkryByGoT/a7tU9MLajMdrhMk3NfvaAfNrWgbB
	QpozFXBzetVmcTqvo+5/fwO2sH6SZIi5dPQTdy22+NQIy6kDW3sh/EEqL/lw
X-Google-Smtp-Source: AGHT+IExEL5F+08Ufv0HdqMI9YZRo+sts+joZ4zAh7L2ZNp4DupHLQPLEWKRt2fAaoKYMvQRkYP9/g==
X-Received: by 2002:a05:600c:3b21:b0:40e:b313:b8db with SMTP id m33-20020a05600c3b2100b0040eb313b8dbmr2421162wms.28.1707589946571;
        Sat, 10 Feb 2024 10:32:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuZtv1jNnWRWBwIZhV+WZlpdy+94ZRBZorpVCrn440ppURIn3ddcHhMZ4JyvE3ay0ARUADeDB6F86oAz0TFTDCJo0+bI7fKiUitq6rog==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b004100b3c41absm4002680wmq.30.2024.02.10.10.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 10:32:26 -0800 (PST)
Message-ID: <fb210325394af2cc3389a780736d236bf9ac4f93.1707589943.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.v3.git.git.1707589943.gitgitgadget@gmail.com>
References: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
	<pull.1660.v3.git.git.1707589943.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Feb 2024 18:32:22 +0000
Subject: [PATCH v3 3/4] completion: add and use
 __git_compute_first_level_config_vars_for_section
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

The function __git_complete_config_variable_name in the Bash completion
script hardcodes several config variable names. These variables are
those in config sections where user-defined names can appear, such as
"branch.<name>". These sections are treated first by the case statement,
and the two last "catch all" cases are used for other sections, making
use of the __git_compute_config_vars and __git_compute_config_sections
function, which omit listing any variables containing wildcards or
placeholders. Having hardcoded config variables introduces the risk of
the completion code becoming out of sync with the actual config
variables accepted by Git.

To avoid these hardcoded config variables, introduce a new function,
__git_compute_first_level_config_vars_for_section, making use of the
existing __git_config_vars variable. This function takes as argument a
config section name and computes the matching "first level" config
variables for that section, i.e. those _not_ containing any placeholder,
like 'branch.autoSetupMerge, 'remote.pushDefault', etc.  Use this
function and the variables it defines in the 'branch.*', 'remote.*' and
'submodule.*' switches of the case statement instead of hardcoding the
corresponding config variables.  Note that we use indirect expansion to
create a variable for each section, instead of using a single
associative array indexed by section names, because associative arrays
are not supported in Bash 3, on which macOS is stuck for licensing
reasons.

Use the existing pattern in the completion script of using global
variables to cache the list of config variables for each section. The
rationale for such caching is explained in eaa4e6ee2a (Speed up bash
completion loading, 2009-11-17), and the current approach to using and
defining them via 'test -n' is explained in cf0ff02a38 (completion: work
around zsh option propagation bug, 2012-02-02).

Adjust the name of one of the tests added in the previous commit,
reflecting that it now also tests the new function.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 24 +++++++++++++++++++++---
 t/t9902-completion.sh                  |  2 +-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8af9bc3f4e1..57a8da7ca1a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2596,6 +2596,15 @@ __git_compute_config_vars ()
 	__git_config_vars="$(git help --config-for-completion)"
 }
 
+__git_compute_first_level_config_vars_for_section ()
+{
+	local section="$1"
+	__git_compute_config_vars
+	local this_section="__git_first_level_config_vars_for_section_${section}"
+	test -n "${!this_section}" ||
+	printf -v "__git_first_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars" | grep -E "^${section}\.[a-z]" | awk -F. '{print $2}')"
+}
+
 __git_config_sections=
 __git_compute_config_sections ()
 {
@@ -2749,8 +2758,11 @@ __git_complete_config_variable_name ()
 	branch.*)
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
+		local section="${pfx%.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx:- }"
+		__git_compute_first_level_config_vars_for_section "${section}"
+		local this_section="__git_first_level_config_vars_for_section_${section}"
+		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	guitool.*.*)
@@ -2799,8 +2811,11 @@ __git_complete_config_variable_name ()
 	remote.*)
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
+		local section="${pfx%.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx:- }"
+		__git_compute_first_level_config_vars_for_section "${section}"
+		local this_section="__git_first_level_config_vars_for_section_${section}"
+		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	submodule.*.*)
@@ -2812,8 +2827,11 @@ __git_complete_config_variable_name ()
 	submodule.*)
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
+		local section="${pfx%.}"
 		__gitcomp_nl "$(__git config -f "$(__git rev-parse --show-toplevel)/.gitmodules" --get-regexp 'submodule.*.path' | awk -F. '{print $2}')" "$pfx" "$cur_" "."
-		__gitcomp_nl_append $'alternateErrorStrategy\nfetchJobs\nactive\nalternateLocation\nrecurse\npropagateBranches' "$pfx" "$cur_" "${sfx:- }"
+		__git_compute_first_level_config_vars_for_section "${section}"
+		local this_section="__git_first_level_config_vars_for_section_${section}"
+		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	url.*.*)
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 23d0e71324c..8600b9e0dd9 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2589,7 +2589,7 @@ test_expect_success 'setup for git config submodule tests' '
 	git submodule add ./sub
 '
 
-test_expect_success 'git config - variable name - submodule' '
+test_expect_success 'git config - variable name - submodule and __git_compute_first_level_config_vars_for_section' '
 	test_completion "git config submodule." <<-\EOF
 	submodule.active Z
 	submodule.alternateErrorStrategy Z
-- 
gitgitgadget

