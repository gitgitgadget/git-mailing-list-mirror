Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CA0C34021
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 16:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B364B20725
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 16:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlG4P+B7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgBQQZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:25:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37345 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgBQQZz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 11:25:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so20485132wru.4
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1Icdibs278wdcEyeEa6dZGn2G2zwN4jx0iZney9lxIM=;
        b=nlG4P+B7HQmmPSfZiilLGZ14ZuSE4Ev79lkvPQDNO3vR2a9yY04qGCDYmWdkL/7G9K
         Y7+DDW/tl1Jb4LO7xDn8sC4vxhOIpzMFPDZRJHARoX4mGCU2l+kuqcsnDTUR3tPouZWJ
         /Ggj44yOebEDHZPCdlA8jRpZktYhJN8bJ77l7C7rZaV2boGuk3woAGOL+yav1NN6j/p8
         WcJiuYx7xjda5EcALCd3AbXBa0YakXZBnTymsNex6gp7NwZPJdMgi86Ks+jlxRFgXx/R
         q2p4t6WDbsVov6msMOYmiGDqt7iUS0E1u3XcAdXs1FcMap+9VFAFdDrcVov/e6rqpS/J
         RCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1Icdibs278wdcEyeEa6dZGn2G2zwN4jx0iZney9lxIM=;
        b=qdyyooMDqiycVqsq05z/Gf6f73HtH5dklrphik69TM2jQGI/bt36fXbOwlyvk1vidx
         KtFOC5twtpgt0nADVTawf5Wi9uTat9NleWUKW+DYXEa+wh6hdi/t/A7yPBUmA5OfFOfR
         i5TdeW/KRLhCVHmsmasmU/0LpiJNoPm3DYshFDfP49cmyq9F9d+zrbMbbcMci+osh9HJ
         puNRvRD2mJaMv9s+SV1LucYsyb9Dy7r3bGYAqFZQYH61HDXikd8jIgkYEBE98g0IrjvK
         4aTsZnCdNjGRHjEWQHTC79mObs6THfBRGt51Iln1QUBdPWBQxv5ojYPRp5KQXq/SnVET
         V4zw==
X-Gm-Message-State: APjAAAW81eaHpnKVPVgs7tDmGVAuuSHMkn9cdRcTQNUORCXmZzkNw2Vs
        RszZqui9R0pKTbMmVag3+TpLtoU3
X-Google-Smtp-Source: APXvYqwwArj8yUtfiCY8IilBifDzvvbaPhY9LUJo3OO8hDYGAaMYviUOOGlH7td6IpNIj30JUFJY8w==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr22405835wrh.49.1581956751025;
        Mon, 17 Feb 2020 08:25:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15sm1531845wrp.4.2020.02.17.08.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 08:25:50 -0800 (PST)
Message-Id: <pull.553.v2.git.1581956750001.gitgitgadget@gmail.com>
In-Reply-To: <pull.553.git.1581619239467.gitgitgadget@gmail.com>
References: <pull.553.git.1581619239467.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 16:25:49 +0000
Subject: [PATCH v2] mingw: workaround for hangs when sending STDIN
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

The problem is illustrated by `git stash push`, which will currently
read the entire patch into memory and then send it to `git apply` via
STDIN. If patch exceeds 8MB, git hangs on Windows.

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
   could be defeated with writing less than pipe's buffer size per
   round, and always reading everything from STDOUT/STDERR before
   starting next round. Therefore, making `poll()` always reply
   "writable" shouldn't cause any new issues or block any future
   solutions.
4) Increase the size of the pipe's buffer
   The difference between `BytesInQueue` and `QuotaUsed` is the size
   of pending reads. Therefore, if buffer is bigger than size of reads,
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
    
    Changes since V1
    ------------------
    Some polishing based on code review in V1
    1) Fixed some spelling in commit message
    2) Reworked test to be more compatible with different shells
    
    ------------------
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-553%2FSyntevoAlex%2F%230245(git)_poll_hang-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-553/SyntevoAlex/#0245(git)_poll_hang-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/553

Range-diff vs v1:

 1:  e2cb36c34c2 ! 1:  2a1e8f80c5c mingw: workaround for hangs when sending STDIN
     @@ -49,6 +49,10 @@
             scheduler) and child is first to issue `strbuf_read()`, then it will
             deadlock immediately even on small STDINs.
      
     +    The problem is illustrated by `git stash push`, which will currently
     +    read the entire patch into memory and then send it to `git apply` via
     +    STDIN. If patch exceeds 8MB, git hangs on Windows.
     +
          Possible solutions
          ------------------
          1) Somehow obtain `BytesInQueue` instead of `QuotaUsed`
     @@ -67,14 +71,14 @@
             which means that pipe gets clogged many times during that single
             write. This may invite a deadlock, if child's STDERR/STDOUT gets
             clogged while it's trying to deal with 8MB of STDIN. Such deadlocks
     -       could  be defeated with writing less then pipe's buffer size per
     +       could be defeated with writing less than pipe's buffer size per
             round, and always reading everything from STDOUT/STDERR before
             starting next round. Therefore, making `poll()` always reply
             "writable" shouldn't cause any new issues or block any future
             solutions.
          4) Increase the size of the pipe's buffer
             The difference between `BytesInQueue` and `QuotaUsed` is the size
     -       of pending reads. Therefore, if buffer is bigger then size of reads,
     +       of pending reads. Therefore, if buffer is bigger than size of reads,
             `poll()` won't hang so easily. However, I found that for example
             `strbuf_read()` will get more and more hungry as it reads large inputs,
             eventually surpassing any reasonable pipe buffer size.
     @@ -147,7 +151,17 @@
       '
       
      +test_expect_success 'stash handles large files' '
     -+	printf "%1023s\n%.0s" "x" {1..16384} >large_file.txt &&
     ++	x=0123456789abcde\n && # 16
     ++	x=$x$x$x$x$x$x$x$x  && # 128
     ++	x=$x$x$x$x$x$x$x$x  && # 1k
     ++	x=$x$x$x$x$x$x$x$x  && # 8k
     ++	x=$x$x$x$x$x$x$x$x  && # 64k
     ++	x=$x$x$x$x$x$x$x$x  && # 512k
     ++	x=$x$x$x$x$x$x$x$x  && # 4m
     ++	x=$x$x              && # 8m
     ++	echo $x >large_file.txt &&
     ++	unset x             && # release memory
     ++
      +	git stash push --include-untracked -- large_file.txt
      +'
      +


 compat/poll/poll.c | 31 +++----------------------------
 t/t3903-stash.sh   | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 0e95dd493c9..afa6d245846 100644
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
index ea56e85e70d..ed23cd6a7f3 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1285,4 +1285,19 @@ test_expect_success 'stash handles skip-worktree entries nicely' '
 	git rev-parse --verify refs/stash:A.t
 '
 
+test_expect_success 'stash handles large files' '
+	x=0123456789abcde\n && # 16
+	x=$x$x$x$x$x$x$x$x  && # 128
+	x=$x$x$x$x$x$x$x$x  && # 1k
+	x=$x$x$x$x$x$x$x$x  && # 8k
+	x=$x$x$x$x$x$x$x$x  && # 64k
+	x=$x$x$x$x$x$x$x$x  && # 512k
+	x=$x$x$x$x$x$x$x$x  && # 4m
+	x=$x$x              && # 8m
+	echo $x >large_file.txt &&
+	unset x             && # release memory
+
+	git stash push --include-untracked -- large_file.txt
+'
+
 test_done

base-commit: d8437c57fa0752716dde2d3747e7c22bf7ce2e41
-- 
gitgitgadget
