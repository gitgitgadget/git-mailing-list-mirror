Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 893341F461
	for <e@80x24.org>; Thu, 27 Jun 2019 12:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfF0MdU (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 08:33:20 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:41842 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0MdU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 08:33:20 -0400
Received: by mail-io1-f49.google.com with SMTP id w25so4296071ioc.8
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TinLX/y52XR9Mf0z+8Ke2qP9gmqWD9qHGvMi4TFL9p8=;
        b=LsR/AxIknpp/zTBMTPwpxpDf5ftg95MOxKhAAkUK5EgF0DcfE29DP9dIJg488ntKrL
         Vhtv/iTEo52dU1R65Kz9GNpozCNT/k8NrwXE70GyOoQyyJK9wsH9dScPRuuJmSyMDXQK
         iapIECaLeR5NEofCGdWE7j5inC36MH0YhXutkc5+Ek7ncH4mqcBSOAl6GWx2K963T/Um
         Oa8GPD31xP56Y3fqsGZonymTvX1M2ASLNUsTgMCwH0mYKFboVW3V6SzMBx+KbLvIAU7p
         3rWGROuqV1RcQHSpSK3f7No3KtCgYp2hNR+knet2VexdWhJfV+SsTl3e9/1xWyhQTNZi
         B2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TinLX/y52XR9Mf0z+8Ke2qP9gmqWD9qHGvMi4TFL9p8=;
        b=kiJ58ccOxA3cHECYDhl86F7ZQYGyKKDk8PeGFb8mwToyTHjW12/0E9usXHcxXKCcqO
         algtHcYHfy/4a74766htPVlEwgXb1i3Uvc+ado3JOIN1YYjhu1TPhYu+04VV+DFJaWos
         5p+kQ4snNxDVJs0tiGfI0NGqPFgnamIfrURbkE+TyBhCEZqDLbaXr75bnQD+xGzNW7bD
         q/AYNJcuc7Ayt+yXqo5WuDeGgaZbi8kvK+0FIm/jfj/icNTAOFxAeLWImTSa3/6mNxM7
         BxKQczxsrfsywVJguDn6bCZ2HCbPxUb36n0Rb9WquOpf6/iW/RwY62SgSaWuQMPx3hkN
         6Jrw==
X-Gm-Message-State: APjAAAXPrZ2sirjhGST2OlG8eAuxQGkmloI8hdrHO3OusCVMMhV15h/i
        XzMJS0ekrDIyXkHO2zgUOTJWChcj9hS64uxrEKA=
X-Google-Smtp-Source: APXvYqwi9eT82Nn3UYPxd0njnhBBYmfG43yRY/PXzn+cN+mPBG2KiI07+z73ZHe3wGz/pflOXhBmXUh4JXrmYzHALg0=
X-Received: by 2002:a02:3c07:: with SMTP id m7mr4622687jaa.64.1561638799337;
 Thu, 27 Jun 2019 05:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190627052515.GA21207@sigill.intra.peff.net> <20190627055739.GA9322@sigill.intra.peff.net>
 <CACsJy8Cjn2z7TrH9HLQ94Ph7qPZ0fC01J=Lq7GcrhvaCQZaSmg@mail.gmail.com> <8736jv8bnc.fsf@evledraar.gmail.com>
In-Reply-To: <8736jv8bnc.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Jun 2019 19:32:53 +0700
Message-ID: <CACsJy8AgmM0xYMMdYvpRSs4JRbNahcQyGcMMfPmaTS4Uv=Ok6A@mail.gmail.com>
Subject: Re: fprintf_ln() is slow
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 7:18 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Why shouldn't we just move back to plain fprintf() with "\n"? Your
> 9a0a30aa4b ("strbuf: convenience format functions with \n automatically
> appended", 2012-04-23) doesn't explain why this is a convenience for
> translators.
>
> When I'm translating things tend to like knowing that something ends in
> a newline explicitly, why do we need to hide that from translators? They
> also need to deal with trailing \n in other messages, so these *_ln()
> functions make things inconsistent.
>
> It's also not possible for translators to do this by mistake

This (accidentally dropping \n which sometimes is significant) is the
part that I made me prefer *printf_ln(). I had been translating for
years, as far back as 2003-ish, but I've stopped since the last few
years so I'm no longer uptodate with gettext development. And my very
old/outdated experience with gettext might make me think it's still
the problem.

> without
> being caught, because msgfmt will catch this (and other common issues):
>
>     po/de.po:23: 'msgid' and 'msgstr' entries do not both end with '\n'

Ok good. And with the downside of degraded performance, sure remove
all the *printf_ln()
--=20
Duy
