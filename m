Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E599C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2979E222C2
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deqb1ivD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgBMSkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:40:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39777 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgBMSkp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 13:40:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so7955115wrt.6
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 10:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vRHImHw99HcstChUWdNvdGu2HzYMvg8iYA0coWzrqxw=;
        b=deqb1ivD/+NbttJKtQsQzTYbrVaRibHWJqSklkuZ6z8FAE3dcf55GJCGBIS6wDNLvx
         +EWUPQlfw0uYogbrE6vIWOSo9a19eDkCjPoY9GlAemotOdBFDS2hbMY3S36SkdeNu6Sh
         D1qH3l1bsgEXrUxVfikOSqMnrBj76sdOMVF85loPgY/a+xxAlBA4UWdHv06T5llnJVP5
         2jRGuieqzqzk0aL33NBUwkjosVVFRlaUFd1lZ/92M4D0Yx1YGagsiwbaq0v+HtPV0wCG
         UfxVUYeKZAw8+TL6f6UjsvM7TsJruSzY7wjamPr2V787ykRireZJbGP+Ut9b2G6swz26
         3Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vRHImHw99HcstChUWdNvdGu2HzYMvg8iYA0coWzrqxw=;
        b=NrKwEuhQHm2/FAOZeCO8nnNXli0OflvqT6/NAfqIfOH4Sd0X3NaZ/R4m4eYV9Gy+JD
         HPO5ueE3j6mehoDVpUrawxqJcJg/x8dUOi9RvEIeEnMEk2Dk44zat1uFZ7oqp5rv03bP
         1pBVS+IOaBPrW/x5WTLLj6HW/5OeqCBe8aTueod7nZvebqpyEsx4hiF+3cQ73yIB5tT4
         xTbs+J4KJATnqgAtCYjo1CMvxKHQ4wzl9s8bvSscrRw8SutbigwSo+YNt7sSmgX9UqKf
         GHVlRKvof3Si4FDwaP1YZqGr1PW7BwDb9YLkIIPZ5vuNkbxOxzsWcOA3s9nZiyKpWYka
         /c4A==
X-Gm-Message-State: APjAAAW0vkaVmY2lbKzb6+EnScYf2JzFSPPP3ok8p8EhPcc2BKUIS+Rt
        jjT8patjTYjcI3HPmVoqs+NjMyAD
X-Google-Smtp-Source: APXvYqx3M/2F1sv/OelDR8A8DpXncxj2nrGkYH4Y6tLLBe+ICK2sSPdR8MDMAEfQX37WhZ5hvjQHOA==
X-Received: by 2002:a5d:5148:: with SMTP id u8mr24208762wrt.132.1581619240354;
        Thu, 13 Feb 2020 10:40:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6sm3927988wrn.26.2020.02.13.10.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:40:39 -0800 (PST)
Message-Id: <pull.553.git.1581619239467.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Feb 2020 18:40:39 +0000
Subject: [PATCH] mingw: workaround for hangs when sending STDIN
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Explanation
-----------
The problem here is flawed `poll()` implementation. When it tries to
see if pipe can be written without blocking, it eventually calls
`NtQueryInformationFile()` and tests `WriteQuotaAvailable`. However,
the meaning of quota was misunderstood. The value of quota is reduced
when either some data was written to a pipe, *or* there is a pending
read on the pipe. Therefore, if there is a pending read of size >= then
the pipe's buffer size, poll() will think that pipe is not writable and
will hang forever, usually that means deadlocking both pipe users.

I have studied the problem and found that Windows pipes track two values:
`QuotaUsed` and `BytesInQueue`. The code in `poll()` apparently wants to
know `BytesInQueue` instead of quota. Unfortunately, `BytesInQueue` can
only be requested from read end of the pipe, while `poll()` receives
write end.

The git's implementation of `poll()` was copied from gnulib, which also
contains a flawed implementation up to today.

I also had a look at implementation in cygwin, which is also broken in a
subtle way. It uses this code in `pipe_data_available()`:
	fpli.WriteQuotaAvailable = (fpli.OutboundQuota - fpli.ReadDataAvailable)
However, `ReadDataAvailable` always returns 0 for the write end of the pipe,
turning the code into an obfuscated version of returning pipe's total
buffer size, which I guess will in turn have `poll()` always say that pipe
is writable. The commit that introduced the code doesn't say anything about
this change, so it could be some debugging code that slipped in.

These are the typical sizes used in git:
0x2000 - default read size in `strbuf_read()`
0x1000 - default read size in CRT, used by `strbuf_getwholeline()`
0x2000 - pipe buffer size in compat\mingw.c

As a consequence, as soon as child process uses `strbuf_read()`,
`poll()` in parent process will hang forever, deadlocking both
processes.

This results in two observable behaviors:
1) If parent process begins sending STDIN quickly (and usually that's
   the case), then first `poll()` will succeed and first block will go
   through. MAX_IO_SIZE_DEFAULT is 8MB, so if STDIN exceeds 8MB, then
   it will deadlock.
2) If parent process waits a little bit for any reason (including OS
   scheduler) and child is first to issue `strbuf_read()`, then it will
   deadlock immediately even on small STDINs.

Possible solutions
------------------
1) Somehow obtain `BytesInQueue` instead of `QuotaUsed`
   I did a pretty thorough search and didn't find any ways to obtain
   the value from write end of the pipe.
2) Also give read end of the pipe to `poll()`
   That can be done, but it will probably invite some dirty code,
   because `poll()`
   * can accept multiple pipes at once
   * can accept things that are not pipes
   * is expected to have a well known signature.
3) Make `poll()` always reply "writable" for write end of the pipe
   Afterall it seems that cygwin (accidentally?) does that for years.
   Also, it should be noted that `pump_io_round()` writes 8MB blocks,
   completely ignoring the fact that pipe's buffer size is only 8KB,
   which means that pipe gets clogged many times during that single
   write. This may invite a deadlock, if child's STDERR/STDOUT gets
   clogged while it's trying to deal with 8MB of STDIN. Such deadlocks
   could  be defeated with writing less then pipe's buffer size per
   round, and always reading everything from STDOUT/STDERR before
   starting next round. Therefore, making `poll()` always reply
   "writable" shouldn't cause any new issues or block any future
   solutions.
4) Increase the size of the pipe's buffer
   The difference between `BytesInQueue` and `QuotaUsed` is the size
   of pending reads. Therefore, if buffer is bigger then size of reads,
   `poll()` won't hang so easily. However, I found that for example
   `strbuf_read()` will get more and more hungry as it reads large inputs,
   eventually surpassing any reasonable pipe buffer size.

Chosen solution
---------------
Make `poll()` always reply "writable" for write end of the pipe.
Hopefully one day someone will find a way to implement it properly.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
    mingw: git stash push hangs if patch > 8MB
    
    Please read the commit message for more information.
    
    The specific problem of `git stash push` exists since `git stash`
    was converted into built-in [1].
    
    On a side note, I think that `git stash push` could be optimized by
    replacing the code that reads entire `git diff-index` into memory
    and then sends it to `git apply`. With large stash, that could mean
    handling a very large patch.
    
    Is it possible to instead directly invoke (without even starting a
    new process) something like `git revert --no-commit -m 1 7091f172` ?
    
    [1] Commit d553f538 ("stash: convert push to builtin" 2019-02-26)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-553%2FSyntevoAlex%2F%230245(git)_poll_hang-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-553/SyntevoAlex/#0245(git)_poll_hang-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/553

 compat/poll/poll.c | 31 +++----------------------------
 t/t3903-stash.sh   |  5 +++++
 2 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 0e95dd493c..afa6d24584 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -139,22 +139,10 @@ win32_compute_revents (HANDLE h, int *p_sought)
   INPUT_RECORD *irbuffer;
   DWORD avail, nbuffer;
   BOOL bRet;
-  IO_STATUS_BLOCK iosb;
-  FILE_PIPE_LOCAL_INFORMATION fpli;
-  static PNtQueryInformationFile NtQueryInformationFile;
-  static BOOL once_only;
 
   switch (GetFileType (h))
     {
     case FILE_TYPE_PIPE:
-      if (!once_only)
-	{
-	  NtQueryInformationFile = (PNtQueryInformationFile)(void (*)(void))
-	    GetProcAddress (GetModuleHandleW (L"ntdll.dll"),
-			    "NtQueryInformationFile");
-	  once_only = TRUE;
-	}
-
       happened = 0;
       if (PeekNamedPipe (h, NULL, 0, NULL, &avail, NULL) != 0)
 	{
@@ -166,22 +154,9 @@ win32_compute_revents (HANDLE h, int *p_sought)
 
       else
 	{
-	  /* It was the write-end of the pipe.  Check if it is writable.
-	     If NtQueryInformationFile fails, optimistically assume the pipe is
-	     writable.  This could happen on Win9x, where NtQueryInformationFile
-	     is not available, or if we inherit a pipe that doesn't permit
-	     FILE_READ_ATTRIBUTES access on the write end (I think this should
-	     not happen since WinXP SP2; WINE seems fine too).  Otherwise,
-	     ensure that enough space is available for atomic writes.  */
-	  memset (&iosb, 0, sizeof (iosb));
-	  memset (&fpli, 0, sizeof (fpli));
-
-	  if (!NtQueryInformationFile
-	      || NtQueryInformationFile (h, &iosb, &fpli, sizeof (fpli),
-					 FilePipeLocalInformation)
-	      || fpli.WriteQuotaAvailable >= PIPE_BUF
-	      || (fpli.OutboundQuota < PIPE_BUF &&
-		  fpli.WriteQuotaAvailable == fpli.OutboundQuota))
+	  /* It was the write-end of the pipe. Unfortunately there is no
+	     reliable way of knowing if it can be written without blocking.
+	     Just say that it's all good. */
 	    happened |= *p_sought & (POLLOUT | POLLWRNORM | POLLWRBAND);
 	}
       return happened;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ea56e85e70..8877ba31ff 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1285,4 +1285,9 @@ test_expect_success 'stash handles skip-worktree entries nicely' '
 	git rev-parse --verify refs/stash:A.t
 '
 
+test_expect_success 'stash handles large files' '
+	printf "%1023s\n%.0s" "x" {1..16384} >large_file.txt &&
+	git stash push --include-untracked -- large_file.txt
+'
+
 test_done

base-commit: d8437c57fa0752716dde2d3747e7c22bf7ce2e41
-- 
gitgitgadget
