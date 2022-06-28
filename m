Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D692DC43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 13:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbiF1N2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346460AbiF1N1a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 09:27:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84DD33361
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso7966620wma.2
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hnuyk1jT+kg9sN6d+WJ/mofyuGV6YJxJs2D/tKxipVM=;
        b=BSYapfnCjPiFx0KxJQCD7Wqpi5utXCFhr/DJfhe2cLb3i1xoOw+QzhpGI2GPJ2mRTO
         rrdyREMXWPsCoE+XiVHfpr2VUY+icBr7IpTUkj8KMFIDsKBfy8DH7ZeSaXvTO3lupWWv
         vC1gx6Y5I6ikQwU2zGcB4f8txJOo9TIsm7jGhsgOKN9qEPehNpuxM5kuZrXN6awa+S3p
         prfEkP48PBcsmZ91bLu7i5bXckifhjkMqZZWngTzl6iWICU6KwbvSTJ/JMgyaWQfPox5
         FfA4/eNQRmgEo+ElWlq3b/fQiZpgZ3fYDGaj26JIWGi+dq5mZqm1GSc+ilBJAImIyRU9
         kNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hnuyk1jT+kg9sN6d+WJ/mofyuGV6YJxJs2D/tKxipVM=;
        b=7p9VzWvmdD1WH5WE8Q7SstvBGjbe7iT68nehnuiwG2rrDMPL35tLUxjaBtWdYxCN0p
         HYE2PcOVeLg+eafvG5fxjivU/WS93W2erA8l7X1J7D+Hoe/C9fcIos9dQjVDDEUSvlnr
         irULTq/TDKZyKOdGyLANjbEw5lb0H+WpF0yNCu7Ih4NMGO8d1hnAhhFqfliRuqVobJ8s
         2Po4qd+SDlCwcK8W554ujZnv5yb1ywGFiOwoCHbPstCNiLUDvSa//7mupNvqLNbW98Sq
         bYhsqSyagYpB24s5Y08oRyB8FXhp3XboV2qBUPYtww9FT1wjSaUhd80mCThRram4CsgH
         ljww==
X-Gm-Message-State: AJIora/UcnQ/up++OGf8KbT/CIUFW9CaZGQmo6tZC8wPvkW/ek49D+qY
        IskaAaxMQWiFyQnb3qrG3y64IfRhd3UjHQ==
X-Google-Smtp-Source: AGRyM1uNQrKKCEs2ED+OYRCa25Gc6dSoou+J6uTY90qsTa/WPbp2htVRj2jkjJZMXCI+WhP6xb7ZCQ==
X-Received: by 2002:a7b:c258:0:b0:3a0:42d9:6f51 with SMTP id b24-20020a7bc258000000b003a042d96f51mr19469351wmj.83.1656422765176;
        Tue, 28 Jun 2022 06:26:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v24-20020a5d5918000000b0021b9870049dsm13449843wrd.82.2022.06.28.06.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 06:26:04 -0700 (PDT)
Message-Id: <6528a50343f0fc3c0b2134f1af29cc30fab4f81f.1656422759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 13:25:55 +0000
Subject: [PATCH v3 4/8] sequencer: define array with enum values
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
index 1094e146b99..2ffee79619c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1685,20 +1685,20 @@ static struct {
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

