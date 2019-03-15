Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CC3020248
	for <e@80x24.org>; Fri, 15 Mar 2019 10:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfCOKct (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 06:32:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40023 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfCOKct (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 06:32:49 -0400
Received: by mail-it1-f194.google.com with SMTP id l139so9991745ita.5
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fxs2TrbtVx9Gze8LBtMAkqJYwk8oW2CztsyDZ8SADG0=;
        b=GoExxKyHPDgc6aX/146T7eV5LXIDSMWNO3ZDqoQZCumc4BnbLLX+gLkTu8mgbqJ93X
         q/eY+4t4poNvRdWOxkq57smCJYwSMH357FTYmGIcTWPMhkXbk+e3PM0NHynCLF9UVtNo
         CiHPAAbX/mVhUF7w8fZv2fCOzPS5+DJBkUyYvpfNXvUofYV43I1aoJ8mjK+bsxrn6tpL
         VrlHNupoiJbgy2iNOfe780e/3g+JNqrwJbnPGrsmPs6T3/grc8PYQg5rTJpTF0C7mj8R
         989MYuOZyN3v8iOuxl2CtFWcmv8qOYgEDMKVHZ2Df1moGb+rrC6o4uES6WxjVC6sKCNJ
         QsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fxs2TrbtVx9Gze8LBtMAkqJYwk8oW2CztsyDZ8SADG0=;
        b=fnGxcVt6Wbbtxt8K3PzJJyEBvcfoxGGrzheh2CmDnTAda3zJT54+24rhqhiitWVQ1J
         43dpTrhoO8WA13/ylPg4Npng/qZc3K6GJSip0g1zJ0+Etz5ziaeXmV6oyd8YxNKvLQPm
         RWKyCwjI4IartR5X4w/B1JkzZOhDtHYp2IgM9fqlVeppjgm6h1E8JffSuk+e/Fw75+yR
         t3zUXwmli4InQvHV1VeBJn4ysww3jEAHOySIrWD5/8zFD4D2lYOogSmU4JSa+K+bTh9P
         FPQURkZDju+WaoUYN2py+np3dR/r3o+vLoT5NtQQFNf+xtpjC0/nNAMRee+zBHkk7J/M
         709w==
X-Gm-Message-State: APjAAAWazVMLi72yfiOUHIQtK7veLVmsdpg0R38tJ0GWxIwTtdHyU0K8
        JIZdx8XN8KM/FNmnhNCqPT+el6jbb+nDsCJH6B4=
X-Google-Smtp-Source: APXvYqzF7ngOYaL1oJeWE2TrrJEE5p48c9XClCCMIocJrNocP5c4Ept1SExmomXmxJIc+nIxtkixnUWtXz9eiZcicnw=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr1327078ita.10.1552645967858;
 Fri, 15 Mar 2019 03:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190313235439.30439-1-avarab@gmail.com> <20190314123439.4347-7-avarab@gmail.com>
 <CACsJy8B=76dMKhvdzOyyOMK5o-s8t+77ZE-hBmezhxLdv7E9dQ@mail.gmail.com> <877ed0bfl9.fsf@evledraar.gmail.com>
In-Reply-To: <877ed0bfl9.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 15 Mar 2019 17:32:21 +0700
Message-ID: <CACsJy8DqABFXAVLObkRZCVCu_uozOVwp1P5bQeU5PCiV8cimwA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] gc: don't run "reflog expire" when keeping reflogs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 15, 2019 at 5:24 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Mar 15 2019, Duy Nguyen wrote:
>
> > On Thu, Mar 14, 2019 at 7:35 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >> @@ -127,6 +140,10 @@ static void gc_config(void)
> >>                         pack_refs =3D git_config_bool("gc.packrefs", v=
alue);
> >>         }
> >>
> >> +       if (gc_config_is_timestamp_never("gc.reflogexpire") &&
> >> +           gc_config_is_timestamp_never("gc.reflogexpireunreachable")=
)
> >
> > Nit. configset api normalizes the key internally, so we can safely
> > write gc.reflogExpireUnreachable here, which is a bit easier to read.
>
> I didn't know that, do we want to do that?
>
> I'd think that as a matter of coding style always sticking to lower case
> in the C code made more sense, because e.g. you might #define a config
> key, and then use it both in git_config_*() as well as via strcmp() in
> some callback. Mixing the two would lead to confusion and possible bugs
> as we'd refactor the former of those patterns to the latter.

I did a quick git grep on "git_config_get_". The majority is still in
lower case. And given that this feature is not documented anywhere (I
had a quick look at config.h and api-config.txt and ended up checking
the code before the previous mail) yeah it's probably just safer to go
with lowercase. At least until the old callback style is gone.
--=20
Duy
