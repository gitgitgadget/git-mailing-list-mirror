Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151BAD53E
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986736; cv=none; b=EqWaJQgZzYja87+4knairhWea6m4Wrt6W+ysGuUBmBKOcihe8VTNwIxxO+t13P8KjWaSHraiYvrksVp+s7PBfTyzPF0t7GjVWwpI5NG+9PL35DbmrCR0m1veVNxNKZafkQMsKpI1GLvoEEl+pIid+QkjylCOEXJdc8QsqpHsfZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986736; c=relaxed/simple;
	bh=f2CtYVYutxg7K82bLzhnwsNZnf7Icqsxu4VYqTxO6zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMsPZdOPxAMis2JgDTrIjrZZj6+2dRVya7+VW7yV5PspnDU6vskTyNAUDzOubFaHm2n0nvy52ookvnOIHABUjsiN9MKVR5btlZrYq3EXUKm8rcdlRvRutdd8C3+TfcNANQR2I9DO7Th/FpndCahLmIFZy9DSuAQzOMuBMN16zVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZGFa5V7O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rl1mTXjW; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZGFa5V7O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rl1mTXjW"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 388681800116;
	Wed, 29 May 2024 08:45:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 29 May 2024 08:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986733; x=1717073133; bh=n7gx9gQMSI
	tbYSxSOsbsFZNpg7XG7OifRLQBfVVRad4=; b=ZGFa5V7OirO8Y5d2ABcm4lT1yn
	QwXuUduHVGXrlwLrPaK4oiVaq16R8OWtDbu2DX3noYptZcqf4PfN3wAknAo3+6tI
	ikyRmb+Iz/JzM5qG38JW0Rfv7sTfwqD1HkD5kBbCeRKxe3BTupjgAyAxzf4s6FZI
	PkNq0B8j26b6VMoUxy7lVg0bit266TP/nG660ODuNd29ugvqPrNVqxV3RVqqK7o2
	Qsh8tXOtoJAuhqOfU7k0LjWZcabgjlA3H76zzrFyAfJc6ELSWI1nxIkd9F+UWs7p
	kULdC3vyNmgtPt6RaE2fCeo5Gx0P/A2MqVJ1GbYrA912l55o8DJOLmfWUPCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986733; x=1717073133; bh=n7gx9gQMSItbYSxSOsbsFZNpg7XG
	7OifRLQBfVVRad4=; b=Rl1mTXjWdPa7/MgviFy8gWvn4kgOOakpQe3VTq0PiIol
	N9cKp5RQ7hAxHaDTef518DGgDs109V7lD5cfF3wBfbK0ITd0im5AGhxmI5CQEgId
	4LYTg/Q3OjhmuAXnYkVaJmwSnYzjeWbkf4fElMIr3G4dWuQ55tL+tWbibUaBMxib
	AUHooLVTJd/HccYLszQWUa4VBOaUimldPaDQZTQFuL7JL+0hw8LzQJgndjOWB9kU
	cQKK0znhPAo5T8gMGI6pEcUDWnxNKgk/JGZuWqiC735xrWOwiIJeuSLR8FSlnpPl
	ZoR6OL3ALpQj6yPyqRbQVbeNDSeRkhNYJY75ipf+UA==
X-ME-Sender: <xms:bSNXZoz3hCSmgTA1jvPh2yJbkyk5byqnfK7WFlyMHZ0qt3o693VX2A>
    <xme:bSNXZsRKC-iMUSeY992PtHPGWQsHg2BuIxs4oBAzCI9nSfI9eV-pjq1v9ESzbjJnd
    7vmIrlH7AlNKArvbw>
X-ME-Received: <xmr:bSNXZqVFC85_Ig_xMXsW7ZRH9qPiY16V2e8db-clWXvoubi79wpOfO_Xhna4ixHivTQBvQPZAOB0UMS-i8Coix56svjEuurzq_J8rhTXZjemc9aY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:bSNXZmhRXmqTGD6I9RinIYxzwTGWS8tos7-o_NhH6C-CWHDFof66Aw>
    <xmx:bSNXZqDdb38yNsOfsubhvGWCgA5V_T7WNPN21HlRvjvPF9a5AZFGyQ>
    <xmx:bSNXZnK5JVQjQwJxz7Cv1hgYRlfnAATv_3DiJo3jpYXO7AGIQBNx1g>
    <xmx:bSNXZhDzYfwq6xEdmhtDWYfmq7ptwAGYRF6F30gSf4R8tzep57oIjw>
    <xmx:bSNXZtP-_Az_bi1S55FGS5wD1puaK3W4ro8KwK8yPbXFH1_wCUsFBOIO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:45:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b07f0242 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:45:18 +0000 (UTC)
Date: Wed, 29 May 2024 14:45:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 18/19] builtin/merge: always store allocated strings in
 `pull_twohead`
Message-ID: <129482dbaa64b509f103914e8b3d6bdd14f47b62.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p7MATRHmAyrZDOQY"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--p7MATRHmAyrZDOQY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `pull_twohead` configuration may sometimes contain an allocated
string, and sometimes it may contain a string constant. Refactor this to
instead always store an allocated string such that we can release its
resources without risk.

While at it, manage the lifetime of other config strings, as well. Note
that we explicitly don't free `cleanup_arg` here. This is because the
variable may be assigned a string constant via command line options.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/merge.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index daed2d4e1e..fb3eb15b89 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -611,17 +611,19 @@ static int git_merge_config(const char *k, const char=
 *v,
 		return 0;
 	}
=20
-	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
+	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat")) {
 		show_diffstat =3D git_config_bool(k, v);
-	else if (!strcmp(k, "merge.verifysignatures"))
+	} else if (!strcmp(k, "merge.verifysignatures")) {
 		verify_signatures =3D git_config_bool(k, v);
-	else if (!strcmp(k, "pull.twohead"))
+	} else if (!strcmp(k, "pull.twohead")) {
+		FREE_AND_NULL(pull_twohead);
 		return git_config_string(&pull_twohead, k, v);
-	else if (!strcmp(k, "pull.octopus"))
+	} else if (!strcmp(k, "pull.octopus")) {
+		FREE_AND_NULL(pull_octopus);
 		return git_config_string(&pull_octopus, k, v);
-	else if (!strcmp(k, "commit.cleanup"))
+	} else if (!strcmp(k, "commit.cleanup")) {
 		return git_config_string(&cleanup_arg, k, v);
-	else if (!strcmp(k, "merge.ff")) {
+	} else if (!strcmp(k, "merge.ff")) {
 		int boolval =3D git_parse_maybe_bool(v);
 		if (0 <=3D boolval) {
 			fast_forward =3D boolval ? FF_ALLOW : FF_NO;
@@ -1294,7 +1296,7 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	if (!pull_twohead) {
 		char *default_strategy =3D getenv("GIT_TEST_MERGE_ALGORITHM");
 		if (default_strategy && !strcmp(default_strategy, "ort"))
-			pull_twohead =3D "ort";
+			pull_twohead =3D xstrdup("ort");
 	}
=20
 	init_diff_ui_defaults();
@@ -1793,6 +1795,8 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	}
 	strbuf_release(&buf);
 	free(branch_to_free);
+	free(pull_twohead);
+	free(pull_octopus);
 	discard_index(the_repository->index);
 	return ret;
 }
--=20
2.45.1.313.g3a57aa566a.dirty


--p7MATRHmAyrZDOQY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXI2kACgkQVbJhu7ck
PpRuFA//SIoGsp4kaAWmYMWxKvGZnJwLAYjKmA88+B+74WFJ9PGxGSt1iJbzY+Vt
xbCCCWU88GeBRHzhVQdnRj3lJ2puy75tznJKA+AudoRu/n5U2gcNZ80zf2upNcnW
2soimY/MlL/cJil+Qk/RLLHzbbB33kmwFfXwi47jeGVF4HBznuPfQzwVecXvGbUw
+/rDDt4iEWbbffxNkIe88jdjDsnsF+xDbmkpi10aYnysaIgLZn3A/jRgOQwpDPZX
oDGTY4FFl3reO/xylDF9PnFDVKJZW2bAsCPgc79Nu0LILT7ZnueUQhV445ylnCPC
PdO2jAMqzJpYV6U/oAXx6OatB96wJRxlSBx58DxNYoJ5G8gqihRri332qelCzCin
4FwMUaJb+MJHeKqtNMfBxwpzaidU7kuc1bdD9CPA5X64i853ARSspXMro97hA605
yQ4Xa9DNwL8MeWbSK0S5QQt73bohZYkLf9hVXrofxu9moPuRTO5dFTfF9mZPxbvy
qk0sfLRQ+DKWsxrXVGFI7bQ0JFgX57nJdgIouPQZtW4scSrNml83TgacpxskTLH0
JWQxlH782qDUvI7fwcqZEkD6vZbyMtZBj7nnWxZ7zbjEKoIIYfMBNKwsk2icX/4o
H8ziGFlONwBCFCx1Y7iu+G24VWW2bh1p7kmMpkmMeN8Sh7DPjjM=
=RLxu
-----END PGP SIGNATURE-----

--p7MATRHmAyrZDOQY--
