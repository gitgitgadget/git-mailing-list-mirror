Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B54C4332F
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 23:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F064261251
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 23:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344792AbhIXXzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 19:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbhIXXzH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 19:55:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2FC061613
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 16:53:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i23so32161013wrb.2
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 16:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fv7nQ5ZUwa4uFFNumJcqLSj/tyOInbTAFP+n8tQn3ko=;
        b=aIfeNeqMdPVOWuzbxF8Xf5LIw6D7g8pQZTXhuovtlFi9xpyHgfPCOBxSrvjUZvyDkM
         3eYd5rmaCkxLpT3B0La1UjwDaw+HFpXMALNU8/F4Bs1fPOlUfvqdzOMQZSBA4YHXsXS0
         aQb7a/YzaK8lgTOxVj3+gHipc15adL4T+OlAa4tPu5FCDV+Hs4+vE4JfQ1Da2LW0TUDO
         hIecmTxDWDaKydFw4UufOJZAe/YUsVS4QrQMFRAtSxxczDN1JhnaPZnky1KmUaN+xdV8
         4nunAPmDBd4VNGeKwcVHlotqaxLRfxd6nyVOIPFA2ldl5dLrJkDYdFqiUP15beG7lTlX
         RXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fv7nQ5ZUwa4uFFNumJcqLSj/tyOInbTAFP+n8tQn3ko=;
        b=XoiDpkqjeJeI8roqcOIdYOe4s2iMy2Sy1RFSxJnKzt63CZ+ZwWjw04nDaMxiEQ4IbW
         9+iDyTWssS65X7hfpYX+JNH0a4t5Dd2n2sKAi6+EMJlYdvUfKKxCkc7x5Rz+PFrVUF1m
         hgQMixZZ1f6OuFS4Y+INug7sDCYm70eaP8rPecu27/V5lafOGOgc79nSyyDXu8IDGCXB
         W5pRiBr/0WK2KeZj05I2s9ycKNpbq7O4APBei28CrfPhhEj2iR6bkXbEA0LA3krGyQ5J
         yVhYK0hSsAdCiNKcBC47Y+ldtoclheY5PjhfT1Qmon4j4v/3JcdfA2sky2UFAVthXzWz
         A13w==
X-Gm-Message-State: AOAM532b8nKynUh0QZQD069EK6T78g6zALsCrENuNLjPN7ENMkShhTSA
        eJ4qJi9M3S98XzuR7M5BWAvGAKAUUR4=
X-Google-Smtp-Source: ABdhPJxbE2C+/3ZDwoIUeLCzC0CJPSx9BJ/zWAn8TreAuY2PWqbbjFJyCrmtN17frCZM+YA9PCdBmg==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr14067541wrs.271.1632527612555;
        Fri, 24 Sep 2021 16:53:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c185sm10344243wma.8.2021.09.24.16.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 16:53:32 -0700 (PDT)
Message-Id: <bdb99822f8c45a8b2855ee2ab38c4460e4b5e22e.1632527609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
References: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
        <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 23:53:25 +0000
Subject: [PATCH v6 4/8] core.fsyncobjectfiles: add windows support for batch
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
index e6d482fbcc6..34c93314a50 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -451,6 +451,7 @@ endif
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
+		compat/win32/flush.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/trace2_win32_process_info.o \
@@ -626,6 +627,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/trace2_win32_process_info.o \
+		compat/win32/flush.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 171b4124afe..b573a5ee122 100644
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
index bb4f9f043ce..1a1e2fba9c9 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -567,6 +567,10 @@ int git_fsync(int fd, enum fsync_action action)
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

