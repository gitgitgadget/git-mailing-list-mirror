Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669B759167
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199182; cv=none; b=TmpCIvPiboaGJ3C+u5P8Et5EyXozwguQGM66ivG3O034b/DLbjgkY5IeIoCp18uYkFYKVBcOassxjazkwSKANhrTCq2yqqZMUNom8sBTIoL77cZlUvJONTqHPj/ahSCS1eZkSiDrEbF/wWXkJGCBgY+4NmtXqa+8jZK7SkcpAcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199182; c=relaxed/simple;
	bh=xw7ZkjbSk2qEw0SGVc2fdyRTSC66XTFUZa/aqgIjBds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ato/+UGjt43kP2cwXN/TrJHKL8HerMY4qY5Ne3gLKDENwJbEeZ4Rw2myc6T5fStoM6OKCfDT8nMClFPSjaLnlZ7nrmEjqPneEhGtHROgDcFYhd+ULddxRZrqyd+H/fmJ5Hn3wMq4X73eLFxseGEtSPY+dIvgMZBJ7h6vQjlG/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PxXSUV1P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pzzfnPqG; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PxXSUV1P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pzzfnPqG"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 408A75C0078;
	Mon, 11 Mar 2024 19:19:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 11 Mar 2024 19:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199178; x=1710285578; bh=bEE5hrs493
	6Hbtxt6AX335ZrLIyPLCBXV8W52GiObUg=; b=PxXSUV1PBM8MviMyO6SSmWHV4Z
	v9Rr2z3cBNQn7UesJbMTYTymDEakVGsdbsip74J8PSPvzXH13QF8Rfcldfqn2Ar+
	E6GRSx+9T/W5c1SsozKK43gO29Y50a2ZOgH9qXvXvDYwUTJopv/rFkeCTtbHSm9M
	LqhbDgVqJO1E425fW3vrB2djJPAH4YI5Nov0YxWgRjx4yenw/a+AYms8ZvKF1Lm0
	LPhs+yb7U+H5QsSPQacHhIKebQEDOy4dJk8vBHwVtDkhhQP2g9t5oLsvTz6JlXBy
	WFd5uYgue7RRQlaqCJ25CQGUOdLhqQdFLrG6zgLS1bGOoHW3C3HAvfdKWyZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199178; x=1710285578; bh=bEE5hrs4936Hbtxt6AX335ZrLIyP
	LCBXV8W52GiObUg=; b=pzzfnPqGUb3kOgpY7f5i5vHK7Aq9n0dIZve95n0mabOl
	M5rUNtY2ijNdzqlAi+nk118tbPY+fVnxouv5guDDNkfbWW57KXFrII+67oGi1rlx
	O7CE3J80XQXELei5tvcj1cH+6lEMMe8bUFc8DFPUazUCry3rhYFXjL1Rcb0r5VnS
	GPtgNmc3yOkjL0noTKqNW7bFccigU2tqBytDUCeVYfqlo1ipYPLD02xadKOEucOJ
	ulpPf2CzSre8Ta19SWQWOcMPNbugy7Nlo8r+fGL7wlGLGLfJEhmS3yVvbgJg8J1e
	4ewQSPXFS4JpF176knp+ql5WWRLIcFj6doZ9q1E7+Q==
X-ME-Sender: <xms:iZHvZWgmahOQzAVbzd87l0Z_cLNq19Ht9OY_C4fVaniZLBsM0QR8QA>
    <xme:iZHvZXDmiYLqjTJJAfJRN4Yr7XHnKbIYMnoxL25A9S9HBXMx5rF3LneNd0YSIjTBg
    qvMKSm2JxTwuwcGVw>
X-ME-Received: <xmr:iZHvZeEVYABzpkYWDnlE5xtZBxBgdF2rzgoNFd86ngs8S8dtNPd4vVev0VTPYI9zg3QMJW6chzNCWYe718buBc3vj8aJ2-ngfbLyvEM6xcGEjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:iZHvZfTi4AoabKoE2F1P3XnCsn0q_15t3nIE1oLIOJUA7NU_xYqIXA>
    <xmx:iZHvZTye27pt0ofjVGt7GwZaU7aG8J8b8-ZGfhyZdDqq-vRODzqS5A>
    <xmx:iZHvZd7j4kcJPrbi68K9PA-FMk86vo6ue3ZGorTTk2aHRUktuFoI0A>
    <xmx:ipHvZeohacyhBlcvY_nRAkr7wYbtoCWA5QogxF_R90NZa4cAeshzSw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:19:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be977923 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:14:54 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:19:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/13] builtin/config: introduce subcommands
Message-ID: <cover.1710198711.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JAwwOoRsox41h3TQ"
Content-Disposition: inline
In-Reply-To: <cover.1709724089.git.ps@pks.im>


--JAwwOoRsox41h3TQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that aims to add
subcommands to git-config(1) in a backwards-compatible manner.=20

This series is mostly a rewrite compared to v1, so I won't go into all
the details. Most importantly:

  - I have replaced several subcommands by option. For example, `git
    config get-all` is now `git config get --all` and `git config add`
    is `git config set --append`.

  - Subcommands now perform their own parsing. This makes the code a
    whole lot more easy to reason about and ensures that there are no
    backwards incompatible changes to the old modes. This comes at the
    cost of additional code though.

  - The documentation has been adapted to mention the old syntax in a
    "DEPRECATED SYNTAX" section. It also lists how to convert old style
    syntax to new style syntax.

As I expect there to be some more discussion and thus some more versions
of this series I stopped short of some things:

  - Tests exist for most of the parts, but some modes aren't yet
    properly tested. This is mostly due to incompatibilities between old
    and new style syntax which make it hard to just run the same tests
    twice with some prefixes.

  - The `--get-colorbool` option hasn't been converted yet. I _think_ we
    might be able to introduce a new `--type=3Dcolorbool` option, but I'm
    not sure I fully grasp the usecase of this command.

Thanks for all the feedback so far!

Patrick

Patrick Steinhardt (13):
  builtin/config: move option array around
  builtin/config: move "fixed-value" option to correct group
  builtin/config: use `OPT_CMDMODE()` to specify modes
  builtin/config: pull out function to handle config location
  builtin/config: pull out function to handle `--null`
  builtin/config: introduce "list" subcommand
  builtin/config: introduce "get" subcommand
  builtin/config: introduce "set" subcommand
  builtin/config: introduce "unset" subcommand
  builtin/config: introduce "rename-section" subcommand
  builtin/config: introduce "remove-section" subcommand
  builtin/config: introduce "edit" subcommand
  builtin/config: display subcommand help

 Documentation/git-config.txt | 213 +++++++++------
 builtin/config.c             | 496 ++++++++++++++++++++++++++++-------
 t/t0450/txt-help-mismatches  |   1 -
 t/t1300-config.sh            | 417 ++++++++++++++++++-----------
 4 files changed, 786 insertions(+), 341 deletions(-)


base-commit: e09f1254c54329773904fe25d7c545a1fb4fa920
--=20
2.44.0


--JAwwOoRsox41h3TQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvkX4ACgkQVbJhu7ck
PpQ3AxAAmXLmz9S51l6HS5cyecJo9Qb3LVTKBoYmC4x3yDu0v6AsjqDbSwGDSgYg
vnMxyesegODIG3A/aUcbV2xyeDsXlQCbWyGhUF4ZLpkHciXdL4cMWv4T/KpQN1m/
RjTGu3T9/AK6DmpmoiWQjwz4OGTiL7U6tHhHwXxjH78LDdGSwH2bBOOzpxRCuxKo
20inHZOG8+PFlTkYPTPv0N3n/bZ6EGDhUBUDvjzHFKtafruVjb/R6NsIkY+9Wj1I
nIJ33nOE8XhpzO9TwFhD7EP90US4rBiP26fmoeJE3G8iAgbZ0plklus1WmBajsau
qbtw6uqVH2qtb8aV8IzBBPTn22GrPT+SUQSyqs1DqQX+J5Ekb+elYqpvwM3EZWzL
tjNgeDyAn1+QS9y7FiHbCE4Gj32W/lOmCHodwFqCI8EYGarVh3kMJrxH9bwXb3/+
JfTy51PFEgxOHZ872w3RDZAtU2FiJki+eTEX9m+u42/bIvbnJ+CE5Q3XLhvsxjTm
GJYxRvgLz+pGkoD/245Joo2MAez3zQ1Fnpbxx8NsrpxwqPqnFWsF0I5k9MKD8wis
hx1yRZBfkEqb4WWkJJGovCbnaQU0qX5qVdTKS/JDhm7CRt53OnjPgypGOGhzySnX
od+xdXos2DoPGQFcidPCJrrPZr2JE0vF0Af/3dbrRIB8U9jZZCU=
=EWrV
-----END PGP SIGNATURE-----

--JAwwOoRsox41h3TQ--
