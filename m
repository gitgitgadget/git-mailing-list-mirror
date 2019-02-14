Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89F311F453
	for <e@80x24.org>; Thu, 14 Feb 2019 22:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503410AbfBNWig (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 17:38:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44412 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbfBNWig (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 17:38:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id v16so8257281wrn.11
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 14:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TNpRDED6t+irlks4bYjBcwR8kwiT1b4gR9o0thtYcYA=;
        b=jZgn1OPjOq1UJdWOBCbOzowiKQN7HtOglrMz2MXC/5hQKmNlurDlsvJyn/vmZQJkTA
         QZGDvF2Ew1a2fhFSpU1OvnfcnV3/VxI8HyJKccFeHkCgXUc71QK0x48B/TzQw5fchZde
         3Db6qMc+29r0v03OWVXhUcFzgzfEqHp6hhilj8S6r8ecyU6uBBH087FyINIVd0aqgaXI
         GYJLEgit68vlp/b9TsFwVC6TcE/yyUu2GpAOctwgi6jw57EjsJw7p0cK1Nw/H5gDdi6Q
         P52Y6R3FeD1ZsMmWUXsSbDu/7oW9eUuQYna8LvTfHDtP6rpsmjkTpW5eajgK5HHLVvHo
         MxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TNpRDED6t+irlks4bYjBcwR8kwiT1b4gR9o0thtYcYA=;
        b=RapsYnrzOQpQWb813NrWWAPuM3ZO7jPBTghism2dzJZB36+QP+KBiKxXqKwRbcatfL
         mUdY0FzxyGO+8HrD/7G1ZOc/qP1/+9LtwF4cmcVvqBqGf0q2xBJ3RlAtVz1gBtxUnUCN
         Y29jnSqf/aTBpbXku0wnYM9JcyKVKrP0u1301LiYF/LUgtil2y5oYoVGLSliDtrDbecU
         iy6U7YH4fx3JVTRdvtkedsEn7qVOmamhtgV1FSmdGLn/abPVOthk+DRg0oa8/QSYhRND
         65bVh6Dg+rv7MvlNF3cbTSvzUZbc/msTEci+xoA7byUxcqQt5HdYskUKpVJNH18F7YN0
         3b+w==
X-Gm-Message-State: AHQUAubaGk6729I/tKw3q+BvW5ddwFxIlMVgZgzUV9zHTbQ097XPMn5y
        ysTLmpeng4GiQvwmRIEnJ9o=
X-Google-Smtp-Source: AHgI3IZnH6ViE971Xbku5E21ivKnjm5IeRm65++U5ZCTzPpSQe3PI/kouz9a2co5oMpLlaKf00fuNw==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr1726398wru.303.1550183913991;
        Thu, 14 Feb 2019 14:38:33 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y145sm3398975wmd.30.2019.02.14.14.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 14:38:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Johannes Schindelin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'Max Kirillov'" <max@max630.net>
Subject: Re: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
References: <pull.126.git.gitgitgadget@gmail.com>
        <005401d4c4b3$147aa8c0$3d6ffa40$@nexbridge.com>
Date:   Thu, 14 Feb 2019 14:38:32 -0800
In-Reply-To: <005401d4c4b3$147aa8c0$3d6ffa40$@nexbridge.com> (Randall
        S. Becker's message of "Thu, 14 Feb 2019 17:17:26 -0500")
Message-ID: <xmqqef8a6lnb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> Unfortunately, subtest 13 still hangs on NonStop, even with this
> patch, so our Pipeline still hangs. I'm glad it's better on Azure,
> but I don't think this actually addresses the root cause of the
> hang.

Sigh.

> possible this is not the test that is failing, but actually the
> git-http-backend? The code is not in a loop, if that helps. It is
> not consuming any significant cycles. I don't know that part of
> the code at all, sadly. The code is here:
>
> * in the operating system from here up *
>   cleanup_children + 0x5D0 (UCr)
>   cleanup_children_on_exit + 0x70 (UCr)
>   git_atexit_dispatch + 0x200 (UCr)
>   __process_atexit_functions + 0xA0 (DLL zcredll)
>   CRE_TERMINATOR_ + 0xB50 (DLL zcredll)
>   exit + 0x2A0 (DLL zcrtldll)
>   die_webcgi + 0x240 (UCr)
>   die_errno + 0x360 (UCr)
>   write_or_die + 0x1C0 (UCr)
>   end_headers + 0x1A0 (UCr)
>   die_webcgi + 0x220 (UCr)
>   die + 0x320 (UCr)
>   inflate_request + 0x520 (UCr)
>   run_service + 0xC20 (UCr)
>   service_rpc + 0x530 (UCr)
>   cmd_main + 0xD00 (UCr)
>   main + 0x190 (UCr)
>
> Best guess is that a signal (SIGCHLD?) is possibly getting eaten
> or neglected somewhere between the test, perl, and
> git-http-backend.

So we are trying to die(), which actually happens in die_webcgi(),
and then try to write some message _but_ notice an error inside
write_or_dir() and try to exit because we do not want to recurse
forever trying to die, giving a message to say how/why we died, and
die because failing to give that message, forever.

But in our attempt to exit(), we try to "cleanup children" and that
is what gets stuck.

One big difference before and after the /dev/zero change is that the
process is now on a downstream of the pipe.  If we prepare a large
file with a finite size full of NULs and replace /dev/null with it,
instead of feeding NULs from the pipe, would it change the equation?
