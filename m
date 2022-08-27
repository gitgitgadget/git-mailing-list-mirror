Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2BAC0502A
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiH0Mpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiH0Moz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C08DE6
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bq11so4737682wrb.12
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=aGD/ZignE1C0ZhT6sGuJHm3uTUzVHjwimyqlXH6u/GA=;
        b=Pwst26F4FH1fVh/xz09LY9f2czkB1XL7xvk+QYZ5trSwFBMjDqIvT0j9KxNcGu/54+
         7LbDqHe2ZjULE0PvAehCZxNU3qS+hrLwux4mnMBozaWYC+g9+d1NtbzPHGRaJvsaIXem
         jEI0F9pJ71kFfuQNChOsaFRnEpkjUXAGSvbPx7Nd5TLYUIQIKQsg/IdYjhAFYbXjYPTA
         IQwnpVHQLj0pWmzGvgHYQj4UfWQN60zjbM44VKwruFIk3QChcHdXcZIVZnNE5tEfBZ6Y
         0Lb+f9d3opH/vMSMV9htOixXyNzeHldXNhpCXbxNs2mei17deEqfUyipISKg1vXx/Vkb
         IBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=aGD/ZignE1C0ZhT6sGuJHm3uTUzVHjwimyqlXH6u/GA=;
        b=ji1AYi7MmH5LaQlD+aQ7vcL9w3jdsixyNCXWCj18Gdcs3S/v0icfN0z35tMkg4g/1W
         BJN8PgsYXoYTgsvFyy4CN/dv2gGKExuwZVgbXOvlTKUreydRHLLqRF2/5I3LfbkD+Kfk
         ueXqWQqxJ8pIrOG5dDen7LZnGyvZSEdNpbbWgCfiNAx4Jy/cWiE2Yf84yAWmi6kt9yiM
         wWUcnCb19cZgqyQCJF4Fui2IaqVntFibfajA+i6wawnte3yh3mEUbp8pDrO6QwPTv+5/
         a3dkKsa2XFj0SlWcDYFgJBs+L34nH1Dz7CfJeixBR6JzVGR61CYm59iArpqBf5WXkA8j
         thpw==
X-Gm-Message-State: ACgBeo2/yU+5HzFDmP5WyggIFdkevKwVUWFW7R7qRkOTAi5EptUBkoJi
        mKsozmKTFlnAvwuD5Y0KhtZugsxbH3w=
X-Google-Smtp-Source: AA6agR7rP9LhmanOfPHGImXsBTnarXPx8uNEC/Kg9ibC9bjCHRE5QQ222m/1HfkDgzYx4QA1LXAz2Q==
X-Received: by 2002:a5d:6f08:0:b0:225:3bc2:ac94 with SMTP id ay8-20020a5d6f08000000b002253bc2ac94mr1973217wrb.203.1661604286253;
        Sat, 27 Aug 2022 05:44:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7-20020adfeac7000000b00226332f9275sm2264369wrn.22.2022.08.27.05.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:45 -0700 (PDT)
Message-Id: <a96489310d33f97e20380bdd4bcdac1d970e128f.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:23 +0000
Subject: [PATCH v5 15/16] bisect: remove Cogito-related code
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
        Junio C Hamano <gitster@pobox.com>,
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
index 16f5c92bb9e..cfd6b63214a 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -15,7 +15,6 @@ static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
-static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
@@ -880,13 +879,6 @@ static int cmd_bisect_start(int argc, const char **argv, const char *prefix)
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

