Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639E358AA8
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199316; cv=none; b=lCgOwkjYCU6Dm0NgIQpEYdu8Prgv24kqd9lHaF2drBO5X8F9t9JYeKVT/jwa+axmo1v1HzbVUsNYAjjRwJGSExznnJ7j5ho+Q4TYCt7s2ZxvDOqu/fYY5Cnp4lecFKbsVBCTyiwC/cfOv6AXxwhiUr2kOHc9foaPXQa+1nThb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199316; c=relaxed/simple;
	bh=V8lzQCZsVizqamWXZS/f5pZFZqRO44eaHmXEL/lMonM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvWRpFqKI7bs8/GXVvQkni9HMG7THtf9RwM7vmez8Wx/gnbHpcLwdsl2/sPCXUEiOkX7OfqQ6xsJ+IT1KWtjSfPN94G3rXR4kRi1EK9whVzttuaE2PethkyZtNUrt6TFE0scwlNNUeQr1SEGgmFK3JzP2bTbhlV8Bb5FmK/25CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qK2gF1t2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g/5gObTt; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qK2gF1t2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g/5gObTt"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 855081380110;
	Mon, 11 Mar 2024 19:21:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 11 Mar 2024 19:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199313; x=1710285713; bh=WYhaTBlr1U
	RuZ9W9n8n9nSmonWY8bbZk52SZ/91agl8=; b=qK2gF1t2AxqDZWm41crHqisKHl
	MVscIRWNiwI01r2VkkzMh0eXgCPzPluu4RzXgh04pEnSMWLM0SIlKF4ps2fc1Spy
	Trgix8GPXd5GzwoTftT/YfC6G4nll+KZmu7aJRWhIQNhtRSQsFrbW5DGzcbJ15n7
	H3xEJX0lpGyY60SFWyDOBUjAn1sR71ZKyGZQzbJy2PJozbzd8qr/zHaCP3L5080J
	/uXDKYO8+iFDHzSS6wk9xCq/egNAD5FbYuXUqBbyhyHmUizrZJDI+Y7MeC6OICr1
	oQU9zxGl5Of0I9M4G6u8HNzEssVODAQKR7oOSo1OUywicg/5l8x5uKS4aycg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199313; x=1710285713; bh=WYhaTBlr1URuZ9W9n8n9nSmonWY8
	bbZk52SZ/91agl8=; b=g/5gObTtrNWlmio0/OQ4z0k0Bi+VilKhoNl4dfwTpnoc
	lp81yNGfg8fceLc1nKWMe+M9+D8sdQUw8gwc93tqMNIm4d1JzXKPIG1qz7Mwz+Wf
	dP1TszhcZZd7UZA0RcveS9sxntAzE0wreaSAJfUXFy7eVdWzlb/A6IBok8WFNrNG
	zGXI9VSc4IS4w1oJWMQuahOdWQGMwmUTA2+9BopEmIKrWMYH4OeHgOZBFpUGEpA3
	TFwOCi2AHgQgmLzCVKYQ3Casw9XNkYfLWdrtANsOz73kj0Hx1cPkubPuczSj/Ec0
	bKv29mE0wn9IZetobsrgVdwmpgPSw+Qfv7VEVpWaeQ==
X-ME-Sender: <xms:EZLvZRs8x2ZHMkOSB4zkIt45_FAJzVyfgRzo6MbqBxhZCCooZI9YsQ>
    <xme:EZLvZaf1rt3eyRJ5SLh0M0QbbEevBRsNX03aKs67Wdx_90xFnada1OZUBXUHrxSBI
    8z_ZGPsM2-Q4I5BEA>
X-ME-Received: <xmr:EZLvZUz6htOaO9UhPgsy5f9vvnt8gjc6g9LcvWysBQxpjJKO9MQlIibsqqMwOjn8gqJOR4lXJRosTsd_MEByTyvesvZOVvapY16Opj6091gShA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:EZLvZYNGTEBIuSKrBL2R4CmSAI38QYMEpKBPJ7StLXdrDq2Jp9476A>
    <xmx:EZLvZR982752nB-5ZrGTQq9Fg6N7P6NjBD0LVN0cADkx72Wtkj44Jw>
    <xmx:EZLvZYVPckSKA8FoF9KfVrNdx_L8-89jiwdlSG_a9ypxjMtjSF-CUQ>
    <xmx:EZLvZRzet659cBvjHIXlWNRNbk8sNEuiQRrAWmmkFZT5w9oz9TBndw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:21:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4db2daaa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:17:13 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:21:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/13] builtin/config: display subcommand help
Message-ID: <2046f6652aba21d24fbd55399aabf71f836db011.1710198711.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1710198711.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="di3tNbeMDnWqwYYz"
Content-Disposition: inline
In-Reply-To: <cover.1710198711.git.ps@pks.im>


--di3tNbeMDnWqwYYz
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
index b1008c487d..8ba8dd77bc 100644
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
 	 * us when parsing the implicit modes.
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
2.44.0


--di3tNbeMDnWqwYYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvkggACgkQVbJhu7ck
PpTUeA//cwx6Hz8ZCCWi8yyU6ypbVDPMZcqg7LM5S39F04onSTD1cnf4I66z/1UY
yVRZymgwNJB+6yf0SA5iofEw4P3CY0Wn7Cne5/dkLjS1+PjRUu4tqzaahX85kqay
gfa8/2ghsso1tJLc6P58/UNHF0HBZdo2RZ4N6ZMhcj5UZq3sNGSEx0buQ6IDqhDh
Yvol8eUPfrz4VhmLiyXb9ovBpnI9e4si26/JqRk+Zq8oYyEDzeDB97lRp3i+3x6B
nJUqiZLMkSH/dBbWC+s1gEe/G4k7GdCGGWIK9mGIyhxvaokggZwCppT9ag5D8e16
9gMtPKUzEKuM3gcVIbEEA0PfGMWcJ04XwPVS4hsKRJEy+2tvXubhB7uE34csqHAe
/oKIUW4E1+MQFI/mcvL0tD5k9ItN8AaGxGtzCU3IY9j9FKZNJk1Se29KMatQcWqf
kklR1luTd/Oqvr6fUVOXYKqmVk1lNgWuwrms0aWnh/l7iWHfWVQUemlwDKDAQILu
ZBfvk1TsbTqeLU4emutA41wBhUMRfBrpSHNX98psceJT1FQ4oBB5TMsBDrNeIo7K
eFCKk8Og2HPTC3ZuPzH9Qf4j0I5tHnP1g9Y3hG0QhY2yfmXB5xL7RHDIq1mv6vMI
r7asEn9HFLQ+/+JK/CdZOpJ0Z1VZFz0XChIvHjJoHyzrjHZQJDg=
=0SW4
-----END PGP SIGNATURE-----

--di3tNbeMDnWqwYYz--
