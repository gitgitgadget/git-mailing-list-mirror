Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E329CE1
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742339; cv=none; b=M/1HAnI0GhYgGz6AA/4mKbQrv/DA7uQ1l81sdJ4CGnGwM4fKqNllLhSVGH9xN0HTsF1isJqyKGl0KC2CTkm40/QbKZONfTbTyy7KZYjqdE/TxQ0MZtAq8nEEpwFWdXKGTnwRZ1WmTaIkRoIVAC7whg9FZHJYLIy0paFSFpbuHtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742339; c=relaxed/simple;
	bh=E+nPAj+kD7snrifL6YWw4bWZKHFPD+hlqV9jjERecfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZAwZ+hcJsbdSxgf9u/aVYTAon25YbQEWutykcugoMIO17ewOKSTL00ShloBghlL4JMRrPkBuoEAfiNXsAuYk165UNR9zTA0P2UNjbaDXUkC8gCU53kALS/G4EnApEphjncMlBt0zmwGERi1vFD/MyDKTbGToFGtagmZx2Rvnm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NBHjAsiZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vf0OsnPU; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NBHjAsiZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vf0OsnPU"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7182311401EA;
	Fri,  7 Jun 2024 02:38:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jun 2024 02:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742337; x=1717828737; bh=+4WF1j6bvZ
	ds/d4owtjGPOmPCCHNBbJGk8zsBKpUiEQ=; b=NBHjAsiZp8syDlKtbaxtzIbOWM
	CwewBEySjYGwzzh7t2LpU8arL2d3xlZ8jeRy/dHglsNcqOw8ovvbR4NR+CroPAIV
	VGY5xStAK/FhZV88Xj9F4JgJFlhuPa7gtOGI8tar6UtGskW1U6bV0QLd3KEfmKB4
	VcOw4PNH7VkMJoS/N9WZCkgIRsAZB+VK/3D/zRmW20gkhl7dF53tFBnbWfEVXIQU
	vyVQCz+Yg08tiAkWwsjdhUVCJ4dpf4jC6OY/jV2zxGSYU0G9Jymbns05k6GEziZt
	YuxbZd4gbZePJLSAL0KwtZBelnIcGpctJlZJVRlc9cYH7vu0zX6AIUzU9Vdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742337; x=1717828737; bh=+4WF1j6bvZds/d4owtjGPOmPCCHN
	BbJGk8zsBKpUiEQ=; b=Vf0OsnPUd2XDsbj8SJ4BGNl7I1Nnf22JQXQnXOT0hpHJ
	i/1sluZzSbrHYZaeowFBgNEMq8ILE7PTGjtZO2ZD2CkpldEkyx6KRTTD9sOEhKie
	LU/1iD6VR54slz/Gy2qHOdt0PA/fjb2JbFyGxrE74J5KFYIou/L/5jaqN2zeU/La
	+AvUM+0tD8twn4MB+M0JyTJCPB+jotOAOzciOAs7aj19qCxy3soyUxZMvFaJA5OB
	cBJVb+C49IPpDFW1lrCz6jdhvl2pHmwJaDzkTdNVvksS7w/cD5f73I+zQtE+RbRl
	eb4bJ+V1Quz+LbNHs6Ttip5XAYOOXA4sO24XNoU3qQ==
X-ME-Sender: <xms:AatiZhphOf6bMrCSoELmgzSkzBcm5expMYag1_0p0aCpU5nSvyMqAQ>
    <xme:AatiZjrQmSMFmmSPaf8oOqxre3-NIuxLePwJl6ujS3cZ0t991r3fpb2jZPjQ_tGVa
    JC25Ea3oihV_GP3-w>
X-ME-Received: <xmr:AatiZuMcapKtYjv3nRgpJ8VRCep8uVeYxUAfJn4ntnJeTYiW0TdU_-VRWN8O8I-nRJB78nbDIsVt592cjY6pAaTqQVd_4L_QjI3D-zfSUlMqB_63>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:AatiZs6qSW1lb9S84vBhPNC-2uWMjhJMJk2PYnwtk0wRYccpFAJGGg>
    <xmx:AatiZg6S_g2eDjF3GeVtNrQyLxo4vuBa1PvF6j1ckIHLQRKOJtp8uw>
    <xmx:AatiZkhga_ZsCai457BnQn3myhC3ruIULyJOx0bmtkGXbgyK5W2j0w>
    <xmx:AatiZi5ANglkg7dsczBMtgq2jzphTckJ9NghyNNzbI5Nau7yndK4_Q>
    <xmx:AatiZr1mcg_V3_wCRL2iFw8SMEWWid33T1YGQpGjHRKoOkpcgHRsWLua>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:38:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3be9bdb9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:38:55 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:38:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 17/27] parse-options: cast long name for OPTION_ALIAS
Message-ID: <f3e02df0ca06d68a05c1faf5e9a643d4fb5093ba.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wD37zv8LI/sHZyn6"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--wD37zv8LI/sHZyn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We assign the long name for OPTION_ALIAS options to a non-constant value
field. We know that the variable will never be written to, but this will
cause warnings once we enable `-Wwrite-strings`.

Cast away the constness to be prepared for this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index bd62e20268..ae15342390 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -355,7 +355,7 @@ struct option {
 	.type =3D OPTION_ALIAS, \
 	.short_name =3D (s), \
 	.long_name =3D (l), \
-	.value =3D (source_long_name), \
+	.value =3D (char *)(source_long_name), \
 }
=20
 #define OPT_SUBCOMMAND_F(l, v, fn, f) { \
--=20
2.45.2.436.gcd77e87115.dirty


--wD37zv8LI/sHZyn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqv0ACgkQVbJhu7ck
PpQ6ThAAhqvNpi0E1SdJo3nLvsHqVIiy/wv7wN6mF6feK8I1FGsEnmDTZaC7hdqy
OYo83UhVXqejRS4WOSuJhKkv/EC2X658EJMLc6599o+0gqeyGkeI3unWRN4QhHMq
i6/4lLl6LrCSTXro24gH/w/umlLEiMAB6PZC5vZlUPhtmCkCBVoxnP2jk/0vm72N
a00tDtkx4N7Q4wvGE83ZnXdJoTbs9rKi5lT2kgqvNanxE2zBMOQCGZF2yH3eKArG
kykoWyciqq0vDAnkuTKBqaTb9urmdGdN/SI3g4M/KHtAb9s1/FJjEob+uRwzXYBP
u/Ubh3oZh/sDyO1x9jgW0Q4rQm7E36zikAK9Vb3pyPpXP5cSu+KmJDl4C1lvCp5t
ZRFOEjLG/bEq5C3Ix47LnurKMAiWwB88rLIhpzR8VR3d1JmZeQpnYqE4+6FzCTBQ
ytU2S25B4kl41a5x24PsHU4nK7UNdw+T29C7Nj4IAtUofs8gyE9f6ajoP162Ghq6
tlx/r3wV/ecE9IfJnYvqnXKMkXf8PFQDQb3i+JZ6hgM+ZkNQHnGpUir4Re/bNnkr
UUI4X+T0dQc4ZL8inyMlQl0Qe7qwvYWSAadKoON/d9vEfV+kcQGryZyBxxzp5V2h
V/P19oO5C/zUGbLw30KT15Z4e6cJszOxNvCLJyHgD4sUpw7OF4E=
=kaGg
-----END PGP SIGNATURE-----

--wD37zv8LI/sHZyn6--
