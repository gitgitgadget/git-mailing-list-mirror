Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD9318FC87
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 05:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316979; cv=none; b=GBDoijMZkuRitdfkRu8TLCHOruOfaaBBxbEzikhuZNPvlNpBXF/UR0zfH543te8LsBxxarDzO71T8irJntRdK6nrayDo2X9tUF5attTpD+BKhBTu0dDxFNqyuJtBzH1C5vX5gzfmKnUtA4z9vMG+1noHEgf9eRBabsW4SXXBDDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316979; c=relaxed/simple;
	bh=06DN0cQvCX/xgSQDtLHHFMLnRtBy5XEcKO5VpcKUCII=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjtFUzUZZO+gfgSXaNgYJmcHclTAnUJGRSyKPQyqDeczYXsMTgl5BvMbsonzFsUYTtSYI6J/gHFBMUit2KzSyrfk04z+jHJpkzTa5TSBCv4zoFCQi4E1B/+aPogiSyyBrzcDVNzNZ36WmuA93wdqtILejfx/fOFKeTWomz8/a7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f2JFKXAu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q38+0oPB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f2JFKXAu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q38+0oPB"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A87CD1140446
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:22:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 30 Jul 2024 01:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722316975; x=1722403375; bh=yTfldErJG5
	GJEWbje7S4kXAOi2S++ydZ/lnt3D8e/kc=; b=f2JFKXAuLkbsnuR8CGdSKU4kKH
	x4ULNbXfZaCI2ZtUCeUmzmsj7VbCgPgglfvcK4V5stJwEZ2rbyMAfoyMYNzaEYUS
	btujj2EKWvrzDhfCLyeP9IRHJV0XJe7h5xt8eWQZVocq5nHx/TjFzADZCWrcvVUC
	hMbQqAOGfmIe4n7nirZPiGIV8sccE37ugPpV8KuehOr/pkC2YKnlHupU2WqbpC5c
	IpXFKExsbxJCI7bZBdd+iBQfmftV0eB/WrCTJnTe40jEY7dEwsaffe5lAYgEbI/e
	GZWYdB34IGyPVH9PKzC7YhI52y0aUpEGaRVwqCiZY6dGEOqAryyHsOnn8Nxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722316975; x=1722403375; bh=yTfldErJG5GJEWbje7S4kXAOi2S+
	+ydZ/lnt3D8e/kc=; b=q38+0oPBanuYyOsxOE+RlrMAweBOzo7x+Pc0CRetohh/
	SRzNziFw8uOnLIyKjK/hwtRXFdf2WvsAZ5VCmkwmhYxaO7OrHVCUrcfFYWbknrJY
	VNrkBOtFej5SmpFNNaZDKWSnhY1a/W1SBRiOesZQ4netLOOSM3rDvi2hbg8QZz22
	nNfbD/hRDuGvhyR+zE14fj++pS+ktVWM9OfAOcP3ld5HUxG3g5+0V/sqEJvF8ZQZ
	ECbQ0hitvvPzjsIDA8BuIVHhUKz9/5XbVIiTMz5jEiJVoA1irIeTl7CVKdmyp5CM
	LUgz9M/OGaNZNbsyx68XFFVWL0JkokIQFOove0Jgig==
X-ME-Sender: <xms:r3ioZnFB6GiCN0wdXeGepFLGkS2fHDjny0yBt_XrGSk-efViif1WAQ>
    <xme:r3ioZkV_0e8nyy_ypI9JrTDzt0OD7arhIrl3UNpM3xm4z5ZD3TnVAaah3BJD6G_id
    XiOsChWQA0SLP146g>
X-ME-Received: <xmr:r3ioZpKGh3UK4LnfHYeIfxh3-P9DVUgAG8MZgW5i79X0TweseHcsd0CqobCjxCJcU1Hs30LcZM7AVh6_b39XX5lSvj0rcoZmSEPXEOP-RAQfTCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:r3ioZlHkFr0rJd4MhSSfNO4P-YQAAqbSFTZIAuQeU0pvl-FlRvaNpQ>
    <xmx:r3ioZtXAzwiXKD4Vv0bzTStzXzM76UoPklxvasWtsxc_6R2eflyhAA>
    <xmx:r3ioZgMV92LLNw1uEpebxyRk6q9S8Dp8oqm0TOvwddb0Z5Z2HPz1yQ>
    <xmx:r3ioZs01dot293TL_EBr_IJkQJRP4-SqyC3COJCRXKW4gh3zt_W4Uw>
    <xmx:r3ioZsfIzQFuOHhtcZJEHMIpxiRIHgFwhKsfQ4P4eeqwsbJal_ANqhwc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jul 2024 01:22:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 74b07d38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jul 2024 05:21:26 +0000 (UTC)
Date: Tue, 30 Jul 2024 07:22:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/5] refs/files: stop using `the_repository` in
 `parse_loose_ref_contents()`
Message-ID: <fe0e2c3617c8040c632dbc3de613a1d22e8070f7.1722316795.git.ps@pks.im>
References: <cover.1722316795.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/KknrllWaVMkfP0E"
Content-Disposition: inline
In-Reply-To: <cover.1722316795.git.ps@pks.im>


--/KknrllWaVMkfP0E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We implicitly rely on `the_repository` in `parse_loose_ref_contents()`
by calling `parse_oid_hex()`. Convert the function to instead use
`parse_oid_hex_algop()` and have callers pass in the hash algorithm to
use.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c               |  4 ++--
 refs/files-backend.c | 21 ++++++++++++---------
 refs/refs-internal.h |  3 ++-
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 94a41934d6..e082fc59b0 100644
--- a/refs.c
+++ b/refs.c
@@ -1752,8 +1752,8 @@ static int refs_read_special_head(struct ref_store *r=
ef_store,
 		goto done;
 	}
=20
-	result =3D parse_loose_ref_contents(content.buf, oid, referent, type,
-					  failure_errno);
+	result =3D parse_loose_ref_contents(ref_store->repo->hash_algo, content.b=
uf,
+					  oid, referent, type, failure_errno);
=20
 done:
 	strbuf_release(&full_path);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index aa52d9be7c..3437c79699 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -552,7 +552,8 @@ static int read_ref_internal(struct ref_store *ref_stor=
e, const char *refname,
 	strbuf_rtrim(&sb_contents);
 	buf =3D sb_contents.buf;
=20
-	ret =3D parse_loose_ref_contents(buf, oid, referent, type, &myerr);
+	ret =3D parse_loose_ref_contents(ref_store->repo->hash_algo, buf,
+				       oid, referent, type, &myerr);
=20
 out:
 	if (ret && !myerr)
@@ -586,7 +587,8 @@ static int files_read_symbolic_ref(struct ref_store *re=
f_store, const char *refn
 	return !(type & REF_ISSYMREF);
 }
=20
-int parse_loose_ref_contents(const char *buf, struct object_id *oid,
+int parse_loose_ref_contents(const struct git_hash_algo *algop,
+			     const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
 			     int *failure_errno)
 {
@@ -604,7 +606,7 @@ int parse_loose_ref_contents(const char *buf, struct ob=
ject_id *oid,
 	/*
 	 * FETCH_HEAD has additional data after the sha.
 	 */
-	if (parse_oid_hex(buf, oid, &p) ||
+	if (parse_oid_hex_algop(buf, oid, &p, algop) ||
 	    (*p !=3D '\0' && !isspace(*p))) {
 		*type |=3D REF_ISBROKEN;
 		*failure_errno =3D EINVAL;
@@ -1998,7 +2000,8 @@ static int files_delete_reflog(struct ref_store *ref_=
store,
 	return ret;
 }
=20
-static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, v=
oid *cb_data)
+static int show_one_reflog_ent(struct files_ref_store *refs, struct strbuf=
 *sb,
+			       each_reflog_ent_fn fn, void *cb_data)
 {
 	struct object_id ooid, noid;
 	char *email_end, *message;
@@ -2008,8 +2011,8 @@ static int show_one_reflog_ent(struct strbuf *sb, eac=
h_reflog_ent_fn fn, void *c
=20
 	/* old SP new SP name <email> SP time TAB msg LF */
 	if (!sb->len || sb->buf[sb->len - 1] !=3D '\n' ||
-	    parse_oid_hex(p, &ooid, &p) || *p++ !=3D ' ' ||
-	    parse_oid_hex(p, &noid, &p) || *p++ !=3D ' ' ||
+	    parse_oid_hex_algop(p, &ooid, &p, refs->base.repo->hash_algo) || *p++=
 !=3D ' ' ||
+	    parse_oid_hex_algop(p, &noid, &p, refs->base.repo->hash_algo) || *p++=
 !=3D ' ' ||
 	    !(email_end =3D strchr(p, '>')) ||
 	    email_end[1] !=3D ' ' ||
 	    !(timestamp =3D parse_timestamp(email_end + 2, &message, 10)) ||
@@ -2108,7 +2111,7 @@ static int files_for_each_reflog_ent_reverse(struct r=
ef_store *ref_store,
 				strbuf_splice(&sb, 0, 0, bp + 1, endp - (bp + 1));
 				scanp =3D bp;
 				endp =3D bp + 1;
-				ret =3D show_one_reflog_ent(&sb, fn, cb_data);
+				ret =3D show_one_reflog_ent(refs, &sb, fn, cb_data);
 				strbuf_reset(&sb);
 				if (ret)
 					break;
@@ -2120,7 +2123,7 @@ static int files_for_each_reflog_ent_reverse(struct r=
ef_store *ref_store,
 				 * Process it, and we can end the loop.
 				 */
 				strbuf_splice(&sb, 0, 0, buf, endp - buf);
-				ret =3D show_one_reflog_ent(&sb, fn, cb_data);
+				ret =3D show_one_reflog_ent(refs, &sb, fn, cb_data);
 				strbuf_reset(&sb);
 				break;
 			}
@@ -2170,7 +2173,7 @@ static int files_for_each_reflog_ent(struct ref_store=
 *ref_store,
 		return -1;
=20
 	while (!ret && !strbuf_getwholeline(&sb, logfp, '\n'))
-		ret =3D show_one_reflog_ent(&sb, fn, cb_data);
+		ret =3D show_one_reflog_ent(refs, &sb, fn, cb_data);
 	fclose(logfp);
 	strbuf_release(&sb);
 	return ret;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fa975d69aa..309b382284 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -705,7 +705,8 @@ struct ref_store {
  * Parse contents of a loose ref file. *failure_errno maybe be set to EINV=
AL for
  * invalid contents.
  */
-int parse_loose_ref_contents(const char *buf, struct object_id *oid,
+int parse_loose_ref_contents(const struct git_hash_algo *algop,
+			     const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
 			     int *failure_errno);
=20
--=20
2.46.0.rc1.dirty


--/KknrllWaVMkfP0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaoeKoACgkQVbJhu7ck
PpQf7A//aljY8wOXlKV4Ezs+kd4xlDKWfU/1vaKoAs6XFySZWLtKGwcVSNFDEowV
nZv0IVqu3k4Kl4xjSlkltjH53GdeHWA50/DeW+Mhw7yRCS0TcO0ebwYlu+cB3sjM
n0WN5q4jAlMhyIZG33xjauRr2iq2ubKNQ0n9tJNQwbNqxldnYzrO+hgKKUND5E2q
fJAyL4LFyJ7ITwYM7h/YFXAKkbobiU5CIDi+Tl9YfdnczVFaRCeCfrYc4rWHA26j
Pu6P1fI958Gxc0h8TyANsc+o0FO2k9Slb6Thq/eqgaN25BBhyfXzEV3xck6k8e68
UM7ndYS43aabumWW8FxmEllpz7h/YJ+wF++oZtSFicsTEoMGm/3n61PF4ZuSMsRt
+RtcarBHUgxzyumZM691jWWVIJXGYJ2goMS2ef0SvoieSr/Ah9CIml2ujoP7nWD7
ai1JUAyW69yDPeq+Obbo0MqjQffIpB532TvM7b5IW+ZQz7GR+MyTBH3u9GJZURJn
/AR6k+MjoozVZ3DuXSoQdqp68XPyn9EEfsCno/JEmzga8/a6uluWBbFTiglpi36/
Q+inx33a7Zxp0lAEiIMQ03W66YeGZBPcJt9PMD+x5o77cmTPUfMyxW/Ia0uUAwHD
JdTVaWlSDsHRo4daR6jCP4Am+Itk5oXHvzgj3U6gv+vZX45hVOY=
=cA3Y
-----END PGP SIGNATURE-----

--/KknrllWaVMkfP0E--
