Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B332C04E69
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 15:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjHNPYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 11:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjHNPXm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 11:23:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D5210C1
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 08:23:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3197a71a9c0so530863f8f.1
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692026619; x=1692631419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Haa4tP6A2Oq5ZZS1WcHSGA/a45wxTM0Jd9BTu3DnTBc=;
        b=c/Wob5lg/siyjJcTggtbMjUq/Op7esNKYHSvSz0V7H2qzrqapxNxGoMA0Q2te3N327
         9EVGlf+vFRUSGyF5x4iJPRR082knSQBKcdPXu1RAE0OYPzvk1TewOyMH5ZTkSuCM/OkM
         yn9109uuq+Ceix4oLPpb0eMtRECmDTIF/XxOTf0vbzIEAa2lQLNBeUidY2VNdfa5BINL
         Y8KfNPUMZY8xHXPqzyIwWg2XF0d7hCnk+5l3L84kmY4SHIoz2exaAZaKNPxy3jdZu9xY
         0gv+pEiWfNkl1DRrKwdoGasBXMSU40bcqFkbj3zVWp1wn0milDvH8DFuKI79Z8t5HZru
         5gFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692026619; x=1692631419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Haa4tP6A2Oq5ZZS1WcHSGA/a45wxTM0Jd9BTu3DnTBc=;
        b=WQAtW8Mtu7XLNelkqQmT+0CU8ecBb0Vmc1HyOyeDkdTqzpXM4MgCNXIrPm+awc3OwX
         R5PsSjAihVtE+2Gs1IP7xSYAM0i+iGRDATH/BDnrtQSnNCFXZvVe52Bew2RV93jeP5vV
         j8/6xRBre8PoV044Kr1iA0t+f7SAar3uD8V2xnHS289n2hkzD3E7sxwz6XoKM2UcJW0v
         b/2jRQjPrcS0iHTEjOvYly5CgwZXsOyMq0fx/21I8Trbr6TQw6pAwa7/Ak7sdv3NjXIb
         VpKTDfgh/nQNXjz7hjY16RveuiLBa4dOaOBeFZ1uBi+Hr9DG24YAv3aalVshAYQ4dxZk
         HLxw==
X-Gm-Message-State: AOJu0Yzod/upoSjI6AZG9z0POj0I2TZBbBsihPA5zu77Azz6HrFzqmrp
        aMTEPiCfyq4BYOjMfsm3VeU=
X-Google-Smtp-Source: AGHT+IHtDB3wY0bcVGUfR0D3sVLEk/e2sgHFKogPWvk2Fq2AY4lBngU487HBzmuhcG/biEkPJinOgA==
X-Received: by 2002:a5d:660f:0:b0:317:597f:3aa6 with SMTP id n15-20020a5d660f000000b00317597f3aa6mr9136040wru.18.1692026618710;
        Mon, 14 Aug 2023 08:23:38 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5941000000b003141f96ed36sm14738852wri.0.2023.08.14.08.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 08:23:38 -0700 (PDT)
Message-ID: <bc373bcc-2ff0-4902-aa7f-f34c23951173@gmail.com>
Date:   Mon, 14 Aug 2023 16:23:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t4053: avoid writing to unopened pipe
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20230813162440.GA1688763@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230813162440.GA1688763@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 13/08/2023 17:24, Jeff King wrote:
> This fixes an occasional hang I see when running t4053 with
> --verbose-log using dash.

Well done for tracking this down, it is interesting that it only affects 
dash. I think your proposed fix is the simplest solution, thanks for the 
comprehensive commit message.

Best Wishes

Phillip

> Commit 1e3f26542a (diff --no-index: support reading from named pipes,
> 2023-07-05) added a test that "diff --no-index" will complain when
> comparing a named pipe and a directory. The minimum we need to test this
> is to mkfifo the pipe, and then run "git diff --no-index pipe some_dir".
> But the test does one thing more: it spawns a background shell process
> that opens the pipe for writing, like this:
> 
>          {
>                  (>pipe) &
>          } &&
> 
> This extra writer _could_ be useful if Git misbehaves and tries to open
> the pipe for reading. Without the writer, Git would block indefinitely
> and the test would never end. But since we do not have such a bug, Git
> does not open the pipe and it is the writing process which will block
> indefinitely, since there are no readers. The test addresses this by
> running "kill $!" in a test_when_finished block. Since the writer should
> be blocking forever, this kill command will reliably find it waiting.
> 
> However, this seems to be somewhat racy, in that the writing process
> sometimes hangs around even after the "kill". In a normal run of the
> test script without options, this doesn't have any effect; the
> main test script completes anyway. But with --verbose-log, we spawn a
> "tee" process that reads the script output, and it won't end until all
> descriptors pointing to its input pipe are closed. And the background
> process that is hanging around still has its stderr, etc, pointed into
> that pipe.
> 
> You can reproduce the situation like this:
> 
>    cd t
>    ./t4053-diff-no-index.sh --verbose-log --stress
> 
> Let that run for a few minutes, and then you'll find that some of the
> runs have hung. For example, at 11:53, I ran:
> 
>    $ ps xk start o pid,start,command | grep tee | head
>     713459 11:48:06 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-9.out
>     713527 11:48:06 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-15.out
>     719434 11:48:07 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-1.out
>     728117 11:48:08 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-5.out
>     738738 11:48:09 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-31.out
>     739457 11:48:09 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-27.out
>     744432 11:48:10 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-21.out
>     744471 11:48:10 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-29.out
>     761961 11:48:12 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-0.out
>     812299 11:48:19 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-8.out
> 
> All of these have been hung for several minutes. We can investigate one
> and see that it's waiting to get EOF on its input:
> 
>    $ strace -p 713459
>    strace: Process 713459 attached
>    read(0,
>    ^C
> 
> Who else has that descriptor open?
> 
>    $ lsof -a -p 713459 -d 0 +E
>    COMMAND    PID USER   FD   TYPE DEVICE SIZE/OFF    NODE NAME
>    tee     713459 peff    0r  FIFO   0,13      0t0 3943636 pipe 719203,sh,5w 719203,sh,7w 719203,sh,12w 719203,sh,13w
>    sh      719203 peff    5w  FIFO   0,13      0t0 3943636 pipe 713459,tee,0r 719203,sh,7w 719203,sh,12w 719203,sh,13w
>    sh      719203 peff    7w  FIFO   0,13      0t0 3943636 pipe 713459,tee,0r 719203,sh,5w 719203,sh,12w 719203,sh,13w
>    sh      719203 peff   12w  FIFO   0,13      0t0 3943636 pipe 713459,tee,0r 719203,sh,5w 719203,sh,7w 719203,sh,13w
>    sh      719203 peff   13w  FIFO   0,13      0t0 3943636 pipe 713459,tee,0r 719203,sh,5w 719203,sh,7w 719203,sh,12w
> 
> It's a shell, presumably a subshell spawned by the main script. Though
> it may seem odd, having the same descriptor open several times is not
> unreasonable (they're all basically the original stdout/stderr of the
> script that has been copied). And they should all close when the process
> exits. So what's it doing? Curiously, it will exit as soon as we strace
> it:
> 
>    $ strace -s 64 -p 719203
>    strace: Process 719203 attached
>    openat(AT_FDCWD, "pipe", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 ENOENT (No such file or directory)
>    write(2, "./t4053-diff-no-index.sh: 7: eval: ", 35) = 35
>    write(2, "cannot create pipe: Directory nonexistent", 41) = 41
>    write(2, "\n", 1)                       = 1
>    exit_group(2)                           = ?
>    +++ exited with 2 +++
> 
> I think what happens is this:
> 
>    - it is blocking in the openat() call for the pipe, as we expect (so
>      this is definitely the backgrounded subshell mentioned above)
> 
>    - strace sends signals (probably STOP/CONT); those cause the kernel to
>      stop blocking, but libc will restart the system call automatically
> 
>    - by this time, the "pipe" fifo is gone, so we'll actually try to
>      create a regular file. But of course the surrounding directory is
>      gone, too! So we get ENOENT, and then exit as normal.
> 
> So the blocking is something we expect to happen. But what we didn't
> expect is for the process to still exist at all! It should have been
> killed earlier when the parent process called "kill", but it wasn't. And
> we can't catch the race at this point, because it happened much earlier.
> 
> One can guess, though, that there is some race with the shell setting up
> the signal handling in the backgrounded subshell, and possibly blocking
> or ignoring signals at the time that the "kill" is received.  Curiously,
> the race does not seem to happen if I use "bash" instead of "dash", so
> presumably bash's setup here is more atomic.
> 
> One fix might be to try killing the subshell more aggressively, either
> using SIGKILL, or looping on kill/wait. But that seems complex and
> likely to introduce new problems/races. Instead, we can observe that the
> writer is not needed at all. Git will notice the pipe via stat() before
> it is ever opened. So we can simply drop the writer subshell entirely.
> 
> If we ever changed Git to open the path and fstat() it, this would
> result in the test hanging. But we're not likely to do that. After all,
> we have to stat() paths to see if they are openable at all (e.g., it
> could be a directory), so this seems like a low risk. And anybody who
> does make such a change will immediately see the issue, as Git would
> hang consistently.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   t/t4053-diff-no-index.sh | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 1fb7d33462..6781cc9078 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -232,10 +232,6 @@ test_expect_success 'diff --no-index refuses to diff stdin and a directory' '
>   test_expect_success PIPE 'diff --no-index refuses to diff a named pipe and a directory' '
>   	test_when_finished "rm -f pipe" &&
>   	mkfifo pipe &&
> -	{
> -		(>pipe) &
> -	} &&
> -	test_when_finished "kill $!" &&
>   	test_must_fail git diff --no-index -- pipe a 2>err &&
>   	grep "fatal: cannot compare a named pipe to a directory" err
>   '
