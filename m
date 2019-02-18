Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6271F453
	for <e@80x24.org>; Mon, 18 Feb 2019 21:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfBRVG0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 16:06:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41412 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfBRVG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 16:06:26 -0500
Received: by mail-ed1-f66.google.com with SMTP id x7so14946764eds.8
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 13:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=oQrA1tviDkZO+JqcZStX1Wzx/CBbohMMuDb0GvpcqA0=;
        b=c528skxYdM1cIOF656rqZozsAQRVd0HKBwYCAVZ8udpISNiVzP+3CW2VF2IjYMegRU
         Afjcnnp4vD5CmEhq72YI3mHDSagZZANk7MfbqEvrp5kYc/RaqenAQuIOWxdQf/QiA4Ec
         SI6Av51b6sivGyZcergeplwrkl7LmE9nlDGjmAm+LPxOOlVFEVnTtMHWXZRfphFxQxNn
         9AFiFCVoqHnrn3UnHE/5LugEmJNeIBLhjcoS3WgMEV7h4tzWRUKwd1P6F2Cyge0n1Zm1
         EZ44NhKK4kJkQ7vwnbsmptfb3eQJjKtc+cxQ3kVpUBtsD0kefboYmtIUbRb5gs7Kvars
         g8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=oQrA1tviDkZO+JqcZStX1Wzx/CBbohMMuDb0GvpcqA0=;
        b=fWrnT4UAp0pvZoabVRERuuwA5/mFuusaek7JTw1jNUdIeHJhQDBYQblzgfS9VchoRm
         YytnOtdMgLRBHccmiABhKX2qkZOIc8tZYCuZ5dwIA6Z/fBFoOhurNOePPx50jvp9YR+S
         QkDdQl2fPbCYK1sXPd/QTrxlZgG4onWTBG0qPnobEKp/v81CteGVNcZ2jwh0Ys9dlkVG
         Sh8WwQ8WuicEvhC0RzrysUdzZfR7SaWLVBZGMybQA5+CS1VREH1WDtQ1hRP7a2o5fx//
         /LAeWRiNVZbi4RyLzcWmnbH8gX77NMKxXMO0PahUEffVo8u8cgAX3WZ0OJsYNuF7umPx
         6AdA==
X-Gm-Message-State: AHQUAuY+fEVcP5X/fHTY03v6qxBrSrZlEsyykOONwVCvS4BV+GmxzFQH
        XtvzTRyHLyG+xK5r+FLaKlM=
X-Google-Smtp-Source: AHgI3IY9ITtE//9kNo3JDS5KLoRatMgt02wlIT5izDk/tDfgaKo5Gv6kg2PXBzQ9LlX5cYQFQS2cmQ==
X-Received: by 2002:a50:a4ce:: with SMTP id x14mr20147455edb.229.1550523984071;
        Mon, 18 Feb 2019 13:06:24 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id c41sm119921edb.64.2019.02.18.13.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 13:06:23 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        'Max Kirillov' <max@max630.net>
Subject: Re: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
References: <pull.126.git.gitgitgadget@gmail.com> <005401d4c4b3$147aa8c0$3d6ffa40$@nexbridge.com> <xmqqef8a6lnb.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqef8a6lnb.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 18 Feb 2019 22:06:21 +0100
Message-ID: <87pnroolgy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 14 2019, Junio C Hamano wrote:

> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
>
>> Unfortunately, subtest 13 still hangs on NonStop, even with this
>> patch, so our Pipeline still hangs. I'm glad it's better on Azure,
>> but I don't think this actually addresses the root cause of the
>> hang.
>
> Sigh.
>
>> possible this is not the test that is failing, but actually the
>> git-http-backend? The code is not in a loop, if that helps. It is
>> not consuming any significant cycles. I don't know that part of
>> the code at all, sadly. The code is here:
>>
>> * in the operating system from here up *
>>   cleanup_children + 0x5D0 (UCr)
>>   cleanup_children_on_exit + 0x70 (UCr)
>>   git_atexit_dispatch + 0x200 (UCr)
>>   __process_atexit_functions + 0xA0 (DLL zcredll)
>>   CRE_TERMINATOR_ + 0xB50 (DLL zcredll)
>>   exit + 0x2A0 (DLL zcrtldll)
>>   die_webcgi + 0x240 (UCr)
>>   die_errno + 0x360 (UCr)
>>   write_or_die + 0x1C0 (UCr)
>>   end_headers + 0x1A0 (UCr)
>>   die_webcgi + 0x220 (UCr)
>>   die + 0x320 (UCr)
>>   inflate_request + 0x520 (UCr)
>>   run_service + 0xC20 (UCr)
>>   service_rpc + 0x530 (UCr)
>>   cmd_main + 0xD00 (UCr)
>>   main + 0x190 (UCr)
>>
>> Best guess is that a signal (SIGCHLD?) is possibly getting eaten
>> or neglected somewhere between the test, perl, and
>> git-http-backend.
>
> So we are trying to die(), which actually happens in die_webcgi(),
> and then try to write some message _but_ notice an error inside
> write_or_dir() and try to exit because we do not want to recurse
> forever trying to die, giving a message to say how/why we died, and
> die because failing to give that message, forever.
>
> But in our attempt to exit(), we try to "cleanup children" and that
> is what gets stuck.

I have not paid enough attention to this thread to say if this is dumb,
but just in case it's useful. For this class of problem where cleanup
bites you for whatever reason in Perl, you can sometimes use this:

    use POSIX ();
    POSIX::_exit($code);

This will call "exit" from "stdlib" instead of Perl's "exit". So go away
*now* and let the OS deal with the mess. Perl's will run around cleaning
up stuff, freeing memory, running destructors etc, all of which might
have side effects you don't want/care about, and might (as maybe in this
case?) cause some hang.

> One big difference before and after the /dev/zero change is that the
> process is now on a downstream of the pipe.  If we prepare a large
> file with a finite size full of NULs and replace /dev/null with it,
> instead of feeding NULs from the pipe, would it change the equation?
