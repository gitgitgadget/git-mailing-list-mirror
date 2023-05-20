Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95752C77B7D
	for <git@archiver.kernel.org>; Sat, 20 May 2023 07:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjETHhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 03:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjETHhh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 03:37:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A0D186
        for <git@vger.kernel.org>; Sat, 20 May 2023 00:37:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f683e8855so223676766b.2
        for <git@vger.kernel.org>; Sat, 20 May 2023 00:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684568255; x=1687160255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7I+0f+orDYDYRxJHxy283MEd1HpnIeCPu8zRLQN5no=;
        b=ANF1KU+v4YxtgjfZBXB4dp6T2YfBgluWgk66x7c2tSdft6lfWlWRBpJQ97fo0U/neU
         QPQg6i+1/SFRV3KQoC9RvdKik75OtjDqj8+/+gqoHS0aDVAsi7yOR40B4ohidzo0ZwOR
         CmFy8PiEpQajkaeZW6inzIdpNCre0HLgkay7xqsxnYNicxJ2Hmo1M9DJ5i5MJWqs96d8
         2vgVRey0nLEWwkp9krpbsykuEmG0aLZLR3idneLqIYfCmDzHFxb9tw1g/4FsrHlRuupa
         /6NoBA2CkEhziJ8iP7njtzofqZMrqrTOq9Ghqg3uVdhXklLMsv9r7Eg5xA1h+gpvVQQw
         xZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684568255; x=1687160255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7I+0f+orDYDYRxJHxy283MEd1HpnIeCPu8zRLQN5no=;
        b=bH1Jbk2SywLyAky4+rLNlw7Sa6yPMn37dIBKGHubqZB1267zulkZbL68JbAtlm1ej+
         eOQJSWk0BFA8xdnC13Hw/V+bUCoezosJ4AUj6SI5QDaeSkZPZxOMsfDiAb5EFFRhiIon
         6hwTOSDEpUjorJdlYIHDDpMdRxDZMohScGZvJa71rHwfgDZ8yrTNPefj0AFvKzPq8e+0
         zXkJi2904rAV+8FFyRKCkUz5Q1gO1+jwX70sy/B2V6PfBsPrTTharkOpPQtBaIogK/uD
         gADcr+IcqE97bF3EWQH6jeKFDHLbuzVe4cmKUnhcTys09bV9ZwI5aQ9Mc/93N+qaQ7nX
         ZeZA==
X-Gm-Message-State: AC+VfDwZldcswq4pkYpN2+YTGVWx+lWBTo6X/d3qmLaxZNFCB20q+2We
        iyfXfG3cDc5D311zrHBaZnRi+ut3oTyA+lqW9M1hDnucG+vMrw==
X-Google-Smtp-Source: ACHHUZ4VXimJcYksrcM4ptsOjmKS3Yy3Q4L280FxaAP5BMEhFE6+zr/AWlwbrj/BtwyuH5gejvRXSkdrBlVPgBiO3dw=
X-Received: by 2002:a17:907:268e:b0:969:f677:11b9 with SMTP id
 bn14-20020a170907268e00b00969f67711b9mr4191550ejc.54.1684568254234; Sat, 20
 May 2023 00:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGJzqsnS3SnoW__aPQ+13s+-b3a+makCjWxR=z6mjgBBnuKjLg@mail.gmail.com>
 <20230519090917.GB3515410@coredump.intra.peff.net> <k3dnos4h7i4sjxzotiqwhz47wc2qvuzpii4wgysgt6ywoi6dx3@2ggmoesxlqsi>
In-Reply-To: <k3dnos4h7i4sjxzotiqwhz47wc2qvuzpii4wgysgt6ywoi6dx3@2ggmoesxlqsi>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Sat, 20 May 2023 08:36:58 +0100
Message-ID: <CAGJzqsmJSVJYTtT41wQ5Cgsz=ExMZ8y7qKPDh-7kt8RXY__NbQ@mail.gmail.com>
Subject: Re: Which macOS versions does Git support?
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Jeff King <peff@peff.net>, M Hickford <mirth.hickford@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 20 May 2023 at 01:37, Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> On Fri, May 19, 2023 at 05:09:17AM -0400, Jeff King wrote:
> >
> > I'd guess that anything older than 2009 is probably not worth worrying
> > about.

Thanks Jeff, Jeff and Carlo for your replies.

>
> FWIW Mac OS X 10.5 (Leopard) was last updated in 2009 and also happens to
> be the last one that can run in PowerPC, so sadly there is a non zero
> number of users for it (MacPorts uses a minimum of 10.4 for that reason)

Interesting! https://ports.macports.org/port/git/details/ It looks
like the most recent build is from 2021
https://ports.macports.org/port/git/builds/?builder_name__name=3D10.5_ppc_l=
egacy
.   https://ports.macports.org/port/git/stats/?days=3D365&days_ago=3D0
shows 10 total PowerPC downloads in the past year between versions
10.4, 10.5 and 10.6

>
> Carlo

I don't have the equipment or expertise to develop on macOS, so I'll
leave the API migration as a potential future #leftoverbits

Reading the keychain docs more carefully, the new API only supports a
fixed set of attribute keys such as 'kSecAttrComment', so discount my
original "further motivation"
https://developer.apple.com/documentation/security/keychain_services/keycha=
in_items/item_attribute_keys_and_values?language=3Dobjc
