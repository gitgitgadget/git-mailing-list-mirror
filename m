Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7610C433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 21:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BC920737
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 21:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bocoup-com.20150623.gappssmtp.com header.i=@bocoup-com.20150623.gappssmtp.com header.b="wngCDm/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgFIV3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbgFIV3e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 17:29:34 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125D8C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 14:29:34 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id v26so57873oof.7
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 14:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bocoup-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDdkkNqSQCwn4zE1WxsGOkEJv7N2i/5Ez42MjE4KxR0=;
        b=wngCDm/y1yRB3ddfLU210XEYrxEwhWqAASaG3/2WeZzqP2j+LsyCdwX9tkEVL5A67+
         qgDtrCwODTXHYNaS6TjjM2T90qheEjGobPi4gSv94OqPxEvCX54LYbVJLuuzOrdnukfQ
         S5puFnN0ot0QntQos0JVqu+zFYg02imMJdD6HijEH4p4WwEYW0yVpMknMF+nvNAV3yKu
         ugrvW/A9QTgHmN/EmqRnqL5Vya6xIxBS0v5qZmWtZgIIBgBWYlsb2YM0EDcJZU2auJr5
         +lgYNpmEx12to+yKPFXbQ2IEi1LuS21j/+YUjbr4k3uCjijuHN7rTKVwE2EtsScJXaK/
         BMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDdkkNqSQCwn4zE1WxsGOkEJv7N2i/5Ez42MjE4KxR0=;
        b=RbZNT3/viSKITOWuJbbd8+68duRnvcqYMPcOuOYy3HoEaLUwOePhBK8L51R2uHW07m
         EhRSj5fXGsyVSakVl2T7Aoe2N/bmNMEULDCPhT7ZQ8tvGVg5vXiYMhbHH5+x3as0cz3y
         Y0cs6nEH0GAQMPuIlZgM5z1MbEwfizv5DgYgQDxYTf6H0tk8F4DHhiQBcP2qdvkSuGoG
         6uUnOl0Ge6Odo975R0A25sO87vIBFGwMqU/+bpw/jYZt40suxi0C8l5+tKFonSaG1ffb
         UL+PVF67DZoTPfRry2jxAnJ6BbFe2H/QSbo0PO4HVi6FRGLhSgUy0Aq2/chMaalJRF45
         J1lg==
X-Gm-Message-State: AOAM533A/gwKo8Ms+hwpHKllfdKfa31vc+x4bf1ANVdwCtYtMLEvURMq
        DfD99Qaj0yfOM2MvPTTU523wOLx6TRROlTKh4ZRtnFZJFYCMtg==
X-Google-Smtp-Source: ABdhPJyqX2H/FTQIkWo+5mlL8xJsvdIhU7KklYADcJjpiWUdLTj61dUNC/8xDtKqcv37Fur3oiq1GL2axG+9eM5zEqo=
X-Received: by 2002:a4a:a785:: with SMTP id l5mr23096662oom.74.1591738173460;
 Tue, 09 Jun 2020 14:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net> <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
 <xmqqeeqoi5wc.fsf@gitster.c.googlers.com> <CAOAHyQzxG7Lc6+PLBtM6oe9vSoEEAmuXAaKF2VzO_phtkfGRVA@mail.gmail.com>
 <xmqqo8psgddz.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8psgddz.fsf@gitster.c.googlers.com>
From:   Simon Pieters <simon@bocoup.com>
Date:   Tue, 9 Jun 2020 23:29:22 +0200
Message-ID: <CAOAHyQyn_ow7_nCJ+Jorr76_=1=_kuBAD1KhqReqVfRQQbmgiw@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, don@goodman-wilson.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 9, 2020 at 11:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> > I find this response not satisfactory:
>
> And I find that response quite offensive.

I'm sorry I offended you.

> I am not saying that there is any good replacement word, or there
> shouldn't be one, or we shouldn't look for it.  If we can come up
> with a single replacement word and everybody can agree on it, that
> would be great.

OK. I agree!

> I am just cautioning you that we may not be able to reach a single
> word as a concensus, and you should plan with the possibility in
> mind.

OK.

> In any case, I wasn't responding to satisfy just you in particular
> anyway ;-)

Yeah, and indeed this issue is not about me. :-)

-- 
Simon Pieters
Bocoup https://bocoup.com/
