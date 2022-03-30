Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E554C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 15:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348116AbiC3PUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbiC3PU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 11:20:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDE0160FC9
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 08:18:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dr20so42169837ejc.6
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D2DdyW/rh2zKmIbpzCSathofGG5ezHn/4N8djNn0Ywo=;
        b=AB5b8xjBaTXp/aNtYtCwpJWgCusYbDiiXR++nowVr88hc085oolrblb6ef/vE7Ec2p
         0xcNcKPdlD+pKM1ioqR39J/4apnZVmhoM6C+4797leQMdLGYuHJR5E+/zPf6OT5Shxfw
         cNgknCo0L4amqm85Fhehfhg1MnrL+M1GpHN45KNkvC41HqypYDzGd4JKHsnCk+L+ZU8u
         AkACfFCiA2hOkq7ad3syi3X7mNpaRb7WLLP/j5Ei9cJi0WRSTnSqQyCU23OnsPJiVTQF
         9rqdvszBDQJceolhKmmIkRilPANulEgPMtcu/wmVn+zkf0nMo0lizvnttMoDRE5/e+Fp
         6Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D2DdyW/rh2zKmIbpzCSathofGG5ezHn/4N8djNn0Ywo=;
        b=nSUjoMhhrwEIJpQfQtNWdv4ldQYG/1Ks2rshlPA6p1sUlALqOFYgbAk6wfUujxzdcr
         ZfM9OPW6jVcWlwMjTKHe0ZM9OSxFlfqIhCA9bItVbe9+gR4dVO7wG6yoyB5tqHNKV/8c
         InQSmTxAVjTGZu2VNVXXuRnTvoVcErlZlS2BK6kyuZdajv5vGKXjESsajFxR38GOsIwi
         viZ582yni8ucSFwBuoznFm7mBVYdBRU59MzdieORgxjOfK0dlng/53H9IOBqaDwGWVLy
         WctNMkNDi8HWTWyMPNfrp+Da3eQXNrtjIaCR+WEqkEaqHpom/qHs33ZCWvlmn6w5+vfB
         aesQ==
X-Gm-Message-State: AOAM531P6Z+pRT3ahrSdxSVqAAiMDC3WsRmUWXJvJ7CTvfGrflynoqNd
        GnYagIXkNO7zLY4/vvEuU1m9RSirP93sz2ODtgiRRQ==
X-Google-Smtp-Source: ABdhPJxPIVjuUtWqkLzpohqWThNP6dgUwpNbKdlEuSkcGgZPGXqiZoDgzPQzXlM9nLQ8ydiI+vNTZTQXNBQ4h3oeDs8=
X-Received: by 2002:a17:906:1384:b0:6df:c7d0:9131 with SMTP id
 f4-20020a170906138400b006dfc7d09131mr23574ejc.134.1648653522338; Wed, 30 Mar
 2022 08:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com>
 <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com> <220330.864k3fpo32.gmgdl@evledraar.gmail.com>
 <CAPMMpoiNZ8pvrZmMqJsRV2x+Fvq-=hpih1GGSLMe=KX785Dk0A@mail.gmail.com>
In-Reply-To: <CAPMMpoiNZ8pvrZmMqJsRV2x+Fvq-=hpih1GGSLMe=KX785Dk0A@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 30 Mar 2022 17:18:31 +0200
Message-ID: <CAPMMpohJEbfA0_0qR8jqOAXgBuwo+Nf=BkVjr0UkjeMa+STHkw@mail.gmail.com>
Subject: Re: [PATCH v5] tracking branches: add advice to ambiguous refspec error
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 30, 2022 at 4:23 PM Tao Klerks <tao@klerks.biz> wrote:
>
> On Wed, Mar 30, 2022 at 3:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> >
> > On Wed, Mar 30 2022, Tao Klerks via GitGitGadget wrote:
> >
> > > +     if (tracking.matches > 1) {
> > > +             int status =3D die_message(_("not tracking: ambiguous i=
nformation for ref %s"),
> > > +                                         orig_ref);
> >
> > This isn't per-se new, but I wonder if while we're at it we shold just
> > quote '%s' here, which we'd usually do. I.e. this message isn't new, bu=
t
> > referring again to "ref %s" (and not "ref '%s'") below is.
> >
>
> I will fix the below, but I would default to not changing the above
> unless someone thinks we should (not sure what the expectations are
> around changing error messages unnecessarily)

I take this back. I will update both - the change is in a "variable"
part of the message anyway, and it's hard to imagine any tool
actively/purposefully parsing the ref out of the message and being
caught out by the new quotes. Any coordinating tool would already know
what ref was being branched / having its tracking remote info updated.

>
> > > +                              * TRANSLATORS: This is a line listing =
a remote with duplicate
> > > +                              * refspecs in the advice message below=
. For RTL languages you'll
> > > +                              * probably want to swap the "%s" and l=
eading "  " space around.
> > > +                              */
> > > +                             strbuf_addf(&remotes_advice, _("  %s\n"=
), item->string);
> > > +                     }
> > > +
> >
