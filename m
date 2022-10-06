Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DD1C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 12:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiJFMYf convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 6 Oct 2022 08:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiJFMYd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 08:24:33 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760519E2DC
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 05:24:27 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id i3so868977qkl.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 05:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQJ0HNo3hixKEJC1tPVmeS6iMxa0YZKQCuZLHw4Co10=;
        b=Fnrx6Jg0M9GBfbSCyMtz7hhoTOHEuBElTLCosCgmHZCCSQmfApXvMHMeYOVA3MiD6I
         4tdyzYhirwT9kzhusmaiEpQ1346rQr1ilcwvY/FEvC334WmZkM0XPPBQDa77AzmEJZfD
         qUo6usamNSWJc3qhcai67Gz89LD2U7dfkrZR3W+l6P+YNPTTO15wPyjWHhJh1EqVL+Kd
         Wt6pxlIeid7wFi6J+9WiDjQxCsl2sFKjsZG7x+DjyzaSghbEsg8REjVfSRqzSKt9qzd8
         kS9VRJAes5eAKs4RJunXhU7AeyZ4MtAhG9781yY9IXiGdEis8/kY8imeBGTHSQgiWHhj
         29RA==
X-Gm-Message-State: ACrzQf342VcZ4Noo8U/j1Yr+7CJf2SSgcPGTp1KQGjs7hPTK1C26T7wR
        pNt2eAnnerpgK+I0ZhgW098wkE+YlcHPA6Rn8bafSJ7l7KE=
X-Google-Smtp-Source: AMsMyM5glexIU4mvqESLvBCK+lELkxjB4PMSo9OFKNtYlXn3o0Tkf3YPz62z4xw7/i8tXFW3REj1GForsjjZHaK7j+I=
X-Received: by 2002:ae9:e647:0:b0:6e6:62aa:b8d with SMTP id
 x7-20020ae9e647000000b006e662aa0b8dmr935747qkl.669.1665059066033; Thu, 06 Oct
 2022 05:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqilkynd91.fsf@gitster.g> <20221005221928.703750-1-asedeno@google.com>
 <221006.86h70hs8xb.gmgdl@evledraar.gmail.com>
In-Reply-To: <221006.86h70hs8xb.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Date:   Thu, 6 Oct 2022 08:24:10 -0400
Message-ID: <CAOO-Oz3L7oe6SYPtp+Xgm2iJFzXkzxzkwr4LmXdN7uaye6zYQg@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util.h: GCC deprecated message arg only in GCC 4.5+
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Aleajndro_R_Sede=C3=B1o?= <asedeno@google.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Happy to do so! I build new versions of git on a few systems as they
roll out, and you'll find many of my (not that many) patches involve
breakage on this particularly old system. I'm sure one day a big
change will break git for good there, but in the meantime I'll do what
I can to keep it going. :-)

-Alejandro

On Thu, Oct 6, 2022 at 3:33 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>
>
> On Wed, Oct 05 2022, Aleajndro R Sedeño wrote:
>
> > From: Alejandro R. Sedeño <asedeno@mit.edu>
> >
> > From: https://gcc.gnu.org/gcc-4.5/changes.html
> >
> >> The deprecated attribute now takes an optional string argument, for
> >> example, __attribute__((deprecated("text string"))), that will be
> >> printed together with the deprecation warning.
> >
> > While GCC 4.5 is already 12 years old, git checks for even older
> > versions in places. Let's not needlessly break older compilers when
> > a small and simple fix is readily available.
> >
> > Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
> > Signed-off-by: Alejandro R Sedeño <asedeno@google.com>
> > ---
> >  git-compat-util.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index b90b64718e..045b47f83a 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -189,9 +189,12 @@ struct strbuf;
> >  #define _NETBSD_SOURCE 1
> >  #define _SGI_SOURCE 1
> >
> > -#if defined(__GNUC__)
> > +#if GIT_GNUC_PREREQ(4, 5)
> >  #define UNUSED __attribute__((unused)) \
> >       __attribute__((deprecated ("parameter declared as UNUSED")))
> > +#elif defined(__GNUC__)
> > +#define UNUSED __attribute__((unused)) \
> > +     __attribute__((deprecated))
> >  #else
> >  #define UNUSED
> >  #endif
>
> This LGTM, thanks a lot for that fix & fixing this (minor) breakage of
> mine.
>
> I did test on an older GCC myself, and then (in lieu of logging into an
> ancient system I have access to) scoured the release notes of gcc, and
> discovered that "deprecated" was older than anything we cared about.
>
> But I obviously missed that while the feature had been there for a
> longer time, it didn't take this parameter until GCC 4.5, sorry!
