Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB9DC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 20:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiCCUcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 15:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiCCUcK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 15:32:10 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC672186BBB
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 12:31:24 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g39so10505704lfv.10
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 12:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iAnlNmWv3XnYTrrhLzLsmvddt+3PUhMFcwEDNAcaecs=;
        b=XSpKyR/p+tN658yZhSfJjo0KZ4lFJdmJVQVL+t4OwMiOABRj1w3pTdBe/yCyzZJ1Tv
         8PIAf1j7CimT+POlFCkToTpv7MLHWWYqBrDGRnnJzrkA5VdwL26lCXBpzyC55A5YtfP0
         xZB9HHzmczA4gjXUSFoAlPnjeDa760c0xBf9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iAnlNmWv3XnYTrrhLzLsmvddt+3PUhMFcwEDNAcaecs=;
        b=zhtDIP80QScw1YXV1EoiM91z1CuB/Zt/4UCMF70bCVDYbfRi4Lc5ESibeOhVjppmu1
         G1oLIaOwTNl9O1r5IY+JdHwWUL1PcDr91aNzwbTR20EEDcCcOs623iz/zpJVHizGOne7
         CJ77hvmGhfPXGOyg5a9FIZRAcc/MmcsH1nxDnTHrDL01mQ21YiyDPQwcDZ/0+gZe7a5r
         tGQVfF4BR+wdnLEy4qVG1UEP/+QPsXlQ26rnD3LGfIEW44//OCHopyv0xEX34t/fhO/p
         NI6doZ8vtT2pwqcUhF80bZT22PQAj8OF5NSJB/jgPoRuOoy2jXVtXIBPFUtcWvZkSmGq
         dmNQ==
X-Gm-Message-State: AOAM5306uiG+TDFMpLvYDt7IRxO2/H+gCMjdMVJ+WN/JKveDW379a0FT
        NwFMvzCuiidVd8rHPQPmA957QLiaNZvxA6q6
X-Google-Smtp-Source: ABdhPJzzcTkTXNWGvnSaBdANDaGFZMoJgdvTdgTDFD5GFgxAs5G8Fo7ds8UtOjlEqVbRrOqYAHroYA==
X-Received: by 2002:a05:6512:1096:b0:443:9258:1d48 with SMTP id j22-20020a056512109600b0044392581d48mr22313554lfg.681.1646339482590;
        Thu, 03 Mar 2022 12:31:22 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id c16-20020a056512105000b0044315cbf157sm617490lfb.64.2022.03.03.12.31.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 12:31:21 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id v28so8327025ljv.9
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 12:31:21 -0800 (PST)
X-Received: by 2002:a2e:aa1f:0:b0:244:c2ea:7f20 with SMTP id
 bf31-20020a2eaa1f000000b00244c2ea7f20mr24315799ljb.164.1646339481302; Thu, 03
 Mar 2022 12:31:21 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Mar 2022 12:31:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi2HkQ648sYe3BusCEh5tBYjJbQ9c5T-DrykfEdgRbi=g@mail.gmail.com>
Message-ID: <CAHk-=wi2HkQ648sYe3BusCEh5tBYjJbQ9c5T-DrykfEdgRbi=g@mail.gmail.com>
Subject: Silly 'git am' UI issue
To:     Junio Hamano C <gitster@pobox.com>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok, so I'm "intellectually challenged" sometimes.

I tend to apply patches with

    $ git am -s --whitespace=fix <filename>

and just a moment ago I had a senior moment, and instead did

    $ git am -s --whitespace <filename>

and then wondered what the heck was wrong with my machine for being so slow.

I ^C'd it, and tried again, because I really am not a smart man. On
the *third* try, it finally dawned on me what a maroon I was.

The problem is obvious when I list those "right way" and "wrong way"
next to each other, but even then the *behavior* is most certainly not
obvious.

And this is really just a problem with "git am" (and possibly "git
rebase"), because they know that the "whitespace" option needs a
value, but they don't actually _check_ that value. They just know it's
a "passthru" argument to "git apply" (and "git am" in the case of
rebase).

So what happens is that "git am" decides that <filename> is the
argument to the "--whitespace" option, then doesn't see an argument at
all, and expects the input from stdin. So it "hangs", waiting for
input. No error messages, no nothing.

If you actually do the same thing to "git apply", you don't see the
problem, and it clarifies things:

    $ git apply --whitespace <filename>
    error: unrecognized whitespace option '<filename>'

and it's all very obvious what is going on.

But "git am" never even gets to that stage, because it is busy waiting
for input that will never come from the terminally confused person
sitting in front of the keyboard.

I don't think this is a bug, exactly, but it did make me go "Whaa?".
But that may be because my other neuron hasn't had enough coffee yet.

              Linus
