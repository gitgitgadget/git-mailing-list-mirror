Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EC5C61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 16:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjBDQs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 11:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjBDQsX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 11:48:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779D4244B9
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 08:48:22 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bk16so7038938wrb.11
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 08:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClbwP2XmKEOrma1GwxV8YVov20CbwIUWmGoolA+JSwM=;
        b=otitIkoXTma8nA+gADsDrWHZrB6Cn9cEqHr0V6s0tBkZ9cer2t+SjNJzcLFS34DtUx
         cy9e7+YfoVqjaUAEWCUPg3s4cYw4EsFt7duUbv6fUZzsr96+NlsUUN4PE8SRF2zqaYs4
         2MBuHnaL3Ap4O46DZ2bkZkpcVaca7ikKoV4aSQ5bHmzfeaIt+C55PtjzHBnl1XocivA7
         KGJOrVct8yRqVNhuopzkil2XBy/v8HZfiL4PD/hGv9k6cfX05lfXH8zHsjoBXpp5BN8K
         LUdzHv77WwtMrv4+GQwknh+eLGl2HLLaj/WILrPZ4JOzsvAbgLmICN4aGKRFrlqxGe3h
         bwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClbwP2XmKEOrma1GwxV8YVov20CbwIUWmGoolA+JSwM=;
        b=lgTa/FUbLRRcE1xDKStIVj8YgO7m8lg5vH/oh2bhZLvP24LPPMntinq3zxiwQf55S8
         cDkABiHvZXOUmRrXBFDHQX8DjV2RjbjBP52fXxYY6pBp4PG39WKBm59KggQfi4XovMFR
         eRw9WdPK6VZcrZZU76vkYehCaOp7JmdG93Lecn6ldETcyW642mc8co1ZqhXh2hhHO/Q8
         mtVn6ObDVhhQ1Jz84MU3h/U2pYxpGiyNZYA4su67W2QCyrg4NiWllwIjaUFVXfvstTNa
         MCZWiR3V2mP0U3PUN6F2NHZe93N/89IkUZmnyiwUEN1EnbWY5dQIReBZdj4Gjmo7QLZ4
         LwQQ==
X-Gm-Message-State: AO0yUKWwTf9kCYrDbul/6Q94sOXdqO7scoW/5WPpl2gjomuBdvq/Es7t
        vDEc7uBzvyyIJ02Mg/S4+pIB+Mg/CvI=
X-Google-Smtp-Source: AK7set/g8Wr3jmARE6kgH1IRBBmVcSAMdWdq5T8HmFrQmseji6mEErwpLVfGNWRLmzqfQwhm0gakzg==
X-Received: by 2002:adf:fb46:0:b0:2bf:b54f:61f0 with SMTP id c6-20020adffb46000000b002bfb54f61f0mr10903576wrs.57.1675529300783;
        Sat, 04 Feb 2023 08:48:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d4986000000b002bfc24e1c55sm4698612wrq.78.2023.02.04.08.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 08:48:20 -0800 (PST)
Message-Id: <966cb49c388b652861c773ad7430875bf7896c16.1675529298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1465.v2.git.1675529298.gitgitgadget@gmail.com>
References: <pull.1465.git.1673951562.gitgitgadget@gmail.com>
        <pull.1465.v2.git.1675529298.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Feb 2023 16:48:17 +0000
Subject: [PATCH v2 2/2] [RFC] push: allow delete one level ref
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
 builtin/receive-pack.c | 4 +++-
 connect.c              | 3 ++-
 t/t5516-fetch-push.sh  | 7 +++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 13ff9fae3ba..77088f5ba8d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1463,7 +1463,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		find_shared_symref(worktrees, "HEAD", name);
 
 	/* only refs/... are allowed */
-	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
+	if (!starts_with(name, "refs/") ||
+	    check_refname_format(name + 5, is_null_oid(new_oid) ?
+				 REFNAME_ALLOW_ONELEVEL : 0)) {
 		rp_error("refusing to update funny ref '%s' remotely", name);
 		ret = "funny refname";
 		goto out;
diff --git a/connect.c b/connect.c
index 63e59641c0d..7a396ad72e9 100644
--- a/connect.c
+++ b/connect.c
@@ -30,7 +30,8 @@ static int check_ref(const char *name, unsigned int flags)
 		return 0;
 
 	/* REF_NORMAL means that we don't want the magic fake tag refs */
-	if ((flags & REF_NORMAL) && check_refname_format(name, 0))
+	if ((flags & REF_NORMAL) && check_refname_format(name,
+							 REFNAME_ALLOW_ONELEVEL))
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f37861efc40..19ebefa5ace 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -903,6 +903,13 @@ test_expect_success 'push --delete refuses empty string' '
 	test_must_fail git push testrepo --delete ""
 '
 
+test_expect_success 'push --delete onelevel refspecs' '
+	mk_test testrepo heads/main &&
+	git -C testrepo update-ref refs/onelevel refs/heads/main &&
+	git push testrepo --delete refs/onelevel &&
+	test_must_fail git -C testrepo rev-parse --verify refs/onelevel
+'
+
 test_expect_success 'warn on push to HEAD of non-bare repository' '
 	mk_test testrepo heads/main &&
 	(
-- 
gitgitgadget
