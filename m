Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C16AC1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 17:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbeHIUBV (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 16:01:21 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:45684 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbeHIUBV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 16:01:21 -0400
Received: by mail-pg1-f175.google.com with SMTP id f1-v6so3056206pgq.12
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jvj6Drfa2IxuzhoybmZszgLpFX9SMLU8PVp5tostdEA=;
        b=sObjmMULQDWdL08c3R3E0NkJ+apiqceVi2s5E/u80ApJeblQIMBTfluoL+kLUgD2pC
         11ggSSWTDcs2hUmMV7AfENEtrAT6f/Fgj7jo6gyAlSBhzkHlees+pnivgKxgtmaWxXto
         gbuS6RxzggUBwEXibSyIpAOIcMAoKvH07IwwwiuIuJPD6v4E5ARzZv+NpLvi28emzREn
         hB0yY8J8VcWPoms3wpKEsIc0N3YGrfxUbK1zEoIKAkkevfGKht95GwtTcGhVZg2eLwOC
         OeOf24z7dPA727HvhbJR8nRihNGh1KckcUAkP3DAsMGxbODSnPJM7LsicWLvXSGyt2nM
         tjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jvj6Drfa2IxuzhoybmZszgLpFX9SMLU8PVp5tostdEA=;
        b=CfaYM9W/Uubjr8y45/4/zKXUV5MMzxqvv/GETC+7ybsp30CRnE4oFm979bG+PWivUz
         KK+WVlHQ5BqEabO+1IcgyH3phnre2MSjl/e+owEuiSeBSWfSII2G59UqvbIcEfC7nwlw
         Br33gpaFsRVV6pIN64BoZSAaAWgmK0lz8W9oq+opbq0TWnXP1/x3DtBcL8KhPlem6VFR
         Y3HvPWwjCdGaNZK1/u1gu1k3zf9duuiPHoMXorq/ySQDrTxtxj6dc/CsTapMHVAABs+i
         cYruA/2ZvFlaKdI7sUa1BALfgQoQYjVh0fCgd62dxVBa2H6lKfhGwdzPDahcMA9QanOh
         aR0w==
X-Gm-Message-State: AOUpUlFhjeSG6oigABtKLSDAC8FwPMAF8AP00EQzSmcKIgeWI9XRz7/1
        /TV7cxOBUkAnJ0Z4LDH9Rz8fmrBg
X-Google-Smtp-Source: AA+uWPxkB9qHnhkVocJd8IO2AkNQGRH4BIuZlryhI4W0aE9wXoa5vMU84YBZnpZ27I9BqF3HR8GUhw==
X-Received: by 2002:a62:198e:: with SMTP id 136-v6mr3366069pfz.103.1533836127961;
        Thu, 09 Aug 2018 10:35:27 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id v22-v6sm19816171pfi.60.2018.08.09.10.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:35:27 -0700 (PDT)
Date:   Thu, 09 Aug 2018 10:35:27 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Aug 2018 17:35:19 GMT
Message-Id: <8dda2d5303952306520bc90c2cf2b25b83fdd31a.1533836122.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.17.git.gitgitgadget@gmail.com>
References: <pull.17.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/4] mingw: implement lock_or_unlock_fd_for_appending()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

For some reason, t/t5552-skipping-fetch-negotiator.sh fails particularly
often on Windows due to racy tracing where the `git upload-pack` and the
`git fetch` processes compete for the same file.

We just introduced a remedy that uses fcntl(), but Windows does not have
fcntl(). So let's implement an alternative.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c   | 19 +++++++++++++++++++
 compat/mingw.h   |  3 +++
 config.mak.uname |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6ded1c859..6da9ce861 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -514,6 +514,25 @@ int mingw_chmod(const char *filename, int mode)
 	return _wchmod(wfilename, mode);
 }
 
+int mingw_lock_or_unlock_fd_for_appending(int fd, int lock_it)
+{
+	HANDLE handle = (HANDLE)_get_osfhandle(fd);
+	OVERLAPPED overlapped = { 0 };
+	DWORD err;
+
+	if (!lock_it && UnlockFileEx(handle, 0, -1, 0, &overlapped))
+		return 0;
+	if (lock_it &&
+	    LockFileEx(handle, LOCKFILE_EXCLUSIVE_LOCK, 0, -1, 0, &overlapped))
+		return 0;
+
+	err = GetLastError();
+	/* LockFileEx() cannot lock pipes */
+	errno = err == ERROR_INVALID_FUNCTION ?
+		EBADF : err_win_to_posix(GetLastError());
+	return -1;
+}
+
 /*
  * The unit of FILETIME is 100-nanoseconds since January 1, 1601, UTC.
  * Returns the 100-nanoseconds ("hekto nanoseconds") since the epoch.
diff --git a/compat/mingw.h b/compat/mingw.h
index 571019d0b..0f76d89a9 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -397,6 +397,9 @@ HANDLE winansi_get_osfhandle(int fd);
  * git specific compatibility
  */
 
+int mingw_lock_or_unlock_fd_for_appending(int fd, int lock_it);
+#define lock_or_unlock_fd_for_appending mingw_lock_or_unlock_fd_for_appending
+
 #define has_dos_drive_prefix(path) \
 	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
 int mingw_skip_dos_drive_prefix(char **path);
diff --git a/config.mak.uname b/config.mak.uname
index 684fc5bf0..159b7da81 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -376,6 +376,7 @@ ifeq ($(uname_S),Windows)
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
+	HAVE_FLOCK = YesWeEmulate
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -523,6 +524,8 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
+	HAVE_FLOCK = YesWeEmulate
+
 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
-- 
gitgitgadget

