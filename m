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
	by dcvr.yhbt.net (Postfix) with ESMTP id 752251F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfHMM1T (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:27:19 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:54463 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfHMM1S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:27:18 -0400
Received: by mail-wm1-f50.google.com with SMTP id p74so1324911wme.4
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=trG6jeg+dluOb+roCHGvhIn7E55rk3GXBHIJwae422k=;
        b=IQZUJ74Gf1O33fwv9opO0wWA4wlt8SZqhfmH2xFMjSK9+jZ9oqPPA59qo3tH4jIB4E
         rIKt1mnuGZN0FYwSrSWrx6qhde68Yjd7UX6DB1SMttfeqz44ONxqiNx8Xhk6+JU6UCiR
         qEsqzOAkJAd6q6ik8bPysd/wG2TNvf6ChBSmYnHys4KxjXSlkwv5g2oEJ//Ohl2JXKOl
         ByJJsnvf/Yzp9P4dm+OFgnCm8V36HSmGSBcnbtyCphxd4v3uek5Cltg0YnBJqQskk+AO
         bHVi7OzkRCSgTHKjfqQokglBHxF3SNy+7xb0TncFv9KTr66giYeF+KUaP7AvdqPV1byR
         v14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trG6jeg+dluOb+roCHGvhIn7E55rk3GXBHIJwae422k=;
        b=liefGL0PsCh7Yl92n8Z9KM8pqD5F8sOUO3S5DclS0pX12JY3hFf5jAAE8VJTtOc9Eu
         A0uz7LtDbdglvSY3LX/UDW86jFa4tMTpiImSrzfSW0N1rwHHEp4ysI5z72apMqwo9iQU
         NKicYZidTZN7Ewe8hQ9gFIW5htclX8YQ4vOe87zTcMXZySEPISx+Vcz4sz7FAMr9xSA7
         Te73Jm/TM/2xfNWhX6mpWS8/rlRHYx5rC8kLRte/Tclx2R2s3y+htQpGxpUx/7TZhe4p
         Z6EDm0UH/Wx1HjL3N1mV3jXE0qgp53hTMMN5c+hTmFybTsNmYCWvBe+nb0I+geWe3yJd
         HzFw==
X-Gm-Message-State: APjAAAX3+ppFLaxb96q6CAnLC26ngWGWrDYEHkdkh5vcRBhZufcn4fYj
        lDCiIOQelb7XyK5fUfpcP5U=
X-Google-Smtp-Source: APXvYqwZkU+hf+7Altu+VWEeU79BwzBo6EFsZ6jE3+KHuUBhaS+L6OTIG8a8XYTi/jpcG3v8CgQMDA==
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr2841821wmj.11.1565699236262;
        Tue, 13 Aug 2019 05:27:16 -0700 (PDT)
Received: from localhost.localdomain (x4db44abf.dyn.telefonica.de. [77.180.74.191])
        by smtp.gmail.com with ESMTPSA id r5sm1978069wmh.35.2019.08.13.05.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:27:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 11/11] completion: complete config variables and values for 'git clone --config='
Date:   Tue, 13 Aug 2019 14:26:52 +0200
Message-Id: <20190813122652.16468-12-szeder.dev@gmail.com>
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

Completing configuration sections and variable names for the stuck
argument of 'git clone --config=<TAB>' requires a bit of extra care
compared to doing the same for the unstuck argument of 'git clone
--config <TAB>', because we have to deal with that '--config=' being
part of the current word to be completed.

Add an option to the __git_complete_config_variable_name_and_value()
and in turn to the __git_complete_config_variable_name() helper
functions to specify the current section/variable name to be
completed, so they can be used even when completing the stuck argument
of '--config='.

__git_complete_config_variable_value() already has such an option, and
thus no further changes were necessary to complete possible values
after 'git clone --config=section.name=<TAB>'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 66 +++++++++++++++++++-------
 t/t9902-completion.sh                  | 21 ++++++++
 2 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 279f04df87..ce7ff0a96d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1406,6 +1406,11 @@ _git_clone ()
 		;;
 	esac
 	case "$cur" in
+	--config=*)
+		__git_complete_config_variable_name_and_value \
+			--cur="${cur##--config=}"
+		return
+		;;
 	--*)
 		__gitcomp_builtin clone
 		return
@@ -2352,35 +2357,41 @@ __git_complete_config_variable_value ()
 # Completes configuration sections, subsections, variable names.
 #
 # Usage: __git_complete_config_variable_name [<option>]...
+# --cur=<word>: The current configuration section/variable name to be
+#               completed.  Defaults to the current word to be completed.
 # --sfx=<suffix>: A suffix to be appended to each fully completed
 #                 configuration variable name (but not to sections or
 #                 subsections) instead of the default space.
 __git_complete_config_variable_name ()
 {
-	local sfx
+	local cur_="$cur" sfx
 
 	while test $# != 0; do
 		case "$1" in
+		--cur=*)	cur_="${1##--cur=}" ;;
 		--sfx=*)	sfx="${1##--sfx=}" ;;
 		*)		return 1 ;;
 		esac
 		shift
 	done
 
-	case "$cur" in
+	case "$cur_" in
 	branch.*.*)
-		local pfx="${cur%.*}." cur_="${cur##*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_##*.}"
 		__gitcomp "remote pushRemote merge mergeOptions rebase" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	branch.*)
-		local pfx="${cur%.*}." cur_="${cur#*.}"
+		local pfx="${cur%.*}."
+		cur_="${cur#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
 		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
-		local pfx="${cur%.*}." cur_="${cur##*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_##*.}"
 		__gitcomp "
 			argPrompt cmd confirm needsFile noConsole noRescan
 			prompt revPrompt revUnmerged title
@@ -2388,28 +2399,33 @@ __git_complete_config_variable_name ()
 		return
 		;;
 	difftool.*.*)
-		local pfx="${cur%.*}." cur_="${cur##*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_##*.}"
 		__gitcomp "cmd path" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	man.*.*)
-		local pfx="${cur%.*}." cur_="${cur##*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_##*.}"
 		__gitcomp "cmd path" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	mergetool.*.*)
-		local pfx="${cur%.*}." cur_="${cur##*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_##*.}"
 		__gitcomp "cmd path trustExitCode" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	pager.*)
-		local pfx="${cur%.*}." cur_="${cur#*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_#*.}"
 		__git_compute_all_commands
 		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	remote.*.*)
-		local pfx="${cur%.*}." cur_="${cur##*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_##*.}"
 		__gitcomp "
 			url proxy fetch push mirror skipDefaultUpdate
 			receivepack uploadpack tagOpt pushurl
@@ -2417,19 +2433,21 @@ __git_complete_config_variable_name ()
 		return
 		;;
 	remote.*)
-		local pfx="${cur%.*}." cur_="${cur#*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
 		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
-		local pfx="${cur%.*}." cur_="${cur##*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_##*.}"
 		__gitcomp "insteadOf pushInsteadOf" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	*.*)
 		__git_compute_config_vars
-		__gitcomp "$__git_config_vars" "" "$cur" "$sfx"
+		__gitcomp "$__git_config_vars" "" "$cur_" "$sfx"
 		;;
 	*)
 		__git_compute_config_vars
@@ -2441,22 +2459,36 @@ __git_complete_config_variable_name ()
 					for (s in sections)
 						print s "."
 				}
-				')"
+				')" "" "$cur_"
 		;;
 	esac
 }
 
 # Completes '='-separated configuration sections/variable names and values
 # for 'git -c section.name=value'.
+#
+# Usage: __git_complete_config_variable_name_and_value [<option>]...
+# --cur=<word>: The current configuration section/variable name/value to be
+#               completed. Defaults to the current word to be completed.
 __git_complete_config_variable_name_and_value ()
 {
-	case "$cur" in
+	local cur_="$cur"
+
+	while test $# != 0; do
+		case "$1" in
+		--cur=*)	cur_="${1##--cur=}" ;;
+		*)		return 1 ;;
+		esac
+		shift
+	done
+
+	case "$cur_" in
 	*=*)
 		__git_complete_config_variable_value \
-			--varname="${cur%%=*}" --cur="${cur#*=}"
+			--varname="${cur_%%=*}" --cur="${cur_#*=}"
 		;;
 	*)
-		__git_complete_config_variable_name --sfx='='
+		__git_complete_config_variable_name --cur="$cur_" --sfx='='
 		;;
 	esac
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 9e90a64830..5d98d66dbd 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1740,6 +1740,27 @@ test_expect_success 'git -c - value' '
 	EOF
 '
 
+test_expect_success 'git clone --config= - section' '
+	test_completion "git clone --config=br" <<-\EOF
+	branch.Z
+	browser.Z
+	EOF
+'
+
+test_expect_success 'git clone --config= - variable name' '
+	test_completion "git clone --config=log.d" <<-\EOF
+	log.date=Z
+	log.decorate=Z
+	EOF
+'
+
+test_expect_success 'git clone --config= - value' '
+	test_completion "git clone --config=color.pager=" <<-\EOF
+	false Z
+	true Z
+	EOF
+'
+
 test_expect_success 'sourcing the completion script clears cached commands' '
 	__git_compute_all_commands &&
 	verbose test -n "$__git_all_commands" &&
-- 
2.23.0.rc2.350.gf4fdc32db7

