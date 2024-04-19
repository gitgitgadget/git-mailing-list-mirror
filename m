Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1877F49B
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520304; cv=none; b=qy/+r2botO0UzleREMra4sYFWpxraNuLgjJf2eDDKb43lELAawHn2fzcGvZINvcsvQLsUmxykJyXrNoMXrFtje2CrygmpelMUtnqlJG4/OvTQbKRuvan8gso9U1Mb+9avydn4yUO0EHiqyEzuUGlEKOi0zPvzZyWIJ/HfPgvLuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520304; c=relaxed/simple;
	bh=7Eqtdk6lGd46dee0fWUHtgqfzuWnFppKS0flS2gaSQ4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCimVZfj2y8fdMkTglAszwukMcGdpufb8uKSLTLM/VcSmfLCk562a9e3a3H+xEMnPITiShYHelXgtxarmPpPW8lgpbMi1/OyZy6Y4Z2krTX1M5FfZSxSSyXcd9cacgKPm2G0zT2UmDy0rtFilk/y8+B7JbtTG30OCH9ewcAsz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g1lgUQSv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PcVQpsfk; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g1lgUQSv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PcVQpsfk"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2146118000D3
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 19 Apr 2024 05:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713520301; x=1713606701; bh=Ws+Icsa0m0
	o/RElShCPyupFZx1DnlkfPmgMhf+7BEqs=; b=g1lgUQSv+YaHvRSujecjpsBFLU
	CsEMFgda298An6Hn3uii0E64Sq+RHSZwwnhJ9Hmhj1eo2HZGEPZcsl6yjgXUg0QA
	s1lzQys1erIkGAWtegHHXHz46xZLUw/dW8x97qgTVJ5duQkLdyioFzDICzIbOktq
	1IL6SAVDmkrUDHXdyYK93oh1X1jZOsemD1vgUXC1VuOhxTqjZ+vuoAm7zulSn9RC
	TatccP6AN0zRJA641AFaVE16I1jzD0JbgsL6uMyjl5XEL6qM0i+2jx4O4N862o/0
	CYGgA7nqxvgtUsNfTqTH7xQgFyPL1pyWicHe824ZYCfAgDw8rdGKkfgPY6iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713520301; x=1713606701; bh=Ws+Icsa0m0o/RElShCPyupFZx1Dn
	lkfPmgMhf+7BEqs=; b=PcVQpsfkBdToHnkVo4Amxal6CEvF1zj7UlxHMTCo/5G4
	pR9ghhwWPSxBB9htliT2lY1tpZ6iO+MaUSq4UEJMJhyDGVdtiwyzBgi/W8B93e/l
	XChQAaSX7F4+SHnJPNJcU/49Ogx2msYJcpkATKUZ1HXzr81gPwXT0LlJsWkZnyrZ
	ayqjZAY++LoLmICYiAQiK1NJbOHMtxnAr26/8ESCWXni+i5zu3lFY6RjpVMRbvWw
	Bs3c33CGtUMG/tuVmSSigaEv23Rgtx6QzY1gyg1MWPg/dxBJhQpKEtac24Zm4DwA
	mopBtszB+jeagVPIwP03DQBsHOEqQHb2vJ57gHuNMg==
X-ME-Sender: <xms:rT4iZq2pjyEroxQrWmlHqjBL-c7vjW1Ie7daSbkRnGY1s-y9Ez-Yhg>
    <xme:rT4iZtHIDha8kNGhMC6OOeE7meiQj5LPHUShdlBDr8j7dtgVjBsuOaRFPoC0uOc_r
    aHCWg8iM4jWombc3Q>
X-ME-Received: <xmr:rT4iZi6fwwKdG-Boq37HZNsc2Mnn_k_iDrrvN8g3ql6CBqtdVNPxJ35QienEZpCH59-s9PKwr0gANsinbXPFM9Q5I59rQA-P0HV-V-84pxYVcONk0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:rT4iZr2GmdVjjSqgjwqnoShRxuGNVoZ12qkv2GtA-RNX5uQ7Uv5KrQ>
    <xmx:rT4iZtHw6zkedvWEWDntQe3cCS-KWpMojMWpv0IDQTZO-Yla60J6Gg>
    <xmx:rT4iZk_rY2Ne-Nd-NnmHkg20qW8EPdL2SJ_u231LNfkjxmklIDJ5VA>
    <xmx:rT4iZim8Zfj24N2UmBIylaaWahbFy327nm38jgHZdpTcwPzk38ritw>
    <xmx:rT4iZrPMIdsatzlJdotARAI9KyhgPzsYvsdHcw4ax3OLbXe69kDW-mXr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e83b718a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Apr 2024 09:51:14 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:51:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/11] builtin/blame: don't access potentially unitialized
 `the_hash_algo`
Message-ID: <e189a4ad15f45906bc96cd9d3372762bad01e928.1713519789.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KgcyMCmha2Vwe6kG"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>


--KgcyMCmha2Vwe6kG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We access `the_hash_algo` in git-blame(1) before we have executed
`parse_options_start()`, which may not be properly set up in case we
have no repository. This is fine for most of the part because all the
call paths that lead to it (git-blame(1), git-annotate(1) as well as
git-pick-axe(1)) specify `RUN_SETUP` and thus require a repository.

There is one exception though, namely when passing `-h` to print the
help. Here we will access `the_hash_algo` even if there is no repo.
This works fine right now because `the_hash_algo` gets sets up to point
to the SHA1 algorithm via `initialize_repository()`. But we're about to
stop doing this, and thus the code would lead to a `NULL` pointer
exception.

Prepare the code for this and only access `the_hash_algo` after we are
sure that there is a proper repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 9aa74680a3..e325825936 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -915,7 +915,6 @@ int cmd_blame(int argc, const char **argv, const char *=
prefix)
 	struct range_set ranges;
 	unsigned int range_i;
 	long anchor;
-	const int hexsz =3D the_hash_algo->hexsz;
 	long num_lines =3D 0;
 	const char *str_usage =3D cmd_is_annotate ? annotate_usage : blame_usage;
 	const char **opt_usage =3D cmd_is_annotate ? annotate_opt_usage : blame_o=
pt_usage;
@@ -973,11 +972,11 @@ int cmd_blame(int argc, const char **argv, const char=
 *prefix)
 	} else if (show_progress < 0)
 		show_progress =3D isatty(2);
=20
-	if (0 < abbrev && abbrev < hexsz)
+	if (0 < abbrev && abbrev < (int)the_hash_algo->hexsz)
 		/* one more abbrev length is needed for the boundary commit */
 		abbrev++;
 	else if (!abbrev)
-		abbrev =3D hexsz;
+		abbrev =3D the_hash_algo->hexsz;
=20
 	if (revs_file && read_ancestry(revs_file))
 		die_errno("reading graft file '%s' failed", revs_file);
--=20
2.44.GIT


--KgcyMCmha2Vwe6kG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPqoACgkQVbJhu7ck
PpQJrA//ctYabqw8Kq43NC+v6qoHT9rYnbYOKJoxfv3zGYhzRt/kDQ9VfDfJpXmO
9IUHOIn6qaJaodKcS1tTyLICGvE1MVtHhlvUnkvR8EVWFoN4ZXAdnGCtFOGcJq82
0yhF2xbNu4H/wY/jeaKkfaRUx6/64bR+4jTRONbz03WrYKJR5W/Qf/Mg/zFSTIpU
V24/NwLlpbJQNSPbj9uckH2nmIrMyIpItbsvRU/JEEwi6tXFA6EOeNvNQyHnf81s
IrrZ0+qLCx8TUrM/MUnHxYdCFWfu2H0zCYnnXnNTmQwInNncXckngvybbAbGF7fM
86jqfhiM8ULDQ6VDRrtyh3+G3/M1KtnNmdPB8rwkdB7BJ2u/AoNUgfiFW3olBpiP
M4PkR2C6m36Zb4BBILhiycCKXs4KDYghIsL+AdeeZ3+VZfqbyiXWtOQyivRUQRRR
pV6HiLW9DIMrytYYKQFHZdv6lUCOzJiP6DktMLSqPNT8ljAnPF2HtLIZrDz3vmsQ
b6AztqIAeCIsVATkBMBjqdTkLkEZW/2noEnEjD3Jj/OUwaaayDE69JLmntqYBq/X
sa73ee/l5aqu/pyRtoOakGio88Nf7VcCeNA3JNUqXW5cuSYw62rXCbHIHX5UAQA3
xrxBm43nGpIOny9MlKHTdt88TIUYVntnBCp0XAnemcwbdC8IYfI=
=sf5Z
-----END PGP SIGNATURE-----

--KgcyMCmha2Vwe6kG--
