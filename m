Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF706C433EF
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 12:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245051AbiFDMrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 08:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241052AbiFDMrk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 08:47:40 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Jun 2022 05:47:36 PDT
Received: from smtp-out-5.talktalk.net (smtp-out-5.talktalk.net [62.24.135.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD8F13E26
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 05:47:36 -0700 (PDT)
Received: from app-12.app.tt.ham.xion.oxcs.net ([185.74.64.161])
        by smtp.talktalk.net with SMTP
        id xTAnnA0RKoOuUxTAnnmwH3; Sat, 04 Jun 2022 13:46:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1654346794;
        bh=M0w3oxPfExCs1qwV5CJmD8kn4iRHtAqtHVAVHKmWDUI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject;
        b=oZLQeDT3kESYyqnCOJgVMPPDTPXZWJj/dSkTZReW5RQ0aZzRqrH5iCXcQ7ejQbUfL
         y5kM2NiiqMEO9YsMaIK1pG2Oh80HaghGJDGebYVohphBApfne2O3XBVAVIse/pqfGh
         KEE4eSUsVjCvGwdFV1jTSOBOK9u8f6je4MpoSaT4=
Date:   Sat, 4 Jun 2022 13:46:33 +0100 (BST)
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
Message-ID: <870925774.539833.1654346793623@apps.talktalk.co.uk>
In-Reply-To: <RFC-patch-07.15-cf1a5f3ed0f-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-07.15-cf1a5f3ed0f-20220603T183608Z-avarab@gmail.com>
Subject: Re: [RFC PATCH 07/15] strbuf.c: placate -fanalyzer in strbuf_grow()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev79
X-Originating-IP: 31.185.185.192
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4wfFyD10ycq2PfD720Fr9543WWWj+yWVi6+sBKsEzT0zsism7IpbaoqghrgVUzGDSStuGywWO1lDQt5mfwUOJ1sP1RhG3GX4hVwV1Xbjvmt0a/w0xn1wY/
 8hYgCWdOYddeDbJXYWcL5S28RTAs3qBTeErNmiZpq86huXguTt9R8xm7NeiX8yHUui2G0vlLhSIfBW1kVNAxbySLXgSnL4o77tFLlTl/YbSlIBzHGs7XSD5j
 PogEBBXopgiRA3jDXMHSfGVIYO2rjjp65OHVGZ1wgbJ3GkIReGZn62HUM6l+uitUkZvZq9qRud+VtSQWz9CXhN7Qf1DtW+SBlHtR/aarih1kShr5xvLfv/db
 vfl783AkcIb5yJw1w4nrOi9k7oYYr29B/7JlGZydFzyF3BMeCowqrR7gYtc+Txmtrn6DTNXPKY4ppJDT/qXWUDXPEHA3GGVvm4/2FMlCh63ROn10lvtobzbI
 1ZiavumVBk9HM9Bp
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var

[This is an old address that I only have webmail access to, please use phil=
lip.wood@dunelm.org.uk when cc'ing me]

> On 03 June 2022 at 19:37 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
>=20
>=20
> Change the strbuf_grow() function so that GCC v12's -fanalyze doesn't
> yell at us about sb->buf[0] dereferencing NULL, this also makes this
> code easier to follow.
>=20
> This BUG() should be unreachable since the state of our "sb->buf" and
> "sb->alloc" goes hand-in-hand, but -fanalyzer isn't smart enough to
> know that, and adding the BUG() also makes it clearer to human readers
> that that's what happens here.
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  strbuf.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/strbuf.c b/strbuf.c
> index dd9eb85527a..61c4630aeeb 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -97,6 +97,8 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
>  =09if (new_buf)
>  =09=09sb->buf =3D NULL;
>  =09ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> +=09if (new_buf && !sb->buf)
> +=09=09BUG("for a new buffer ALLOC_GROW() should always do work!");

This is a bit ugly, have you tried adding
__attribute__((malloc (free), returns_nonnull))
to xmalloc() and xrealloc() ?

Best Wishes

Phillip

>  =09if (new_buf)
>  =09=09sb->buf[0] =3D '\0';
>  }
> --=20
> 2.36.1.1124.g577fa9c2ebd
>
