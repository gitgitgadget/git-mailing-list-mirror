Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B989C1F45C
	for <e@80x24.org>; Tue, 13 Aug 2019 12:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfHMM1R (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:27:17 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:42905 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbfHMM1O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:27:14 -0400
Received: by mail-wr1-f44.google.com with SMTP id b16so10862669wrq.9
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rEPmkj+POqXtHaTq12MU/27C0/Y21KxJ2xUmkHNWaL0=;
        b=mSfG1QsUyUwkN7txdHI/bznEEz17livqsLdH2wmdUNoZ2IMhqFaIXGQ8KM/jW+l6wp
         Jon7IwiWEVwA347fd4a7LBSGf26LXZDXHqGb6zpevaXNakYx6IhSldEJFw5HBG8sAO/n
         Su8BgZwqT/2sTWd8yo4WxHJcmenbzccHLZ9zPw0d65pZlCeFRwjq66X93wH3PFeKMqds
         XAitcTWg6y+1Z/3gRPFTOkQFE1M4pD1+4nV2OFk7V0EZBIadcjyyLVBT7wmzYxlOzm+b
         x+SVdXhlYdn7ePVdV5BSTKDmWAn4eVfysV2xGefLYHENGxuKnzFY7GWbNeBjE1DeV9z+
         PxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rEPmkj+POqXtHaTq12MU/27C0/Y21KxJ2xUmkHNWaL0=;
        b=HorM61IqyYhqewnZsvXJY5Xo71sWOqmttYUHOdYoOn9pCqHuUgBigD/onktLjy6ghA
         mXJDcpGF/H/86CubC0bBVF4kCdALePNX4dMl2IIKztPM8dg7LCvtexMlFHdMtBha9gqn
         4bZOciyZrnLBhwwl7W1ZiZeAlemyzXy2eFZ45W1XOKiTSGcSCck8a+O1ZrF1BtaPFFMG
         6JD0nc31tK1spStrtQZe3ejIBwM3muS+xb+M7LzGiSTTVxdncp1IJjOvqLUQNt/G+3uG
         OpcnotH1hHEwjvbQlDk5JGsno58O3xMcUR8Mg2yWz55g1/fgO9S7YU+B7OJK5zo0iQ2B
         rd8g==
X-Gm-Message-State: APjAAAW8LFhsaQVsm46kxDqUfbNtvf8JVh0B+EjRw55qLoCbXKUB3kyR
        6dGNeOrixuwco3Ms+L/4KKU=
X-Google-Smtp-Source: APXvYqzuCF4+36xqEkeRFJbQp/8gLBhP3lNmWZ/sae68mU1avZPH/Vg1K1Q/gWMOMYWvFiXmzo8HhA==
X-Received: by 2002:adf:d182:: with SMTP id v2mr18121521wrc.49.1565699232819;
        Tue, 13 Aug 2019 05:27:12 -0700 (PDT)
Received: from localhost.localdomain (x4db44abf.dyn.telefonica.de. [77.180.74.191])
        by smtp.gmail.com with ESMTPSA id r5sm1978069wmh.35.2019.08.13.05.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:27:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 08/11] completion: complete configuration sections and variable names for 'git -c'
Date:   Tue, 13 Aug 2019 14:26:49 +0200
Message-Id: <20190813122652.16468-9-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.350.gf4fdc32db7
In-Reply-To: <20190813122652.16468-1-szeder.dev@gmail.com>
References: <20190813122652.16468-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git config' expects a configuration variable's name and value in
separate arguments, so we let the __gitcomp() helper append a space
character to each variable name by default, like we do for most other
things (--options, refs, paths, etc.).  'git -c', however, expects
them in a single option joined by a '=' character, i.e.
'section.name=value', so we should append a '=' character to each
fully completed variable name, but no space, so the user can continue
typing the value right away.

Add an option to the __git_complete_config_variable_name() function to
allow callers to specify an alternate suffix to add, and use it to
append that '=' character to configuration variables.  Update the
__gitcomp() helper function to not append a trailing space to any
completion words ending with a '=', not just to those option with a
stuck argument.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 59 ++++++++++++++++++++------
 t/t9902-completion.sh                  | 14 ++++++
 2 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3e9c5b6b71..367b1c50f4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -360,7 +360,7 @@ __gitcomp ()
 			c="$c${4-}"
 			if [[ $c == "$cur_"* ]]; then
 				case $c in
-				--*=|*.) ;;
+				*=|*.) ;;
 				*) c="$c " ;;
 				esac
 				COMPREPLY[i++]="${2-}$c"
@@ -2328,18 +2328,33 @@ __git_complete_config_variable_value ()
 }
 
 # Completes configuration sections, subsections, variable names.
+#
+# Usage: __git_complete_config_variable_name [<option>]...
+# --sfx=<suffix>: A suffix to be appended to each fully completed
+#                 configuration variable name (but not to sections or
+#                 subsections) instead of the default space.
 __git_complete_config_variable_name ()
 {
+	local sfx
+
+	while test $# != 0; do
+		case "$1" in
+		--sfx=*)	sfx="${1##--sfx=}" ;;
+		*)		return 1 ;;
+		esac
+		shift
+	done
+
 	case "$cur" in
 	branch.*.*)
 		local pfx="${cur%.*}." cur_="${cur##*.}"
-		__gitcomp "remote pushRemote merge mergeOptions rebase" "$pfx" "$cur_"
+		__gitcomp "remote pushRemote merge mergeOptions rebase" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	branch.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_"
+		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
@@ -2347,28 +2362,28 @@ __git_complete_config_variable_name ()
 		__gitcomp "
 			argPrompt cmd confirm needsFile noConsole noRescan
 			prompt revPrompt revUnmerged title
-			" "$pfx" "$cur_"
+			" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	difftool.*.*)
 		local pfx="${cur%.*}." cur_="${cur##*.}"
-		__gitcomp "cmd path" "$pfx" "$cur_"
+		__gitcomp "cmd path" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	man.*.*)
 		local pfx="${cur%.*}." cur_="${cur##*.}"
-		__gitcomp "cmd path" "$pfx" "$cur_"
+		__gitcomp "cmd path" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	mergetool.*.*)
 		local pfx="${cur%.*}." cur_="${cur##*.}"
-		__gitcomp "cmd path trustExitCode" "$pfx" "$cur_"
+		__gitcomp "cmd path trustExitCode" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	pager.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	remote.*.*)
@@ -2376,23 +2391,23 @@ __git_complete_config_variable_name ()
 		__gitcomp "
 			url proxy fetch push mirror skipDefaultUpdate
 			receivepack uploadpack tagOpt pushurl
-			" "$pfx" "$cur_"
+			" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	remote.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_"
+		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
 		local pfx="${cur%.*}." cur_="${cur##*.}"
-		__gitcomp "insteadOf pushInsteadOf" "$pfx" "$cur_"
+		__gitcomp "insteadOf pushInsteadOf" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	*.*)
 		__git_compute_config_vars
-		__gitcomp "$__git_config_vars"
+		__gitcomp "$__git_config_vars" "" "$cur" "$sfx"
 		;;
 	*)
 		__git_compute_config_vars
@@ -2409,6 +2424,20 @@ __git_complete_config_variable_name ()
 	esac
 }
 
+# Completes '='-separated configuration sections/variable names and values
+# for 'git -c section.name=value'.
+__git_complete_config_variable_name_and_value ()
+{
+	case "$cur" in
+	*=*)
+		# in the next patch...
+		;;
+	*)
+		__git_complete_config_variable_name --sfx='='
+		;;
+	esac
+}
+
 _git_config ()
 {
 	case "$prev" in
@@ -2984,7 +3013,11 @@ __git_main ()
 			# Bash filename completion
 			return
 			;;
-		-c|--namespace)
+		-c)
+			__git_complete_config_variable_name_and_value
+			return
+			;;
+		--namespace)
 			# we don't support completing these options' arguments
 			return
 			;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 008fba7c89..bf60a11fa8 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1719,6 +1719,20 @@ test_expect_success 'git config - value' '
 	EOF
 '
 
+test_expect_success 'git -c - section' '
+	test_completion "git -c br" <<-\EOF
+	branch.Z
+	browser.Z
+	EOF
+'
+
+test_expect_success 'git -c - variable name' '
+	test_completion "git -c log.d" <<-\EOF
+	log.date=Z
+	log.decorate=Z
+	EOF
+'
+
 test_expect_success 'sourcing the completion script clears cached commands' '
 	__git_compute_all_commands &&
 	verbose test -n "$__git_all_commands" &&
-- 
2.23.0.rc2.350.gf4fdc32db7

