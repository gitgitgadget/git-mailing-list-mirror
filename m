Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA94C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355382AbiEUOtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355341AbiEUOta (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7786D19A
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t6so14953869wra.4
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cZ+LNH8O8gwPm9WYchSe9lh5S7QD6NeSB/sWAdzc4uc=;
        b=Xmi2eJMGCku2DWywG9jJnMqBW6EoCg4bEHGUOw6+OAXn6k6iQMun7x9/q02r3Ry2Xw
         S/UqVxLAIW6G4xSw8/+g2gA1bPM3vd2C8hwCTVZf6WQ5hBF4faMwVUVBlJlJIkXcWeMp
         U9bzFow2zfrw75U1JtHlYd6Y4Jv6T7OPmFi4xDrW4ep8ItFSR2bayJn49Mh6Lh8m38+F
         Iu8Ijh4gHiVNKkzK46vxkfhJuSYlowmAZwu0BsSfxPuviNOlaqzOBhOEfDSIVoaWK6t3
         KnyigR029HYp2p2imX+k6jWXdmobSiZ9K9gXhtQzdxVYAtJ7POTGVE+536vJ5HzIG+Zo
         dEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cZ+LNH8O8gwPm9WYchSe9lh5S7QD6NeSB/sWAdzc4uc=;
        b=JmRpvhqaxXpvLxEiYmbj1QJN2caZOV1iUMdfYUhmCfUk1DTORGRm5n8g1ZJ1ctlgT/
         77fR7qUGTsjIEr3pxHoY8enY5P514DL5SbM+vW4oYMD4IRpPjECc6ZYMr4qOFLhhUumE
         WsDYcnOJxsF6Ckva2l7Qz3iuPDqznUq6eE9pJgUmpEIIgZ/pnRoVOWFLInmrENCu/t6C
         skmSWbZmWcAACx5PJyMIgDCm58MFFb8RQ/s0WYpmnEEDRjylf0I1zTLiis5MSgOykgf/
         /LU2MQ2kHbPj1P9U2T80etssfHUSIG0E4yMweeoTIjX2DfmzsO0KcgC6oOGENZQqjyvG
         Dhcw==
X-Gm-Message-State: AOAM532eZ2yfDjPs/lENPhQ1d0nzKowhtn+mmI6BDV/eNNheA51rprus
        d0GiTvBVCEVNC6Ezd15oyr6KSi+6olI=
X-Google-Smtp-Source: ABdhPJyoEaTwdfJkNP1pFQ4mvRxtwOH5Ltk0FAi8aPNZdGfx8M4HSAR4bmeAQzMYHcFlER0rPyUAGQ==
X-Received: by 2002:a5d:5442:0:b0:20f:ca5b:bbca with SMTP id w2-20020a5d5442000000b0020fca5bbbcamr2139058wrv.704.1653144564436;
        Sat, 21 May 2022 07:49:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18-20020adfae12000000b0020c5253d8e1sm6528538wrc.45.2022.05.21.07.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:24 -0700 (PDT)
Message-Id: <289917e96af373bceb0e11d1e33042e9d9225ce5.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:49:05 +0000
Subject: [PATCH v3 14/15] bisect: remove Cogito-related code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Once upon a time, there was this idea that Git would not actually be a
single coherent program, but rather a set of low-level programs that
users cobble together via shell scripts, or develop high-level user
interfaces for Git, or both.

Cogito was such a high-level user interface, incidentally implemented
via shell scripts that cobble together Git calls.

It did turn out relatively quickly that Git would much rather provide a
useful high-level user interface itself.

As of April 19th, 2007, Cogito was therefore discontinued (see
https://lore.kernel.org/git/20070419124648.GL4489@pasky.or.cz/).

Nevertheless, for almost 15 years after that announcement, Git carried
special code in `git bisect` to accommodate Cogito.

Since it is beyond doubt that there are no more Cogito users, let's
remove the last remnant of Cogito-accommodating code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index d33de133c8c..8f32ccb47b7 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -14,7 +14,6 @@ static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
-static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
@@ -808,13 +807,6 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 			strbuf_addstr(&start_head, oid_to_hex(&head_oid));
 		} else if (!get_oid(head, &head_oid) &&
 			   skip_prefix(head, "refs/heads/", &head)) {
-			/*
-			 * This error message should only be triggered by
-			 * cogito usage, and cogito users should understand
-			 * it relates to cg-seek.
-			 */
-			if (!is_empty_or_missing_file(git_path_head_name()))
-				return error(_("won't bisect on cg-seek'ed tree"));
 			strbuf_addstr(&start_head, head);
 		} else {
 			return error(_("bad HEAD - strange symbolic ref"));
-- 
gitgitgadget

