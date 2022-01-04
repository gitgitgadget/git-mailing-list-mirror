Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12453C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 17:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiADRhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 12:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbiADRhF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 12:37:05 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A79C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 09:37:05 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k66-20020a1ca145000000b00345fa984108so1838135wme.2
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 09:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7Y1eVqZYE9BacgGrfH4O//tMC0Ck7M/KSJNB61BWioo=;
        b=PDjnaXRL4DyTNOilngmCcvGg58xaPM+u5JldREuWXnVq+3sUMsunw79E0JbRKY6a7T
         3TftDp+zej05B5c0onGCvfR+pQn3EbtkJ1NRji4supcILpg3eUDrYya/kDvbU8t0gHqk
         H4A4cmoK/LJdzOIjaxMgJfxIXU71ywSoRVyVyFNRh8QmAnSBbT1aigoFr5Pw7OcyIXxc
         E1o77ooKwUVXsJ2/ow/2t+sLsxD+gxWfPDAaFBIALIdMEju+zcgGhxD7awaMwKDMRB0Z
         BjDkZAiLnf2KGfRrHbIKyZVehDYf0x5GzTM+XqwA8XbyuTVTsBwCA757D7aXt6ypuNkc
         4haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7Y1eVqZYE9BacgGrfH4O//tMC0Ck7M/KSJNB61BWioo=;
        b=FNMk4DgFUKF5vB9l7r+Bq0Ma45DInbg5mmHZFAoNtDRlsvkD+4kysXxIfRq6DFDKvS
         2UNWEVLg6mm7m9CFAM4spbTpFpJII5rL/SImhcGbdDZLVf/RCPpU8sFwM49118L3NVCJ
         kFhZE1yceZA1uFP0H5/vq/9sqcKqo4rtMgFQ4s87prR/OaYMw4bFYe+QtXPU/saarXmh
         USqqsbkLOFQuhZ/C68Pe76hkeKGm2ZisvhTDWRzxRTg1FPn6PS1tNyEXDeNqn3LgRSHO
         1dSXspTUKLe08OD3f1wFzv0AJCgaThutBy9FRmveqM9ThHHqbx8kP4315Xi/h0t0atnX
         LoTw==
X-Gm-Message-State: AOAM5325iPZg8tg5ET+GzKub5LlVRn1+VDqZm/8PK2kNsJRpp5OueVa1
        FQPcqvz4OxkSmay4eGGnbJcXGS+fjyM=
X-Google-Smtp-Source: ABdhPJxdZLzM7loakHtXUwd+dCbH8nlhvDr0Bi0GX4iIY6WIph86+WgBU/gWOWCVeRosdMWJzUWYCA==
X-Received: by 2002:a05:600c:34ca:: with SMTP id d10mr43963766wmq.133.1641317823426;
        Tue, 04 Jan 2022 09:37:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm37599015wru.87.2022.01.04.09.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:37:03 -0800 (PST)
Message-Id: <0194d894c2f9c5ae4bbaac4cd6fca89933a04789.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 17:36:53 +0000
Subject: [PATCH 2/9] reset: reorder wildcard pathspec conditions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Rearrange conditions in method determining whether index expansion is
necessary when a pathspec is specified for `git reset`, placing less
expensive condition first. Additionally, add details & examples to related
code comments to help with readability.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index b1ff699b43a..79b40385b99 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -204,10 +204,16 @@ static int pathspec_needs_expanded_index(const struct pathspec *pathspec)
 			/*
 			 * Special case: if the pattern is a path inside the cone
 			 * followed by only wildcards, the pattern cannot match
-			 * partial sparse directories, so we don't expand the index.
+			 * partial sparse directories, so we know we don't need to
+			 * expand the index.
+			 *
+			 * Examples:
+			 * - in-cone/foo***: doesn't need expanded index
+			 * - not-in-cone/bar*: may need expanded index
+			 * - **.c: may need expanded index
 			 */
-			if (path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
-			    strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len)
+			if (strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len &&
+			    path_in_cone_mode_sparse_checkout(item.original, &the_index))
 				continue;
 
 			for (pos = 0; pos < active_nr; pos++) {
-- 
gitgitgadget

