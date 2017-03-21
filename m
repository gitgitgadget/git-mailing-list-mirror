Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539AF2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 22:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932411AbdCUWMU (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 18:12:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34351 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757940AbdCUWMS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 18:12:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id u132so5589397wmg.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8v9fGLX69TNY3qhpNa4thJyRK1Y4FoYwPwNBN+YT0J8=;
        b=co1Zh5Ko2hOGKx4AdB/fsXiL2y4RSHs4hBPDt//7Qm/7+XBI3XcE6ghrqes46vV3AQ
         Ehj8tmf5YZ3+Dwmo9/RpblLpfwzLWzSs8wqSooei+Aueu0jCta5y9WlyuAMXfX6/iNgp
         Lww1hrqGQHNX/ZHciMdVn/XpUItBRObUGo25o8AJ2zgi1ygYaCV2n0LYiwK0em+u3hAd
         FnEr//23vjzDS7lTYSmus9eFPu5xtH4cMrxdAczgmTaVjldZM6rGRsuu7EvXHNbWQvOg
         8zm10L/myYiEjjGE9DUkdqxRorwW3QuIimqpdpDtu0+wiUkw+YghmMUu2uqMz4Hc1pny
         QFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8v9fGLX69TNY3qhpNa4thJyRK1Y4FoYwPwNBN+YT0J8=;
        b=WjyHn52AwfCWEDFl4iRWvehbFDtDLtUcWJy9YMzelKrcZ5x7OAoI+7tRwzPmw2EPqF
         /3roAlVju/bIaPt/iMonARsIhFjShx+vA+DRB/vc5GN2qSegpGWbD2MtwaoxkLTWeF7/
         0+l67WvnHr5Yzd/9Lr1zH1henAjdklvNcbv1k2TitkkEs6+fxYRFmqqFALQVzBhjac3J
         9SBFDFwb5BhrvJpRxFww3n+pWv6b1vPotGsQEDXawcR768ZhsWj3wnzrUtgPjyaAxq2d
         V68K3w67DGQXVtH4Avch243P9wLhg+E1mXVtOptvnTURVB7uzfynFWUl2ZcAG3Yfiz/L
         dC+g==
X-Gm-Message-State: AFeK/H1090n1Y+YFL7W8MRPKImOrikubjK4zyJu+ThaOAQ9pegGFdnE+JKA+ZOJf3HOzfw==
X-Received: by 10.28.215.18 with SMTP id o18mr4948784wmg.98.1490134327381;
        Tue, 21 Mar 2017 15:12:07 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id x133sm19245070wme.22.2017.03.21.15.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Mar 2017 15:12:06 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/3] stash: don't show internal implementation details
Date:   Tue, 21 Mar 2017 22:12:17 +0000
Message-Id: <20170321221219.28041-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.401.g98d3b1bb99.dirty
In-Reply-To: <20170321221219.28041-1-t.gummerer@gmail.com>
References: <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170321221219.28041-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git stash push uses other git commands internally.  Currently it only
passes the -q flag to those if the -q flag is passed to git stash.  when
using 'git stash push -p -q --no-keep-index', it doesn't even pass the
flag on to the internal reset at all.

It really is enough for the user to know that the stash is created,
without bothering them with the internal details of what's happening.
Always pass the -q flag to the internal git clean and git reset
commands, to avoid unnecessary and potentially confusing output.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 git-stash.sh     | 8 ++++----
 t/t3903-stash.sh | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 9c70662cc8..ba86d84321 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -299,12 +299,12 @@ push_stash () {
 	then
 		if test $# != 0
 		then
-			git reset ${GIT_QUIET:+-q} -- "$@"
+			git reset -q -- "$@"
 			git ls-files -z --modified -- "$@" |
 			git checkout-index -z --force --stdin
-			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
+			git clean --force -q -d -- "$@"
 		else
-			git reset --hard ${GIT_QUIET:+-q}
+			git reset --hard -q
 		fi
 		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
 		if test -n "$untracked"
@@ -322,7 +322,7 @@ push_stash () {
 
 		if test "$keep_index" != "t"
 		then
-			git reset
+			git reset -q
 		fi
 	fi
 }
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 89877e4b52..ea8e5c7818 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -663,7 +663,7 @@ test_expect_success 'stash apply shows status same as git status (relative to cu
 		sane_unset GIT_MERGE_VERBOSITY &&
 		git stash apply
 	) |
-	sed -e 1,2d >actual && # drop "Saved..." and "HEAD is now..."
+	sed -e 1,1d >actual && # drop "Saved..."
 	test_i18ncmp expect actual
 '
 
-- 
2.12.0.401.g98d3b1bb99.dirty

