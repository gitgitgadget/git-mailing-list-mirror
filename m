Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F25C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346058AbiFJCDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345887AbiFJCCS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:02:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F879BCE88
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:02:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a10so10689315wmj.5
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i5yWOgGV6nkLRgqYQPcJed9enMkjAOg/wHLTF2newGs=;
        b=Sbr9R7ck9Pbkhp+1s+9+GU4awgiYUYy41LwSrH7Y4h6NxAjc0RD7zbiQsFGSbkxC/N
         aGky75KADwfgBA20tJfLp3/kfil6mMVxN/S4mS+/fwWxes6ec5JnMrib4f6LdJar1pFo
         s9isldZo+QqjSsCIbEmJYZkW4GiOPQ5q9dtBRFkmHBndLTygUIxsTiA24IkxU3aTHCHa
         lCcTvDn4dTGqv9cHdWCEOGWuf8o3C0wAqD5oq51p7GzubipE7kP9KDYEml1rkkjvIRG0
         hcU/1CkYHfRB1KggelcrQtqczjpd4/SRWftSGX8c9sdr3lj10XkIa3yCGROj45KL8DYl
         yS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i5yWOgGV6nkLRgqYQPcJed9enMkjAOg/wHLTF2newGs=;
        b=yrrs3qRKFFxgHr3sxMZ6izmSYaGakbFcyDhkEzLdHFi8H3C158SrSHEu8vRh6I/YBG
         r6ZTx26BF6+BBqxSO0rYTcVyWCwSqE1Jajmm5T7WMuqt0rseMiun2IWuCNfOkpvRV50l
         gM9c0jMnqCRFclkpNrDZYbU6AL+I9VztBucCK7Twu2wREaL34m3m3+3wWaSfibw0epDP
         QULG4Y8xWWgcRGwK4u7JTeymwdpJ4K83SOo9BnumTRrf6t9ilexZxPyBWlR7hLmYOr94
         l8VoxWh7SB50ef9qrsI9KBnacene8I7jLffijlUl1lTQeLC8PYN/+IO6W5iHnlC32WZY
         oYsg==
X-Gm-Message-State: AOAM532UY55Wq8Y1wKh8uylJf4H0PHHZ635cJ6MZzSPfPgX8NnBq+b8I
        LqsEEmk/u2i5qkAjxy4q/gdQvUZry448hw==
X-Google-Smtp-Source: ABdhPJzfqXE62PZSBF0MYlfHsiMulH9BFcZWnjs6Iqem66S/k8AMsQOdWQYIbYtChfxrRTB9Im1v7Q==
X-Received: by 2002:a05:600c:19cb:b0:397:51db:446f with SMTP id u11-20020a05600c19cb00b0039751db446fmr6098221wmq.182.1654826521630;
        Thu, 09 Jun 2022 19:02:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:02:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 16/20] git-submodule.sh: dispatch "update" to helper
Date:   Fri, 10 Jun 2022 04:01:28 +0200
Message-Id: <RFC-patch-16.20-08abadda7c3-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dispatch the "update" command directly to "git submodule--helper
update", rather than doing our own argument parsing in
git-submodule.sh. As this is the last cmd_*() function to be removed
from git-submodule.sh we can do some larger cleanup of that file as a
result.

As noted in a preceding commit the only behavior change here should be
the desirable change of better "-h" output, and that this
implementation understands the "--verbose" synonym for "-v". Let's
update the documentation to reflect the new "--verbose" synonym.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-submodule.txt |   5 +-
 git-submodule.sh                | 159 +-------------------------------
 2 files changed, 5 insertions(+), 159 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 5f1c552110e..95685ac4f1c 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
-'git submodule' [--quiet] update [-v] [<options>] [--] [<path>...]
+'git submodule' [--quiet] update [-v | --verbose] [<options>] [--] [<path>...]
 'git submodule' [--quiet] set-branch [<options>] [--] <path>
 'git submodule' [--quiet] set-url [--] <path> <newurl>
 'git submodule' [--quiet] summary [<options>] [--] [<path>...]
@@ -133,7 +133,7 @@ If you really want to remove a submodule from the repository and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
 options.
 
-update [-v] [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter spec>] [--] [<path>...]::
+update [-v | --verbose] [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter spec>] [--] [<path>...]::
 +
 --
 Update the registered submodules to match what the superproject
@@ -271,6 +271,7 @@ OPTIONS
 	Only print error messages.
 
 -v::
+--verbose::
 	Don't be quiet. This option is only valid for the update command.
 
 --progress::
diff --git a/git-submodule.sh b/git-submodule.sh
index 1929c34ae8b..e245b7fbaca 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -30,163 +30,7 @@ GIT_PROTOCOL_FROM_USER=0
 export GIT_PROTOCOL_FROM_USER
 
 command=
-force=
-reference=
 cached=
-recursive=
-init=
-require_init=
-remote=
-nofetch=
-rebase=
-merge=
-checkout=
-depth=
-progress=
-dissociate=
-single_branch=
-jobs=
-recommend_shallow=
-filter=
-
-#
-# Update each submodule path to correct revision, using clone and checkout as needed
-#
-# $@ = requested paths (default to all)
-#
-cmd_update()
-{
-	# parse $args after "submodule ... update".
-	while test $# -ne 0
-	do
-		case "$1" in
-		-q|--quiet)
-			GIT_QUIET=1
-			;;
-		-v)
-			unset GIT_QUIET
-			;;
-		--progress)
-			progress=1
-			;;
-		-i|--init)
-			init=1
-			;;
-		--require-init)
-			require_init=1
-			;;
-		--remote)
-			remote=1
-			;;
-		-N|--no-fetch)
-			nofetch=1
-			;;
-		-f|--force)
-			force=$1
-			;;
-		-r|--rebase)
-			rebase=1
-			;;
-		--reference)
-			case "$2" in '') usage ;; esac
-			reference="--reference=$2"
-			shift
-			;;
-		--reference=*)
-			reference="$1"
-			;;
-		--dissociate)
-			dissociate=1
-			;;
-		-m|--merge)
-			merge=1
-			;;
-		--recursive)
-			recursive=1
-			;;
-		--checkout)
-			checkout=1
-			;;
-		--recommend-shallow)
-			recommend_shallow="--recommend-shallow"
-			;;
-		--no-recommend-shallow)
-			recommend_shallow="--no-recommend-shallow"
-			;;
-		--depth)
-			case "$2" in '') usage ;; esac
-			depth="--depth=$2"
-			shift
-			;;
-		--depth=*)
-			depth=$1
-			;;
-		-j|--jobs)
-			case "$2" in '') usage ;; esac
-			jobs="--jobs=$2"
-			shift
-			;;
-		--jobs=*)
-			jobs=$1
-			;;
-		--single-branch)
-			single_branch="--single-branch"
-			;;
-		--no-single-branch)
-			single_branch="--no-single-branch"
-			;;
-		--filter)
-			case "$2" in '') usage ;; esac
-			filter="--filter=$2"
-			shift
-			;;
-		--filter=*)
-			filter="$1"
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
-		${GIT_QUIET:+--quiet} \
-		${force:+--force} \
-		${progress:+"--progress"} \
-		${remote:+--remote} \
-		${recursive:+--recursive} \
-		${init:+--init} \
-		${nofetch:+--no-fetch} \
-		${wt_prefix:+--prefix "$wt_prefix"} \
-		${rebase:+--rebase} \
-		${merge:+--merge} \
-		${checkout:+--checkout} \
-		${reference:+"$reference"} \
-		${dissociate:+"--dissociate"} \
-		${depth:+"$depth"} \
-		${require_init:+--require-init} \
-		${dissociate:+"--dissociate"} \
-		$single_branch \
-		$recommend_shallow \
-		$jobs \
-		$filter \
-		-- \
-		"$@"
-}
-
-# This loop parses the command line arguments to find the
-# subcommand name to dispatch.  Parsing of the subcommand specific
-# options are primarily done by the subcommand implementations.
-# Subcommand specific options such as --branch and --cached are
-# parsed here as well, for backward compatibility.
 
 while test $# != 0 && test -z "$command"
 do
@@ -235,7 +79,8 @@ absorbgitdirs)
 	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
 	;;
 update)
-	cmd_update "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
+		${GIT_QUIET:+--quiet} ${wt_prefix:+--prefix "$wt_prefix"} "$@"
 	;;
 add | foreach | init | deinit | set-branch | set-url | status | summary | sync)
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
-- 
2.36.1.1178.gb5b1747c546

