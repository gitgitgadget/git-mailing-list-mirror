Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7A7C433FE
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbiBBHeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238048AbiBBHep (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:34:45 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C07C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:34:45 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e2so36635906wra.2
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=qWyPPa0T9JYdn+UDCC8fWI0AHy0ShE9yXmZc1Hj1FeTm/rwrqkCLcZp/Tbt1ovtlq2
         SFn7nCebVS+WWpyXS9leYmgm2QKM2rONRaVzyrM7cAkB5WDIffQXJCdxmTn2Jw+pvILu
         RAvWLy9iYW0eJWCD/Ve3nMopT4KrjDlIsVvTBd/9Znwuj7ZXVisS98tc7PUuSqIKGMDX
         74Kn0zSrbJB+UWz/SsYHSl5UlL1CDsT/SZBfiCLmX0w+SJhK7nb36SNxDTevZ6+o+sTm
         mHhFsNY4ttrSm2FTBUHBbqc2vtpBj85EWb1a2sW+i7wwx8qLx4VJOhlpDYepYu+VFMTp
         dgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=Pu2qkzM/W6MNg6ZvAp+CKRYSAFMB7oeqigzOEvt4NqOJ1k72Vr9XA5sDR+6Bia3sRW
         Te6t3zYBFkZW/pS+OzI4uAyULWhW7bs/FEwGfADPU8Sazbq6jSaVLKacmz0okbsNYrop
         4cmb/OyJbHwHwkFeZj7ruggWPqKVmc3KivMxEB0PtqjbcesibbuE8vxuvIzpSRSe2eob
         P6e3v5E/lifjbMh8WZyH1IRz5zz6F5csKNsBEj6k+fYXgIz7sTMWkKyyfohCtl+gzpFU
         6whoNGpAi2Dhqwb0TKxhzfDhwPRd6wZ9sVCTTohs8e3cVxub/pnK8KBrl3DdnVbEALnD
         vvzA==
X-Gm-Message-State: AOAM532q9t0klcS9VRQzBec9JHw+mnH8ycgd46xWw0sLXI4bp/x/d73f
        VPtbSSPev/Fh+SBMypXoj+cmI9F9S78=
X-Google-Smtp-Source: ABdhPJxdYahcD/la2KFIjc7X+Le7sesmThs6hFk7p/kcaDrpjuFpzMiMxA6MYRa+ZXzJjISjWHBKcg==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr24044720wrs.209.1643787283929;
        Tue, 01 Feb 2022 23:34:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6sm4397234wmq.3.2022.02.01.23.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:34:43 -0800 (PST)
Message-Id: <4a7cd5542bb2f89b4874e4115542ccee9c4639af.1643787281.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 07:34:27 +0000
Subject: [PATCH v3 01/15] merge-tree: rename merge_trees() to
 trivial_merge_trees()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge-recursive.h defined its own merge_trees() function, different than
the one found in builtin/merge-tree.c.  That was okay in the past, but
we want merge-tree to be able to use the merge-ort functions, which will
end up including merge-recursive.h.  Rename the function found in
builtin/merge-tree.c to avoid the conflict.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 5dc94d6f880..06f9eee9f78 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -28,7 +28,7 @@ static void add_merge_entry(struct merge_list *entry)
 	merge_result_end = &entry->next;
 }
 
-static void merge_trees(struct tree_desc t[3], const char *base);
+static void trivial_merge_trees(struct tree_desc t[3], const char *base);
 
 static const char *explanation(struct merge_list *entry)
 {
@@ -225,7 +225,7 @@ static void unresolved_directory(const struct traverse_info *info,
 	buf2 = fill_tree_descriptor(r, t + 2, ENTRY_OID(n + 2));
 #undef ENTRY_OID
 
-	merge_trees(t, newbase);
+	trivial_merge_trees(t, newbase);
 
 	free(buf0);
 	free(buf1);
@@ -342,7 +342,7 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
 	return mask;
 }
 
-static void merge_trees(struct tree_desc t[3], const char *base)
+static void trivial_merge_trees(struct tree_desc t[3], const char *base)
 {
 	struct traverse_info info;
 
@@ -378,7 +378,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
-	merge_trees(t, "");
+	trivial_merge_trees(t, "");
 	free(buf1);
 	free(buf2);
 	free(buf3);
-- 
gitgitgadget

