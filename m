Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0453984FAF
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545690; cv=none; b=Qo4q61GxibQHGqROCN4jte9kQDwet2IgaUY4DXJPmQhwlHMKKJEoxvipwz3TS8mozshfDeCdpXigoJJJoUw2Gswscpx8bZ/QQW8aSGp1xIKb2aSrhTw2D7ZYnIDwrMvCNTY/Xjtb/2OSSBwCrS/+Fi9iZNg1VTASwIGNGX6yeF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545690; c=relaxed/simple;
	bh=fXoRGu2pWuopzys3WnPQKe6ZDYDtwaGVLtcPrDn84Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLJ0zQQRygEu0/3Gpf4s3Dj89GKmvW8nKyg6Jc7rO3Lyl/Z6eK+/llIwviGxvLCS1vuHDtZqIa4JswZ+WEcjqX05FzEx778nKw92ayXNswre0Azdmxpsx2Qko8A4PDWjC71qCVy4o5+QgNvUSIfC5oIJIV5IrUTqq444sVP6YF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YTNyqZnZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GTjLneHx; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YTNyqZnZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GTjLneHx"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 24E3B114012B;
	Fri, 24 May 2024 06:14:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 May 2024 06:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545688; x=1716632088; bh=NBDJXp7l1/
	BoONU/nbQ9pQ0vRRsu1LtaZVn8327stvI=; b=YTNyqZnZVUK2j8nDALVd2SxuYB
	MuZbbNpaGLj7c7SiRcdJniyLOoMF0izNWy74W4o4x3t6qR4/FCXEEnI6EKQSYrPV
	Bh+aH5DDwIE3CsAqvnHNJEuaDdmdMe3d1s6saH0OxVlHV4THoNHqI05K9oHlEOpp
	Rh/m/jRmw9SzteV6+jy0hQHheMtphWIMWal9NmTViQXt0czRTOPQgPCTGe739kQs
	lt23ucDar1NRemkgTx9eIhDTvQ48pAAKfzzA9siGBNYEU8EqAc51NsOZdfCz3yr3
	TpNBJDRL0crmkMRKx1Qcgk14EXqpoPCdutdWuPUMRTtDQz2ajgl/DYI6qgkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545688; x=1716632088; bh=NBDJXp7l1/BoONU/nbQ9pQ0vRRsu
	1LtaZVn8327stvI=; b=GTjLneHxEteJVB1pgjk4SHXyWYxru1z4oM+3lEgR+gJv
	ud+4vmESt3FygjQ0k6RqUoUbA2bSVLxnfrUNISpBn4IiREnr3w85aQW7Upc1dhPf
	82cmj8pH6FuyAzdyYghyHx3Jk2KKJ0tSFBbg4nSwohEeIjy/eBZUJiQRdWd7MIax
	e3ZDbi3B2EqHFWB/wqK/DPWOhMRFgAJeZI4bZ1sPAtpq2iGo6ZleGzFhn3/NrSr5
	uLmb7Ld3oaR6f+y1yvl7JXVQNmEjzOtwIgC3R/ApbDi3iTXEWtq6ztbAt9gnutvh
	FBPNSzWnvgLBcEmq/Xt1yZHCpGHoX6FmGurYdDjvXA==
X-ME-Sender: <xms:l2hQZjporcbD6Pr3ltcqDgdo2GLYwdUMVqoPe3BMz5tXaU-J_Qjj0A>
    <xme:l2hQZtqY5wzS5QuN9hzoHiMeKPHTfRBmljBbSnt-j6Ji6gZS8v5rC3hGn83qUpwtU
    ZZz5R5CwK-zeEK1Cg>
X-ME-Received: <xmr:l2hQZgNJSH7f9rsJTvO6E6lJWezEJwsjc46HncfGozjS_ClI8NQwusXBMZ5TnbmUivcTgwsbYW17tnKjSo89Vl6lRe04j3PIehjkwNgiRhhuDBY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:l2hQZm40B-RRClbUtp949qLkx7O-pjNYWlN_0LdcZ-CDVmp6pReFbA>
    <xmx:l2hQZi7r14X8FtWqSC-mfb3sfLkhD3jE9n_vWWYWryE47cT7FeN02w>
    <xmx:l2hQZugSiS0Q74OHzvdzc2OuAns0okfEmsfPFiebAv1QfX58y-UdCw>
    <xmx:l2hQZk4O15ocd9WiVqltT9WnXaoJFsbELlf7tyk8-1X70IJXiTp14w>
    <xmx:mGhQZontmboVpUHmHNidYv1DuYFtAetgRnBLFMqiaGgmel-MfOj_b0RV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:14:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cc81b625 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:14:43 +0000 (UTC)
Date: Fri, 24 May 2024 12:14:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/9] refs: allow to skip creation of reflog entries
Message-ID: <03f4ac6ee7143f6b38e1eb95fb139c8e454136f5.1716545235.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716545235.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g3iiwYgijziC8jCP"
Content-Disposition: inline
In-Reply-To: <cover.1716545235.git.ps@pks.im>


--g3iiwYgijziC8jCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ref backends do not have any way to disable the creation of reflog
entries. This will be required for upcoming ref format migration logic
so that we do not create any entries that didn't exist in the original
ref database.

Provide a new `REF_SKIP_CREATE_REFLOG` flag that allows the caller to
disable reflog entry creation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                    | 6 ++++++
 refs.h                    | 8 +++++++-
 refs/files-backend.c      | 4 ++++
 refs/reftable-backend.c   | 3 ++-
 t/helper/test-ref-store.c | 1 +
 5 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 7c3f4df457..66e9585767 100644
--- a/refs.c
+++ b/refs.c
@@ -1194,6 +1194,12 @@ int ref_transaction_update(struct ref_transaction *t=
ransaction,
 {
 	assert(err);
=20
+	if ((flags & REF_FORCE_CREATE_REFLOG) &&
+	    (flags & REF_SKIP_CREATE_REFLOG)) {
+		strbuf_addstr(err, _("refusing to force and skip creation of reflog"));
+		return -1;
+	}
+
 	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
 	    ((new_oid && !is_null_oid(new_oid)) ?
 		     check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
diff --git a/refs.h b/refs.h
index a7afa9bede..50a2b3ab09 100644
--- a/refs.h
+++ b/refs.h
@@ -659,13 +659,19 @@ struct ref_transaction *ref_store_transaction_begin(s=
truct ref_store *refs,
  */
 #define REF_SKIP_REFNAME_VERIFICATION (1 << 11)
=20
+/*
+ * Skip creation of a reflog entry, even if it would have otherwise been
+ * created.
+ */
+#define REF_SKIP_CREATE_REFLOG (1 << 12)
+
 /*
  * Bitmask of all of the flags that are allowed to be passed in to
  * ref_transaction_update() and friends:
  */
 #define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS                              =
    \
 	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION | \
-	 REF_SKIP_REFNAME_VERIFICATION)
+	 REF_SKIP_REFNAME_VERIFICATION | REF_SKIP_CREATE_REFLOG)
=20
 /*
  * Add a reference update to transaction. `new_oid` is the value that
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 73380d7e99..bd0d63bcba 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1750,6 +1750,9 @@ static int files_log_ref_write(struct files_ref_store=
 *refs,
 {
 	int logfd, result;
=20
+	if (flags & REF_SKIP_CREATE_REFLOG)
+		return 0;
+
 	if (log_all_ref_updates =3D=3D LOG_REFS_UNSET)
 		log_all_ref_updates =3D is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_=
NORMAL;
=20
@@ -2251,6 +2254,7 @@ static int split_head_update(struct ref_update *updat=
e,
 	struct ref_update *new_update;
=20
 	if ((update->flags & REF_LOG_ONLY) ||
+	    (update->flags & REF_SKIP_CREATE_REFLOG) ||
 	    (update->flags & REF_IS_PRUNING) ||
 	    (update->flags & REF_UPDATE_VIA_HEAD))
 		return 0;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index f6edfdf5b3..bffed9257f 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1103,7 +1103,8 @@ static int write_transaction_table(struct reftable_wr=
iter *writer, void *cb_data
=20
 			if (ret)
 				goto done;
-		} else if (u->flags & REF_HAVE_NEW &&
+		} else if (!(u->flags & REF_SKIP_CREATE_REFLOG) &&
+			   (u->flags & REF_HAVE_NEW) &&
 			   (u->flags & REF_FORCE_CREATE_REFLOG ||
 			    should_write_log(&arg->refs->base, u->refname))) {
 			struct reftable_log_record *log;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index c9efd74c2b..ad24300170 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -126,6 +126,7 @@ static struct flag_definition transaction_flags[] =3D {
 	FLAG_DEF(REF_FORCE_CREATE_REFLOG),
 	FLAG_DEF(REF_SKIP_OID_VERIFICATION),
 	FLAG_DEF(REF_SKIP_REFNAME_VERIFICATION),
+	FLAG_DEF(REF_SKIP_CREATE_REFLOG),
 	{ NULL, 0 }
 };
=20
--=20
2.45.1.216.g4365c6fcf9.dirty


--g3iiwYgijziC8jCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQaJMACgkQVbJhu7ck
PpTqKA//R9EmPkWDhiff37agSOyxN31z8xK3DuQMWYK4fXEE1y1RU3954KliGmES
0ssDXuirVmvK3Jpd6sVvG3AH+qTUJQziUdB3baqjFxvUOixMvV2izBQgC7U3ISaY
c1EyWpCgYeRMLkFyopcE+ha9O1NoAgjnSwKE4WIgdbAdtlgBRhhAUcDNzKD3jQ3f
fzAzPksTtr9zQjg+9fKtCR/aA8wzmKu+TFJ8/yGuj+Kvi43tjFDgJrvG7H6pSJwz
n1dNqGXZnJr0/x6sAQBGY9TmyBLC8Cvut+jh1FNsVO3JxJB6rnBzfyzgnzZOain+
HlS+PYJmtPAmMSH1EwvZuIswleza/WaJxaVrHaRHZTirGIzbTXPu0z6a1Bh2pJ5N
QbgDiFX1BvCWEKc1ITGZ1vCsQSkAtgXa52Tl3PEcdO4L50gRGWsmG8jsg72x6iQ5
v/pdAp7m/+ctoFNLCkDNQ5S4PzYW5+u9hKD3Sh9mOwoLFCkaU0GbzZaYH8X3gfbJ
JGwRcLc30otcMYuGmxRGlctmh0FrE8pzP7+vYhfp0CP+txfsK8BiDu/36UlB0cbj
Fni22mjagmWkh85U+KK97s8OmKI7cpXAyf9WFpMXEJo9scADXk+EDflyg6RYHPis
OG+4YOhq0BsLYJQlk3ZICPdY3Beli6AbR6OAWwUIweG6t1odvb0=
=y8sM
-----END PGP SIGNATURE-----

--g3iiwYgijziC8jCP--
