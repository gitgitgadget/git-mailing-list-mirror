Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53A451F453
	for <e@80x24.org>; Wed, 31 Oct 2018 06:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeJaO5z (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 10:57:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43330 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJaO5z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 10:57:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id t10-v6so15040354wrn.10
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 23:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aSKJdHwlqklYxW5abFAcYCsIshLvNLuRdl4PRqTSSOo=;
        b=YFn+BW8AsmHpmA6A6LaLZmrzxncZe/Mcymsaz/qMyZhDNcfmaQleU8UPSkECvKVJgi
         78Oj/XDLon0nm+HIFLJRV//WYXgen23XBIFb7Sk2tNgCqan7KhwYBT6MUdCsZjwu+98A
         9jWnpJWk064jwRHIM1DPUd/XIst+AzbPx5Z2jAuSZb3ly0Oq8V1N1ojwtb6pWgp/ONRR
         Hzw3R0+PKcWZOVDSKcyf5u8Y9CfF50x3416SCVpUEop7X/rLL/nOqvVNA2yLqezJBnBS
         nJsJ2yJH1M16H/E7UnYbTW9EYga3j9gsHAGimDx/yJpf7Ko0nUwfUMhHXcQLHOzw/MSR
         N3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aSKJdHwlqklYxW5abFAcYCsIshLvNLuRdl4PRqTSSOo=;
        b=S/liBDKK7mPI3E/juz5ZuChmz+R087pyRwmzq0duzRm6dgyGlr8h5E9Muzup6QuKMu
         VWrkCWn+0WJ7iVHPrBefdXQ9TPJisH9l5sb2PI8hcd4PT1H/NOL0whaiSweKy+uSZCpo
         nlI/Dkd/0g3DVBZy4fgyVuZ34JojGGaPcljsCPThswvFCvNCaleNQJ5jDNpjWzrM6u9g
         7BjG8PTXxd1HyqgMLukNVIOOXhU3yzbff2exOaw3sfJh5vKKVC5B1VKtZ8GXNZGEpFgY
         mQ9QeuGVionyutBpZO2SFCgzdz+dfrCLeKY0p6OS54JEe1agepGQpedjNQslNQizXDkd
         qz0A==
X-Gm-Message-State: AGRZ1gL2QNiyiZahEVNOExEMfQwXmXoBf/nJkL6C/htSFUo3p5sIwTkW
        xP/1P17w6VMNlFxtTPbmLJA=
X-Google-Smtp-Source: AJdET5cyFPRWMTf+DsRKGGWN8DbdAF6FZqg2FZ2VAz4dWqX+qkiyyzCFClXEIvbHsuu8bUMkiAopiw==
X-Received: by 2002:adf:e68d:: with SMTP id r13-v6mr1262657wrm.239.1540965674236;
        Tue, 30 Oct 2018 23:01:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c11-v6sm9160139wrw.94.2018.10.30.23.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 23:01:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH v7 09/10] submodule: support reading .gitmodules when it's not in the working tree
References: <20181025161813.17252-1-ao2@ao2.it>
        <20181025161813.17252-10-ao2@ao2.it>
        <nycvar.QRO.7.76.6.1810301053540.4546@tvgsbejvaqbjf.bet>
        <20181030121630.0aec137f670bd5d3486cccc5@ao2.it>
Date:   Wed, 31 Oct 2018 15:01:12 +0900
In-Reply-To: <20181030121630.0aec137f670bd5d3486cccc5@ao2.it> (Antonio
        Ospite's message of "Tue, 30 Oct 2018 12:16:30 +0100")
Message-ID: <xmqqftwmwt7b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

> I see, this is also mentioned in t/README, I had overlooked that part.
> Thank you for reporting.
>
>> Without this fix, your new test case will fail on Windows all the time,
>> see e.g.
>> https://git-for-windows.visualstudio.com/git/_build/results?buildId=22913&view=logs
>> 
>
> Junio, what is the plan for 'ao/submodule-wo-gitmodules-checked-out'?
>

I did not and do not have a specific plan ;-) 

If the only remaining issue in the previous round of the topic were
what you said in <20181010205645.e1529eff9099805029b1d6ef@ao2.it>,
which you addressed in this round, and given that Stefan (who is
likely to be the person who would need to work with you if there is
any issues later found in this topic) seemed to be happy with it in
<CAGZ79katS+PHWWD_0EqSmoEFazE0vAbMsg8G+iowNfbDmMkyMg@mail.gmail.com>,
I'd say with Dscho's bug fixed, it should be ready for 'next'.

> I see it's not in next yet; do you want me to resend the whole series
> with this fixup in or would it be less overhead for you to apply it
> directly to patch 9/10 from v7 of the series?

In either way, this involves rebuilding ao/* topic and then redoing
sb/submodule-recursive-fetch-gets-the-tip topic on top, before I can
do the 'pu' with them, so I cannot promise it will happen today, but
let's see.  I think I have enough material to do the fix-up locally
without any additional thing sent from you.

Thanks.


> P.S. I was wondering if it is worth having patchset versions mentioned
> somewhere in pu/, maybe in merge commits if not in branch names?

No, not in branch names.

The tip date published in the "What's cooking" report is taken from
the committer date but we may want to use the author date instead,
which may help (and encourage people to be careful _before_ sending
things out, to avoid doing many rerolls in a day).
