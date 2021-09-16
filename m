Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F799C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 11:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2028B613A8
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 11:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbhIPLhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 07:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbhIPLhl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 07:37:41 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA45EC0613C1
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 04:36:20 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 17so5884656pgp.4
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80qoBYplBwkAIz37B61a+xtLnciKKclTzvBS/XlxAnI=;
        b=ladKC/8E160JJc8lbH+T2JD0HZ2RL2V+2uEHNsF7mGJa3C01FHeNQHWJ34RAzcFJk6
         TWRkUPTzzybcVWNCkszC46enBZ0WMmbYzgNRGNb8l55zRSjbJS3x+1hLgfu+PudK0Z72
         SBhnMyFYdd0XzVgbPYDtC9rKHtifrMfZ2b0XDVHT2oE4wchAcr9SHWvL7c8foDqeBN8S
         poNboPdTOdR3TbST1dSvRnQe1JJd2m75NP2v8sNkAiCchNVEdQZAsMUeMkSz9rhe/NIc
         vNqauh0buLBa29u797VhzJ6jqO+vP7biXipM+n5S6bD09xv4RSj67yC7fOfiualmou7X
         gGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80qoBYplBwkAIz37B61a+xtLnciKKclTzvBS/XlxAnI=;
        b=ZHT+bS48gHXz5nBryb8J2BVOdCmmSxsykpMFvCzuaXDpGeBkPT+oVJthqYG1cu5UVH
         0oT6gK1Szffwow0apcgqmKKLvAmzNyfx0kyZfWilVJdjJogsJnbNT2+MCd5UhdeLGqU5
         iITrNzfqeWUsL9JgDzUK9s8QJ9ZCPpJw5MEkTmBaFzi/7deNFx5H8fUqivp/ENkvjXns
         wEFtqrIdkflVnE5Tw4GLxr29opTysEiOP7j27SHqWteEurT3cEC5hw6YwGbPYQS2xyBs
         3jODtkur6mo0CgpUo148ih9GhLNZLu1NT7linGZju/6aCwxpI/6WdtpiwQdeVoufcu/K
         lqbw==
X-Gm-Message-State: AOAM532L80+DUt2xyyqL/HEC+K+wN5M6MVK3kTP3G37tNj6H0POcNcXX
        2UDXjAHjkDqSpCKa9JBDiV0URWPVijjRpQ==
X-Google-Smtp-Source: ABdhPJymHuEdiw3FD0FMk6zlmc9WdZjHzm8EpbGyPU+ajf6GT7kN9dTwI0LDYHcu7X5JDtmpinlg4w==
X-Received: by 2002:a63:e057:: with SMTP id n23mr4607982pgj.183.1631792180108;
        Thu, 16 Sep 2021 04:36:20 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id d5sm2501188pjs.53.2021.09.16.04.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 04:36:19 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ryan Anderson <ryan@michonline.com>, vmiklos@frugalware.org,
        bedhanger@gmx.de
Subject: [PATCH 2/2] request-pull: mark translatable strings
Date:   Thu, 16 Sep 2021 18:35:17 +0700
Message-Id: <20210916113516.76445-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916113516.76445-1-bagasdotme@gmail.com>
References: <20210916113516.76445-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark user-faced strings as translatable (including PR message output).

Cc: Ryan Anderson <ryan@michonline.com>
Cc: vmiklos@frugalware.org 
Cc: bedhanger@gmx.de
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 git-request-pull.sh | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 9e1d2be9eb..8aa3a3f342 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -40,7 +40,7 @@ test -n "$base" && test -n "$url" || usage
 baserev=$(git rev-parse --verify --quiet "$base"^0)
 if test -z "$baserev"
 then
-    die "fatal: Not a valid revision: $base"
+    die "$(eval_gettext "fatal: Not a valid revision: \$base")"
 fi
 
 #
@@ -58,12 +58,12 @@ head=${head:-$(git show-ref --heads --tags "$local" | cut -d' ' -f2)}
 head=${head:-$(git rev-parse --quiet --verify "$local")}
 
 # None of the above? Bad.
-test -z "$head" && die "fatal: Not a valid revision: $local"
+test -z "$head" && die "$(eval_gettext "fatal: Not a valid revision: \$local")"
 
 # This also verifies that the resulting head is unique:
 # "git show-ref" could have shown multiple matching refs..
 headrev=$(git rev-parse --verify --quiet "$head"^0)
-test -z "$headrev" && die "fatal: Ambiguous revision: $local"
+test -z "$headrev" && die "$(eval_gettext "fatal: Ambiguous revision: \$local")"
 
 local_sha1=$(git rev-parse --verify --quiet "$head")
 
@@ -76,7 +76,7 @@ then
 fi
 
 merge_base=$(git merge-base $baserev $headrev) ||
-die "fatal: No commits in common between $base and $head"
+die "$(eval_gettext "fatal: No commits in common between \$base and \$head")"
 
 # $head is the refname from the command line.
 # Find a ref with the same name as $head that exists at the remote
@@ -120,13 +120,13 @@ remote_or_head=${remote:-HEAD}
 
 if test -z "$ref"
 then
-	echo "warn: No match for commit $headrev found at $url" >&2
-	echo "warn: Are you sure you pushed '$remote_or_head' there?" >&2
+	echo "$(eval_gettext "warn: No match for commit \$headrev found at \$url")" >&2
+	echo "$(eval_gettext "warn: Are you sure you pushed '\$remote_or_head' there?")" >&2
 	status=1
 elif test "$local_sha1" != "$remote_sha1"
 then
-	echo "warn: $head found at $url but points to a different object" >&2
-	echo "warn: Are you sure you pushed '$remote_or_head' there?" >&2
+	echo "$(eval_gettext "warn: \$head found at \$url but points to a different object")" >&2
+	echo "$(eval_gettext "warn: Are you sure you pushed '\$remote_or_head' there?")" >&2
 	status=1
 fi
 
@@ -138,19 +138,22 @@ fi
 
 url=$(git ls-remote --get-url "$url")
 
-git show -s --format='The following changes since commit %H:
+git show -s --format="
+$(gettext 'The following changes since commit %H:
 
   %s (%ci)
 
 are available in the Git repository at:
-' $merge_base &&
+')
+" $merge_base &&
 echo "  $url $pretty_remote" &&
-git show -s --format='
+git show -s --format="
+$(gettext '
 for you to fetch changes up to %H:
 
   %s (%ci)
 
-----------------------------------------------------------------' $headrev &&
+----------------------------------------------------------------')" $headrev &&
 
 if test $(git cat-file -t "$head") = tag
 then
@@ -162,7 +165,7 @@ fi &&
 
 if test -n "$branch_name"
 then
-	echo "(from the branch description for $branch_name local branch)"
+	echo "$(eval_gettext "(from the branch description for \$branch_name local branch)")"
 	echo
 	git config "branch.$branch_name.description"
 	echo "----------------------------------------------------------------"
-- 
2.25.1

