Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEF9C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiCASpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237042AbiCASoy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175706516A
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:50 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r10so21975088wrp.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CDWjf/n9UzLjzdXGySSp6qgLC/+A694jP9gMhCN6WGM=;
        b=DG2lkjBuylU7z65sLTb46Pkd2fzhM3VYLdVP3tcnRgQYDR2KxvdlkwnTjyJn8Eo4xU
         m3YL2QWDWY4xpli6gFHqhC101gYd53T/EEi5i5oPoo9xDgJ9cZVqH+506uClE5hh1nkn
         2jScwbw8ybFkrURMcZJ1hM/h5DjTrV520FEYt0Cq1R1aSnhPpUWXGlFr5LCZbCmSZYua
         QOCgtJfHgVj2xwuZlxpV025C3LoI1M/kv/s67itZ47ddi4oq4i8JwDuKFR6vsgh5JpGR
         iEB3AiMDpKOuohDW8TmpOqL3eGLNXEeTe18TZUyBCVo/rt15v6r45rBIO7dB1XfytA1A
         kw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CDWjf/n9UzLjzdXGySSp6qgLC/+A694jP9gMhCN6WGM=;
        b=HMQS9fIesOHUlZXYEohtbMIaYoFR+IyG7A7RVPAlf+NjQTs3850FloDMfNFxFGLN2c
         /7/tleUI5Gy+1LjHx/1uSnxP+JfBFpn7h/umxja3FeDROC4tmJvVYVrSQlqJhug5imvi
         QLI1nUxJreHLlhOOtNrGnIO7+sv/KxtV7/YIyCwPC0IPyz5uMGcHhjvgz0lRo8FfckSE
         axbjJ9r/hBgvb3zKxVVloOTxq/xtHXbJ8lpFvylRF5GX2wS3I1bqSY9yGJkNXRR4kfdK
         QoerBuXUyRN1GZt5ut8+Qtrp8GDC+1XKTP1361Z1OPHdXoqxNeQetKwzHcajNznqdAnA
         UMzg==
X-Gm-Message-State: AOAM531mWmhEnJYHaZFI6n3DGGcImUbdhCskV6Wc5tSkQpmq26gnNtuW
        EStWerNflj4q/EehYAxkvY5OIq4qz7k=
X-Google-Smtp-Source: ABdhPJx2WHNSu4/OCblBL0cK2ApDZCbhf60FdJjQJp6NeET8+iirluaFgLqlKGFcKp94hTzGzZrvEw==
X-Received: by 2002:a5d:43c2:0:b0:1ed:c331:9a96 with SMTP id v2-20020a5d43c2000000b001edc3319a96mr21766788wrr.389.1646160228405;
        Tue, 01 Mar 2022 10:43:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0037d62a899b1sm3475936wmq.6.2022.03.01.10.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:47 -0800 (PST)
Message-Id: <cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:18 +0000
Subject: [PATCH v6 16/30] compat/fsmonitor/fsm-listen-darwin: add MacOS header
 files for FSEvent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Include MacOS system declarations to allow us to use FSEvent and
CoreFoundation APIs.  We need different versions of the declarations
for GCC vs. clang because of compiler and header file conflicts.

While it is quite possible to #include Apple's CoreServices.h when
compiling C source code with clang, trying to build it with GCC
currently fails with this error:

In file included
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
   ...Library/Frameworks/Security.framework/Headers/AuthSession.h:32,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
   ...Library/Frameworks/Security.framework/Headers/Security.h:42,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
   ...Library/Frameworks/CoreServices.framework/Frameworks/...
   ...OSServices.framework/Headers/CSIdentity.h:43,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
   ...Library/Frameworks/CoreServices.framework/Frameworks/...
   ...OSServices.framework/Headers/OSServices.h:29,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
   ...Library/Frameworks/CoreServices.framework/Frameworks/...
   ...LaunchServices.framework/Headers/IconsCore.h:23,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
   ...Library/Frameworks/CoreServices.framework/Frameworks/...
   ...LaunchServices.framework/Headers/LaunchServices.h:23,
   from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
   ...Library/Frameworks/CoreServices.framework/Headers/CoreServices.h:45,

     /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
     ...Library/Frameworks/Security.framework/Headers/Authorization.h:193:7:
     error: variably modified 'bytes' at file scope
       193 | char bytes[kAuthorizationExternalFormLength];
           |      ^~~~~

The underlying reason is that GCC (rightfully) objects that an `enum`
value such as `kAuthorizationExternalFormLength` is not a constant
(because it is not, the preprocessor has no knowledge of it, only the
actual C compiler does) and can therefore not be used to define the size
of a C array.

This is a known problem and tracked in GCC's bug tracker:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93082

In the meantime, let's not block things and go the slightly ugly route
of declaring/defining the FSEvents constants, data structures and
functions that we need, so that we can avoid above-mentioned issue.

Let's do this _only_ for GCC, though, so that the CI/PR builds (which
build both with clang and with GCC) can guarantee that we _are_ using
the correct data types.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 96 ++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index c84e3344ab9..f76341317dd 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -1,3 +1,99 @@
+#ifndef __clang__
+/*
+ * It is possible to #include CoreFoundation/CoreFoundation.h when compiling
+ * with clang, but not with GCC as of time of writing.
+ *
+ * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93082 for details.
+ */
+typedef unsigned int FSEventStreamCreateFlags;
+#define kFSEventStreamEventFlagNone               0x00000000
+#define kFSEventStreamEventFlagMustScanSubDirs    0x00000001
+#define kFSEventStreamEventFlagUserDropped        0x00000002
+#define kFSEventStreamEventFlagKernelDropped      0x00000004
+#define kFSEventStreamEventFlagEventIdsWrapped    0x00000008
+#define kFSEventStreamEventFlagHistoryDone        0x00000010
+#define kFSEventStreamEventFlagRootChanged        0x00000020
+#define kFSEventStreamEventFlagMount              0x00000040
+#define kFSEventStreamEventFlagUnmount            0x00000080
+#define kFSEventStreamEventFlagItemCreated        0x00000100
+#define kFSEventStreamEventFlagItemRemoved        0x00000200
+#define kFSEventStreamEventFlagItemInodeMetaMod   0x00000400
+#define kFSEventStreamEventFlagItemRenamed        0x00000800
+#define kFSEventStreamEventFlagItemModified       0x00001000
+#define kFSEventStreamEventFlagItemFinderInfoMod  0x00002000
+#define kFSEventStreamEventFlagItemChangeOwner    0x00004000
+#define kFSEventStreamEventFlagItemXattrMod       0x00008000
+#define kFSEventStreamEventFlagItemIsFile         0x00010000
+#define kFSEventStreamEventFlagItemIsDir          0x00020000
+#define kFSEventStreamEventFlagItemIsSymlink      0x00040000
+#define kFSEventStreamEventFlagOwnEvent           0x00080000
+#define kFSEventStreamEventFlagItemIsHardlink     0x00100000
+#define kFSEventStreamEventFlagItemIsLastHardlink 0x00200000
+#define kFSEventStreamEventFlagItemCloned         0x00400000
+
+typedef struct __FSEventStream *FSEventStreamRef;
+typedef const FSEventStreamRef ConstFSEventStreamRef;
+
+typedef unsigned int CFStringEncoding;
+#define kCFStringEncodingUTF8 0x08000100
+
+typedef const struct __CFString *CFStringRef;
+typedef const struct __CFArray *CFArrayRef;
+typedef const struct __CFRunLoop *CFRunLoopRef;
+
+struct FSEventStreamContext {
+    long long version;
+    void *cb_data, *retain, *release, *copy_description;
+};
+
+typedef struct FSEventStreamContext FSEventStreamContext;
+typedef unsigned int FSEventStreamEventFlags;
+#define kFSEventStreamCreateFlagNoDefer 0x02
+#define kFSEventStreamCreateFlagWatchRoot 0x04
+#define kFSEventStreamCreateFlagFileEvents 0x10
+
+typedef unsigned long long FSEventStreamEventId;
+#define kFSEventStreamEventIdSinceNow 0xFFFFFFFFFFFFFFFFULL
+
+typedef void (*FSEventStreamCallback)(ConstFSEventStreamRef streamRef,
+				      void *context,
+				      __SIZE_TYPE__ num_of_events,
+				      void *event_paths,
+				      const FSEventStreamEventFlags event_flags[],
+				      const FSEventStreamEventId event_ids[]);
+typedef double CFTimeInterval;
+FSEventStreamRef FSEventStreamCreate(void *allocator,
+				     FSEventStreamCallback callback,
+				     FSEventStreamContext *context,
+				     CFArrayRef paths_to_watch,
+				     FSEventStreamEventId since_when,
+				     CFTimeInterval latency,
+				     FSEventStreamCreateFlags flags);
+CFStringRef CFStringCreateWithCString(void *allocator, const char *string,
+				      CFStringEncoding encoding);
+CFArrayRef CFArrayCreate(void *allocator, const void **items, long long count,
+			 void *callbacks);
+void CFRunLoopRun(void);
+void CFRunLoopStop(CFRunLoopRef run_loop);
+CFRunLoopRef CFRunLoopGetCurrent(void);
+extern CFStringRef kCFRunLoopDefaultMode;
+void FSEventStreamScheduleWithRunLoop(FSEventStreamRef stream,
+				      CFRunLoopRef run_loop,
+				      CFStringRef run_loop_mode);
+unsigned char FSEventStreamStart(FSEventStreamRef stream);
+void FSEventStreamStop(FSEventStreamRef stream);
+void FSEventStreamInvalidate(FSEventStreamRef stream);
+void FSEventStreamRelease(FSEventStreamRef stream);
+#else
+/*
+ * Let Apple's headers declare `isalnum()` first, before
+ * Git's headers override it via a constant
+ */
+#include <string.h>
+#include <CoreFoundation/CoreFoundation.h>
+#include <CoreServices/CoreServices.h>
+#endif
+
 #include "cache.h"
 #include "fsmonitor.h"
 #include "fsm-listen.h"
-- 
gitgitgadget

