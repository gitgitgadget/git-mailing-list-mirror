Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4887C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 09:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbiCKJLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 04:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiCKJLa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 04:11:30 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EDB1B9887
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 01:10:26 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1BE9F5C0269;
        Fri, 11 Mar 2022 04:10:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 11 Mar 2022 04:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=Ry5Fhu9XwGtgzB2KA3GFO27gPAtlYYwFduFEla
        Ze/3A=; b=hr51/Ubw9VeF9BusIkYtqMYumAHrjYTPXVroB4Wb0OuACrxgkeMIlY
        vRsbJpurRGlwY57yRrqjumCcRdkLZpGHfEB8IRZfHhUlUvDxu/jSMMI2Eb3zEFik
        6TWEn0Sfk2qXVkYDb0BX/YfWoOb+vJ8ST/EyuCRknUKLUSQfA9qkgDyGZRn/rv7+
        I7ewlZNEfI6Q4c8w4GEIZXYzIT/lyQMTJrjrjld8yQ/EyPCZs3V3Pqs3dVQ8N1DM
        ei0CNLD4RXaX10pEFm3NtBa+ZNhkoyBzgZzoNUuyvpJPYb8D/EzAS/Ms7Qs5ra/0
        n9rIxtw5t1VWGnULS42VRlnWf3axV4+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Ry5Fhu9XwGtgzB2KA
        3GFO27gPAtlYYwFduFElaZe/3A=; b=H5TTdTlPrYXaQdt7Z1KBiQvaofOBBk9jU
        cQkLHPda2wBEjxMWvivZuO+NmsibUZXC7jxEW3Wb3bOUsh0ZbAHSk/F4VU20Bggo
        O9793gkGkYaoyxWBhxqN1ZAXGFsDCSn+y0qzWhC67S645CH4b8zm1fZbK/7l77RS
        bSgOyuRNBEmRdpSDn/O+Fov3D83VRrwF7N41vCkrZzSq3dDilRiLfvhYNV2tLiwQ
        xPCRkd1WjXc06nqQsSHfD2FE4UfbpVd9ulJUUWOvPSlCSvx9ssdGjZGdMqt2+5NE
        TpyX1wFtiV5ykH42PMF9c2nE2+E+XNt2SnhXKA8JBMXmFuDb47DKQ==
X-ME-Sender: <xms:_xErYlPZ3_WuBmMJl2i5_k4DXnZoUcj_C0SdO5dj99TIgALwWsg6Mw>
    <xme:_xErYn82Cmgm3ln2cJZIPW4CEw4COpFJue0MoSoba0fWcxy0E8ENAYsZrzvKLPJKX
    WbVYU3hjpbNoeTCZw>
X-ME-Received: <xmr:_xErYkSmw88kZd4EnVFD778T9WWrSdYsltQebvCS1uqrLxiOtogfYxG0cjuLoDyu0-57KWFYrnX3efy05J-j6-RbKOvCm0a0kQtqptbciOdeuveAMKGggVkL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvuddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:_xErYhtPQsEDOMVi0pgWNsXdwWMnXbbjEb9X6IKLEJnadu-7l7Bhcg>
    <xmx:_xErYte0dW-JLSh9sE64xXRlLqaMo9Wifg5J_lLttnyg4yVpM0-p0w>
    <xmx:_xErYt3Fsd5NfhmBNLYM_ctWGSabUsKv-oyn6VvgwKMw4iuhITDKqw>
    <xmx:ABIrYnte-sJ2TDypiqhkkD7Cg79p8HpAqsyG2DEbKG23edafYV9QZA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Mar 2022 04:10:22 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d3c7778f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Mar 2022 09:10:17 +0000 (UTC)
Date:   Fri, 11 Mar 2022 10:10:15 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 8/8] core.fsync: new option to harden packed references
Message-ID: <YisR92nI81SHlOYb@ncase>
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
 <3b81d8f5aeffb73a32b0bff0da947f023a3df517.1646905589.git.ps@pks.im>
 <xmqqzglxek5y.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/7DGk4AHKL9kImVi"
Content-Disposition: inline
In-Reply-To: <xmqqzglxek5y.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/7DGk4AHKL9kImVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 10, 2022 at 10:28:57AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index 27dd8c3922..32d6635969 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -1262,7 +1262,8 @@ static int write_with_updates(struct packed_ref_s=
tore *refs,
> >  		goto error;
> >  	}
> > =20
> > -	if (close_tempfile_gently(refs->tempfile)) {
> > +	if (fsync_component(FSYNC_COMPONENT_PACKED_REFS, get_tempfile_fd(refs=
->tempfile)) ||
> > +	    close_tempfile_gently(refs->tempfile)) {
> >  		strbuf_addf(err, "error closing file %s: %s",
> >  			    get_tempfile_path(refs->tempfile),
> >  			    strerror(errno));
>=20
> I do not necessarily agree with the organization to have it as a
> component that is separate from other ref backends, but it is
> very pleasing to see that there is only one fsync necessary for the
> packed backend.
>=20
> Nice.

I was mostly adapting to the precedent set by Neeraj, where we also
distinguish loose objects and packed objects. Personally I don't mind
much whether we want to discern those two cases, and I'd be happy to
just merge them into a single "refs" knob. We can still split these up
at a later point if the need ever arises.

Patrick

--/7DGk4AHKL9kImVi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIrEfYACgkQVbJhu7ck
PpRuAw/+LhtKSuj0R/DHIVf362n9cDi7I73fo0w1Pd2G7sdOaQg6omoah6/6tUxR
KENXdw9dN6R/zJCpx+2LIZJ89Wtk2+3b4mdJVaeEalvT310wSAn6Ss3AjROt2kmy
MPY4A7XogNxSUTOJfR01RY69bX3QimbzkcLyySuirJ8slCdVRTR/30SBQMuFWBaX
8tGoyqk3eh36b0/Wa+1RXziPF00QCBQLJXwvo5NVAHvQU9MwS4F50v/lsWqGttvD
ZRqZAaDlUrmoKXaBqi19/6feXLNtENHH4NTf1H3a+SFjum7fbSR3bmqyfvRWmKM6
C0gFC68DuNqdRNQmFm8qiShoVFPQVn5CkA+xqz04ZggablSrUT96ZmIOZTn/GjRb
/KHQpa5im1ZGo05LKEGWQmyRlgNHxw8+DpHYfqHGp/1r9Jw4N0ZIw8DHQpUcA8sp
yEOKYDgCSpF+kB6wHVoerF+oeGg5Z2LwnSexMNsIMM7d5j+DdYYVfgt3t3Zar7l8
Tq4ClUkMXEIL8hHrtZz66eNoYVLDoD6Pr1LqMlwGg6zo77st9m4YP7v3vKohQXeM
bpgEv6Ovxz3rmabhdZh724Wc8SqRdlWpMZJtg2fH21qN3NxNE/Xy0SgZ2s3w6skM
A8tpVTEIvAIBmIk7qZJW0U/xLyF/Jn8NFT9geFk4VO9RdRBcSRo=
=8IqW
-----END PGP SIGNATURE-----

--/7DGk4AHKL9kImVi--
