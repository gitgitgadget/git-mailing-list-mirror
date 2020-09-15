Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1BEC433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C676C2078E
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvE9IPTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgIOV1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 17:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgIOV0G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 17:26:06 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72BDC061788
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 14:25:54 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h2so4397844ilo.12
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 14:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xi+inf7Qh+QMKUaYLgpZ258NRmsUFvvwrRfFY5Z4kLE=;
        b=fvE9IPTU+iN1LKLhEy98afdpAGeFlFyb2sa6C5tTycW8UvzcVCKEQD3CCUIOa0fo15
         2vXa5/UF23giv7z131Dtlbwz9smHVOBI78OAsAaysXMqeSuBWwbYs6z9DB4MZEhS37wR
         /fq7HXDXwLZ19aSWcTXmvSBeW1iCAcKRU17uRcLJqXv2cVgpVF7fQUr/muMfYlje+C8z
         E8U8R5P3yI0TOqkwl1654ToL3VgQcfUDvfI6VWLpFFxpAT9HrFWqeIVy8aDw8gzVz+GQ
         RMl8dgASyc//napCHw5aAv9hw5UXZxPmLnmP3mU4rrwSDOJOozED+UrmzoKyJxZdNBOm
         sFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xi+inf7Qh+QMKUaYLgpZ258NRmsUFvvwrRfFY5Z4kLE=;
        b=AGbAOuJjwQI+pewHm/g3sRoPdf18ltd/RaqMC0KHNQ/w8ZU+MPnsSd84Jzr18wwY3p
         8yg3juMK/pinwdLw8DqUavd0R1P0O0YPb/L7U0OocCPPUNM3/eQdSV/ToWR19hRde4Wk
         PiN7gZlEnYau/vPkFAVOqnPghZFm17SP2rDf1JBWmO9VrJDd70HWUVbsvVU5xTl6HyuW
         DDgXL+oV6FmE08qdFGx0ORg8t93cqZZrvhhhNTuN2IJ9omkIRqlZu0v6UB11l1VwXa+b
         WzVgSnEyhLyLrzq7HXVMv1mCLC/DwmdfmsWadm9IpSgegteWWAd0oIcZVaDKNOgAZ3VB
         lbQg==
X-Gm-Message-State: AOAM530qFri71Ee7hZOdzNrp5UsFAdypmr04QE/xJHLkSncxKl+jDUTr
        Avlxseo3McHKweJ1ej7Likn9M4XT/0724lTUYpQ=
X-Google-Smtp-Source: ABdhPJwoStgdyMi65CSlciVoZ9qFJIm6e+CERCV1ZT3WDsnokuNiL3FwmjYBFh21eoEb7MpW8s25Fa0htcrjPKyWGhk=
X-Received: by 2002:a92:bad5:: with SMTP id t82mr12646363ill.148.1600205153341;
 Tue, 15 Sep 2020 14:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4ko6twc9.fsf@gitster.c.googlers.com> <85ft7ivp1t.fsf@LAPTOP-ACER-ASPIRE-F5.i-did-not-set--mail-host-address--so-tickle-me>
 <xmqqimcezqs5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimcezqs5.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Tue, 15 Sep 2020 23:25:16 +0200
Message-ID: <CANQwDwc3-n4X16F1Xuf-y-yLeXoGRTeT5c=kVVFXH1E6P=ZEqA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2020, #03; Wed, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 15 Sep 2020 at 23:14, Junio C Hamano <gitster@pobox.com> wrote:
> jnareb@gmail.com (Jakub Nar=C4=99bski) writes:
>
> > Those are patches that are part of GSoC project of Shourya Shukla:
> > 'Convert submodule to builtin'.
> > ...
> > Those are patches that are part of GSoC project of Hariom Verma:
> > 'Unify ref-filter formats with other --pretty formats'
>
> Yes and yes.  What is your intention for highlighting that these two
> are GSoC originated projects, by the way?

It was to compare the final status (merged vs not merged) of all Git's
GSoC 2020 projects... in a bit clumsy way, I admit.

[...]
> > Because corrected commit date offsets are not monotone, that is after
> > value that doesn't fit in 32 bits (in parent) there can be one that doe=
s
> > (in child).  It is extremely unlikely that in real repositories there
> > would be that large corrections needed, but it can happen in theory, an=
d
> > therefore we need some way to handle overflow if we choose this option.
> > And of course we should test that overflow handling works correctly.
>
> My gut feeling is that overflow handling needs to be there whether the
> field is 32-bit or 64-bit.

Not if the size on-disk is the same as the size in memory:
timestamp_t is usually 64 bit (and even unsigned 64 bit epoch
would be enough - its range is over twenty times the present
age of the universe per direction).

Best,
--=20
Jakub Nar=C4=99bski
