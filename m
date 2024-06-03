Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D984D1D
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408130; cv=none; b=ctcMqWhJgVIx1o2n3OgUi0rVDOt3eFpixx41ucJtsYfWdf+n31BVOgjykG3b5KvB7TH/v5MRWH1W35saxDzdl4y1C4gnGe+dUbHd7wKNrc/7I9hzIdC1nL1801eEec+8P7+1ON8mHzQ8GyT31E9BMlixX0Gss0UpSus24J/M6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408130; c=relaxed/simple;
	bh=Cx17qdWLFNDSW0irixYozr/qPQMFw7i77PDGm9wHlK8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIlOYx8A2HaJ9lUQQ9ILG8AzwUwrFui5+eNgz81+f42t5EcHJ1J2pjkmdY9/TBg8ySY8nAuKy2MdMWPQDRXEf64k0BX1MqXZ+X+OqpGZ4rTLyArh2IemK+5QD4Ds2Pmp/Hm2mtJ5rr4JLuQIY1P8r2619PncydtW2wFGzlvmnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S0YxXpa9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qeOdZoCB; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S0YxXpa9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qeOdZoCB"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 48C911C000F5
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:48:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408127; x=1717494527; bh=5t35oEPujo
	i7+cF9IWq3/68hZ9jkIZPDfSB81UDbUZo=; b=S0YxXpa9GkSpig8V4kanmV5qNn
	09JU7Wo8rjBIy502zQ5I9PB3cphKGRUdolrc6QaucZ2XaDvxQoIB552QxUvxTY2W
	CFeOI7+JWV3GiZjNBkVA67UiePOMnrDZChzTAn48Aa4IceFR+Nb+ueeZWblqyIXr
	rQtikTdxQkRIrgrLPQNyrFp8hwV19BOhRe9Xnj5DviatwQd59AnCglB2Lpv+uALs
	gXBhPS7I7DCeaiSjCYQAuldhCRIv0uAdJ5wrBkYanWZuHxInU5gB0iWQrdL8IJuv
	697A2X0KIpD4cGYHSfCTB+bMgvw0H8Rsh0eHrAJWfkLsM+7Nvr/XH/LhGiZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408127; x=1717494527; bh=5t35oEPujoi7+cF9IWq3/68hZ9jk
	IZPDfSB81UDbUZo=; b=qeOdZoCBw0Em4dy16xz6mZKkQiTZGRUCuSgfBMBDbxEe
	YdHh5O7jokLymOa8OF//C7Tk7tZTDH34jzBZ75jYschW6Ag+3r2PZvsHVzD44CER
	EDoZvir25mbdrTfc/opUYvoDKpkjhuB6ZEUWZS6cttowD/uuGXQsBlNkYMSvCh9O
	92oVvNLWarodAQHhIghAKuCU4LenXAaz+ZJuAzEhGwvWho/XdxLBHVs23zB5SU/F
	bR126aVjiZc6uEtytH1HxM+v2szh3dw3B9k8nzkDZSJRh5jUJti2rBkRCQWSApDY
	OvnnA2ZAkXcSQU783SGBgbiuS8MBXiVzRU+INODOQw==
X-ME-Sender: <xms:f5FdZoIPOWXYiQxV0QYzth_wnulJUEcZE5CgKTNobXvLp-M9C3py5A>
    <xme:f5FdZoKCCK0TAM5yqOFWWPdNh8UlqPJMpfaVyFmCWSoF31kvyF2Jw15S85JIMIIqa
    65MhoIYCAxr4pPLCw>
X-ME-Received: <xmr:f5FdZou1GFXSmOOykv0TIclQacfehzHo89bmHJfhmF1-J6m-eGGHKmuSuPsdVlgul7jgi7K4yV_4-GlCNL1j05e2jOuUCmgSmwM0EvNCDRBLzLL8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:f5FdZlaap5mVBmoH3u9ZA-8rUoCsGNC4_euWw4zG8uXh_zOBLMWvFw>
    <xmx:f5FdZva-kRhWjePvmuieJLDCl5ZF3J8BO6CRHhezSQ_iNWsVzk3DzA>
    <xmx:f5FdZhDvTUfiNzHET1LumTRquHmOvZjmSirxIgpNCZivQqw_Fseqdw>
    <xmx:f5FdZla7VBZaYxgmZklx7iFAV5HLVwmcY7M5wQZzKLQs0aFMhyArug>
    <xmx:f5FdZmxaO7s-hessoLmmwpmn7WbZuhiCq5UvSbHMi81njphQlcCwJL5C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:48:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4784b16c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:48:22 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:48:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 29/29] builtin/blame: fix leaking ignore revs files
Message-ID: <5b5fdfc6cb8262d1d975de41d0643fd69078bbfa.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cV7FF2REZXioCike"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--cV7FF2REZXioCike
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When parsing the blame configuration we add "blame.ignoreRevsFile"
configs to a string list. This string list is declared as with `NODUP`,
and thus we hand over the allocated string to that list. We eventually
end up calling `string_list_clear()` on that list, but due to it being
declared as `NODUP` we will not release the associated strings and thus
leak memory.

Fix this issue by setting up the list as `DUP` instead and free the
config string after insertion.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c              | 3 ++-
 t/t8013-blame-ignore-revs.sh | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 17694410ed..702fe4fb94 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -67,7 +67,7 @@ static int no_whole_file_rename;
 static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
 static int coloring_mode;
-static struct string_list ignore_revs_file_list =3D STRING_LIST_INIT_NODUP;
+static struct string_list ignore_revs_file_list =3D STRING_LIST_INIT_DUP;
 static int mark_unblamable_lines;
 static int mark_ignored_lines;
=20
@@ -725,6 +725,7 @@ static int git_blame_config(const char *var, const char=
 *value,
 		if (ret)
 			return ret;
 		string_list_insert(&ignore_revs_file_list, str);
+		free(str);
 		return 0;
 	}
 	if (!strcmp(var, "blame.markunblamablelines")) {
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index dbfbd86e83..d33788d867 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'ignore revisions when blaming'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Creates:
--=20
2.45.1.410.g58bac47f8e.dirty


--cV7FF2REZXioCike
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkXsACgkQVbJhu7ck
PpS9xQ//V7Cfxjld1SwzkSe/CsKCtfiurHJEAqB+ZqTldgmhkmqtyIJAyYvk+KT+
ImaGzsB9+nTMHJt6msmeveZQTBHP63Ghu8SHvDwFnDjjf0FNRKeF6fhj/k9OA4nL
265WnyRX0roImVP2rUEp07txJZtgjnB8VWuDndPyWJjAFOqQvVqJnD9WGo/oSxPf
XSK1l7CZpd1l9Lv/VDB2P+/52dpWG7LlEV95d0tV0QazwURjkRwd3IVyjxjYnsDO
8v12MX8405enMY3FZyXViZFkhvs/I3zBqgrIS5+VAa0qgB88mrAsqZ1D6+LgRJS/
QJGgNH3o4qVMX/7ZYQ/6icvqGFfSC9luJYcGCrFT2G2A/w/O0Vq+gqWDMrydSF9S
9tXoe76nrbEZY7NgPehv34W5w7Ci/N4jnARcg2fe9CroBGUFUkBOG5Qv6IJJgVMe
RtWlQSifvKVi54+VJLXIDcazg6hrADmrfUVUkGYYYdf45P3OgDNwhYd65jcPKE67
PS88cwrRbFDp+SJ+M9FXo7Xg7HLdf3FEUNwPpUGvDpnH1j2vx8iNROaflmdfqKgD
V4dmyi5djz4R+DgxCvU/sxaFBnAsO04REhEEt3PkpYV7Cs+I/NN1wi9U3RUOdtFP
5Tbxn1jDKcszyPHKxCXkf4ePaNlfpVTh17FfIsEsasqzPzV5jDw=
=wHC8
-----END PGP SIGNATURE-----

--cV7FF2REZXioCike--
