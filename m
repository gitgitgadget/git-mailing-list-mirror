Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD19C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 11:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353508AbiELL4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 07:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353485AbiELL4M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 07:56:12 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3764F2D1EB
        for <git@vger.kernel.org>; Thu, 12 May 2022 04:56:10 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id x8so4862240vsg.11
        for <git@vger.kernel.org>; Thu, 12 May 2022 04:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JfW4ZS3/5FBWMYeZ7Di/+yRISO7yW3IdoPzQM9E28t8=;
        b=CjUBmyBDvViSFvNdzUy+HwGAQGQtKwQbVL+xl3lzxERY9t8TavbB5JSuv+k1k0Qi2A
         x9Ar/bMbf/P69atpT/hPCDoNIGHUoIoWXA5GdxqHH6FOUFuupHDEgLPW1ggRRBm5qBT+
         YkKS2KvWtM1ofaUuSMFvQr8sybkGOjuiG06NtwOjBT5QYx/19GuU0SzwzmzBRpqHQZke
         AmQhZeKLmoqUOmxK45sdj/j7pcQeKVDZSpFp+5/RTQlJxwpzE7P0VDBf72LTH83xGO6h
         zTRN8vccYhir5uNkuM6gn6aBQFzI5WDQwL6HYBYnPftejOy8fjH/jCqPPGcKiTMpPnFI
         SJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfW4ZS3/5FBWMYeZ7Di/+yRISO7yW3IdoPzQM9E28t8=;
        b=XmJCz3mnj0L2JOJHdzIrjxJIsrnu2rVzLT1L6ZShUZsiXf9UOGs5dYnmcHpIedHn5a
         OL8V94S3SdmFBnrP9me2JMRglMyhgQeevKUfx6WwJxCeBZt98rt686vnfn0fE8yem72/
         JyZiaB4V0QlkZD53EjbJlbC12huth7xEjYnBEWFs6s6LZOImn8OO2p9H0sFXFk/zizWf
         NXcQ87NhYjic/F23691zb4FvJh8i1r4AsM8M4p5qVzfBYPxB/UW2y4deLN2Q6D1hf+i7
         +Y1IzcjoAWdNrv1Yx8l6NjXFyaGuc+F/oSF32tfcRUL0cq2FhKGXiMZSmWgzbh6QZ/w7
         y+8g==
X-Gm-Message-State: AOAM530v7c+mQzLtj5VrekfU/aNPReJlxVaB2TKoKMe6ErMNcav64sxa
        Vtm0WBaV20dz62KM6LXCc+ZbxqwVYUmwoL+X3t8=
X-Google-Smtp-Source: ABdhPJzP1V1zewnnqu811hlLpxfkbg8KqBxDAYfCXt5mGxXkID46631SyxA0jbMi/TP9lJveWlvAlynMXX+wa9wCV04=
X-Received: by 2002:a05:6102:1519:b0:32d:8834:f17a with SMTP id
 f25-20020a056102151900b0032d8834f17amr16054378vsv.1.1652356569268; Thu, 12
 May 2022 04:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220504104601.136403-1-chriscool@tuxfamily.org>
 <20220509153834.485871-1-chriscool@tuxfamily.org> <CAPUEsphA=q10wCsrf3AxR9fXz9HQHt374tDFoWBu++EPNDA-LA@mail.gmail.com>
 <CAP8UFD2F=5RsB_WVOHKmzJsD9UJgZ2YM_yreTur2_huAAJ=+Vw@mail.gmail.com>
In-Reply-To: <CAP8UFD2F=5RsB_WVOHKmzJsD9UJgZ2YM_yreTur2_huAAJ=+Vw@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 12 May 2022 04:55:57 -0700
Message-ID: <CAPUEsphmN+1FVdQSX3GoRYQBh33XdR+nN-WAPZdtZmMsBAfazg@mail.gmail.com>
Subject: Re: [PATCH v3] http: add custom hostname to IP address resolutions
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2022 at 1:30 AM Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, May 10, 2022 at 8:20 PM Carlo Arenas <carenas@gmail.com> wrote:
> > I also think it might be a little confusing (and probably warranted of
> > an advice message) if git will decide based on a configuration
> > somewhere in its resolution tree that the IP I am connecting is
> > different than the one I expect it to use through the system
> > configured resolution mechanism for such a thing.
>
> I would be Ok to add an advice message or another kind of message
> telling users that the IP used is based on the config variable. It
> could break scripts parsing Git's output though (even if it's bad
> practice to do so).

Only if they added that config option, which is an obscure one that
nobody should be using anyway, so very unlikely, right?
I also think that breaking my script could be avoided by turning off
the advice (as suggested previously), and I MIGHT want to have my
script broken if I picked up this config by mistake.

> So we would need to decide the kind of message and
> its content. Suggestions welcome.

I am not good at wording those, but I would think something innocuous like :

  "curl override detected to point name %s to %s instead of using DNS"

> > I assume that if you want to use this frequently, having that advice
> > disabled in your global config wouldn't be a hassle, but it might be
> > useful to know that I am interacting with a potentially different IP
> > when referring to some host by name in my local repo, maybe because I
> > forgot to change that setting after some debugging.
>
> Yeah, maybe. On the other hand GIT_CURL_VERBOSE might already be the
> canonical way to debug this and might already tell about this.

of course, but that is mostly used when debugging HTTP issues, not
when your DNS seems to have gone nuts, and you are looking at your
screen in disbelief because the code you were working on before lunch
and having released is now suddenly in production.

> Yeah, it does:
>
> <= Recv header:
> == Info: Connection #0 to host gitbogusexamplehost.com left intact
> == Info: RESOLVE gitbogusexamplehost.com:5551 is - old addresses discarded!
> == Info: Added gitbogusexamplehost.com:5551:127.0.0.1 to DNS cache
> == Info: Couldn't find host gitbogusexamplehost.com in the .netrc
> file; using defaults
> == Info: Found bundle for host gitbogusexamplehost.com: 0x5556d2bd1340
> [serially]
> == Info: Can not multiplex, even if we wanted to!
> == Info: Re-using existing connection! (#0) with host gitbogusexamplehost.com
> == Info: Connected to gitbogusexamplehost.com (127.0.0.1) port 5551 (#0)
>
> I agree it might not be very clear that it's because
> "http.curloptResolve" is used though. But maybe we could output a more
> explicit warning message only if GIT_CURL_VERBOSE is set.

As I pointed in my example I can see this being useful also for some
web developing which are mostly concerned about JavaScript and might
not be aware of the OSI layer stack and how to get an HTTP packet
dump, so I would think better done even when GIT_CURL_VERBOSE is not
set.

> > I am sure all those folks that forget to edit their /etc/hosts after
> > they are done with their local site versions might instead use this
> > and then be happy to be warned about it later.
>
> Do you mean that those folks might like a config option ;-)

Yes, and I think it is not THAT of an obscure config option if it even
has documentation as well ;)

Carlo
