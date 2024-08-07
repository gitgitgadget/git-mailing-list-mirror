Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938113C801
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050201; cv=none; b=TPu7EkjeHvDnYiRFMCJ7jjqM2eG7iPZYSCSxF6Uyb50kPfa3kAo0QK8i5w40Eon/SvvHS5WQ9d9rgt1x2Fd7Iipqr8IU83zSxYv+wnENtz9I18EpH8sOJ/YDA54ooFjDNrBXgFtY7dI1yWUoHM5NsZBHoRG4NAatn5yh8aK1EHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050201; c=relaxed/simple;
	bh=I1sfnzcf1z0dlOjUfYR52r9g8XLTdTCPiwCZlWaqdqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDOYRgzYpjLW65ELKhYzOPQ3Dc4Vlvzh8hRMe0wp1A6idDRmoyybq3NA7/slmAC7q/hby//b+l8U1md174mPf2Z/LsB2KgSuG0RD6sZ91rX7gJKXYWz4Iybo8uGxIV5tre082fLNz/ikgcHY8uthORSy50szipUGI1BBMX6+NU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I8A4yhgi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kKCL34t4; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I8A4yhgi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kKCL34t4"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id EE697138CC97;
	Wed,  7 Aug 2024 13:03:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 07 Aug 2024 13:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723050197; x=1723136597; bh=/Cc5Sm9c4T
	hH2hq+kehaP0gXztiusVBLkMB5ezQ7h3I=; b=I8A4yhgiXni+DHLrPxSGiZa+wz
	mM4RLIeifLuGoalonIpBTp546BWVL9+TiKV0q886RQDW1zrvVtNj3TpoNocF/PrS
	B4ZBsWF9NWh7si41nfOaPXpT36D0s4F6K3DrbT6khXL2n64lmMlD0vVaarv2kLKn
	jBA4LgJ0NdT0V0x9q7s5w1Xv1O0vQ3JNpKXThP8X/CtAWwvYozTQcItRrzlCla/v
	me9JtypzU/pnZFE2SXEKy++mKO5Gw2+x8D+ZWXmexY2k2GbmpqU58jc0LJHQG++D
	KM6gHCTuo7Y0InmmNc1RrCEAjxJVKyIoOMA+8kHnTdoEkMZA8EBNF8TbEQEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723050197; x=1723136597; bh=/Cc5Sm9c4ThH2hq+kehaP0gXztiu
	sVBLkMB5ezQ7h3I=; b=kKCL34t43ahNDQefdIi0rop9ntoXbPuRTIly6wMN1VNk
	ajTKMSLH6O8Vdr4KochXACVbrUzFaJQpq2Cl0t61qyfhym0y100ev2fMzg1NjwTK
	zH9OLHy+AK7iMZFUZFq4ANgx88FF4nQS2zPZPZzN2Qff3y+BjZehp3VDX4jryghB
	k58bJRyg2PykPdsnsiQ5U4oY/xa8yBxMDvNwXbybL19TIyzcOPHOIZYUhnrYqWOj
	AhDBYMWiY414p5echQd7SR9fs34t98QhGUY+1FjhUYz2JWbU+N7dsLrQTD+qzTKM
	ITnrY3ZXXjwthxXAQuBrsxRG/YaoyiF9bMElJhJ1hA==
X-ME-Sender: <xms:1aizZmjZTZoJ5OpydJd8cNHzK8mMc3XkTXO8q1jvv8A-k9z7DNQErA>
    <xme:1aizZnAdT4jbY7joss5XWO-cTP6sd_UFlgJihr8L_0uscaOXh-bFmaq9kdfHHUyPX
    r4QIkpeEhpr15ojZQ>
X-ME-Received: <xmr:1aizZuGAwlhXs6H9K06LHUCX1iX0qjCR1R6xEkY9VrE72oGr_wQ7tPvYdFihp0bgCXetvaB6T-OP0k-JWgo-9-CBt9hgJ8vaAWcPtqTALmyWAFRG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedvgfevueffffeghfeuvdegteekgeffte
    fgtefghedutedvvddvueeifeellefffeenucffohhmrghinhepghhithhhuhgsrdgtohhm
    pdhgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:1aizZvRx6rxZJqIxqgNCK7UZbNAi7sMyk-j2SwflqUr2zQrlGKWTZQ>
    <xmx:1aizZjyBZ_MLrvC4X7wJOEDoNqBCic0H_97zcyQEFtLAIvc5IiZ5NA>
    <xmx:1aizZt6KZE3QLDazFRxbWqM4WFPgZHJMw-8nb-BWYXDu3H5waQkoCg>
    <xmx:1aizZgwm2EODCpEjgMMJ7iGmJBjt_lFORKuu4HwMC4gXQICTttfVHQ>
    <xmx:1aizZu_5EliOo2ZSdTn4Z3ScgccwXwdzMELBqwJBxKjZB0i7p1-CrWz7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 13:03:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 99465a92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 17:03:09 +0000 (UTC)
Date: Wed, 7 Aug 2024 19:03:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/22] Memory leak fixes (pt.4)
Message-ID: <ZrOo0DuiPeSp9E0b@ncase>
References: <cover.1722933642.git.ps@pks.im>
 <xmqqy158nu9w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6pLTVtOI11PsCqhE"
Content-Disposition: inline
In-Reply-To: <xmqqy158nu9w.fsf@gitster.g>


--6pLTVtOI11PsCqhE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 09:59:39AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The series is built on top of 406f326d27 (The second batch, 2024-08-01)
> > with ps/leakfixes-part-3 at f30bfafcd4 (commit-reach: fix trivial memory
> > leak when computing reachability, 2024-08-01) merged into it.
>=20
> A quick question.  Is it on your radar that transport_get() leaks
> the helper name when "foo::bar" is given as a remote?
>=20
>   https://github.com/git/git/actions/runs/10274435719/job/28431161208#ste=
p:5:893
>=20
> If not, I'll handle it separately, whose fix should look something
> like the attached.
>=20
> Thanks.

Yeah, it's in part 5 [1], 97613b9cb9 (transport-helper: fix leaking
helper name, 2024-05-27). Feel free to handle it separately though, I'll
wait for part 4 to land first anyway, which likely takes a couple of
days.

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/tree/pks-leak-fixes-pt5

--6pLTVtOI11PsCqhE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazqMsACgkQVbJhu7ck
PpRxtg/+OL93rFeQJ9oP0uA5yYs3Q7vU2qNK55HBqU6k8Wug9t6mB2XzcYG6kopV
BvZG6L6vIOn/ykYN0S5zggiBY3+DWAUHvL4RQG8xU5voTT+SHLupQ/pP9lMCQOSt
qL4TE8OfclorSKun3GaYK0BeU6XQ4QNjS7h5SkUqYz74e8JbWDQnblVGHINsAGYf
InizY/TIwY3v3MbZdTgUg0JUtSG8A54nO104bQ8lyJ/MtffKCy7UPEwlRzpxQxdc
gUyjx4wH47raa3Ll7ErmBdQBTjYBrJP87BZR93L6njieigwPAvSZASxHSESd1HGz
EAW9Vz/9ecG5cQbijew4IpHdtWiYcKaKIqmfePpofbiTIr8Fra61ysq0XfU7Jwbr
+qofCExTRC3iVwhVLIFiOuPFdls+bNZwiMMw/J/KmyuYER8dXvzMFe8yfR0yEhhE
E7lwGb4PxL2uANOVxB/vofzvH5F3ddSqVUp/ZJAhwasQjwMq4apAAPQuLDFIsI8W
tahpnL4tkJM5k1xNs7eePHjRg6g/bef0z2jAmNhMvH44LjtlLYn/FhpXj5NODHF9
AJuivUB9Fh8QX2TfFtCjmigvTmaoKkcfzfZtM/gNOVV0DhZ2RYwd0Pu0ZGBtPCQx
aysa55lnAYiUiszVHy42NgrySBD5bAcuUpsZeHHhrm8F9LSxX/Y=
=ekcE
-----END PGP SIGNATURE-----

--6pLTVtOI11PsCqhE--
