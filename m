Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4522619
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854968; cv=none; b=l3i3A/qIMGC2hnqa2b+n/9onnAnU0C74Sx+NSZxJUOOgu5rBN6csbhfcDsRsABbPOpV75Y33ac9mPMSv53b0+OuxaRwoRnsTT3QSyG4PA1I6g+/pJYc36f65u5HVvjNGZOVaZZ8yPZvmwLodPmdvm1W2d67WJBtUn1k2D8HODXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854968; c=relaxed/simple;
	bh=9tlOKyVxcE30FPoooN0x481GRWXV7z5HydCKTSo6KF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcIlnHE1luiDxZDoMn3gstfGD4GBLyKVf5zcn2Yit+R17AUovko5+jjvWfnmyzMsnheoncTCjy5cQQL6EsMh4sbYyil5H2xu9jRtG2ql7NwkOr+QVizP8wJyqZii8O2kKrYYjA5kyg0Q5Ndljz5SiT+vIloiKwY6xRFN4rP1kyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fiBl7bx+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E8q1Au59; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fiBl7bx+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E8q1Au59"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id A600118000FA;
	Tue, 23 Apr 2024 02:49:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 23 Apr 2024 02:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713854965; x=1713941365; bh=Rtd/aBRl0q
	3lJzAOC958LDk0An1qJwJwZYQKw9vLqhA=; b=fiBl7bx+B5XXeE2loEmBWCt58z
	DEap9fQ0utRvUmuJnyKSRMkO9ucyLK6O6aBYCcZQWt4mpU3fcyLF/PIKhjG/9V67
	1SKMCDR2Z68rtVMn5Dnx3dfFt4y3sqx9mVKk+tepU5AGzFKVmAP/3cChwxfag4li
	bJHREKzCFgz/PyQkf9Q2axxZ9h5C5rIhdGQjR4uo5QKYTvPhLv4kYwGHDMStEsHa
	kH0nFFgal+T8Yg/2xaKdcLIB20X4ivjVvEL/n1YAprxi4acnte19O0wizzmr0GGF
	svSpMLXzE692UExggc/c/C4wh7G+QCphL+9S66LjBTL9Yg7lXInGJb7qp6ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713854965; x=1713941365; bh=Rtd/aBRl0q3lJzAOC958LDk0An1q
	JwJwZYQKw9vLqhA=; b=E8q1Au59uB90gemBzek+in7GZ2yXwHyUlo6wiPZvWPNO
	ZsuqT9cdGEQTGQ00KjECM6Gva8Z6OdF+QerOLJbcV4uxWOD5j69NTIAJ48cEawvl
	S89TrS38Ut0Atojid/PRlteylFMIL2mzmcNiYGp5Slz1C2AEYq+Qd5HQOON5jtNM
	ippQ3tL0pl/pknY1BQAQJEFFq61JZ3L8aJYraQxGEaz8Pk0LdDK1Vrir8eASKV6Z
	eMk7VGbPu89cP0LoA4w1+PLYAPbDEUyLAQT6296eS+PMOB7nYYGeKV38tmXxLHQ8
	bOKzeqlOf1EVAhb/pwd266gFFe+2cB7AfrLhcKll3A==
X-ME-Sender: <xms:9FknZivcyZxpfi76A3HoHz1z9kALw-1w8EbHRUTm8jaMXlDkzWoKug>
    <xme:9FknZnd8W6cVbrw5xvQuxpEK6rXjUOBMjtGXMO8BWPE_76Qk3SCGv1fqocE2wv5n0
    8uGK65k_O_2SbvSpQ>
X-ME-Received: <xmr:9FknZtxA21pit89MA_JMViYm86ZebwLnuhPG5tM9P6ZXooMdx1M7994pgS_wjeLjcr-PFSkFJxjsRbC0FoR7AxxRicDAtQPQeYVkHYHpo2doHNT4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:9VknZtOxU4Ox2PEP024X2zctky8NKg8cxo7MAxSMfBp5Wf8ba-mbtg>
    <xmx:9VknZi8NLkGPhvob-LUcjla6yr18ttbPoOGVR4cZmcus_1u1DxApig>
    <xmx:9VknZlVzroosf69eN5bMzm-Ywx1j_LwprqkgEU_dU7lC_XOm370tWA>
    <xmx:9VknZrcK30L6YEdtTqjnCn27Yjn-tYpA0qBmCEghGP3uceGgHqV0dg>
    <xmx:9VknZmaZzLA7z2RlYxHBELWi0bQLoA9Ewmqhl5chbrTLDeTJ0iy_PxYC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 02:49:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5b2222fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 06:49:15 +0000 (UTC)
Date: Tue, 23 Apr 2024 08:49:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 6/7] update-ref: add support for symref-update
Message-ID: <ZidZ8N6WsvgxMcrv@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-7-knayak@gitlab.com>
 <ZiI8IFdfBHEqr02C@tanuki>
 <CAOLa=ZTA94HModfa40So7Uk7WAG99G+XabvKfOY93RCL6Xac5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0Ac5PO8n0VtFIh8a"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTA94HModfa40So7Uk7WAG99G+XabvKfOY93RCL6Xac5Q@mail.gmail.com>


--0Ac5PO8n0VtFIh8a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 03:00:11PM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> [snip]
> >> +	/*
> >> +	 * Since the user can also send in an old-oid, we try to parse
> >> +	 * it as such too.
> >> +	 */
> >> +	if (old_ref && read_ref(old_ref, NULL)) {
> >> +		if (!repo_get_oid(the_repository, old_ref, &old_oid)) {
> >> +			old_ref =3D NULL;
> >> +			have_old =3D 1;
> >> +		} else
> >> +			die("symref-update %s: invalid <old-ref> or <old-oid>", refname);
> >> +	}
> >
> > So we first try to parse it as a ref, and then as an object ID? Wouldn't
> > it preferable to try it the other way round and first check whether it
> > is a valid object ID? That would likely be cheaper, even though it may
> > be premature optimization.
> >
> > Patrick
>=20
> I think the issue is `repo_get_oid` would also parse a refname to an
> OID. Whereas we want to first check and keep refnames and only if it
> isn't a refname, we'd want to parse it as an OID.

Okay. The question is whether this matches precedence rules that we have
in other places. Namely, whether a reference name that looks like an
object ID overrides an object with the same name. Testing it:

```
$ rm -rf repo/
$ git init --ref-format=3Dfiles repo
Initialized empty Git repository in /tmp/repo/.git/
$ cd repo/
$ git commit --allow-empty --message first
[main (root-commit) 09293d8] first
$ git commit --allow-empty --message second
[main 1588e76] second

$ git update-ref $(git rev-parse HEAD~) HEAD
$ cat .git/09293d82c434cdc1f7f286cf7b90cf35a6e57c43
1588e76ce7ef1ab25ee6f846a7b5d7032f83a69e

$ git rev-parse 09293d82c434cdc1f7f286cf7b90cf35a6e57c43
warning: refname '09293d82c434cdc1f7f286cf7b90cf35a6e57c43' is ambiguous.
Git normally never creates a ref that ends with 40 hex characters
because it will be ignored when you just specify 40-hex. These refs
may be created by mistake. For example,

  git switch -c $br $(git rev-parse ...)

where "$br" is somehow empty and a 40-hex ref is created. Please
examine these refs and maybe delete them. Turn this message off by
running "git config advice.objectNameWarning false"
09293d82c434cdc1f7f286cf7b90cf35a6e57c43
```

So the object ID has precedence over the reference with the same name.
Unless I'm mistaken, your proposed order would reverse that, wouldn't
it?

> Also, why do you say it is cheaper?

Checking whether a string can be parsed as an object ID should be faster
than having to ask the ref backend whether it knows any reference with
that name. So it should be fast for `repo_get_oid()` to bail out in case
the provided string doesn't look like an object ID.

Patrick

--0Ac5PO8n0VtFIh8a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnWe8ACgkQVbJhu7ck
PpQtOw//USrDgtvFU5CB25eb9WgbRlOOVsWIV/RyEXFohqO/3fVyJqSUTyQy4VWf
ms6Vr4QCZXZrvCA3fO/LkTsmlLyRglPk8lFk0Jm3KLsWBwaRRac9FiAXPSjts9MW
Oo9t50HRRdZcrErTC3tQPFGozdAqfu+6x78SXyta0ZrbMRQTRlq76M6BkmcJimIu
XZ2lvZBcF7K/f6TrlKRH3B6GeQ29nTFDgngU5sazuQCEX96helz+pwQp2OUFHGXP
cieoQRapVxJTQHAfrVLU30rxoyXhMDIOw2tb5WtAnOAwL0UUHtZfpcatKLneXcy4
9RWQrQkcw9HpL8T7BT34/HWUdtV7eooLCZR9pGi9G+YvWF9AIA0Gfmidp8drlNEO
URIrtiwdhnbqBedOj8xMkq1ThHJ4hOAJ/Xla2NZxnnaOCyZw4hFYushvdJryBsR5
k9+d1pl2P4yoM77oizdm3Hv6GFJNa4ePpCc9vSeHwz+RDvWitCaSXJHK46ODQ/89
6YuaCLfnX9O5sVQ+VVSVObVaZXmPJOfIe8jtnHF7GV46/U9lEOAVoVFV1yaQnLfJ
+aib1buW7qR29crWDp9uW/p+3hQMuxQvwpQWbrbJvyUmC4OjjClQW0McF3w8MGIw
MR3jnq119oKe3MNeBg1fIkwk+07xb9m916LjjubKbzdTAeKkUl8=
=K1tE
-----END PGP SIGNATURE-----

--0Ac5PO8n0VtFIh8a--
