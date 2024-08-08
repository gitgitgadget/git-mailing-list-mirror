Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787EE188CD7
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102557; cv=none; b=Nrs0vqR4FfREgIGbsCxJChIsgeBK/gU41f/XtC75EEYJymeogFNnOATEwU5dxz45B1cnp7s9iYCpz0TjUlP4SmshcX5cRxlkEhFu+X7oHFjliQBpMy0FZZengooztgmxFUHHtYwkzmt5ypFFfwJ+Iq0orI97TyL7CvMfnK6WYRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102557; c=relaxed/simple;
	bh=/CxbifL3mtx9yVwBeniXWGaFTP7QDrvCeer9Y52Nsc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxFgGjhoMzADsVhqIDUJ4bk636pKYxGZDxgfwHN/L8uiWWbUs8FgWD4RsCSaiyk+wlFZCpwHxPm9B6u+xP7RLHBX6W1MXALVLHCsVceYdRuemAnJ6vaZvyNeTXbFcZFfpNsloKNfvhZZhVV/elqCMa+OxqbzBgFQtz4gcEscDWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UUTSTNRF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MM+Lxfw/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UUTSTNRF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MM+Lxfw/"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B638B1151C3B;
	Thu,  8 Aug 2024 03:35:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 03:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723102554; x=1723188954; bh=rPIKWxe1g/
	n96DafRJhm9L6URSYkbDWkBQ/J9bq0kfA=; b=UUTSTNRFjf/yMhDDFndW1wMV7Y
	qKI6OcYmLPNJFaHKcxTVGSZW+XUteU4tRTAmahC9k4VufVJYc7hRMFkCC9mekofC
	iqXscP23cVj/lUqSPM93PJPW5Eqtaq15/Rr5iYPpjT9/+Lxye7kTBEQnJ7W6vHkc
	Vl/NPu9QWWgIMJAHWzZD9vXdR3rG2fFMIvfy2wJO6iQ+VykIClveRJZASsftC9sF
	RNwRsLgHsE2Ic2CmPfL+f0XY73PQYI8xCzbgfnkz7n9EOPAQSoYdCxL5lTZjkycY
	7q7vfkJkuJNEZaXvSKu/tG2WCS7htr2RS9Xk7fW5slLy7EGspowkKpvDg0kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723102554; x=1723188954; bh=rPIKWxe1g/n96DafRJhm9L6URSYk
	bDWkBQ/J9bq0kfA=; b=MM+Lxfw/p0N2fIcQkCdx0RCZ0KK7X0A9ItqJjKj1S5r6
	IQhk3iBGFVh2NorLiTQng6hRARHw0X7QEsZl4Pb0+JAPWGOxSeWDlytaAPuiVZQ4
	S4Uny9fqSXIEZWvO+n5ccgyrQc6PawT0y5xDt+jLdEm3ueIY+O74yiJTjR0anm2p
	nbaW9uj9ILWpSAHQK/RFnM3VOX1AnYMIjeJW7KQMmzcKZ/GUrm7C/6uRAus9vr4G
	1gzUavv/4pLrgaBEhBCjmgj5YfCimwbabfqzFwVyGonjsRYCYztpE0Cmvluhan8q
	29z8qu+6zNMGlFsbrspLGYlW5imRywQHqLvjSbnOtQ==
X-ME-Sender: <xms:WnW0ZmpcG7_GgZqN7HviPniqUormYJfrTrWYSZhkZX6m13zYlUheqQ>
    <xme:WnW0ZkqxW1ny_J6SjiYbQhUXrQHaIoY0_1x32JVho1Fm5vOzblT4j8FUzGP5DD7wQ
    TTiPlzB0PS8UTU5LQ>
X-ME-Received: <xmr:WnW0ZrNQ6wB-LF70CwKYr1d_OGjtbP7Zf0mSF_02rImCoosqNN7qp9BiuUZ9TZXc0qufWyOJfOOQEKNYA1KhGX4s-0fmpnCGJPkCNZHEw33VlgkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeg
    hefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjohhlrghnugesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:WnW0Zl6ambLL5CDfI-Yvt2vzGjca89jCpSDS6RCN5aEF7RTznMoPHQ>
    <xmx:WnW0Zl7yAhuLWOg0CDYGJhY6DkkFmKIvgykEEuK1a8DiymLodMG6hw>
    <xmx:WnW0ZlhCkJl9w8Al41bsto-0tmwAZ9PP_Er_SLJJkfrHbX9JiFpKXw>
    <xmx:WnW0Zv7gxOlHgjmcIfwGSTRxfBhA90ISNK23cdDfNKyJgblv7MxwPw>
    <xmx:WnW0Zo1RxgU20eKQvIyraD7FqpJy7Mr4WvkjXme1f87xyL0lLD1q5fEF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 03:35:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b7a4ec17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 07:35:47 +0000 (UTC)
Date: Thu, 8 Aug 2024 09:35:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/8] submodule: fix leaking fetch tasks
Message-ID: <d92770290f6fa3f1296f1ff9bdf8046543b6c34f.1723102259.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723102259.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dJsSu1bYoesNW7dR"
Content-Disposition: inline
In-Reply-To: <cover.1723102259.git.ps@pks.im>


--dJsSu1bYoesNW7dR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When done with a fetch task used for parallel fetches of submodules, we
need to both call `fetch_task_release()` to release the task's contents
and `free()` to release the task itself. Most sites do this already, but
some only call `fetch_task_release()` and thus leak memory.

While we could trivially fix this by adding the two missing calls to
free(3P), the result would be that we always call both functions. Let's
thus refactor the code such that `fetch_task_release()` also frees the
structure itself. Rename it to `fetch_task_free()` accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index ab99a30253..f027a6455e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1496,7 +1496,7 @@ static const struct submodule *get_non_gitmodules_sub=
module(const char *path)
 	return (const struct submodule *) ret;
 }
=20
-static void fetch_task_release(struct fetch_task *p)
+static void fetch_task_free(struct fetch_task *p)
 {
 	if (p->free_sub)
 		free((void*)p->sub);
@@ -1508,6 +1508,7 @@ static void fetch_task_release(struct fetch_task *p)
 	FREE_AND_NULL(p->repo);
=20
 	strvec_clear(&p->git_args);
+	free(p);
 }
=20
 static struct repository *get_submodule_repo_for(struct repository *r,
@@ -1576,8 +1577,7 @@ static struct fetch_task *fetch_task_create(struct su=
bmodule_parallel_fetch *spf
 	return task;
=20
  cleanup:
-	fetch_task_release(task);
-	free(task);
+	fetch_task_free(task);
 	return NULL;
 }
=20
@@ -1607,8 +1607,7 @@ get_fetch_task_from_index(struct submodule_parallel_f=
etch *spf,
 		} else {
 			struct strbuf empty_submodule_path =3D STRBUF_INIT;
=20
-			fetch_task_release(task);
-			free(task);
+			fetch_task_free(task);
=20
 			/*
 			 * An empty directory is normal,
@@ -1654,8 +1653,7 @@ get_fetch_task_from_changed(struct submodule_parallel=
_fetch *spf,
 				    cs_data->path,
 				    repo_find_unique_abbrev(the_repository, cs_data->super_oid, DEFAUL=
T_ABBREV));
=20
-			fetch_task_release(task);
-			free(task);
+			fetch_task_free(task);
 			continue;
 		}
=20
@@ -1763,7 +1761,7 @@ static int fetch_start_failure(struct strbuf *err UNU=
SED,
=20
 	spf->result =3D 1;
=20
-	fetch_task_release(task);
+	fetch_task_free(task);
 	return 0;
 }
=20
@@ -1828,8 +1826,7 @@ static int fetch_finish(int retvalue, struct strbuf *=
err UNUSED,
 	}
=20
 out:
-	fetch_task_release(task);
-
+	fetch_task_free(task);
 	return 0;
 }
=20
--=20
2.46.0.46.g406f326d27.dirty


--dJsSu1bYoesNW7dR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0dVYACgkQVbJhu7ck
PpSUKQ/7Bj1Zz4tYJE5dflTHHy9N9eiHVRF9Jb8HAAoo6CVz6Y7zZfwPw0ctH19H
k9qS/UfBUco4F2CmejfLZEBjB2wFv5mN8KJK1bVFTSBxl9Dn/gQghtgKmmlg1epE
5U7t5KQ8LXFXw3vLbVf2O8DeUFHQIJ/5rSwmlQpXYlX2UD9OyESoJe/EaiQr0E0S
4BzboCE49uMqm8Sww6+TvpAlWdaKJImNBG7FiJaAgRvpIA1j7hyPwwFSJrKTO27s
mQK68SVTo9ea5UjOuMV5nnfjvtzjOPAna6sJsTztCiUV/Fn3/e80QrFI6Lv1JdX4
bWIPduiTtz4EV+lGyACRALIsaHkySomU1zUQ+VT5s7tjfWF7wQwMwBqisUDEVwa8
MqngQwi+mqPSdOK6IAt0zjDJG92N9KStty1i/yV1cC7feMiescVF3hZ83jlxVVkr
C7XSMAM4O/MQiO+8GfCKaPdr6fHotKdBi9uCUDq+EgWyHsFviDolb6oDs58VTlcl
4vw2eSEPePlO1w07kP3arJPBH59m0rTNkdlcMpX1xmGqluq47xJu/umntZmOCoKK
b6Hlj+/u62AJVnbWzEMv8Jn89QiM8+qc3DARaaMwwZ6MHDQDb/JLSMcRgPxzJgO2
vmdLeEsV2in+sUfjpIcnT83N+7m5oihuVJqKhS7zIA5xVPk7A+0=
=ftz2
-----END PGP SIGNATURE-----

--dJsSu1bYoesNW7dR--
