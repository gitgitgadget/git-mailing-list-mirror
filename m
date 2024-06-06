Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853D5328A0
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669790; cv=none; b=TOAQo3zKGzYQJPEOXkDD0tkkOynAw7tgcFLiyoz1MD3RfnrGUcgBFkwyzVhWYcdt+OnnmywLeODu8z13AQJxq3ZH5M71Ep3SEK3+x65YNshSaUQ7BMd+fIbjo9FFSPoje/Pr5+3Pzwho2Ylv5f6JgSOlUHqFDovLBU+3Kw31Vpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669790; c=relaxed/simple;
	bh=W7hBEfczXaMe7CufaHD4Sbcg9bt+yYviCHc/cmocCGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSwt3fFFFhCjNaftft2YzjXsbvzvUUiIyDTPYvrF0nnqEm745+wxSKsHg6H81cRtSwJV1Rnlshq299+YErQv8zYpnwGW0dTSosRi4+lvvC1r04i7AqbFZvZZge/+Q2poIAAH9gilghUNGjLcwh7BxODmvJ8hjypGE9jIxZ1OKkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hrj/Krhb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZC7F7XT1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hrj/Krhb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZC7F7XT1"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id DA39D1380128;
	Thu,  6 Jun 2024 06:29:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Jun 2024 06:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669784; x=1717756184; bh=SJOGYaeQjk
	lM1+HqDBQLqe7MiPA38vSodnMPlHpWjz8=; b=Hrj/KrhblSawvC+8T3Z4s6SFY3
	z0MVpMWKB2mXWRtHpWmE27hk0Zi76W/XyxiqghKSm+1SZ+KwD1zxw50Bl4HtsI2R
	O2Qg6+BvYQjVY/ItcY41Fr4EVjL4vsPTbwE4xh8MLU966a8hwdesA4yVFwOz0fke
	li087rJ8ICk5t5169OsK6XouCFQyoGGGOKWJL8f16IxXdbHQ5kj4Qf7g5Hn//KNj
	mULZOj7G6lbhT44Bq/8Eu5csYFw63TZvrbFMPO9Ve/Yw9GIxOzI89mZStx+7ICv3
	OJTPVbebqvFgLQboBqcGI8U6eok6NfVTeCL3YXZT3bg2C4H4n8bF5fJxdQOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669784; x=1717756184; bh=SJOGYaeQjklM1+HqDBQLqe7MiPA3
	8vSodnMPlHpWjz8=; b=ZC7F7XT1VwhvO/Y8C11YUbOeVC6X6ySS/lq5/wRW5/YW
	+B7sURX4AR0es3vi7+aOM5Dtdt2J0k6BKzy/PXBoqzU8Z8AXy3nw+4+ykePX6CYd
	dLAEcnYgnxAfXLvzIf4cFvqErOMcYXUd66awdGbeodvAsRZ1yyg5Bfd1X9Q8qfuq
	dqoRfuwJKztxmjZ+tAOrRT3xnaHeX6fw3us3ti1ywKYcbC29wGNy8+H+3cwxQjXT
	NKfy3YMMUuNVFhnw0w/KHYcitrG3VQA4U30o4dgwsRM4E51bfdybuJMTRRU1gem4
	TdzqcGj94sKkvJxCwYoaoA/U9Ny4SUjvYH5kntXpig==
X-ME-Sender: <xms:mI9hZls4t6UPxqzpuEspC2zysQWDeOWsSNzGr0mKLLUNJZcPJJU__A>
    <xme:mI9hZufcflGsfcUOLd1AsfbwCB67UPMyYTEYYTKB21YsmrrBkgxDGPA6o-KJbPZ_k
    kaxgM8NS0qZ_1bM0g>
X-ME-Received: <xmr:mI9hZozwz5seou6Cjj8oogHHOeL80ytvc3xSk70kr2CaEbXZNN7_RQuhn3iHmmNf1IPa05W1uSTmgicRb7muWivw3eMdF5ICfIHBlp3hVI1-4eCR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepgfefvdefffefvdfffeduiedutdetgefgudeiuedvfeeitdejueefueeileeukeef
    necuffhomhgrihhnpehsthhrrghtvghghigpohhpthhsrdhnrhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:mI9hZsOfmpcYUmS2-V0QIWE92AIp8BJrZn5G0Fdquuc8WD-dgks0iQ>
    <xmx:mI9hZl_8ZhZv4b0mxmQcY9ZHOCi5OoJDJQ2Mvyomdr84MoyVtWLAYg>
    <xmx:mI9hZsVqEZucbfLHAG9fcfAd8X6yaG5iCbTXssMlr6zkFVYTD-PEKA>
    <xmx:mI9hZmcFkWLLRXDPwpNTqizfQAEWuNRSaOoSjCT22Exa3NCk4LAOQA>
    <xmx:mI9hZhY64dx6IyB9l6RHVU2WaHdWtakbnC-qK-UdCdL81jcOp4UqUaGt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:29:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ff821756 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:29:13 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:29:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 25/27] builtin/rebase: always store allocated string in
 `options.strategy`
Message-ID: <6819bf6116f0b5f7a57263a9564919aff695267a.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uufSXK44+EFsZb6F"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--uufSXK44+EFsZb6F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct rebase_options::strategy` field is a `char *`, but we do end
up assigning string constants to it in two cases:

  - When being passed a `--strategy=3D` option via the command line.

  - When being passed a strategy option via `--strategy-option=3D`, but
    not a strategy.

This will cause warnings once we enable `-Wwrite-strings`.

Ideally, we'd just convert the field to be a `const char *`. But we also
assign to this field via the GIT_TEST_MERGE_ALGORITHM envvar, which we
have to strdup(3P) into it.

Instead, refactor the code to make sure that we only ever assign
allocated strings to this field.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index adc990b55e..4506bae768 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1061,6 +1061,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 {
 	struct rebase_options options =3D REBASE_OPTIONS_INIT;
 	const char *branch_name;
+	const char *strategy_opt =3D NULL;
 	int ret, flags, total_argc, in_progress =3D 0;
 	int keep_base =3D 0;
 	int ok_to_skip_pre_rebase =3D 0;
@@ -1175,7 +1176,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 			PARSE_OPT_OPTARG, parse_opt_rebase_merges),
 		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
-		OPT_STRING('s', "strategy", &options.strategy,
+		OPT_STRING('s', "strategy", &strategy_opt,
 			   N_("strategy"), N_("use the given merge strategy")),
 		OPT_STRING_LIST('X', "strategy-option", &options.strategy_opts,
 				N_("option"),
@@ -1484,13 +1485,12 @@ int cmd_rebase(int argc, const char **argv, const c=
har *prefix)
 		}
 	}
=20
-	if (options.strategy_opts.nr && !options.strategy)
-		options.strategy =3D "ort";
-
-	if (options.strategy) {
-		options.strategy =3D xstrdup(options.strategy);
+	if (strategy_opt)
+		options.strategy =3D xstrdup(strategy_opt);
+	else if (options.strategy_opts.nr && !options.strategy)
+		options.strategy =3D xstrdup("ort");
+	if (options.strategy)
 		imply_merge(&options, "--strategy");
-	}
=20
 	if (options.root && !options.onto_name)
 		imply_merge(&options, "--root without --onto");
--=20
2.45.2.409.g7b0defb391.dirty


--uufSXK44+EFsZb6F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj5QACgkQVbJhu7ck
PpRgnBAAnKweFgTweBUkwfVdsLsB6ZtqoTDuvbeMFbUAh+EEaMPHOUElX9pvm/8v
MpnNf8PCsZ73tMMJm0pCUAimAeboWafKmDvX67CisPzBUMxfYUE86qLOqzYal6eh
j7Sh8IOcD/qNqLzOJHUFcDK55XQYOXzjblol2tSydDK3Qwx0wGJ8i/N5gcE1P/P8
pYBClgWr2mVDtncUY2d/C/wuj1NiJ2v2rSMGsUbuJTnl726Cwd+QJWhBe6uiconE
vpvdjICoP/UIFiGe8ZA67Fzh00kbzzSoGf4SWRqQehFzxGvFIgFoiuRUDG3JagQF
YP4jIxOcjNUgNtVoIPx0m8ugvcEmvZ/XhK7otZ1GxVFPDDWK++sVXqkbqmI3VnUr
V1TvqqUgbcGfR2F0dRwc0RJp3/3nQFoaW4h1tT9lTaSg7ZrBjo4Gv6EA/VzC3vmK
TfTVDNIslyWmnF7CJ4kovQ1eWjQ4IqPyw9IGj+F/iPftlMYz76ja+y13Rw4Af20i
RbttZMAbbsCJ8rGg5vhDawhkFgD42NydizbhANT2niYMkw9EGZY4xsQIBmVJafg7
b3BjSepiYYtps/vGU2ryWxEuHoKaHEZovnsAYqOP4XbODweIM63tnmeNMjPo17i7
y+om1pxkGtrtQBNkIw1XeV+9ooQC9XNw7jsEDOaMl5NdNP9CATY=
=u4Qx
-----END PGP SIGNATURE-----

--uufSXK44+EFsZb6F--
