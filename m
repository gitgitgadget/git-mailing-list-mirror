Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35492C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 06:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiCQGKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 02:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiCQGKe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 02:10:34 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9F12C6C7
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 22:48:19 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C7F695C0241;
        Thu, 17 Mar 2022 01:48:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 17 Mar 2022 01:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=RpUhNXASy+LOHvT912VCbJS2DoHRIZOa6Q/GbU
        0SWDs=; b=pX71bPSNBFH1xRGsu8JI7N3YHOHAcBw7B4LB/F1Nic1JlbUokW4LJv
        nfW6fPq1bfc07419ZrWKpAlRF3tboMMibjNKQaY8rex3UZftbe0KZ/WkPGOO/p2+
        vUcXtxn6QvFVZv3fcjZRreyzQkGQt65M8IoDRjyBdar+iUtnD2r7hQmjzv6ngGe+
        C75W0KYbUvxEfGUryybmyuWM87qHRhwIivSvG9AXidtcxTZA/389rBrX3nIhcLV3
        7OTzhTq7POBqtTp3a3a7uiJSBTRHmGdg5sLKHSuOTjLY9y5C71jQotBOc0EvszgN
        6im2HHYes613Q0ZjEeXgne6Ud9qOVAQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=RpUhNXASy+LOHvT91
        2VCbJS2DoHRIZOa6Q/GbU0SWDs=; b=J/fO3AInVp7PXCfSag2pNotHl4cSbH+dx
        vZZ2aAjuwtuR+TYLCoK0M+xOYENnGy5hZrWs8H+2bCX3XZhWE8X1gbaUkDHR88zg
        InLaSebxzcxdIr7QZV/oAw7wzY302MV1H/jzP4kqj4u39odGINcgbFFR/3+4SExw
        qBZjIVxcJ/ikPr4J87Nk9BKZMZ8/KgHjmQSHpDMXZGGoceNdPcH8x08ER5cuRiCb
        8H2CRaWMV4vipvomnSVB3xIcUwfQYxhl4awotUoJ7fOUIybQHX7duGgQ62Tf+iok
        IotMiVmrsQlhSnQe6RVK4esrEY2assGrLNKjZMPymNcumwwfJV4zA==
X-ME-Sender: <xms:oMsyYhjHAuD1iyTJr87ZLafOwO1c5-e33b9dRfgqUUs36j33kaA-Mg>
    <xme:oMsyYmBxJIJ3qj2uJm2qnkF9fztUqzzlw5BqIiXdIo_8T0aFHlHENPSmxw7FK3-xe
    6Gsp2sdC7wMKDlQew>
X-ME-Received: <xmr:oMsyYhHeQOMrNy-_7YwjasfuKf6bnR4OvPsCMP8hqesRdT2CBR88FswqbH1GbQqkIv-D6UP3YA5UEJLxjU43m7cpVyZquAW3Nsiz8mZbAkECVJG0lwUCvx8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeffedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:oMsyYmQ_scQ_0awWG-Nd50UPEscqOfPccYfOsBn_Ha6GQPv4WcESvg>
    <xmx:oMsyYuyZ32LMWIZKG0Y-_VHDK8chvRO9OTNwL7ZNycZn7l5jp1mH_A>
    <xmx:oMsyYs4t9QtSQucFCyBOs7kSJBv-U04KxeymVc-A3pyqiC0OGZyjKg>
    <xmx:oMsyYovAklfeXJuuScTyGIPS7mVoYq4ut7Jzc2PnDSYsaGRIWiDOnw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Mar 2022 01:48:15 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 1ad201d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Mar 2022 05:48:11 +0000 (UTC)
Date:   Thu, 17 Mar 2022 06:48:09 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 2/7] core.fsyncmethod: batched disk flushes for
 loose-objects
Message-ID: <YjLLmRvvfkAOR4/6@ncase>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <d38f20b4430bada1d0dccc1e600e6f0b098f3767.1647379859.git.gitgitgadget@gmail.com>
 <YjGSOJlZnDSske3s@ncase>
 <CANQDOddkJ_iyUjYQAHs93nqCda1W6ss5JQzbz3uuh-XnoATg5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GTsBZDAlgzYdp6p/"
Content-Disposition: inline
In-Reply-To: <CANQDOddkJ_iyUjYQAHs93nqCda1W6ss5JQzbz3uuh-XnoATg5g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GTsBZDAlgzYdp6p/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2022 at 11:21:56AM -0700, Neeraj Singh wrote:
> On Wed, Mar 16, 2022 at 12:31 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Mar 15, 2022 at 09:30:54PM +0000, Neeraj Singh via GitGitGadget=
 wrote:
> > > From: Neeraj Singh <neerajsi@microsoft.com>
> > > diff --git a/Documentation/config/core.txt b/Documentation/config/cor=
e.txt
> > > index 062e5259905..c041ed33801 100644
> > > --- a/Documentation/config/core.txt
> > > +++ b/Documentation/config/core.txt
> > > @@ -628,6 +628,11 @@ core.fsyncMethod::
> > >  * `writeout-only` issues pagecache writeback requests, but depending=
 on the
> > >    filesystem and storage hardware, data added to the repository may =
not be
> > >    durable in the event of a system crash. This is the default mode o=
n macOS.
> > > +* `batch` enables a mode that uses writeout-only flushes to stage mu=
ltiple
> > > +  updates in the disk writeback cache and then a single full fsync t=
o trigger
> > > +  the disk cache flush at the end of the operation. This mode is exp=
ected to
> > > +  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS fi=
lesystems
> > > +  and on Windows for repos stored on NTFS or ReFS filesystems.
> >
> > This mode will not be supported by all parts of our stack that use our
> > new fsync infra. So I think we should both document that some parts of
> > the stack don't support batching, and say what the fallback behaviour is
> > for those that don't.
> >
>=20
> Can do. I'm hoping that you'll revive your batch-mode refs change too so =
that
> we get batching across the ODB and Refs, which are the two data stores th=
at
> may receive many updates in a single Git command.

Huh, I completely forgot that my previous implementation already had
such a mechanism. I may have a go at it again, but it would take me a
while given that I'll be OOO most of April.

> This documentation
> comment will read:
> ```
> * `batch` enables a mode that uses writeout-only flushes to stage multiple
>   updates in the disk writeback cache and then does a single full fsync of
>   a dummy file to trigger the disk cache flush at the end of the operatio=
n.
>   Currently `batch` mode only applies to loose-object files. Other reposi=
tory
>   data is made durable as if `fsync` was specified. This mode is expected=
 to
>   be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesys=
tems
>   and on Windows for repos stored on NTFS or ReFS filesystems.
> ```

Reads good to me, thanks!

Patrick

--GTsBZDAlgzYdp6p/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIyy5kACgkQVbJhu7ck
PpQbqhAAgTNl5bx5XQOpj5PRY7ey8ntEvPP1kuk+7W9RX58Ps6ylYk0qbe4USTHo
QpebZpP9GYws3tI8Ifn3LBq5I/SZUxyyYJWeeg1muSGG8uxLTzkLI6HThoBO1TWK
LiUp1aIGb1xQOAVf8RSvmAnXD/KPstu2v8qOdYmSqeaprD6Jkw3gZotekmDgxAlj
kVdS1dipAK/aWg4iOGsQo+Bi9V7wrLUlNAFKtJzNuWj9K+IXfGNXjvNfeO/ECEOe
tg678Pk0mi9keoVai0C93r7QrgylNXnnVSAyR0iqvsC3MnY70LCQcQr68Y5N1Yz3
DPaitshOz8r50EvM1x+W0raSaf381/Qsv2sJ/0ZdA5StrT5Q6xKBp+5MTHLMZ8Jk
VZsAsgSE9dyYP29gdz4nhbVvHsGGeSR+MaHkskw0eAQKFjPd2BJ0YCSGcIcL1s8U
tZVi65CsMXcZOj3hN28MFE9SyJHOS5+niHi+oTrMgRqAVNye/DmeXAcAkSYUKPkN
l4JFV0g/F+vHCD9yfbrp/xEGJuPFCgSaIdnyK1jcsi1GrlA1I5chRefNxk5TMc4V
IeGPFuc0307VEFF20daoEguCeMDzgazaaDxMmUWnUuyUokSizoQZI4vVSgL8oNh1
ova6NOpmlWE+5PQOWZb2C5lSjYbR8BbmV8gFlwMU7OdBpH37bwA=
=ZiDw
-----END PGP SIGNATURE-----

--GTsBZDAlgzYdp6p/--
