Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E11C0DEA
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711786726; cv=none; b=itSzCxm3PA1hV5+lYyK+Rq8EZxNseAP9foE1LlmdsxZohbfHVpmelJ3mRnQ+sjZSIc6f388eRZbDMvcgSiPWUf435HZqUcT2JGCW/PioFtsXw4CupPPTs+kIwf090slbrnmk8UFdnQv9MokwpTo4GpwHiAeFng/x6ve0HlHHVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711786726; c=relaxed/simple;
	bh=FGqylyrImOEqHasYLqDUUqQXxmlux7mB4nTj0lr4Ecc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSFt/ai1wk6KTI/5VTaHYoYEqBl4FUFJnsxynO7dTNLy6he3NHY9N4RxRPVkgp0dSLDESESxhhIyOv0xMW6EzNRtBpcvF1bB/sqpjSh5tgGhjgwLMotmLsWq3Juf+cX+4nXjqSGOK0RPVlQuVOjvjv0KPI6Lr1+lyTHDCEDRMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oxhWbrwb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gQvi+El5; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oxhWbrwb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gQvi+El5"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8827613800F8;
	Sat, 30 Mar 2024 04:18:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 30 Mar 2024 04:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711786722; x=1711873122; bh=FGqylyrImO
	EqHasYLqDUUqQXxmlux7mB4nTj0lr4Ecc=; b=oxhWbrwbTTfhMIpqpiVNJoDujo
	3UefBcFrDLEs0VgMYOKzAvBEGNSTMFH1ZCYgrD/DLuFp4Gn4L7FFGpCoXKCvcegM
	nuv/a65H3YtoezlpBZvs7Dbh6Vsn6bu0qJ0BXTPnUtB8b+6oMCYZ5IbgYjwpMZcG
	qZtlRN7IE2TdqAd3h3HkrZLtgc3GlRfdqyB2cuBvzElFKFcaUNkUorJgVaLwfR9m
	bCxF39vV2gfjl4DWPonQ2xi6UYobU6JIiWWy6em/0V7415NKPc38Ddap61RYZT+O
	z3rGh9ifRF82GKmXivzknqjyeRiIzDH2ASiAi/zujqTM8pZ1PH6QDk1o7pwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711786722; x=1711873122; bh=FGqylyrImOEqHasYLqDUUqQXxmlu
	x7mB4nTj0lr4Ecc=; b=gQvi+El5ufpOUlS8ynX1OEaZ/zHfR23VVd7+LGVXzJlD
	NyenbzTnZKpc69cN7Ol5xoi7PbaTu1/mtJwNT4+/6gOaBTsi+QPClS2j0ecuK/ph
	6nxybDnqJ5eDDmikKt+CTWWb1O/K0B9LU1Mcw+YPIcLz6InO279OO+L3uOB7mpFv
	z87mQwVrl6G9n0wEN7NUZScYPTXNPQc98Kqezbga553N+DRJpQyklV57M8Kn+3wt
	LO0EOelYEAxaILqQpzTZ5fCnQks93DLpLqcg5+WajUZBkcLuvq7NN298M+vRvZ93
	IBC77KSYTtZOmdNdyj6tYCKNCvUyVk4qSj2VIVAueA==
X-ME-Sender: <xms:4soHZrnOthkmZcKflQSyr4_KZ2D_C06Zq4V7g8eCSPFmD1n3Gx9WKg>
    <xme:4soHZu1WEnnz7y36Msvymgbw5jYFECkv1VoCpaeQSpaI6LweRimH75lqfwrU7_9VN
    39QBzcdjwxSKkozgA>
X-ME-Received: <xmr:4soHZhpJxKZsoBysyOo5FxXEBhg7JFb9ZRXdndBub5hhNDPHtFe2OdNosoH_EZ99cB07L84XgMZ_AYr_DKu2q1B2pPtCBikSmTIuDM-9ewY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvfedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:4soHZjnoG5Cdw3U-5bbybdbww7fmyfsLVHCy6b42-Yo1vqzEEBcJGg>
    <xmx:4soHZp3aVC2-dudwQh3c8KR7DLMXxbUxxx1UtNURsLCaUKetlbce4g>
    <xmx:4soHZiu_LLmRO5MmrBp9tgBTtiFDm05iMPWXXdNEZ7LFK1ZIdyKdjw>
    <xmx:4soHZtWYDwTaK6wgyPW_eBF7d55orSqCXBZDJXmORxQtgC465vAgZA>
    <xmx:4soHZiKs3_cyrGwwil47CRHiGSJ34u7SiVEBQ9qR0Dg4NHKSvo6rJQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Mar 2024 04:18:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id acba1a51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 30 Mar 2024 08:18:36 +0000 (UTC)
Date: Sat, 30 Mar 2024 09:18:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	psteinhardt@gitlab.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Git mirror at gitlab
Message-ID: <ZgfK3DoeidDcIaFj@framework>
References: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl>
 <ZYQl_G-S4vQibHWn@framework>
 <Zad1S3vCuv4KYIzx@tanuki>
 <ZfwY_h70OeuRT7mk@tanuki>
 <xmqqy1aba6i6.fsf@gitster.g>
 <E5C00398-536B-4CE5-AB25-FE7FCD55CCD8@schinagl.nl>
 <ZfzUb9HkZLq1UIed@tanuki>
 <CAP8UFD2LmapWutRpfveL6ChSg8xrCkQXyQaJwHyEp8JA0p_Osw@mail.gmail.com>
 <Zf2B5oksaJRDH5WT@tanuki>
 <1d6a282e-afe6-4d43-a61c-d0259131b11c@schinagl.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K2DrCxF2YcVWxw6J"
Content-Disposition: inline
In-Reply-To: <1d6a282e-afe6-4d43-a61c-d0259131b11c@schinagl.nl>


--K2DrCxF2YcVWxw6J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 09:14:47AM +0100, Olliver Schinagl wrote:
> On 22-03-2024 14:04, Patrick Steinhardt wrote:
> > On Fri, Mar 22, 2024 at 11:08:34AM +0100, Christian Couder wrote:
> > > (Sorry for initially sending this privately to Patrick.)
> > >=20
> > > On Fri, Mar 22, 2024 at 10:41=E2=80=AFAM Patrick Steinhardt <ps@pks.i=
m> wrote:
> > [snip]
> > > > I'd personally rather go with the latter, mostly because it matches=
 our
> > > > git-scm.com domain. I also like it better than the current git-vcs/=
git
> > > > because of that.
> > > >=20
> > > > So Chris, would you mind adding me (@pks-t, my non-GitLab handle) a=
s an
> > > > additional owner of that group?
>=20
> I'll empty out my gitscm group, make it private so that it won't be
> accidentally used and transfer ownership to pks-t. You can then 'do what =
is
> needed' with the group. Since gitlab doesn't support aliases (yet? :p) be=
st
> to park the namespace.
>=20
> Olliver

By the way, thanks a ton for being this open and helpful during the
whole process. This is greatly appreciated!

Patrick

--K2DrCxF2YcVWxw6J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYHytcACgkQVbJhu7ck
PpR4Pg//SDwcnqDhUc1vkxXDdAasPRVv6/xLuwL0gesWZHwWHkT1/lwjOWrhiC4u
fMQSJC+6IXilWBNSCFKKwsZwWWL4ZGGJV/+LEk9R0J8VzhyVANocEezbck6RbbX7
d26oNobSv+Y0mIa0zCXf8j/OMzEbQ61LDKkqoe/FVs4C/uldweebTxyO6TldF4CX
hL8nDBAEoWFKQHrafSeNoSjSyYurxRqUd1CB1YhzIg5n3fCuO8DjFjHPp5htvpmx
IxlEFX1EVpI1zN3838JpUSA7LlVozcbdfXLkTjGFRoOYE2qi2nU5XsdEMt8BlIG9
P59P3dM+PAtqCC1Ag6oIk2pzlXZ+paNS+FdRMIhI6am2kpnOSND30E58syv7n47U
XTV7QrSC8LaVzJ8RGvnSmf41r5EAm2axNpNT152OW19FKMUIAeY+lxVhSth1F7t0
hsgOZycV+lC+3igIiJI3zj/GM/RGNLtmcxxFdJVBlP5nZEmtQGYd9Tmjvk3F6A2C
3HMRXsI0fN1kJW9dCdE0urk1ulISwjoe7Zg/60LydhfLleHeA8x6wbu15X2pDtrs
g9bbw+BXGfZjQbMe8zyINDZlKIpmF44gAytdjmlXvASJ94OSpCN9WfHDi/Xsl9Zk
JsAMefRrZ+iYgTMUqIiGdwMNEptEQAL3dju57PGLx0fceI8qLWY=
=RIeO
-----END PGP SIGNATURE-----

--K2DrCxF2YcVWxw6J--
