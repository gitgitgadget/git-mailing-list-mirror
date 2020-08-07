Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22110C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 09:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98EC2177B
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 09:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dg144JEd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P/VEN3B2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgHGJES (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:04:18 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36947 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbgHGJES (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Aug 2020 05:04:18 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 238DF5C00E9;
        Fri,  7 Aug 2020 05:04:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 05:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=jmyynSRoB5UXmN0kCIItEf1Oe2A
        RZapb4ZtCHybBjM4=; b=Dg144JEdMljjpBbaFgarzWo956B6tLnIkq5xkqf/Imz
        tALSxLoUl5fqXCUZaP2TIMZTlYY2p7IkW0cXVOSyYBzGyJlF36ehf7A/jltJh394
        /mI8+P6cCDq2tSVCkWBeIE005F06HJ39Z5hcp8k2nmIL4UfFBEWdpxpo15F6NhHu
        Qg8k82g78T4CFM4BUbqCSg7m4dJacA9SBC6eay98dzGPEPtv8YffIUu1kI2LG8FL
        gvbLRj5GFO0hWI1rC50ZYun2EX5IoxcHCET333/HSWF+CfM7+04UxrX4xaEoy/+7
        KB1/goj53WD34BJ3SkPa+F5JcwiUY/wjX/KF7cB6+Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jmyynS
        RoB5UXmN0kCIItEf1Oe2ARZapb4ZtCHybBjM4=; b=P/VEN3B2qpy3priywdN4ZJ
        36kenCvJrs9Wwbp233EvAwV/WPnq6Iew5XAdi7QtTf/qdXlVgDGNeE9sXATE8aZQ
        Ebp916UVd34XD4q5wJwwwJ/9UUwuDKi+IMLWqU+0djuk5Wgs+unyJxglnNnIAdJq
        51W1ZTO3HJOWRkd4/dT+0G5Td4inL0NV4FZgqrQSLd+GNqrjnGIZQaNVrDtCZjy2
        OTJv2NH6lxE9/00tKO0+pELKw9d3bnShDdTE79wy7UAfj+mEs3aGNHrV3JJmMT6E
        ucMefpLuBkTgJzH/c8zVGuJ7aL1TNplbHGtsJ3rZslKwldmovA4uZPqfUPs5sh9Q
        ==
X-ME-Sender: <xms:EBktX7KaL0aAWBsrfKSsoXvtyIPXkU0QfDZSQK9-zpk6Vkvf5hgqpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedvgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeiieelgfekvdfhhffhfffgheejgeejudetle
    eifffftdeigeefkedvgeegheeifeenucffohhmrghinhepphhusghlihgtqdhinhgsohig
    rdhorhhgnecukfhppeejjedrudekfedrvdeirddugedtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:EBktX_LlTucDCbH-vkwNKHIupldQrX3lA02iJgYqkE_6G_Q9Tab-vA>
    <xmx:EBktXzuspy37sDCkrQWQtvN-pT2kiV2SIc27lQT9dlaLmOFyLuaKcw>
    <xmx:EBktX0bDaEoiFyXtZaIj7TQuxbHZXFYMkXhidw0KDXBMKKZJP1dObg>
    <xmx:ERktX7npQROPtlZjfpvPyvVUa4m93lPsXOy6-MoWrTZfrnaxlXb1OQ>
Received: from vm-mail.pks.im (x4db71a8c.dyn.telefonica.de [77.183.26.140])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3A780306005F;
        Fri,  7 Aug 2020 05:04:16 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3c4ca0e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Aug 2020 09:04:13 +0000 (UTC)
Date:   Fri, 7 Aug 2020 11:04:12 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] refs: fix interleaving hook calls with
 reference-transaction hook
Message-ID: <20200807090412.GA1407904@tanuki.pks.im>
References: <63fb363375b515b903ed1269d10124b727c1d1cc.1596783732.git.ps@pks.im>
 <20200807075837.GA32344@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20200807075837.GA32344@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2020 at 03:58:37AM -0400, Jeff King wrote:
> On Fri, Aug 07, 2020 at 09:05:58AM +0200, Patrick Steinhardt wrote:
>=20
> > In order to not repeatedly search for the reference-transaction hook in
> > case it's getting called multiple times, we use a caching mechanism to
> > only call `find_hook()` once. What was missed though is that the return
> > value of `find_hook()` actually comes from a static strbuf, which means
> > it will get overwritten when calling `find_hook()` again. As a result,
> > we may call the wrong hook with parameters of the reference-transaction
> > hook.
> >=20
> > This scenario was spotted in the wild when executing a git-push(1) with
> > multiple references, where there are interleaving calls to both the
> > update and the reference-transaction hook. While initial calls to the
> > reference-transaction hook work as expected, it will stop working after
> > the next invocation of the update hook. The result is that we now start
> > calling the update hook with parameters and stdin of the
> > reference-transaction hook.
>=20
> That makes sense. I think of push as a single transaction, but that's
> only if the caller sends the "atomic" capability. Otherwise get one per
> ref.
>=20
> > diff --git a/refs.c b/refs.c
> > index 2dd851fe81..17e515b288 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -2044,7 +2044,7 @@ static int run_transaction_hook(struct ref_transa=
ction *transaction,
> >  	if (hook =3D=3D &hook_not_found)
> >  		return ret;
> >  	if (!hook)
> > -		hook =3D find_hook("reference-transaction");
> > +		hook =3D xstrdup_or_null(find_hook("reference-transaction"));
> >  	if (!hook) {
> >  		hook =3D &hook_not_found;
> >  		return ret;
>=20
> The fix here looks obviously correct, though I have to wonder if the
> caching is even worth it. It's saving us an access() call, but we're
> about to exec a whole sub-process.
>=20
> It's perhaps more justifiable when there isn't a hook (we're still just
> paying that one access(), but it's proportionally bigger). I kind of
> doubt it's measurable, though, since a ref write requires a bunch of
> syscalls anyway.

Yeah, this really was done to not have to pay a performance penalty if
updating thousands of refs if no reference-transaction hook exists. E.g.
if doing a non-atomic push of n reference, we'd have n calls to
access(3P). See [1] for reference.

I've just did another quick benchmark without the cache, and it still
consistently shows a non-zero performance hit without it:

Test                         pks-reftx-hook-interleaving   no-cache
---------------------------------------------------------------------------=
-----
1400.2: update-ref           2.82(2.13+0.81)               2.86(2.19+0.78) =
+1.4%
1400.3: update-ref --stdin   0.22(0.07+0.15)               0.22(0.07+0.15) =
+0.0%

Patrick

[1]: https://public-inbox.org/git/20200603165142.GA24049@syl.local/

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl8tGQsACgkQVbJhu7ck
PpSvUQ/+K4uMjiqZy5TPDXEfBJ0pb+njDs0l2Mgkkdgscm2nX0NvpjdH0IVmjz04
a3Wfwghkc5ckDtg/s/HH7wT7Rb0lotETL34jOSmHr3cEUaMAlFT8xFNY+mRr35y1
uC7hiRJfKlWQbefbG2Fk8hHkcYVpBh2PFP/8gw34CE9TrSpYJEpX4VPAxOiiYSME
7fiZJ2SYDidgOZ5TDDSpd6pdwO5d8oj2WZORdxUFlc75OzKuEdA+gbwXtlbLF8hz
yYDRg0K3Jd3USRaB+mj5m4KghJKoi+zfy372AOk/x6CIbCgRsFeDOkPrpGWC8emY
Ti5fs51kUoR/0WTqchBaHDeYtUc7ghg3mdtwnwxR0Z4i9Gslh9spxz9CnVBf5lpq
dMNm3+tioFVW/mbOilDOsW+6XjFAnQ+2J3r9Ip5XsM10ra3Pmo7sMhHo1+bfUELq
V5dhF+A0fcGWTc9ZfaaLRKTvjyspHzwK4LoZPzLAA48McOXBpTZNBvKlziVfwYmh
sGVVXYTLSk0v642OIZzlaB2J13BCnVuNWhlcs64/eh4a8SU7JSm0lk7mYoY+NETM
dPyYzckhvvdFF+wsuzxz+DcLFSbKUGnyDpLhdo1sgAXffPQzvn0+4V03lWRG9Niu
xXKdgEzVerr1KvTYMDDTad0hX0bQbBAFzFCklWXtwwe6Z77ZJYc=
=pKlX
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
