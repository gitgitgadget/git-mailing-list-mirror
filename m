Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0258AA9
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199215; cv=none; b=ViVIsdw+Rtgh/DobWGFZQOWG8ayPoGFdKw4KzoKT+MdCGht4qV1ZH0xwn2ZAdqaB3y6QdTO3o69cWkGjqYSL+1GIbmtTAJcpzu74ajaqWroZle7cW06jppEZtOTfDyolhMRmI8WycxOgaNLMe5PfNf6Tu21yzwhV/3+BvbvvjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199215; c=relaxed/simple;
	bh=aPiscuJmMZABC1T3xa5T2YcQ6xY9G4PR9yrtxbBS/Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSmuBoynn9dLXTQBdl4j9YghuG7np4lBACYjL5zw82TGEz9pRyEWFG01ORpEFMwdujE/VSwiowDUL1ahenEJnc4bGyZypY0m63dtUO32lRazo6hxawjtaTNgJKMpxv2ujk5xJYJdMjrUZ4zauz4Iga84duubOeKtADsfcQzmPmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k4ak8QqL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TMTLojlQ; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k4ak8QqL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TMTLojlQ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 7D24E5C0081;
	Mon, 11 Mar 2024 19:20:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 11 Mar 2024 19:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199211; x=1710285611; bh=c3dyHd9+Q0
	0EtaO/HocbpfDGdxukrLaMR4ncgukUPw0=; b=k4ak8QqLNFcKqLI9uEln/1mUBN
	0zOS+qQwWMbG4+XL49t8AxapCI5VtyxRDBJI5qrD94oib+PJjBcSQpH8u2epAqbS
	d9ao+XUBhtFnnFV7kV2+4XmtUKfFPa9MUuKTQN70xirslgoyIpuLXv3nk06lCpdL
	bO/whcF58kfZ8M46qyt1BCRWkpuYcSrzxYRMCPno9ETtp4a0wg6d14uD7yEHDkIQ
	dLPuVceYu4WvWaM++oFIZhc8p1blmBP5kTVTUZXPUUNzcyrNOdDOm1y8r3QHoFNv
	ZlQwIdx6ZaqmGy+8y50s+xU6PEzmWPLbXWHJt7416vLtRrlxKV/BGk4EuqZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199211; x=1710285611; bh=c3dyHd9+Q00EtaO/HocbpfDGdxuk
	rLaMR4ncgukUPw0=; b=TMTLojlQyRoi+NlWZgXDQoeEWlPYDkLJrSpj1I/r5dDI
	DG5XjyBKye2RMOGSaq2KdXK5CyGrRwbL0uD3fa0kbkjnX69hyctwSTX8qTeA8O+s
	c/OvdwNNowmxvf9WPHRA6WigYcDYV82o8LHkjDwkqgDxcnWyUF8VAq6DicpV3HRq
	rg0B7Ez+isv5K8yccd6LITxkrxcFCMDw6do3/20vYFWXMQlyz/XqtlKtUYwQr63V
	THSteff+kZaOVhD5xWMfsxux5hEIPlYcYxDhuMz3eL1tbuc5zG30M67MPDCYh1y5
	V0pw5VWL1OtBow51tvWM6MaT/tdRdTj+5QfFETGa+g==
X-ME-Sender: <xms:q5HvZfQxQBYrybMQkkdq2NOSoWkwFGmpWqDOJeXE9GjcB1wTr7Waqw>
    <xme:q5HvZQyZHBMJanuF8v6QT2-E6ppS30Zyl9gWMoyJC7zf-WQCC8FVZADHMKIdbWV_V
    hu7ZouI8ON5GGckFQ>
X-ME-Received: <xmr:q5HvZU1KHksl7IrCg9eBcXy2cwAZSx2zYjIQTqLogFtf9AFhiqTz47VALuFpoWnN6Np2TOq0Uy-T_73lvSQ2mbuVVXBKYFqV2bkmeaKytR7mPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:q5HvZfA8hrwxfbQrKBczDll9Ca9LrmXw1OsB3iHi_tOBQTLtecUFUA>
    <xmx:q5HvZYhWa2lUs6KUKWcP0vjp1-DamY0noNaLsu5eO3pVPGXpO3pjLQ>
    <xmx:q5HvZTqkuIiWhPL9IQguvY-IBWnrN6QGii8GiPsLOES6ZeWFiL0pjw>
    <xmx:q5HvZSYbTPX04wiJhCDLg5NYh85Y1iKMgBbXXL00gISksy7czwFGVQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:20:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 346399c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:15:31 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:20:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/13] builtin/config: use `OPT_CMDMODE()` to specify modes
Message-ID: <49d190ac2456bf3823885f9e8877c307dc4a12bd.1710198711.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1710198711.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vo9Vq+7/qktUCNW2"
Content-Disposition: inline
In-Reply-To: <cover.1710198711.git.ps@pks.im>


--Vo9Vq+7/qktUCNW2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-config(1) command has various different modes which are
accessible via e.g. `--get-urlmatch` or `--unset-all`. These modes are
declared with `OPT_BIT()`, which causes two minor issues:

  - The respective modes also have a negated form `--no-get-urlmatch`,
    which is unintended.

  - We have to manually handle exclusiveness of the modes.

Switch these options to instead use `OPT_CMDMODE()`, which is made
exactly for this usecase. Remove the now-unneeded check that only a
single mode is given, which is now handled by the parse-options
interface.

While at it, format optional placeholders for arguments to conform to
our style guidelines by using `[<placeholder>]`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c  | 32 ++++++++++++++------------------
 t/t1300-config.sh | 13 +++++++++++++
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index fcd6190f12..a293161be4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -631,20 +631,20 @@ static struct option builtin_config_options[] =3D {
 	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use gi=
ven config file")),
 	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read =
config from given blob object")),
 	OPT_GROUP(N_("Action")),
-	OPT_BIT(0, "get", &actions, N_("get value: name [value-pattern]"), ACTION=
_GET),
-	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-pattern]")=
, ACTION_GET_ALL),
-	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-regex =
[value-pattern]"), ACTION_GET_REGEXP),
-	OPT_BIT(0, "get-urlmatch", &actions, N_("get value specific for the URL: =
section[.var] URL"), ACTION_GET_URLMATCH),
-	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variables: n=
ame value [value-pattern]"), ACTION_REPLACE_ALL),
-	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACTION_=
ADD),
-	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-pattern]=
"), ACTION_UNSET),
-	OPT_BIT(0, "unset-all", &actions, N_("remove all matches: name [value-pat=
tern]"), ACTION_UNSET_ALL),
-	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-n=
ame"), ACTION_RENAME_SECTION),
-	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTI=
ON_REMOVE_SECTION),
-	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
-	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
-	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [de=
fault]"), ACTION_GET_COLOR),
-	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [s=
tdout-is-tty]"), ACTION_GET_COLORBOOL),
+	OPT_CMDMODE(0, "get", &actions, N_("get value: name [<value-pattern>]"), =
ACTION_GET),
+	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [<value-patte=
rn>]"), ACTION_GET_ALL),
+	OPT_CMDMODE(0, "get-regexp", &actions, N_("get values for regexp: name-re=
gex [<value-pattern>]"), ACTION_GET_REGEXP),
+	OPT_CMDMODE(0, "get-urlmatch", &actions, N_("get value specific for the U=
RL: section[.var] URL"), ACTION_GET_URLMATCH),
+	OPT_CMDMODE(0, "replace-all", &actions, N_("replace all matching variable=
s: name value [<value-pattern>]"), ACTION_REPLACE_ALL),
+	OPT_CMDMODE(0, "add", &actions, N_("add a new variable: name value"), ACT=
ION_ADD),
+	OPT_CMDMODE(0, "unset", &actions, N_("remove a variable: name [<value-pat=
tern>]"), ACTION_UNSET),
+	OPT_CMDMODE(0, "unset-all", &actions, N_("remove all matches: name [<valu=
e-pattern>]"), ACTION_UNSET_ALL),
+	OPT_CMDMODE(0, "rename-section", &actions, N_("rename section: old-name n=
ew-name"), ACTION_RENAME_SECTION),
+	OPT_CMDMODE(0, "remove-section", &actions, N_("remove a section: name"), =
ACTION_REMOVE_SECTION),
+	OPT_CMDMODE('l', "list", &actions, N_("list all"), ACTION_LIST),
+	OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
+	OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: slot=
 [<default>]"), ACTION_GET_COLOR),
+	OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: slo=
t [<stdout-is-tty>]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
 	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type),
 	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"")=
, TYPE_BOOL),
@@ -767,10 +767,6 @@ int cmd_config(int argc, const char **argv, const char=
 *prefix)
 		usage_builtin_config();
 	}
=20
-	if (HAS_MULTI_BITS(actions)) {
-		error(_("only one action at a time"));
-		usage_builtin_config();
-	}
 	if (actions =3D=3D 0)
 		switch (argc) {
 		case 1: actions =3D ACTION_GET; break;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 31c3878687..2d1bc1e27e 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2612,4 +2612,17 @@ test_expect_success 'includeIf.hasconfig:remote.*.ur=
l forbids remote url in such
 	grep "fatal: remote URLs cannot be configured in file directly or indirec=
tly included by includeIf.hasconfig:remote.*.url" err
 '
=20
+test_expect_success 'negated mode causes failure' '
+	test_must_fail git config --no-get 2>err &&
+	grep "unknown option \`no-get${SQ}" err
+'
+
+test_expect_success 'specifying multiple modes causes failure' '
+	cat >expect <<-EOF &&
+	error: options ${SQ}--get-all${SQ} and ${SQ}--get${SQ} cannot be used tog=
ether
+	EOF
+	test_must_fail git config --get --get-all 2>err &&
+	test_cmp expect err
+'
+
 test_done
--=20
2.44.0


--Vo9Vq+7/qktUCNW2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvkaMACgkQVbJhu7ck
PpRTDhAAqVrVpPAnWfmJNDFyw0Ejy4LjFL3Nszp9+rpAR10Ql+yzuSIaCr9EE1XO
igMhYnNVin1e3TWsz3zCKXapKDHYlfeEY/sSKZ59hRa5vQyQGH0YEC9r2gQLAuhL
DigPySL58ILafDc3weEsYJVyaVLwvvMPYp7OCdlqYtW7vSd5n9tCO/+VooO8++wh
ThyzcXIRrhaLY8ZAZEP+Vd+ynhWpbH1wrJVSeUpySRJcSUnpQnxXJYXV0uLXV3LE
WIDQbU8rceyg9u0O0SBqm/LYlKBtiOqUBIPl3tV//Lr3UjmMAZsW0QIKwz2qUkE5
8VDc9Z9ocOW7k4fKluMDWRjTAEvivaLcemE4+OdZPsO2jnT9ROFRt3ja10s5Mj8d
IejnW3yLUqJuH3XEBFzjqdatkH9V/ngwcvFRVSwt81k0l6N61XgPY1rLCc4VNHF0
Pu7RDHptxMzJk3ETU7oZNMZJsVdjBH0C3pHL8JQFN3/kQDmjrAb3/RaX2jIfGKz/
USwETamUpLtxDY+iW5HDvIkiTRQn+bwRHP+CxCNLeb6pUoZ0VqPnCqsmjbfXrvgu
YraFdYZVaD8+TsGN5d3IvQzZwZj3lWsgZyfEQubIv8x7AAw5y38+PPrcL+CcvKdx
NEfRI0UwtH4EobctBtN75MOmDu5kWjLwmeDVWcAOc0CAj/RWDZE=
=+HXj
-----END PGP SIGNATURE-----

--Vo9Vq+7/qktUCNW2--
