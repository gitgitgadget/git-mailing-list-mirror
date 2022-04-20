Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFF3C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382183AbiDTUrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382155AbiDTUqq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:46 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE22443C8
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso2027769wml.5
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m/7nmjzQrPWZOZRTUqvWzqRTYtxoxcBSCt/eY/PHK+w=;
        b=mMJXyEUuS00nmY1CyshN87S7duWHDwwpL0R1m1nhDHrnicveQZYw1hYHDvzFQ9zdXY
         LzeG4yLAeLEBaIXzJTDzAVMDY48nWbMKZZ+L0idB0pUMB2s5WKjwzN0UxyzdW8UHECjp
         h3qZ/v+aX+R7jv4SWFi6FQwAyjqPujQwAtV3Zzr3dAkXrAk0zOeCGyUjtBDpe3nRc8ev
         c+bNZdIlYvKort9qlIE+PoIB1pwoPtWeViaDeFd9UErvIlSoQ5q6CiRCBXhmpRz8FOSX
         Zsvxt7DE6TWEGCfLTOai6glGceCcm587Y9CSvxKYGDHmgWSLDYB3PINJI1puMVnhHgwx
         pjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m/7nmjzQrPWZOZRTUqvWzqRTYtxoxcBSCt/eY/PHK+w=;
        b=ffaSZhhlCBeH3jvZldCHcyytymJ1Aa75wM9W69wfN6jr8OxmKvIhMcJ2pgrgjDN2xd
         B736GsiqKZLUdir8zGib8FkxpQ0SZTDNy+uQD8yYoD9ZfxV13DtyF9aUWnuHbmygSsGn
         wfJ3SnaIKbSTjY0Cg9o1NnZVWi71vomcTtG3/RJ8xtwfLg5cvA0lHAyO3mnvTfFN1o1E
         7FJIsj6LZtQ4stMfsW1e5OUvmUNVZEf1rwdg9zzVs1iz7PZhnMTRyEzN4Rdw9S74mvb9
         QZYnyE0QgGZYHMMetWChDcOPE5AW0JYNMhz1KpndkrKVPo+w34wIdl1tXug9I9sl4eYb
         /H7Q==
X-Gm-Message-State: AOAM530R/r4tCGu3w6HssKpjTQtilGMUGVahoMQqLsvthjKczlYPeAnd
        mV+s0Z3Bv0F3sTXBC2qR+dQABYg0Mps=
X-Google-Smtp-Source: ABdhPJzjRwYfWAEE4VXGH007qIhQvaYPIuVNvTHrVoCqnytBOHhIfdRbK+ZlKzicQajnpWeS0hXjZw==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr5455425wmh.21.1650487425435;
        Wed, 20 Apr 2022 13:43:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k23-20020adfb357000000b0020ab724ceb8sm747133wrd.54.2022.04.20.13.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:44 -0700 (PDT)
Message-Id: <f1365cdd40cd625433ba5494b8f590e31f34a944.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:43:09 +0000
Subject: [PATCH v5 19/28] fsm-listen-darwin: shutdown daemon if worktree root
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

