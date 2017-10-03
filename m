Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923A52036B
	for <e@80x24.org>; Tue,  3 Oct 2017 20:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbdJCUZf (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 16:25:35 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:57175 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdJCUZe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 16:25:34 -0400
Received: by mail-qk0-f181.google.com with SMTP id u7so8972379qku.13
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K8FPTyRvZIrCIAcAwCT+OJa7RHO76D6Qa5lV/OkgOwc=;
        b=LKob+M1HyiWzF/kZHwOv+wCRyBPo8HC9FliYBaqSzlibkRmiXORXo2VTKfEbJzE0TC
         gDWO6YCv3e1ULKfU0njQU6v1jN5JCMtJ6Y7Kzi7CAtW7mluXohmdHuMXHP5z6s45XiLO
         Q2y6yhjUT4pIoTjKlMZaSvLuK728NEdxFJG+oGUd4dEFGzbD5BJLFHZdNW5wCUpB45Dp
         CW6OW2z1rAF9n0qMlZBy6Qqo/ZX1sNX4sgPYuxlPO76Da0WeGU3CLo3IJpkiZoN9lhQb
         4uLIbSs/qQpX8V4ZXX32l+pNrvfYw+a5Jkt1iCHNvJ68G014z5PZPy9eB51y988rQt4a
         VmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K8FPTyRvZIrCIAcAwCT+OJa7RHO76D6Qa5lV/OkgOwc=;
        b=Ak7uYbt9rOWfjsIRnznqs2nEpE5MSD42qv+dg7TSkpQU+1TMi4Ds6JMSrQuJr8IJQM
         jeAwx0M5Uatos5H0DV9k8jwn/G2bmMgQ21Q6QMw6nXNcBw1k8oMrmqlo7t/WYdGDsGCV
         9buOwPpA1E3iHEYbc8BLJe1Res0FDsrDp/jS9sdE/dIbu4CNZXGUsG7p9htUri/2jxeV
         BK6uMJZufWxdXPNlnDFZtanpK+NTHPKcydrwbMSWMP2ExDkAskJdMiXIrMy/CgBKimug
         tBJrz60fYuLJrGDsU2LOAmZAVDByy6BNJAr+pex1vU/oVZwy6jYuFmpUfD3jqswiL9O/
         3wMA==
X-Gm-Message-State: AMCzsaWpQXY2v2ZCULFTVIR/KL+lvebDlhzf6yAqvdB4brUDh/OtZCdY
        mB1IWWD5/beePZEtSWIF4+xg5tEdpXYodT0CSbdOQg==
X-Google-Smtp-Source: AOwi7QCIN+rGyHyj73J7PNepm7Xd2vezhMlGmi64V53RRpLum2nCChmWM0H62pD6K5FNlmz5iwmaoOuVhkUw6txK91U=
X-Received: by 10.55.90.199 with SMTP id o190mr23044117qkb.180.1507062333868;
 Tue, 03 Oct 2017 13:25:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Tue, 3 Oct 2017 13:25:33 -0700 (PDT)
In-Reply-To: <20171003195713.13395-4-t.gummerer@gmail.com>
References: <20171003195713.13395-1-t.gummerer@gmail.com> <20171003195713.13395-4-t.gummerer@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Oct 2017 13:25:33 -0700
Message-ID: <CAGZ79kYPEeEh1ZG6M7bjMkA6V_XsU2LZCqdD0OxXU0h4p17FOQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] sub-process: allocate argv on the heap
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Ben Peart <peartben@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 3, 2017 at 12:57 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently the argv is only allocated on the stack, and then assigned to
> process->argv.  When the start_subprocess function goes out of scope,
> the local argv variable is eliminated from the stack, but the pointer is
> still kept around in process->argv.
>
> Much later when we try to access the same process->argv in
> finish_command, this leads us to access a memory location that no longer
> contains what we want.  As argv0 is only used for printing errors, this
> is not easily noticed in normal git operations.  However when running
> t0021-conversion.sh through valgrind, valgrind rightfully complains:
>
> ==21024== Invalid read of size 8
> ==21024==    at 0x2ACF64: finish_command (run-command.c:869)
> ==21024==    by 0x2D6B18: subprocess_exit_handler (sub-process.c:72)
> ==21024==    by 0x2AB41E: cleanup_children (run-command.c:45)
> ==21024==    by 0x2AB526: cleanup_children_on_exit (run-command.c:81)
> ==21024==    by 0x54AD487: __run_exit_handlers (in /usr/lib/libc-2.26.so)
> ==21024==    by 0x54AD4D9: exit (in /usr/lib/libc-2.26.so)
> ==21024==    by 0x11A9EF: handle_builtin (git.c:550)
> ==21024==    by 0x11ABCC: run_argv (git.c:602)
> ==21024==    by 0x11AD8E: cmd_main (git.c:679)
> ==21024==    by 0x1BF125: main (common-main.c:43)
> ==21024==  Address 0x1ffeffec00 is on thread 1's stack
> ==21024==  1504 bytes below stack pointer
> ==21024==
>
> Fix this by allocating the memory on properly on the heap.  This memory
> is allocated on the heap, and never free'd.  However the same seems to be
> true for struct child_process, so it should be fine to just let the
> memory be free'd when the process terminates.

Uh. :( The broken window theory at work.

The patch below seems correct, but as you eluded to, now we'd be
leaking memory. The run_command API has two fields 'char **argv'
and 'argv_array args'. The argv is kept around for historical reasons
as well as when the caller wants to be in control of the array (the caller
needs to free the memory, but could also just reuse it for a slightly
different invocation), whereas the args argument is owned by the child
process, such that the memory is freed by finish_command.

As we're doing a memory allocation now anyway, how about:

-       const char *argv[] = { cmd, NULL };
...
    child_process_init(process);
+    argv_array_push(process.args, cmd);
