Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A8423CB
	for <git@vger.kernel.org>; Wed, 22 May 2024 04:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716353515; cv=none; b=dEsS5npgfCS8+yu/0i04DrvO5gUCcBb2V0t5/IMrz/075vNCkBTHl5y8KoJiCqS1nVjXCjljN0PJURbW9hpJVXyZyKZP4Q1ZiCG9/GOYx5xiLb2tw9yWbRx7nwBS4eGueLwV5p78iRGRAcPMSFf1d9SHSHTHT9k75ioa9BnC/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716353515; c=relaxed/simple;
	bh=jEt6KQBnPfzGI+/IXEmNKOKpC6c+SemXE89M1VSR7jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEUycvhfRKa3J+gDCOf6jIJMS9JyPz0DZozN9589iqRL/OE04dDYhpTLXQoitsbvyf/In8PRy/m4ivybxVkILxpR7GRBL6/YN9NEqn5mIS3T5Sjpigc2MOpbHLxiHZSoemlbWSZUHjsPzMm0H6Q/wWUGGwVs3jPpRQXrX10Af8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YGRWnodb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dRCadxsP; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YGRWnodb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dRCadxsP"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9C9B51800096;
	Wed, 22 May 2024 00:51:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 22 May 2024 00:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716353511; x=1716439911; bh=jEt6KQBnPf
	zGI+/IXEmNKOKpC6c+SemXE89M1VSR7jM=; b=YGRWnodbkMo9bN/1tzDIavcXgM
	6L47C9/h9WRyUQ7kt5fWiSNxmyTVu9dIXTXCSo9YGaKYlI78X/u/WC8WRBk8nT3a
	ELjdiIX7q24c7tCaADM2MsP0o5Qd4tNbxmeEOP0Gtmqb2D7RKE2te8BrUztQVlnQ
	EioRv2y6+F4HcpyF6EDPMWDqrUzUa3R5yCYCdGMJ/uhht2V8rEvymb3e9pyU0lJK
	b7kXTvzWm7wnQWbQ07+Dp4P4ZRbmn3FLIo5gS2JpEHkibxgr5ygIqZ5t9RN5PgyP
	pl8sh76v0PFCaWhNgfuwp6OGKSywjeYV/Wz2XeyX0gpbGLAMSI7haujzSyKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716353511; x=1716439911; bh=jEt6KQBnPfzGI+/IXEmNKOKpC6c+
	SemXE89M1VSR7jM=; b=dRCadxsP9qBotTD2t8wVjmbihISFd6qgVBnOK1wWzVm3
	IBuVKCniURGsRmmhablaTskVG1JqJea++SInQF/MET7Ml5g+SAguZVKkCIAexwmj
	8N822b2/WCB0RfWW/giZT4QMsdjrVWM5NiyuwG/bM9mK6CUm8PK0QUfEY4hh1Zzi
	kzWi6Xx54l5uQYMjvhS5LltjZdOBStoOZJgyCvqR1+bpdtRbwwnNCFCn9Hv98ESL
	gKisq9J4VUSAYk6vNxfJ5oD4TbluDxl9yRppUvDelE/DcUnCXbsHuP+cM5D5gufA
	N/wIll/v4vVvrkVwVPR0oYBuSeUPznt4+z3pbmIv8Q==
X-ME-Sender: <xms:5nlNZkEvVtKVnxblLWuGd6LJfnC8IjJTHBAcsl6smBKYsZgZRk9ntg>
    <xme:5nlNZtWgCDOInSRU66Bq3f2RvRGASguFNWkL_q1J9eWw0caxXhmAuhhTyUSFTWiEm
    KvHcmN11qWU44peXQ>
X-ME-Received: <xmr:5nlNZuIw6Gyp49wivZlqjZPuromfpLQcgaI3DALhYcxzB0-JJCJwQ9Bv-KzjC8tC9yQMDqIIm6qppygEAfKc0NtEREAc8d2-SURVzV6q97pVKjyy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:5nlNZmFIA0xDMlpGRCioFlB7Czze_mVdp9_XtHCcw_6KcTMP_rGpAw>
    <xmx:5nlNZqW7HGTDPQ0P7jFDX-Odr0lXwRPFr_D8KHmg_KOVNevEIfYx9g>
    <xmx:5nlNZpO_1AOeVhK-92DVIElNO5JBGMqY1NVoqwwppxglL8CXC4OCwQ>
    <xmx:5nlNZh011U2qDNeZ3o_QbynzJCfrUOQpvjy5vfbH6itplpXtBw95BA>
    <xmx:53lNZni44xYzIre7oHFKM9qejhWmpwTgORKsDu4XYkCrXPar8VW8t-U6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 00:51:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7751892e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 May 2024 04:51:44 +0000 (UTC)
Date: Wed, 22 May 2024 06:51:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Fix use of uninitialized hash algorithms
Message-ID: <Zk154eQUf6LG8Qd-@tanuki>
References: <cover.1715582857.git.ps@pks.im>
 <20240520231434.1816979-1-gitster@pobox.com>
 <ZkxUGzPn363PNWMF@tanuki>
 <xmqqpltf9gz3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E5CNAFv2IWyz14QC"
Content-Disposition: inline
In-Reply-To: <xmqqpltf9gz3.fsf@gitster.g>


--E5CNAFv2IWyz14QC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 11:07:12AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > I have two smallish comments, but neither of them really have to be
> > addressed. Overall I very much agree with this iteration and think that
> > it's the right way to go.
>=20
> I've locally done the following locally but it probably does not
> need to be resent to the list before merging down to 'next'.

Thanks, the diff looks good to me.

Patrick

--E5CNAFv2IWyz14QC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZNedwACgkQVbJhu7ck
PpRIkw/9FnEpA8Rv4H8nI1oNOY20gC7c/JIAmbkmBmlE9Rrx8JSHynB2NZ5j/+Da
fbK4XYi/D4BklLYxu3jcFeviokBGJSCJcglrEBeGXKku6QsmBXP22KgquZglzy2+
KGa16Slxq4vz3FoTsJP/L9bhT3+laenkvhP9S6no+97HNlrPoGitEJ84PfU751zE
dJS5dbUO+9R+b9Arp3J7hhGlq/B/d674N8OZ+aPUlPrmsg1ROP1AjsiYDusTBaub
c1tbws0+WQ5jPwvlxZDw11UKX/9zVaIG2UdP+orLvlve/NXgjbEt4IVHP3LKHRl6
CWxG6iPCBJ0xtC4nctLuqr3gxLbennbtrO5qPuUmCOvKx315aQXAE81P2ztKFl4j
F5/6jEXCBwlXSJjsQ2LktzU5CIkaUFBPyB5VVJLREXc01LIq0384T8+/jZ3VkSok
9x2mWex4qRrGCrF/p5B99kfAoixOHyC1bBkS5tLm6yHrmchKmv6Ay2HW0huUPeXT
1zUK8YjnV0s64vrsMhVyn75dv9ueuZQR7VwIsS7US3DkDdfHDAu0r2VtyvjTYR6e
mRrENEjHQkVMAzH2d57XRi1NzfQU3oxkVBUZyQTAZqUuTsMtmmkgct7En2T9uNk/
nMy3vFwY+0leCcJth+Uhigik8Af13hVCSQaOaj28uvLFzwPVEpA=
=sRhT
-----END PGP SIGNATURE-----

--E5CNAFv2IWyz14QC--
