Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8382886245
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711351998; cv=none; b=UvVsd4c4kARaHcxYnB0nVqPg4yyZPe2otM/LFFh1c64fpQHKifKxufOoHb8JLAV2Yd5PTcl5eHAlleLduTcbfST3srm9xCCoSujQSvwiutAZXg/fWAxh4lco0gD2fRMglcPLTb2TkKyoj7bSYAMkcryqsQ5rPHD/lLbakla6bAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711351998; c=relaxed/simple;
	bh=hlqI87akyF99fGEBbMn+uUGhD9Y2/Acuuvo9jRJKxIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=romEjYlInzxBfdCOBJ7ifQX4QmgJ0ICfX/6TG1ssek9fIwChMcmhNku6+VuB8YE3RuLjHkK8geSNJDTpSUP0c8CGcobCUIZC0YazfCJYLGr/hZftNK1HekDMdYVddhNZwJhPKYFdsZxqeo2LwlTdFm4pyD1L3rGkYr5YVTGHc14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T771KVHg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RDIEiQiZ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T771KVHg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RDIEiQiZ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9883D11400B2;
	Mon, 25 Mar 2024 03:33:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 03:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711351995; x=1711438395; bh=hlqI87akyF
	99fGEBbMn+uUGhD9Y2/Acuuvo9jRJKxIA=; b=T771KVHg5gJ6kRvrhtM4W130Zt
	996T7UmL6YG6cc87lftvSyiZTjw1lqaSM4Q6pNokXmK8nZvrPnBS6GM4t1ugEFiN
	o2mpdhUVnZEGvrZXkna+HgxMtglTp9OyEnBLkGmlyw0vn0o4SwgbU/kSdxP5mpaT
	EPeqiJfELdPPK4GXCfFparLt3B/ie091LqwnvT/VSHfc1xWiHypCSNHitoHNyvNe
	0vVJ9tyoWXkBkLb5VSEakDVQiUl8WW092trQT4SR4DP/3OS3Af1eou9PpQgp0zuz
	atO/ZMLgHslBF2ozMNNO5LQ9MPub+0Ocv0luoOagUw76XECjNwrnGvHH+MIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711351995; x=1711438395; bh=hlqI87akyF99fGEBbMn+uUGhD9Y2
	/Acuuvo9jRJKxIA=; b=RDIEiQiZqW0PdBK8H5w4yn9/bdWvkkKhKZT1g3aw9BYD
	27dN4f2BzGbRgiR0tH38r6UFuN66hgtxNctqt1YQWC403lBO0PxOar7gcnErctu0
	Uf5AgFlmkJdCfCQlrNM9AE4agdAEw9kRAenAfubJggTx5hfTA5a6Q1PG+H0DZrHI
	bhQX27WmbGNI62XROFkA/fFMpjt/2TzObwwCisONFcD1A37DdkX3Pcr4I7os8IpL
	dS0NY765EFnysy9xsY1MaYuYkVhwmLcO6MeXLYkwoo0/Je9QIF0T2UFjZ+21W1dl
	UjpDpambDJTACWORFksa2048IJUKJRiQvKEefjvGmA==
X-ME-Sender: <xms:uygBZryHKgxLE3K_JdqgUUM_6v7TxdiUvjraoIS9XGLwvYULlott1A>
    <xme:uygBZjTPVNUtQz_5HDEDZs4cgfgJftFfGrhmcz_1_MRv47UZhFAmBKu05JJN848Rj
    hsQv8EwjU72mcDVrQ>
X-ME-Received: <xmr:uygBZlVJlRqefvChm859l1r6I_XuQQgnzOllnLVX2Loo94rJljAsIP0O9KFF6WA3dFtVJdvldNZ6iZeYDB_kOPuVW2JFsIF7vKivjIWGOVHqUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:uygBZlgDsgbNHK5xKcjy7CONtMqYomzlNZBjBlTOk3nbJp7n6Gdssg>
    <xmx:uygBZtBAMGrMnEJRKxirS7xxm-q09wAFGyEr2PR3KTEVG5sunFU_HQ>
    <xmx:uygBZuIUbTGYk-FlB-eNyjC1NXCj3SIbcOivNIPPgWsbsM1TjoLZYg>
    <xmx:uygBZsCBKrvVnKJNGTxnfZHPa4C7F6XPZzk0WvQmJMqit8bzbFeoNg>
    <xmx:uygBZsN0WmdQeKx7Mf9aTngOBdL1E1u7Ar2OlWZ7gwub8a-Ld-i9vg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 03:33:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eb4ebe52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 07:33:04 +0000 (UTC)
Date: Mon, 25 Mar 2024 08:33:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Utsav Parmar <utsavp0213@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC][PATCH] userdiff: add funcname regex and wordregex for
 typescript language
Message-ID: <ZgEouMZvJQdU8VVx@tanuki>
References: <20240319185938.243667-1-utsavp0213@gmail.com>
 <ZfwmMKLBjtYvUPUV@tanuki>
 <CAD6u1kiaFDcyRX7-iZBb9LtoQ1F+M18UkyJuTXsQPE0YQGafmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1PIya25l3WyYEqWV"
Content-Disposition: inline
In-Reply-To: <CAD6u1kiaFDcyRX7-iZBb9LtoQ1F+M18UkyJuTXsQPE0YQGafmw@mail.gmail.com>


--1PIya25l3WyYEqWV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 08:18:57PM +0530, Utsav Parmar wrote:
[snip]
> > We don't usually provide such bulleted-list-style changes for each of t=
he
> > files. In this case, it shoul be fine to say something "Add tests and
> > documentation for the new driver".
>=20
> These are the original commit messages ':|. I apologize, I'm still new wi=
th
> using a command line mailer, so please bare with me. I'm learning how to
> use this well. On a side note, is there a mailer that you'd recommend?

This is of course very much a matter of taste, but I myself any many
other folks use mutt or NeoMutt to access mails from the command line.
Others may use for example Emacs or Alpine. If I were you I'd have a
look at the alternatives that exist and then decide for yourself which
one is most likely to be a good fit for you.

Patrick

--1PIya25l3WyYEqWV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBKLcACgkQVbJhu7ck
PpTDhg//fC4tGctbzORfVTDXUvTtCJi0WI4uMCu57dHRh3eMy8acVcHcIrWb7e5g
7UXS+NEjgEw7Kj41gwtktb7CBqW+FKg2iTsJ494OajRwH5femYS0ZKT48gd7yOHn
VUY2jJOqiY+7XOzhTuOtZNeVeJCl7p/uj1bRFoWKgciR82O9/JkfcnfY74XQvbUh
nHQlRKczWe7D/k5/tuFzWkiZXHIExY949R6hB8hS6qRNRdGFcl0OJ4nMIRK3KFH8
1hHTwybsus9YRw0zZ0dWp1F4G18BDf0VZSjdIzc9rTiuPzX7LSjqP1b/7J0txAus
HtZ0bq4184FiDp+ojsoi8UU+8hDXftXwKjPShh3lCJy7Et8pbLG4gHWZ5yDWEyPk
nmcn2ANdx3aFh+PmB4jUzs8pNyCmStGRBDwdWL0pj8arCrpdcw15mqfiBdUK5m7u
b4c+ATG9hLElSdmDL2MVLOOZon5FfJ9oZBqWh3Nosp5Lv9eMSF4Znec6n0aNLCnX
X4gltCmvmXVWrhLAEU+aH4XWzx1VoXz4XC1WIg3YDghB8H+x0NkDwTTOKA/0adWV
uB5/sjrF4zIqtKlY7cikYA8WRg/P5kDOwVBo40m554nS1U9iXFP2IWmH8TwNPicu
JItFKgEawi1LXgpsSTGGL+DvQ7LrvCqvHnVrm7DAeknfUhMOuP8=
=ufiV
-----END PGP SIGNATURE-----

--1PIya25l3WyYEqWV--
