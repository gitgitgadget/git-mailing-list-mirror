Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30EAC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351967AbiCXQy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352192AbiCXQxM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1883B0A4B
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n35so3088919wms.5
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5W2x8t68NoDAVIFeMr0BVtQdXxzEzVw8wanSKIA/+K4=;
        b=ROVwxhdP4wfT3CGpJ0lI5Br06kYDzl1XP1XQWXkKUvrAv6CKsAPE3qj8LZ+cQ2/Jgl
         2oe/N0pymn/tsdgTNzm2QwPIFUEH6A7oNITI3okldSY3lJ0BcqevTxdPKXLHBtt3HqZ1
         qY1XnXdj6ktQ2YcW2JT3G8Ek47DJvFkel753GR9XqySZ/o0TV38gu/rL+NUGOizN9BvY
         C0iRsW3SRdnPeqgAT1pd8L4YS/xvrkG3Qi1th4QjcxWTB8ieea0WM9ydEA9qEqIfF5DG
         FoAutCjdMHujKu3JX0Y22cjou/N4D6Y1zRPT64+iCZS8IwZYTjpuRqZMiqyIdeRXWiwX
         MeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5W2x8t68NoDAVIFeMr0BVtQdXxzEzVw8wanSKIA/+K4=;
        b=NsTnKg7TuJ+9X0aYgDtgi2sFp++XW1f8NlqxijAzIf226MyLXfH4XegwsRggqmKQlV
         tS+xsKRgFGJg7dL1T+6Cksu5T96tGokJ4Xid4DDCghrKqKJvE6+Al5250xl9/3Uj/loh
         gK4VcunJXCOmdperxAZHeZ0n4vNE59XfsTigG5cWRvE14yhU0oOtcGcSc2JE3QCAoFsZ
         9BION4tGq9vWGDXDxcfMnSIpXT/5g7UgUhb2s/tRam9WyA3CuvQvZKfF4EebshawYzm2
         BomJUY7gzPKT9YgorTWKqad+KLa81aRvDR+mQMTRPvvnIa/boestTaGj3uuDxRehl5Uv
         9GFg==
X-Gm-Message-State: AOAM532R/3ANNYdu/XZsRjIjnjxwgGn5Osh2mLsITNvKd4IPye74p/G1
        ka8br1sAMOKDoyPgxBfiaGU/mOGAfBw=
X-Google-Smtp-Source: ABdhPJyDI/BLh0E9HM5mo/5/TigaydoDfLHpzH23xAEbIPimHcLUetOenTEvS5PY3xABlWfh4UJ6wg==
X-Received: by 2002:a05:600c:1994:b0:38c:48dd:23ba with SMTP id t20-20020a05600c199400b0038c48dd23bamr5521722wmq.206.1648140697966;
        Thu, 24 Mar 2022 09:51:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm6721827wms.25.2022.03.24.09.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:36 -0700 (PDT)
Message-Id: <3f154d0251784436d1d90a2000cfc986df01f17f.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:05 +0000
Subject: [PATCH v4 12/27] fsm-listen-darwin: ignore FSEvents caused by xattr
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

