Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09C169AE6
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 05:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316972; cv=none; b=I0GNsQwYy4FpK4gzAba7pYmvZMkGdlWxYYKxFL7Gzc/FMo8NxEn8qBOuFsaeY7/XynBfY1+6EEXl/ytlfHSX+qosx9DgDyke271/Sa8jtts+WE9Hsktl5BvkKE8f0r0yIwXloKiWiygUJsM7vcjvRE/eAcnKee5avxEzTxJLSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316972; c=relaxed/simple;
	bh=e/a5iOlmKSZOwDKftKEiLcxb8JPNrLOyhG04yqIazZY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4sa2ZDqSDDpVkNK+5GjbxUEaFi+tFz0NTE7PPCOtaaRk0xy1KkYll2fPlh7hiB71lBq8/PldpVXTh9Vh4/2REQT6iZLJuvVQYe1RQtxsrau+smCyVCs54aa8yYwF3P6mWCbg6QEmI9IpnlIAIx/fR4hI792lnsS4oTyZ4YPqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dzcxDQIv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jmnVB+Gc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dzcxDQIv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jmnVB+Gc"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CF653114046B
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:22:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 30 Jul 2024 01:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722316969; x=1722403369; bh=7MWSQs4DbQ
	aPlrobgGvb2tFjXlVw51dA63CfXka5VYo=; b=dzcxDQIvtyU3g2w8lb2k5OiBLo
	wq/uYYgqNw3uPG5kFZBzltY0yFayag/IUpAfF/37uTuBzvV4y0gORQIcXHTYQZC/
	U+bguo6+WkMKwO5qSjhs4gV4v7VgKoYnPG9lnVKDYyFDDurgSe1aH8F3sRR+H2CP
	zwf3f14AHz8KceuYH4Ldb+TQAzhcylkIF7BLG/XuNUTj1YEC1VZpwY5/SaDjoCGw
	bFIXmDsWyqNdu+oCVubuC8HJRjwwvmTz33E9BHcSNdNqMiu7G8j1WPQgMBpWhG3D
	xeyfFS74pFYDF9tnfA6Ja1w5RMQnn3sjO2LkOAxeNE06lQQmbMoldGUJlsfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722316969; x=1722403369; bh=7MWSQs4DbQaPlrobgGvb2tFjXlVw
	51dA63CfXka5VYo=; b=jmnVB+Gcbhh1ZpLktdektnkzeBcKxhqRPyCUbKaql1HV
	qneUPABvar4zzxBx2m2ZSOLgaFWtyEpFBuf0zvabEAMEiMHujexM/85xMF7xN5TX
	dCVpiMAEkaJvPJagWDEwriAyYv3YBrsF/AA512E4AyFGZXWhFvnZFnS6PShkSIE5
	z/yExZBlLsipDG8iZI6SOMKvjQ7IhTdmTLoYrNjtGPY51hVfSlnNNMd6ZfefsLhu
	KiFu3uDsXU4QFCfRw0iJEuOti/VvQloeHy+rpPDzcJmQg4dgE28QnKdSf0vk1Uz/
	OlyPi14ImsK0s1/it70/xT/JPIYkfO9QQnwIVldwvA==
X-ME-Sender: <xms:qXioZva4zl6gCW7VQoYaTpThSOr_0_UCVkDxvE3-2xfMR0bXyd_4Vg>
    <xme:qXioZubg7zZ-yqzwzbfuUdO3u75eFc6IcGjH-gkPMqHTBXaRr9_St-jktIjpNqQAR
    -Rjp5bs-VOqArKGLA>
X-ME-Received: <xmr:qXioZh--maeMTsD5nqmqR_oOS2iUxmLWgjVMIekiKdq2eTkRZS7x_QLEsaNPUjml9U_K8DNHFr5in8tdsPez1I2NMJyhgGtv9l7fD8z9VZJcjEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:qXioZlo5vejdJBMN_EhTt0fbFzafqy-csXAdeyzxnQscQHnUdbTuxw>
    <xmx:qXioZqoLVEE9TpBL7tigdhnX0mj4_A2C-SseQEui_2vcMA7lzjorig>
    <xmx:qXioZrRP4gADuHTHPCqgD1Hl_U3XKV236IjAXcdqONppwhBODxiu-w>
    <xmx:qXioZio5hbie8LRnk2NfmdlI5wux_JPKEmUdLeuh_s4Atg2nOwNRnQ>
    <xmx:qXioZvBVXNJGe907IVQ2hXluO9tGlIbQDOHlHQB6kkko-rY2BRxtPT_6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jul 2024 01:22:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 54e86b30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jul 2024 05:21:22 +0000 (UTC)
Date: Tue, 30 Jul 2024 07:22:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/5] refs: stop using `the_repository`
Message-ID: <482a06560a6e6aa27469b355e8c81034a8867a40.1722316795.git.ps@pks.im>
References: <cover.1722316795.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LbQk0ZNhR5zdJJUb"
Content-Disposition: inline
In-Reply-To: <cover.1722316795.git.ps@pks.im>


--LbQk0ZNhR5zdJJUb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert "refs.c" to stop using `the_repository` in favor of the repo
that gets passed in via `struct ref_store`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 915aeb4d1d..94a41934d6 100644
--- a/refs.c
+++ b/refs.c
@@ -2,8 +2,6 @@
  * The backend-independent part of the reference module.
  */
=20
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "advice.h"
 #include "config.h"
@@ -1838,7 +1836,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store =
*refs,
 			    failure_errno !=3D ENOTDIR)
 				return NULL;
=20
-			oidclr(oid, the_repository->hash_algo);
+			oidclr(oid, refs->repo->hash_algo);
 			if (*flags & REF_BAD_NAME)
 				*flags |=3D REF_ISBROKEN;
 			return refname;
@@ -1848,7 +1846,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store =
*refs,
=20
 		if (!(read_flags & REF_ISSYMREF)) {
 			if (*flags & REF_BAD_NAME) {
-				oidclr(oid, the_repository->hash_algo);
+				oidclr(oid, refs->repo->hash_algo);
 				*flags |=3D REF_ISBROKEN;
 			}
 			return refname;
@@ -1856,7 +1854,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store =
*refs,
=20
 		refname =3D sb_refname.buf;
 		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
-			oidclr(oid, the_repository->hash_algo);
+			oidclr(oid, refs->repo->hash_algo);
 			return refname;
 		}
 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
@@ -2011,7 +2009,7 @@ struct ref_store *repo_get_submodule_ref_store(struct=
 repository *repo,
 		free(subrepo);
 		goto done;
 	}
-	refs =3D ref_store_init(subrepo, the_repository->ref_storage_format,
+	refs =3D ref_store_init(subrepo, repo->ref_storage_format,
 			      submodule_sb.buf,
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&repo->submodule_ref_stores, "submodule",
@@ -2045,7 +2043,7 @@ struct ref_store *get_worktree_ref_store(const struct=
 worktree *wt)
 				      common_path.buf, REF_STORE_ALL_CAPS);
 		strbuf_release(&common_path);
 	} else {
-		refs =3D ref_store_init(wt->repo, the_repository->ref_storage_format,
+		refs =3D ref_store_init(wt->repo, wt->repo->ref_storage_format,
 				      wt->repo->commondir, REF_STORE_ALL_CAPS);
 	}
=20
--=20
2.46.0.rc1.dirty


--LbQk0ZNhR5zdJJUb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaoeKUACgkQVbJhu7ck
PpRZkw/8C9DW+ZMGwuE5IS0jQIrII/QG3/YO9itebYcmYK787kf6Kj6D8I5AyrUd
L2Bdn/TXXsx6jV4J2kHp3n4KmgOqgSFtpo4ermrlsPqhqcx5nE8aVxUA+6+hmUWa
vmFfvtmCB+FytnoF2BiZ4W/X8KnpvCAr8opSET8WHXzqNYAEJOggSQhfZRWhAvKu
x2Ioz4oTHQ6QS7GHGoifC8PUO3SDFF4WwpmiHXndE7G2Qd5HDC7t+5rKLCgDUnOb
/3YE7ev9gOgZZALOHmm/IygqZCfw64CvqY39IaqS6mdwsxIB9UjAL2h5pB3+Gb+q
JlY1SYB6J8LIvz6OuKVpU7Ybw02gSQq84pdtwEoRk6yQVS0UbXsj2Bzk8peQPWLU
XrXbCxV6aYh0v5uHdOZf256WVbxHMAF+42POcVIWVZzgczXkTw5DDWePU1SOuwA2
TozjILu4OoWlDhwIcX5IKOGGJeCBBxG/eviFe97726PR7Z4bipbTjvioe5I7OJuN
MaLiwuxK52c4zZ3uQP+xqyW2qs8omt9IDoCDKtlcA6H2k3yNknxVvwm8SiNM/ruu
qnQnxHmWhWgGozYZO9+k4TzF0bknUqexXQe/bZ//XzuJy/x1lm0sP0L4XPmAo5Q1
qUm+ix6crWlRBdT1JnWqiI/XHTIEoAJcrhayb+UKYMBwVccVkXI=
=cKpe
-----END PGP SIGNATURE-----

--LbQk0ZNhR5zdJJUb--
