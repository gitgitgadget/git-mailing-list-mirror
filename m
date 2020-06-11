Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5E9C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 14:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE212083E
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 14:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MpYgctNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgFKOJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:09:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:56341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgFKOJj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 10:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591884570;
        bh=3PJ5y0qzEURgJqA/czTuljkh6BxuUuQivA2lhBbEPJ8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MpYgctNowng8wNBFLb7GeepFCyK/TaAGcgnc9gtF4HQSPcZe3ivvIlTzZMP6uGAwg
         qo56RWr6fYH7rrDi9HpX0Zb+XVhfXNkjGXNmnaKzVOD09e66rUvTxj1PrQm671ADVJ
         /RUS6bdCavGVkUXBhzVj6VA09yrehbjJenQo8aRA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.212.132]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sHo-1jnDNQ05CM-0053v9; Thu, 11
 Jun 2020 16:09:30 +0200
Date:   Thu, 11 Jun 2020 16:09:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
In-Reply-To: <CAPig+cSnEvVB5vsffFXidG1-XNxDX10u2XhD9NqV3pwh8zyxxw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006111607450.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com> <CAPig+cSnEvVB5vsffFXidG1-XNxDX10u2XhD9NqV3pwh8zyxxw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XQkMtmKNL7ddsHsEHDQq2eAM9qvEELsq+c/utHIopPrUU3yDCw1
 zhSvI/ck+GdaWRbHjWLDaM/oixJAoPOew2aTHZZRrmsZ744x6GYM3e/joaHDnDUaABj+EcS
 gk3i++ly3OgNCXZ3p9SDszz2TE7Bxo80WAgHh0V7jTkyVIyJH6VIo4nRW45PBiZ2rAugZb9
 lIIAczxw02KDwmI+IkRug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L09hk1IgZhs=:4ZMsVkbdslMQUT31LerN6R
 Kqlb8IfOnZsZjvQCiVE3WJWGRpWx1vd+D6OYsuD3xQr2hF5DqEGHr3kIYiAN6n+JN71CQPYQI
 Lngn4d26SkkD0rUqGIJ9NzD9/VZQOiLXeDfoYdL6BfTLESN8/Z2LrrEdZmxykAEQwDAdEk413
 O3OfyHBhTtN8WXn/AQqeZ5vos8mKToLNfAh08IxvNR1JOnULNqdfEiLmsihmrEao74Uy5bOHH
 NRIQHseBoVopACPMPyBixpV9kfoN3Aw0eY9uM9D+3VKUlhVnK2WFqy0Nf35iAYNJ2x8g+xfYH
 xyJvY+FMmoS5b1DVAkjxQw7Oqf9b5mhE0sULqa5LTG/ndNHNNCBakCm9JMDKP/IJFQzQY8DMW
 aepeopJo49Jm2MdxjkQDLQqHKUhPEn1KFaQZzU3ctiS4qV2SM+DWAXYc/lAqYOD8g53hG8eO+
 qZV0F5u7FHsUu/zBV1g0CmhnhgIi+q8h6Yg91zGU41KQhqMbs+E1jRws/ZvyA6VxwuhPXPd4w
 HvIFjr0joKBFjVh51r0zg8QWmNB41+LyS0kZEAE7gDE90MCXNXVWrWfCUIhMJbet14qMkcxHE
 wZySVH6N8hsBGlwX+vTKna+L6yFXzRfjut8QBTAjFTILyOjG59ZSsHnrpUiQ+4+utPvMNmy10
 foDvOCEzl/itMXTqpOu+/MeWhl1swXJFMFpY0Y/N2OgQXjPIl34H8q9XFhvkIpoCKELUWEbA8
 nTG8RvrDTYzAkNwjVwi1L48VlcVBI72cLvJdoYyyxSfkq8oxms45nCMYje6uvxMPYyJ4+gyov
 OTgYfEnQrggOjjMpAJqR4texlLnIzua/THBVaEg6v7f8ZkH4L2/MM18kdOVFj96CSGzuZf5T0
 FYcqqlD0Y/QeBUTK6byIHRbCHo8ABvkIHqFZkche3XnGJLxFIWuZrXdVIsupIpRDksGNzQlrZ
 1ycFWW8vJOsDIH1AaSPH408A1/HqwUnalK9As79WnV9JWceGrOZ8hl4g9vB5FuckIwBkLIVBt
 VMWIqv54jaxteV2CT6aFddUWl16zqBPH79vjfgG+v9B13T4l80IF8/QZXzvZw37zvANfeiBv/
 bCCP3yYU5Nl0y47GutznaNwM4/67Et6J4WlQW0SKHlUOqoobrKsaigs9ybmKdPTaVp/Zsbr0A
 fv0E8vbuRiXb5qPY3B8fDAC0EHWVD/uzsrcUopmaq1bqM3OL+ViNWqrF2w4lm+2MeJEbAiChm
 SgwZ9C7hVH8Xg24dm
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 10 Jun 2020, Eric Sunshine wrote:

> On Wed, Jun 10, 2020 at 5:19 PM Don Goodman-Wilson via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > [...]
> > To make this process much less cumbersome, let's introduce support for
> > `core.defaultBranchName`. That way, users won't need to keep their
> > copied template files up to date, and won't interfere with default hoo=
ks
> > installed by their administrators.
> > [...]
> > Signed-off-by: Don Goodman-Wilson <don@goodman-wilson.com>
> > ---
> > diff --git a/refs.c b/refs.c
> > @@ -560,6 +560,40 @@ void expand_ref_prefix(struct argv_array *prefixe=
s, const char *prefix)
> > +                       die(_("Could not retrieve `core.defaultBranchN=
ame`"));
>
> Nit: here the error message is capitalized...

I downcased it...

> > +               if (from_config)
> > +                       branch_name =3D from_config;
> > +               else
> > +                       branch_name =3D "master";
>
> Non-actionable nit: could be written:
>
>     branch_name =3D from_config ? from_config : "master";

Good call.

> > +       }
> > +
> > +       if (short_name)
> > +               return from_config ? from_config : xstrdup(branch_name=
);
>
> The logic overall is a bit difficult to follow when trying to
> understand when and when not to duplicate the string and when and when
> not to free(), but seems to be correct.

I agree that it is a bit hard to follow, but then, the function is really
short, so I hoped it is okay.

> > +       /* prepend "refs/heads/" to the branch name */
> > +       prefixed =3D xstrfmt("refs/heads/%s", branch_name);
> > +       if (check_refname_format(prefixed, 0))
> > +               die(_("invalid default branch name: '%s'"), branch_nam=
e);
>
> Here, the error message is not capitalized. It would be nice for both
> messages to share a common capitalization scheme. These days, we tend
> to favor _not_ capitalizing error messages, so perhaps remove
> capitalization from the earlier one.
>
> > +/*
> > + * Retrieves the name of the default branch. If `short_name` is non-z=
ero, the
> > + * branch name will be prefixed with "refs/heads/".
> > + */
> > +char *git_default_branch_name(int short_name);
>
> Overall, the internal logic regarding duplicating/freeing strings
> would probably be easier to grok if there were two separate functions:
>
>     char *git_default_branch_name(void);
>     char *git_default_ref_name(void);
>
> but that's subjective.

For such a tiny nuance, I'd rather keep it as one function...

Thank you,
Dscho
