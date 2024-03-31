Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFACABE49
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711870028; cv=none; b=Uj3lUaSMi1oVbPxBRsPenepT3PKvUhlgupp3cEBx+u+76rSs8MNtovU+se7b7OgEou9uOOTOwWeeG1FC9gVSNeAr9vB3Mxl+CzGiNAuCLdAC+57DsUOjpKuR7JOKaH+QS6LqNoLcubrZ4Fvx0bYsX2CXn40sDgmr/cx8LANrmRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711870028; c=relaxed/simple;
	bh=0xupxwIiGTiG+pFbojxURWv5KVCDcsY1pHW2VMl5NZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8xkUKgI1EKi+SH8dCyXFlX+4s3Q9nR4PZx1G/xgyR8XcWTPQPbTwQfLxacpAtBaalw8iUsEmMjVPtMRflu0GxDiSEUqSwMbwj4MCo7ttKDjQ90cfvcwA1x+DEDwo9j1kdqbZtsfU2albD6LPlonnE9zTsPd07P+ckRvUAPkFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PHlzbLYa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hbD19q3/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PHlzbLYa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hbD19q3/"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id A3A1413800C0;
	Sun, 31 Mar 2024 03:27:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 31 Mar 2024 03:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711870024; x=1711956424; bh=0xupxwIiGT
	iG+pFbojxURWv5KVCDcsY1pHW2VMl5NZ8=; b=PHlzbLYal4oly1aMPv83NgS9sZ
	1+n5qxVvBM+cq//tOWv1HEG90UGmkDaPYHy+nZMXeKDEDag32fg8ddA9dUwqOFKD
	4qNKzewpqmYwqpY4/0fj+hmFmZuH+dEjpGS6Gnel4cw//M7+YfH4S2QL2qxMIpYQ
	LOX/keAWRDA98Cp32/oJail6vDk3Spog4mBYuW690JbkzUrxqBjuw2v0tlNNhBGq
	c1WK+4y0baC844L7n3Ar/ytMh5GUMYA6OkY3kTBJOH6N8uln618AKkT+FPbsVoZb
	lbz1B6/d/9jysqVhHJrrcQexqIuKdN3193nUoo9W8Ht+hl3QWguzKbMgTkHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711870024; x=1711956424; bh=0xupxwIiGTiG+pFbojxURWv5KVCD
	csY1pHW2VMl5NZ8=; b=hbD19q3/dXlNQ8nKWNBl/7u3cfSzXLCuphtq7O81ybvo
	Bc3OhspZ4AKbL1c5zA7XYbxh9QGabeVSwjCBWUiJBSkSraIDmDBi3lNHgJrCrM1v
	cTM4qVaKlCCF7vkNHuNu4OXqZzHork34MnoMcKRP8G86cYTlqYtz2IjlUorQY9K5
	UrOMX7JoiVwYL/qFiGxq7NqQ7h3Pa90BHqZABOf8ZawdMubk0pO08M0DXJbJ6pEt
	gdHiD+wl9f/B0fX/hV57aeJZ6HP500FNOYC4otYsY7MgllpcmN4/7bYKA65IyRhd
	o3tepMIOvAprIW9K9zhv8WHij138sFihGvCPhwH8rA==
X-ME-Sender: <xms:SBAJZrudWvx-AIxfbRgDIWr05y0GtiyYhzrXBpM4RDjAZIU2JSCpOA>
    <xme:SBAJZsdGpbYorpy-SF5REj54Vs9OxkWCE7Mv8RU6hlqIVHQb95HttO4QLm5UFKfbn
    brXvBbZnnvAuyJbHA>
X-ME-Received: <xmr:SBAJZuxEygq_fSdSHJ-2bnwurbBY_Uo90XjS7otWZPK2W4D0Ygwc2KRi62PuTuMiWYED_HwdZ2XCdqC4a_5HdCmEmHwb4xOUTVkuCTRdl1o1zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddviedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:SBAJZqPMfsijWqoOfeEPg2WP2zs5MaeEoeL12eU4rbWyhsfoyVlvwg>
    <xmx:SBAJZr9XX4Z8uEMA4n9mdJjDaQD-clldCXMl4llNUdKncqgQzAEhKA>
    <xmx:SBAJZqWSaOYmoKa_v3fv18UytZr7sMnkmngNeGIGKjNYj6WFq0ffiA>
    <xmx:SBAJZsc_AMdw2iFvmZDh2Fd4VOqSWUa8rVHJcO94NJ7lWAv2qAz8YQ>
    <xmx:SBAJZnRAhERXpGRtXTtSBb9E4Qy6jw17P-saXAFZIM7VMdJQLmr9xg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Mar 2024 03:27:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 98800c57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 31 Mar 2024 07:26:56 +0000 (UTC)
Date: Sun, 31 Mar 2024 09:26:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	psteinhardt@gitlab.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Git mirror at gitlab
Message-ID: <ZgkQQhW6GegFNqfB@ncase>
References: <ZfzUb9HkZLq1UIed@tanuki>
 <CAP8UFD2LmapWutRpfveL6ChSg8xrCkQXyQaJwHyEp8JA0p_Osw@mail.gmail.com>
 <Zf2B5oksaJRDH5WT@tanuki>
 <1d6a282e-afe6-4d43-a61c-d0259131b11c@schinagl.nl>
 <ZgfK3DoeidDcIaFj@framework>
 <f283d6ed-54b6-4bbd-8b14-67c9c8d50a2a@schinagl.nl>
 <ZgfWH_smdZ1jXkLO@ncase>
 <68563c5e-af74-4300-84c4-a0d75434167f@schinagl.nl>
 <ZghUu7Ae5PYga-Ji@ncase>
 <4A3E0E2D-2922-4C90-A306-30A685D11C4D@schinagl.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N0gaeesGtl0HLRe7"
Content-Disposition: inline
In-Reply-To: <4A3E0E2D-2922-4C90-A306-30A685D11C4D@schinagl.nl>


--N0gaeesGtl0HLRe7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 12:54:12AM +0100, Olliver Schinagl wrote:
>=20
>=20
> On March 30, 2024 7:06:51=E2=80=AFp.m. GMT+01:00, Patrick Steinhardt <ps@=
pks.im> wrote:
> >On Sat, Mar 30, 2024 at 11:59:51AM +0100, Olliver Schinagl wrote:
> >> On 30-03-2024 10:06, Patrick Steinhardt wrote:
> >> > On Sat, Mar 30, 2024 at 09:20:22AM +0100, Olliver Schinagl wrote:
> >> > > On 30-03-2024 09:18, Patrick Steinhardt wrote:
> >> > > > On Sat, Mar 30, 2024 at 09:14:47AM +0100, Olliver Schinagl wrote:
> >> > > > > On 22-03-2024 14:04, Patrick Steinhardt wrote:
> >> > > > > > On Fri, Mar 22, 2024 at 11:08:34AM +0100, Christian Couder w=
rote:
> >> > > > > > > (Sorry for initially sending this privately to Patrick.)
> >> > > > > > >=20
> >> > > > > > > On Fri, Mar 22, 2024 at 10:41=E2=80=AFAM Patrick Steinhard=
t <ps@pks.im> wrote:
> >> > > > > > [snip]
> >> > > > > > > > I'd personally rather go with the latter, mostly because=
 it matches our
> >> > > > > > > > git-scm.com domain. I also like it better than the curre=
nt git-vcs/git
> >> > > > > > > > because of that.
> >> > > > > > > >=20
> >> > > > > > > > So Chris, would you mind adding me (@pks-t, my non-GitLa=
b handle) as an
> >> > > > > > > > additional owner of that group?
> >> > > > >=20
> >> > > > > I'll empty out my gitscm group, make it private so that it won=
't be
> >> > > > > accidentally used and transfer ownership to pks-t. You can the=
n 'do what is
> >> > > > > needed' with the group. Since gitlab doesn't support aliases (=
yet? :p) best
> >> > > > > to park the namespace.
> >> > > > >=20
> >> > > > > Olliver
> >> > > >=20
> >> > > > By the way, thanks a ton for being this open and helpful during =
the
> >> > > > whole process. This is greatly appreciated!
> >> > >=20
> >> > > Hey, no problem. I initiated this discussion because I wanted to g=
et to this
> >> > > solution. Just because my mirror is not used doesn't mean I don't =
agree :)
> >> > >=20
> >> > > Btw, I can't transfer the group, it's empty, but if I delete it _r=
ight now_,
> >> > > you'll have to re-create it, _right_now_ (well within the next 5 m=
inutes?).
> >> >=20
> >> > Shouldn't it be possible to add me as a secondary owner of the group=
 in
> >> > [1]? From thereon I could "transfer" the group by removing you from =
it.
> >>=20
> >> Done and done.
> >>=20
> >> I'll remove myself, or you can kick me :( one I know you have successf=
ully
> >> received ownership. I tried to invite the group git-scm but that could=
n't be
> >> found, probably you can do that (and then remove yourself :p)
> >>=20
> >> Would have been useful to transfer ownership of a group, iirc you do t=
hat
> >> with repo's as well? Under the hood it could use the invite + remove m=
embers
> >> thing. Though this works.
> >
> >Thanks! I've added Christian to this group such that it has a higher bus
> >factor. I guess it should probably have the same owners as the "git-scm"
> >one just in case we ever want to do anything with it. I've also removed
>=20
> Could you not just invite the git-scm group and have no members at all?

In theory yes. In practice though this could cause us to hit the free
user limit in the "gitscm" group eventually. This could be fine given
that we don't intend to use the group anyway. But I wasn't a 100% sure
and wanted to double check first before doing that.

Patrick

--N0gaeesGtl0HLRe7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYJED0ACgkQVbJhu7ck
PpSK2g/8CJ54Ih/JcAof2zEDrmjF0jl1Nnr4k0eIdRtHuBfRN3hHRR0Tp2Q1QmU4
gFM1N6onwEQTVgKC4BiFgamuJ4a8IETVSSN11to98bePrzmtdG7EttiGapY64cul
jc3L+aaoN+mkzZcbcnhdYcvgw/eBFCRZTDHzsDQyb9b24LEF5Ww4RidAgM1PfjUO
zIuNCaWsYizZ18wp0LvKJ8X+AuG0ds3HTljKhoAyBW1zMi5v5zGKKhyS6uEGhiBS
bkOZutuO6eZHwjowEG5UDkQK38T+qnmJN+aBHhec5o9PK3WYoapp4rLB1HFNzLzT
eNC/G7rtL1P5L3f9EgfJ7cDofHlg9PMpcuJJWudQ08EEXBrAvVvGXZqtBE8Sw4DI
4kXD4jnNcoc6bhGAYbuUzcjblBLgv2b0D3Ohw+i1+7MWNtRnw/fdtufjU4xLYJMQ
BtDXUJGdbo/y6dYxe3UfqLEfrR0IfFBNt2kpecKun7Dkke9yYWoG2YfeCbyeMpIb
yDb73v7ldjigkIw+3SPj9ds/qAqRVTC9ToBSPdAPQkPitobYl8sz0xWoUa3RvbG6
pRNC1SkojFsWkhTjQX963DKZ8BppK+iEdzzjOj+fY0h+bSPXzrQ0LaPKWVBdqjYJ
MVOIPxCkHFHkg3CUSvnUw/9H0cVhZt5XIl6lE+vgIlxj6KdhJs4=
=b3/L
-----END PGP SIGNATURE-----

--N0gaeesGtl0HLRe7--
