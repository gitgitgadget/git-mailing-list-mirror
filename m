Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F90B1F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 23:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfHPXA6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 19:00:58 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39779 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfHPXA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 19:00:57 -0400
Received: by mail-ua1-f68.google.com with SMTP id k7so2630055uao.6
        for <git@vger.kernel.org>; Fri, 16 Aug 2019 16:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tiIzENa/LsyttsxhQJCg20SM3mO2VV9nKHegpbdtJzY=;
        b=vMZpX0bJLl2dvrM36DiShU8ndhdedzg+grA/SeldWHFF+2YeqiYyHUixatRorg8UVk
         M2acozkLUOE73aw27LZYxFRxwbApam3dRuXdx9unHllbt4+r4j+sgxY3zv1YQmP0msBO
         v3dTdSUZRN7aAKJrp8mJXTZTs05vwi/vACodrbhuxXdGVHuj8QwIs/oS96E7EQIxFyIp
         OOQc0ErqdnhFW/Ex2y0T86UEvmVfGeoPhsfu4gOlExStZFN526xSEG2DNnFViOae7qoK
         BBttYw56fJnkuAEOYNXj+iVYb40QL8QPcqpaesYZYgd86EpGL5f9BZmHUQ3rI3/5n3v9
         NuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tiIzENa/LsyttsxhQJCg20SM3mO2VV9nKHegpbdtJzY=;
        b=hdWtkJcL/9KR8WZH/Ip1yktDT4PVHMeGZ8Ldq3BlUAHttlGV0+bjO+ceghuH0kcB3r
         QbJM10ttM5kviWG1c9pEL1KjUZV871bczqABDqUc7ToJLEjaT0S8z2lWrV8KHWnQjAhe
         Xw0lrGVPdaI3WerHGmCG1RwbZfMZT5HHkgqKdO5sJzZbWLz19ijoG5CrQ4UOxg7Ax0a3
         XELsjxO6dcIV2FAX4ei89SyBZRHNfxjucDXXImGY35gltWrdweVsL157ydL8PQX/H2Xm
         XbXRDB4esYxJvZRTSHaY+kjIbUkaDskAuQugjaNjyPTHxuY+AyTMLkxx6zNXPL/bJizd
         gTCQ==
X-Gm-Message-State: APjAAAX9MjbwWbpgPphrAydiFb6xbThyGYjLqteU1tLNL98XOX8O6C0u
        WulwE9YBiD3tj8Wiw627PCN6YvTPbQxhe2YC4jQ=
X-Google-Smtp-Source: APXvYqz3Bfi+k5ZcLKskrU1NSg3oD60lykYqrVHFAGik1YrFlp14zgOaBqu52wHfhI2uBWp12a34+ACOdYzJNeNRuio=
X-Received: by 2002:a9f:2230:: with SMTP id 45mr7601259uad.87.1565996456779;
 Fri, 16 Aug 2019 16:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190726155258.28561-1-newren@gmail.com> <20190815214053.16594-1-newren@gmail.com>
 <20190815214053.16594-22-newren@gmail.com> <20190816211922.GS20404@szeder.dev>
In-Reply-To: <20190816211922.GS20404@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 16 Aug 2019 16:00:45 -0700
Message-ID: <CABPp-BHcrfMYOxJXAke5R3nq2hqJVupmOCNv5NnWoLT3W=Odcg@mail.gmail.com>
Subject: Re: [PATCH v3 21/24] merge-recursive: split internal fields into a
 separate struct
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 16, 2019 at 2:19 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Thu, Aug 15, 2019 at 02:40:50PM -0700, Elijah Newren wrote:
> > diff --git a/merge-recursive.c b/merge-recursive.c
>
> >  static void merge_finalize(struct merge_options *opt)
> >  {
> >       flush_output(opt);
> > -     if (!opt->call_depth && opt->buffer_output < 2)
> > +     if (!opt->priv->call_depth && opt->buffer_output < 2)
> >               strbuf_release(&opt->obuf);
> >       if (show(opt, 2))
> >               diff_warn_rename_limit("merge.renamelimit",
> > -                                    opt->needed_rename_limit, 0);
> > +                                    opt->priv->needed_rename_limit, 0)=
;
> > +     free(opt->priv);
> > +     opt->priv =3D NULL;
>
> Coccinelle suggests FREE_AND_NULL(opt->priv) here.

Thanks; will fix.
