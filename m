Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAA6C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbiCVSC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbiCVSCS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:02:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C2C66FB9
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o30-20020a05600c511e00b0038c9cfb79cbso1924710wms.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fAa8hrpVrno1BmdEVVVe0xU+KaqvnFCI1tVOqmc3Cac=;
        b=bQu8NwZvlnpd6eFlaU4PlT+pDH1NYf3KBkirE1BOKwhcgiNq1oFmxn2R1q8E7T2WyN
         jqcHjQIkCY05dHFoGnCCivP5XtSZf5q2Da7Qc6q5zBlublh77lQfqD6ml1JL84c+pWdL
         lI5F5DsM/n0sljWUP1w5Ut0UEcaOhglL6tG3Xnam9GqsmCVp2xOmJ+3KBMuF/bXnisje
         uGWOASyt4ocyXjm4sjOYHzuXwYOZV4ZBWKMPKGZSdpjfYKqQpaN4s/k/wTA+/v4ZXDAn
         qpEHAo7yDBynHA7u+OUT8tReg4i97jyFzbXWLROnx1HdcC26Hzd4iPYsTpDK2tA+t0eA
         x3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fAa8hrpVrno1BmdEVVVe0xU+KaqvnFCI1tVOqmc3Cac=;
        b=udYmV/Th2D/DvFz5F6UkgUPvrEhJHarWt8heOXxiHi9UI3y0M/jdKg2vqwBEWjAEj3
         h3OcN4HeBQ8KdKJHv3TY54hUrYmBDD6lfcCMSfF2bzSYggeE6z/aSNEsdfk0C/t+AmkA
         bcGz2D1LPXn7g5ufeRxn5P2v7NfPdF3tXaTlBN2iUaQKAmQNxoroS+4/Fe5AiUWp4t28
         VKg7B0R+l552vqIU1wMnS8rveOlMWCUd8+fyYM/a+GeYwwDyQ0KeMXZiUOa5zbRSvHHr
         GvxalggW0OoBsV1Kongg90O+u69qybTIdoSBa27aIRkbTC0WHs3+/HchByiKaySoLY1z
         jY+g==
X-Gm-Message-State: AOAM53098IakCFsQhJlj3zp/gc2YeZX1fVPke/A8BbuXXwMJFhLQwZ0B
        5e8Y2WS8jyZlkiXE8vGk79r9ipAZkgM=
X-Google-Smtp-Source: ABdhPJyIF14eqBD9hhmc6n+B4ShXwdmWt5qqQsBAppTcL62TdQ9p4nJeEMgzyXnIPcpFip5HP946sQ==
X-Received: by 2002:a7b:cd01:0:b0:38c:9142:2006 with SMTP id f1-20020a7bcd01000000b0038c91422006mr5133584wmj.4.1647972039751;
        Tue, 22 Mar 2022 11:00:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600018af00b002057c72d45fsm2151058wri.77.2022.03.22.11.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:38 -0700 (PDT)
Message-Id: <14b775e9d8b1a4672f8175a546eb70e2790c1b23.1647972010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:59:57 +0000
Subject: [PATCH v7 16/29] compat/fsmonitor/fsm-listen-darwin: add MacOS header
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
 compat/fsmonitor/fsm-darwin-gcc.h    | 92 ++++++++++++++++++++++++++++
 compat/fsmonitor/fsm-listen-darwin.c | 24 ++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-darwin-gcc.h

diff --git a/compat/fsmonitor/fsm-darwin-gcc.h b/compat/fsmonitor/fsm-darwin-gcc.h
new file mode 100644
index 00000000000..1c75c3d48e7
--- /dev/null
+++ b/compat/fsmonitor/fsm-darwin-gcc.h
@@ -0,0 +1,92 @@
+#ifndef FSM_DARWIN_GCC_H
+#define FSM_DARWIN_GCC_H
+
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
+
+#endif /* !clang */
+#endif /* FSM_DARWIN_GCC_H */
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index c84e3344ab9..d2ce942cade 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -1,3 +1,27 @@
+#ifndef __clang__
+#include "fsm-darwin-gcc.h"
+#else
+#include <CoreFoundation/CoreFoundation.h>
+#include <CoreServices/CoreServices.h>
+
+#ifndef AVAILABLE_MAC_OS_X_VERSION_10_13_AND_LATER
+/*
+ * This enum value was added in 10.13 to:
+ *
+ * /Applications/Xcode.app/Contents/Developer/Platforms/ \
+ *    MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/ \
+ *    Library/Frameworks/CoreServices.framework/Frameworks/ \
+ *    FSEvents.framework/Versions/Current/Headers/FSEvents.h
+ *
+ * If we're compiling against an older SDK, this symbol won't be
+ * present.  Silently define it here so that we don't have to ifdef
+ * the logging or masking below.  This should be harmless since older
+ * versions of macOS won't ever emit this FS event anyway.
+ */
+#define kFSEventStreamEventFlagItemCloned         0x00400000
+#endif
+#endif
+
 #include "cache.h"
 #include "fsmonitor.h"
 #include "fsm-listen.h"
-- 
gitgitgadget

