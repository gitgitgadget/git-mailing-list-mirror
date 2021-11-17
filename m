Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BF1C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 21:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8460610D1
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 21:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhKQV4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 16:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhKQV4T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 16:56:19 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2420DC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 13:53:20 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id b17so9271282uas.0
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 13:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gZ+GXZwy1mgtl+yAE3ENeieA2acb+cqSvL1kNDP6fIU=;
        b=FIMUBeLeCOESFxD1v99IRPnkkGgZr7Yhdb8QFZxr8/282Rin6DDL/S9LCziXEqiN7i
         HReSg+XSfSc282cHkjiB8LB0byRPEtF05pYtMqugwDzWG5SSY2gZ6H9iqysHrLB/jTMR
         0KB7DAR+CdxeEGFAmZqB3+o674tjq3vzG9098Klrlf3PHDJsiFDcYlgXMEDcm+1DPrT7
         2YQu226YDnafCvNRxBCHXvG6yZkI1IIi4SjIGF9OWzYJ80cbnV4IuSdd5pSAjmu7j62s
         Ut35B3J/NTBAvLr38XFwBpPv28RBbqHQsP1ATWQHFr+xNaWJ41YifuA8dxqemsqkJCQI
         04rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gZ+GXZwy1mgtl+yAE3ENeieA2acb+cqSvL1kNDP6fIU=;
        b=zpmzBf7Lu6Yql+H+3PGPacRmiJeqKSVpMHfiNKEEBx7AmO9TNpRK1myajt5wk51L/h
         qxGIoPTQ3bSeYmCO7ejCSm9WW/CHcbAnxb0Qs5mYYb2DzuPWZc+8PXckBEeRcBH2F/oI
         PG6J8pYue3MYbRvb2A12F1YHTPIagOnuKR/tGQMy5kcjXDLLVxyLlGYs3c8fB6apRJ/Q
         TKZgoAzTdec2lnPqDICypPGh7lZavIS0KEd6Cw75XwAhirc8vYi81WuqSm6WPvetPTpW
         Ap77VAAiA+ZoWWL7ugDaPlbBRKszaRaEdAAeM7pwCsa6XP2MgjkIQ2u5eiVcNqhNypcB
         ES1Q==
X-Gm-Message-State: AOAM532YwT6mEqjUI+3MbPtogxv/oM+cB270e7ORu3thDM332Mt1hsxL
        YO/4pKWjvg20u6nKioRdk62wNR+VGBL3y6cgesqsklllx4E=
X-Google-Smtp-Source: ABdhPJwtF4VGouqBLZfYnQJv9i3b3gbMrK8k3sWkpGPQz0Iq1jPaG0XKtkQFGsbuzA9PPq/2uGN8KbkKGCxsqdfWek0=
X-Received: by 2002:a67:3382:: with SMTP id z124mr28990978vsz.57.1637185999195;
 Wed, 17 Nov 2021 13:53:19 -0800 (PST)
MIME-Version: 1.0
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com> <877dd9i1zj.fsf@igel.home>
 <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com> <87o86kv6fh.fsf@igel.home>
 <CAPUEspi=r9EsG8KPvdiD-HM7Drq8ho1yjkN_c_T1e+ZeR4eejg@mail.gmail.com>
 <87fsrwv46h.fsf@igel.home> <CAPUEspg8ZUdn+KFz35yG1k9bbfVTe1b+7=+WdMknRS1zu8VcDQ@mail.gmail.com>
 <634c4237-325a-13e8-0a92-09d23bdfb111@web.de> <211117.86y25m5wez.gmgdl@evledraar.gmail.com>
In-Reply-To: <211117.86y25m5wez.gmgdl@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 17 Nov 2021 13:53:05 -0800
Message-ID: <CAPUEsph8NMJtK2r_fuT6UPsgmoPAeGVfTLOj8uz6NaOj4UZ1dg@mail.gmail.com>
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 1:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> PCRE2_UTF will also matter for literal patterns. Try to peel apart the
> two bytes in "=C3=A9" and match them under -i with/without PCRE_UTF.

Is there a real use case for why someone would do that? and how is
that "literal" valid UTF to warrant setting PCRE2_UTF?
I would expect that someone including random bytes in the expression
is really more interested in binary matching anyway and the use of -i
with it probably should be an error.

Indeed I suspect the fact that pcre2_compile lets it through might be
a bug in PCRE2

$ pcre2test
PCRE2 version 10.39 2021-10-29
  re> /\303/utf,caseless
data> \303
 0: \x{c3}
data> =C3=A9
No match

Carlo
