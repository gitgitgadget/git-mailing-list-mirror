Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6C169D18
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520085; cv=none; b=Ow5HTG1KYlJZRNX2dJEGQU+a7qh+vrgo35uT6yOnBKl3ezYDGxX0QpL1kwmP6EwSBv950hCn2ixyVBrVfR3cM6x/qjoQCqSCcrUNy2vOxstCOwXWdmB/pIYBBX4Fe+1H5a5sZ3ydNBca8/PnJWQOBFKgI+dI2Sb3BC55GLhhGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520085; c=relaxed/simple;
	bh=8D+lcDd4WANnqloonE247yisScDk5RsFD6C7iNDfMTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnmGFbCADAAjrcGdwrnQ0dJe90ARbyJfmGYkkMkm6NYFAQjB4bRjCNN6SNIFQFpIcxL/Odpq2Cj98gqKmKuiG84HUxN7yH3nc79WTzuBE3ij677WSgqTgByJ3+/I05pW0rlRYA4amirajKn7WpYNjb/XFGW7EqJKPRNMBdZXhaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JR4jzHA0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jVoaFW+l; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JR4jzHA0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jVoaFW+l"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 406101C0008D;
	Wed, 21 Feb 2024 07:54:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 07:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708520081; x=1708606481; bh=hOcQMRWK4h
	38PdZTQDMJTZcyEvMzc0wq3SnIl1SxG+k=; b=JR4jzHA06cdkiA5AYbVzkqlOqw
	5/gzWCcIFHSvrP86BlSJt9HjOvjX4tgwY2ugFY17VJCp4xkWps//ThWk/86qdDB6
	+pB2vf6pFEoFPWNUfQjU+K7ljZug2umC5eF6AMnX6R/BRxzv/znG+Yu0HxxJtmsC
	YHCx4XvbwYrkLLnumjHR3JI7f0OpX2YOXD8M5k6rBI9fCC0JGFxtmCYdrjebCx4b
	G7zITVbkm1r1F031zLuObgycK8lUntA8hKhC1KadvOeZKL3WZy7bXdoAUu7MmyWY
	HcD8cxbpQNPo8TRiYGYJGjKk+FhsAHDigDEAwL7ZN0olyWHOZQbBMjewA+Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708520081; x=1708606481; bh=hOcQMRWK4h38PdZTQDMJTZcyEvMz
	c0wq3SnIl1SxG+k=; b=jVoaFW+lf/5invbF9EkaoYvlUu4cWT7BCo3075/NWzE5
	+BmaqsjgU0VJbeOkZokor6g0Xc4eIlRj6BGb4DJtuAJU9j327zbPeluQq2wVM+Yb
	18LCKpC9IIVUTpzZg09tC7QdUpMWmsd5Co560P1vA9UZ8rSMdwU++1ZNvp/JW4kb
	LQthoSGCzmifV0l7eHoTSbpaRlM7o+YsTqUtQOGyvQCpx2KtdbXQd+elBjOZHYnV
	75Mc4T+7ixVnkx4GQ/tYBQqhqUcjda8XoWyU3v4RT8VSPyWqZM5+4I0iSzCgcE3H
	1EYutGdWlLl5flXka4NYnPGi3SvP0d8KTqNO+q1Kdw==
X-ME-Sender: <xms:kfLVZXxmjfcWMBkz5e0qp8g81kefCJLwEtnbwzUHD_Io-nwI1BmBKA>
    <xme:kfLVZfQmjruAZIN9JmxXkt3uKN6FjQzEBKNR6q5f-h9TDj8U0fyImn6qNuNcEMWjl
    pg6ZE3KLzGkPiI3bg>
X-ME-Received: <xmr:kfLVZRUm1gpJ59UUpd41SEn1WNsN-zukrSM38D9MLh5Rcrt4ov1AbMfCJQ41Eu--HzQS7kC6t0pynTMbqSX_bW1XcvM39Xd7UgucI1TsLsb->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:kfLVZRiBpJmuOtjde3P58hctdhFOnZ8u4OASRsXKdQIo39Orm7CsFg>
    <xmx:kfLVZZBLakWKebqbzZFDZkd46MMWnXVvlMSMcFnLrOzXRHuUYND10w>
    <xmx:kfLVZaIozBfFOzrgngvZq_05krnAbBkLb3rm9okfBs2lrTyQ-b9z0Q>
    <xmx:kfLVZU_JiNYiIvkgF58KnAXx9BgfATBPYOw23u8iL4nN2wSSOXJernXTWuA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 07:54:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 11770e7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 12:50:33 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:54:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff Hostetler <git@jeffhostetler.com>
Cc: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 04/12] fsmonitor: refactor refresh callback on directory
 events
Message-ID: <ZdXyi2erhfoW5CMW@tanuki>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <3fb8e0d0a7c0455cc7a5ba28c12736fd4bbbd44e.1707857541.git.gitgitgadget@gmail.com>
 <Zc3aGSbEIFVClRd_@tanuki>
 <3fcb41e4-b17e-48ec-b54c-50452654b28c@jeffhostetler.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rIIvdl2MdeRF/I3q"
Content-Disposition: inline
In-Reply-To: <3fcb41e4-b17e-48ec-b54c-50452654b28c@jeffhostetler.com>


--rIIvdl2MdeRF/I3q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 01:54:44PM -0500, Jeff Hostetler wrote:
>=20
>=20
> On 2/15/24 4:32=E2=80=AFAM, Patrick Steinhardt wrote:
> > On Tue, Feb 13, 2024 at 08:52:13PM +0000, Jeff Hostetler via GitGitGadg=
et wrote:
> > > From: Jeff Hostetler <jeffhostetler@github.com>
> > >=20
> > > Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> > > ---
> > >   fsmonitor.c | 52 ++++++++++++++++++++++++++++++--------------------=
--
> > >   1 file changed, 30 insertions(+), 22 deletions(-)
> > >=20
> > > diff --git a/fsmonitor.c b/fsmonitor.c
> > > index f670c509378..b1ef01bf3cd 100644
> > > --- a/fsmonitor.c
> > > +++ b/fsmonitor.c
> > > @@ -183,6 +183,35 @@ static int query_fsmonitor_hook(struct repositor=
y *r,
> > >   	return result;
> > >   }
> > > +static void fsmonitor_refresh_callback_slash(
> > > +	struct index_state *istate, const char *name, int len, int pos)
> >=20
> > `len` should be `size_t` as it tracks the length of the name. This is
> > a preexisting issue already because `fsmonitor_refresh_callback()`
> > assigns `int len =3D strlen(name)`, which is wrong.
> >=20
> > > +{
> > > +	int i;
> >=20
> > `i` is used to iterate through `istate->cache_nr`, which is an `unsigned
> > int` and not an `int`. I really wish we would compile the Git code base
> > with `-Wconversion`, but that's a rather big undertaking.
> >=20
> > Anyway, none of these issues are new as you merely move the code into a
> > new function.
> >=20
> > Patrick
> >=20
>=20
> Yeah, the int types are bit of a mess, but I'd like to defer that to
> another series.
>=20
> There are several things going on here as you point out.
>=20
> (1) 'int len' for the length of a pathname buffer.  This could be fixed,
> but the odds of Git correctly working with a >2Gb pathname doesn't make
> this urgent.
>=20
> (2) 'int i' is signed, but should be unsigned -- but elsewhere in this
> function we use 'int pos' which an index on the same array and has
> double duty as the suggested insertion point when negative.  So we can
> fix the type of 'i', but that just sets us up to hide errors with 'pos',
> since they'd have different types.  Also, since it is really unlikely
> for Git to work with >2G cache-entries, I think this one can wait too.
>=20
> I don't mean to be confrontational, but I think these changes should
> wait until another series that is focused on just those types of issues.

No worries, this doesn't come across as confrontational at all. As I
said myself, the problems aren't really new to your patch series but are
are preexisting and run deeper than what you can see in the diffs here.
So I'm perfectly fine with deferring this.

Patrick

--rIIvdl2MdeRF/I3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXV8ooACgkQVbJhu7ck
PpSqsQ/7BFwcSZBs5SFbNp8A2Bg3PbVaitur/dwZjWjr8Bu1cq1zAdNBvqWEO9pL
u/I4anPC2MmDXEKigkaowKJt57tbY11B7yCoYiSoJ0KpahvW3Oizx6QIiNoMjYv+
g5B1OWzmwKxg52hXNnZ3XPkIxT9UaxbHbzGbd/GT+Dl4bx7tqCRvH3frL54MapLZ
YxMir2BUts8vsIifTMftrImIQ6OZZCGRAQtTHFypc6G1cX110JiJjNTkM3YpupXo
z4ghs42D5h/L+TlY97QAPfPJQitK6fzPR4kVIpz6S61Hk5L2/iiLV0BWrDJki90K
AUVpRRtyZuNZuIPfLbBqMfwiHxC0aDICC0vUqZ/vRMXXTIoNhwHJJHLpy1Ykqtoj
qt8dGR3Tj87gyJNpaXud1/JNuslyb/xxNoJr3OBC4873XWjdCDLXsDt6hNmZpx13
aaEQP0Tv7Uh5vvurYrUi9IU5OiwXrux5nAgcKUni3rdaTiXVklA2N3MIQaTmCXjC
EyrA7x70O0K6jWHqh+SkcMJYHltjH1yLLmY0pm8z9izKQqJyRtc0hnyb9u7vwuYO
SEEk5z2l8uTHRNVo0mDsRqC07YWnIgyS4DrLd+OA58yZWon7sGwU1iZ+K77qBYop
JLTH6rH8i/GLFTq0/HHpVI03EoQaUNMNJ74SczwGOTObEzFmxL8=
=loqV
-----END PGP SIGNATURE-----

--rIIvdl2MdeRF/I3q--
