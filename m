Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D6031F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 11:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbeGKLEq (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 07:04:46 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38430 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732502AbeGKLEq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 07:04:46 -0400
Received: by mail-ed1-f52.google.com with SMTP id t2-v6so4301098edr.5
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 04:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=d+yeslBOglY4d+gtaRNiF7xJdu5gf3k/Ks6MYDRoGh0=;
        b=Rh21WcyiJZ6cqFTstMQrihBEWBVnIsCFYjL9sIX9JfD8IvlKak6XCVbdBA0uWv26sz
         tG5/rmZb7IsSiDBPauVWl+GtKVyNSchSNd7q4gpdq4p423oQkaBy21gnXza9j0+wQVbs
         K1Q2oMbGPxj6My+3XE+Bpu9DwLrj+yIo48+kyTKrYgkb+vpm5PWKz1bmaTtkbtpk2yn0
         0GUsMPU0d4WWfSlmoLeQ30VyL/GEHkXrEqdhseM5gmLK4V6haFJVMX50+/2StvQB53R/
         o6ZI/PGGTggRbKj+gQuVyCPGZcBq8WDju+mQnuXeVHkzooqUPRMNMXySuyNqLrL2CApz
         3xiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=d+yeslBOglY4d+gtaRNiF7xJdu5gf3k/Ks6MYDRoGh0=;
        b=Gmva28NyYZ7MGnwtkVFrKnR61na8PTOBfrRnwkxRCsToUIrRKdYiHwCMt0idK1wg7K
         Diac9B12Z/5okPi6J6aVuvYJ7ta9c2tp7Ils4JEOp+Gcv8Ccp30pt0zQ2IMjS6RuF8tq
         9BZW7Kx9cMhBVFCDDI3vJh+L97nK+10b6TZxOyOjM/Z2FleH0tTsHIABQJH9Kh22kM6s
         TvxWtf6DDnap1KYJeCvyr0RArMKm0qfuvIvtnoC9dlv7E4VTQMEjWw713tkPOzjevg8m
         aCMMrPzkiWmmoZIxkROnERhtP1CEddrfu5XUX9q195XPo5p3mIA0zalLrRh2nSzYdMyl
         piRQ==
X-Gm-Message-State: APt69E2YKEb6zc5dsb2jC47edB+qDtOhv8pr9J3ZOpO553seUrXkR3pS
        mzgEygly+mihEDVNPrkdCyxt7lP0
X-Google-Smtp-Source: AAOMgpe5hE+UFbUjKg0wO1fg/3FSiyRMmBN73SLos2IC/NHWqdDC8kQACf94AEcnjLMHmXNnarKpBg==
X-Received: by 2002:aa7:d0d8:: with SMTP id u24-v6mr18507721edo.144.1531306858514;
        Wed, 11 Jul 2018 04:00:58 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id u3-v6sm2927895edo.44.2018.07.11.04.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 04:00:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: BUG: Segfault on "git pull" on "bad object HEAD"
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Wed, 11 Jul 2018 13:00:57 +0200
Message-ID: <87k1q2c9zq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This segfaults, but should print an error instead, have a repo with a
corrupt HEAD:

    (
        rm -rf /tmp/git &&
        git clone --single-branch --branch todo git@github.com:git/git.git /tmp/git &&
        echo 1111111111111111111111111111111111111111 >/tmp/git/.git/refs/heads/todo &&
        git -C /tmp/git pull
    )

On this repository e.g. "git log" will print "fatal: bad object HEAD",
but for some reason "git pull" makes it this far:

    $ git pull
    Segmentation fault

The immediate reason is that in run_diff_index() we have this:

	ent = revs->pending.objects;

And that in this case that's NULL:

    (gdb) bt
    #0  0x000055555565993f in run_diff_index (revs=0x7fffffffcb90, cached=1) at diff-lib.c:524
    #1  0x00005555557633da in has_uncommitted_changes (ignore_submodules=1) at wt-status.c:2345
    #2  0x00005555557634c9 in require_clean_work_tree (action=0x555555798f18 "pull with rebase", hint=0x555555798efb "please commit or stash them.", ignore_submodules=1, gently=0) at wt-status.c:2370
    #3  0x00005555555dbdee in cmd_pull (argc=0, argv=0x7fffffffd868, prefix=0x0) at builtin/pull.c:885
    #4  0x000055555556c9da in run_builtin (p=0x555555a2de50 <commands+1872>, argc=1, argv=0x7fffffffd868) at git.c:417
    #5  0x000055555556cce2 in handle_builtin (argc=1, argv=0x7fffffffd868) at git.c:633
    #6  0x000055555556ce8a in run_argv (argcp=0x7fffffffd71c, argv=0x7fffffffd710) at git.c:685
    #7  0x000055555556d03f in cmd_main (argc=1, argv=0x7fffffffd868) at git.c:762
    #8  0x0000555555611786 in main (argc=3, argv=0x7fffffffd858) at common-main.c:45
    (gdb) p revs
    $4 = (struct rev_info *) 0x7fffffffcb90
    (gdb) p revs->pending
    $5 = {nr = 0, alloc = 0, objects = 0x0}
    (gdb)

This has been an issue since at least v2.8.0 (didn't test back
further). I'm not familiar with the status / diff code, so I'm not sure
where the assertion should be added.

This came up in the wild due to a user with a corrupt repo (don't know
how it got corrupt) trying "git pull" and seeing git segfault.
