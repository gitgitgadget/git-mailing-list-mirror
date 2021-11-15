Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FA8C4332F
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A38761B66
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345143AbhKPD1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbhKPD0X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 22:26:23 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399BAC126D02
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:10 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso542047wml.1
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RRVKUU/CDTvLO/mF2IPKnCbu1AteNB3iWsrxuugjmSU=;
        b=luUCwaXOHOJqwoVH4z6Qj2FgVX6Vz4OV0Kvl19xZGKR8Tlm/cma5ecMEKyOG/FNW1g
         9RwKeIxMW0S046pju33m744gz+evVvxs+YXz6hDVvbw+RGuZZSB1t7aVTJe5IYFC88C5
         gAxdQJS8G2+e2+N6dhrrN6HchWj/hx/hGD30JO1bBor5rPUiVZiEzfCJirmS3C5teUPT
         PVsTDQ+RnsMyqjx1GgF3ykmSbSdM0BRNuSWZ72VZr0Xhy8110iNz1Fs+MAxpK0YCqox8
         f0HTRgzKvSEgJ6TRl3W260KgbXTPdlObFtfIpMmagcfdByO5vokIFPsQtTw9vt6FfX0h
         J2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RRVKUU/CDTvLO/mF2IPKnCbu1AteNB3iWsrxuugjmSU=;
        b=x0OFKnSCnuxABPNFD3Xo/pZ9DRKIJwBTM3oh5Tyc54JgpaMpAVJlP3mLablPOh1g3g
         OY77MYuc8vOPb+ubZfEyIRBiB6u3RrTzuNTMw34cnzkw4CCNH/9Q/iBm7FEj2VQ6EP/6
         mh2m1+YFlH0nGhoVXMSofyn92mx1UC3BbBWo5BVHmePqLjcccPRZP+FPIExzp9rftqgm
         Ydgj6xxhp8Lr3ZbMGzPH+Yr1sXNWOlErLuHtymPrzliGlauURv2KpQoCeo7T+Z/hCf6w
         yOXslyb62PkY1RCWa5guZHrprrbmioKpxU2QOKPEWE6iVmNZePTaTWJE8jgIJqySSxXr
         qRug==
X-Gm-Message-State: AOAM533LDJSpLxUb5bH9UWmZDou32ICgAnJq/9UysP4Nd8pRnRdFl8ea
        ja5eu9/ouaQnHsRUCS6fA+hqXHJJeM8=
X-Google-Smtp-Source: ABdhPJwfkjmT1jD29SbsmNJHi562S/UhAmPMH7eHUGCZ+DU8LzdaQiK+wKHuNwiaK84Gv2DafDA1yg==
X-Received: by 2002:a1c:96:: with SMTP id 144mr11113156wma.126.1637020268695;
        Mon, 15 Nov 2021 15:51:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm1016435wmf.2.2021.11.15.15.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 15:51:08 -0800 (PST)
Message-Id: <951a559874e3e76c85e98d24c457e81a65de76e4.1637020263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
        <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Nov 2021 23:50:59 +0000
Subject: [PATCH v9 5/9] core.fsyncobjectfiles: add windows support for batch
 mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

This commit adds a win32 implementation for fsync_no_flush that is
called git_fsync. The 'NtFlushBuffersFileEx' function being called is
available since Windows 8. If the function is not available, we
return -1 and Git falls back to doing a full fsync.

The operating system is told to flush data only without a hardware
flush primitive. A later full fsync will cause the metadata log
to be flushed and then the disk cache to be flushed on NTFS and
ReFS. Other filesystems will treat this as a full flush operation.

I added a new file here for this system call so as not to conflict with
downstream changes in the git-for-windows repository related to fscache.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 compat/mingw.h                      |  3 +++
 compat/win32/flush.c                | 28 ++++++++++++++++++++++++++++
 config.mak.uname                    |  2 ++
 contrib/buildsystems/CMakeLists.txt |  3 ++-
 wrapper.c                           |  4 ++++
 5 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 compat/win32/flush.c

diff --git a/compat/mingw.h b/compat/mingw.h
index c9a52ad64a6..6074a3d3ced 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -329,6 +329,9 @@ int mingw_getpagesize(void);
 #define getpagesize mingw_getpagesize
 #endif
 
+int win32_fsync_no_flush(int fd);
+#define fsync_no_flush win32_fsync_no_flush
+
 struct rlimit {
 	unsigned int rlim_cur;
 };
diff --git a/compat/win32/flush.c b/compat/win32/flush.c
new file mode 100644
index 00000000000..75324c24ee7
--- /dev/null
+++ b/compat/win32/flush.c
@@ -0,0 +1,28 @@
+#include "../../git-compat-util.h"
+#include <winternl.h>
+#include "lazyload.h"
+
+int win32_fsync_no_flush(int fd)
+{
+       IO_STATUS_BLOCK io_status;
+
+#define FLUSH_FLAGS_FILE_DATA_ONLY 1
+
+       DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NtFlushBuffersFileEx,
+			 HANDLE FileHandle, ULONG Flags, PVOID Parameters, ULONG ParameterSize,
+			 PIO_STATUS_BLOCK IoStatusBlock);
+
+       if (!INIT_PROC_ADDR(NtFlushBuffersFileEx)) {
+		errno = ENOSYS;
+		return -1;
+       }
+
+       memset(&io_status, 0, sizeof(io_status));
+       if (NtFlushBuffersFileEx((HANDLE)_get_osfhandle(fd), FLUSH_FLAGS_FILE_DATA_ONLY,
+				NULL, 0, &io_status)) {
+		errno = EINVAL;
+		return -1;
+       }
+
+       return 0;
+}
diff --git a/config.mak.uname b/config.mak.uname
index 5ead1377667..5727fb093ca 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -455,6 +455,7 @@ endif
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
+		compat/win32/flush.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/trace2_win32_process_info.o \
@@ -630,6 +631,7 @@ ifeq ($(uname_S),MINGW)
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/trace2_win32_process_info.o \
+		compat/win32/flush.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index fd1399c440f..ef0c1e4976d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -261,7 +261,8 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
 				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
 				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET)
-	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat/win32/path-utils.c
+	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c
+		compat/win32/flush.c compat/win32/path-utils.c
 		compat/win32/pthread.c compat/win32mmap.c compat/win32/syslog.c
 		compat/win32/trace2_win32_process_info.c compat/win32/dirent.c
 		compat/nedmalloc/nedmalloc.c compat/strdup.c)
diff --git a/wrapper.c b/wrapper.c
index 689288d2e31..ece3d2ca106 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -573,6 +573,10 @@ int git_fsync(int fd, enum fsync_action action)
 						 SYNC_FILE_RANGE_WAIT_AFTER);
 #endif
 
+#ifdef fsync_no_flush
+		return fsync_no_flush(fd);
+#endif
+
 		errno = ENOSYS;
 		return -1;
 
-- 
gitgitgadget

