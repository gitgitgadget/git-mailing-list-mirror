Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF79C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbiF0ShR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbiF0Sgb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BCF18B2D
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so6154966wmb.5
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PoF4Q/fqBbJ8ev1xLdRGGRicWOWXCjpw0TjrWxjcXrE=;
        b=JIlzEpEH2mx6LQR/SJ1WqffoCoRouFMWn5RcGuHq2l1aAQKktgHr1crRtmrfscF8Ki
         ApllpS56s0Dqtec4i9uFEiZ+FZM4rl1dQhZu3fwUI3Bp5ZLr3qrHX9YioiVY4Od383Nl
         VY+E3cPHDhUOkjOIwFz641sXV99MtZlkXSkFCCvxT1LGwnlOo54HA/27+NnB3MYYGfIs
         L5Ka7l36XLNww3ZuknNuZxImyRg5LEwERLhxakqDidRSH4KOe5lax1JdgJnk+5y4Ze7O
         /kgAvHP/c9KrvVh8X4e2bY2u1TZKm5HXT4RO2SV1lvOnBpd5h1G0Mql4VnkdxmQeb2Gs
         jwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PoF4Q/fqBbJ8ev1xLdRGGRicWOWXCjpw0TjrWxjcXrE=;
        b=p4GMWsMW9B0h355jzrFrs5CTbWuTsF2b0FPR5mXDEJj77XFrJ/yD+IfqF0bRyTzMXF
         5ZtX+YxoiPFOysU5mj39tx+puf2OmOs0+GdZw2bgiaekrsES70TccPXS45XNKmjc2Gus
         vrVpOpVmTTKsKc8jksvA0WD6QqlTgVYx/ZAm4ex1e0oPxh7DHwbNfqGFTPNFz9GU2ObP
         9C9cWZ1WZRK7b0QI5eWCHnfnRqot/6CU0Z2BwjsZUSDo2euU4441dRGqq2XNwky/t5Gd
         ntr21CYFfW/mRZLmVxHjTaKYzNTAUdI1ys1m8YGWbxKPXGww4ybfbUy2k6ThMC3kUVZj
         kShQ==
X-Gm-Message-State: AJIora8o9k8h/mUPsR1ZO9d5M/zpgnCwoXnVp7iTuFhLcvqqw7H12eBm
        0L5Bf8c+MzuSt+Yu4rlDJ2D7UPMVYUWgnw==
X-Google-Smtp-Source: AGRyM1ty3P9gVnI0/pq1MCtG5/jw6KtmntVX84CDoVxujRuSIlUGUgQFdA9JC95NuUE4Tu15VPa/XQ==
X-Received: by 2002:a1c:770b:0:b0:3a0:42d9:6f4e with SMTP id t11-20020a1c770b000000b003a042d96f4emr14970162wmi.164.1656354697466;
        Mon, 27 Jun 2022 11:31:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d5611000000b002101ed6e70fsm11193171wrv.37.2022.06.27.11.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:36 -0700 (PDT)
Message-Id: <33566b86d77dcc11d68b2aceec0b6c5218bf198e.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:16 +0000
Subject: [PATCH v4 15/16] bisect: remove Cogito-related code
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
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
index 380fef852f3..47103ebf3f2 100644
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
@@ -809,13 +808,6 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
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

