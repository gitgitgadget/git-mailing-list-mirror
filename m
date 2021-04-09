Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED7CC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D0D610F7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhDILOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:14:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44003 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233932AbhDILOp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 07:14:45 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7FEFA5C0065;
        Fri,  9 Apr 2021 07:14:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 09 Apr 2021 07:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=bJmILJaFhH0WiuqkuC8bA3RXzJX
        zxtyPZRJGfz1TrR8=; b=KD6vgTbGwClaADlGgS6WO5awkid+4xe/W1ZyEnp+Uza
        IhDfZoTOd5BHJ8EaYAScgXnR9YedEF+o5kYfF180ygy2HOXkY10dJvp/px+xarVp
        vE8G8MT9xM4LtkhHaapBUig+9dVpKvVmuuqB211PnMaPagEbcLKHNsyTfqLjano+
        lbaMp0W2jMDF5sovdg912UiIeCY94u1MnUwD5cTJqyEElRp6TXWbjT8N5AmTVJ+y
        E/YutlGufLkhrE2oUOyfjuSZTltP4rqiV3CINOBX7qLlhciMyN2pu7kFchohPx6F
        LSzWczODG/vszGwusvMwDey+9iewztrpuFt5EO0nMtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=bJmILJ
        aFhH0WiuqkuC8bA3RXzJXzxtyPZRJGfz1TrR8=; b=ojtTFwIV/rgYj2tzQ/BLn/
        Olxnwc6WFB3j/66Y+saGFi6Mu4+er5D74ks2s/xkswut80glQzDtNvLopg/4ycSs
        vKZqL7w/ceC4J0ZsIQwMx7NTDMms/3iuKbv4uxCuqqSK4goW3WV7uY5bYe5VRjgI
        7Ne18gM5WqTNWkOpEuW6WWuRxcpZIi0hADZB0qttWsEKkrypBUzAyZvz6hNgPNjE
        gRVc6F1HYEgWiUcR7QVPTODweFcwS0avw6qupoor4HGzlsUESrT/XbxAADqFdLH6
        R9S6uoNpmDQV/G9l2c5suZ6oEbtjSjmLrWfLSj9BQytSUwfU+ulixUPUnyc8K84g
        ==
X-ME-Sender: <xms:FzdwYGslkKTR_lwMXZoflEIgU-4eR8fMoxYhUmZLaxrElUPIAQ_RAg>
    <xme:FzdwYLcsmCOFC7YZVuSSBczqWl23ps-cmgwKILqgeby1NUrh8Gx9iAIJ9_MmW8_7H
    -qJMx9LACLWswOTrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdekrdduieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FzdwYBzMC8IlK24UNQociqNnaQuz_P55uBW2BxE3ZrFz8kt6h4kpuA>
    <xmx:FzdwYBN8Gu_N8ny1vUvxxst0tik31_Z2YhKJqHIFsOn6fFSOdXsnew>
    <xmx:FzdwYG-qh7HYFp5W1eJYS_SvAIuLsFbyJEVhAHTsyLRIBXk3MsV8aQ>
    <xmx:GDdwYIL2LXVAPdxxNIoLwLSyuP-pYCGKN_lPvIuTspCXx7eyKJi8cQ>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F761240057;
        Fri,  9 Apr 2021 07:14:30 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 4e5db764 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 11:14:27 +0000 (UTC)
Date:   Fri, 9 Apr 2021 13:14:26 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/8] rev-parse: implement object type filter
Message-ID: <YHA3EkH3HDe45EKA@ncase>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <xmqqblbdjzu6.fsf@gitster.g>
 <YGyjtCWqdeCj3S3U@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JK+mXRdn0PxzmOZF"
Content-Disposition: inline
In-Reply-To: <YGyjtCWqdeCj3S3U@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JK+mXRdn0PxzmOZF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 02:08:52PM -0400, Jeff King wrote:
> On Sat, Mar 20, 2021 at 02:10:41PM -0700, Junio C Hamano wrote:
>=20
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > > this is the second version of my patch series which implements a new
> > > `object:type` filter for git-rev-parse(1) and git-upload-pack(1) and
> > > extends support for bitmap indices to work with combined filters.
> > > ...
> > > Please see the attached range-diff for more details.
> >=20
> > Any comment from stakeholders?
>=20
> Sorry, this languished on my to-review list for a while.
>=20
> I took a careful look. I found a few small nits, but the code overall
> looks pretty good.
>=20
> I do still find the use of the filter code here a _little_ bit
> off-putting. It makes perfect sense in some ways: we are asking rev-list
> to filter the output, and it keeps our implementation nice and simple.
> It took me a while to figure out what I think makes it weird, but I
> think it's:
>=20
>   - the partial-clone feature exposes the filter mechanism in a very
>     transparent way. So while it's not _wrong_ to be able to ask for a
>     partial clone of only trees, it's an odd thing that nobody would
>     really use in practice. And so it's a bit funny that it gets
>     documented alongside blob:limit, etc.
>=20
>   - for the same reason, it's very rigid. We have no way to say "this
>     filter OR that filter", and are unlikely to grow them (because this
>     is all part of the network protocol). Whereas it's perfectly
>     reasonable for somebody to ask for "trees and blobs" via rev-list.
>=20
> I dunno. Those aren't objections exactly. Just trying to put my finger
> on why my initial reaction was "huh, why --filter?".

Yeah, I do kind of share these concerns. Ideally, we'd provide a nicer
only-user-facing interface to query the repository for various objects.
git-cat-file(1) would be the obvious thing that first gets into my mind,
where it would be nice to have it filter stuff. But then on the other
hand, it's really rather a simple "Give me what I tell you to" binary,
which is probably a good thing. Other than that I don't think there's
any executable that'd be a good fit -- we could do this via a new
git-list-objects(1), but then again git-rev-list(1) already does most of
what git-list-objects(1) would do, so why bother.

It kind of feels like git-checkout(1) to me: it does many things, and if
you know how to wield it it works perfectly fine. But the user interface
is lacking, which is why it was split up into git-switch(1) and
git-restore(1). It's telling already that the summary of git-rev-list(1)
is "Lists commit objects in reverse chronological order". I mean yes,
that's what it does in many cases. But there's just as many cases where
it doesn't.

Patrick

--JK+mXRdn0PxzmOZF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwNxEACgkQVbJhu7ck
PpQFpw/9EAnRl8RbO3nwkI3iJNfdGy71AAebWq3M52+J3MDa50xHN6FCsY4W5Rnm
8T6x15w2Zc4R2JuGk9+R99l5U9xPUH1TTm95LcqHmcw5PfuW4/TnV2Co5sKB9Yh+
XAn75YLMM69XdjEidMh4qXcQtLURSV3qzCY9y/1stXXOS7v5lCDZZza0fmzr25D5
hQjDLuyeGNTAgmXkkdLku3KOMz0AfqVrWhPUebrDFxSi/wcN0xExq+mY+92iLzuf
xDbOYqxO9YEETvwR17npkvOoyuGGbiOSoPon9C6pjn9lafJd9t/48kEiekLto8Te
f35pdoIsSx1By7WZgEeYComliPb/K1wgV7ZXyZCc8qon9exXX4dAEjAk8lyZDgpc
FvrtLl2rxE8dI4+tAd5G5k5Y8Gm5WQcdzi4u54UPctXeFKZi4dwD6IVwZR/eGX+c
FA6Pss3dq3kFxndroPIY4mwgWrzLGXzp3YLQ4kzLrKPQz1e5lIb/cT+6Fev0/Zqv
+w0PzoyyMLSfN8QFNHa21JZrk4NQ3Dm9R3S3srhjCeOubpzyy7ccvCTjLwaefKKG
WGowtAgsHT7X5t63NLG2+bBwesvg/2b6naushoAX1lpC1na2UaULOjmwhVsduVeX
A6Qv8A0nBf3Ncxqa9pWRhV7bQCXmP2jTZUKZSxqPWxvD6PJBnqY=
=SjOS
-----END PGP SIGNATURE-----

--JK+mXRdn0PxzmOZF--
