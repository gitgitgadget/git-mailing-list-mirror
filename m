Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124C71F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 02:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJLKFO (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 06:05:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40004 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbeJLKFN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 06:05:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id z204-v6so11403393wmc.5
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 19:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6hJ7oNLfJQY/Xg6HDyFeueST38tKiqz6phA9Dh8CYtw=;
        b=Xf6+NnF5kvbri5DpFzyTzLWQFC2mb803+SERfzqDCDC5JfovPGsnYcVn8aRsjWBGcr
         On9qyfuSNE6nC+syZ073KF0DbCqiVLLfbwXXwUhKr/lsZAly9wS6qALo4XrhhtwW6q4f
         2LlKmqxp5KYiYfXT69ooev9i5y8GoaNNtv33kNHogGGmFCzRoF1vm0+K3b/xT61feKW2
         OXtyQ0Rq+PCeNw6H91tQH9VKWpi0sQ8dgDSxUcAdVwHdxYtNila1D9qBMxHlY1mX++Ic
         zUHMmsXVT7NK6IVMqVSjTADMPxQAS07PIW8KGk/IL9dIts2ddbkqHtxxACdNqu9TAnxe
         r8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6hJ7oNLfJQY/Xg6HDyFeueST38tKiqz6phA9Dh8CYtw=;
        b=MGQez9ayJ98h5ZgKsXsCQYkHWAaXZEg+1rpmUuTNXLlqClUOW78igPXX7Ml+0q5jcC
         /gBwotVYnaNo1Rx8DzyWAHC5OHT+aeyVOhbIcROWJvIeFnWEK7qmAa32Gsu9B/AmIb9D
         RhSYU6dYF35EraplG6t9pky24awhHxoc06lfjorpi2WXrLpUOLc+JDc7JfUmoi5h/9zi
         8AhsdNrVl8uHTC+6XNBHxnSXCpS4rLMVRHdDaOLU9ohnPZRNwAkwe0cR0KUKj8kSuWJI
         cHJVVd2TJF+hsSapujaaBvAISosc3wNs9s0Tv4QxNRtf1X1/EqXhv9DTffo2Qw0b97Nz
         WQiA==
X-Gm-Message-State: ABuFfojBj57moEdvNl+kdO9qe40Y5OOnRZf7RPq7SOBNegCwvUny7KPI
        ZjX9wVissF1qCDxHK7REMwXZ+l8nxiU=
X-Google-Smtp-Source: ACcGV60aCKf8cS0NrQROVTps3TdWAeAoBTv2t55F1bj3RclqL1K4B9uiHbqNTOevPiETLbPkaUJLiQ==
X-Received: by 2002:a7b:c1d9:: with SMTP id a25-v6mr3581053wmj.55.1539311703735;
        Thu, 11 Oct 2018 19:35:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 199-v6sm42520wme.39.2018.10.11.19.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 19:35:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] ref-filter: free memory from used_atom
References: <CAL21BmkdUiNgr4NqpwTdi9f47i85s8oXCZMmVx5VyNKotL78uA@mail.gmail.com>
        <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
        <xmqq5zy9jnv1.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 12 Oct 2018 11:35:01 +0900
In-Reply-To: <xmqq5zy9jnv1.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 11 Oct 2018 10:03:46 +0900")
Message-ID: <xmqqa7njevu2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

These three patches seem to cause t6300 to fail with an attempt to
free an invalid pointer in "git for-each-ref --format='%(push)'"
(6300.25)


*** Error in `/home/gitster/w/git.git/git': free(): invalid pointer: 0x000055cca3a9f920 ***
======= Backtrace: =========
/lib/x86_64-linux-gnu/libc.so.6(+0x70bcb)[0x7f052fdacbcb]
/lib/x86_64-linux-gnu/libc.so.6(+0x76f96)[0x7f052fdb2f96]
/home/gitster/w/git.git/git(+0x15a866)[0x55cca35ca866]
/home/gitster/w/git.git/git(+0x15ab48)[0x55cca35cab48]
/home/gitster/w/git.git/git(+0x15b6d3)[0x55cca35cb6d3]
/home/gitster/w/git.git/git(+0x15b7dd)[0x55cca35cb7dd]
/home/gitster/w/git.git/git(+0x49e18)[0x55cca34b9e18]
/home/gitster/w/git.git/git(+0x19b20)[0x55cca3489b20]
/home/gitster/w/git.git/git(+0x1aab5)[0x55cca348aab5]
/home/gitster/w/git.git/git(+0x19809)[0x55cca3489809]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf1)[0x7f052fd5c2b1]
/home/gitster/w/git.git/git(+0x1984a)[0x55cca348984a]
======= Memory map: ========
55cca3470000-55cca36cc000 r-xp 00000000 fe:00 2760695                    /home/gitster/w/git.git/git
55cca38cc000-55cca38cf000 r--p 0025c000 fe:00 2760695                    /home/gitster/w/git.git/git
55cca38cf000-55cca38de000 rw-p 0025f000 fe:00 2760695                    /home/gitster/w/git.git/git
55cca38de000-55cca3921000 rw-p 00000000 00:00 0 
55cca3a9e000-55cca3abf000 rw-p 00000000 00:00 0                          [heap]
7f052fb24000-7f052fb3b000 r-xp 00000000 fe:00 393287                     /lib/x86_64-linux-gnu/libgcc_s.so.1
7f052fb3b000-7f052fd3a000 ---p 00017000 fe:00 393287                     /lib/x86_64-linux-gnu/libgcc_s.so.1
7f052fd3a000-7f052fd3b000 r--p 00016000 fe:00 393287                     /lib/x86_64-linux-gnu/libgcc_s.so.1
7f052fd3b000-7f052fd3c000 rw-p 00017000 fe:00 393287                     /lib/x86_64-linux-gnu/libgcc_s.so.1
7f052fd3c000-7f052fed1000 r-xp 00000000 fe:00 392469                     /lib/x86_64-linux-gnu/libc-2.24.so
7f052fed1000-7f05300d1000 ---p 00195000 fe:00 392469                     /lib/x86_64-linux-gnu/libc-2.24.so
7f05300d1000-7f05300d5000 r--p 00195000 fe:00 392469                     /lib/x86_64-linux-gnu/libc-2.24.so
7f05300d5000-7f05300d7000 rw-p 00199000 fe:00 392469                     /lib/x86_64-linux-gnu/libc-2.24.so
7f05300d7000-7f05300db000 rw-p 00000000 00:00 0 
7f05300db000-7f05300e2000 r-xp 00000000 fe:00 392487                     /lib/x86_64-linux-gnu/librt-2.24.so
7f05300e2000-7f05302e1000 ---p 00007000 fe:00 392487                     /lib/x86_64-linux-gnu/librt-2.24.so
7f05302e1000-7f05302e2000 r--p 00006000 fe:00 392487                     /lib/x86_64-linux-gnu/librt-2.24.so
7f05302e2000-7f05302e3000 rw-p 00007000 fe:00 392487                     /lib/x86_64-linux-gnu/librt-2.24.so
7f05302e3000-7f05302fb000 r-xp 00000000 fe:00 392485                     /lib/x86_64-linux-gnu/libpthread-2.24.so
7f05302fb000-7f05304fa000 ---p 00018000 fe:00 392485                     /lib/x86_64-linux-gnu/libpthread-2.24.so
7f05304fa000-7f05304fb000 r--p 00017000 fe:00 392485                     /lib/x86_64-linux-gnu/libpthread-2.24.so
7f05304fb000-7f05304fc000 rw-p 00018000 fe:00 392485                     /lib/x86_64-linux-gnu/libpthread-2.24.so
7f05304fc000-7f0530500000 rw-p 00000000 00:00 0 
7f0530500000-7f0530519000 r-xp 00000000 fe:00 392698                     /lib/x86_64-linux-gnu/libz.so.1.2.8
7f0530519000-7f0530718000 ---p 00019000 fe:00 392698                     /lib/x86_64-linux-gnu/libz.so.1.2.8
7f0530718000-7f0530719000 r--p 00018000 fe:00 392698                     /lib/x86_64-linux-gnu/libz.so.1.2.8
7f0530719000-7f053071a000 rw-p 00019000 fe:00 392698                     /lib/x86_64-linux-gnu/libz.so.1.2.8
7f053071a000-7f053073d000 r-xp 00000000 fe:00 392461                     /lib/x86_64-linux-gnu/ld-2.24.so
7f0530916000-7f0530918000 rw-p 00000000 00:00 0 
7f0530939000-7f053093d000 rw-p 00000000 00:00 0 
7f053093d000-7f053093e000 r--p 00023000 fe:00 392461                     /lib/x86_64-linux-gnu/ld-2.24.so
7f053093e000-7f053093f000 rw-p 00024000 fe:00 392461                     /lib/x86_64-linux-gnu/ld-2.24.so
7f053093f000-7f0530940000 rw-p 00000000 00:00 0 
7ffe894ee000-7ffe89510000 rw-p 00000000 00:00 0                          [stack]
7ffe8959e000-7ffe895a1000 r--p 00000000 00:00 0                          [vvar]
7ffe895a1000-7ffe895a3000 r-xp 00000000 00:00 0                          [vdso]
./test-lib.sh: line 631: 262132 Aborted                 git for-each-ref --format='%(push)' refs/heads/master > actual
not ok 25 - basic atom: head push
#	
#			git for-each-ref --format='%(push)' refs/heads/master >actual &&
#			sanitize_pgp <actual >actual.clean &&
#			test_cmp expected actual.clean
#		

