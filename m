Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07B8C433EF
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 01:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiGEBd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 21:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiGEBdw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 21:33:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E891BC97
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 18:33:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o4so15436821wrh.3
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 18:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ysrfIK+K9nK21STm/jpYzuK4G4DzmoD98BUjPHyngU0=;
        b=jVRNaSz9s/2QthYNiatIsihd2bGURe4iYzoFSD34K7DgDRYg7KA9EZU3QlLq0tA7tc
         R9X/mM/kdYYdxAOI9EsOQJD+IKBt3LalvoPKZhw/sLUScHgRgyQKi3NrYRXS+Aq5C4Fg
         lyZnbXrBTCfj+MFi7z/yeBmyknNV5q0fMCXySbbT6+FKhuWpmlmEUD1VtaIIl2kRztoX
         9y+/2wZ558wd81N2AJLnyC72bBPR9kQcculoCFaePJT9zsgEFx8950u51H75uDTsk8kM
         LfFaiY1csFZfYHIhcPs4VCgCzzjJr5UVISyiwMrTCt4IrhyGLBDN1osJTHa0tgwNdht6
         DPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ysrfIK+K9nK21STm/jpYzuK4G4DzmoD98BUjPHyngU0=;
        b=KpIOxnO0qEbsGxQmUjpDhGfHiCdc4JwjADxUWBvqxNwSAmCL4LsJol6E/T5pElJsnM
         5HyczHBN4oSv359C1AQCpIt6J0BBHYr0JoBP/2xGr91Z44WSynuNiSZtGp6Qm92OnjYk
         psmhUhu4B4JV3szRpLD1Jbjq4WuGylbDd2TyEVonBJPNw0HbzjlXtjhOgYtH0buLPYzM
         yt0ZkKqSHeLBG+ZMTlDA1TfN+mJ2Q/SEACH8n/3cZ5ygyOId5aufG0TU/jCzx9f7yDCW
         ++ERDxlYV3oGYdgTtLbxPsLPQlZ+3SilUfUL2kK0+YGS5IPztbYiDkpHxWiBe4GPnETC
         Eaag==
X-Gm-Message-State: AJIora+UweWJhCDruABIg1gzdIqX3nQwrMvcXqakAzgFSj2F8Tr2CpoM
        TkbLPJd3DLc44RfI/bYcvVd9tWh1uq4=
X-Google-Smtp-Source: AGRyM1ufcVMMTLDEDHkJymhRiFuuiSVzV12tmRg1qz4sH/teaq+LU8fTX/lN0LrG4WrevJ9f6WZ75A==
X-Received: by 2002:a05:6000:69c:b0:21b:9280:9b2d with SMTP id bo28-20020a056000069c00b0021b92809b2dmr28045271wrb.203.1656984829888;
        Mon, 04 Jul 2022 18:33:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d4d8a000000b0021d4aca9d1esm12913616wru.99.2022.07.04.18.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 18:33:49 -0700 (PDT)
Message-Id: <297fef60b19b28a24c449eb42948e0e9138cfdaa.1656984823.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v4.git.1656984823.gitgitgadget@gmail.com>
References: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
        <pull.1268.v4.git.1656984823.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jul 2022 01:33:40 +0000
Subject: [PATCH v4 2/5] merge-ort: small cleanups of
 check_for_directory_rename
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@palantir.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@palantir.com>

No functional changes, just some preparatory cleanups.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@palantir.com>
---
 merge-ort.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8545354dafd..ff037cca8d2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2267,18 +2267,17 @@ static char *check_for_directory_rename(struct merge_options *opt,
 					struct strmap *collisions,
 					int *clean_merge)
 {
-	char *new_path = NULL;
+	char *new_path;
 	struct strmap_entry *rename_info;
-	struct strmap_entry *otherinfo = NULL;
+	struct strmap_entry *otherinfo;
 	const char *new_dir;
 
+	/* Cases where we don't have a directory rename for this path */
 	if (strmap_empty(dir_renames))
-		return new_path;
+		return NULL;
 	rename_info = check_dir_renamed(path, dir_renames);
 	if (!rename_info)
-		return new_path;
-	/* old_dir = rename_info->key; */
-	new_dir = rename_info->value;
+		return NULL;
 
 	/*
 	 * This next part is a little weird.  We do not want to do an
@@ -2304,6 +2303,7 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	 * As it turns out, this also prevents N-way transient rename
 	 * confusion; See testcases 9c and 9d of t6043.
 	 */
+	new_dir = rename_info->value; /* old_dir = rename_info->key; */
 	otherinfo = strmap_get_entry(dir_rename_exclusions, new_dir);
 	if (otherinfo) {
 		path_msg(opt, rename_info->key, 1,
-- 
gitgitgadget

