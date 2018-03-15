Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6D01F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbeCORBI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:01:08 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36024 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeCORBH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:01:07 -0400
Received: by mail-oi0-f49.google.com with SMTP id u73so6298018oie.3
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S+yc3B563VaqPpsM8BRllyQWIt232JuzVaZjIrJ/CTM=;
        b=o6m9tf0MyXdTATK87xRK9MvGEgbAwFj1JEhEdeDVqr5xsO75lugHKOvwqz7wHe8Wq/
         35Hava75XVYmOOs5fxeQbpEoxPF1XJ303MNxWXBKDe6g8163XYZRIuCthtcCBtCMCUyp
         +h5w2Rjw9byYz4KF+cBOa8/ULCmDx9sY6+MQI8JzZhL/BM5WohIIhE4b0s9bipDzPXb1
         wwuSwRDGGSljVcpVaoGQ5dI64GPVEPzc9ZaJqkx2YjTRRH7sGetTe4vaGeQmpkZ1Ukt1
         2lWODp36QPBP0ueRJysyhpdlmettIrzMpI9KSIuql7BD5yxlCtZrbv5RtcJFt9eRzu5H
         xUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S+yc3B563VaqPpsM8BRllyQWIt232JuzVaZjIrJ/CTM=;
        b=qfyBU3WGbZraJRT2FIMzBOuN/yxBuzDZIonb+d77dfMmf/WQQ2AuK+ckMi1sTS2DW5
         /FaHxnZ2Fy8sT7C6MgTKKKUDKBy5cblr3NjavosPHUSTJXsUV04GcNx/YHhRofHqYNch
         /8IH3CufkuoiwQhtd+Ra+etkttxumo9CGqyuaSUKOtPmPfjoyRJQie+cRN9e/BCjSh6k
         dgQREpEKLDrcl7AIe3Pi2wTL1a5j5/KfsX25ar1YoZuQz9hcxYB7aFW+K1KiF3Q+wW4W
         tYb4YVWk9R68w4t6QXPiHTEDurZHibxWZ7b/Jr51kLDim7iVZq6yFKwDr3Lxt68htaLP
         qkfw==
X-Gm-Message-State: AElRT7FFPyqIVvOEE6ciAmx/acTm3vB4C7srYu98JqjjkJ88p+VXxLX5
        //GNBvcYSWt3qCs5mE4oYZwewnyGF5mC9BrL8tk=
X-Google-Smtp-Source: AG47ELsVuMG61AxSVJX+agmC2K8GI8E+uNlHXDG8xDnlFafKnXn+F9+HVKyDBGcHBhLrmk4U9M2XmYYVgief+bXrU6I=
X-Received: by 10.202.64.85 with SMTP id n82mr5780674oia.30.1521133266083;
 Thu, 15 Mar 2018 10:01:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Thu, 15 Mar 2018 10:00:35 -0700 (PDT)
In-Reply-To: <87a7vdqegi.fsf@evledraar.gmail.com>
References: <20180301092046.2769-1-pclouds@gmail.com> <20180306104158.6541-1-pclouds@gmail.com>
 <20180306104158.6541-4-pclouds@gmail.com> <87a7vdqegi.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 15 Mar 2018 18:00:35 +0100
Message-ID: <CACsJy8DZGa8v6z6c3SUjENMd4h6Qi55iPfsT2c5-cejqv5jA2Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] gc --auto: exclude base pack if not enough mem to
 "repack -ad"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 12, 2018 at 8:30 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> We already have pack.packSizeLimit, perhaps we could call this
> e.g. gc.keepPacksSize=3D2GB?

I'm OK either way. The "base pack" concept comes from the
"--keep-base-pack" option where we do keep _one_ base pack. But gc
config var has a slightly different semantics when it can keep
multiple packs.

> Finally I wonder if there should be something equivalent to
> gc.autoPackLimit for this. I.e. with my proposed semantics above it's
> possible that we end up growing forever, i.e. I could have 1000 2GB
> packs and then 50 very small packs per gc.autoPackLimit.
>
> Maybe we need a gc.keepPackLimit=3D100 to deal with that, then e.g. if
> gc.keepPacksSize=3D2GB is set and we have 101 >=3D 2GB packs, we'd pick t=
he
> two smallest one and not issue a --keep-pack for those, although then
> maybe our memory use would spike past the limit.
>
> I don't know, maybe we can leave that for later, but I'm quite keen to
> turn the top-level config variable into something that just considers
> size instead of "base" if possible, and it seems we're >95% of the way
> to that already with this patch.

At least I will try to ignore gc.keepPacksSize if all packs are kept
because of it. That repack run will hurt. But then we're back to one
giant pack and plenty of small packs that will take some time to grow
up to 2GB again.

> Finally, I don't like the way the current implementation conflates a
> "size" variable with auto detecting the size from memory, leaving no way
> to fallback to the auto-detection if you set it manually.
>
> I think we should split out the auto-memory behavior into another
> variable, and also make the currently hardcoded 50% of memory
> configurable.
>
> That way you could e.g. say you'd always like to keep 2GB packs, but if
> you happen to have ended up with a 1GB pack and it's time to repack, and
> you only have 500MB free memory on that system, it would keep the 1GB
> one until such time as we have more memory.

I don't calculate based on free memory (it's tricky to get that right
on linux) but physical memory. If you don't have enough memory
according to this formula, you won't until you add more memory sticks.

>
> Actually maybe that should be a "if we're that low on memory, forget
> about GC for now" config, but urgh, there's a lot of potential
> complexity to be handled here...

Yeah I think what you want is a hook. You can make custom rules then.
We already have pre-auto-gc hook and could pretty much do what you
want without pack-objects memory estimation. But if you want it, maybe
we can export the info to the hook somehow.
--=20
Duy
