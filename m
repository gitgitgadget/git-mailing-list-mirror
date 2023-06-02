Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA75C7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbjFBKUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbjFBKUC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:20:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8601E7
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:20:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so2608948a12.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 03:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701199; x=1688293199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+65mm+NRVM+ZwYJ2aE69+z7rnXkhrqeVtOhhq8zabP8=;
        b=fGHOaaCcTkh9T3XfVCf/jWt83toFoiWb8mVZpiypNvTAn6TwiZu8ePE2KZQa0Qgfwj
         dgYnbABKlBdeaEQ8s73EurNQ9yTJlYiCxcjytk/xNcMa+rR9bqfRzBKWotq+KCYef6k+
         qZi1flDfu+/Qi9TVxPS3GK0b5ccNPVWqSbqtERW1wSDS0uQFBRiisP2la1DN6kRPthop
         scgHJoiLJbKvRlXJq1XN6RNWKOQDSYQWfbpuZsBKmDom7s7Ysx1FveHCUk+95yZ2KGTF
         oQ8yYTOtJx6S4SE9UyE6ZXxY0WccCEwl2b15KuCWxdyLvAeaHkRyWRX63smq5d//9Z7C
         WItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701199; x=1688293199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+65mm+NRVM+ZwYJ2aE69+z7rnXkhrqeVtOhhq8zabP8=;
        b=GuXmJBOe2CYMEJGBMx9M5z3+ayKS8h7PViEvDeQ/eiFmnK263EVWeeJQitsq5+KpzI
         GLZBEK8VC517lyLrJitQ4TPPEZBmOUVdqtCn8epnrJHFXSMUw+IO6H02ZBo/kKkxYY3h
         yylYEAnli1xvls7uPv2i7FPHwOM5vf3Mf9lLgsx1LkZpFXIpmSSmZedk4oRc/i7ukl0Q
         uSVlLbhsZ6OIGGyADae8bSKDv75RTuaaENhZnTnNRDmT7Fx/+tQGbd9VIkPeeiPWm0NZ
         FuhXsif7vAA9hYmd2USH8xB7RJUgBfyamnXpUDAc7lIfvkc8GapMFaV0dmjPAROaHmI9
         cU7w==
X-Gm-Message-State: AC+VfDyYytHwQiQL20z3PgeXDayfavVOt/PbiXlDbmTggozO3W0nbZZ1
        GEVpMmwLtuxtb5dly5/3Fv/tCNUdx9YpNTzb6Js=
X-Google-Smtp-Source: ACHHUZ7YIS8IhVBwRGRMebTJBgbJ6PDvwwHSO61TkInX/Lc6Yop+uZwHHTzBvjI9M49faw2tAMjFYZW+WF4s/PkCh6U=
X-Received: by 2002:aa7:df81:0:b0:514:af52:e49a with SMTP id
 b1-20020aa7df81000000b00514af52e49amr1646965edy.25.1685701198843; Fri, 02 Jun
 2023 03:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD2zaEPKNj2SpgGQUyFRmNp24E-8n1O9K5Se9=OhXckxGQ@mail.gmail.com>
 <ZHVM6dw4lIHjdLGw@debian.me>
In-Reply-To: <ZHVM6dw4lIHjdLGw@debian.me>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 2 Jun 2023 12:19:47 +0200
Message-ID: <CAP8UFD3OptAe-98+Q=WJZkhPnNVY91N9+Mx5thZoa3ieOXShrg@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 99
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bruno Brito <bruno@git-tower.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

On Tue, May 30, 2023 at 3:17=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:

> > After some discussions between Peff, Phillip and Junio, Peff sent a ver=
sion 3
> > of his patch series with small changes. Especially the new version make=
s sure
> > we reject timestamps that start with a character that we don't consider=
 a
> > whitespace or a digit or the - character before using strtoumax(3) as t=
his was
> > considered enough to avoid issues related to this function.
>
> I think it's odd to have second person (we) when the text is written in

I think "we" is the first person.

> third-person perspective. Thus, abouve should have been:
>
> > ... Especially in the new version, it made sure that timestamps that we=
re
> > started with a character that wasn't considered as either a whitespace,=
 a
> > digit, or - character, were rejected before using strtoumax(3) ...
>
> Thanks.

Thanks for your suggestion and sorry for forgetting to take it into account=
.

I must say that I think it's Ok to use "we" instead of "the Git
community" in Git Rev News. I think we have often taken this
perspective before.

By the way, does someone knows why the announce of edition 99 doesn't
seem to have appeared yet on https://lore.kernel.org/git/ :

https://lore.kernel.org/git/?q=3Ds%3A%22Git+Rev+News+edition+99%22

while it appeared on https://public-inbox.org/git/ :

https://public-inbox.org/git/CAP8UFD2MNFjEjrGVyj__d4f95nC=3DD7csKajYzdtMFkf=
XKmrixQ@mail.gmail.com/

Thanks!
