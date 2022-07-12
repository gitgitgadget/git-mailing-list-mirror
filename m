Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EEFC433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 13:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiGLNHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiGLNH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 09:07:26 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438B4B5211
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v10-20020a05600c15ca00b003a2db8aa2c4so4772154wmf.2
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z+L9+tPr9fjSOm+ow1CUgMKdAgsHWFJvdTFI6Y5m8Js=;
        b=I2gbzeLD388FFlAxV3LUiPwJw7CxWDipEwq51RAx10Fc6LNQuzoA2+Lo3wz5Hi31DR
         bdJsqLnCDn2aD2NY4+roXwxUlQwTXsNX5+MClvkrytTJpwREKN0ETib0XoUcinS24b5f
         VacEnFMCBV1PaU69GdqcTe8BauZICMtGs7BS4/Vwe1E55VwmsFAB+Bhj5KPzlehZnDn+
         xcdXHXkgp4JtTbUs5H7ms7Pltw4Grz6ZAXc7WgY1+ZJX/vUvNR7nDXGIOjuW1G5JqyXS
         nzckq9yB1LUuMT7fVYc+WiBGMJ8BjgDjMw5xpEa0ayy9jcdIfxZsR/tzuZYdAcOAts49
         JG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z+L9+tPr9fjSOm+ow1CUgMKdAgsHWFJvdTFI6Y5m8Js=;
        b=5I62eKhnNntRx/vxkerbVatV3Y68btITo3dEkP4GRxgFBFX5oLBRFMnepDLqZ2jj1e
         nEGNqCOgDvVisSHnBdDQ1GHktpdOW3k1MDXvQ/JCSRzlLM2zJ7tz3mTgktg9QCMwd1+O
         fN1SxxSWMShEjfKuqtl0x7EDodVtSalP/U8X1kt5zgkXCCSTmbqRlLDkOLKBvxwG8uQF
         wYtsz0EfYc7utJgTKIuv8A0JUc0o60UPvyG8grL/j8XZQavCuu8RO1KSlA1O1YkM7MU8
         v7L2LKMwOYmbEgk55pu7RoKTkMMiVS+nqlCKFqflVJHx7nrdNuXAljg15RjTxPTCuIHD
         SRwQ==
X-Gm-Message-State: AJIora/DDbO8HbiIsdQyGxBQbw4ppQenzrXFC/0+jsvcUjn1W4WDjlas
        so6iv07XCD/IIJJ0KOscvSg8lqUFjYI=
X-Google-Smtp-Source: AGRyM1tjXNkalkNL0tdYK4mDq4G3fr22uJY778PT7IJLs1KzPQoYk52J+uRkx6K+k5Bl9cNd+VklDw==
X-Received: by 2002:a7b:c2aa:0:b0:39c:9039:e74b with SMTP id c10-20020a7bc2aa000000b0039c9039e74bmr3787933wmk.127.1657631235426;
        Tue, 12 Jul 2022 06:07:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d4c47000000b0021baf5e590dsm8258010wrt.71.2022.07.12.06.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:07:14 -0700 (PDT)
Message-Id: <dec95681d2be3b09090c4df325bdcac4a5b97530.1657631226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jul 2022 13:06:57 +0000
Subject: [PATCH v4 04/12] rebase-interactive: update 'merge' description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'merge' command description for the todo list documentation in an
interactive rebase has multiple lines. The lines other than the first
one start with dots ('.') while the similar multi-line documentation for
'fixup' does not. This description only appears in the comment text of
the todo file during an interactive rebase.

The 'merge' command was documented when interactive rebase was first
ported to C in 145e05ac44b (rebase -i: rewrite append_todo_help() in C,
2018-08-10). These dots might have been carried over from the previous
shell implementation.

The 'fixup' command was documented more recently in 9e3cebd97cb (rebase
-i: add fixup [-C | -c] command, 2021-01-29).

Looking at the output in an editor, my personal opinion is that the dots
are unnecessary and noisy. Remove them now before adding more commands
with multi-line documentation.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 rebase-interactive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 87649d0c016..22394224faa 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -54,9 +54,9 @@ void append_todo_help(int command_count,
 "l, label <label> = label current HEAD with a name\n"
 "t, reset <label> = reset HEAD to a label\n"
 "m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]\n"
-".       create a merge commit using the original merge commit's\n"
-".       message (or the oneline, if no original merge commit was\n"
-".       specified); use -c <commit> to reword the commit message\n"
+"        create a merge commit using the original merge commit's\n"
+"        message (or the oneline, if no original merge commit was\n"
+"        specified); use -c <commit> to reword the commit message\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
 	unsigned edit_todo = !(shortrevisions && shortonto);
-- 
gitgitgadget

