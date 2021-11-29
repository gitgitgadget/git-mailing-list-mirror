Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50674C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 19:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352182AbhK2Ti7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 14:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238805AbhK2Tg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 14:36:57 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7806FC061A26
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:48 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a18so37859969wrn.6
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rWdQm5Zkkxjg4tRvPMLEws5NQlPaszk/3jdQlcrd+H8=;
        b=MMBPAdPO443VYdA8XQaDv85gncWMjuwd+71rtrdbUKTG/P/414X1jgikVmWKE4tl56
         CB3Ds3FyoWkb4zOR+eEk6y04NGaEZWWxHKZGHOLXVZCJq23zYTyrxs/6t/Xb8W155YgJ
         O5nR8Mf99Yr+9piikbveXZrW5VTL+lePDtb8bGLfrRHUz6SqD7HEk1Ywm4J8Dd17/NzU
         GffaVRbRZ8Jj1axOIGHPgook6VWT+8MF/vZq53eq/34Kerb0ZNnV9wzl2HkYub5RRgCA
         FT0JaVH1eSp0wzLDXUbiZ68LYQXUSTUqvKOzazB90OL1+W9KRFxQXusV3BlNxRbfMI9o
         fQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rWdQm5Zkkxjg4tRvPMLEws5NQlPaszk/3jdQlcrd+H8=;
        b=JogAOpFhGHneGoKUPsMt3GUboeC7Jw79AOGthHRAhGpqOA2JEHkS7KeFGN+lfPg1Sq
         catkbb8S9I4U+879NlcUqml7RdCLDGEY6omqduVIbbxNXsguaR62KCQyyInTleLVVHG3
         PDPuwaz9Z90vYHQikMhuH+m7M9ZJau3qqzbdNhp2QswcNGs6+9s2PM0CPGky4EmYki3S
         vlJ39ZQPZav4U+b4k1HaUTzpy8H7rCFgN4NDlgdsw+ILdw1Xf76BujkXLdi9wwNdr+O+
         QITRJSoPLCcRsV3pvYB4JBBmU6//+6QzKXrdiysh0JvuYqFpIlptb1o7Am2kJHumtOOL
         Hiag==
X-Gm-Message-State: AOAM533pNJUdlI+C1ZjLZ7NrEOSnI6h4QKZUyI6bi3OczMduZouPOV7g
        lCheoUTgOHk2qC1yewGzL+Lm9mkWlI8=
X-Google-Smtp-Source: ABdhPJy6mhwrvB6WoMmt9E0rHAbdU4/gmS+XkUDceu4Uu36Kb04fM9Dqwsk3aeF4xQHC3zLLRlmdPg==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr34292040wrq.120.1638201166993;
        Mon, 29 Nov 2021 07:52:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm26092774wmq.46.2021.11.29.07.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:52:46 -0800 (PST)
Message-Id: <1bb2ca92c60be453d7b151e0a1fb5d471a2e5090.1638201164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
References: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
        <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 15:52:38 +0000
Subject: [PATCH v6 3/8] sparse-index: update command for expand/collapse test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

In anticipation of `git reset --hard` being able to use the sparse index
without expanding it, replace the command in `sparse-index is expanded and
converted back` with `git reset -- folder1/a`. This command will need to
expand the index to work properly, even after integrating the rest of
`reset` with sparse index.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index c7449afe965..cab6340a9d0 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -634,11 +634,15 @@ test_expect_success 'submodule handling' '
 	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
 '
 
+# When working with a sparse index, some commands will need to expand the
+# index to operate properly. If those commands also write the index back
+# to disk, they need to convert the index to sparse before writing.
+# This test verifies that both of these events are logged in trace2 logs.
 test_expect_success 'sparse-index is expanded and converted back' '
 	init_repos &&
 
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index -c core.fsmonitor="" reset --hard &&
+		git -C sparse-index reset -- folder1/a &&
 	test_region index convert_to_sparse trace2.txt &&
 	test_region index ensure_full_index trace2.txt
 '
-- 
gitgitgadget

