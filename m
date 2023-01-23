Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF09C38142
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 16:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjAWQgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 11:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjAWQgo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 11:36:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCE42BEC7
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 08:36:39 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so11059836wmb.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 08:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vcw0YGiPy6dpVwZY6zm31k1ZkvDdFwSvm+eCt9LX9ZU=;
        b=Cj/7bhxVqvkAr6KcaBUHzxklBpzRqzY4kCX3ZzgyIj751q2XFA1cRY15jHGjYRaJSz
         b0T1xhwGrys5381YNDQX46JtTjG4x34RxEQ7FOb8CBFuTxJAWJoMsgyUGGqLqXk5rSou
         VDX7AVDmMm0xPTK2z4lUhQtZ81Tkln0sFHH2PtZsUL1rTA/ZaijvlUM7BnEXrhiZ6A9l
         vzg8IVlC7zY9OMI5yaghFMkNgqcPMHfRVGWqvVFMv4B42rTj17QZe5x1rSqYZw65L7ZA
         x8adMCpjZ2G0NzCOBtJnPe6B9K1ufNEIWFR/wdoD/BBYtdfFoyWfjHDjnKYEpstkr3Gx
         3z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vcw0YGiPy6dpVwZY6zm31k1ZkvDdFwSvm+eCt9LX9ZU=;
        b=lflgN1bb9s33CosrQs+S1MHUjwZCsUTIftuVA40QAnepkhZIqSqb0+Dx7itIAfZygE
         DIs4+XVDxIkg/cJPwXLtBPZDuFJl/bN0Vmz/h9zZPwnGJu5FtD3IttKJe61AuxjgTxu5
         F2hE6WoIK40a4BCk9vMYpiBjffN9vTFq8iO13yCu/+/7ef89oe93N8+L1u5rMtGYVShD
         gJmaYxHANFMR8GZ0Jx3PJUKpJNQOwnuj9lj1jZvcTcE6Rn7GoGJZjK3hkh7syFhaEcMz
         5b8/1MmTHHFizSJfZhvpbbdci7kbJZ9bswBKBCVy58r1sTT0Oe2ds7tler1SvzLoTStr
         YgSA==
X-Gm-Message-State: AFqh2kpulF43eugPRiakzJRtEZ5sCmZ3nDMRbamJ/8M35Q3Yog+Oi8qy
        aDq/J/ckzS16vYaTuhXXte/dnpOKgzs=
X-Google-Smtp-Source: AMrXdXuBsbbJWtJPOqcBEfWCN4EpPUI5bL4T4OEqLKR6/WEVkDo4ri680cp7BmjoUdFevAptNKf57g==
X-Received: by 2002:a05:600c:a15:b0:3db:18a0:310f with SMTP id z21-20020a05600c0a1500b003db18a0310fmr19070485wmp.33.1674491797942;
        Mon, 23 Jan 2023 08:36:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p25-20020a1c7419000000b003d9f14e9085sm10886188wmc.17.2023.01.23.08.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 08:36:37 -0800 (PST)
Message-Id: <pull.1440.v2.git.git.1674491796648.gitgitgadget@gmail.com>
In-Reply-To: <pull.1440.git.git.1674334159116.gitgitgadget@gmail.com>
References: <pull.1440.git.git.1674334159116.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 16:36:36 +0000
Subject: [PATCH v2] win32: fix thread usage for win32
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Use _beginthreadex instead of CreateThread
since we use the Windows CRT.

Finally, check for NULL handles, not "INVALID_HANDLE,"
as _beginthreadex guarantees a valid handle in most cases

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: fix thread usage for win32
    
    Use pthread_exit instead of async_exit.
    
    This means we do not have to deal with Windows's implementation
    requiring an unsigned exit coded despite the POSIX exit code requiring a
    signed exit code.
    
    Use _beginthreadex instead of CreateThread since we use the Windows CRT.
    
    Finally, check for NULL handles, not "INVALID_HANDLE," as _beginthreadex
    guarantees a valid handle in most cases
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1440%2FAtariDreams%2FCreateThread-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1440/AtariDreams/CreateThread-v2
Pull-Request: https://github.com/git/git/pull/1440

Range-diff vs v1:

 1:  f5de6bfb759 ! 1:  4a2c3da9d4c win32: fix thread usage for win32
     @@ Metadata
       ## Commit message ##
          win32: fix thread usage for win32
      
     -    Use pthread_exit instead of async_exit.
     -
     -    This means we do not have
     -    to deal with Windows's implementation
     -    requiring an unsigned exit coded
     -    despite the POSIX exit code requiring
     -    a signed exit code.
     -
          Use _beginthreadex instead of CreateThread
          since we use the Windows CRT.
      
     @@ compat/winansi.c: void winansi_init(void)
       
       	/* schedule cleanup routine */
       	if (atexit(winansi_exit))
     -
     - ## run-command.c ##
     -@@ run-command.c: static void *run_thread(void *data)
     - 	return (void *)ret;
     - }
     - 
     -+int in_async(void)
     -+{
     -+	if (!main_thread_set)
     -+		return 0; /* no asyncs started yet */
     -+	return !pthread_equal(main_thread, pthread_self());
     -+}
     -+
     - static NORETURN void die_async(const char *err, va_list params)
     - {
     - 	report_fn die_message_fn = get_die_message_routine();
     -@@ run-command.c: static int async_die_is_recursing(void)
     - 	return ret != NULL;
     - }
     - 
     --int in_async(void)
     --{
     --	if (!main_thread_set)
     --		return 0; /* no asyncs started yet */
     --	return !pthread_equal(main_thread, pthread_self());
     --}
     --
     --static void NORETURN async_exit(int code)
     --{
     --	pthread_exit((void *)(intptr_t)code);
     --}
     --
     - #else
     - 
     - static struct {
     -@@ run-command.c: int in_async(void)
     - 	return process_is_async;
     - }
     - 
     --static void NORETURN async_exit(int code)
     --{
     --	exit(code);
     --}
     --
     - #endif
     - 
     - void check_pipe(int err)
     - {
     - 	if (err == EPIPE) {
     --		if (in_async())
     --			async_exit(141);
     -+		if (in_async()) {
     -+#ifdef NO_PTHREADS
     -+			exit(141);
     -+#else
     -+			pthread_exit((void *)141);
     -+#endif
     -+		}
     - 
     - 		signal(SIGPIPE, SIG_DFL);
     - 		raise(SIGPIPE);


 compat/mingw.c   | 2 +-
 compat/winansi.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index e433740381b..715f1c87e11 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2291,7 +2291,7 @@ static int start_timer_thread(void)
 	timer_event = CreateEvent(NULL, FALSE, FALSE, NULL);
 	if (timer_event) {
 		timer_thread = (HANDLE) _beginthreadex(NULL, 0, ticktack, NULL, 0, NULL);
-		if (!timer_thread )
+		if (!timer_thread)
 			return errno = ENOMEM,
 				error("cannot start timer thread");
 	} else
diff --git a/compat/winansi.c b/compat/winansi.c
index 3abe8dd5a27..be65b27bd75 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -340,7 +340,7 @@ enum {
 	TEXT = 0, ESCAPE = 033, BRACKET = '['
 };
 
-static DWORD WINAPI console_thread(LPVOID unused)
+static unsigned int WINAPI console_thread(LPVOID unused)
 {
 	unsigned char buffer[BUFFER_SIZE];
 	DWORD bytes;
@@ -643,9 +643,9 @@ void winansi_init(void)
 		die_lasterr("CreateFile for named pipe failed");
 
 	/* start console spool thread on the pipe's read end */
-	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
-	if (hthread == INVALID_HANDLE_VALUE)
-		die_lasterr("CreateThread(console_thread) failed");
+	hthread = (HANDLE)_beginthreadex(NULL, 0, console_thread, NULL, 0, NULL);
+	if (!hthread)
+		die_lasterr("_beginthreadex(console_thread) failed");
 
 	/* schedule cleanup routine */
 	if (atexit(winansi_exit))

base-commit: 56c8fb1e95377900ec9d53c07886022af0a5d3c2
-- 
gitgitgadget
