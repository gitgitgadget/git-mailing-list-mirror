Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46B1320899
	for <e@80x24.org>; Mon,  7 Aug 2017 10:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbdHGK7K (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 06:59:10 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38792 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752835AbdHGK7I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 06:59:08 -0400
Received: by mail-wm0-f52.google.com with SMTP id m85so4061877wma.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2oJLYNtXTcWKvf0A/2fwnfyveEEo2Vc1SRjupsKGHCw=;
        b=Se9cDaa4+QuoRac8LAP2Io9s/0g+ApMm3clO6H4BNt67myFUOGp/u91sNAYtcjPrag
         hw8adfQ56mSr2O6a6GsYdXwdz5s0+WIFz50JJDEhechDAPPr3rySarnYHpqltrhz+BjO
         51wmqrVrexXxARQAb7oZPolcRAfyybC3WWUTaWyFqq0+YyEXJZFcUcHi+q6ti9746/Fm
         bhSi8/C51PLC2KzjnWuzVC4ffQPYf49+BiBRlWKak2LImJDFEssDGgfqejQhyTrUODgU
         aCB9nwY/pfMxOLKhKkNLsRT2OQRCaXvXSHnk+2FnN7GCI5jF7r9Ocov16ekpOHhr1mVd
         48Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=2oJLYNtXTcWKvf0A/2fwnfyveEEo2Vc1SRjupsKGHCw=;
        b=Z4ZrIXKD3R5AeZhfwOV1T9VlDQGDYSjyVAMO6wRqW8x+p115zkQ3mxkUIMpCDA4OF1
         oNUWkk4efWKDWzDrM/CQXKo+leMuGMs+SDeq45jhiLRFTwb9uASNIl6+E0c/s4+ors0i
         ZSS+Nct7Fib8S5jSfsWi7kBoQVXP98Aw6ERjFzaM3pVeq0TXw0ARVyq1gNoWORRnJT9p
         6PpYzeXiyMwYAPDxn83db+s/xzXAcyTSEz9qfGunTu+kBk7RTP6eYZ9R3ht591kD4S5w
         fdcZ1XYEz7D5N9Dr0B2XJ7hETlNW9khVSHM7fpyCMs3yIm01GsOIEaJJY27iPNnZA9L+
         KPlA==
X-Gm-Message-State: AHYfb5gRrecYQvV28Lr/XxqObeSdYEUfELh2pafVNRkUNMfd0KxsuxU4
        FEU9pkaCQCQZkA==
X-Received: by 10.80.152.28 with SMTP id g28mr568185edb.138.1502103547554;
        Mon, 07 Aug 2017 03:59:07 -0700 (PDT)
Received: from snth (157-157-140-194.dsl.dynamic.simnet.is. [157.157.140.194])
        by smtp.gmail.com with ESMTPSA id p49sm7626880edc.47.2017.08.07.03.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2017 03:59:06 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1defkX-0005U6-Ar; Mon, 07 Aug 2017 12:59:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Coppa <dcoppa@openbsd.org>
Subject: Re: [PATCH] tests: don't give unportable ">" to "test" built-in, use -gt
References: <20170806233850.14711-1-avarab@gmail.com> <20170807011832.oy6lxf2ewkmzg65s@genre.crustytoothpaste.net> <56fd58d6-acc7-042a-1b68-9854ed54361b@web.de>
User-agent: Debian GNU/Linux 8.9 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <56fd58d6-acc7-042a-1b68-9854ed54361b@web.de>
Date:   Mon, 07 Aug 2017 12:59:05 +0200
Message-ID: <873793zls6.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 07 2017, René Scharfe jotted:

> Am 07.08.2017 um 03:18 schrieb brian m. carlson:
>> On Sun, Aug 06, 2017 at 11:38:50PM +0000, Ævar Arnfjörð Bjarmason wrote:
>>> Change an argument to test_line_count (which'll ultimately be turned
>>> into a "test" expression) to use "-gt" instead of ">" for an
>>> arithmetic test.
>>>
>>> This broken on e.g. OpenBSD as of v2.13.0 with my commit
>>> ac3f5a3468 ("ref-filter: add --no-contains option to
>>> tag/branch/for-each-ref", 2017-03-24).
>>>
>>> Upstream just worked around it by patching git and didn't tell us
>>> about it, I discovered this when reading various Git packaging
>>> implementations: https://github.com/openbsd/ports/commit/7e48bf88a20
>>>
>>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>> ---
>>>
>>> David, it would be great to get a quick bug report to
>>> git@vger.kernel.org if you end up having to monkeypatch something
>>> we've done. We won't bite, promise :)
>>>
>>> As shown in that linked Github commit OpenBSD has another recent
>>> workaround in turning on DIR_HAS_BSD_GROUP_SEMANTICS and skipping a
>>> related test, maybe René can make more sense of that?
>>
>> I've confirmed using the NetBSD 7.1 man pages that NetBSD will also want
>> DIR_HAS_BSD_GROUP_SEMANTICS.  MirBSD will also, according to its man
>> pages.
>>
>> As I understand it, the only consequence of not setting this flag on BSD
>> systems is that some directories will be setgid, which, while ugly and
>> useless, should have no negative effect.
>
> Right; specifically it's for newly created subdirectories of shared
> directories, which we want to be owned by the same group as their
> parent. That's the default on BSDs, and we have to set the setgid bit to
> turn on that semantic only on other systems, e.g. on Linux.
>
> 81a24b52c1 (Do not use GUID on dir in git init --shared=all on FreeBSD)
> introduced DIR_HAS_BSD_GROUP_SEMANTICS with the rationale that setting
> setgid on directories may not even be allowed for normal users.  I can't
> reproduce this (t1301 succeeds for me on FreeBSD 10.3 even without that
> build flag), but apparently at least in some configurations it's not just
> a cosmetic issue.
>
> The skipped test 'init in long base path' in t0001 is a different kettle
> of fish.  getcwd(3) on OpenBSD respects permissions on the parent
> directories up to root.  E.g. after "chmod 711 /home" normal users would
> get EACCES when they'd call getcwd(3) in their homes there, while e.g.
> on Linux and FreeBSD they'd successfully get their current working dir.

Good summary. As openbsd-tech points out it seems the bug is ours, if
I'm understanding this correctly:
http://marc.info/?l=openbsd-tech&m=149625768825173&w=2

    [EACCES]
        Search permission was denied for the current directory, or read or
        search permission was denied for a directory above the current
        directory in the file hierarchy.
