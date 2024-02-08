Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2D4C84
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 06:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707372703; cv=none; b=nBb9r65Rgt1Nb7HdozkMlI5Ackzi6nqPZPqkIrOUUTS22u73ziPothh/Uwld0D7X/gtalI7w6c/M4YVCE9hLO2To5miy/niV0kvwWurI3tQka32UMgk4v9co0I1nFW1XdotHu8l0LAGuPKO0bq/YncjUQt855tVOegdSQLUUfb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707372703; c=relaxed/simple;
	bh=FKXyvpcXFAprPLcpiqX93NqClFtD7fEYzdyMCkPHodo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ybv8lw0IPAqQ+rn0NRv0MvtvwaJGRmDhK9bCKNnBNFxYdoBZh6ZuTCqFCkKoZIhM6sZy0eTaZ3ih8hiOZ4oiu14ETItGD/xaUK9fNs8HB6rc7fKB36wevdJ/OWsF9d6xJSqd54kA5QhgC4gjlfq3Y8LGP355zhOTi7XshSOQAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kKDQ15RJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aWtohGuM; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kKDQ15RJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aWtohGuM"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7C55A180007D;
	Thu,  8 Feb 2024 01:11:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 08 Feb 2024 01:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707372699; x=1707459099; bh=qAdHSWCBm2
	sivOgY4i5trXfAXML5ga0Z3NQGHbxWPpw=; b=kKDQ15RJzAsoerwoe6u4aMQdIB
	g8++r8n/ALhS97VffQLmQR96enbydZvRQxtHR/PZPhmBx+AZ65Y3kX712hvVI6im
	JY8FruO/85B9ZZO/MSXs55rnrViVcGWNvCrYtRhpKRF55Ve5pbXjtLdM5ON8ed6a
	Hdz9APtgvdoymDtEIy+bmP8WwAnBk6pnozk3U4hbGiAQUq7Y4iwJqiHhj3Njxq1W
	di/v7Gia3TkLRyZx+ag4pccZSmI5alBHg4jWoOdKsXt3u98ebMN0Tx5ahLvtFuXy
	HPkWw/JITvXQATUzNHno2a/2XOznP5XuEsanek/EI421NyOlpZJyUR6MsQGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707372699; x=1707459099; bh=qAdHSWCBm2sivOgY4i5trXfAXML5
	ga0Z3NQGHbxWPpw=; b=aWtohGuMEnH6BrHaupSAsvA92CbYBc1qduNfLDqIeLjW
	+MeSL8I3LJa+UYUvZDbiBLwGVCfXS1m37Xz+UWsa1uRmMdY0Wf1B/yCP84flaA0/
	edGPf06shpHa59+R1Fc+ewQOK4aWKzBhMPrQIrp9T+FQ5a8rtIA3x9teG+rZjNny
	dPU88HmOR7JiKhw5Ayfz20PJWvCsiLgP2y2oQAhz4Csm4VxENwVi3FVVMuZ3qhWl
	13T9jt7cv+qD2IL83+1YxuXZrxWSvjofG2BVGgofp5PH/2T0bBxtshJ/7NE6Ed0v
	ulTDDImlBTZF/BUJznk6/BQtHZNGU6mry8aelvXfpw==
X-ME-Sender: <xms:mnDEZQzJfmO18CqRcY6Ysa1stencRLj5Ni2qRIFXqbcd1iCbsNIDlQ>
    <xme:mnDEZUR-okw1DFKPW9HkgEkxIN1O68-xJB3DcbWJ8z2ANu1AcnNKTBsO-_W3xtAT_
    C8r3aFjcA2do7q4QQ>
X-ME-Received: <xmr:mnDEZSUzsfTcy3zpdyoR9tcDH_6HmZj5kzSLdHH6XcP-UQW44YDnIyMWzIYggIYoz0dxS7tYe_tcLsQdz8YlDTOpZ5_llc6PwEophxMZKXN0l44t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdefgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:mnDEZehwZeR-fS8jEGsLpvzjPSM2T_n4CMTMhcWpDl8kiFz5aKYPyQ>
    <xmx:mnDEZSBHxeRDppVoZbKCxxQ6bzqZTfJ-dbxt7Ziu6dZJGPcH-jsdfA>
    <xmx:mnDEZfKkTHi1UcthX7eOpA7xVjSaBJee5930Cwtm5dAuPwcXworyMw>
    <xmx:m3DEZYAheGMnr_y8kgjG0BdKxEerJHRgzZZaHBVXfP7wzpB2QYcRRZJkkOQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 01:11:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 97450342 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Feb 2024 06:08:01 +0000 (UTC)
Date: Thu, 8 Feb 2024 07:11:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Linus Arver <linusa@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 00/30] initial support for multiple hash functions
Message-ID: <ZcRwlUdKbM6bEVmr@tanuki>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
 <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
 <xmqqv86z5359.fsf@gitster.g>
 <owlymssbn6qa.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b+BjDHYwMBVoF04B"
Content-Disposition: inline
In-Reply-To: <owlymssbn6qa.fsf@fine.c.googlers.com>


--b+BjDHYwMBVoF04B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 04:24:13PM -0800, Linus Arver wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > "Eric W. Biederman" <ebiederm@gmail.com> writes:
> >
> >> This addresses all of the known test failures from v1 of this set of
> >> changes.  In particular I have reworked commit_tree_extended which
> >> was flagged by smatch, -Werror=3Darray-bounds, and the leak detector.
> >>
> >> One functional bug was fixed in repo_for_each_abbrev where it was
> >> mistakenly displaying too many ambiguous oids.
> >>
> >> I am posting this so that people review and testing of this patchset
> >> won't be distracted by the known and fixed issues.
> >
> > We haven't seen any reviews on this second round, and have had it
> > outside 'next' for too long.  I am tempted to say that we merge it
> > to 'next' and see if anybody screams at this point.
>=20
> FWIW out of all the "Needs review" topics this one seemed like the most
> deserving of another pair of eyes, and I was planning to review some of
> the patches here this week + the weekend. If my review takes too long
> (taking longer than this weekend) I can give another update next week
> saying "too hard for me, please don't wait for me" to unblock you from
> merging to next.

I completely lost track of this patch series. So same for me: I don't
want to hold it up, but would be happy to give it a pair of eyes next
week.

Patrick

--b+BjDHYwMBVoF04B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXEcJQACgkQVbJhu7ck
PpQithAAhSC0O9/FlfDhLZlsiSHUyRF1EuVIGKe+3WgJlbmmvhtKMFuuYScnsGPE
TxlGM4DzDqBps5yYdj8jqa1HaiZErw7JYBPNjcR1iputX2dRR8S3Ye5QJuYIjaPL
wrwfHzJLqGf1rp6VAHgPt2eJQSL/mS4HGF6SHP1sEfWiYR3wXRzlROPJwghmTgcY
fC+Ibvk7Dj3evE8W8ld8JDNlCla/9saLVQiC0PJq6f37fdhmnpwojjT79pN34IRR
T9Ge8PWlxEhV2InODSTNTgJNFzn22p4/R/X4Ki2TKllNTMBdgNKt3/TVR+0TUgfq
tQ+rec2D50RXYUs41xYTzxVYVolKZd9LmI2DWGY87H89VPjCMxtHox2z3vEFoZSj
1ahcgSOtFGbbN4MazULJ8Sjky2Yw2HhdoKO7Tc+cUj1f94sGNAQ7xp+qOUYAtGCm
hXzm8lTMQjJXmGO/4/lQOEaIS3AcXuSNbJf6hsZcMGnbzn6TB2LU10ERjYZ4o0SW
ceqOTsKkRppCJ4YBZKRpWeGwLcg+KqiA71bPRQqUQKorEG5tDQODR4RMSsbHMhAw
JzN0FKFngDak68Ds6grTflzcOEUNzRh7eVYgx9rj2anGurBCqkr9YWsNcDvBhyQT
wdMbrH3cM0q9m0aaMSpQvT7SK9LaqHyE1kjLo4z/Ue9foHh3x4M=
=sgZM
-----END PGP SIGNATURE-----

--b+BjDHYwMBVoF04B--
