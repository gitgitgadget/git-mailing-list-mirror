Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FFC13C693
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467203; cv=none; b=I8UcShD+KLU5Ejd6u1/Gi5ExUIVsFUDBRY8xi0uW7NSQD4HvZb3vjHP3x8hDw5N1SySbgdoagf3TdJkFu3GoY8VicMrS4rTaJXqfFoFqBRtcX52I4jdX/ejRZHwgoGhZ+IJPqxzRvxdoCoDsF/P+Rs6EFg7ADtce6JxoReAv2O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467203; c=relaxed/simple;
	bh=9AniqPux0QTOfdftXRazsUzyHNrRGrQvKS2u/YvrOuY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgV0xsJ/b7q/5sUozdhdeKecNZdmjzV908j+lZeGLNm0DxsOcbiOveRItG9Loty0t3kABGTQ3crUwzRiwumeYdHkBToL3WAwBIrdSZyZIpdYvTPbhXLOBWzw5im1If0RNojtcCuj+D2zAZYdJET+wqX9Ez9dBJRMKk1uVYrW7Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xx9cyikR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iFUMoqcF; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xx9cyikR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iFUMoqcF"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 53D6A1C0011F
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:26:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 May 2024 08:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467200; x=1716553600; bh=A/cQdrZirG
	beEENhoaAUBBL4qstXgMT2xgPS5U8ofB8=; b=Xx9cyikR+nyzeBllrnLvwqlQPa
	6xfhYBzOrIeWpet1a6LEbIP23JCqWGCGcWvyEMUgCx10K80Au4M3XBHjGPO/88Jg
	9IkKI+S8hAwh//XFqNwbKRO95MC2hIv2/If+T36k/NFPnHqibypLyxzt0cHSM5+X
	HOBhUOxg0asclM3e7w7TVYFW4E6afW2EJ8LbqCqN0/aCawlG/eW7zPoIUzOV5UIJ
	ElcJmSk+sBXGaZBfbrtzqipstgdbOUtPLHTeMuGhf8DCgMlqp1y/d1SGA2z+T7LQ
	OT7lM5yG+6F1IcrZQvKNDb4sa4hQ+v2G5WE3JTAXwEMqMr5kkiYy0juIOeJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467200; x=1716553600; bh=A/cQdrZirGbeEENhoaAUBBL4qstX
	gMT2xgPS5U8ofB8=; b=iFUMoqcFhr4KozdPYVItZrGIzhKtimLmO9VPuDXyaBTD
	uhq81K2jYRuk55ESAAFcVja+sZlGuFGWK9Wr58XgfqOIl67TnmItAv9JZDAXa2Bj
	3Qa6+6sU+pzqZl/bmgfNAOY1XMs0NlAqqwP/3ZMwYdMa8eu+2cTSqeoa6crNWiWa
	aXp3P+tiX6eRDN/R7uFRqODgxu/kVZ2g1XXrERw9VSn+xhf24HCUKU2WFiVu0j8x
	ypkiNwDivvTsR+C/FJM+O+EzbSp2UXYFge71EFMr3N8mLSVxbrM0yHV624l9fCkE
	nfebXcaohP4q0i+HUHGXcpakkNI6QKTAhDc9P665tA==
X-ME-Sender: <xms:ADZPZvnu3DQN28-TXH7Xas1-d5gaRtccpCcKgTSlDw8EqDFfjEcfNA>
    <xme:ADZPZi2SR4QZg3L0ovow-nJjH23k9nBeO261YQaflHwOZykWmb9gtChqy_ecIPSOt
    BrPgV5Q7ngeQzXaGA>
X-ME-Received: <xmr:ADZPZloDql6YS83EIvxokgD__4OeD-2mD2N8RwvwcyAjfj1u8uFwBBMm32XulqCNrGTo6xKFyr6ozVYa04ybF-3myK4_ATrwiGhGsAts-G9B8jlsZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ADZPZnm1QXUvugIt8ZCopzdy1GCkmNWcXCg_md61Aknn-wRBA6Q7sA>
    <xmx:ADZPZt2-1GsYTqcKUa8U9-YlhzkbFJCAFbuQwAkUnxoKIBKXZSsqEA>
    <xmx:ADZPZmtusidCNrfbU_AeX78PsbG2WZmm0lo1wXWx_p9Vh1T5TBPq4g>
    <xmx:ADZPZhW3bj3Zt_mYgL9qrkhgsHsGrJlszkOri90PTu3HKpvI3aSBaA>
    <xmx:ADZPZu-WAmqe_xvJ_-rvAjn6lITifw6ERSU63eCLPPP9TZLgaZouQsud>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:26:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6cd34e0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:26:34 +0000 (UTC)
Date: Thu, 23 May 2024 14:26:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 18/20] builtin/mv duplicate string list memory
Message-ID: <7a2e5e82ccfcd2194b2f2787f33733953c2e0d6d.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/5kq7VUCy5Hofl1b"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--/5kq7VUCy5Hofl1b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

makes the next patch easier, where we will migrate to the paths being
owned by a strvec. given that we are talking about command line
parameters here it's also not like we have tons of allocations that this
would save

while at it, fix a memory leak

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/mv.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 9f4c75df04..12dcc0b13c 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -183,11 +183,12 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 	struct strbuf a_src_dir =3D STRBUF_INIT;
 	enum update_mode *modes, dst_mode =3D 0;
 	struct stat st, dest_st;
-	struct string_list src_for_dst =3D STRING_LIST_INIT_NODUP;
+	struct string_list src_for_dst =3D STRING_LIST_INIT_DUP;
 	struct lock_file lock_file =3D LOCK_INIT;
 	struct cache_entry *ce;
-	struct string_list only_match_skip_worktree =3D STRING_LIST_INIT_NODUP;
-	struct string_list dirty_paths =3D STRING_LIST_INIT_NODUP;
+	struct string_list only_match_skip_worktree =3D STRING_LIST_INIT_DUP;
+	struct string_list dirty_paths =3D STRING_LIST_INIT_DUP;
+	int ret;
=20
 	git_config(git_default_config, NULL);
=20
@@ -440,8 +441,10 @@ int cmd_mv(int argc, const char **argv, const char *pr=
efix)
=20
 	if (only_match_skip_worktree.nr) {
 		advise_on_updating_sparse_paths(&only_match_skip_worktree);
-		if (!ignore_errors)
-			return 1;
+		if (!ignore_errors) {
+			ret =3D 1;
+			goto out;
+		}
 	}
=20
 	for (i =3D 0; i < argc; i++) {
@@ -566,12 +569,16 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("Unable to write new index file"));
=20
+	ret =3D 0;
+
+out:
 	free(dst_w_slash);
 	string_list_clear(&src_for_dst, 0);
 	string_list_clear(&dirty_paths, 0);
+	string_list_clear(&only_match_skip_worktree, 0);
 	UNLEAK(source);
 	UNLEAK(dest_path);
 	free(submodule_gitfile);
 	free(modes);
-	return 0;
+	return ret;
 }
--=20
2.45.1.216.g4365c6fcf9.dirty


--/5kq7VUCy5Hofl1b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNf0ACgkQVbJhu7ck
PpS/Rw//W8O3W02tW3z7Av827qZF0yUZwg7loCRhe24tq/stnSfpcOX6YdtsJByq
eKRr7fqBU+RanDhuXZ1Jzlk7DAPQW00blnvI5SDpAKG3gXTtzMT8HqTmAcTYKHIC
fjb+9Qs2D+6XfL5u3Y27Pd6G2IZuqI79vDpiza5NJmnJMTrg1EtChv1B99mDruLO
asGGwkXWS6C2B3P4xDN07+KRb3FaiHvly/JKFuahE19VjnoQIfQb0KooiV8zs81Y
bNmVbAMleQhmd8JE30uK1RtMpZoFTTZ8bRhZ4AJDnRpP4iBtwVUz3L5HuJOge3+p
Qzh5NpAo7JNhoibfh/cr6y61UIPMpyV0yJvc1q7XKhO5JX9c1M/YLUizEky3ucRu
Px00zaDZ2AsCUxF3xZdUx0+Cv9OHhYF+B8rKwLL5aprxclOzv6dHlxpeQn/S+RBB
HeAEVlKipvB1LrJtCpIFxxrnHULZStV7CmGBBNY8U0F73QeARPgHAzdLZD82ZPW2
mzitbrTQ3+cecRj9hHs5yg+zH4Vk2B2LdE9J2kjIYqqrqlgGKfwpyu6TzVTna51v
cA8yLJESwohI0fAUIFNsZ/KAkaUPCD6rKSdha5CN1HxwB7yEkoEP9ryVwx8oqRud
VMxumjb+ebfwVJQrzNJ4ilj1vKQ84FcHDkhyVRZN6fLyrxX3Sws=
=/sas
-----END PGP SIGNATURE-----

--/5kq7VUCy5Hofl1b--
