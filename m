Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01BCC46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 13:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbjAJNGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjAJNGI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 08:06:08 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BE1574D5
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:06:06 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l1-20020a17090a384100b00226f05b9595so11330563pjf.0
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZs6/cdDOwCsodV48+P3l3ZTEjShlcTpBJm0CQ69WTo=;
        b=mry95RDWpgA/iHryp4rmO4+cMUGcupaspnqB/eH3AWWEO6B9LqU/gMh9QSdGSuEd+Q
         topr1Kpnx519wjNYAPpyNOt6mhUY6vTlDQvAGniPWC6W8xaOKM07hl/rsIFzGL5YOSKK
         O/pKBEvNNZhFqBtufLRdaekXl6bWaiDs15In8UgEG9XBZqnEifo6i2E8O+HXMkWEmV1O
         vtvZuqDTBEvs2nZzF9jhWmNDFZHBaEnm5XslFWtr01/u3jIQ488vFJtTU5Xuddj2ok3M
         eSwPEizO/2mlAxIXpuJTZ1heCqPbtWS9nI2Ii1DCA7Yckh3RBdPV2OTLSzQRYCuoOpMH
         ksqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZs6/cdDOwCsodV48+P3l3ZTEjShlcTpBJm0CQ69WTo=;
        b=V8vQriWKCqtAzg87eYSMQRYBjfWW7h+j296N2xMSrkXfEAanzM298/1IXD9ex8Aoxv
         BEj75lOpREIk34+VcyxzmPDBxvvoM4gFXHdNlwSV2WL9MLI9F/UkI6PYhgJOtgenHVXe
         RH0zM4Zg+ZBwo634sUoSi0teh7FGOjLo2JcZe4s/ChKRdePaflZqHyb8GlOAKkGkVDxn
         x2FLI7CBJLH+zYYicBd058OD3hAoSMjDtOX3kJ8NSXLAIkeAA56N9OtRcd3K41Mg6T4n
         zdMpSG1ZL92nnR5tnpy7onIfcyZYB5JOTl++agA1Pps3HeJuC82svvSA75Su0vlmae8Q
         k5cQ==
X-Gm-Message-State: AFqh2kpZxIHx04kthDhiSsROVDQn0P0hwwDVeLyNJvT1FtJZbJZZPWgp
        H4hl6NZI07I0IBLaRdvFxSVvcStBT3j1KBLLAJM=
X-Google-Smtp-Source: AMrXdXtgfZM9555iifWRG7DXJmQ6dPYDtcFTL6SZvTkrg8aEij9WDQoR/FHyCi9VPqvDxc3X8fYSYEagUiNe+7ClYGI=
X-Received: by 2002:a17:902:a506:b0:189:c7f1:c2a1 with SMTP id
 s6-20020a170902a50600b00189c7f1c2a1mr3822400plq.141.1673355966236; Tue, 10
 Jan 2023 05:06:06 -0800 (PST)
MIME-Version: 1.0
References: <CALDp=1EVmQE2NZAd7ccAT0z=R=2S8FvyJzsPNrDeXwdJkEW3Lg@mail.gmail.com>
 <CAN0heSprKD35P-D7GTVQ20eRsj0AriYEA7iCDnrA9GuiwX0snw@mail.gmail.com> <Y71Xnx2vmznV913I@coredump.intra.peff.net>
In-Reply-To: <Y71Xnx2vmznV913I@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 10 Jan 2023 14:05:54 +0100
Message-ID: <CAN0heSqvqnCHPa-RQ3JuxxP7M_k1ORYOAV9aG+8EuXvB1GZukw@mail.gmail.com>
Subject: Re: Bugreport: Prefix - is ignored when sorting (on committerdate)
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Fredrik_=C3=96berg?= <fredrik@bakskuru.se>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 10 Jan 2023 at 13:18, Jeff King <peff@peff.net> wrote:
>
> On Tue, Jan 10, 2023 at 11:54:16AM +0100, Martin =C3=85gren wrote:
>
> > I suppose it could be argued that the '-' should be applied to the
> > fallback as well, e.g., to uphold some sort of "using '-' should give
> > the same result as piping the whole thing through tac" (i.e., respectin=
g
> > `s->reverse` in `compare_refs()`, if you're following along in
> > 7c5045fc18). With multiple sort keys, some with '-' and some
> > without, we'd grab the '-' from the first key. It seems like that could
> > make sense, actually.
>
> I dunno. Just because you are reverse-sorting on one field doesn't
> necessarily imply that you want the tie-breaker to reverse-sort, too. I
[...]

> I could see it depending on exactly what you're trying to do. Which
> leads me to think the rule should be as simple as possible. You can
> always do:
>
>   git for-each-ref --sort=3D-refname --sort=3D-committerdate
>
> to specify exactly what you want.

Indeed. So probably best to leave it as-is, then.

Martin
