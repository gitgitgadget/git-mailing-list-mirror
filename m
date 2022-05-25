Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA99AC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245028AbiEYPBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244998AbiEYPBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361E9AFAD2
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v4-20020a1cac04000000b00397001398c0so1256931wme.5
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5W2x8t68NoDAVIFeMr0BVtQdXxzEzVw8wanSKIA/+K4=;
        b=owW9lhpzojtIW6IA41gTlSNAHl9jkYIjraTAfVilvUwih9fDyMBRXbtETrBhc/90KR
         ELs7wbWr4RmQYGIULCAqNgqvRu+iRS9QxIm+PBLSPU2/6/bxD7DaUsykR2Nr1nCDvCfQ
         jfzia9dMpj09vq0iefPktZmOBpNU3jVtAuVt1gSHCPFj+OxPGUKmw9VtA9DhcFfi+QF6
         BAS1CZEGd81IEjbDT0ks5c6ZpE9fkGP+BBc3SJf/tQmLM2nOdyFUsGZMce+KsFVNHJzJ
         gJjCg6Ty4/FM2PHBriEH3Aso78H8PT5TgIsLvTfolkJ1qzfL9poTiz1sk6Qn5bw/+kQG
         OxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5W2x8t68NoDAVIFeMr0BVtQdXxzEzVw8wanSKIA/+K4=;
        b=tGY0xQFYIeHyIL6ADAwbpubU+LdA4mY/ecNhoLAHOYk5R8KEIVp5gFT+eSiZqW3Ixj
         ilW4DDJc8RrtEsEkE7Z3ifAD/JbN5YXKqSyxd2pnRHXm+3FvEtVhv9pIYjSfcRYGw7yj
         KFOMgH0sAHaghcTWM97CmeCfLXUxQHo3D1R0TGLjKUop+rJF0Q9LkQ1dWfyQXXoRsG+Z
         VomDnFJ0asJymJFltZfdnDt7RR0yJEg+Gvt+dJDZZ+14Ee/amJNdcK6xDBRyqDeKwlm8
         sW5pmMGnFm3k33pErPLxwCnJLoHSes81sKUgaOohIdHxEnT/LYdNLA8kB/70Rt5nqzJb
         nk+g==
X-Gm-Message-State: AOAM530kqLr42/Pl1IyLgTSVewMBmim5T7ofW5PY+kZchJ17hN/w7Rxj
        8V/pgPk9WBZHdai4ZLQ7I+P9hBI1rUE=
X-Google-Smtp-Source: ABdhPJzwbN8Iu+VHnOm/GSPXWpsGxVERYIqzBGLCXT0F64W6uxOVRlEmtcdGV0Ks/SIjpAauMg6GtA==
X-Received: by 2002:a7b:c4d2:0:b0:397:6403:702c with SMTP id g18-20020a7bc4d2000000b003976403702cmr5917640wmk.58.1653490874398;
        Wed, 25 May 2022 08:01:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q21-20020a1ce915000000b0039768532c79sm2362183wmc.6.2022.05.25.08.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:13 -0700 (PDT)
Message-Id: <4f2b15d3d1f10eaec8e485b84281eb4cca207a69.1653490852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:34 +0000
Subject: [PATCH v8 12/30] fsm-listen-darwin: ignore FSEvents caused by xattr
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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

