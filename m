Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA43C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 17:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiBARAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 12:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiBARAe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 12:00:34 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFCEC061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 09:00:33 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v13so33193275wrv.10
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 09:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4CxSlU+kep9DX1zZYLemJZjbA+nBm6S4um3lY3Er1yw=;
        b=K+mTRfEligFBxXsv2+qTcEbXXSPAc750D+e57UfL05bhpz3iYBiqHQIOIXHIgoo7+z
         pGKh09eVrsFPBp3OC0b5sH3z/3K3a7tg7hH/M+q7Ruty/XiTNhaqHD184Uo2xm6TQTrZ
         3NRF8tLhHw8jwu4PeOyw9Q30wPxRk1E1CqzPXboss3Qa3kknDL8XD1IJa21u25x6W3rS
         /jsjSL7x5QXhdxKkcd0pAqnwugwr18xcbKHuknWvOmFpym4auW2Qi7yFC+E+6XLksmpN
         JXDmcn9TI7nmfQkROAIq8NBaXSYYRIic7gQekyJUc8G+0KYbdCMGaPFP3Q8QU0RGBkO8
         Hm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4CxSlU+kep9DX1zZYLemJZjbA+nBm6S4um3lY3Er1yw=;
        b=NlG2bemzj8SG61w7LaIgGB4wmKXbQlCkPTfXokK9L6UTx3KQJhfHHpkDQoTq9k4vj7
         jZQoP+VUEmEfja8KvLp9Imp57bvquVLLn1bvRhijlM/h06Kze6oQDKsuANvDx+YMZvlB
         N4kx5g+WFp7NcZzjb1RoPbYyybqaFUwZXhIVdxPf4eKN26/a7jUsR7YOKgLtxQnDrl+B
         Fxx8MO+PygK4yZMDk7fxaDCfPFHo+qc1zc+3yIqsJ9BrevUyfeytbfeMgZX8JKE7cVxt
         AhmzeiAY+KImGjadHk3TqbKO289K4iMDhI3GvzqDMdLk/5NQK0yEPjaOGzbvIshxyWDU
         dYNA==
X-Gm-Message-State: AOAM530+fNyVDbT8U/J3Ti9CTek3Ht9eOPia3dsqTQhBo7pkmxszI9T/
        5wPKt0h0M5msRpx75ljFv9i6Aabnq/U=
X-Google-Smtp-Source: ABdhPJzVi1T/eR+sFIKtPiFexDDUqaXNMK7woiJjkls6xwTrfGRa14+C3ZPKBvFoc8/bxHlMOWkDyQ==
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr22076364wru.39.1643734832225;
        Tue, 01 Feb 2022 09:00:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm2616755wmq.43.2022.02.01.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:00:31 -0800 (PST)
Message-Id: <7b28c527a907c81c3d3d8a6a54d5c713cef4f2a0.1643734828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
References: <pull.1131.v2.git.1643478692337.gitgitgadget@gmail.com>
        <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 17:00:28 +0000
Subject: [PATCH v3 3/3] repo-settings: name the default
 fetch.negotiationAlgorithm 'consecutive'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Give the default fetch.negotiationAlgorithm the name 'consecutive' and
update the documentation accordingly.  Since there may be some users
using the name 'default' for this behavior, retain that name for now.
We do not want to use that name indefinitely, though, because if
'skipping' becomes the default, then the "default" behavior will not be
the default behavior, which would be confusing.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/fetch.txt | 21 ++++++++++-----------
 fetch-negotiator.c             |  2 +-
 repo-settings.c                |  7 ++++---
 repository.h                   |  2 +-
 t/t5500-fetch-pack.sh          |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index 63748c02b72..926bcfd8b48 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -56,17 +56,16 @@ fetch.output::
 	OUTPUT in linkgit:git-fetch[1] for detail.
 
 fetch.negotiationAlgorithm::
-	Control how information about the commits in the local repository is
-	sent when negotiating the contents of the packfile to be sent by the
-	server. Set to "skipping" to use an algorithm that skips commits in an
-	effort to converge faster, but may result in a larger-than-necessary
-	packfile; or set to "noop" to not send any information at all, which
-	will almost certainly result in a larger-than-necessary packfile, but
-	will skip the negotiation step.
-	The default is "default" which instructs Git to use the default algorithm
-	that never skips commits (unless the server has acknowledged it or one
-	of its descendants). If `feature.experimental` is enabled, then this
-	setting defaults to "skipping".
+	Control how information about the commits in the local repository
+	is sent when negotiating the contents of the packfile to be sent by
+	the server.  Set to "consecutive" to use an algorithm that walks
+	over consecutive commits checking each one.  Set to "skipping" to
+	use an algorithm that skips commits in an effort to converge
+	faster, but may result in a larger-than-necessary packfile; or set
+	to "noop" to not send any information at all, which will almost
+	certainly result in a larger-than-necessary packfile, but will skip
+	the negotiation step.  The default is normally "consecutive", but
+	if `feature.experimental` is true, then the default is "skipping".
 	Unknown values will cause 'git fetch' to error out.
 +
 See also the `--negotiate-only` and `--negotiation-tip` options to
diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index 273390229fe..874797d767b 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -18,7 +18,7 @@ void fetch_negotiator_init(struct repository *r,
 		noop_negotiator_init(negotiator);
 		return;
 
-	case FETCH_NEGOTIATION_DEFAULT:
+	case FETCH_NEGOTIATION_CONSECUTIVE:
 		default_negotiator_init(negotiator);
 		return;
 	}
diff --git a/repo-settings.c b/repo-settings.c
index 41e1c30845f..e984075df12 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -26,7 +26,7 @@ void prepare_repo_settings(struct repository *r)
 	/* Defaults */
 	r->settings.index_version = -1;
 	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
-	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
+	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
 
 	/* Booleans config or default, cascades to other settings */
 	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
@@ -85,8 +85,9 @@ void prepare_repo_settings(struct repository *r)
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
 		else if (!strcasecmp(strval, "noop"))
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
-		else if (!strcasecmp(strval, "default"))
-			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
+		else if (!strcasecmp(strval, "consecutive") ||
+			 !strcasecmp(strval, "default"))
+			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
 		else
 			die("unknown fetch negotiation algorithm '%s'", strval);
 	}
diff --git a/repository.h b/repository.h
index 2b5cf97f31e..ca837cb9e91 100644
--- a/repository.h
+++ b/repository.h
@@ -20,7 +20,7 @@ enum untracked_cache_setting {
 };
 
 enum fetch_negotiation_setting {
-	FETCH_NEGOTIATION_DEFAULT,
+	FETCH_NEGOTIATION_CONSECUTIVE,
 	FETCH_NEGOTIATION_SKIPPING,
 	FETCH_NEGOTIATION_NOOP,
 };
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 41ea9f25de6..ee6d2dde9f3 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -968,7 +968,7 @@ test_expect_success 'use ref advertisement to prune "have" lines sent' '
 test_expect_success 'same as last but with config overrides' '
 	test_negotiation_algorithm_default \
 		-c feature.experimental=true \
-		-c fetch.negotiationAlgorithm=default
+		-c fetch.negotiationAlgorithm=consecutive
 '
 
 test_expect_success 'ensure bogus fetch.negotiationAlgorithm yields error' '
-- 
gitgitgadget
