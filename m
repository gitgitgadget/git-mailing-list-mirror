Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB08DC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 17:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243592AbiBYRUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiBYRUx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 12:20:53 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D77221133D
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:20:21 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bu29so10680499lfb.0
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BI0yFFp9ixy7eEpf5eN2ZEnWsTly4Bv8TGP1wOdJqdo=;
        b=BwkafG/PImo7SoHq9Du/gv2OrwKpk9ZHMeKuGM7+vWQtGSrTsIryo84Q0o3xycD+ir
         h2wTIV7tHtZUymnifH1oNLzx6CaOOlWXh2xLJlh1Tn8uo6+MG0+mUs0yXIitPzHG8alq
         F329JgE+6M/ddrzCzIwCLutAptVmtZEUXsSZZvo/JwZoKtOy8qneFQlf6mo0nEfNBt7F
         OhREzmkUhtmZ5ItjpAG/d+DHRQI7BY0SAFizXZ2vS9ZRm/JhdhP/x3cihIRbTnjJD1cf
         J3seHvn8i6q1h4YsTssf6itYEe/fPAVP/zlNK/Xa7vWOiyBi5uVWzoTgbaS/76geaGS2
         BEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BI0yFFp9ixy7eEpf5eN2ZEnWsTly4Bv8TGP1wOdJqdo=;
        b=gKSUYN9z8/EpioAe+zJ30qM97S+pHrsHHuIhEy2UlEd5RV3BvvCsEGglrT5fccM5SA
         53N3uM+pHMJ6XeyIlhg37gm+NvPxCxzAb2avm5QE/y0LW27v13P4eXAO3pEZD1gIDjNd
         SMP24EBlqZvuGY4uuT9Ey3kasolNzUaggB+S0y1iXfVnsxCStjZVfR6k0V471pDHekgK
         79rSSIGYszHCv7Az4UvnXRfJtrHrqpZecuHJATtoEruud510woV6jgNKbTPv383gnR3s
         Pei+HR44T1NVZYmcrfmoXImjGhboPXUGbIdSyEMs9cB82PplJk1ipxUDRBLfdqVomDwk
         095w==
X-Gm-Message-State: AOAM532BtkyIQgjJ8ElUGQNIa/OCjGQeNxTYEAq92VnnrRIKed0/89fn
        9DuWSf871qaWrDZvTg4o7gk4QJNSfgyGTx/MF+Tw0yeV
X-Google-Smtp-Source: ABdhPJz6SqKbnOcyMk1G0+/Dm0ySexbqJhe0tL/aGp3DWh7pYax5w1A+JBynb50HFb2zE8JKrd5BuyRV73duWvwsdhE=
X-Received: by 2002:ac2:4143:0:b0:443:ee24:b490 with SMTP id
 c3-20020ac24143000000b00443ee24b490mr5491745lfi.205.1645809619305; Fri, 25
 Feb 2022 09:20:19 -0800 (PST)
MIME-Version: 1.0
References: <20220224064710.2252637-1-alexhenrie24@gmail.com>
 <xmqqv8x4m6jn.fsf@gitster.g> <220225.86h78n88gb.gmgdl@evledraar.gmail.com>
In-Reply-To: <220225.86h78n88gb.gmgdl@evledraar.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 25 Feb 2022 10:20:08 -0700
Message-ID: <CAMMLpeTSMzx4mFjV-fQtbqo1cPfME_ekRO5Xt5TQaKGj0fmNxQ@mail.gmail.com>
Subject: Re: [PATCH v2] switch: mention the --detach option when dying due to
 lack of a branch
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 25, 2022 at 4:57 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Feb 24 2022, Junio C Hamano wrote:
>
> > Alex Henrie <alexhenrie24@gmail.com> writes:
> >> diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
> >> index ebb961be29..f54691bac9 100755
> >> --- a/t/t2060-switch.sh
> >> +++ b/t/t2060-switch.sh
> >> @@ -32,6 +32,17 @@ test_expect_success 'switch and detach' '
> >>      test_must_fail git symbolic-ref HEAD
> >>  '
> >>
> >> +test_expect_success 'suggestion to detach' '
> >> +    test_must_fail git switch main^{commit} 2>stderr &&
> >> +    test_i18ngrep "try again with the --detach option" stderr
> >> +'
> >> +
> >> +test_expect_success 'suggestion to detach is suppressed with advice.s=
uggestDetachingHead=3Dfalse' '
> >> +    test_config advice.suggestDetachingHead false &&
> >> +    test_must_fail git switch main^{commit} 2>stderr &&
> >> +    test_i18ngrep ! "try again with the --detach option" stderr
> >> +'
> >
> > OK, we try to be consistent with other tests in the file, and leave
> > s/test_i18n// to a file-wide clean-up outside the topic.
>
> FWIW that's not the case here. This is the first use of test_i18ngrep in
> this file.
>
> But better to use test_cmp as noted in
> <220224.86sfs8abj6.gmgdl@evledraar.gmail.com> in the sid-thread.

Why is test_cmp preferable to grep in tests like this?

-Alex
