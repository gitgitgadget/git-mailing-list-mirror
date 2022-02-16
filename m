Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBA5C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 15:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiBPPz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:55:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiBPPz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 10:55:56 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BED29690D
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 07:55:43 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a23so290520eju.3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 07:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/BERg0n57wSpMtiksWTUjYBUapOwQ0b9YPq9O06Wdc=;
        b=M++/Jp1mqWFjZaHokiIchgxle3mV8Fxp2bdbyxGuFyHzjddgGCrlnT731eumnOr29e
         TzPmPruTu/l2vu3Yd5FlgBdXSpUy3kyLV5Pb8f/9RfQRzvdZy6OtWnNb27R2kniwJBau
         qQ2tD/fnAB34AxLc1IrinApeES6/uV0fmvPNccc7c3i8R7vIpELQ21PqUy7iLpHbwiFy
         bfy3OQBDRrt1WLohd05QzDCv3YhpatQeRBexLGl0j9D1BsAGb1dbb9RylYoFzdD0KzZn
         ircgpOuagUUVbyVHkNLiIgszum64Pi9shU/gNe9ZVnZ0ERog4zWTeZB2olFmc+2lQeH0
         NEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/BERg0n57wSpMtiksWTUjYBUapOwQ0b9YPq9O06Wdc=;
        b=c/HxIR6/+Vc6ONGDZVcR6OFT+rCDDtU3rEZJ1XKZhkgl/AGTnbgCy0rfNn3KwTc6it
         eKLq91TrMZQAbHTrgZyUw9HgjmeLeOebvPP0UG1CXC/mPSXSo7VMpGyvmHGJBE8yh6jZ
         2EUZQtw+r2aoS5zkt7l2Hc4JrB42egdMFHO2mYosfZ1rOProEgfcsGO3c5ERYHB5s2ry
         kObiRo/ldmGZsLP9v+N1BI5Cvu62fdETEluFeN1n1VR4X9H3yCkUnyvRdh89jISh1oD6
         v2VMHlBPL6FiHEkM75OB+TlcAitiF9Kcf9Yvvp5R4HRVV0KhgUDAD3R8pEqOWJQC8H+/
         ZM4Q==
X-Gm-Message-State: AOAM533wp25lVMAzUDeNehveSlE8tXzRRE0wI2KEuArzl1QeOSA/KSoa
        HhpqSnxKegsR1DPyHG6HTtsySWC2PGvm5jM4YTrefrl6
X-Google-Smtp-Source: ABdhPJx4x8KzIAlEiF4fqpgNT0J+JDvWfHBD9slEico9jdCLo2eKqvuCcTrF9LVSYCK8IbFkZsn1tbXBnRbfroMEXAY=
X-Received: by 2002:a17:906:fca5:b0:6b4:6d25:ac19 with SMTP id
 qw5-20020a170906fca500b006b46d25ac19mr2675443ejb.485.1645026941869; Wed, 16
 Feb 2022 07:55:41 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <730fb307-3bc7-b52f-49c1-d83b5ab55c95@iee.email> <3b112eee-8110-baf6-d7e7-cb25b03c32ff@gmail.com>
 <CAP8UFD1BYm-_p=JYw3GELsk1=hR9-o7cxEowtnrKPumi0Gk8kg@mail.gmail.com> <65abccbe-eaae-5d68-c738-b7f9a3844bbc@gmail.com>
In-Reply-To: <65abccbe-eaae-5d68-c738-b7f9a3844bbc@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 16 Feb 2022 16:55:30 +0100
Message-ID: <CAP8UFD3prsevU_8zCXQu_BpZH+NHm+HD04RiBvOXkZkDoi+yjg@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Community <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 15, 2022 at 9:32 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 13/02/22 3:03 pm, Christian Couder wrote:
> > On Sat, Feb 12, 2022 at 7:12 PM Kaartic Sivaraam
> > <kaartic.sivaraam@gmail.com> wrote:
> >
> >> On a related note, the organization registrations are now open for this year.
> >> The deadline is February 21 - 18:00 UTC. I'm not sure if anyone else is
> >> planning on applying for Git. In case no one else beats me to it, I plan on
> >> applying for Git around February 15 17:00 UTC.
> >
> > I was thinking about applying for Git, but I am glad that you plan to
> > do it. I will try to add some project ideas to SoC-2022-Ideas.md
> > before February 15.
>
> Thanks for adding it! I've applied for Git in GSoC 2022. The application
> information could be found here:
>
>    https://git.github.io/SoC-2022-Org-Application/

Thanks for applying!

> Let me know in case anything needs to be tweaked. I mentioned that we have
> 5 mentors available counting Stolee, Victoria, Christian, Taylor and myself.
> Also, I've invited Christian as an Org Admin. In case anyone else would like
> to volunteer to be an Org Admin, do let me know.

Thanks, I accepted the invite!

Not sure we can invite possible mentors yet.

> On a lighter note, the application structure was a bit different than
> previous years due to the new website. They say that it supports persisting
> the organization information which should mean less work while applying for
> GSoC in upcoming years.

Nice!
