Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF3933CF1
	for <git@vger.kernel.org>; Fri, 31 May 2024 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162397; cv=none; b=gB0eVjoC8g0DpVkQy5d5wKbUd0OuUqu5yYI2VKk6DLzT3CDdtnHfrEQOl/+e/UYTtTmDOXx5O3HkO6QKD1cnyNHqFlrTieHJg5p7hEKnhE2uFefrBuO59ZTMTBnAmoN6ZKFsj7xuvW5hy//ZAXySlIXdcoOFB7NEQs+lq/TGgSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162397; c=relaxed/simple;
	bh=HGCRFilpCHcUBPDZgAktAlqVXXCcwmbTy8KXg/55gdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox8D4nG2iu89E7NyI5xQH+MhDZ2GPtqHjb6kHJY7wn6eB9bkhnLkiOIV2PUrxNyba4AcEwz0hKEzGX0DUz/XqOzgLdxosmc51ulgemr5eXlFj0ToTsCXu4ckG2MwM9Pbbxg2nZEZWS+Z4aocL242gIvUNAp2TAkXkV8gFcEc97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XZDiUwf4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nx2wVgzl; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XZDiUwf4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nx2wVgzl"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 0285C1C00115;
	Fri, 31 May 2024 09:33:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 31 May 2024 09:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717162394; x=1717248794; bh=KffWqUFGln
	+MNBJvAe2Ev6fXSi9QbzmelZCiJyRGdn8=; b=XZDiUwf4aGDQdId8BMRRDahWuj
	riygsAeu0r3rbrIsuHc79YPnwj2b0u16X5hEQB0/N1Hud9nDjMTrJlNTSLP2L05O
	G8HDVt1dQf+ZfvJoCyJPoEM60RxOAysYqT2ecUhxqeYu6ip+MpASKX+yxLJwsEZ6
	veCjqKrUpej1pD5vQNyUKXFklDIEr4IttRzpBuMl+WcOxJKP4tDo7bg2N+W+RaYd
	p+HKapttP55ZV1CWfWcrF9eKhySjLwlLzMqQk4JBDHIfvywPZ+oj6LA/+w7lpZYp
	JzBWwkffG4w74WDEWAtxlUw7VCdXvqDMzCXUzCjDmtu249we4k2rtF+PrpTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717162394; x=1717248794; bh=KffWqUFGln+MNBJvAe2Ev6fXSi9Q
	bzmelZCiJyRGdn8=; b=nx2wVgzl+rUDtahZaSXRnF5o4yg9OCUU5sTGI5WiIjwR
	ybK48BzLBFxxPutXQDPqbdHHW10rShvtl48AXpEnumFNVaT6c9XgivLLWdKcxRAD
	GcjLz7NrVngBqNA5D0Ma2w2Fo9pWrbR/Z9CYgfxGhAl1onoeDtrH2HTO35PgTQKk
	EvSsPYWZkEoMO/UFWCRr9s50hY4RMzf1uhD+IlMBNe2Ub9WbTdmdIYDCWYFAiWO0
	XaMu8GHHJUXskOvmaOTyCULdbNGMCRC0YVTss41315udI6LmBl/RHU6IlwdTb5qZ
	6qAQHNg04UWMbtztu0cc1a7IAtpweX6dYQzNm9SnOA==
X-ME-Sender: <xms:mtFZZuAYtif0JEPa5zYev0s9iH-AXFj--iBBkWZVTlwYOoCi78TPzg>
    <xme:mtFZZojzV_nzcbKKYmsM1cDtb2i0RNtqotradSvIYW-CQhFc4vOXKM3gmiZBNKJtf
    vSXhcSi21oE0rtspw>
X-ME-Received: <xmr:mtFZZhk5_5fJ7EoE4zMbm5ltSmSYp1ybldjpcF9PiznNVVHoQu05P9miSSKZ3IWSMi4_4mfccQaNHnKCPLxvmb8lckV3OqRVWvD3tvWzJNOhLhI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekiedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    orredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehfefhuedtvedtfeeiteeugefgfeelge
    elveehffeukeelfefhieekteevudfhffenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:mtFZZswx55opxPkRK3Ztmzt1jm0jD-YXT_KDSoPfyya4pL0jh5tKpQ>
    <xmx:mtFZZjRAgbd3-9PioARJMO-YLyhqXl3u3qerRQnMWoKP4sn579hcFQ>
    <xmx:mtFZZnaqjQpvz9A_pLlqRZG030sg84zK4RI-a2G545putOeYwM_5oQ>
    <xmx:mtFZZsQp3bD8JX8gN1OMOpu4ajZX-V1AIRBqfnYgbodMJ_5S5X032Q>
    <xmx:mtFZZteo2Ct7w4YRgMVr_WIbap-QkhQHHz2GPO6vnhD0mINT0XbSrkv5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 May 2024 09:33:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 38d8ce38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 May 2024 13:32:53 +0000 (UTC)
Date: Fri, 31 May 2024 15:33:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/19] global: assign non-const strings as required
Message-ID: <ZlnRlRdfbddzYMnO@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <51ee5660a1452797ac0a45819210141c57f3dcb9.1716983704.git.ps@pks.im>
 <xmqqplt4y1gk.fsf@gitster.g>
 <ZlhjN7K8JKYz6Opd@tanuki>
 <xmqq34pzozsq.fsf@gitster.g>
 <ZlnJ83qSnGlQ0FWR@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y0iaEQEfdz8CmdTi"
Content-Disposition: inline
In-Reply-To: <ZlnJ83qSnGlQ0FWR@tanuki>


--y0iaEQEfdz8CmdTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 03:00:36PM +0200, Patrick Steinhardt wrote:
> On Thu, May 30, 2024 at 12:38:45PM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > > Well, we do. Not in `get_fetch_map()`, but in `query_refspecs()`. It
> > > does weird stuff where it writes the result into either `src` or `dst`
> > > depending on which of these fields is provided by the caller. Which
> > > means that one of the fields would typically be a constant, whereas t=
he
> > > other one will be allocated.
> >=20
> > Yes, <src, dst> is used as a pair of <key, value> to query one with
> > the other (i.e. "where does this one go?" "where does this one come
> > from?").
> >=20
> > But we are not talking about const-ness of the member (iow, once you
> > point a string with the member, you cannot repoint the pointer to
> > another string), but we are talking about const-ness of the string
> > that is pointed by the member (iow, not "char const *src" but "const
> > char *src"), no?  If I ask "I have this src, where does it go?" with
> > a refspec element filled with src, the dst member may need to be
> > updated to point at the string that is the answer of the query, but
> > that still can be done with "const char *src, *dst", can't it?  That
> > was what I was wondering.
>=20
> Well, yes, the pointers can be updated. But that doesn't solve the
> underlying problem that the interface is not well-prepared to track
> ownership of its inputs and outputs.
>=20
> The root problem is that `struct refspec_item` is being abused for
> multiple purposes. One of these purposes it to store parsed refspec
> items. Another purpose is to actually serve as a query. The requirements
> for those two purposes regarding the lifetime of associated strings is
> different:
>=20
>   - When using it for storage purposes the strings should be owned by
>     the structure itself. Consequently, the lifetime should be managed
>     by the structure too, namely via `refspec_item_clear()`.
>=20
>   - When using it for parsing purposes the input string is owned by the
>     caller, whereas the output string is owned by the callee and then
>     handed over to the caller. Here we cannot rely on the structure
>     itself to manage the lifetimes of both strings, at least not in the
>     current form.
>=20
> Now of course, we could amend `struct refspec_item` to grow two
> additional fields `src_to_free` and `dst_to_free`. But that only doubles
> down on this misdesigned interface.
>=20
> The proper solution in my opinion is to detangle those two usecases and
> split them out into two independent interfaces.
>=20
> > And again you are conflating "allocated" with "read-write" here.  It
> > is often convenient if a variable that points at an allocated string
> > is of type "char *" and not "const char *", because you do not cast
> > it when calling free().  But if you want to make a structure member
> > or a variable that holds an allocated string responsible for
> > _owning_ the piece of memory, then you need to consistently have the
> > member point at an allocated piece of memory (or NULL), no?  What
> > this patch does, i.e. prepare an on-stack refspec_str[] array that
> > is initialized from a constant string, and have .src member point at
> > it, would not make .src freeable.  In other words, .src pointing at
> > an allocated piece of string "some of the time" alone is not a good
> > justification to make it a non-const pointer, I would think.
>=20
> That's fair enough. I'm trying to work around a broken interface, but do
> not solve the underlying issue.
>=20
> Patrick

In any case, I have now invested some more time into the individual
sites where I was converting to use on-stack strings. In many of the
cases we were indeed able to avoid the issue altogether without too much
of a hassle. The end result is more pleasing indeed, I'd say.

Patrick

--y0iaEQEfdz8CmdTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZZ0ZQACgkQVbJhu7ck
PpQjLRAAjoQo8fC8EZn0/Fmh1+0/ZdK20obFF0E7CyhMrmudmEx1Mgcryur0hFU7
Y8mAl6xAZ0q+FhOuJJ+HHnRx7GxVuDgUyg1XXtb0KTzw5Vl5OiAskYs1UMFi6aZ/
cDgCRmVEhu5RuRh3XRS/xuZJ3OKZ7yzSp2ytQDEE4rDeeDKRc4o64i00B+ZEuzIw
5p6q9J0xWcbrq6aSnlz7rkVfIAZ1+KF4A0RsjUELRgJve/UidE0TWAiCBgQ+5Qnx
AC0DIrMdJX6jenJ3eSLhzTRh4f+fSlMRVw0ZFanBFZFz9a46hqiHv0UC+jnApe/b
x3IlDV+pRfYoPejfZyQmHlnjecoKQkfapkY94/v/DqgJGVyviU50CTnqgC/C7DrI
llInSeIm7Acra7bBW0GbaXQRViwse/pWFYoC6c0X2qKu41tEcKONi31DW/Txuplt
5ZuM5Io9WJBOlxfYquziZP8OQjc3COIaBIMfNYC8j0Xi9SWeTkME+Vt1KV8BkYGE
fxno3HP0KxIgSzur3jtkSeDzqDvLf7EJnq92wb2bqaEv3JZlOaA3lpNLNklLOoDP
4aXVoiop0GuiqI7G4c+jqKI3s6Nx8N5hMGxhTOFfNimcHiLMlHfGNOQx0Y7isaIW
zU2OZlFtWdhnDHkyxRCm3SZhoKY+CiY1eR83lmoCL/KeSpqnzUQ=
=y2vT
-----END PGP SIGNATURE-----

--y0iaEQEfdz8CmdTi--
