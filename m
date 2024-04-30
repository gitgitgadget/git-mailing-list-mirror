Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFCB1292D2
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471794; cv=none; b=KjnHbsg1u/7TrjLYyjknUYdYfcp7pt3ByRbm4A6iMZSEkrmPNLskOiniNGI4wPzgyC9o0N7eKuOcczGfQyWyw1CWQinmY64CFltBm1ZVy1YEkb5/Lw+kDeU2cip52PT7RZZDlwTHgAaAk5bWj+LtieNegGErVYEhu4kJMoeaPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471794; c=relaxed/simple;
	bh=7DamN3tasoI9fJGPCMH2M2JtUKQ5uLFzvLu4PVhnFT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t59WnV8WLjtpNGcl0xrdOVCKFrQdcgsvn+HrKYv3XIXKZNaTXL9ckhGjUjVrN7ciBHk3aTG8/LIpWtrL5s084tau7Q3n/snPvvrMFKIvQ1aXe2+ARrxxfBoTcEpJa6qIulDPdaDI6asaM1Lkve6A7/MGh5x6eBAk4rOhNrhKhVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UHFn1/qt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YLltwCta; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UHFn1/qt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YLltwCta"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6975E1380EA1;
	Tue, 30 Apr 2024 06:09:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Apr 2024 06:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714471791; x=1714558191; bh=0JthQmYw0b
	Yu0ZJXSIdzhgN7jYbDkfDtbYyEk67O4rk=; b=UHFn1/qtQjEO/O2J+w4y+F0uGt
	ZfCAm4mdfhFkCTZBYBuGGzwwvkSNTOIVBpPb6ZVT26GvdDJ7hB/+Xhs73pHuLp8Z
	7FNI4d7eIzxtr/tMHfb1FIBkOXKiB5AFmtWEtDhRgowZL9s5n0LT4sHODOGOf9f2
	kG6KBR+dmjlB3t/gQ9xZtCFVWrRov7bHi3nIQl5y76TK5pqsFmTJMwOC7PIw7RY7
	obUdholq8tp9hTGgW3XLAH4xHxvW1QgYb/4qHTu3DeoZmYQfYWrnCxayUXEyBvsN
	NbjKNskI0mJSWTdkD5ftFp0WGKgZdpOSOhF8AaRO/nInFBD7jPHjywZeKEfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714471791; x=1714558191; bh=0JthQmYw0bYu0ZJXSIdzhgN7jYbD
	kfDtbYyEk67O4rk=; b=YLltwCtaT5noF9fd/I/hdA47MLId9GglKlL1hGQAgWix
	lWPoGvLGj0xi48lKHW2QZN9TKKt1/Bdm7rB1sSBvdCZD//hHtqlIO+PH39I7jYmq
	hr5OaZ7JOgEyPAk7XD4uOhDxg7wzdHrZ/tteumUmEm0oV6a6M+PbVojsSeqLVm3R
	nRrZfFiLh/6BWgKmRr8BTvVndngVC5PaieGWAWuX1NMXUJl4vcTDOi5BTtQJbag0
	hzTyTkheHyHL4n915pwzlnAtgRaukU/Cday830kjWzGe+LXIkgW/j+e3T7Kse1Jm
	8BsikSg2n6qoR239J9Ha80SUrfLgvQtNb4Ju5VPVjA==
X-ME-Sender: <xms:b8MwZvwzz90VTD2w6xAKxMENKx7REEmo7VhDc0vmqQmMDcZfofuBnw>
    <xme:b8MwZnSmM1bXj_wjPx3UjqDeLVP1Dww8EduM01T9w46ASJR96CdqZkeORPeYt20Km
    knIDd4K1a3z40oFuw>
X-ME-Received: <xmr:b8MwZpVv2h35b_9bS-c4pJ2MkTYdl5jp0aTjdoccaXMTu-ingxpPlkTpUhTISIhfCKUwk2MMDnIkvQSNlg9eTytUKqh5OF3dv-EYhHoKrdXvbrOLuP0x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:b8MwZpjMgE6KRjM9umS0Km6gn3tmACzb5KZR6iyplGWmDzCdTFj8gQ>
    <xmx:b8MwZhBxC80b6UKp3WARtMFo5RoyldHjOo-wpLlq69PkirvQl2Be8A>
    <xmx:b8MwZiIgGjEzvhahC7uvikqJmQtTwD7kDW_2WRAtLF8C1HkyQ68QVA>
    <xmx:b8MwZgDM8-4pBBgsSgfo1-GJ2swcy7Js4CDKEnwUJwHq8XN7DPia4w>
    <xmx:b8MwZkOQzY2_efx3l7umLoKC3RMbr7GF0suXSxQakqz1bhO0tGxaZsPB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 06:09:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c0012f02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 10:09:28 +0000 (UTC)
Date: Tue, 30 Apr 2024 12:09:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] check_refname_format(): add FULLY_QUALIFIED flag
Message-ID: <ZjDDa5PIxPCFzMhq@tanuki>
References: <20240429083325.GE233423@coredump.intra.peff.net>
 <ZjB5bHiF5kAcRMpP@tanuki>
 <20240430100145.GB1279403@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zpvw1EJFbgB8xt0J"
Content-Disposition: inline
In-Reply-To: <20240430100145.GB1279403@coredump.intra.peff.net>


--Zpvw1EJFbgB8xt0J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 06:01:45AM -0400, Jeff King wrote:
> On Tue, Apr 30, 2024 at 06:54:04AM +0200, Patrick Steinhardt wrote:
> > On Mon, Apr 29, 2024 at 04:33:25AM -0400, Jeff King wrote:
[snip]
> > > The whole ALLOW_ONELEVEL thing is a long-standing confusion, and
> > > unfortunately has made it into the hands of users via "git
> > > check-ref-format --allow-onelevel". So I think it is there to stay.
> > > Possibly we should expose this new feature as --fully-qualified or
> > > similar.
> >=20
> > Hm, that's really too bad. I wonder whether we should eventually start
> > to deprecate `--allow-onelevel` in favor of `--fully-qualified`. We
> > would continue to accept the flag, but remove it from our documentation
> > such that scripts start to move over. Then some day, we may replace
> > `ALLOW_ONELEVEL` with something like `ALLOW_ROOT_REF` that allows refs
> > in the root directory while honoring `is_pseudoref_syntax()`.
>=20
> I don't know if we could ever get rid of --allow-onelevel. If you want
> to check a branch name, say, the replacement for it is to ask about
> "refs/heads/$name". But sometimes you don't actually know how the short
> name is going to be used, but you want to make sure it's syntactically
> valid. E.g., validating a refspec may involve a name like "main" on its
> own. I suspect it would be OK in practice to just give it an arbitrary
> "refs/foo/$main", but that feels kind of hacky.

Ah, fair enough.

[snip]
> > > @@ -322,8 +331,11 @@ static int check_or_sanitize_refname(const char =
*refname, int flags,
> > >  		else
> > >  			return -1;
> > >  	}
> > > -	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
> > > +
> > > +	if (!(flags & (REFNAME_ALLOW_ONELEVEL | REFNAME_FULLY_QUALIFIED)) &&
> > > +	    component_count < 2)
> > >  		return -1; /* Refname has only one component. */
> > > +
> >=20
> > I first thought that we don't have to handle REFNAME_FULLY_QUALIFIED
> > here because the above should already handle it. But we can of course
> > have a single component, only, when the ref is "refs/".
>=20
> I hadn't really considered that case. The reason we have to handle
> FULLY_QUALIFIED here is that without it, "FETCH_HEAD" (or for that
> matter "HEAD") is forbidden as having only a single component. The
> earlier hunk only rejects bad things, so we still end up in this code.
>=20
> I think that "refs/" is forbidden both before and after my patch because
> it's invalid to have a zero-length component (so "foo//bar" is
> forbidden, but so is "foo/" because of the empty component on the end).a

Makes sense, thanks.

Patrick

--Zpvw1EJFbgB8xt0J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYww2oACgkQVbJhu7ck
PpRoTw/8DKvkMSWG6iDEgY+zdDxdaF3WE/+vOHk1brwmuzVEhoK47uqkMXF+NY6N
Qe4HfXipStVBD4Cy0dbo5bt7v+jzzvSzPfXrZ7YJpWjyCHZrlnb/ciZSsSXI/1D4
WVhPEv0P1W8Ii5TbaydyC37IVwKMRWNdLAfKVBBrp4f8iP/YneiVHU33YRB3LVN0
qUPr/7Adyt/eW2tXBRDSKn7Y8V0SUOSOGd2RB72jOmVvDAfYfDwAbGV59wf4YQ42
MF067h6YYwXenCh3/YGi976zK5ztrBNKoVUmsF256hdgaYJ62rElz8qeBu0PoZq1
gh1Rkfwa8fLjns6fdOGIQRkoY3nTmjoHahaII85zMLSWm62P2aX/BMtmhLRvEUP6
KC5JEQSEN/5MyXRq0/xc59fBaShQrkret4TMO4Fm1oxjw6tu9gfLANyYq6y6w5Ca
8qUoBt3Y75LYkc6CkBRn4dYTOewCCHgvNwKsNMNJr4tGszNmpiKKLUHYtJ5Saiy8
gVdibICNuxRBRPo5UaF1MyrZdbeJ7AhNaaZ0pxfGnDXVKNyZeBadTUV7pmuLGVX1
Ao5HeMN9w+RMtuLkSboUe4N/bFgb9CGEHSlS8lY+PYzyKfmDBQJQHcxnso4SLbOx
eOg8WoRuetfTZPoDVF+qWqM9fPVYkAnetLfq8W1Ikas2tCbGRUw=
=z8ni
-----END PGP SIGNATURE-----

--Zpvw1EJFbgB8xt0J--
