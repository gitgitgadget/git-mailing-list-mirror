Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0DFC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiEWUPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiEWUNu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D43BABF71
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c9-20020a7bc009000000b0039750ec5774so218516wmb.5
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m/7nmjzQrPWZOZRTUqvWzqRTYtxoxcBSCt/eY/PHK+w=;
        b=ifjaQ2K2F5NE0v7wYwiqonUwXgT2ecqHREO9Tr80Gjlub1Ou5Ba7ppVdJ97ntQYkdO
         2GPNquJGBKghcQEJJWpiwm3K9cA9VafD/7QMI3rGYjir7iIMtUWgvXCVWmqaJ/VQ3Q2Q
         G7b5T45g2yIhzbrCjCgekdofdZ9gVEYRD7QThOMLmEknqfJ8ayzLQ9nO8eJRkNwnqPkq
         bZs9Y/re9IM2zkp3Txf22mmEP52eUBr47B+hu7+8m0P5m2YKWao1b7LPjDS7KnuVAJgg
         XRmLGkFCL0jszy8tMeqU/MacYDFJG+BHHXPmlKvYJX3aKoi2KXvXsyYnFlDk6n2h0C4e
         Ksiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m/7nmjzQrPWZOZRTUqvWzqRTYtxoxcBSCt/eY/PHK+w=;
        b=y238arhMVLn7GQj7ZPhN3SCOYm/3hUhbzRkn/ojyq1wXfs9NFeHQSZAIGYJIRxXa6u
         e2cQspGbPjDrOnjMBSy5cCCHPTUCcXj91LEcag+nM8x5ArtN9SudrwHJKp8qBHkETpCq
         +HpDDrYINrjiE5bYcxI+7kcK+mXfbwFZ7y1L4aDl3v277i6v/BOP+/LRKPTVQvc46SlG
         eGmQ0uw1QeNmCnWSG0OPW+V2inp0NfRK2ltCIIwipZYyjjLCRxesV6D7sq4ovl8orpL3
         3vC0zqa+EFAM7pXe8KG5L7QTHmABDuDHuQSe6eoOgDoQ3zb0bwGh24NG/qk1GZrmCEBz
         kR+w==
X-Gm-Message-State: AOAM532KhFRqsLr3sB+2kKplls+cB01L4Jx5tQ+3o9/QCXj+30P2fR5l
        9yrrmb9WM5bOKA9r4//Uh3XgfS3Seuc=
X-Google-Smtp-Source: ABdhPJzur+i0MBOQK2Maz51TFUCdq5AndylXSIfoGPqmsXfVVq+XMsHtGpiTNxzEexnnzS7YT3M65g==
X-Received: by 2002:a1c:19c3:0:b0:392:9cef:e32b with SMTP id 186-20020a1c19c3000000b003929cefe32bmr639910wmz.116.1653336792941;
        Mon, 23 May 2022 13:13:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bca53000000b003973f4f3cdfsm242745wml.6.2022.05.23.13.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:12 -0700 (PDT)
Message-Id: <95cf1299d445696630d8c0850a69dc2c0ee040ce.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:34 +0000
Subject: [PATCH v7 19/30] fsm-listen-darwin: shutdown daemon if worktree root
 is moved/renamed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach the listener thread to shutdown the daemon if the spelling of the
worktree root directory changes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 07113205a61..83d38e8ac6c 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -106,6 +106,11 @@ static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
 	strbuf_release(&msg);
 }
 
+static int ef_is_root_changed(const FSEventStreamEventFlags ef)
+{
+	return (ef & kFSEventStreamEventFlagRootChanged);
+}
+
 static int ef_is_root_delete(const FSEventStreamEventFlags ef)
 {
 	return (ef & kFSEventStreamEventFlagItemIsDir &&
@@ -215,6 +220,26 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			continue;
 		}
 
+		if (ef_is_root_changed(event_flags[k])) {
+			/*
+			 * The spelling of the pathname of the root directory
+			 * has changed.  This includes the name of the root
+			 * directory itself or of any parent directory in the
+			 * path.
+			 *
+			 * (There may be other conditions that throw this,
+			 * but I couldn't find any information on it.)
+			 *
+			 * Force a shutdown now and avoid things getting
+			 * out of sync.  The Unix domain socket is inside
+			 * the .git directory and a spelling change will make
+			 * it hard for clients to rendezvous with us.
+			 */
+			trace_printf_key(&trace_fsmonitor,
+					 "event: root changed");
+			goto force_shutdown;
+		}
+
 		if (ef_ignore_xattr(event_flags[k])) {
 			trace_printf_key(&trace_fsmonitor,
 					 "ignore-xattr: '%s', flags=0x%x",
-- 
gitgitgadget

