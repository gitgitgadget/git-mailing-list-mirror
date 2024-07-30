Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF2197A96
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328320; cv=none; b=RxlkPxX+JV77G3PgfCJI3Zr6dypW3809xPx4RmpKGgFxdnKDjt1XEFD5kR2/ZYdbUHOT3LAiq4bMW0n8TUTdYVU6LYJEYFxKLrTEMAz6zoVzm41TFeFq45m5ruZEsi1ZXz63k21JhuIsJ3tVEk19M1qSQpEvnuzG+s9Mbi3/tp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328320; c=relaxed/simple;
	bh=ubNoJPLnBUCZmi2QGxMmOvDRNWZpjdtqikOBsOj3DgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvdPTWZ7Br3JatcuASRPd3kFJBwLaoZB6/xf87xwzvo7opmVV+F4vfxJmKxar8uB1FfXuf7hncqvTZw8IGIJTeiit4CcWXizES/VvTdna4RKA9wDUlpPpkv3a7zTVOJaO73B3qj/TXfEj5dyxN4cPTFlczhHlyxdi5p27fkLI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VZT8+Bik; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UIm9w4x9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VZT8+Bik";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UIm9w4x9"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 24EB511403DF;
	Tue, 30 Jul 2024 04:31:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 Jul 2024 04:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722328318; x=1722414718; bh=JCPbtWIuI2
	RdqaJ8JUBTvXREbI/C3rsVxaflYhacIgg=; b=VZT8+BikP+V2S9SEzjiZ3L2g7p
	l6kQY9YgX4Ukf43OG3A/UJmOXfV/ynhcGQ9e5FAGu28TwW0P7LxLi8VltZ9NLg8v
	HKM1S4BLwEz3TaTGoa0SfLIqqhFoGRAkHaoojoHaB6ZpaJGEuoFVnXUCpwQhjsk0
	Ofxz5ewIph52uquMvAkoJLviagPj7zS2OdkpqAkPXMuZ0ehuxcPE9xfOTu6uwwO5
	AfLSjcWvEXDn9xJw521WJBpFEYmH3tQHAKUeJOuR7APSzcYm1apU8zrxprrSntWZ
	Y0hQGD2kfQgevWoEku48uelg8WBxn9urXSNzkxnrV5bzEdTossoynSP/kdIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722328318; x=1722414718; bh=JCPbtWIuI2RdqaJ8JUBTvXREbI/C
	3rsVxaflYhacIgg=; b=UIm9w4x97BoSkUFcJFSXBhMUXjCqr+tjvStw7yRCmugu
	qFCF9SnMYjXelbXtvZrOX6+rRxwuUxhnqT4ofP6Wf/FKA4PELp+BSXUOhz7uXGQr
	BnDTdBUvyyyAcXCYdMY99U7j5+ybk1mbYjHldOvhtsibMBPLMWNxOcgIi6rfrCnx
	/42sVVfDdqVStx1Rp7oF+JJkdDLQVtjmRzy2MOdzPhA9zjVEoX7XoyR5w2dAGx/z
	yfOT3nAlKp+pLFLxsWI/bejYvemqXPA+iKTdgpyKX+5soGWgyvyR8DPBA3lJikNH
	15QRQ82yPv1VLwrV8AJ5X48ZNSfI6uz922LQGz4rKA==
X-ME-Sender: <xms:_qSoZpdHHQMxTewOWDAN63aZt3okYz9HMUB4R40uvb27v_zCg_7FaQ>
    <xme:_qSoZnNB89pkHvO2nEMPR3TEQ7G_1Z_KGnl-GYPjJoBPuWwTAMdFyJDiqvoQ2-utp
    k1It-cGpiQ9sRu2cA>
X-ME-Received: <xmr:_qSoZiiIxM3_Yvw38rRZe0bJRgQJC9JfiuWHxIJLeRwv671FUdVSCZzii7SYHYATnUQD5ObFa56DZPJ_3p3pSJyLfA4TrCJzBQlCSm0300W63u0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:_qSoZi9VxahG8U41SAq0Q_FalyqiO19iwqRTNEjyfd4HTxu8Iwc0tQ>
    <xmx:_qSoZltDJaw0j7z254CBpbx2iluaUamszzGC_kPuZXkT3CyXAe710w>
    <xmx:_qSoZhEMLEmMw-ekvhjogVNXHKum4YfdCzirCGnbrxeXiYpKjuhyLA>
    <xmx:_qSoZsP64QoUyHdNeTMu-fMKOMU8cxIriNDTTRrukm1Y3MPetqVaOQ>
    <xmx:_qSoZpjA18DikHRnnkhQbN4qxzYsmnL9Vbq_xggHKl57uM_9etfe7N8b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 04:31:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 685dc396 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 08:30:29 +0000 (UTC)
Date: Tue, 30 Jul 2024 10:31:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 10/10] fsck: add ref content check for files
 backend
Message-ID: <Zqik-iqO4-yNuIn7@tanuki>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeY3Dhj-Fo-bZ2k@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hRPPVjzXEJ8HrU89"
Content-Disposition: inline
In-Reply-To: <ZqeY3Dhj-Fo-bZ2k@ArchLinux>


--hRPPVjzXEJ8HrU89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 09:27:56PM +0800, shejialuo wrote:
> Enhance the git-fsck(1) command by adding a check for reference content
> in the files backend. The new functionality ensures that symrefs, real
> symbolic link and regular refs are validated correctly.
>=20
> In order to check the trailing content of the regular refs, add a new
> parameter `trailing` to `parse_loose_ref_contents`.
>=20
> For symrefs, `parse_loose_ref_contents` will set the "referent".
> However, symbolic link could be either absolute or relative. Use
> "strbuf_add_real_path" to read the symbolic link and convert the
> relative path to absolute path. Then use "skip_prefix" to make it align
> with symref "referent".
>=20
> Thus, the symrefs and symbolic links could share the same interface. Add
> a new function "files_fsck_symref_target" which aims at checking the
> following things:
>=20
> 1. whether the pointee is under the `refs/` directory.
> 2. whether the pointee name is correct.
> 3. whether the pointee path is a wrong type in filesystem.
>=20
> Last, add the following FSCK MESSAGEs:
>=20
> 1. "badRefContent(ERROR)": A ref has a bad content
> 2. "badSymrefPointee(ERROR)": The pointee of a symref is bad.
> 3. "trailingRefContent(WARN)": A ref content has trailing contents.

I think it would have been fine to stop at the preceding commit as it
clearly demonstrates how the whole infrastructure is supposed to work.
Additional checks like those you add here would then be a good candidate
for a separate patch series. This would help you get the first patch
series landed faster as you really only have to focus on setting up the
baseline infrastructure.

Feel free to keep or drop this patch as you prefer though, I don't want
to discourage you aiming higher. Just keep in mind that the more you add
on top the longer it takes to land a patch series :)

> diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> index d8e437a043..8fe24a960e 100644
> --- a/Documentation/fsck-msgids.txt
> +++ b/Documentation/fsck-msgids.txt
> @@ -19,9 +19,15 @@
>  `badParentSha1`::
>  	(ERROR) A commit object has a bad parent sha1.
> =20
> +`badRefContent`::
> +	(ERROR) A ref has a bad content.
> +

s/a bad/bad

> +static int files_fsck_refs_content(struct fsck_options *o,
> +				   const char *gitdir,
> +				   const char *refs_check_dir,
> +				   struct dir_iterator *iter)
> +{
> +	struct strbuf pointee_path =3D STRBUF_INIT,
> +		      ref_content =3D STRBUF_INIT,
> +		      abs_gitdir =3D STRBUF_INIT,
> +		      referent =3D STRBUF_INIT,
> +		      refname =3D STRBUF_INIT;

Nit: I think it's more customary to start each of the lines with `struct
strbuf`. Not a 100% certain on this one, though.

> +	const char *trailing =3D NULL;
> +	struct fsck_refs_info info;
> +	int failure_errno =3D 0;
> +	unsigned int type =3D 0;
> +	struct object_id oid;
> +	int ret =3D 0;
> +
> +	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
> +	info.path =3D refname.buf;
> +
> +	/*
> +	 * If the file is a symlink, we need to only check the connectivity
> +	 * of the destination object.
> +	 */
> +	if (S_ISLNK(iter->st.st_mode)) {
> +		const char *pointee_name =3D NULL;
> +
> +		strbuf_add_real_path(&pointee_path, iter->path.buf);
> +
> +		strbuf_add_absolute_path(&abs_gitdir, gitdir);
> +		strbuf_normalize_path(&abs_gitdir);
> +		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
> +			strbuf_addch(&abs_gitdir, '/');
> +
> +		if (!skip_prefix(pointee_path.buf,
> +				 abs_gitdir.buf, &pointee_name)) {
> +			ret =3D fsck_refs_report(o, NULL, &info,
> +					       FSCK_MSG_BAD_SYMREF_POINTEE,
> +					       "point to target outside gitdir");
> +			goto clean;
> +		}
> +
> +		ret =3D files_fsck_symref_target(o, &info, refname.buf,
> +					       pointee_name, pointee_path.buf);
> +		goto clean;
> +	}
> +
> +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
> +		ret =3D error_errno(_("%s/%s: unable to read the ref"),
> +				  refs_check_dir, iter->relative_path);
> +		goto clean;
> +	}
> +
> +	if (parse_loose_ref_contents(ref_content.buf, &oid,
> +				     &referent, &type,
> +				     &failure_errno, &trailing)) {
> +		ret =3D fsck_refs_report(o, NULL, &info,
> +				       FSCK_MSG_BAD_REF_CONTENT,
> +				       "invalid ref content");
> +		goto clean;
> +	}
> +
> +	/*
> +	 * If the ref is a symref, we need to check the destination name and
> +	 * connectivity.
> +	 */
> +	if (referent.len && (type & REF_ISSYMREF)) {
> +		strbuf_addf(&pointee_path, "%s/%s", gitdir, referent.buf);
> +		strbuf_rtrim(&referent);
> +
> +		ret =3D files_fsck_symref_target(o, &info, refname.buf,
> +					       referent.buf, pointee_path.buf);
> +		goto clean;
> +	} else {
> +		if (trailing && (*trailing !=3D '\0' && *trailing !=3D '\n')) {

In case the ref ends with a newline, should we check that the next
character is `\0`? Otherwise, it may contain multiple lines, which is
not allowed for a normal ref.

Also, shouldn't the ref always end with a newline?

Patrick

--hRPPVjzXEJ8HrU89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaopPkACgkQVbJhu7ck
PpR9gw//S6mSY3c1QR6p4VmBGCHr+5l1SfjvImpEDZnIvKfX85hw2npWMStgqQ87
Kgru/ysTXUgxtwK3hiLTgguwPvTZXZf+Nu+N1xTzmNK/HLBWuNMx0UW4tpz8nAra
xYNVSWpvZbn4wHM9+TEgxyL2/KnDA/pRtmaD4pHpRi6MT/Qe/Gy1BgDVNq/s21AB
TTkzBIsLXsKcmMr0ER6O2qa8+b6pWE2P21XRMlOEDh3nI/mzVGSLH6ZBTuJgP3qk
YkFN3JJcyH5stWuGRGd/4spmBFR/5fchI2idbZ4SlT0BgPGl8S5h/WOhpJky9MyX
OPjGF7DtJOJjlFRnoO+CVOkdgsqmh8VN8ZNrJz8zR3kIBtvTB9tvgPQyXx4aTYu0
irQCRbRbMGcpKNHSkGsjqewTNucxNQTa9sYh0TGU8rmyFD4cyno+xeA4MeCPXoyq
g1D5NQfCxGlFlRp4McjEYvsCCBX1wKi3U9oE3Yt4DfbyPvAbIwQhEpWEVmbaEbzV
KJLxWSRZZwegtpOBmEsX0S+yvKQCkooiKMy2lN07CwByJ6IGV12/k/CLBi4vQlr0
1GdulCEsR9S/pEe/rOv85ORO9zU8NLCSGCT/u9ux2TnfVIBA4Iscc+TOJMTnBb9M
CgBgPlikKVwk4MybSWEDDcQejc5gqegh+bA3bB6zsldYLD8R/lc=
=0N36
-----END PGP SIGNATURE-----

--hRPPVjzXEJ8HrU89--
