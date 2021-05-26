Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0064C47082
	for <git@archiver.kernel.org>; Wed, 26 May 2021 22:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB14B613B0
	for <git@archiver.kernel.org>; Wed, 26 May 2021 22:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhEZWD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 18:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbhEZWDY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 18:03:24 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D66DC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 15:01:51 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o27so2696764qkj.9
        for <git@vger.kernel.org>; Wed, 26 May 2021 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=blhaY+Q4fnweo6VHU9n2AYyJ1OyBrPI2LAprNePDfoM=;
        b=pkBzVnuMQqxpn694XSXPhISa2GOZ7+RvI7eo6TfEKVNu5BXBef7eZP2phOfTRPFZHG
         c1Mz7hT783qR+inVZ5oXK2hFpoQHXBqwNn1dT9IJq8dKjtsnnns4LB+WZ3+XQmnFjeys
         lqAaWKl19hYSoP/P/NyjJSvA7gI8wu6e3+nQJHXGJu5X5USn/jRrVgCuNrkbXVp17JfV
         /D7omRu1IpXkwLZP2uzjDRFXNRbZJyYSdKVn25M4VDBXjMK0nXZ9FcSCsf5xe96edC47
         ILq1pXJDI+KayYA1jlHGgDEafGgL44vD+KNjhDw86yA9v0nydBPX8ZZ5R7PGKEPbcCGC
         Qfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=blhaY+Q4fnweo6VHU9n2AYyJ1OyBrPI2LAprNePDfoM=;
        b=to7MxLYixB0zOIWngmLoD/FJdl8R0WB+VcHudd0lHDKfizotDiSqPtCUGi8S+m3V8V
         pbCnfYMbFxhUrdUH71msocpEstVnQKojLx52MuZCP3eLUcWm1Hh/VDyGtUP7Baz3QUo5
         lCg81lI0EhWwJS9snMfZlResAv0ooapjscPcz2n24h6ta4k80QCf2YrzulG+v7A4wF7m
         Y9wJsQyGB6pf5YKYi3ecqKbreFxN8H6eFjGBmUM6VufUbLQiaBV3mG7TN9WHrSC6NHtr
         ILgLKYfysDtLASBW2U14XmI00ZkNfF4HzZlCKA6i45nCr5uV6PJ0PB0AsG9fc7VqPboA
         0z8w==
X-Gm-Message-State: AOAM533bpsf0qphsh12hSpBPjo4iRTEWiss3mVKiHOwFRo7x6FQ+eeC+
        aNOtbbfVbP3wO+KydGRfSBYyE4LBRdNXjbOnxmgNyw==
X-Google-Smtp-Source: ABdhPJx2GS5KgXx+SaMrNA0qRM3qyhK9r80nbQWQnWb95wPKdgE2ETKALEvuFSNJn0qRND1rIx0n7fLH+1Cvi7hr9ik=
X-Received: by 2002:a05:620a:210e:: with SMTP id l14mr281841qkl.1.1622066510467;
 Wed, 26 May 2021 15:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620145501.git.matheus.bernardino@usp.br>
 <667777053ab853ef2f94b7ba4ab39f7241d2b49c.1620145501.git.matheus.bernardino@usp.br>
 <87eedtmj7w.fsf@evledraar.gmail.com>
In-Reply-To: <87eedtmj7w.fsf@evledraar.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 26 May 2021 19:01:39 -0300
Message-ID: <CAHd-oW6X4cwD_yLNFONPnXXUAFPxgDoccv2SOdpeLrqmHCJB4Q@mail.gmail.com>
Subject: Re: AIX failures on parallel checkout (new in v2.32.0-rc*)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, =C3=86var

On Wed, May 26, 2021 at 3:40 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>     + test_checkout_workers 0 git -C various_sequential checkout --recurs=
e-submodules B2
>     error: Your local changes to the following files would be overwritten=
 by checkout:
>             d
>             h
>             j
>     Please commit your changes or stash them before you switch branches.
>     Aborting

I requested an account on the GCC farm to debug this, and the problem
seems to be that AIX's `cp -R` defaults to following symlinks instead
of copying them. In the above error message, 'd', 'h' and 'j' are all
symlinks which were followed when copying the test repo, so these
paths indeed won't match what's in the index, which makes checkout
abort.

Fortunately, there is a POSIX option to force cp to copy the symlinks:
'-P'. Adding this flag to the cp invocation at line 117 of t2080 makes
all parallel checkout tests pass on AIX.

We also already use `cp -R -P` in the test suite (at t7001), and
without any prereq, so I guess all platforms we are testing git at do
support this flag in cp. I'll send a patch adding the flag at t2080.
