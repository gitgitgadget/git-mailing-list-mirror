Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C3EC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiDVWju (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiDVWiK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A361FF571
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v12so5959282wrv.10
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m/7nmjzQrPWZOZRTUqvWzqRTYtxoxcBSCt/eY/PHK+w=;
        b=a6H/oALg49BWh8V3RomZvNIu23Q10xNceWU/c8jTNvwwqoP0Urg7R6L/jaXkeDiNSV
         Luy/ATgOspZqj0ozdt3tR3uEAt2uXyRjEmtV2u8OrfAhhAlueqhkjvCIAX5zpvKNwiyc
         mqBHKpvplbbBKwerz1EfF4FqGS9VS+iTvx7C2yd7xs9mjQ34t9MBLtnVLxHmVi/Mr43P
         Z+V3sQnRnridHBQrvBa+PRbBOy2c9+Rl5Zwb5CwGh2+OLTk8P0jy07qkF1UuWeNuTxht
         p2xzAsvXlHvzpfzF7c8QN0wlMQfuXUH7pLtUY0Gu+Z48/Z43TVI7+KA9yIQMi3/CH2n5
         jVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m/7nmjzQrPWZOZRTUqvWzqRTYtxoxcBSCt/eY/PHK+w=;
        b=Ma3VvoPAbeqdExr5/yC7T4EftU+clJzLKo5jiXpI1c0oKljGIYD20aWGHnLQEJLT5a
         ZjnO0bcFp8sbyWJmROgVVBDuQSODNqMGjgZ11kowMf+LK4en/TCjhcPT0A1921VVaOek
         Ouzjb8frhBrB73oV5PmNFs60AtKglD614nXGvOYmScFpIUNYM9BJ3in88W6BbVAQ0WLb
         Pn0mq92k8+W0zcWZ6wwtuXCTBLPKjcS0tGz47Kk6Azn08w2p/jaeXttVnPGCl0GMAJN7
         AOms/Vh7dxKKKJsb2aijZRWoRS7D0kY1TJex1IpUQufLTHOE+YolQqKIWkbr1KV73Sws
         toYw==
X-Gm-Message-State: AOAM533DCgOrJqua6YKol9gg5tH5U/i1qhq2A8BpSLz63JxT3vBm6qmE
        /QjnpYZDNclbbbr2GqX42FNKwfogwCo=
X-Google-Smtp-Source: ABdhPJy6kwYLyuJ382imh/ykZ8aDnWmQAYnYlbhJqxnIU4Udx9DbdKjxk6g8d8cD3yBGFAUfY11pQQ==
X-Received: by 2002:a5d:5987:0:b0:20a:aba9:9b2d with SMTP id n7-20020a5d5987000000b0020aaba99b2dmr5260383wri.26.1650663016342;
        Fri, 22 Apr 2022 14:30:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3-20020a1c2b03000000b00392a3e6280bsm5339157wmr.8.2022.04.22.14.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:15 -0700 (PDT)
Message-Id: <1bd5f346248dad90ab6ac4cea18149d4bb2d2c56.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:45 +0000
Subject: [PATCH v6 19/28] fsm-listen-darwin: shutdown daemon if worktree root
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

