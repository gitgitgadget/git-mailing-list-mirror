Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F830C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 09:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiKOJcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 04:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKOJcs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 04:32:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30325101E0
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 01:32:47 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f7so21027577edc.6
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 01:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKzOtjxlNncShVb1+Tb7AE7on7XT4flMFZ5ruiE8iWM=;
        b=YyrgwnJDpUujDnh4OwXGGNaljxRSxQK1KRSd9+g6n1GoSAehRFG3TzYfo8L2Maebab
         6NVPuEaYc/28UXqmKEgYRtrllNmFAWNMxoejCoxC1YzcMp20xFShUT48/y2AOvLgfc3h
         SUbQTo3orHoS5f+ppNPA3lx92KPe3HQdpSqtxnZuXkFN91iXuAmMoyHHLjkX5EQ/9QzQ
         rLEYW7LcIU6zFpHEpq234ZTij/vUQg2E8oE/TBkxOQFEhA8Lij1TjuojL1w8Z97RdXOj
         hdzYLVPTN8Xom07wRXo+Exgj4BYW4Siz+bUEzLQdCjrTYvXFbWuSxvWxqv4qVQ5B9eTc
         qC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKzOtjxlNncShVb1+Tb7AE7on7XT4flMFZ5ruiE8iWM=;
        b=NoXyHcHTDHba09LLR5KvywWqhe+brWJeJY/yQSMR0Twehsk7i3i9OgrPhCMyhFydlo
         uTNBoarFU/FGX5WmrePdmUqOfMAnKwA3XGbZaY1TwGb5hGXvwC+jTJSyOJ/skeM6ggIe
         nZHFuQ+LseiQpfH/+PurwYmJgoJLpcuECnWaMsxH7Vssh6zjkxqf0HWRRAeHPsxcA/My
         Nts8OptDVcinbA0ZFdQYvD+JbrUIlTAEw52DTqNmimKf7hAp1Bh6h9Cch67zJrukBiLv
         LpLxCtCjuOH56z2SSISbzUuf7GedAu9UUlY15DP/8BHcJ/5KTWeXDBVjlR+Tk9xlBoLX
         pCHg==
X-Gm-Message-State: ANoB5pkDwfET5gt2Qii47K0+w/0X8FJA2JTOVXV7cEdTTh5KTe1Ac/cm
        3TzaMru0Z96GxqjM1cWJksZAHOI9fc+OoQ==
X-Google-Smtp-Source: AA0mqf616RzKV/NZapfFnab3k1zZICezjgBmC2FeAGDztqJ2IjnP9SNbopCwMM3fHoLaF7LnFyauWg==
X-Received: by 2002:a05:6402:1cb9:b0:461:f5ce:a478 with SMTP id cz25-20020a0564021cb900b00461f5cea478mr14384757edb.304.1668504765248;
        Tue, 15 Nov 2022 01:32:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906301600b0073c8d4c9f38sm5358172ejz.177.2022.11.15.01.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 01:32:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] bisect; remove unused "git-bisect.sh" and ".gitignore" entry
Date:   Tue, 15 Nov 2022 10:32:42 +0100
Message-Id: <patch-1.1-7be23b6faa0-20221115T093130Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1473.g172bcc0511c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since fc304fb52f9 (Merge branch 'dd/git-bisect-builtin' into next,
2022-11-14) we've used builtin/bisect.c instead of git-bisect.sh to
implement the "bisect" command. Let's remove the unused leftover
script, and the ".gitignore" entry for the "git-bisect--helper", which
also hasn't been built since fc304fb52f9.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
This goes on top of "dd/git-bisect-builtin", which just landed in
"next".

 .gitignore    |  1 -
 git-bisect.sh | 63 ---------------------------------------------------
 2 files changed, 64 deletions(-)
 delete mode 100755 git-bisect.sh

diff --git a/.gitignore b/.gitignore
index cb0231fb401..fe234cfa19a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,7 +20,6 @@
 /git-archimport
 /git-archive
 /git-bisect
-/git-bisect--helper
 /git-blame
 /git-branch
 /git-bugreport
diff --git a/git-bisect.sh b/git-bisect.sh
deleted file mode 100755
index f95b8103a9e..00000000000
--- a/git-bisect.sh
+++ /dev/null
@@ -1,63 +0,0 @@
-#!/bin/sh
-
-USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|view|replay|log|run]'
-LONG_USAGE='git bisect help
-	print this long help message.
-git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]
-		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
-	reset bisect state and start bisection.
-git bisect (bad|new) [<rev>]
-	mark <rev> a known-bad revision/
-		a revision after change in a given property.
-git bisect (good|old) [<rev>...]
-	mark <rev>... known-good revisions/
-		revisions before change in a given property.
-git bisect terms [--term-good | --term-bad]
-	show the terms used for old and new commits (default: bad, good)
-git bisect skip [(<rev>|<range>)...]
-	mark <rev>... untestable revisions.
-git bisect next
-	find next bisection to test and check it out.
-git bisect reset [<commit>]
-	finish bisection search and go back to commit.
-git bisect (visualize|view)
-	show bisect status in gitk.
-git bisect replay <logfile>
-	replay bisection log.
-git bisect log
-	show bisect log.
-git bisect run <cmd>...
-	use <cmd>... to automatically bisect.
-
-Please use "git help bisect" to get the full man page.'
-
-OPTIONS_SPEC=
-. git-sh-setup
-
-TERM_BAD=bad
-TERM_GOOD=good
-
-get_terms () {
-	if test -s "$GIT_DIR/BISECT_TERMS"
-	then
-		{
-		read TERM_BAD
-		read TERM_GOOD
-		} <"$GIT_DIR/BISECT_TERMS"
-	fi
-}
-
-case "$#" in
-0)
-	usage ;;
-*)
-	cmd="$1"
-	get_terms
-	shift
-	case "$cmd" in
-	help)
-		git bisect -h ;;
-	*)
-		git bisect--helper "$cmd" "$@" ;;
-	esac
-esac
-- 
2.38.0.1473.g172bcc0511c

