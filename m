Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6E9C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 12:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiKSMBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 07:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiKSMBV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 07:01:21 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A17697A9D
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:01:20 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n12so18855917eja.11
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=123yo0QSx503XrpnLyA8tuvskZEl6wFq1+Gcfg/cVKc=;
        b=FtnziYijNmYVDV7vReuRnUjWnPhkaJcrQcBzqiqs0ExfeXn4aXRSp+Qd9w4Y6g7JHG
         QylKf4ljShLYs+nYNK3dKptruVDaRA096yx98dWR+xHXpCu7DPMtG5YJ+VTYiS6fLokH
         vQmZwXdLA5FtJJEqFeluhlD2rFAg5paFaBEP2DaxlkpOEE81BMvbxNEWdTHn7Yf6WfEV
         P7NGvWEqhi/yXN1GhyATTy34snOhbfHJXRV+y1jhphlkZUZUHnTZZLB61jb8c0sMbEE0
         EWlI+PPksM8RFlKXW/9Pq21mEkFNaXEKq5aV+XUsef7TUQBHzcZ4+KlrZmJBLBoKmq5P
         R65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=123yo0QSx503XrpnLyA8tuvskZEl6wFq1+Gcfg/cVKc=;
        b=iGssFEN812hHsHX0O+0wI9dZE6tln1aKtKSEatA9wrD1fAOphpbGKQoH10L4ACJoj1
         NdRSQQLAzSi+HsN4fu/Nxv1OIltd5W/7o3sosdu8YdOvsWiZ+9Cnxp6ILk2ZEBk8l4IR
         Vh3naWgxGp33QmBp7EenD3r4cgIZDfNRv0X5WoEefz3KiYBu6NvKumdDBwmJj/N16Prc
         oMBXPexFF1yaeG6KipRUhoRhX7ccbuE7CSeLm+UiOcZ7lRc5u8TMTl2pdHGCwUU69CRL
         5Bj7ipEP5PB22c/CyyppQHQmyCJ9TxgU3QfDZrmZeGcTzfdH8nirxAe75aRqVkaGTUcb
         tqGg==
X-Gm-Message-State: ANoB5plG+tXX4ba+6SQgNU87DSzwkKAQPwYBil8MrGi63KqWnFif54br
        ZqCzZAfqULT1ZGRns5+8iDo=
X-Google-Smtp-Source: AA0mqf4IjHO/knFAI61iB7yqkntSb/4Jm4FLCTcOVEPPjkGzKTjIlJ6FlN1tRKd6WcM8JU6hNh3dCQ==
X-Received: by 2002:a17:906:77db:b0:7b2:8a6c:162f with SMTP id m27-20020a17090677db00b007b28a6c162fmr9015874ejn.693.1668859278674;
        Sat, 19 Nov 2022 04:01:18 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q7-20020aa7cc07000000b0046191f5e946sm2864119edt.21.2022.11.19.04.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 04:01:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1owMX7-006BF8-2J;
        Sat, 19 Nov 2022 13:01:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Date:   Sat, 19 Nov 2022 12:54:31 +0100
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
 <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
 <221114.86tu31lnwr.gmgdl@evledraar.gmail.com>
 <pss2rp96-qr48-21p4-36on-ns04nnp0944q@tzk.qr>
 <221114.86pmdplbs5.gmgdl@evledraar.gmail.com> <xmqqr0xzkfz8.fsf@gitster.g>
 <Y3hF1vOQ8waqpvXo@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y3hF1vOQ8waqpvXo@nand.local>
Message-ID: <221119.86wn7rdugi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 18 2022, Taylor Blau wrote:

> On Fri, Nov 18, 2022 at 03:19:55PM -0800, Junio C Hamano wrote:
>> Well "! test_cmp" is wrong anyway, because it _expects_ two files
>> are the same and gives more detailed diagnosis when they differ by
>> giving "diff" output.
>>
>> If you expect them to be different, "! test_cmp" would give
>> "detailed diagnosis" in the wrong case, i.e. the outcome is what we
>> expect.
>
> I agree that "! test_cmp foo bar" will give output about how "foo" is
> different from "bar" (and halt the test only when the two have the same
> contents).
>
>> So the caller must do "test_cmp !" whether the underlying
>> implementation of test_cmp uses "diff -u" or "diff --no-index".
>
> But this confuses me. "git grep 'test_cmp !'" turns up no results, and
> furthermore, test_cmp() itself begins with:
>
>     test "$#" -ne 2 && BUG "2 param"
>
> So I am not sure what you are referring to.

I think we've got got a bit sidetracked here.

Junio's pointing out that a test that would do:

	! diff a b

Is pretty stupid, why would you want to show a diff of differences, if
you're expecting it to be different? Just use:

	! cmp a b

Or something. That's correct. So I think probably those "! test_cmp"
uses would be good candidates for some clean-up to make the test suite
pretty.

But what I'm pointing out is that by having "test_cmp" be something that
invokes "git" (or a helper) we *must not* negate it using the shell's
negation, we have to use "test_must_fail" for anything we build
ourselves.

So, the proposed patch would make the existing cases where we do:

	! test_cmp

Cases where we'd hide a segfault, whereas before it was maybe a bit odd,
but harmless, and working as intended in the sense of reliably passing
if we had differences.

So no, nothing currently does "test_cmp !", I was suggesting that
upthread as the least invasive way of having "test_cmp" safe'd under
negation, now that we were having it call out to "git diff" (or a
helper...). It's the pattern we use for our own test helpers that invoke
our own binaries (and if we don't, that's a bug).



