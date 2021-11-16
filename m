Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F81AC433FE
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 076D761B98
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhKPJxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbhKPJwp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:45 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C7AC061204
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:48 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w29so36275927wra.12
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nXlUzK0eG1nytfPPrkrw0gtj2yvs5u/jSO3jH2X9/oQ=;
        b=GypDAEyvYffTDaovXmLwb9nnAtnBSdB25Cc+YUnBFW7wyPvAVr+fopIVgXZ4+2F3XR
         gD0yszHuim7U7yn0ulwScCYlizYKpsxoQ55+rJO9aInV8HF6fuQz+2W7YYdtm/5FdVFH
         87PGRmKsJk0MXRXdzUClS3R0awo8HTXhHCEpNXx03hUVOhKM5ycos/eIScX/Ze383CUt
         www+UlAs/ohLs6tEjKNDswLAAxxFT5P+TzIodVuKkrPieog/18PlIbDiNHXmg1Cxc62x
         P5JYt4aby676dwlZIAvLWPiuOKuEhR6g5wUuFSlb48ZPVdm+/Z+92Ru+5z+Fghoy0lvm
         S/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nXlUzK0eG1nytfPPrkrw0gtj2yvs5u/jSO3jH2X9/oQ=;
        b=TiQtrCX3i7FdVq4gZcrp0PBMp1nZYUmO4e6eTNhwnidPYFhz8BRK1WaBWpsyQqI7TE
         gQGrtalBSwG4Ok+kkhmPSRPY7LsFULdNUP7LhBu0/XnaOLWmunRa20tqVY5RFOajSwvN
         gbaZWftKjSn4pTkxX82aFXd7RykUneI7lEuph0EWuSYJAhRO53WNgpLWMguyYANlTQJh
         klhb/frRrjWXG+id8a8KN1xX5O9G80QxbvVHoYXqYggJD23xc/+zsYdp8ubPUY2mq5DV
         /r8Pfqb51XwMH/2b+cdQLSOqnpXwuc3v6q5+OeFrNPjJ8lncD4A8UhfHsAiCILCO4Lsg
         ngQw==
X-Gm-Message-State: AOAM533An92KQVGzydA/snbZF920bJ7UGIOpHr1vZUb8dmAMJ3vho35Y
        qvDpuLfL5s18ZSCbDKcewIziyeDLzLo=
X-Google-Smtp-Source: ABdhPJxVabAdOUG7B6Vt4ChVQ9vz/f4R58Ihf5ypnMCJ4Qv50s9dNTAWX9QuxJHX4cn4cBSB5KNWBg==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr7934736wru.380.1637056186907;
        Tue, 16 Nov 2021 01:49:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j134sm1952377wmj.3.2021.11.16.01.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:49:46 -0800 (PST)
Message-Id: <c3e5dce1910b3d640757e0845d646c3b040a8e28.1637056179.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 09:49:32 +0000
Subject: [PATCH v4 09/15] diff --color-moved: call comparison function
 directly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This change will allow us to easily combine pmb_advance_or_null() and
pmb_advance_or_null_multi_match() in the next commit. Calling
xdiff_compare_lines() directly rather than using a function pointer
from the hash map has little effect on the run time.

Test                                                                  HEAD^             HEAD
-------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38(0.35+0.03)   0.38(0.32+0.06) +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.87(0.83+0.04)   0.87(0.80+0.06) +0.0%
4002.3: diff --color-moved-ws=allow-indentation-change large change   0.97(0.92+0.04)   0.97(0.93+0.04) +0.0%
4002.4: log --no-color-moved --no-color-moved-ws                      1.17(1.06+0.10)   1.16(1.10+0.05) -0.9%
4002.5: log --color-moved --no-color-moved-ws                         1.32(1.24+0.08)   1.31(1.22+0.09) -0.8%
4002.6: log --color-moved-ws=allow-indentation-change                 1.36(1.25+0.10)   1.35(1.25+0.10) -0.7%

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 78a486021ab..22e0edac173 100644
--- a/diff.c
+++ b/diff.c
@@ -994,17 +994,20 @@ static void add_lines_to_move_detection(struct diff_options *o,
 }
 
 static void pmb_advance_or_null(struct diff_options *o,
-				struct moved_entry *match,
-				struct hashmap *hm,
+				struct emitted_diff_symbol *l,
 				struct moved_block *pmb,
 				int pmb_nr)
 {
 	int i;
+	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
+
 	for (i = 0; i < pmb_nr; i++) {
 		struct moved_entry *prev = pmb[i].match;
 		struct moved_entry *cur = (prev && prev->next_line) ?
 				prev->next_line : NULL;
-		if (cur && !hm->cmpfn(o, &cur->ent, &match->ent, NULL)) {
+		if (cur && xdiff_compare_lines(cur->es->line, cur->es->len,
+						l->line, l->len,
+						flags)) {
 			pmb[i].match = cur;
 		} else {
 			pmb[i].match = NULL;
@@ -1195,7 +1198,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
 			pmb_advance_or_null_multi_match(o, l, pmb, pmb_nr);
 		else
-			pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
+			pmb_advance_or_null(o, l, pmb, pmb_nr);
 
 		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
-- 
gitgitgadget

