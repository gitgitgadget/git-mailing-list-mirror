Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DEFC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 05:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801C46143A
	for <git@archiver.kernel.org>; Wed, 12 May 2021 05:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhELFOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 01:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhELFOV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 01:14:21 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDF4C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 22:13:14 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id v22so16334220oic.2
        for <git@vger.kernel.org>; Tue, 11 May 2021 22:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=pwDEooVV/eNOXeT4/kSAxkNd0Vpt3BYS4BCqaKP8AHc=;
        b=asjLlv6IyUT7rsRNWLw6L6wqxDgGFnRc8H9aS//Lb0ePyAJRn1vOSif4pjTT28HB2P
         3cc04Un1dYIJSrmj3QrWoPWfn+6ywuTfrt0d50/rMRUsd/0ULOE2fYKd+5TgX7iC5uCw
         H7BBBqLvSnwgqCJ2SRm+jj8BgxRrRtm3UjvkznKYZgI0T0hVg8DUkJU6QDXv7MDlIEri
         5nsY25aXm34qGlfmeqz7ZqDsk90sUEC2gNZIXX23ualyHohIL9PJe1hwlJtCAJi2XUwR
         0XWsGKtP/nlJccda4JXv8+Uqs4913GMrsZtcWFMiJMjvpVYHzX1DHiMYf3DfdjMYJXcB
         iCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=pwDEooVV/eNOXeT4/kSAxkNd0Vpt3BYS4BCqaKP8AHc=;
        b=Ch2ZVnkR0fo20zSawMq90wihkzDO3hc2wr3+RS0O3EnhzDqlkwepAiwS/m1unmBHod
         hl00CPAv9NXsI9I3XIhM1YY9RpNUoQYLy3WQJdkW3Z45CUJmE7T8f2dXLWiZ50fd4BEm
         SI8NsSp/IPbFSIMphFZIlSQeqMs7X+5hVC8f0wxS7pF1yrCyaRxIqm8IjlsTMSPuwwnr
         Wg5JYvHyGQae1NEz4zrPG4TxPxA6nvx8wP0e6wjr7kWNdxH++ets9Qosx+nrgEmsRoQl
         stZJKDgDJVAnNcpwtLK80AEwbld32vhRsf2+hDIZZV4MS3z9JogXy5YSs/SoVm3JRMzy
         j/gQ==
X-Gm-Message-State: AOAM530BCuPSm2nU+x0NjTTm2+qwaaQHGA6I71tmwXRpFQIrxYsrSnjB
        sEvCjZYky0rtqbTRk3giYT8=
X-Google-Smtp-Source: ABdhPJxJFMGeFwS2POhCn9qJhPvAYTt7Oz5PRuCme17811SDBu0q6Y3P3UoehWUh3VAbyz1s8Lrk1A==
X-Received: by 2002:aca:a945:: with SMTP id s66mr6255073oie.165.1620796393672;
        Tue, 11 May 2021 22:13:13 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a4sm3685950oib.17.2021.05.11.22.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 22:13:12 -0700 (PDT)
Date:   Wed, 12 May 2021 00:13:08 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Message-ID: <609b63e48fd49_6d7da2086@natae.notmuch>
In-Reply-To: <20210512040926.GN12700@kitsune.suse.cz>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch>
 <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch>
 <20210512040926.GN12700@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Tue, May 11, 2021 at 10:43:38PM -0500, Felipe Contreras wrote:
> > It is a paradox called "the bikeshedding effect". When you contribute=
 a
> > complex and convoluted change it's easier to get it in because few pe=
ople
> > can object (as few people can understand it). But when you contribute=
 a
> > change as simple as changing the color of something, then *everyone* =
can
> > opine (literally).
> =

> You forget that what you are doing right now is bikeshedding after the
> fact.

Except that's not what I'm doing.

> You can use 'affect' or 'impact' and it generally conveys the same
> meaning.

That's clearly *your* opinion, but that's not my opinon.

I'm not arguing between blue and red; I'm arguing between water-based and=

lead-based paint.

The difference may not matter to you, but it matters to me.

If it's bikeshedding to you, and it "gnerally conveys the same meaning",
why are you arguing against?

-- =

Felipe Contreras=
