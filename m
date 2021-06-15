Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847E9C2B9F4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A1DB60C3D
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFODNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 23:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhFODNz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 23:13:55 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0E2C061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 20:11:51 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g38so18384546ybi.12
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 20:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DH6LJ+dNvxFOj8d1qagH86GUwPkmY6Sno6XMtJ8GtqU=;
        b=YTq8lgkBySOGIvX1GH4rsq649S+9+97uOWr+eOJ/cjkQPxso1TliXvbdgf+Y1Rr7zN
         yeLqrZHC1+3BKRTdVjpoDK1ift4Mv2qynJfc4VkBHnHSifhKILfCNtF9bA+qQy1m46q7
         49qtRSHZWPneJuTA7hjMgNvlYZNqDRwowtSK3tiqXXcRC0Qqf24Qk5odA+old41nLVAR
         EhC++W4GBL5cbSI91gNB/s6npze5djtHV17dDAl1fx9vTlVqKe8D1Ez+jEQozrJoJDFT
         xuMvSExvCtr5nNZ4J6qluM6gdCrFovVfH876aaQhiHPZY1tsObt797DPzvl/s3MvdsWI
         NhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DH6LJ+dNvxFOj8d1qagH86GUwPkmY6Sno6XMtJ8GtqU=;
        b=eWLXRuYuj76qZOGc3ypXjEus97m2H37M1ZnIerkMrdivzCQfcBpK7yN6X1o/PG8x2B
         XAWiN9vJsSoyVK2UhCZNJK9LGP7oE4x53OcUpJMwVt9VYP7OK/1qWiY0oH1G5SEC0QJN
         a1qkP0vVcm98mH1u4+0ZM6T9LG4jfHGoJxE817YMS6s6XqEiKmWKOL/xENA2+pZ52gPe
         /X3dEqhxlUDbOHEugqGfV2wVhyeD/9vFwCDTnGF0LjMl3ryluggtq3VoAkWlq4ElJA2N
         DrORDHnr6u9Tdvx8x2+AWdHNHgahls3A0Dzw2cwlSnwYpPs/I0c0i5l0At8bJNU/XFOp
         Mj+w==
X-Gm-Message-State: AOAM530sipwM16TPwG6Ma8S8ybnEyN4+WJ/7wIZJe3wq9rdhXdnmbY95
        ZX6mtEv3/sOwEI16JWV7sIauHwNvwJI7Oo0KlnM=
X-Google-Smtp-Source: ABdhPJyL6zxi+BRWySQaqJyiRAJpSDvOXJJV5YYaLLD6OSNiDNiiz8GJp/C/1PuJUQVnkFXN5RRE6lnAHRTOqsf7T1o=
X-Received: by 2002:a25:81c5:: with SMTP id n5mr28891192ybm.323.1623726710824;
 Mon, 14 Jun 2021 20:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <87im2s5jjm.fsf@evledraar.gmail.com> <20210612050711.4057-1-worldhello.net@gmail.com>
 <xmqqa6ntytks.fsf@gitster.g>
In-Reply-To: <xmqqa6ntytks.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 15 Jun 2021 11:11:39 +0800
Message-ID: <CANYiYbHA+obZPPNw3Oc0h5BbtdVyqpxOK-u3dxDB-sQbdcY0yQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Fixed t6020 bash compatible issue and fixed wrong
 sideband suffix issue
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8812:10=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > In addition to fix the bash incompatible issue of t6020, find another
> > issue when try to rewrite t5411 to compare raw command output.
>
> Do the three later patches depend on the t6020 fix, or is this made
> a 4-patch series only for the convenience of sending them out?
>
> It's not like get_abbrev_oid() used in t6020 is defined in a common
> part of the test library and later used by other tests (instead, the
> patches duplicate this helper function into yet two more files).
>

Will split it into two patch series. One will fix bash incompatible
parameter expansion in t6020, another will fix clear-to-eol at packet
boundary issue of sideband and try to test raw output in t6020, t5548
and t5411.

I also queue another patch series, which add "--bare" support to
"test_create_repo", and replace "git init" command in test cases to
adapt to variable GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME.

--
Jiang Xin
