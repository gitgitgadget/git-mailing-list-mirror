Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6D1B86D5
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013877; cv=none; b=SMC9Yp5unV+qUoIeri9p6l8YkbORJAb8wyvZOMvRqRfOPN19M8Zy9k5BVpKwQlfWGSqHL2TGAFBP0Uslsni/8WAGF35gxlE9Uoi6d4f6TsjKh/SABg93CPOfe2X/CU079pfwaNJPI2B13xjyqX1Dj+1iU1WchO0ATVO+XYyVJwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013877; c=relaxed/simple;
	bh=u6acBVlT9Y+Mj9j+926PrsRvtC7tXnLgLHm7DOnYtxo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETyuIgw4SSOHbFh3s6X0Q18ewst+hsi50k5dAIz7i2e2+CH7hfYDKxeum06WxQeX3Pe3rdH6+qtrN+szFAOkWPYMlViJD2Mb9NXIAnGwokQ1L1Qv+WB1tx/+fKMOlk2N7zVLXNCJFkXqCGyZf/GJ8yDCdO6mKm1NJYn2DFKvYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X/zI2j0d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t3luCrxk; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X/zI2j0d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t3luCrxk"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D72F51151AED
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:57:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Wed, 07 Aug 2024 02:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013874; x=1723100274; bh=v/elHaq+sW
	a3hX3puCxB3mQ88HCQOyyeMLirkaejxQQ=; b=X/zI2j0dJ+4NCRY4GHs08VvaTr
	h/b4eeNWMlsCLVWKIP33uFBb0JIIjvw9QhAoEFqHYuhKi0PjAIO66rv6RiVQZ3Jh
	mV1Na7RAkS2y+hD5d0DviYt/rA2eyo2TYiS9eLpf+7tf+AG+hpQ3ZHRuR00QQlyM
	uxYTSkUwM0xOcO0jjGSlJOzAs5UMv80kdvd54Kcjd4/Sdd1ly21Q+zBvVIMVZ8jD
	UCmZ1cDxcdFgctB+X2to2NJmvOSz8FcENAYHR7eIIYVx0IM+HpLqliUQWFx6kDcI
	gWUqHpbJhdSg9QswEm5l2GhJkyARpzxot6QYH0ceyFvM30W5kQUS/maT4Arw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013874; x=1723100274; bh=v/elHaq+sWa3hX3puCxB3mQ88HCQ
	OyyeMLirkaejxQQ=; b=t3luCrxkOKkN68n4xXgitqBezYKZNN93msRvM03HZIvd
	//FMnWUpBo63QuWGXa7h5cIzHDStFGAHrGVtUB/wuYy8//4JmfHdtNWLu5iLggmg
	Mkxm+0h4iDNR/By85wJjjvK1h+k8hDiOg0LYBT+A/Lh3U/h/EYpcktvgWWMffes1
	C/cJNwbGnGg8eIpKY2v7YF0sD5KsfhryUtZCnvCejCq3dqvoEqRA+fL1O9DJi+lL
	+qFoVDqF5fb56MvpaWzQf63pebAgzJnxfVwam2LS0SKeWQEWklI5A5UqWg0pbJTU
	KVdifYhzpoma/BN53eeW7CPWdlpCzBX+KSee+B7LUA==
X-ME-Sender: <xms:8hqzZrJeR00K9EM4JE8l6bQzUm7kyMPNaTx_Co_OH_OxXgVI2gw81A>
    <xme:8hqzZvJZhfZUh16y9QVVKinGDhxnt3gSPxpAVx_TU4geD0W0yEqS908vY_iRoTjV-
    Xrsf11Nk6dbE6vmDw>
X-ME-Received: <xmr:8hqzZjsQD4S20ThaU42RiY0w4AaBps0IQackUZSSI1V63G0AEdBqyQHFCB_ZRvR6pvAbsNB54BQTk2ZfWsq4kr_e7fGiBs4BYxrbLL05c3jRaxtn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:8hqzZkZXRiilkuNMkVnOnIvjiZHTwti4xXjsicwurYgM-FamD_ILfA>
    <xmx:8hqzZibRJ70xvANsq-EPkHtQBLqia3f_-1As6cI8-onqAnr9O8kS5g>
    <xmx:8hqzZoDNypN7h_NWN3kJRQnIcPMPBVnq5Ak5rZtKmrAjDDtAFD8KWg>
    <xmx:8hqzZgYRmAZMqdtr2o4uSBfhay5ybKBTlDIRiRiRyWRBPPDUGYEmDQ>
    <xmx:8hqzZlzFuhP1WFP1TkA3C7GQolvY2tsIACWl82plbwvf2y9q4t9m-TRY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:57:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ff5a1457 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:57:49 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:57:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 15/20] config: pass repo to `git_die_config()`
Message-ID: <d70d9bfa7eef82d0488da647c3cd1277282f8ee0.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rYhtey5O18mr7y3G"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--rYhtey5O18mr7y3G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor `git_die_config()` to accept a `struct repository` such that we
can get rid of the implicit dependency on `the_repository`. Rename the
function accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c |  4 ++--
 builtin/notes.c       |  2 +-
 config.c              | 12 ++++++------
 config.h              |  3 ++-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index d21c4053a7..0249503c70 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3481,8 +3481,8 @@ static void git_pack_config(void)
 	if (!git_config_get_int("pack.indexversion", &indexversion_value)) {
 		pack_idx_opts.version =3D indexversion_value;
 		if (pack_idx_opts.version > 2)
-			git_die_config("pack.indexversion",
-					"bad pack.indexVersion=3D%"PRIu32, pack_idx_opts.version);
+			git_die_config(the_repository, "pack.indexversion",
+				       "bad pack.indexVersion=3D%"PRIu32, pack_idx_opts.version);
 	}
 	if (!git_config_get_ulong("pack.packsizelimit", &packsizelimit_value))
 		max_packsize =3D packsizelimit_value;
diff --git a/builtin/notes.c b/builtin/notes.c
index d9c356e354..c0fa86d847 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -868,7 +868,7 @@ static int git_config_get_notes_strategy(const char *ke=
y,
 	if (git_config_get_string(key, &value))
 		return 1;
 	if (parse_notes_merge_strategy(value, strategy))
-		git_die_config(key, _("unknown notes merge strategy %s"), value);
+		git_die_config(the_repository, key, _("unknown notes merge strategy %s")=
, value);
=20
 	free(value);
 	return 0;
diff --git a/config.c b/config.c
index 33d9af29c8..e35fc90238 100644
--- a/config.c
+++ b/config.c
@@ -2611,7 +2611,7 @@ int repo_config_get_string(struct repository *repo,
 	git_config_check_init(repo);
 	ret =3D git_configset_get_string(repo->config, key, dest);
 	if (ret < 0)
-		git_die_config(key, NULL);
+		git_die_config(repo, key, NULL);
 	return ret;
 }
=20
@@ -2622,7 +2622,7 @@ int repo_config_get_string_tmp(struct repository *rep=
o,
 	git_config_check_init(repo);
 	ret =3D git_configset_get_string_tmp(repo->config, key, dest);
 	if (ret < 0)
-		git_die_config(key, NULL);
+		git_die_config(repo, key, NULL);
 	return ret;
 }
=20
@@ -2668,7 +2668,7 @@ int repo_config_get_pathname(struct repository *repo,
 	git_config_check_init(repo);
 	ret =3D git_configset_get_pathname(repo->config, key, dest);
 	if (ret < 0)
-		git_die_config(key, NULL);
+		git_die_config(repo, key, NULL);
 	return ret;
 }
=20
@@ -2774,7 +2774,7 @@ int repo_config_get_expiry(struct repository *r, cons=
t char *key, const char **o
 	if (strcmp(*output, "now")) {
 		timestamp_t now =3D approxidate("now");
 		if (approxidate(*output) >=3D now)
-			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
+			git_die_config(r, key, _("Invalid %s: '%s'"), key, *output);
 	}
 	return ret;
 }
@@ -2858,7 +2858,7 @@ void git_die_config_linenr(const char *key, const cha=
r *filename, int linenr)
 		    key, filename, linenr);
 }
=20
-void git_die_config(const char *key, const char *err, ...)
+void git_die_config(struct repository *r, const char *key, const char *err=
, ...)
 {
 	const struct string_list *values;
 	struct key_value_info *kv_info;
@@ -2870,7 +2870,7 @@ void git_die_config(const char *key, const char *err,=
 ...)
 		error_fn(err, params);
 		va_end(params);
 	}
-	if (git_config_get_value_multi(key, &values))
+	if (repo_config_get_value_multi(r, key, &values))
 		BUG("for key '%s' we must have a value to report on", key);
 	kv_info =3D values->items[values->nr - 1].util;
 	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
diff --git a/config.h b/config.h
index 3a5016afea..947307c591 100644
--- a/config.h
+++ b/config.h
@@ -726,7 +726,8 @@ int repo_config_get_expiry_in_days(struct repository *r=
, const char *key,
  * dies printing the line number and the file name of the highest priority
  * value for the configuration variable `key`.
  */
-NORETURN void git_die_config(const char *key, const char *err, ...) __attr=
ibute__((format(printf, 2, 3)));
+NORETURN void git_die_config(struct repository *r, const char *key, const =
char *err, ...)
+	__attribute__((format(printf, 3, 4)));
=20
 /**
  * Helper function which formats the die error message according to the
--=20
2.46.0.dirty


--rYhtey5O18mr7y3G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGu8ACgkQVbJhu7ck
PpS69BAAhYJK7XYSSCjxw5vPDkTZXe9PMeV8cjPiRFLbCJbdtOJCT0q0qDvlVp3E
MfkVoDnqa+fWvMHp24IUWY09rw05GiBn1v3dwfmfhPckV9YPJP5eGRUUzahQJ5Tr
Jorm5pw+kglbK27Si6XRToZjelEgo/I3uOyqH8PlA56T3axT+kT+9qjoCI2tbrii
8QkEkL0fn4l9r9nrpwZZNChcHj1zxCSl3I7Dv0Ezd9a31alb5R+FUnDwh6mGpVy8
wEcEYysT74IKAZzEycpmehta7Fd3d9eR6wlWacw4NNiUoCrURL4H2rSnTKk+vIMC
l8c0LVp7nwVIMAT25unqszr59CGRW6AgbDFKbzZCDaTPscOJTa1PykRjFGxd8zs9
2C9+PyLKZruvbTTywxMsXh6Hkf2Rz0/SX8MqWxU3Bs3wegmE52nKEKBSTw2OYbpL
mD7pTnmUl0wk2tY2BOGh0Af5W8uL2FY5Gwy8GphJnLXlO9oaaTFoMB0SHGUGwMw0
k/QDsWM2MqqUsEnX4jELzrnldZSveb2v6Gv9n2gXrAjPJtA/dXkAjLwODDLVBQ37
/6CjAI1kDDKxaTdoHlTZ9auh+Rcq8B8tNE5ljSOJ8QMxYx6C5Wqxqg9R7G84bSX7
c8vtVngJY7xXSwHlcP+FhaKfihbC9n6IeDdoLH2tcr+lrVu0IM0=
=JrG3
-----END PGP SIGNATURE-----

--rYhtey5O18mr7y3G--
