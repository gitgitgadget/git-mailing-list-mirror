Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DB74CDDCA
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968051; cv=none; b=DYNrkMHrUume+J3+GbCobL2eAb7dSBemz+FrrmiUapvk0OYD3xHgptvw1BaVoO+UjfQ5WL3Fn7MgWAVhSlSpjUpFR9PK5sjG2EC4HubzarLDmdRyKvDsWZ5un/vHY4kceZWI9Ddon6SgZYQ/skBVV1rOguNLT3tzMGrUxYHWm4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968051; c=relaxed/simple;
	bh=oqBoQ1KjioLPKX5cVV19FcMqafUqFksTzLMa0FJYQuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLouqey4qZIaIfpa1+N1bW7XgTwIQ173Hd903s9wheGgMFZxVVHYzI/F09QDo5jUdfCaMg/rvJHffNom8vilahWdVEr68g2+AO0O7Hnm7hLeXLc4JQVznRg4c8Ele6YWp9kxXd53DUIuGzuhR9vKB4H3H24RdghWWeKcxW2m2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gkKZUPh+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FjSlmbhy; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gkKZUPh+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FjSlmbhy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72CA214000F7
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:54:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 14 Oct 2026 04:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791968049;
	 x=1792054449; bh=c00reCsmpUiPfZSvnEmm+xsSukJbNKCTmXKuDRQg5nA=; b=
	gkKZUPh+KRYEZM8FwkG+mIxs/lcYPhnp5R/gBoLWsninLR2K8ClbNJyRqDnMf5eM
	iQlbMuO/ARYYuaLFfkEtOR5pOQRYXV1Hbyb/rCIPikkthQz14zUuNgyFHYSmdkeS
	s/sD+Q9jGqo5darm/NVS8ZtzvI9YVl56VhsHGjn42nICVSX+scNhBBWbP4ZBFab3
	KrzZDPbcaEjt2rHAuAT6o6IeikvnCPnY/jOwC1xrjLuNyGW39ttw50PoJFMgUQpG
	cWVK5pA5/sh1V50WSkUUl7aXmgxxHRIq5pBLAPAH8YkdU237m/CiNBfWyxG7HKNg
	OybRCUq1kputQxQPMojpXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791968049; x=
	1792054449; bh=c00reCsmpUiPfZSvnEmm+xsSukJbNKCTmXKuDRQg5nA=; b=F
	jSlmbhyXpX6fM9SUsBW6VFglCGhLhQSWY6Dtx7WxWeFv8lVQ6UwrcQBGrI8rf+/Y
	f9w9vHfGadBqCGvDrrdjHs0JEmdy//Z+NFHZO10uE09mgCUP5czyLQCAwxZCL0TB
	CfSTmte+m8Ad9sHnFXijXwgxOIEP6HhAHUOt8BHAhJuiZZU1jhUsNOlLQeQ5mH0E
	N5CCHZ7a97sgI/jyX+uwt6tuTPGuJXPyD8Mjy2HUIpCrtFKpRHeTUo0xvxeNwlx1
	O7t5EebCB7C+rLwJIFzvBepsimR52BY+RPVJn7w0XjMY783QBsJwWIggWbv+47rG
	tZoQtMTI5B8gKJXOAeAhQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791968049; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DL0NuytDoZJnARUhXJlkEBl+5VUMaFpcK+jJZQwx3MuFyqg
	+UXKkvvg+iRAz02U55W8OTHEqxy0PUSe8SXFTpocFPnBnO5uyW4pdEyQwCwPUepX
	nqGjsb9RnKUzzSuZFHLr0eLd7/C9c24MSfIfVwLDGrK1nd6Jnp9jVokekys5sCxp
	L0vNNsSHMz1/DkI6kb2LZD4Lde5Ix1W8vlsyPNaKzvLImrPMRZkiAw0/wFeXwxmG
	hoS4KjxLb5vxwii/zhu1hdfhs+F51RFLtD/qqSSv1DS1pxuqhsMXmmDCHCY9M1Un
	KhL6EyIaGyOQaqVDo0WtTxsgBx50juPVwjqiZwA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QydIu7YyxzL5bKiIeMwr+XnGm2Gg/G6pFtC9yME7ijA=:oqBoQ1KjioLPKX5cVV19FcMqafUqFksTzLMa0FJYQuI=;
X-ME-Sender: <xms:MUPPat810Ol4O7XLtMzzgkFIJUq_dlyrEa4YQ4HKvpfTxGP8PMe15Q>
    <xme:MUPPaosK0AxG6X1HTz4FJpYtPESwiEdswUO00zMAEPVVL9JMD3L-i9kU2EytJZMhL
    1EzZZM1wBXpLj0QbZrMJbtHCuT1SrRSNJPMNEjMxlZwc91n6MicdPc>
X-ME-Received: <xmr:MUPPagBtGw6RFGy8XWyfH0ljX9TaiLiPsE4pnKZEEwhCRBSIS7dyqQ>
X-ME-Proxy-Cause: dmFkZTEmhPxbaWbmdmiM5YEoMDthvvqhAUT+PKR/t9E8V5ghj/QIC7S7c2AowCcJWUx2Ty
    IszGpMH0nxcrIYvdd/LiEJoDG3jBQeBKGnlQkVIjtcy5ewOb1klrSiTckMthzKvmfXlCiT
    xEVmh4GzpWDY6QhEsKIwwQvKr36ua8q3OVqGGGm6UjfL+5v1GNfFQ1xw/jSxWAwx6TsbAd
    zuvjcrmPGyY2xkKKSCqEw+4getqwIObIDFrJsS/rUYL3LL4a0RPMzuZ9rKYQlumWKWmSzs
    +zvNzZI8bjzyj6OTlrQZJgsfV7snNGycVu11AD4DBUT2jF0sQSI+xvCQozJ9gU7ON8O0fk
    r2nux/RWfR901tDsvOi/DVdmLKOYePtz4gNlZ4u1V1HL7gmCnoZqbhtiGpwhr3qiBbEoJR
    SuEXZ4GdMWKfXZ3g4s4m3Z14ppxSDwkT091H1IoAQQTdESK3mpu3h6CkM0qhtW7Pd7xBUW
    P4lIldUr0oJOVJgiBigNmCIIlK/r6Bm1ZeU0uUxsUUoXMzhvN5QiELgbLY8cMj8rjfA9G5
    FPTt5ksU5Tb5kvc8RJkhhLA1YwlIft5wVrBz6B4XBT4Z+7jAF2T/9J61pkW1CU5FIb0E/9
    NtBT/EC2zgK/8Y3P3Or1L2Jir66eip3Gc6LP2eBhV/Yjzk2b/ftGKL2la/Kg
X-ME-Proxy: <xmx:MUPPagV3u_rVvaBJ-bitHjvJ11mK0MSySvlMBUmT0pRmuveyD9j9IQ>
    <xmx:MUPPauBgnepcgrlw6-XLECNfJlpRmJjZlzt4URaMV0kha_rbm4Ia6w>
    <xmx:MUPPaj_NISeuifazWiHTNC_gf-QgrPN5ykWSo2W1RQ5lY7-M-Oc74g>
    <xmx:MUPPalERymfk9JshJ-q-JzAdwrgLTM0s3IE8un0zW2_Rd6A5rt2DsA>
    <xmx:MUPPas4C53fcWI5CZ5hXHDRcI7dwYQKcWtOHWUKmWI1SZwoMyjn6HII3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:54:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9e0a482 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:54:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 10:53:49 +0200
Subject: [PATCH v2 5/6] odb: don't try re-fetching corrupt objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-pks-odb-files-alternates-cleanups-v2-5-fed9b2caa3be@pks.im>
References: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
In-Reply-To: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When we failed reading an object in a repository with a promisor remote
we try to fetch it from the promisor and then re-read it. This logic
kicks in not only when the object couldn't be found, but also in the
case where it could be found but the object is corrupt. It feels dubious
though to just paper over corruption and proceed as if nothing has
happened, happily fetching data from the promisor.

Adapt the code so that we only fetch objects in case they are missing.

Suggested-by: Justin Tobler <jltobler@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/odb.c b/odb.c
index 095183aec0..2c93a9490c 100644
--- a/odb.c
+++ b/odb.c
@@ -265,7 +265,6 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 	struct strbuf corrupt_err = STRBUF_INIT;
 	const struct object_id *real = oid;
 	enum odb_read_status ret;
-	bool corrupt = false;
 
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
 		real = lookup_replace_object(odb->repo, oid);
@@ -278,38 +277,27 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 
 	ret = odb_source_read_object_info(odb->source, real, oi, flags,
 					  &corrupt_err);
-	if (!ret)
-		goto out;
-	if (ret != ODB_READ_NOT_FOUND)
-		corrupt = true;
-
-	/* Try to fetch the missing object from a promisor remote. */
-	if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
-	    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
+	if (ret == ODB_READ_NOT_FOUND &&
+	    odb->repo->fetch_if_missing &&
+	    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT) &&
+	    repo_has_promisor_remote(odb->repo)) {
+		/* Try to fetch the missing object from a promisor remote. */
 		promisor_remote_get_direct(odb->repo, real, 1);
-
 		ret = odb_source_read_object_info(odb->source, real, oi, flags,
-						  corrupt_err.len ? NULL : &corrupt_err);
-		if (!ret)
-			goto out;
-		if (ret != ODB_READ_NOT_FOUND)
-			corrupt = true;
+						  &corrupt_err);
 	}
 
-	if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
+	if (ret < 0 && (flags & OBJECT_INFO_DIE_IF_CORRUPT)) {
 		if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
 			die(_("replacement %s not found for %s"),
 			    oid_to_hex(real), oid_to_hex(oid));
-		if (corrupt) {
+		if (ret != ODB_READ_NOT_FOUND) {
 			if (corrupt_err.len)
 				die("%s", corrupt_err.buf);
 			die(_("object %s is corrupt"), oid_to_hex(real));
 		}
 	}
 
-	ret = corrupt ? ODB_READ_ERROR : ODB_READ_NOT_FOUND;
-
-out:
 	strbuf_release(&corrupt_err);
 	return ret;
 }

-- 
2.56.0.212.g129ede20d9.dirty

