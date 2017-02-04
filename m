Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329891FAF4
	for <e@80x24.org>; Sat,  4 Feb 2017 06:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753750AbdBDGnM (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 01:43:12 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32965 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753709AbdBDGnL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 01:43:11 -0500
Received: by mail-pg0-f67.google.com with SMTP id 194so3870854pgd.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 22:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QNHdPnBDkvc5GiapT3l5HPvldv9ZxLW+ZUAIktyGfkk=;
        b=AvlJf5bzVNgzBPO/XvHn5kVXb/nl0ACLAXSIm046kqsphNwzcwwBMQrgdCIK2WAkaz
         gqNLZWt1NvcpNUV88XEQp4v0ci/ic9jfcUw0dVEwrqBk2mVRqebgc9V4quvJj5Q9Pxzz
         218os6IS3IyyMda7m6vXNRx1EtWOSWE9L+Y8Ql+XtCtqioEx+hwWDslh20dByfIFLF1/
         nKWfzF3MUjA7QpPCUHtoQKKtyYBQqPHqt0g248bE07la3GWDzUhJ9K7fgyhVIrsVfaTE
         61HaAZ471Q4+W2iYcwNDHUBNcXZyJDHTpeiCDpyS9j3YbFjJqXYdo2FHDBr8KBvtphSb
         3f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QNHdPnBDkvc5GiapT3l5HPvldv9ZxLW+ZUAIktyGfkk=;
        b=D78LZrLSywvLQiY7oqV4cmbbDC657UKZ9VFcF8Bp1dau0tG6Kv2zQTeSYzjT6BQnZp
         cO9NnNOfhu+mUokagqc8BfPO97Dl0Og+SfaloTmwYFJPuxfY3NSGr5XIrAty/okmHJ6t
         dtMl0px/iRj1XPx+vsNagD8V5RI9ObT8yIPLe842w/dnLTOJdeFtFikF87+947CUgNi7
         HoMkh3rt1BGWx7Mnk4Hmf+9yIOrNKgkqjuWncOEs+Z/KqzTZudjYmrGYjVsNWuxMXjmh
         f6qUf6oOFYftoQI6R2aKB52/UIJbM8/iWx7gNRkWM61Aqv+Xao59TvhrXA3f2pf2ZmvL
         JXSQ==
X-Gm-Message-State: AIkVDXII/v54I4Ubm/OtdBAmFuhvaBvfN1kVSuxXssXw6aVL7s3v/gf1g8iHjjsoYCv8Sg==
X-Received: by 10.84.231.205 with SMTP id g13mr1422042pln.118.1486190590727;
        Fri, 03 Feb 2017 22:43:10 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id o18sm72521741pgn.36.2017.02.03.22.43.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2017 22:43:10 -0800 (PST)
Date:   Fri, 3 Feb 2017 22:43:03 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] Add --gui option to mergetool
Message-ID: <20170204064303.GA14990@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* fix the discrepancy between difftool and mergetool where
  the former has the --gui flag and the latter does not by adding the
  functionality to mergetool

* make difftool read 'merge.guitool' as a fallback, in accordance to the
  manpage for difftool: "git difftool falls back to git mergetool
  config variables when the difftool equivalents have not been defined"

* add guitool-related completions

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-difftool.txt         | 3 ++-
 Documentation/git-mergetool.txt        | 8 +++++++-
 contrib/completion/git-completion.bash | 6 ++++--
 git-mergetool.sh                       | 5 ++++-
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 224fb3090..0b5d29237 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -89,7 +89,8 @@ instead.  `--no-symlinks` is the default on Windows.
 --gui::
 	When 'git-difftool' is invoked with the `-g` or `--gui` option
 	the default diff tool will be read from the configured
-	`diff.guitool` variable instead of `diff.tool`.
+	`diff.guitool` variable instead of `diff.tool`. If `diff.guitool`
+	is not defined, it will try and read from `merge.guitool`.
 
 --[no-]trust-exit-code::
 	'git-difftool' invokes a diff tool individually on each file.
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 3622d6648..2ab56efcf 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -8,7 +8,7 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
 SYNOPSIS
 --------
 [verse]
-'git mergetool' [--tool=<tool>] [-y | --[no-]prompt] [<file>...]
+'git mergetool' [--tool=<tool>] [-g|--gui] [-y | --[no-]prompt] [<file>...]
 
 DESCRIPTION
 -----------
@@ -64,6 +64,12 @@ variable `mergetool.<tool>.trustExitCode` can be set to `true`.
 Otherwise, 'git mergetool' will prompt the user to indicate the
 success of the resolution after the custom tool has exited.
 
+-g::
+--gui::
+	When 'git-mergetool' is invoked with the `-g` or `--gui` option
+	the default diff tool will be read from the configured
+	`merge.guitool` variable instead of `merge.tool`.
+
 --tool-help::
 	Print a list of merge tools that may be used with `--tool`.
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 21016bf8d..8a7427f3c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1268,7 +1268,7 @@ _git_difftool ()
 			--base --ours --theirs
 			--no-renames --diff-filter= --find-copies-harder
 			--relative --ignore-submodules
-			--tool="
+			--tool= --gui"
 		return
 		;;
 	esac
@@ -1566,7 +1566,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool="
+		__gitcomp "--tool= --gui"
 		return
 		;;
 	esac
@@ -2189,6 +2189,7 @@ _git_config ()
 		diff.submodule
 		diff.suppressBlankEmpty
 		diff.tool
+		diff.guitool
 		diff.wordRegex
 		diff.algorithm
 		difftool.
@@ -2290,6 +2291,7 @@ _git_config ()
 		merge.renormalize
 		merge.stat
 		merge.tool
+		merge.guitool
 		merge.verbosity
 		mergetool.
 		mergetool.keepBackup
diff --git a/git-mergetool.sh b/git-mergetool.sh
index e52b4e4f2..a17668752 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -9,7 +9,7 @@
 # at the discretion of Junio C Hamano.
 #
 
-USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [-O<orderfile>] [file to merge] ...'
+USAGE='[--tool=tool] [-g|--gui] [--tool-help] [-y|--no-prompt|--prompt] [-O<orderfile>] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 NONGIT_OK=Yes
 OPTIONS_SPEC=
@@ -414,6 +414,9 @@ main () {
 				shift ;;
 			esac
 			;;
+		-g|--gui)
+			merge_tool=$(git config merge.guitool)
+			;;
 		-y|--no-prompt)
 			prompt=false
 			;;
-- 
2.11.0.21.ga274e0a.dirty

