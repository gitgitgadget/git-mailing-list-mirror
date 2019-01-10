Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAA6E1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 15:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfAJPrk (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 10:47:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:58809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbfAJPrk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 10:47:40 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKHik-1gfyef0Yti-001f2z; Thu, 10
 Jan 2019 16:47:19 +0100
Date:   Thu, 10 Jan 2019 16:47:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Kim Gybels <kgybels@infogroep.be>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] diff: ensure correct lifetime of external_diff_cmd
In-Reply-To: <CAPig+cQKnEWb+co_NJ0UyZbXZrvx2KsbS_ZugdyjjYZcz8tjvw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901101646050.41@tvgsbejvaqbjf.bet>
References: <20190109221007.21624-1-kgybels@infogroep.be> <CAPig+cQKnEWb+co_NJ0UyZbXZrvx2KsbS_ZugdyjjYZcz8tjvw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:B5klk8ls8S81gwGnDyaiG8hVf94sYzyB8RPevuXRfpv3khu5kGq
 fJg1oqo3thY3MJepFqZEaO56R9fN3evii0WCZUfq4VAsW/nWxOBIaShyeuTrD64ERWmC1dd
 JI4BSFCsR/pN+3yqZwbYUaelbObAH9amAg9mvkDQVWX9lgi8mCR3R4ouY+2k/LH+gnEATFu
 674bd7sIyYTkZJPUsApfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ZY4k1e9M7I=:9r/EGBSDBgu9iY0UrFkQX9
 Rwsy7WxcGMdRA6Sz4tIevy5EJBdlgNinJAxK5w5AABNcZmTuicFrYZA6SX+u7vk5sTr5gRrrG
 /j4Tc3X9GlDNafmt6SXDQE7PxNhxq/34LAWNqaSPW3evFfID9IBYoN44qXzrfDLhnTUJ5+MkO
 Qwgaby2FCZ31nWjkXLgBQz6PbaQX6v30Xnso0j+eC5WzJQw68vyEcVhbsCdhokAJ388OWpczG
 y012bomS6bS42Ffx1hfPbvMwsZH1IgM4NQwTBqgMXkDqjyw+KOudcbIML3GpNIqiv4ECuJcy0
 kv0HmdJK08IECdVv1D+8rWe8L2+Wwzs3K8Hrq9L/5qaFoaGowzF+6xj1iduzBA5H4z4WGuPIg
 YWQu0lhm1RIG4gH/E34Ws/hkij+rWA2BbxbUjqkFozR4qV8oHrn+l2KxA0QeTy9d07a2uMDkp
 qEET+cbRdVLPCOjvtX/yDAkUB0U1Xe7Qr8+jYStD+4ZMlYcIUO0vG3QLpdmLp5EdsiUJynO9x
 5Xr+AJCf9ZR43gy6YIp3HmbwYsMM14PYDWulKF919DN8bWhUTVYcDY9vkVy12D6yQeJOMcS2S
 eaLIKduEIaQQ8TQsKjZevdOKZMF7MA5fHbvsr+HCUbAsQ3oGhh8wsQD0q4yLaZwUX/VThW6xO
 +PTaIPWiP4ovVnkQIFBr3XgpvmAAZKM0n7cHmppr7QrivQAuoGWTWpCY7SwY7X1XH4Y7sE52Y
 AxdKWVu6r21XXx3hTnGRovrFfOdDMvnkE7ST4oqzuY84757JAOweSMtHPv5fgIOEqHK4mlZ5E
 JfuneYyMqMk6xC8fCMSnkx7cs+DuFK3Aig5fvLy43TP/ZWFoLfUKaTxCxpSfozSxqnVUVMky8
 R0LtvahR/V2hrkKyoTZF9l/Kd+P72dRLwJ+JTJ7e1C07SfknLaZJO87bORTVZsoebIrGdZkid
 qIHDh5CeFJg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 9 Jan 2019, Eric Sunshine wrote:

> On Wed, Jan 9, 2019 at 5:19 PM Kim Gybels <kgybels@infogroep.be> wrote:
> > According to getenv(3)'s notes:
> > [...]
> > Since strings returned by getenv() are allowed to change on subsequent
> > calls to getenv(), make sure to duplicate when caching external_diff_cmd
> > from environment.
> > [...]
> > Signed-off-by: Kim Gybels <kgybels@infogroep.be>
> > ---
> > diff --git a/diff.c b/diff.c
> > @@ -492,6 +492,9 @@ static const char *external_diff(void)
> >         external_diff_cmd = getenv("GIT_EXTERNAL_DIFF");
> >         if (!external_diff_cmd)
> >                 external_diff_cmd = external_diff_cmd_cfg;
> > +       else
> > +               external_diff_cmd = xstrdup(external_diff_cmd);
> 
> Make sense.
> 
> Not shown in the context is that 'external_diff_cmd' is static, so
> this is not (in the traditional sense) leaking the dup'd string.

Ah! And that also explains why we do not need to take care of releasing
the memory via `free()` (which is what I was wondering about).

> I do find that the logic is obscured by doing the xstrdup() in the
> 'else' arm; it would be easier to grok if the condition was reversed and
> xstrdup() done in the 'then' arm.
> 
> However, you might also consider using xstrdup_or_null(), like this:
> 
>     external_diff_cmd = xstrdup_or_null(getenv(...));
>     if (!external_diff_cmd)
>         ...as before...
> 
> >         done_preparing = 1;
> >         return external_diff_cmd;
> >  }

I like this version slightly better, too.

Thanks for diagnosing and fixing this annoying bug!
Dscho
