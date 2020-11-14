Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9091CC63697
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 12:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F17A20644
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 12:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtkLgU6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgKNMVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 07:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgKNMVs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 07:21:48 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A00C0613D1
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 04:21:48 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p19so9076187wmg.0
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 04:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uhbJTZyFa5i2gg3xU6yMagc3zUUUPyEuXyaeXZBHC5w=;
        b=KtkLgU6i3NQqnDrXSEwfdWpgU+TUwS6Yi5ZFhosAgdNWa0jnut6/mW6ZX9dGm1eN2H
         hY0MZlp0gNVgcnN850edHx5hOuepPMmHctSLxb0AQI+9Dz//dzzzhzHpxyd0u0DALVYD
         q/Heuq8k3pq/mQWDPt4weRAS/Cd+cwzN0YdFS+RQU+MlBkyxV9TjgJZn4rV1vQYDo1n4
         lrpndR4S4Q7wXkyj9ZQk80wCzTPZXSIXGzHKqC0WQUQ39ep0yhC49uyeATHI+Bzklf4J
         Ee+Izwj9JqhmypuesUxcoLGd2TmcmD9DliEtLBmP2dGwWaFerxQBNnfu3dne5fRau5/N
         eGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uhbJTZyFa5i2gg3xU6yMagc3zUUUPyEuXyaeXZBHC5w=;
        b=U+1Bo8d3N+JeDy7/SGyTy/WnOcK+TjJkiB0+3Sz4XRC+PAsTB2QVScWZXNwBSyQGu1
         fDcP8IcT3vAE4qh8blR308LQo9voOsSYfNF9pAiSddPqkD5ahFkkGcCIFi4sjGGhJmAC
         E01j1nQei4YSwMpZVKm6VizvLTLxf1QlXVxu/GKJ4capIHxOwmM7ZFfENxeca6WRaAAx
         yw1qRn8P6aTSfS8c2jikIwvbUPLu8RdmgC9yaNtSiv47f6FnsEq0tmYpCIqLDlSfXgTA
         WFkR21VRqjIx0v8zYuCvHY/1SGiGuI2PLkZgoSgOUXlu2zPN272v+rhB04qw4BFjltTe
         1W0w==
X-Gm-Message-State: AOAM532o5rjtK16iO+RXwWBaAOAbQ5Meq6CbtJtC/ZZYNSD9PIG5RDPo
        /KWlm1VZHlAdGdE/5DW9M9D1ctueM8/eTA==
X-Google-Smtp-Source: ABdhPJxeeF9OLQnje4L9phbbBkMkyFVhWYIWEjQU1a2y2B6eGiDAg6LUohw0MPAI8SnCRnFt/+LjWg==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr6959589wmj.155.1605356507029;
        Sat, 14 Nov 2020 04:21:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f19sm12845225wml.21.2020.11.14.04.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 04:21:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/3] parse-remote: remove this now-unused library
Date:   Sat, 14 Nov 2020 13:21:32 +0100
Message-Id: <20201114122132.4344-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201112203155.3342586-1-gitster@pobox.com>
References: <20201112203155.3342586-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous two commits removed the last use of a function in this
library, but most of it had been dead code for a while[1][2]. Only the
"get_default_remote" function was still being used.

Even though we had a manual page for this library it was never
intended (or I expect, actually) used outside of git.git. Let's just
remove it, if anyone still cares about a function here they can pull
them into their own project[3].

1. Last use of error_on_missing_default_upstream():
   d03ebd411c ("rebase: remove the rebase.useBuiltin setting",
   2019-03-18)

2. Last use of get_remote_merge_branch(): 49eb8d39c7 ("Remove
   contrib/examples/*", 2018-03-25)

3. https://lore.kernel.org/git/87a6vmhdka.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore                         |   1 -
 Documentation/git-parse-remote.txt |  23 -------
 Makefile                           |   2 -
 command-list.txt                   |   1 -
 git-parse-remote.sh                | 101 -----------------------------
 git-submodule.sh                   |   1 -
 6 files changed, 129 deletions(-)
 delete mode 100644 Documentation/git-parse-remote.txt
 delete mode 100644 git-parse-remote.sh

diff --git a/.gitignore b/.gitignore
index 6232d33924..9da275e4e8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -114,7 +114,6 @@
 /git-pack-redundant
 /git-pack-objects
 /git-pack-refs
-/git-parse-remote
 /git-patch-id
 /git-prune
 /git-prune-packed
diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
deleted file mode 100644
index a45ea1ece8..0000000000
--- a/Documentation/git-parse-remote.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-git-parse-remote(1)
-===================
-
-NAME
-----
-git-parse-remote - Routines to help parsing remote repository access parameters
-
-
-SYNOPSIS
---------
-[verse]
-'. "$(git --exec-path)/git-parse-remote"'
-
-DESCRIPTION
------------
-This script is included in various scripts to supply
-routines to parse files under $GIT_DIR/remotes/ and
-$GIT_DIR/branches/ and configuration variables that are related
-to fetching, pulling and pushing.
-
-GIT
----
-Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 790a883932..c874dff9b8 100644
--- a/Makefile
+++ b/Makefile
@@ -613,7 +613,6 @@ SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
-SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--preserve-merges
 SCRIPT_LIB += git-sh-i18n
 SCRIPT_LIB += git-sh-setup
@@ -2577,7 +2576,6 @@ XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
-LOCALIZED_SH += git-parse-remote.sh
 LOCALIZED_SH += git-rebase--preserve-merges.sh
 LOCALIZED_SH += git-sh-setup.sh
 LOCALIZED_PERL = $(SCRIPT_PERL)
diff --git a/command-list.txt b/command-list.txt
index 0e3204e7d1..c19c8a94fe 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -135,7 +135,6 @@ git-p4                                  foreignscminterface
 git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
 git-pack-refs                           ancillarymanipulators
-git-parse-remote                        synchelpers
 git-patch-id                            purehelpers
 git-prune                               ancillarymanipulators   complete
 git-prune-packed                        plumbingmanipulators
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
deleted file mode 100644
index d3c39980f3..0000000000
--- a/git-parse-remote.sh
+++ /dev/null
@@ -1,101 +0,0 @@
-# This is a shell library to calculate the remote repository and
-# upstream branch that should be pulled by "git pull" from the current
-# branch.
-
-# git-ls-remote could be called from outside a git managed repository;
-# this would fail in that case and would issue an error message.
-GIT_DIR=$(git rev-parse -q --git-dir) || :;
-
-get_default_remote () {
-	curr_branch=$(git symbolic-ref -q HEAD)
-	curr_branch="${curr_branch#refs/heads/}"
-	origin=$(git config --get "branch.$curr_branch.remote")
-	echo ${origin:-origin}
-}
-
-get_remote_merge_branch () {
-	case "$#" in
-	0|1)
-	    origin="$1"
-	    default=$(get_default_remote)
-	    test -z "$origin" && origin=$default
-	    curr_branch=$(git symbolic-ref -q HEAD) &&
-	    [ "$origin" = "$default" ] &&
-	    echo $(git for-each-ref --format='%(upstream)' $curr_branch)
-	    ;;
-	*)
-	    repo=$1
-	    shift
-	    ref=$1
-	    # FIXME: It should return the tracking branch
-	    #        Currently only works with the default mapping
-	    case "$ref" in
-	    +*)
-		ref=$(expr "z$ref" : 'z+\(.*\)')
-		;;
-	    esac
-	    expr "z$ref" : 'z.*:' >/dev/null || ref="${ref}:"
-	    remote=$(expr "z$ref" : 'z\([^:]*\):')
-	    case "$remote" in
-	    '' | HEAD ) remote=HEAD ;;
-	    heads/*) remote=${remote#heads/} ;;
-	    refs/heads/*) remote=${remote#refs/heads/} ;;
-	    refs/* | tags/* | remotes/* ) remote=
-	    esac
-	    [ -n "$remote" ] && case "$repo" in
-		.)
-		    echo "refs/heads/$remote"
-		    ;;
-		*)
-		    echo "refs/remotes/$repo/$remote"
-		    ;;
-	    esac
-	esac
-}
-
-error_on_missing_default_upstream () {
-	cmd="$1"
-	op_type="$2"
-	op_prep="$3" # FIXME: op_prep is no longer used
-	example="$4"
-	branch_name=$(git symbolic-ref -q HEAD)
-	display_branch_name="${branch_name#refs/heads/}"
-	# If there's only one remote, use that in the suggestion
-	remote="$(gettext "<remote>")"
-	branch="$(gettext "<branch>")"
-	if test $(git remote | wc -l) = 1
-	then
-		remote=$(git remote)
-	fi
-
-	if test -z "$branch_name"
-	then
-		gettextln "You are not currently on a branch."
-	else
-		gettextln "There is no tracking information for the current branch."
-	fi
-	case "$op_type" in
-	rebase)
-		gettextln "Please specify which branch you want to rebase against."
-		;;
-	merge)
-		gettextln "Please specify which branch you want to merge with."
-		;;
-	*)
-		echo >&2 "BUG: unknown operation type: $op_type"
-		exit 1
-		;;
-	esac
-	eval_gettextln "See git-\${cmd}(1) for details."
-	echo
-	echo "    $example"
-	echo
-	if test -n "$branch_name"
-	then
-		gettextln "If you wish to set tracking information for this branch you can do so with:"
-		echo
-		echo "    git branch --set-upstream-to=$remote/$branch $display_branch_name"
-		echo
-	fi
-	exit 1
-}
diff --git a/git-submodule.sh b/git-submodule.sh
index d39a28215c..86ad60c05c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -20,7 +20,6 @@ USAGE="[--quiet] [--cached]
 OPTIONS_SPEC=
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
-. git-parse-remote
 require_work_tree
 wt_prefix=$(git rev-parse --show-prefix)
 cd_to_toplevel
-- 
2.29.2.222.g5d2a92d10f8

