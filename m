Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA43C4332F
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbiCVSZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbiCVSZS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:25:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8BB8F9AC
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so3863566wmj.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5W2x8t68NoDAVIFeMr0BVtQdXxzEzVw8wanSKIA/+K4=;
        b=euXWwXv4Huay4kBJIaraV0X9wTjhVbD8VV+wBUhUau7lNcl5PXYzpC2vbqX7OksqZB
         WkoCILPUoQ6S0k+jgdZQ77q6dyhtCHT/O3T5A3p1Gwx+7kGcw4RPx19eY9gZGY34rVhE
         4ymuc5yWs8fwEC9Cq3J4KzKktyr+YYJkDSGjNLaLrXTuL39jzGzajpmteKD9rfybRAz7
         5XjuZYm36Ld1H+mmBjPFMZITwDbr54Vv14k+OQv+4NoboLfVqZd9BuS5AjYK8PMqaOgH
         gd9Z6eTkmhrJuunqb6udVk/6dw93KG5hnL49mZFjBmwricoW+wjqVPCDVW15HNJJqucC
         eH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5W2x8t68NoDAVIFeMr0BVtQdXxzEzVw8wanSKIA/+K4=;
        b=hRV4Ig2bFPFjGZ9V9Geux+iYWLTBLOYbedJh9TmIcOHzqNsBx8kVzOvjMWp1GjqVI+
         yLReW21iMxlrrDtd54h69mzq2Kq/STMnWOMxN2bWhr6lzZUIvspI7YGGLZvr7L40KQEG
         qYZtEXr/L7txrNN0R5e4magwRpQWBopzrpXxiIm0RTMtd0ztpFaOEYptQBUIWaQEuo/m
         HIibLKZzARcDvm510nOAWaX7MTcX+b1DFg7JSSj29svXkqXVHe4O+QOwElDd9aoaaxAO
         yf68nnMFsIGiAtBXhe8E2XYDOuhcB6XQvM2gdBvVAl4XvXMh2RcZxYzQx5ypGET9XnXl
         kIlw==
X-Gm-Message-State: AOAM5320cbGPsS7OgJp6c4iVNbwHeGPyMPm1hgdU7yG3yaoKQ3pfEvRs
        tZtNGcP+OUTaHg78h+kSIMRj9aeYwSY=
X-Google-Smtp-Source: ABdhPJzhWrcb8KuDTcjg3Nb1s2LF+qDxsvMpnXzJsXk79k61PxwafsPYVm3i/Q0cWFKCRq8iDspcgQ==
X-Received: by 2002:a05:600c:35d4:b0:38c:9933:41c0 with SMTP id r20-20020a05600c35d400b0038c993341c0mr5071123wmq.149.1647973412767;
        Tue, 22 Mar 2022 11:23:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm10444986wrb.101.2022.03.22.11.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:23:31 -0700 (PDT)
Message-Id: <35c77b854bdb5ea3a339c9a57865d4d0debc4df5.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:45 +0000
Subject: [PATCH v3 12/27] fsm-listen-darwin: ignore FSEvents caused by xattr
 changes on macOS
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Ignore FSEvents resulting from `xattr` changes.  Git does not care about
xattr's or changes to xattr's, so don't waste time collecting these
events in the daemon nor transmitting them to clients.

Various security tools add xattrs to files and/or directories, such as
to mark them as having been downloaded.  We should ignore these events
since it doesn't affect the content of the file/directory or the normal
meta-data that Git cares about.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 34 +++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 0741fe834c3..14105f45c18 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -100,7 +100,7 @@ static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
 	if (flag & kFSEventStreamEventFlagItemCloned)
 		strbuf_addstr(&msg, "ItemCloned|");
 
-	trace_printf_key(&trace_fsmonitor, "fsevent: '%s', flags=%u %s",
+	trace_printf_key(&trace_fsmonitor, "fsevent: '%s', flags=0x%x %s",
 			 path, flag, msg.buf);
 
 	strbuf_release(&msg);
@@ -125,6 +125,31 @@ static int ef_is_dropped(const FSEventStreamEventFlags ef)
 		ef & kFSEventStreamEventFlagUserDropped);
 }
 
+/*
+ * If an `xattr` change is the only reason we received this event,
+ * then silently ignore it.  Git doesn't care about xattr's.  We
+ * have to be careful here because the kernel can combine multiple
+ * events for a single path.  And because events always have certain
+ * bits set, such as `ItemIsFile` or `ItemIsDir`.
+ *
+ * Return 1 if we should ignore it.
+ */
+static int ef_ignore_xattr(const FSEventStreamEventFlags ef)
+{
+	static const FSEventStreamEventFlags mask =
+		kFSEventStreamEventFlagItemChangeOwner |
+		kFSEventStreamEventFlagItemCreated |
+		kFSEventStreamEventFlagItemFinderInfoMod |
+		kFSEventStreamEventFlagItemInodeMetaMod |
+		kFSEventStreamEventFlagItemModified |
+		kFSEventStreamEventFlagItemRemoved |
+		kFSEventStreamEventFlagItemRenamed |
+		kFSEventStreamEventFlagItemXattrMod |
+		kFSEventStreamEventFlagItemCloned;
+
+	return ((ef & mask) == kFSEventStreamEventFlagItemXattrMod);
+}
+
 static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			     void *ctx,
 			     size_t num_of_events,
@@ -190,6 +215,13 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			continue;
 		}
 
+		if (ef_ignore_xattr(event_flags[k])) {
+			trace_printf_key(&trace_fsmonitor,
+					 "ignore-xattr: '%s', flags=0x%x",
+					 path_k, event_flags[k]);
+			continue;
+		}
+
 		switch (fsmonitor_classify_path_absolute(state, path_k)) {
 
 		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
-- 
gitgitgadget

