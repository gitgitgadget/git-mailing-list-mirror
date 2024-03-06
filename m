Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF284C6E
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726409; cv=none; b=pP/S4jwT1hKtf6RDMqRBjGjAivDvJHEUCD6uh4334wkrlfRuZjkk3QGV1NoRF9nwP65HSqGbBbaEYzPD86Wepj34+lBOtUcyNUMfXAFwf85zHGKB3Z72WE/kQDlm4U2Rnx9eDxdvv76LQll4aDD9KElT0ZWAA6GpjAyJSWO5zb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726409; c=relaxed/simple;
	bh=mXRfUBgcm5+YmAcbtpwUNQBUZ+IWV/eatnjfTHaiuRk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBn9XAKO0JQfB8FRlNfCsf3aUl9fp0n9OWZtrvlE3PkIbsxVIawzkMYdxioJlDmKM6UQ8pcAwy99fNgoSMw/fKQ9wQLCEwPIZSNfvvXKo9rHGhKOcK6wZyRYvTA/6EHrFnELk73p7cRY9DGljRVdWc+KFWU3PqjRFM7dCAfsui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ilHhELYg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vn7oq2w4; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ilHhELYg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vn7oq2w4"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 312B33200564
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 07:00:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 06 Mar 2024 07:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709726406; x=1709812806; bh=Kjmo3m3fZX
	12SIasK+GgveH6VbX0RseMigPybI2dqkE=; b=ilHhELYg6qeQ7xEqzZs0zK8bvM
	paV6foOpc9xO12ToiiPevYfM5Yl0z5def3tkyEOSu+aY5DWBhPlrxGleHPnY1Rpw
	8WQK9Ixwfa2q/CknZyM8D7xh/JWv6fYwf3uwpqgmcSCq3qGcg0o1fdKk80Mlbizm
	BjP8SPmJEsOEpddcOWepxErwahdLT+4CLWOCnU4rAwIPkM7t8iYFb9l0OLl4FGt8
	m0dzcse4Oqm67blzS4L4oDiFgn0qvSfYXB+eJpvcoZDiJ32t5IBxquR41TUMhZ7w
	oVznUzo91m8WY5QMdUQn0dR7OY2mpIPsTnIz2TC/c3SzAGr9vzmK0SwYh/rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709726406; x=1709812806; bh=Kjmo3m3fZX12SIasK+GgveH6VbX0
	RseMigPybI2dqkE=; b=Vn7oq2w46Vftvt2ex8KcaMbaxJLgM5+dkQGF68F6fwm0
	q2JRFuTQRrtVUNb7glsRK7G8NvOyDByqQR90lwaxgLAQhdzPKTqMECJF7VcCHBvi
	lJxMB1X7cBgMeszbmb9D2SdrNwv8nwTBdwar7uSIOlRB2in0vAAZbjmNQxniy06Z
	MtzaCViNe8PE6VtIkv/DIwsYncN6wltBS3Wu34oquLros1yGOaQOjaRL7MJQTNxV
	bYy87Fm1CukywDLzhwAm6c0RjNYFWaPhyZrc6Pa5bLb+n9LdhglVSp+l8ol5OuaY
	Taap5HgAE9BrtbGGwhrum3f1TeJCYnxNDMYtiW5wDQ==
X-ME-Sender: <xms:xlroZXE4yeXAjFenQOeFtdMyGGAsAEVAbh59WMcc6eUToMee_i7GKg>
    <xme:xlroZUWqhO0hkL-DV93NhD53Q-iphVpCj6hlMJ30jA-VZkxFFEW2cMiVQ3LK-eSPJ
    QXmaYvRCh1uVFdRZg>
X-ME-Received: <xmr:xlroZZLVchevafeD93G7CA_4pNXc2zjaq7k3QoHBlHlICFizTQcf1PQTcBsz8uRMZmxHipPv6yOKlymhroAG3q4S8R8bQmViudo7v9KC-9tUqMVHyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:xlroZVGHQetbCQz93Q7wF-DK4Oqfnpn7gEVpqpWa_sDOlFiIlvCC7A>
    <xmx:xlroZdUnaUO-fQa0Wj9B6CsdOOJqG6bYTaIlorcTXJoLM21ULvI_Fw>
    <xmx:xlroZQPw0RzsPFqlmwsEIO_n-ty-oNboQIAhTW1qoc_2aNNGE7YNEA>
    <xmx:xlroZedS2gy3K2WQA-y48pBNUitbNM_JcHzHbq3c19EDaPbcAAiYtw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Mar 2024 07:00:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f23971f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Mar 2024 11:55:31 +0000 (UTC)
Date: Wed, 6 Mar 2024 12:59:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 2/4] reftable/stack: register new tables as tempfiles
Message-ID: <Zehav4V_8GGZG94Q@tanuki>
References: <cover.1709549619.git.ps@pks.im>
 <02bf41d419efd00e510a89a405e1b046b166ba20.1709549619.git.ps@pks.im>
 <6cw6d3ubo2kbogzdbniyoznij2zfoh5t3htwb4oaghaltcgeqg@kkrw4g6atr2k>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0sx6SEYBufDMElwS"
Content-Disposition: inline
In-Reply-To: <6cw6d3ubo2kbogzdbniyoznij2zfoh5t3htwb4oaghaltcgeqg@kkrw4g6atr2k>


--0sx6SEYBufDMElwS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 04:30:18PM -0600, Justin Tobler wrote:
> On 24/03/04 12:10PM, Patrick Steinhardt wrote:
> > We do not register new tables which we're about to add to the stack with
> > the tempfile API. Those tables will thus not be deleted in case Git gets
> > killed.
> >=20
> > Refactor the code to register tables as tempfiles.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/stack.c | 29 ++++++++++++-----------------
> >  1 file changed, 12 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index b64e55648a..81544fbfa0 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -737,8 +737,9 @@ int reftable_addition_add(struct reftable_addition =
*add,
> >  	struct strbuf tab_file_name =3D STRBUF_INIT;
> >  	struct strbuf next_name =3D STRBUF_INIT;
> >  	struct reftable_writer *wr =3D NULL;
> > +	struct tempfile *tab_file =3D NULL;
> >  	int err =3D 0;
> > -	int tab_fd =3D 0;
> > +	int tab_fd;
> > =20
> >  	strbuf_reset(&next_name);
> >  	format_name(&next_name, add->next_update_index, add->next_update_inde=
x);
> > @@ -746,17 +747,20 @@ int reftable_addition_add(struct reftable_additio=
n *add,
> >  	stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
> >  	strbuf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
> > =20
> > -	tab_fd =3D mkstemp(temp_tab_file_name.buf);
> > -	if (tab_fd < 0) {
> > +	tab_file =3D mks_tempfile(temp_tab_file_name.buf);
> > +	if (!tab_file) {
> >  		err =3D REFTABLE_IO_ERROR;
> >  		goto done;
> >  	}
> >  	if (add->stack->config.default_permissions) {
> > -		if (chmod(temp_tab_file_name.buf, add->stack->config.default_permiss=
ions)) {
> > +		if (chmod(get_tempfile_path(tab_file),
> > +			  add->stack->config.default_permissions)) {
> >  			err =3D REFTABLE_IO_ERROR;
> >  			goto done;
> >  		}
> >  	}
>=20
> Since the tempfile is now being created through the tempfile API, I
> think the file mode can be set directly through `mks_tempfile_m()`
> instead of creating the tempfile and then using chmod. Just something I
> thought to mention.

Unfortunately not. The problem is that `mks_tempfile_m()` will munge
passed-in permissions via "core.sharedRepository", but we already pre
calculated the target mode in `config.default_permissions`. Thus, the
result would have wrong permissions if we used `mks_tempfile_m()`.

Patrick

--0sx6SEYBufDMElwS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoWr4ACgkQVbJhu7ck
PpRLwg/+IuxUTDso5W9wmzqymcTmbd2AfBXftSyNovSD004ynZRHuA9rC5mA4OiD
K1WsX+q96ecifPSsonWRwUsEskylw3pJXaYw5jObKuEnMtMYDcDcNessMIsbW+BD
928fRKEvFwRrm5Oj+P7s1E+GdDg9saW6X+JSiFWtIajr49naGEQNraQ6X8+CCdeC
gSxO1NiKXPXqxKy56AXelf9shOw7MkNDukAiRa3jYJWfpRt27vojC8GLctQ9pc7h
mHn6pNZRf7E8ZgjgBhQGxr6WRESYdEBGvGQqN7m1z+7WPCV4foAZLp8zSlHeDGCf
uhKf/FQc7bnJQDKYMPWRZTRt+4H0LVjML580SeqaypDYOUZDrB/1Zcdpt8sfHncA
VExz9p3EfYeofaUYZXCALngw2GR6gAroB5AD5tIm9djVTQB32A2OxQ0PHQYBYRvp
eh9+pk2f+4gmIJ/6QNuB6wo+DZLf8K6S6sSupRQrjiPFFV69Gr+isauPGYbKJI0a
mD0qc2HdZ/vpiB1gHssooqLqPB4vaTPjMG0r7Xr4UedGlPWhz5qrqUu3LrV9PF00
/LXiyVwLzqQf5fxmXp0UgViNzq8h49tDgQrGQeWluuSl/TWX7hBtlz1aGAejGRLI
zumjsvGTNf8wLfn4YHrsE1RhDOuWeCkB2B4xwyyEhCNlheYleqo=
=gaB4
-----END PGP SIGNATURE-----

--0sx6SEYBufDMElwS--
