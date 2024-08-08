Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC56EEA9
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122313; cv=none; b=n3RjvEDA0EUMumV9hCd14ntYWd1H+KgnVBQ31wrS+ROJSg4/2TUNgMlqLnkrepoI+fKIlZkUOzUBoI1UIz1mqiLfydJXcUC6fLuRLk+v4qfNpk4DBTraN06cByfqFpVugmNsDXMKhUpvUeuoufntfrdYMqX6dVvDpW2qV6FIUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122313; c=relaxed/simple;
	bh=oDLchzGe7Ee4MU7C6VSnikCZtYxYgD+7hYI1cRC7Xlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=md9Yb78oU6JFfITMSf325DMb8BPh1Bwl5YfVeNVOsO+mLW0eh52sGRre8vdUFDpjMsWYg1n/zf27kRi4TP9bwBFnde8+olBXtKyKACWCy0fr8yFTlNpBVNT0lbiobwCESdLjTac6pkBIagtFB/OlqtpzfVWpByqMWjvrx6eM1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LF5imQVY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QzSNHVYh; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LF5imQVY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QzSNHVYh"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id C814F138FC70;
	Thu,  8 Aug 2024 09:05:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 08 Aug 2024 09:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122310; x=1723208710; bh=8+nj5Y/mx9
	6wWp0Ob8myx6K1tynKti+ImBJhz0/x9Ag=; b=LF5imQVYFr04KXmUwtKOv6bLCO
	xaJSJ6J4SUbAuENZ+c+xOZ7ODSO5/N8+TAWdaqrJNlq3m0lj/cEoG3T/c9uIBjsw
	cVfE9l3bmNwjT3XLOTRpduvrh3VQImYCfKJMqz8vJVOW0GlO8WZ+N/8Ox15QFcGr
	n0tkwNTEZzdqTp56O4j+GkhT8eF3LXTbijXmPBOaQMRWqDHONmuJqXFmTgvGh/rF
	2+VbKUb+msyijpC/hWIGorO46NVkiuaHanqHkq8sSTp1WWLx1Osr+RRQ0uqCPyM/
	UgjraXqMACi0MjIiWgcxlzUUDc33/a8bp5INlhytbmh54MQPm5FEQ/DaIQNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122310; x=1723208710; bh=8+nj5Y/mx96wWp0Ob8myx6K1tynK
	ti+ImBJhz0/x9Ag=; b=QzSNHVYh2Fqfprv0/YBtvJjaA+dXuqFlq8AYniNwzZF5
	AfHFX0EGi2V9mXgeEfusKzwEXPB0rjpkr5KFlWySR98xw2zhMkfSJbGTguYQF5tC
	vRtXai4jxqcQ9jzIW6mJ9fwczDjqRfUCyM0mvhLf2Y4RZZFrj5RuSyRkOVgOD9Mb
	aYz45M/eq3I2DX2ebYA6nJrLe2zv6YI/MyGHUIEv71f1yOrax/dzp5CdZKTKCr3W
	zcH/JHeyB2efErtt1LByOj0E/jHNYT864+QOXIfyjb1Lbs0vWNHBeB8oZueXh/VK
	yPapWC2wmEXQXRrlUfIkYF4poJcmJ+diQ0srjaLQhw==
X-ME-Sender: <xms:hsK0Zh7pdmHOteCPJOaftGR8jRO3q6KUAasQDmci7pNwUCU4CXjJow>
    <xme:hsK0Zu5RsIhcWsOOuCFg3UL7PrPfc_Ge8HIklwBTwCOG8jYrulYZbJOT9MDB8nu79
    qb1667NL7JUDnVwOQ>
X-ME-Received: <xmr:hsK0ZocOd39QMNUu_IgwWA1bSHCzD0PBSNpEw3SRJU8qp2YzJxJbFCUze9d3p-AyeCFgggiUNowOZdH76A39u-eSBDh8ch8BtOGWiH9j-afN7jPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:hsK0ZqLlFfh18vC-xC0Mvmqa6eXedvVkSnDLj0ki3M9RKNQPl8E_0w>
    <xmx:hsK0ZlIWPrdw-tEDwflK881Wq9wyQGff56prw55lQomn35M8_gYRqw>
    <xmx:hsK0ZjzJ-_2x1atpqVUM9gVv2R6aLcjzcSa-1zO4bd02YYXnl7AaTA>
    <xmx:hsK0ZhIo7ljxdo1xdEdQ2cz6S3FcN6HLy54d4TI5lOWSV1sTmEhCdw>
    <xmx:hsK0Zl2axV7yYWsuyYWhtyR736626cuKU-IYTtezbmqlQfO8CUmKLzyA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:05:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a16f6a9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:05:02 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:05:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 08/22] config: fix leaking comment character config
Message-ID: <8fbd72a1002d1a285847c62b5524041927a7b4d4.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m8XioyM4axyh91ld"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--m8XioyM4axyh91ld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When the comment line character has been specified multiple times in the
configuration, then `git_default_core_config()` will cause a memory leak
because it unconditionally copies the string into `comment_line_str`
without free'ing the previous value. In fact, it can't easily free the
value in the first place because it may contain a string constant.

Refactor the code such that we track allocated comment character strings
via a separate non-constant variable `comment_line_str_allocated`. Adapt
sites that set `comment_line_str` to set both and free the old value
that was stored in `comment_line_str_allocated`.

This memory leak is being hit in t3404. As there are still other memory
leaks in that file we cannot yet mark it as passing with leak checking
enabled.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit.c | 7 +++++--
 config.c         | 4 +++-
 environment.c    | 1 +
 environment.h    | 1 +
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66427ba82d..025b1c4686 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -684,7 +684,9 @@ static void adjust_comment_line_char(const struct strbu=
f *sb)
 	const char *p;
=20
 	if (!memchr(sb->buf, candidates[0], sb->len)) {
-		comment_line_str =3D xstrfmt("%c", candidates[0]);
+		free(comment_line_str_allocated);
+		comment_line_str =3D comment_line_str_allocated =3D
+			xstrfmt("%c", candidates[0]);
 		return;
 	}
=20
@@ -705,7 +707,8 @@ static void adjust_comment_line_char(const struct strbu=
f *sb)
 	if (!*p)
 		die(_("unable to select a comment character that is not used\n"
 		      "in the current commit message"));
-	comment_line_str =3D xstrfmt("%c", *p);
+	free(comment_line_str_allocated);
+	comment_line_str =3D comment_line_str_allocated =3D xstrfmt("%c", *p);
 }
=20
 static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
diff --git a/config.c b/config.c
index 6421894614..cb78b652ee 100644
--- a/config.c
+++ b/config.c
@@ -1596,7 +1596,9 @@ static int git_default_core_config(const char *var, c=
onst char *value,
 		else if (value[0]) {
 			if (strchr(value, '\n'))
 				return error(_("%s cannot contain newline"), var);
-			comment_line_str =3D xstrdup(value);
+			free(comment_line_str_allocated);
+			comment_line_str =3D comment_line_str_allocated =3D
+				xstrdup(value);
 			auto_comment_line_char =3D 0;
 		} else
 			return error(_("%s must have at least one character"), var);
diff --git a/environment.c b/environment.c
index 5cea2c9f54..1a95798d5f 100644
--- a/environment.c
+++ b/environment.c
@@ -114,6 +114,7 @@ int protect_ntfs =3D PROTECT_NTFS_DEFAULT;
  * that is subject to stripspace.
  */
 const char *comment_line_str =3D "#";
+char *comment_line_str_allocated;
 int auto_comment_line_char;
=20
 /* Parallel index stat data preload? */
diff --git a/environment.h b/environment.h
index e9f01d4d11..0e0906f125 100644
--- a/environment.h
+++ b/environment.h
@@ -9,6 +9,7 @@ struct strvec;
  * that is subject to stripspace.
  */
 extern const char *comment_line_str;
+extern char *comment_line_str_allocated;
 extern int auto_comment_line_char;
=20
 /*
--=20
2.46.0.46.g406f326d27.dirty


--m8XioyM4axyh91ld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0woIACgkQVbJhu7ck
PpQKcw/7BQmR0h42ksVJEAY/NR8iWs26llEdoOzCiOpB5/be0KEHXYHGSEckl+n3
cMX4MmVp720+3H8S24PP0Aap82pTjx5HOqkdsnYefFJAfKuVWcAD2imrBviQaIf9
tBCFyivLV2bSfZ7J49Eh3X3jI0+gWpsSQqFRZ897bd0FyLlUgpuhQ4S4NPMrNOtN
+//hqzB+MpmfKWap54byi4UbUnnDf7kZZr+HnCxhuv4itLBGEDTUtUk5olgB5hUL
gkn9b1+i/dhd6AM+Q8NBour41Xq9q4DBeowEnKVTQt2ZtwpSfIcVu1ZLXKaP1KG9
8bqdV+R2NbN9dQ21jR2nar6msNJkVaiJh9BispWpUAjyMT0UWnLH8l0CEaHNbKK9
OJLR05J96xJCMjn3v/5oGt2ch4YNMD1qPX9Qm6dAWyQ72f65nvUbIxJT8YrFKHaP
aDoizx7JeuWh+mo/5qWJwFNNBHxYdrVsWaz1bR4S/pllUF16ptMzrBpdyckihZhJ
K4/QeaRtxd6EXo63OjFpBW8IwrakeqgVDNOMbjO0JT70/ddM9ahiZTr9+ej8niCN
vNP+TAaEL2xzboTgqSH5vVqlqXWNqmjPlYxMvHP/r6jVF5+DfeHJXqThb2veYrG9
b4dle3k/38L21iusAqJRChS1JZBGJ7cpLvazc3KzFBBdGld91BQ=
=dPII
-----END PGP SIGNATURE-----

--m8XioyM4axyh91ld--
