Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C010E5
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564612; cv=none; b=LuaR4huOnA35cnAn34lhEAxlQQWhzusYsyWvakh3/2+65uDXnMFRw7y560Si0sSDrYvYHA6Vi3DtKViZ38jRtb0+N20IaLllOKaI8X1XwL4Pqm4znoZ9qBPDnnw7Adh1sAkGjIZn2S/ZqWQwgY8u1tFExMF6iMcfB4z3/nNweNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564612; c=relaxed/simple;
	bh=CxPyvWfuyLlNiHwvbZQr/fXY05PWDNEKsEKbzVqwnyg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M//c5fXE40TuwanfI/NnstbuxdIiTFm277CoLdtbbceYJUQQJfkaeHrGskcBeDbm6b4nhUvXQYCCk7ST/TZbKr5HQV4cy0lMCLMNPGmS2Pr+kagtpbHzKcgHxxKt3B3ANRKQH9J7mdBOvcyVWI6rmwXRWfRrzCfVnhNQV6kT3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=akPJKPAW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lcAuMeX6; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="akPJKPAW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lcAuMeX6"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id A34B21C0017A
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 01:16:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 05 Jun 2024 01:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1717564608; x=1717651008; bh=ONcLAkGTZhoBOJxZK6LnLLMyDSz59FXY
	KuGf/fBcoRY=; b=akPJKPAWQcmjzU6kADGfdBFd8yUCpU8Rw0XJxClag9fDXHIj
	Fwyrt+rF8DMsFVyqZ4ML23+FBwabD+wTtxUOYr65tLCTwNXmFA3vzS+ynWAxoEmW
	FNuzN0K/LJ/Qww+rcGhLRDqN+pF9XMwzeg2Mt9k4xlngarriCZI86mJp1DRrzuN9
	Tbc5d+XN7pLhc/NwKGN5PheaQLa4qj8ycauzF5HOMiiKTRQIyufXK3SYbdL56GbI
	bUbPLC6MiLk/URz/Q+4y0ZNdQ/CiWZSdbkA3z3UyWDAGfwpyhCc+VLXLAOaJMt+L
	QfTexH3GWarA45aSAGxgYu7r8/ajRe2hVDBK+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1717564608; x=1717651008; bh=ONcLAkGTZhoBOJxZK6LnLLMyDSz59FXYKuG
	f/fBcoRY=; b=lcAuMeX6PMzhbDndJ5kfGFQfL8b4uCjNbE18g57r6kIg/rhP+w0
	fpZEKS6zqn9AKAmb473TUuURAIaAlPJT5bH6+VbdcY9frTEbpYuUnCXZ5rgKVbes
	UCwoWKJDuy8OJQUfrYcboSU1OMsxX2r+nzdFuQAPxA7GlX1eVjTxJat6PhN8+sW0
	dsOP1lcEhHOzzNBZ1RVju7aoHOxOE5xzjTRlfjS2vl45wh1E0byEcS4UqC9b65/S
	THhYKxVIY9XxpFJlaiBCIFo8o1bp5ZCQ8BQGmySWRDJ4L3xIbKoHdPORW54vuHr0
	F72yk74XPG8PnRKkTRv0V8qmTD6v6WQ8CSg==
X-ME-Sender: <xms:v_RfZvclR8cM08Y9Rb4VNAeMJD19YkQB5bNpQ6Z6wUx0ZOzJ11RdLA>
    <xme:v_RfZlMwET-mvZNRVi1BpA7brb1t4t-LIL7XIURGS8WKh4Em4NMS_m7ipLBcGFWta
    i8_LMZLZ_UOWP3MzA>
X-ME-Received: <xmr:v_RfZoh9oMnVJNuFmh14zEJ_MleWYlvJfSb2jsswFSiyDFJMVfV0WNbWzCz-ljdEgXuVLTRbQyUCMU-N3NmNF_gLNRE70BhREwj33JNFkKmfdnNLico>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:wPRfZg8PYfjBMo2rXnAFzwCT9scLK5voLjhxwIJaXQ7FPFuTUcXBQg>
    <xmx:wPRfZrun8hTwNAx4IlLHwj-JJMGxi6zEun3P7TN9SbmrkiqDWqvMhQ>
    <xmx:wPRfZvEITjnx25leo3R56xWqfMXtkvBOGbEyHOaxiGHvj8NGMPI_fA>
    <xmx:wPRfZiPmCzGaEClsopB3EbafjRuuX7O5YG4CUzmxNkY9PvPDMOW_lw>
    <xmx:wPRfZkVNX-ZfBTpeWdxDe_bfJ4PDuWxSGHJlopHpENpX0HOvwWKR9xgT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 5 Jun 2024 01:16:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 01b12cc9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 5 Jun 2024 05:16:16 +0000 (UTC)
Date: Wed, 5 Jun 2024 07:16:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/4] Documentation: improve linting of manpage existence
Message-ID: <cover.1717564310.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DKvpu/23JU7ha7M7"
Content-Disposition: inline


--DKvpu/23JU7ha7M7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

in [1], Junio noticed that `make check-docs` was failing for a recent
patch series of mine that introduces the new git-refs(1) command.
Curiously though, while the checks do print errors, the Makefile target
itself succeeded and thus did not make the corresponding CI job fail.

This patch series fixes that issue and also refactors the infrastructure
such that it fits better into our existing set of linter targets for our
documentation. Finally, this series then adds a job to GitLab CI that is
equivalent to the job we already have on GitHub Actions.

[1]: <xmqqjzj9czop.fsf@gitster.g>

Patrick

Patrick Steinhardt (4):
  Makefile: extract script to lint missing/extraneous manpages
  Documentation/lint-manpages: bubble up errors
  gitlab-ci: add job to run `make check-docs`
  ci/test-documentation: work around SyntaxWarning in Python 3.12

 .gitlab-ci.yml                 |   9 +++
 Documentation/Makefile         |   4 ++
 Documentation/lint-manpages.sh | 107 +++++++++++++++++++++++++++++++++
 Makefile                       |  36 -----------
 ci/test-documentation.sh       |   1 +
 5 files changed, 121 insertions(+), 36 deletions(-)
 create mode 100755 Documentation/lint-manpages.sh

--=20
2.45.2.409.g7b0defb391.dirty


--DKvpu/23JU7ha7M7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZf9LMACgkQVbJhu7ck
PpTPrw//ZsJD8lnZQEMe1MFKeZgrorn7YDH6HrUAmp5EFGa3X65/zcuBbfYO66I1
Xte6CXmhgv0LKj96yh5ntI9KXnaSWeBnnfRFyGIjh361nUQeZtDb5Voz+RXu8tkE
KcnLt7bBoZjghWhRDYk3AOphp9oV+ViwCuudOh1w9IvXf4KlUWsUC7bOvqRi/kuR
nQhZR9WfdH2Tkc+dlz/8C5C5K3/XiRioQo4yA190zZIZERJ8paIJfrLETYYjszpS
RxPOtnJC+Iv/Q01snwK537Dk906PoeRR+nMTub8PwdUIXfo/3MyOEg2vLOJdVkrh
XP6qTr8YISrYC73kgvyticT6ZnwZ51OvAKXqlD0VhuvAZWywRjyiSxIWqLP6E4zc
x0x2dhlL4zb8EaWxUHFrdOWcCeTDLwh/3uWYv8cbjIKbcn/ukFB0CTNtqkfVf7tH
WjH3hzcgV0KNi/CJPBvajUL7IMCXR2VikOBxivvWmsdNVFoMIAJ/hfJn50wu5Dmt
Tfmvuxk4+5fPR9COUMzgWnoo2Ba+o8CMeS3UkB7MPVk+MqiZh/dENY48fivV+9Wo
zaVn3QFeKsYL+ClZjj8if9KNhOPzOkJmevkH/CCemhA6GO+7XcmG2INTFZBPi0X8
eC9heJ6JjUCBCFs9Qpys+CsHjHhc1WPkpwevKywYlVttqezXCpM=
=eDNK
-----END PGP SIGNATURE-----

--DKvpu/23JU7ha7M7--
