Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44493128374
	for <git@vger.kernel.org>; Mon,  6 May 2024 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981015; cv=none; b=I//3zRiYKRImuMDj083lCcpNLoXHoUFSXRanmDD3+Etlk/6qfyuyUOCzkDU5ZXfiGJ6hUSPyKBBlBiUW6QSqAVlNu9pMkR7L2RufDpGkkglJonsZMg5V8Ur84Fkj9Oxb0lTpdoggjtW3jSX968jMXaFH+IeDVlgtw79675gkQgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981015; c=relaxed/simple;
	bh=Ys8Qm64J7NFyvyhUsiNOOl0vbocWHAmYkRcRHxIRoy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArQ0QaclCU2022yWSUIgKUS1rC0mnYR2wGYNstWMwp6WsmPyTCNmX+c8qvivhjoLqMP9jDWxMAnCKRMEiA2WjYGK6RPVnpJy8imsSe5HlELE/8CwSGF0N1CMWOp689vQrjkwo7lbx4tLVbCLbAY4VXX16+yo5TmJilJiPlcor9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SWbEyRHA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UNgjwVvk; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SWbEyRHA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UNgjwVvk"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3E75A180007D;
	Mon,  6 May 2024 03:36:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 May 2024 03:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714981011; x=1715067411; bh=Ys8Qm64J7N
	FyvyhUsiNOOl0vbocWHAmYkRcRHxIRoy8=; b=SWbEyRHA3bsjQEvZ6cDiMRZ5h9
	57SaVDA3oyRqCfqJ7zMQ2hgTcHYBGBFvt37itZ8inpHKGmHB4h4vTI8+5Y9juH3i
	wmuapWSNw3dIyBgiu2pco7ZacqUfQwLbyeGpu0PQgCxO1Y6KIiBNkPuUZ+mwnggv
	Gpa5U5D9YpdXWurlsudCWkR34DyTD4krvfA/qlhezMaw22aERx9MAdw+py1N/74N
	AuewboPHv2VZi3Jywpbk+dnRL7sV7vNM849Lbenw+e4dSYU531E+76M1BqlPfLyU
	hZrnYIAJewpMqeytbTSOlA9uKVRzgrLVft5+ojm0p5AtQfI4lyhrUBt3lFWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714981011; x=1715067411; bh=Ys8Qm64J7NFyvyhUsiNOOl0vbocW
	HAmYkRcRHxIRoy8=; b=UNgjwVvktue/mDDlQMF7H2WZ9rqfGyQ3SNzxA9QW8WzQ
	ts7OWnK6eJarMeKHSJhLfpvxqzZg8g64c8tQDf42HDXLZfJEhMQRNqj6FgNDVbrj
	pKNXluyoVLWAWYZ/ed7oue/adsBCppqxizOcgBDWOxDCQ0uUiWAkUPiQvgHAvtGF
	2ogqOarecoG11pwegZj6R1YPnwkkeIdjKVLJkL2SjOjewfPgbe6itbA2Elmx0sBj
	vOEE0uAC0wp7fMdN4LthWVVIrbz3oACQIJBk5kEwvJyrQfe/NuVGoEZh9bfdfym7
	UT9w/rZpon5KooCLXRryI+Qsr7iXn669aRNKwYDK0Q==
X-ME-Sender: <xms:k4g4ZuKDlVvvGJ7OMgkfEnxB5vNOf_fbw0DPk3FZ186AjYD516YaAA>
    <xme:k4g4ZmJPdCuVqa3gYWS-8xlt2MjMl5ZTSxKwXr2V3OEP9D_SyRe2WQeVgI6X0DH5f
    7HbsgMPHqqyZhn4Lg>
X-ME-Received: <xmr:k4g4ZuswkCHIOTaGVvVSQqXhCWmKvC35_zjnQ0njVi0AwXAWh46KwNTiJGAJZtClZMZUX3xgD005xbzAq86-QtwnfwocKMtVRo-Zjai-ts468oOl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfel
    gfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:k4g4ZjZi3_1VlUFRlWUY-DwtlYv0v-VCcdYFUyBXLGXwAjEBkMs6_w>
    <xmx:k4g4ZlYZZWSlphbh3hTqwWriSpDt_OSFsZx-zYuy511cwrPh7fQNyw>
    <xmx:k4g4ZvCp_QM5riapqL9x2RzxQEA8Be-jdn9UXh572JtKV7MkH_UfjQ>
    <xmx:k4g4ZraMjNX7P4j-WTYqyXfexKpF5l8CQqFGNw_tGtpXK7p4SnQq-A>
    <xmx:k4g4ZkW8wofcA3ZPx8Xf9xi15CXfMhnGpPW4u0ElZV1Gyrc78GYHEd5W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 03:36:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0e5ba057 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 07:36:43 +0000 (UTC)
Date: Mon, 6 May 2024 09:36:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v6 0/7] refs: add support for transactional symref updates
Message-ID: <ZjiIjsGhRDHxo-vR@tanuki>
References: <20240501202229.2695774-1-knayak@gitlab.com>
 <20240503124115.252413-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S4otmM1c3nV0nUov"
Content-Disposition: inline
In-Reply-To: <20240503124115.252413-1-knayak@gitlab.com>


--S4otmM1c3nV0nUov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 02:41:08PM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> The patch series takes over from the existing patch series, wherein we
> introduced symref-* commands to git-update-ref. Since there was a ton of
> discussions on the UX of the patch series and its application, I thought =
it
> would be best to shorten the series and split it into multiple smaller se=
ries.
>=20
> This series adds transactional support for symrefs in the reference db. T=
hen
> we switch refs_create_symref() to start using transactions for symref upd=
ates.
> This allows us to deprecate the create_symref code in the ref_storage_be
> interface and remove all associated code which is no longer used.
>=20
> The split was primarily done so we can merge the non-user facing parts of=
 the
> previous series. While pertaining the user facing components into another=
 set
> of patches wherein deeper discussion on the UX can be held without worryi=
ng
> about the internal implementation. Also by using this new functionality i=
n a
> pre-existing command, we can leverage the existing tests to catch any
> inconsistencies. One of which was how 'git-symbolic-ref' doesn't add refl=
og for
> dangling symrefs, which I've modified my patch to do the same.
>=20
> We also modify the reference transaction hook to support symrefs. For any=
 symref
> update the reference transaction hook will output the value with a 'ref:'=
 prefix.
>=20
> Previous versions:
> V1: https://lore.kernel.org/git/20240330224623.579457-1-knayak@gitlab.com/
> V2: https://lore.kernel.org/git/20240412095908.1134387-1-knayak@gitlab.co=
m/
> V3: https://lore.kernel.org/git/20240423212818.574123-1-knayak@gitlab.com/
> V4: https://lore.kernel.org/r/20240426152449.228860-1-knayak@gitlab.com
> V5: https://lore.kernel.org/r/20240501202229.2695774-1-knayak@gitlab.com
>=20
> Changes over v5 are:
> - More user friendly error messages.
> - `create_symref_lock` now writes to an err buf, instead of directly to s=
tderr.
> - Refactor code to make it easier to read around logical operations.
> - Cleanup commit message and fix typos.

Just for the record, I don't really have much to add to this series
besides what has already been said.

Thanks!

Patrick

--S4otmM1c3nV0nUov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4iI0ACgkQVbJhu7ck
PpTS7Q/8CjNDb2o79U2hq4n8nfpusIlGDEDRFMhDaUVUjg5zu0m5h1eXS/jzfwB/
TNLbryMei8YytRLTSwBIUOwuo31xMVYKAkMkwrvg2uiCx6K8dGPDdGxg9KKyE82Q
w/aZ+qOG2PDxpiq5ACHiukHriPSJ3bOj8oC8tIkrnwhn24SKXRbqNun2WJDQDaXK
zZ95BgRnX/4u1Q25j7egWd3zoN1zD9As+KH954PH7sANwZ5ZatzZaahYTAcuE65E
FnAVBZkDU2l3aSdGk3eAwaT2falyHUzyYKUU9MZCoxj+4WsLpOWWtmDJwSo8kXgj
rePJlCW7gW454wvocYe98bk0xPxO+kPsLTHTZ08bT2Am9doYEQaM/rRkon4k20cZ
T/rYiO44YSBNNRwS4y9sIpTuXa3UsP8ZWmc+HfeCsyw/ANfs+QZUsHmftQZwSCCz
1ALAVSDEJyMqx0FBnIDHUaA0b8w86seybzBqnwluRt5VfX5jySB26TWt7y0ytbsJ
ztl3MQ9vEiHENWPiIAcq8jOtjWnzkA3uEh6gp0lEns2sMnXdGGOF6gxTD7IYwsjk
dAlWc8q8kOB5j7eSNu6l2daHjj/zzfOrWPY6C3jAv8DiQhd2ZFhD9aG2rRn3xFqH
EZkw5B5pYqrX6Gqn7zorA/1NFKy1SHX3TMh3ts6LLzGDuU2OCi4=
=7Het
-----END PGP SIGNATURE-----

--S4otmM1c3nV0nUov--
