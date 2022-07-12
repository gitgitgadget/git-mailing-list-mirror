Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E69C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 13:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiGLNHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiGLNH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 09:07:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5E6B522E
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y22-20020a7bcd96000000b003a2e2725e89so4466188wmj.0
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DIFIaXYKY2CqP0ES2Glof0k0rNcQdbL8X4eFD2b7rGg=;
        b=CkEYiWzuglvTwWcBpYDN8GnnpOGcoUHLVmwzWXLD73Zd/aulNAY8Eg5dprfJQSzdOM
         LPX7j1VDkQeIPx/QTXQ1AKiE91IprDiwhUlZ4nsKyITlbIdX8YSTilPSTvabjLwH4L3w
         b4tsV3R8ljMi1ZqkJ14hwa8MPu88BouNroNYH1Wl0oCxBvnU9VfL9ETrP10/Y+FKAEJt
         T8YiS0pI9ZNz5JOEnI3zDmqigip7pqiRvJnypO0InJQztQsLv0ZNHjez33jJa4K6S27h
         0XowcPDwqsF0p5rWb3i/W60Acf7f17J4egpoxEZgNAWo9PaCNrUY4SB/y0opujPg8M/K
         vY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DIFIaXYKY2CqP0ES2Glof0k0rNcQdbL8X4eFD2b7rGg=;
        b=44l8hLWU0ZZzQ4D61cKjrldqpdiNGOzXhdqso4m7Z1nI6Aq1rtgvhfwtz0oJOGqwWH
         7kFfVlqdhLtXaLxi0yje3qUySGV6xAG9NrRyapd5GmbWAt5k9z7dsKgXWzclwaWPhBAh
         yF2vu43knkOv2kpKUaFLhwjJ3W+Uamr/krLRxFgLJmktLZ2Scixbnj9kGo20vnGVSlLM
         r4QRCjrlhhXU2UWfyCDYWB0/qVs+p2ESqrvE1fvfORNK7IjoRkDp/uEohdrtbkE9KLTR
         zMGpEXqo6MECFutbJgmNOgAo1qFQ+nLldu7Yut0J5JPNqSEGSqcXMg9turj9Qy25nmtT
         NeOg==
X-Gm-Message-State: AJIora9i0Aoq/D2Mv8OTdZY5BT53vna7jKSHht9SMjK9JAi0LpvbOkva
        EMPjBzZ4kyE3qekkRRK9G8NPuS9PJ4w=
X-Google-Smtp-Source: AGRyM1urb5VGeDSci9iDxxuePkJeZqB4YMgiTdLDKdVLp7hwFlrON3DfNmP0NvWJ6DqOYzSgLdG7ew==
X-Received: by 2002:a05:600c:35ca:b0:3a2:aee3:a8ff with SMTP id r10-20020a05600c35ca00b003a2aee3a8ffmr3754127wmq.206.1657631236951;
        Tue, 12 Jul 2022 06:07:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8-20020a7bc848000000b003a2e7c13a3asm5641073wml.42.2022.07.12.06.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:07:16 -0700 (PDT)
Message-Id: <b2c09600918572e1157969a27f4e83a34ea0af69.1657631226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jul 2022 13:06:58 +0000
Subject: [PATCH v4 05/12] sequencer: define array with enum values
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

The todo_command_info array defines which strings match with which
todo_command enum values. The array is defined in the same order as the
enum values, but if one changed without the other, then we would have
unexpected results.

Make it easier to see changes to the enum and this array by using the
enum values as the indices of the array.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sequencer.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e93c61cbd25..575f9be5ea0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1708,20 +1708,20 @@ static struct {
 	char c;
 	const char *str;
 } todo_command_info[] = {
-	{ 'p', "pick" },
-	{ 0,   "revert" },
-	{ 'e', "edit" },
-	{ 'r', "reword" },
-	{ 'f', "fixup" },
-	{ 's', "squash" },
-	{ 'x', "exec" },
-	{ 'b', "break" },
-	{ 'l', "label" },
-	{ 't', "reset" },
-	{ 'm', "merge" },
-	{ 0,   "noop" },
-	{ 'd', "drop" },
-	{ 0,   NULL }
+	[TODO_PICK] = { 'p', "pick" },
+	[TODO_REVERT] = { 0,   "revert" },
+	[TODO_EDIT] = { 'e', "edit" },
+	[TODO_REWORD] = { 'r', "reword" },
+	[TODO_FIXUP] = { 'f', "fixup" },
+	[TODO_SQUASH] = { 's', "squash" },
+	[TODO_EXEC] = { 'x', "exec" },
+	[TODO_BREAK] = { 'b', "break" },
+	[TODO_LABEL] = { 'l', "label" },
+	[TODO_RESET] = { 't', "reset" },
+	[TODO_MERGE] = { 'm', "merge" },
+	[TODO_NOOP] = { 0,   "noop" },
+	[TODO_DROP] = { 'd', "drop" },
+	[TODO_COMMENT] = { 0,   NULL },
 };
 
 static const char *command_to_string(const enum todo_command command)
-- 
gitgitgadget

