Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60D79E0
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712555318; cv=none; b=POrfIaS4yhG4eF4cfpGBm3zvgZtUMa2jJDiIuegltSR5AxQQoemjuDb8msEnuiPEYtRLxLbsABsVt7URd5etbAvtNt6/owqzMXqHqp8YX5QVUs2DD7H+RQolvg9JxA1/4XVj3QpjVLNaQWBcFoR3XJT04cQ1Xr9OhB5mu7+q0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712555318; c=relaxed/simple;
	bh=MaEpV0S2lsx/xER55rXiShm4NIy8T0Ad7E94Hftc0fE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDFazUcx4sVH1xgAJMlV8loAtohhkkd6M/iatqhuq+6GU+mBoaGr6FZIADhqBggJokarZBzQQc9fdey4NgBICY7/09ITRxh7tLWZ4ta+IXl+atk7XynUdVk4Q/MYZck4A3Z4f1mTco/X1nNplSsad0fcwcjP6Ei0yrjdDHEs8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JfvIp5Qr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oazQMOUL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JfvIp5Qr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oazQMOUL"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8BF071380078;
	Mon,  8 Apr 2024 01:48:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 08 Apr 2024 01:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712555315; x=1712641715; bh=HsBhuqCbsd
	7i/W+CjiAyN0YBWQkeatOw9UuL9TtpqvM=; b=JfvIp5QrWamv+mNKfaX3xJp6Ry
	F5OR08DDjUwAlRO7KALWPDue+647llVKF5YXG6AiDGRWCzTXxHjvWzPsSHpMs+Jl
	NemheNynX3Ag0Kx4j5AdXpu36f4ICMEF35mFEOikMxglE/OlisA4R+zQe2sXc9h7
	ca84YbrOSz3pgdDdUJ/pWR/71YzgJE7GSXFor/qCnKqHfa1400kTLRvum0WxMg3R
	2stMqdpx5ek26Sd68CrI0lHXEWkPOyKow6zmbplYbx4hQiIKsdMlZksa+VVowRw0
	6OBaLMPq/7xu9/uYkDE5ZJwN0k8D4JrAD45gF7HXX//1GPdRSgVNzHjz6DvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712555315; x=1712641715; bh=HsBhuqCbsd7i/W+CjiAyN0YBWQke
	atOw9UuL9TtpqvM=; b=oazQMOULQXN/ymYAjVC6i3xSZUbAQ/FF3bdOYkJUJEjg
	kfbquRMuMNju7HafuvFSPdZFqEOq47ufLI/UcO/uQsMxXmP1JNO2S9v4BdoaEpMH
	Jibv+PONWscBzAR2ePBOmN9H1rav4ryZMAaN/XnCjZPa0gZxjKIhUBo95zgyqvAG
	kGUyCagdE2UGaTO8zIV94y0TJgOmn2fR3g2B94CDMdUg9UIHv9n14Srkshy8eGeY
	opjQieN4HXR/2zOtyl6RQaMCcnDT665jnS5JVaXz6X0JziO2W8uAP5zUmWeRB3FB
	fzlnNqKonznbCrkIUbycSpJMlLKzcPnxW15TUr5Q+w==
X-ME-Sender: <xms:M4UTZgxqGvtt3hwYMwYzUBECT2q7PGqArx2CquMNO_6taNGotHe7wA>
    <xme:M4UTZkQLjBgrDjvENNQHWn-7DSDgsdy4bjyUO2gaiKUaemNvp8AT2PSde0Fv-lPSX
    d3n8RzPqQMV3RLx4A>
X-ME-Received: <xmr:M4UTZiU80JfQkypCx_VAZYwdqB-_oYzEkVx6e2rhyGJnj_7CzP33y5vimZK1xi8fqR5xZbrsbzRuMcGUuh0iIls9DFVHsp2ub4SX-27BCslpRrKpMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:M4UTZuhFsoYTD7QDmGsz72bLLDpTlSRlp0d7pyihw_CmCrp62VO7_A>
    <xmx:M4UTZiD42WJFvNKXQ80G5NG_R97kbejkwNjU5zGlUxlWV5xajlx4jg>
    <xmx:M4UTZvIBIuo04ejDEu7CATDU-UtdwnTMUzXK5jwk0feOyruu3Hwm3Q>
    <xmx:M4UTZpDR71fEAKkxySbRlQTvgMlvTnxUnI5Z3GPr-XFsEnYv3mLVVw>
    <xmx:M4UTZp5SQ6UZS2J-DdqD1fycMnnvBvWx6OJYa_HX5QFC8ZHuuJLxBrkw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 01:48:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4dbe57c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 05:48:27 +0000 (UTC)
Date: Mon, 8 Apr 2024 07:48:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	Han-Wen Nienhuys <hanwenn@gmail.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: Re: [PATCH 08/12] ci: make Perforce binaries executable for all users
Message-ID: <ZhOFLsfVg-dpQJ4w@tanuki>
References: <cover.1712235356.git.ps@pks.im>
 <22f86f8ccb9f3fb7f98ff57ddd09724fc9e44628.1712235356.git.ps@pks.im>
 <ZhBX7REqotKKHpWg@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nlzoHVrJ/tHcRZl2"
Content-Disposition: inline
In-Reply-To: <ZhBX7REqotKKHpWg@google.com>


--nlzoHVrJ/tHcRZl2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 01:01:52PM -0700, Josh Steadmon wrote:
> On 2024.04.04 15:25, Patrick Steinhardt wrote:
> > The Perforce binaries are only made executable for the current user. On
> > GitLab CI though we execute tests as a different user than "root", and
> > thus these binaries may not be executable by that test user.
> >=20
> > Fix the setup so that we set the executable bits for all users.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  ci/install-dependencies.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index f4eb125fd2..068c478025 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -47,7 +47,7 @@ ubuntu-*)
> >  	mkdir --parents "$CUSTOM_PATH"
> >  	wget --quiet --directory-prefix=3D"$CUSTOM_PATH" \
> >  		"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
> > -	chmod u+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
> > +	chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
> > =20
> >  	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.t=
ar.gz"
> >  	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$CUS=
TOM_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
> > --=20
> > 2.44.GIT
> >=20
>=20
> Do we break CI in patch 6 and 7 until we get this fix? Perhaps we should
> just squash this into patch 6?

No, this was broken before already as we had the same "chmod u+x" even
without this patch series. This doesn't lead to a broken CI system
though as Perforce is an optional dependency. Instead it causes us to
skip all Perforce tests because we won't be able to look up these
binaries via PATH.

I'll try to clarify the commit message.

Patrick

--nlzoHVrJ/tHcRZl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYThS0ACgkQVbJhu7ck
PpTapA/+KKxVEA+YhdgbLN//IWQhHp3VejmeMsQq0rstZ/2MWx7HlujKeHpsN8Sy
n7aDef4b7jvJYF6mcQ04WJXJdcOvKX5jTiUs2leK7EgoAfix6N75rzVcg7guxGwc
HzkgOb/YuZ+kRNP8idDgNQakhZCghvP1y/GiKfIcp2A+zfP3PsXwQiXV7r5X1ekm
/dgTOb0EzIt3lC7ZU0RkmKaUFnjGG/XJpnNKRwZaJdnjeFJFWKeY7i62VoJnHTKK
7RAI/TtXk3C58NeEI0lncf5yK41R/s00jou5yqcM+VjW2veB3yfLYX7ddmoSRGnM
yrPp5LppwHoZqb05680XwBrw6JFaNKTyJOq2YQTHMF8d8wdladlT8H++lezq9Rb2
8MuCnNd8Ur9L1ZF++LfNzk8X9KLcjfqKMJJ4R4EMyVJz49qKz95CK2uo84mzxe9I
D++U+Utskq3XCu2SFAdk1ymv/tB73/3cIs89BuhGpiCYwWKtNJXOkRs9A5nSCh64
MDZA1Fe6yr6egzs94tk+D8WTEiUgrZbWHFZfnnqnSIn0oiu9XkIvydw0o6/BtIGW
2d/Eq2AwmdEX6ry8JGIE/LhobjOGO4PQP6tQYg1zinMBdhGKlBL48c384hTXGte6
Ft5/wUL5DACU4vJK1ffs7EmQjdiDdaZjqDKSYnTX9hNSHruW50g=
=S3AX
-----END PGP SIGNATURE-----

--nlzoHVrJ/tHcRZl2--
