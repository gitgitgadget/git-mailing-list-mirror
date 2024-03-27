Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE536139
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529229; cv=none; b=IUzhVawKOGzAHNeEYAGmaENRWozSflhAMV8+Zwv0Ao6cnHeTSGF1kq0QlC3DQBek9ZqhZQOqiCFk3a4bG5K18OFaA/dFrNkxA2CQNY2akhTNhYOjM+PSkUPMMflGIq+RPUa7FCboZvDFVa2j/CXwZHQ5LJquA5nwq/juGTztWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529229; c=relaxed/simple;
	bh=LU0uu5/voFOFQ/1LLQK2T/RhNNr6j2ZhN1x3lbkmTTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3CQVATpRVryZ/XzhInOKymCqJzCRrmLhh/rplX4FwAnSYJX1xK73aUjVN2r2JNfMjZnLqxVvYWNpea4opgkx6w84DjLSIYyXPZ/uYZgmCuTbmpPaxwf6YjJgeEFT2HvD96S/qCvTY2A7T0Kle6JOjIer8RfzlfBmbNrEht+ErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KP9uR0Ol; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sEZ1E6vD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KP9uR0Ol";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sEZ1E6vD"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id B9C74138015E;
	Wed, 27 Mar 2024 04:47:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 27 Mar 2024 04:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711529226; x=1711615626; bh=UPE/s/ysUt
	gvuixHiyTXOeWSosJNsQ+lvFIcNXYp030=; b=KP9uR0OlFjp39QNVzh6zoxNylE
	wxnivzcw2fKjhtCsXGDJ3gTDkA4Ul6qbfUcyX22DUlokapk4XCG6frboUPewdVbc
	/QEIscFxUnev/u78Y7o5WqgYJ1KIzUYMhkiEAReM5ipYvG2YagC2X0fhpPHN3gCt
	c/uenAOu68DO8gxJEvLzVi5hYnzzMVuOsqs8yESzfaSrX5bbcXVMBZ9tvLIrf9o0
	dMfU5tsc2YRk0bhwDi4TPoUau9LPXw+gml6i+45irTS+/lFnPn9WkjtHsS75UfOI
	8j1j1hssjDCn/C1ktnnaNbGlvRGV+hX7EPhTapg73/hmEHr3NwaOI2HCtUSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711529226; x=1711615626; bh=UPE/s/ysUtgvuixHiyTXOeWSosJN
	sQ+lvFIcNXYp030=; b=sEZ1E6vDC36scqffdH4TKUGDccett0pYp2gMSS6yplZL
	OtsVNHv/iV+vQPdR2nZuDYx+keta3sVM14bYS0ygxhIJY2liCC0+qENS9zqJ/tGD
	YxvQBEQzumGSYewUBdUTI/fdU5B1UpTcRD6/YfzGOVIcB6hlfpyrL/l9aJXN8Ehg
	9mIRRgwb1ZXN5QEih8KCrGwCCz75CSaivo6xom4fpEM3InHLYjzizCZGu86959zv
	HB/X0B8ytbd76zASeFCDtGS9YH3IKtw+lwm5c47/AOY8GnXKx+fwV1rNJra+nNxs
	evi7M5ZjCICLO3qxzSqSnYEOgtvcT0wEQCXsicKXCA==
X-ME-Sender: <xms:Ct0DZk6_S_ymqsoq0m708Sd6b-_m9gLLAuw2CvZQMMkKspGRcyMoMA>
    <xme:Ct0DZl6k_sHbEnpfguyz9xp6siFMbKxYZJtv36ked2N-nF8VBDyxAVka4f8Tdqkga
    a6R_HUgiXl39YKOuQ>
X-ME-Received: <xmr:Ct0DZjfIIGO5E5elGQI0UcJC4FR_4hUVwKuH-NhsVlQTaLhtpGFi7Dp_zXBf2kXt8w4QYXUpHKuoczuQBNZ5AH5rpJQ99RJY2Lep0t4NYI0Q0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Ct0DZpIVbjLzizfeNakzTYpFif0XOe9_dUrcX-O0ft2wPu5WW7Z54Q>
    <xmx:Ct0DZoIfHBvw3547tbcSLwPmZ5H21-r-mBBH27r6GkTNJ4Y0DAoz6g>
    <xmx:Ct0DZqzSBhgygc0RrLw4PoE_E1zOlKH0TsnOdQWifUyUe0r7YFb-uQ>
    <xmx:Ct0DZsLMWy0YyQXDw9YoVIil_SwrJCyS_9tFDlRalcdzEULgS0-J2Q>
    <xmx:Ct0DZhoC8us91JPtn6FEucl-VlA43r1zcr7Nts4h00iioxu8oWbpmQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:47:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2c8784b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:46:52 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:47:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/13] builtin/config: display subcommand help
Message-ID: <657d1355b5d33056644effc5d170d323a58ebdbc.1711527812.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1711527811.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2QJTKoa11Ha5VTsO"
Content-Disposition: inline
In-Reply-To: <cover.1711527811.git.ps@pks.im>


--2QJTKoa11Ha5VTsO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Until now, `git config -h` would have printed help for the old-style
syntax. Now that all modes have proper subcommands though it is
preferable to instead display the subcommand help.

Drop the `NO_INTERNAL_HELP` flag to do so. While at it, drop the help
mismatch in t0450 and add the `--get-colorbool` option to the usage such
that git-config(1)'s synopsis and `git config -h` match.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c            | 5 +++--
 t/t0450/txt-help-mismatches | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index b8cb940b1e..18b1f7014a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -23,6 +23,7 @@ static const char *const builtin_config_usage[] =3D {
 	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
 	N_("git config remove-section [<file-option>] <name>"),
 	N_("git config edit [<file-option>]"),
+	N_("git config [<file-option>] --get-colorbool <name> [<stdout-is-tty>]"),
 	NULL
 };
=20
@@ -1084,10 +1085,10 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 	 * us when parsing the legacy-style modes that don't use subcommands.
 	 */
 	argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, bu=
iltin_config_usage,
-			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_NO_INTERNAL_HELP|PARSE_OPT=
_KEEP_ARGV0|PARSE_OPT_KEEP_UNKNOWN_OPT);
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_ARGV0|PARSE_OPT_KEEP_=
UNKNOWN_OPT);
 	if (subcommand) {
 		argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, b=
uiltin_config_usage,
-		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_NO_INTERNAL_HELP|PARSE_OP=
T_KEEP_UNKNOWN_OPT);
+		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
 		return subcommand(argc, argv, prefix);
 	}
=20
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
index a0777acd66..28003f18c9 100644
--- a/t/t0450/txt-help-mismatches
+++ b/t/t0450/txt-help-mismatches
@@ -10,7 +10,6 @@ checkout
 checkout-index
 clone
 column
-config
 credential
 credential-cache
 credential-store
--=20
2.44.GIT


--2QJTKoa11Ha5VTsO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD3QYACgkQVbJhu7ck
PpQ7FQ//fysgdKvPkw5ww7IiWY+mzNOutF9PiUhNLB1Wj+/7+bN3SaE/IUXwKu1r
zUaVZlxs/nwK/JegDrvloakQg6arBtB3/W4jbaElofJJHsBwojlaKVFDZ0obUf6N
GKAk+2O6X2HJUs40NJ2Efrcwh7Rx3fQf7ZVDKsT/oidipUik7KOKdDF7Ki3zDJQi
HiqeoE2ToaF1yV+f1IBgdpKy68AQaPwnUSRvkBOHuEF62s36aoWBeOWnMiLmw3Kf
UExzaTiYRf/tuIfNE++00xAAEgdt4raqkoF0QueeXhc1W4orFuZecCsvivMAkkvU
jsBK5gcHdQyzXoNB3Dl5n2bAK6G7yiPfhClY3AE5CoUX+kcxq8NOOdC3yAWXCPEK
eRZf70+ml4pMPqqLsIebJf9ocRZgnbswH9TzwsFPHeCUZr8tgJ9+yWwO96BwEB2i
btO6SYo4pbVzqi/egW/RdBESHkzHYptA6iQLyM+hD46n+oHbDFAbgnd3ugzs6YLY
76RH7Gs/WF5CLWRcpxLTNfcdgrc7b0PUD7FHlzng37T2809Jdks5oXsymsHXc4fM
UyZc8Kq91XcBgqNZ5LyybMn6BQ0wpYcWkGxYH+hpsi8lVqs83S05q77FRpsANpB0
ZbFUU03ntRwphOUVo6fuyjT8Y4ne2WhB6VoQyFF4V10XGRlylMc=
=otL0
-----END PGP SIGNATURE-----

--2QJTKoa11Ha5VTsO--
