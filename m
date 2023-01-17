Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295D8C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 10:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbjAQKhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 05:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbjAQKgf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 05:36:35 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7A13867A
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 02:32:55 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d2so9961663wrp.8
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 02:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KubJKxpshjTvR5pLQ0gCsn4YDWIvsMwSSfeYsfYWJYc=;
        b=h3wPhply0em9Vqr5R0U01oz6voHEgJ6mTsMZyZMpRt9J8iqhEcOMmZMp6ah8MX7aqd
         p9uxNwHnwOgRVUb3Iu74Emtcyz0rWrdXaZNIgGQb16/vFyzzJ1nwbIuLEPEw4/EyUvPH
         V0cAB9DLvdUrWMtDv6bZdKg4G9lftbbbZV1H2C6cH+5KwU14+Elq2dnFmk2TjboPb01a
         dDhSemJdXdqTYkOkw6RtYOXHAeuLsZXsBreWN1kvVejUbf6t8MMaJMRwvWNUGGObUjKv
         3bLeUSf6OYKsh9/sVhhwI2FF39DtsnJpbgPHrBS4YmMPB/9OuSXi7d0SQDqiwEYr42nT
         x6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KubJKxpshjTvR5pLQ0gCsn4YDWIvsMwSSfeYsfYWJYc=;
        b=pwmGyRXHo8tN0i605U6jCnxWe2c6D5BhH/bblmjNEknw/GpFQLjZ6Kh13Gnxli4fVU
         4qIdAxglXfG41bARaWEMD+dLY4mFX2hSE/r8CZbHC4lUAU/nKaJLX2bwpaKqO5y2dD5N
         u9IqDscdU8fhUaXOGXDfDokOoWoU4RaMEsniho7fWoaWl741SJvaUbm8ri+WTxzqxiKS
         8JyoUkCk9PQss7fnA0Ny9GDAQ4kRSSqcZomkT/Kvf+omnGmY0Qh1iQkn3Cka8jAjBvoA
         ivRRAGDyq8lhhL6YA9a5ELmFqOJpMNzqmgomuDgSRCrlP4a9UYBg/8NZYgWL+fN/3rL2
         Vglg==
X-Gm-Message-State: AFqh2kpgfLTDXzqzezlQMAygfstcziD4s958j9fCOy875Ftq+z/sFQR9
        v17cxLAetrWY03r6lG9twO+8X/xaDWY=
X-Google-Smtp-Source: AMrXdXtrwzQQUpFJrUJ/CSV9+YslwkYgUP3R97LoU1EnjMafwYOjeHvhf7teMQoRKkIOdczgjPpm2A==
X-Received: by 2002:a5d:5484:0:b0:2bd:e150:bf54 with SMTP id h4-20020a5d5484000000b002bde150bf54mr10809594wrv.60.1673951564701;
        Tue, 17 Jan 2023 02:32:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600003cd00b002be07cbefb2sm5341505wrg.18.2023.01.17.02.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 02:32:44 -0800 (PST)
Message-Id: <605b95bf8ab6f1fb5b1ec5b75cd4dcaefbb7f3b6.1673951562.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1465.git.1673951562.gitgitgadget@gmail.com>
References: <pull.1465.git.1673951562.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Jan 2023 10:32:41 +0000
Subject: [PATCH 2/2] [RFC] push: allow delete one level ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Git will reject the deletion of one level refs e,g. "refs/foo"
through "git push -d", however, some users want to be able to
clean up these branches that were created unexpectedly on the
remote.

Therefore, when updating branches on the server with
"git receive-pack", by checking whether it is a branch deletion
operation, it will determine whether to allow the update of
one level refs. This avoids creating/updating such one level
branches, but allows them to be deleted.

On the client side, "git push" also does not properly fill in
the old-oid of one level refs, which causes the server-side
"git receive-pack" to think that the ref's old-oid has changed
when deleting one level refs, this causes the push to be rejected.

So the solution is to fix the client to be able to delete
one level refs by properly filling old-oid.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/receive-pack.c |  5 ++++-
 connect.c              |  2 +-
 t/t5516-fetch-push.sh  | 13 +++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 13ff9fae3ba..ad21877ea1b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1463,7 +1463,10 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		find_shared_symref(worktrees, "HEAD", name);
 
 	/* only refs/... are allowed */
-	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
+	if (!starts_with(name, "refs/") ||
+	    check_refname_format(name + 5,
+				 is_null_oid(new_oid) ?
+				 REFNAME_ALLOW_ONELEVEL : 0)) {
 		rp_error("refusing to update funny ref '%s' remotely", name);
 		ret = "funny refname";
 		goto out;
diff --git a/connect.c b/connect.c
index 63e59641c0d..b841ae58e03 100644
--- a/connect.c
+++ b/connect.c
@@ -30,7 +30,7 @@ static int check_ref(const char *name, unsigned int flags)
 		return 0;
 
 	/* REF_NORMAL means that we don't want the magic fake tag refs */
-	if ((flags & REF_NORMAL) && check_refname_format(name, 0))
+	if ((flags & REF_NORMAL) && check_refname_format(name, REFNAME_ALLOW_ONELEVEL))
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f37861efc40..dec8950a392 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -903,6 +903,19 @@ test_expect_success 'push --delete refuses empty string' '
 	test_must_fail git push testrepo --delete ""
 '
 
+test_expect_success 'push --delete onelevel refspecs' '
+	mk_test testrepo heads/main &&
+	(
+		cd testrepo &&
+		git update-ref refs/onelevel refs/heads/main
+	) &&
+	git push testrepo --delete refs/onelevel &&
+	(
+		cd testrepo &&
+		test_must_fail git rev-parse --verify refs/onelevel
+	)
+'
+
 test_expect_success 'warn on push to HEAD of non-bare repository' '
 	mk_test testrepo heads/main &&
 	(
-- 
gitgitgadget
