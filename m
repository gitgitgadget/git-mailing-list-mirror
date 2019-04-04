Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08AE1202BB
	for <e@80x24.org>; Thu,  4 Apr 2019 08:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfDDIC2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 04:02:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33189 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfDDIC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 04:02:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id q3so1337971edg.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 01:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0GyZarQPcGvxgqGHrJTz9zuX63VirqwZJU5y/BH68t4=;
        b=dge95uDFL4hLVHEDp5f9zDwoeqkNqTzu1rtVxQvqXFJ8GPZxkXB8R93RV3yQrkxhYM
         kWUZWf35ku08olMSryf6vRCEhNiNkJmYelGY9F+WggBrRRS7QokhmsGY0/5uY0umckuu
         phq/L1ipU26LlLCPaku6lfiZ4uZ4AykjQjoY+cPBo/VkM2HpS+ftaIGD6kDCLu6lo3cb
         d5HhZ8A2HEs+wxVeR8Z3UTjRIJiybEhZhv95PukU1v2XOOJluSkHPGXQqz91cMG3fHdy
         7Z57/IDzeU79URBtf3A1z+GOah0Gh8kf2AeR99Ukj8N1s4MVaFwlTw9jEvTONuaLj/R8
         E8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0GyZarQPcGvxgqGHrJTz9zuX63VirqwZJU5y/BH68t4=;
        b=YrgL3km9jUpvPdq6o870/+c32RWpYGC46a0XBwg/ijtViiVgavWBBE/w6Mvspuj6VO
         lusDHApVa7Y+OUm53qtTqJ86l+DJ7n44h/epnH1mi+hVrWf8MM9xA3TGvJI/ZP+99aac
         GsbMG6saQDXJi5vGUtddlbW0yyysYriLEDf58hBpB+a4albJAu/2ri+EdLSr16pSghHR
         pDYnB+E0IRP60PqWBUOAVCTfAsZLrBxKXtUSIH5QG+M7jS+zAN1Ep0WAnufwcf2Sy/YI
         6HqwFZ28JLmUQBe8fRGJiVaN9/3vDtPtq5t9MPKm4pHS91fJacsviJAkMKffsibOnRWs
         King==
X-Gm-Message-State: APjAAAVBa0RKjyzqXhILxWKs/yrXP+evqPcQQkgC8+8keCEOq5T/hdL1
        dOqKjSfvBhhwrsL7ZWsd0KNubwUQlY4s9kRdOks=
X-Google-Smtp-Source: APXvYqw5xHFalBowYqeXnozeRWYXc/NF4l7ttOq7eSaHE9nyo1CgN7ePNP08DUOBd1vScYcS9eYqynf0iGQb4f8eJns=
X-Received: by 2002:a50:b1fa:: with SMTP id n55mr2927273edd.34.1554364946498;
 Thu, 04 Apr 2019 01:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190401164045.17328-1-chriscool@tuxfamily.org>
 <20190401164045.17328-3-chriscool@tuxfamily.org> <20190403220839.GM32732@szeder.dev>
In-Reply-To: <20190403220839.GM32732@szeder.dev>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 4 Apr 2019 10:02:14 +0200
Message-ID: <CAP8UFD26hGfMQTFw2364Osa_Tbho+b8Dn58s-U8cPsWk+kTxLw@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] Add initial support for many promisor remotes
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 4, 2019 at 12:08 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Mon, Apr 01, 2019 at 06:40:36PM +0200, Christian Couder wrote:
> > diff --git a/promisor-remote.c b/promisor-remote.c
> > new file mode 100644
> > index 0000000000..0c768210ee
> > --- /dev/null
> > +++ b/promisor-remote.c
> > @@ -0,0 +1,92 @@
> > +#include "cache.h"
> > +#include "promisor-remote.h"
> > +#include "config.h"
> > +
> > +static struct promisor_remote *promisors;
> > +static struct promisor_remote **promisors_tail =3D &promisors;
> > +
> > +static struct promisor_remote *promisor_remote_new(const char *remote_=
name)
> > +{
> > +     struct promisor_remote *r;
> > +
> > +     if (*remote_name =3D=3D '/') {
> > +             warning(_("promisor remote name cannot begin with '/': %s=
"),
> > +                     remote_name);
> > +             return NULL;
> > +     }
> > +
> > +     FLEX_ALLOC_STR(r, name, remote_name);
> > +
> > +     *promisors_tail =3D r;
> > +     promisors_tail =3D &r->next;
> > +
> > +     return r;
> > +}
> > +
> > +static struct promisor_remote *promisor_remote_lookup(const char *remo=
te_name,
> > +                                                   struct promisor_rem=
ote **previous)
> > +{
> > +     struct promisor_remote *r, *p;
> > +
> > +     for (p =3D NULL, r =3D promisors; r; p =3D r, r =3D r->next)
> > +             if (r->name && !strcmp(r->name, remote_name)) {
>
> r->name is a FLEX_ARRAY, and Clang complains about this condition:
>
>   promisor-remote.c:34:10: error: address of array 'r->name' will always =
evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
>                   if (r->name && !strcmp(r->name, remote_name)) {
>                       ~~~^~~~ ~~
>   1 error generated.
>   make: *** [promisor-remote.o] Error 1

Yeah, it's a left over from the previous version where it wasn't a FLEX_ARR=
AY.

Thanks!
