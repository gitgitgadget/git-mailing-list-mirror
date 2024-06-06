Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330BF18C33C
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669713; cv=none; b=ZyMgtiP7oymOjJ+6LLSMCKNaF8PdKroKFMtsUasSHgj9sZ6pX7adKrxIiC7UY8ZEJpV6pMRkTwjO1yYqMNGyInGxCDDkef6BXzls/LprnfAWVdQ85gkUv5OU49kb9i9PyJUN9Chy+ZJtQehon6ifvnrTZgcm/EoOl5ZrVwqOYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669713; c=relaxed/simple;
	bh=Xo0JqzHcccVUwtbk347d4E2TGAki9TlXvJ5Q6SiuJt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSj+TthWS729IeBqOxkmHV79XJt2qcgbThrBoe4SmNhg1vfC+CaMe9RpHGJiyh3ZPtr45wakt77OxRl2lNTIk2jZoWXZTU+GXfCclMgCVPmJnTFbZYDo40EbxZS/5E7BmG2cN8gePrTPqglRQ9GVHDSeuurbujfQ0mIbYGyYQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ORAxdxvs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kIaWuwHi; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ORAxdxvs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIaWuwHi"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 84F6311401CD;
	Thu,  6 Jun 2024 06:28:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Jun 2024 06:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669711; x=1717756111; bh=OuTuMeD0vQ
	XYic1EWShu8V9Jr9hfJIiusFWdUuQRLKs=; b=ORAxdxvs0fMl09UmxAS1nDrneJ
	A6YCpGf3eHUF7vvpJ65pEGo6Pkj42oUFdaWQY/5VHK3Y4KkmOxxQDbcTbMHXakmA
	OzVJOxh5kVHZphIeGe28LeQArZhxVAFclmAh7PX5U8rdLteG0VsbdtSqQCPz+rD2
	G1O/nbpcLUsucKVrGSksJz1/rEcHJU0qEeOv0eujL75F0FoB33TYi4ZDKvNQWsKB
	q3w4SbojTOR26TXVWbfRZHjN2qLSG4pYG4ZhRX0l6S7Ov4Bpyq3rnMkK4MM1jegI
	AqI4/oipE8W9dclCtK+tDFzLMxEqrSo7yyM4CEx45hbXXrNdU/QZnIJFLeeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669711; x=1717756111; bh=OuTuMeD0vQXYic1EWShu8V9Jr9hf
	JIiusFWdUuQRLKs=; b=kIaWuwHiNX2ahHhhJrag2mDdwXUaSq/3EwOTJjkw52kp
	MDIvjIDbyuSeuJEXF5QRaCbJYZDM/kkswWij6Z7Mst8I0xHTU4dgfaos3p5u/niv
	bwKogkq8mKgg5PHxkn3cTBTROV0tTroBXjK50kAu5LWcur+vA+voXTv5r4ZqKbF/
	QsW2EEjVFC9+rWjWcNA3VI/MGmdVTA/lckGizGXkUjVXt34/ILROozRtmtNCac5K
	efrGVi9dGp8gs2SfOX9emxeSshFjD585h8CwBH66oqhm8MLuKVs2GLVoaX73OfSy
	bWAC4JQt9pmI2lq2sGc1E0HO/GeKtUpLfm4Fpammew==
X-ME-Sender: <xms:T49hZirC1SVk5umOCH-KtaEdn9GBcQymBG8-Nyv7lJ-OVFd5cMEuJQ>
    <xme:T49hZgqEI9uBGrK0pKdzDueCIyZAiTvDJRqfFjHoEnrOCVHY9D3l4joLh6PoHdqix
    iDtYLeqAES0-xEW4A>
X-ME-Received: <xmr:T49hZnOMWJPooR1QTbq9cHk13FEzmnVyr7fllXYCBF-72xU9WUuI0J--P4qDK5i6CeGOg5DvQTf1A_sMrJkznsXsHNKuG46DX4JWh6XAs2LmSOx2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:T49hZh6LysPzia9hv3SmitsjfDBZJo2e_JCBQaQ7-v1xjPRNFQPklA>
    <xmx:T49hZh70Jda215LIU77Gt7sz3HdU0HoRenixTOaRoaDzaCpR262Ftg>
    <xmx:T49hZhiBCthiBr_E5IFzUNtIPXF6oreRJQZebetgOQKhcKem9UmT-A>
    <xmx:T49hZr4YMrF5BiOY3dIdkevn3Sk0EnrFZ31mxkVSzRssPVqkMTSbYQ>
    <xmx:T49hZk3BOt9rpnNCWO6sMWL1-Wc7L3MJYnNFgkipnbrHnKYgmk8YXUun>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:28:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 61e188fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:27:59 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:28:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 09/27] line-log: always allocate the output prefix
Message-ID: <b717af02f0958b0c204164ba92453ea7845186b7.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xYxF2tr8ZdhU/vqO"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--xYxF2tr8ZdhU/vqO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The returned string by `output_prefix()` is sometimes a string constant
and sometimes an allocated string. This has been fine until now because
we always leak the allocated strings, and thus we never tried to free
the string constant.

Fix the code to always return an allocated string and free the returned
value at all callsites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 line-log.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/line-log.c b/line-log.c
index bd3e663c24..67c80b39a0 100644
--- a/line-log.c
+++ b/line-log.c
@@ -899,14 +899,12 @@ static void print_line(const char *prefix, char first,
=20
 static char *output_prefix(struct diff_options *opt)
 {
-	char *prefix =3D "";
-
 	if (opt->output_prefix) {
 		struct strbuf *sb =3D opt->output_prefix(opt, opt->output_prefix_data);
-		prefix =3D sb->buf;
+		return sb->buf;
+	} else {
+		return xstrdup("");
 	}
-
-	return prefix;
 }
=20
 static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data=
 *range)
@@ -927,7 +925,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, s=
truct line_log_data *rang
 	const char *c_context =3D diff_get_color(opt->use_color, DIFF_CONTEXT);
=20
 	if (!pair || !diff)
-		return;
+		goto out;
=20
 	if (pair->one->oid_valid)
 		fill_line_ends(rev->diffopt.repo, pair->one, &p_lines, &p_ends);
@@ -1002,8 +1000,10 @@ static void dump_diff_hacky_one(struct rev_info *rev=
, struct line_log_data *rang
 				   c_context, c_reset, opt->file);
 	}
=20
+out:
 	free(p_ends);
 	free(t_ends);
+	free(prefix);
 }
=20
 /*
@@ -1012,7 +1012,11 @@ static void dump_diff_hacky_one(struct rev_info *rev=
, struct line_log_data *rang
  */
 static void dump_diff_hacky(struct rev_info *rev, struct line_log_data *ra=
nge)
 {
-	fprintf(rev->diffopt.file, "%s\n", output_prefix(&rev->diffopt));
+	char *prefix =3D output_prefix(&rev->diffopt);
+
+	fprintf(rev->diffopt.file, "%s\n", prefix);
+	free(prefix);
+
 	while (range) {
 		dump_diff_hacky_one(rev, range);
 		range =3D range->next;
--=20
2.45.2.409.g7b0defb391.dirty


--xYxF2tr8ZdhU/vqO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj0oACgkQVbJhu7ck
PpT5hQ/+Pw4fasfVaTcm7bUTQczJRFSnRhEYTU4ZP3dj6f3Hj7lz2ZSyl468DQxk
GbbFrZI1KCeeLx0WGcWZ+2p3GE8x+Ea6ge4v014Kamwo1y7aHfujrRNqSiuDN4Fd
27FqTjDdYpoVYQ3kUrzjF3eWP0tGwXO6+ThdckT7q0wesl9ZtVz7zYsGn8UvUz+c
P4kLdTgw4lXxLABV1CtOcT5kRtfkBXn5mm9I119CFL1KDD+41cQuGV1/BJonZtzg
Tf2WkJEqLdS6g7BLDM16PN8N4/zdWOjvGsrDmDUnPDIm6pEx1+byW2gi7r/ha04m
FF2ZqAPISTIS1KhfUKbDljak57n6tH+MAhQmaY7OG0FooArx6Fp7THBGgidyuotP
MMikc2+3XoeFrulUzbtIzfH3cwQNHbhtOdUMOyKWC3rie3OFIrCMbY6UVyewPeqV
csZ0RZY6VcCIBInvN5J7/3BOl3N786RoTs6bqQH69QAtCHvQE1+YjPl/vlPtrhlV
INv4ktOGQuCP/nNUUkPN2dk+BFa/p4ROv9WoIU/KJ2ewYQa47Z/S0Jbzwmdq8jRR
4LS1bJiamC7sFqSEX6OmOaw9WHuX8wF58WgsqLIe2zc30ZPx+kWDdgxXGO7ENj2J
Po7sydLCSfpY1EjlXPGXHce1o+w3i+5SxZdXdxfQfA62ZgwCT6w=
=VvEN
-----END PGP SIGNATURE-----

--xYxF2tr8ZdhU/vqO--
