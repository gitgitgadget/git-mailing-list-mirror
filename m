Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD474C43215
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 14:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E63820715
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 14:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj1qfPPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfKVOlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:41:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44379 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKVOlM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 09:41:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so8852785wrn.11
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 06:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fd0RJytb8yE0ezMrwNyNzPh/LCYv/WmTwTPXUFSgMpE=;
        b=Uj1qfPPTHsti0z0i0EErJWX4KGydsVGZQKq4rvm25shQB7a+RGnp1Xxwp7vOTZKjEd
         8VLmCbwlBeBS86aahSXhsMs/zlpTbAJm9Nmje7ziCFfeWIozyTO/OThSSO4qb60+nvDk
         Xx+GsUwm8nzmkj9J1spPa4JoCroIlAJp11Krhey7iH8buVENSWQMVZvwwk7MaEudE2SU
         oz7H+xTrj5JxYXrwyuPtHMC7jbuGfseABbpVdx161JEDE0OxbK205gPTewC47mC9lCtx
         7iS/sdCrqd8waEOX/s5kke+orbJEalXVZ+qKxPyemNzUM+hdK8Nd5oAwBrQPhAsoO7JX
         fi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fd0RJytb8yE0ezMrwNyNzPh/LCYv/WmTwTPXUFSgMpE=;
        b=lhncDZWo/+APMvXg7+LCNh+eLulAT+8pYWL7bSnWHTQZ/uuFHrcK552HAdRlFqcWvg
         ifAsvYZ+1PqutXTnYjb5ZUB06dK2TFFyb/g6ZVnGTOcFbgtsZWtWLWOCxClol5LOGc7Z
         JQr9Y/QNQIDbhMMmFtqSVdx6GFMMy0vIdcf5g7FDdfIl1xiMhhT8POTsxxYSmG81NITG
         XmIUx3vKBqJ6bsn4YR6y3FC0imfMArWff6A1mXf0WH5+jBR1tbcRKWXE4T5kjubSZQ2w
         kAHEL2VokG+8qGpoYcx/ndiXPWnAwJLAMVP4MHNyvJT9PuOXphpPkMjdO5NoTr/wyRD1
         gzqg==
X-Gm-Message-State: APjAAAVfiHGKQAly61hnFaPjuWdKMB+747+wlLesKKfIfgO9Yvq8t5NP
        nWBcVscOw0w540BdfLRAEfJwjiIG
X-Google-Smtp-Source: APXvYqxXJFoEc6FerHTjcW+q6D+g66PVt8nELSBhHmbvEcKmcHQv5o52HlGTmaO8OzzQuNU/4BLiyw==
X-Received: by 2002:a5d:6585:: with SMTP id q5mr17565687wru.158.1574433669325;
        Fri, 22 Nov 2019 06:41:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm8201863wru.59.2019.11.22.06.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 06:41:08 -0800 (PST)
Message-Id: <feb197792814701bf36cb15b73e1e73aae2baa4d.1574433665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.670.git.git.1574433665.gitgitgadget@gmail.com>
References: <pull.670.git.git.1574433665.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Nov 2019 14:41:04 +0000
Subject: [PATCH 3/4] mingw: spawned processes need to inherit only standard
 handles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By default, CreateProcess() does not inherit any open file handles,
unless the bInheritHandles parameter is set to TRUE. Which we do need to
set because we need to pass in stdin/stdout/stderr to talk to the child
processes. Sadly, this means that all file handles (unless marked via
O_NOINHERIT) are inherited.

This lead to problems in VFS for Git, where a long-running read-object
hook is used to hydrate missing objects, and depending on the
circumstances, might only be called *after* Git opened a file handle.

Ideally, we would not open files without O_NOINHERIT unless *really*
necessary (i.e. when we want to pass the opened file handle as standard
handle into a child process), but apparently it is all-too-easy to
introduce incorrect open() calls: this happened, and prevented updating
a file after the read-object hook was started because the hook still
held a handle on said file.

Happily, there is a solution: as described in the "Old New Thing"
https://blogs.msdn.microsoft.com/oldnewthing/20111216-00/?p=8873 there
is a way, starting with Windows Vista, that lets us define precisely
which handles should be inherited by the child process.

And since we bumped the minimum Windows version for use with Git for
Windows to Vista with v2.10.1 (i.e. a *long* time ago), we can use this
method. So let's do exactly that.

We need to make sure that the list of handles to inherit does not
contain duplicates; Otherwise CreateProcessW() would fail with
ERROR_INVALID_ARGUMENT.

While at it, stop setting errno to ENOENT unless it really is the
correct value.

Also, fall back to not limiting handle inheritance under certain error
conditions (e.g. on Windows 7, which is a lot stricter in what handles
you can specify to limit to).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c         | 120 +++++++++++++++++++++++++++++++++++++----
 t/t0061-run-command.sh |   2 +-
 2 files changed, 110 insertions(+), 12 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index fe609239dd..cac18cc3da 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1398,8 +1398,13 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 			      const char *dir,
 			      int prepend_cmd, int fhin, int fhout, int fherr)
 {
-	STARTUPINFOW si;
+	static int restrict_handle_inheritance = 1;
+	STARTUPINFOEXW si;
 	PROCESS_INFORMATION pi;
+	LPPROC_THREAD_ATTRIBUTE_LIST attr_list = NULL;
+	HANDLE stdhandles[3];
+	DWORD stdhandles_count = 0;
+	SIZE_T size;
 	struct strbuf args;
 	wchar_t wcmd[MAX_PATH], wdir[MAX_PATH], *wargs, *wenvblk = NULL;
 	unsigned flags = CREATE_UNICODE_ENVIRONMENT;
@@ -1435,11 +1440,23 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 		CloseHandle(cons);
 	}
 	memset(&si, 0, sizeof(si));
-	si.cb = sizeof(si);
-	si.dwFlags = STARTF_USESTDHANDLES;
-	si.hStdInput = winansi_get_osfhandle(fhin);
-	si.hStdOutput = winansi_get_osfhandle(fhout);
-	si.hStdError = winansi_get_osfhandle(fherr);
+	si.StartupInfo.cb = sizeof(si);
+	si.StartupInfo.hStdInput = winansi_get_osfhandle(fhin);
+	si.StartupInfo.hStdOutput = winansi_get_osfhandle(fhout);
+	si.StartupInfo.hStdError = winansi_get_osfhandle(fherr);
+
+	/* The list of handles cannot contain duplicates */
+	if (si.StartupInfo.hStdInput != INVALID_HANDLE_VALUE)
+		stdhandles[stdhandles_count++] = si.StartupInfo.hStdInput;
+	if (si.StartupInfo.hStdOutput != INVALID_HANDLE_VALUE &&
+	    si.StartupInfo.hStdOutput != si.StartupInfo.hStdInput)
+		stdhandles[stdhandles_count++] = si.StartupInfo.hStdOutput;
+	if (si.StartupInfo.hStdError != INVALID_HANDLE_VALUE &&
+	    si.StartupInfo.hStdError != si.StartupInfo.hStdInput &&
+	    si.StartupInfo.hStdError != si.StartupInfo.hStdOutput)
+		stdhandles[stdhandles_count++] = si.StartupInfo.hStdError;
+	if (stdhandles_count)
+		si.StartupInfo.dwFlags |= STARTF_USESTDHANDLES;
 
 	if (*argv && !strcmp(cmd, *argv))
 		wcmd[0] = L'\0';
@@ -1472,16 +1489,97 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 	wenvblk = make_environment_block(deltaenv);
 
 	memset(&pi, 0, sizeof(pi));
-	ret = CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL, TRUE,
-		flags, wenvblk, dir ? wdir : NULL, &si, &pi);
+	if (restrict_handle_inheritance && stdhandles_count &&
+	    (InitializeProcThreadAttributeList(NULL, 1, 0, &size) ||
+	     GetLastError() == ERROR_INSUFFICIENT_BUFFER) &&
+	    (attr_list = (LPPROC_THREAD_ATTRIBUTE_LIST)
+			(HeapAlloc(GetProcessHeap(), 0, size))) &&
+	    InitializeProcThreadAttributeList(attr_list, 1, 0, &size) &&
+	    UpdateProcThreadAttribute(attr_list, 0,
+				      PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
+				      stdhandles,
+				      stdhandles_count * sizeof(HANDLE),
+				      NULL, NULL)) {
+		si.lpAttributeList = attr_list;
+		flags |= EXTENDED_STARTUPINFO_PRESENT;
+	}
+
+	ret = CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
+			     stdhandles_count ? TRUE : FALSE,
+			     flags, wenvblk, dir ? wdir : NULL,
+			     &si.StartupInfo, &pi);
+
+	/*
+	 * On Windows 2008 R2, it seems that specifying certain types of handles
+	 * (such as FILE_TYPE_CHAR or FILE_TYPE_PIPE) will always produce an
+	 * error. Rather than playing finicky and fragile games, let's just try
+	 * to detect this situation and simply try again without restricting any
+	 * handle inheritance. This is still better than failing to create
+	 * processes.
+	 */
+	if (!ret && restrict_handle_inheritance && stdhandles_count) {
+		DWORD err = GetLastError();
+		struct strbuf buf = STRBUF_INIT;
+
+		if (err != ERROR_NO_SYSTEM_RESOURCES &&
+		    /*
+		     * On Windows 7 and earlier, handles on pipes and character
+		     * devices are inherited automatically, and cannot be
+		     * specified in the thread handle list. Rather than trying
+		     * to catch each and every corner case (and running the
+		     * chance of *still* forgetting a few), let's just fall
+		     * back to creating the process without trying to limit the
+		     * handle inheritance.
+		     */
+		    !(err == ERROR_INVALID_PARAMETER &&
+		      GetVersion() >> 16 < 9200) &&
+		    !getenv("SUPPRESS_HANDLE_INHERITANCE_WARNING")) {
+			DWORD fl = 0;
+			int i;
+
+			setenv("SUPPRESS_HANDLE_INHERITANCE_WARNING", "1", 1);
+
+			for (i = 0; i < stdhandles_count; i++) {
+				HANDLE h = stdhandles[i];
+				strbuf_addf(&buf, "handle #%d: %p (type %lx, "
+					    "handle info (%d) %lx\n", i, h,
+					    GetFileType(h),
+					    GetHandleInformation(h, &fl),
+					    fl);
+			}
+			strbuf_addstr(&buf, "\nThis is a bug; please report it "
+				      "at\nhttps://github.com/git-for-windows/"
+				      "git/issues/new\n\n"
+				      "To suppress this warning, please set "
+				      "the environment variable\n\n"
+				      "\tSUPPRESS_HANDLE_INHERITANCE_WARNING=1"
+				      "\n");
+		}
+		restrict_handle_inheritance = 0;
+		flags &= ~EXTENDED_STARTUPINFO_PRESENT;
+		ret = CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
+				     TRUE, flags, wenvblk, dir ? wdir : NULL,
+				     &si.StartupInfo, &pi);
+		if (ret && buf.len) {
+			errno = err_win_to_posix(GetLastError());
+			warning("failed to restrict file handles (%ld)\n\n%s",
+				err, buf.buf);
+		}
+		strbuf_release(&buf);
+	} else if (!ret)
+		errno = err_win_to_posix(GetLastError());
+
+	if (si.lpAttributeList)
+		DeleteProcThreadAttributeList(si.lpAttributeList);
+	if (attr_list)
+		HeapFree(GetProcessHeap(), 0, attr_list);
 
 	free(wenvblk);
 	free(wargs);
 
-	if (!ret) {
-		errno = ENOENT;
+	if (!ret)
 		return -1;
-	}
+
 	CloseHandle(pi.hThread);
 
 	/*
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 473a3405ef..7d599675e3 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -12,7 +12,7 @@ cat >hello-script <<-EOF
 	cat hello-script
 EOF
 
-test_expect_failure MINGW 'subprocess inherits only std handles' '
+test_expect_success MINGW 'subprocess inherits only std handles' '
 	test-tool run-command inherited-handle
 '
 
-- 
gitgitgadget

