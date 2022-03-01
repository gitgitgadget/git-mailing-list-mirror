Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62F0C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiCAJp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbiCAJp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:45:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE0F65816
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:45:13 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j17so19571107wrc.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 01:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F+YL8RMugdAmPQp/l+XKk9qPV2vfiRZuVBxs4oYeEjQ=;
        b=PZ7TN1KEhoyQZFwYSNMpfINIjXg6kzF4U8ubqJLbQkYnSEDUB8YGnf65bfpxOZv0kg
         br3vkpNmdBf5h+KYshMugEedz1axBVLBmfAEnPYHjntAxm/ePJwOG2yTeCPGkQae2dpo
         UOf8PAsAml/1Ioeu5d0L57bzfv/A8RMn8S46SJrpodad4gFj6xFqBnMQtqicxrw1cUSa
         pTzzpQDRcG1/QWmddv0tnvauy9wKbiV1WIoaceuzgeWMG5jhLzsOxVb8isIBxh8+zzjs
         HAIZ4bZpbU11nEvRKyaPZsftErAjG+44cMmRO1Ex+Gb/oDzS+HtOSj5uNSk30C4hbHD3
         gzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F+YL8RMugdAmPQp/l+XKk9qPV2vfiRZuVBxs4oYeEjQ=;
        b=i2DHcWMBcD8eCcEzXGxtcNgxgjDK2bN0GSefWEKu8WbdF3SwMOQSeGhsg6y5cUWdLN
         7Nj5SIFJNDe+kgDjjLMrnPz3FTUg61hF7RW4dMeHwjTaj6uI3OQ9IbnKU/NrC2EBT3gB
         gFpDkiPP7KcH6ULEo0LQ2AFDeeG8y6esCGgPDLXHqSfVLV0+Up3PTlMs4bmnssp7V2pQ
         5RHkZfzoHKSPf5+Gbq8uriXhx/Me+DlCrovNs9THpji+fGL/jn1YOvq/lSr6I256j+da
         b/irv49N67YzigbmrT1Ti7w8xuyno0x4cAnP8VC1aP48wzsyTU9XCatNzuFEma613Jvx
         rdfA==
X-Gm-Message-State: AOAM5320zaL0UDUMybY009sPBHYBHsN4vJQdukAkWKKjjyvDlkBNbT9X
        XxfLSN3h+YSFDD2pToIRCoU2RJEDalE=
X-Google-Smtp-Source: ABdhPJwKgqfm7PItlhn58SOr5c6st39ZMzkJ3XthZi8lNYwgYZGARLRFzvO1PJWeYq2rXn8J9fQQVA==
X-Received: by 2002:adf:b74b:0:b0:1ed:e1d3:e053 with SMTP id n11-20020adfb74b000000b001ede1d3e053mr19250215wre.131.1646127911396;
        Tue, 01 Mar 2022 01:45:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b003808165fbc2sm2319099wmq.25.2022.03.01.01.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 01:45:11 -0800 (PST)
Message-Id: <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 09:45:08 +0000
Subject: [PATCH v2 0/2] Reduce explicit sleep calls in t7063 untracked cache tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in a recent proposed patch to t/t7519-status-fsmonitor.sh, a number
of test cases in t\t7063-status-untracked-cache.sh explicitly sleep a
second, in order to avoid the untracked cache content being invalidated by
an mtime race condition.

Even though it's only 9 seconds of sleeping that can be straightforwardly
replaced, it seems worth fixing if possible.

Replace sleep calls with backdating of filesystem changes, but first fix the
test-tool chmtime functionality to work for directories in Windows.

I do have a question to the list here: Do mingw.c changes need to be
upstreamed somewhere? I don't understand the exact relationship between this
file and the MinGW project.

Tao Klerks (2):
  t/helper/test-chmtime: update mingw to support chmtime on directories
  t7063: mtime-mangling instead of delays in untracked cache testing

 compat/mingw.c                    | 21 +++++++++++++++++----
 t/t7063-status-untracked-cache.sh | 27 +++++++++++++++------------
 2 files changed, 32 insertions(+), 16 deletions(-)


base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1166%2FTaoK%2Ftaok-untracked-cache-testing-remote-waits-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1166/TaoK/taok-untracked-cache-testing-remote-waits-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1166

Range-diff vs v1:

 1:  76b6216281e ! 1:  7cdef0ad5fb t/helper/test-chmtime: update mingw to support chmtime on directories
     @@ Commit message
          The mingw_utime implementation in mingw.c does not support
          directories. This means that "test-tool chmtime" fails on Windows when
          targeting directories. This has previously been noted and sidestepped
     -    by Jeff Hostetler, in "t/helper/test-chmtime: skip directories
     -    on Windows" in the "Builtin FSMonitor Part 2" work.
     +    temporarily by Jeff Hostetler, in "t/helper/test-chmtime: skip
     +    directories on Windows" in the "Builtin FSMonitor Part 2" work, but
     +    not yet fixed.
      
          It would make sense to backdate file and folder changes in untracked
          cache tests, to avoid needing to insert explicit delays/pauses in the
          tests.
      
     -    Add support for directory date manipulation in mingw_utime by calling
     -    CreateFileW() explicitly to create the directory handle, and
     -    CloseHandle() to close it.
     +    Add support for directory date manipulation in mingw_utime by
     +    replacing the file-oriented _wopen() call with the
     +    directory-supporting CreateFileW() windows API explicitly.
      
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
       ## compat/mingw.c ##
     -@@ compat/mingw.c: int mingw_utime (const char *file_name, const struct utimbuf *times)
     - 	int fh, rc;
     +@@ compat/mingw.c: static inline void time_t_to_filetime(time_t t, FILETIME *ft)
     + int mingw_utime (const char *file_name, const struct utimbuf *times)
     + {
     + 	FILETIME mft, aft;
     +-	int fh, rc;
     ++	int rc;
       	DWORD attrs;
       	wchar_t wfilename[MAX_PATH];
      +	HANDLE osfilehandle;
     @@ compat/mingw.c: int mingw_utime (const char *file_name, const struct utimbuf *ti
       	}
       
      -	if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
     --		rc = -1;
     --		goto revert_attrs;
     -+	if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
     -+		fh = 0;
     -+		osfilehandle = CreateFileW(wfilename,
     -+					   0x100 /*FILE_WRITE_ATTRIBUTES*/,
     -+					   0 /*FileShare.None*/,
     -+					   NULL,
     -+					   OPEN_EXISTING,
     -+					   FILE_FLAG_BACKUP_SEMANTICS,
     -+					   NULL);
     -+		if (osfilehandle == INVALID_HANDLE_VALUE) {
     -+			errno = err_win_to_posix(GetLastError());
     -+			rc = -1;
     -+			goto revert_attrs;
     -+		}
     -+	} else {
     -+		if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
     -+			rc = -1;
     -+			goto revert_attrs;
     -+		}
     -+		osfilehandle = (HANDLE)_get_osfhandle(fh);
     ++	osfilehandle = CreateFileW(wfilename,
     ++				   0x100 /*FILE_WRITE_ATTRIBUTES*/,
     ++				   0 /*FileShare.None*/,
     ++				   NULL,
     ++				   OPEN_EXISTING,
     ++				   attrs & FILE_ATTRIBUTE_DIRECTORY ?
     ++					FILE_FLAG_BACKUP_SEMANTICS : 0,
     ++				   NULL);
     ++	if (osfilehandle == INVALID_HANDLE_VALUE) {
     ++		errno = err_win_to_posix(GetLastError());
     + 		rc = -1;
     + 		goto revert_attrs;
       	}
     - 
     - 	if (times) {
      @@ compat/mingw.c: int mingw_utime (const char *file_name, const struct utimbuf *times)
       		GetSystemTimeAsFileTime(&mft);
       		aft = mft;
     @@ compat/mingw.c: int mingw_utime (const char *file_name, const struct utimbuf *ti
       		rc = 0;
      -	close(fh);
      +
     -+	if (fh)
     -+		close(fh);
     -+	else if (osfilehandle)
     ++	if (osfilehandle != INVALID_HANDLE_VALUE)
      +		CloseHandle(osfilehandle);
       
       revert_attrs:
 2:  a1806c56333 ! 2:  3e3c9c7faac t7063: mtime-mangling instead of delays in untracked cache testing
     @@ t/t7063-status-untracked-cache.sh: sync_mtime () {
       	find . -type d -exec ls -ld {} + >/dev/null
       }
       
     -+chmmtime_worktree_root () {
     ++chmtime_worktree_root () {
      +	# chmtime doesnt handle relative paths on windows, so need
      +	# to "hardcode" a reference to the worktree folder name.
     -+	cd .. &&
     -+	test-tool chmtime $1 worktree &&
     -+	cd worktree
     ++	test-tool -C .. chmtime $1 worktree
      +}
      +
       avoid_racy() {
     @@ t/t7063-status-untracked-cache.sh: test_expect_success 'setup' '
       	touch one two three done/one dtwo/two dthree/three &&
      +	test-tool chmtime =-300 one two three done/one dtwo/two dthree/three &&
      +	test-tool chmtime =-300 done dtwo dthree &&
     -+	chmmtime_worktree_root =-300 &&
     ++	chmtime_worktree_root =-300 &&
       	git add one two done/one &&
       	: >.git/info/exclude &&
       	git update-index --untracked-cache &&
     @@ t/t7063-status-untracked-cache.sh: test_expect_success 'create/modify files, som
      -	rm base &&
      +	test-tool chmtime =-180 done/two done/three done/four done/five done &&
      +	# we need to ensure that the root dir is touched (in the past);
     -+	chmmtime_worktree_root =-180 &&
     ++	chmtime_worktree_root =-180 &&
       	sync_mtime
       '
       

-- 
gitgitgadget
