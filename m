Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F54C757FC
	for <git@vger.kernel.org>; Wed, 15 May 2024 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775848; cv=none; b=b5TbXFR9LgHJS4SIQQQEcHhsJ7yCZU1I6QNEVnhZgnMs0SEWJcd/supFQAZZzbfCYHLEPHNVtq5bLrvbRTjuEGEjjKj7cZpKPDKNmgHr7M8J6tA2Q9utS0m6RKnwqNtvLJAHdZzQJtnk2qpR3bY1SWybpy0p3GUC291wsOPdiL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775848; c=relaxed/simple;
	bh=Q5sm4NN9q9AomVbP7qrBfzKTKjZblfIAkgPKE0S4LdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6eOA6np+HAug5NAaqbIVJpARYThi/2f9w2yQd7ey//HfbDOmfc4UTDjhRAxT1FnAR3Xu+F+XWlmkCKQh/u6HiQ18DYqv5KrqhcSZhYssUAJ1bCoALDJMW4ScukeNG8aLtVkae1DXE/8fPm/4E2Yn3yBqjEyoprCt0QPQhqcWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Egq2RYc6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=di4FtSxT; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Egq2RYc6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="di4FtSxT"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 43D521140146;
	Wed, 15 May 2024 08:24:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 May 2024 08:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715775844; x=1715862244; bh=Vv0fusU1nN
	k0J3qirSxYg7KAj+jLFbY3glg2qukQMBg=; b=Egq2RYc6ooJqfimPSjRxW0gqxQ
	ORphHrzmhprOyEhipwLS8YRH2nzVtoT7DbEy5yszEFMJ/vYW4EZpPY9b/r5CMchu
	f1yV0Sc/4Ya8MWDEUqgL8i8tB3MI5zif+S2VlbnQzO4qddeWQC98uBSeg19dUUb+
	MRGe1krxYeILowqiFyYlkuqHmj93Gy2I3UdOuMzrg09an7eH7gbNVcts5xwtq6mM
	6YsOFLB+OX+sIkuLZ92U7HFu3biyn/eeYkytH7wWMhGejtrqTeT65SZh1PgDXNpg
	9yeIaKIxlsB1ne2LHrDENR9s8QY0YhCNsz3vTVVrv0/GsAVjEl2V5tCg+zDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715775844; x=1715862244; bh=Vv0fusU1nNk0J3qirSxYg7KAj+jL
	FbY3glg2qukQMBg=; b=di4FtSxTv2fx86TzJDhVZ4ma40Cxs/Zmv4Mds/s/0rsU
	UcjZ2rb3/V0jm5HlsE34ipAcgbodS+tR3X4jE/QkGg+MSoTmsYNdhfdAgizqAZFg
	ZDTz35fn4LpuHcpM6PbEf0Nk8uJqmcLr6197Q7PzmAPnOW7CzfUL1WROTcg8nEqC
	gFrPcvdDnmH3RVfPh/jrd9Lq1gpX5kpoFK9T/MDMob1uqygqiurq/f/wUzbNMbxM
	UJoEAhs1kkCB9Kj5a0nXBcCbkADvHkFddMJc03LtoY57+0uFAwLx1Joty11uUQcI
	cgyhfaiBUDLOO3GvkElc+Qj7fCC2vA8N9hJECi9s6A==
X-ME-Sender: <xms:Y6lEZjGV97EdXc8klQg4zG6xyLB47wf2Y1pg4MpkHrNOg3JJTVOHig>
    <xme:Y6lEZgWoloX6Nq96nj2-pb5mjspiGQ4tAWVp5_Q6uUopTb0mnzVwCV6wP3lkTHOdR
    JAfjr0__micoeXtSQ>
X-ME-Received: <xmr:Y6lEZlJgFm6MPqG9wsbwI90pxycRZxLE6GQwI1GbXxPmZjgs7LZ7GlDxkqppDt_xE6MWzX6c3_IVqsqf8MipEuwFt_2E6D0jCFQU0zSxdup5zBgI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Y6lEZhEbjCY8QKVmi_Wu62lqh14GO1YK0ALIcpw5bVjDtauP7uDVhg>
    <xmx:Y6lEZpWQ6Deyyk06P_WnoQLzIVv1FznrRT6q4b0BPzK3IsfjoKKhiA>
    <xmx:Y6lEZsMJLsDgfFI864cLEOgPzWsxZFxgWLc1_-h-J12NZtJdMhvVQw>
    <xmx:Y6lEZo3rwLxUf01G9RutUIULivm-8UvH5QpX-Riv10FRVe39OwWpaA>
    <xmx:ZKlEZmg7G9SHUWtGIXBdmagH0hf3PMIV3Kv1YVhnGnIQ9wXy5aQSb6R5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 08:24:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e750d904 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 12:23:37 +0000 (UTC)
Date: Wed, 15 May 2024 14:23:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 1/5] setup: add an escape hatch for "no more default
 hash algorithm" change
Message-ID: <ZkSpXnsyxEf6p_4R@tanuki>
References: <cover.1715582857.git.ps@pks.im>
 <20240514011437.3779151-1-gitster@pobox.com>
 <20240514011437.3779151-2-gitster@pobox.com>
 <xmqqikzg48hm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wN6fwbUXlgzUacht"
Content-Disposition: inline
In-Reply-To: <xmqqikzg48hm.fsf@gitster.g>


--wN6fwbUXlgzUacht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:19:01AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Partially revert c8aed5e8 (repository: stop setting SHA1 as the
> > default object hash, 2024-05-07), to keep end-user systems still
> > broken when we have gap in our test coverage but yet give them an
> > escape hatch to set the GIT_DEFAULT_HASH environment variable to
> > "sha1" in order to revert to the previous behaviour.  This variable
> > has been in use for using SHA-256 hash by default, and it should be
> > a better fit than inventing a new and test-only knob.
>=20
> Having done all of this, I actually am very tempted to add the
> "always default to SHA-1" back as a fallback position to the
> set_default_hash_algo() function.  We know we are going to get the
> right hash algorithm when working in the repository, so the only
> case the default matters in practice is when working outside the
> repository.
>=20
> We already have such a custom code for "git diff --no-index", and we
> are adding a few more back in here, but they can disappear if we had
> code to set the fallback default when GIT_DEFAULT_HASH does not
> exist here.  The "always use SHA-1 regardless of the hash used by
> the repository" code like "patch-id" should not depend on such a
> fallback default but should have its own code to explicitly set it.
>=20
> As the user can tweak what algorithm they want if the wanted to, it
> does not sound too bad to have a fallback default when the user did
> not choose.

I think that this is going into the wrong direction. The patches that we
have added surface real issues. If we now unconditionally add back the
fallback to SHA-1, then we only punt those issues further down the road
to the point in time where we drop `the_hash_algo` and/or
`the_repository`. All the issues that were surfaced until now are
technical debt, and the proposed fixes have been documented with a
"TODO" item that they need more work.

In some cases it's as simple as adding in an option to the respective
command that lets the user pick the hash algorithm, and I do not think
that GIT_DEFAULT_HASH is a proper replacement for that. In other cases
like for git-patch-id(1) the issue runs deeper and we need to refactor
the whole subsystem to stop relying on `the_hash_algo` altogether.

Patrick

--wN6fwbUXlgzUacht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEqVkACgkQVbJhu7ck
PpQ8PA//do+lA6ihx9gpfueoA4xSnEQ9eJ9KRkxJIiH6+GkZ+yKS2YO2YAM3wtyb
IGtUAfjwUjWvxRzrjD1oC2OiSddO6FwHCP+BjSV0IEQvYjxvtSlS1SIHTxnIaT25
btCXyDBXUQvEE4b0f8eghkETMYSnu1EqZV+vqBKSSrMuP04dj/IGoaT5kw70OOmX
5J+MYnjYyJkORa+IhSTHyNW5v5SxckkkEPEKzeE1M/NgCBxz73ES624Q/sL/2CHu
sxZYnmTeeJviIv521+Iq4W7BSPofqltUkGCxzT+iP8dmpYFBhunRc0xqVbFq4Odf
RADlRDFZHjTCWQ706A6BipgTp7fDXvdvA8+FxM+MLI3Cpti/1/0/OkTqcTriiKXn
RQT4sCoJvHRx6U0KkSkx0Ktzb7torvnuqu7SoDcdNeMXw1Sqi32JXD9tJSgwmtX0
FpmVbzRLC/QAuKLoeaKBmvSPVAepX/tuXFqb2YOuvOqHJY3Xo7pWEpCHdbHizP5w
yoy3yg+/0jcTZJn/KgBbppPRXj6ZcvfiKQZ95K131Z0Ldz0wjAqPjmAJXLTZ80Bh
g/Leb2bnyye5WaA5U38AmDQ7EuNjeIMtmtCBQijj1+Jf0JH4c1Z+X2gghiQMGTFo
yUwll32sKVfvD10xRI4GAIK8AylDoxh5AT9p+90O0ykOaxAx6eg=
=hDkX
-----END PGP SIGNATURE-----

--wN6fwbUXlgzUacht--
