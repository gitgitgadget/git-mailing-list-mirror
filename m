Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151E6170A37
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508819; cv=none; b=pXL4c/I1CO1LHYGQBaQMXa/0IE5Hx8F46DCC3WvhEoQz8g9FC1EpN1zT5J+yQ6j7LZCnDtQWHTj7S7ow7lw7hFIyBjUpc2Hk+7/ZCzVV19yiYU9qNqWLCMfqqfHNQoAGUveegA8kdEOIYFT4GsXH4NIGx4BylpiXH9rA9TkW6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508819; c=relaxed/simple;
	bh=CmCcMWs7koI06t9cpBHKGhXeVAelThvnsDyma3KmSUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEg14ysT5NPmHrgeYRGoTfkL3cSvsA/8wCOPguWY6A/MmBovEQ0eiNrr/YL5D0tYepez6zNuJRSTFg76w49wRG/Js/CraMGV3253nCvnNvdYEX9NwVJFYOS3Sq3EBLyGz5zDp0Eo9IdA6GR9tfqF8bKGLViYJZjtzGKq0/ZQR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K67sOxWo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RJ26aHC0; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K67sOxWo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RJ26aHC0"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3F9B2114AB16;
	Thu,  1 Aug 2024 06:40:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Aug 2024 06:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508816; x=1722595216; bh=6cE/1JLRpA
	neb87IItSX11QjDbGD3yGvXuNSWAXtWTM=; b=K67sOxWoIpf4AwpXHFRB+U894F
	X3eNM35ORTs/Sjj8YcDGjweiVxX5LDrEA/YzB+5dbYz1WQBgwilSfEf2C1Kw4Zsr
	fFo0XgLzf+umfzmDbnlTUBdfrU3QXdYCFkNtYk3mIxTZno48cH5lGr5DC8AL89Zj
	EuKvhp68SfLFwDiGfOu1x/sOG9XSo3zntk/tyQ1COfzMFxlCkrAufOedg1Oj1GOw
	trYPrPERlpmmi/yvNfbqfmWp0WxZsRNsgVb+jiKLdm8n+OueqgQB7l+nXnXfIjrx
	6ufSUlUf8C+tbk4KUP+PQWpVjBb8scLG4Wvb8sIzoiow7eMNb21c2WIAgSQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508816; x=1722595216; bh=6cE/1JLRpAneb87IItSX11QjDbGD
	3yGvXuNSWAXtWTM=; b=RJ26aHC0avB4Xe7mM6IZht1sp86d+PJuzRwXi0U03QIq
	V5wbGw0Jl1t+qoRNnGbuRj1TzR5pvBYKRP61hxROAN7gaA24+d8K2V9igvgw/RVm
	Nmt9Y8rcmfDear2GqB/LK3COfsN/WWNyuF3RtbbPSyJJIXcWkTcavV1qJ8c3d6rV
	qMmsKG0pTCSooV3DdCcbQ9GQiHSLniamnz1a0uEcgH/0NCUwq+RQ2ICnGHJNuo11
	M0CmziAEd9WC9O44lPIa6ZgGJhQ+2X1YZJJRXkfArYxdKmORj0YNcKeJ/wgTnL/W
	5GhUhs+POxRBgYtw0x3vcNJH5sBdJpI6ynaRM3u02Q==
X-ME-Sender: <xms:EGarZjSVsIclhkHbYAtiu2VGr07FAGdR3XJ2Er7Kh4yfIP2_ipmA0A>
    <xme:EGarZkxbIlhoKECrGT3TSmGEOvohKbuuTQju78ZxzlPgbosNLMbX9J-Z4okZpaxJt
    oJh0OJqToY7J2JFgQ>
X-ME-Received: <xmr:EGarZo1_F24cFuIauWLnZIBJ5cgM_gWb6DXkrKWiAW7SlSjSRYE0cxN8GVxZV3pBIHVyvGsgtOaVTyXZXJ8EHVdXNDWDCE4cRKm0J_Hw0mBfOFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:EGarZjBpeR3fUkQqWfv9JOVD5-AGEKDUbwgCA6NaJwEmJJa2vLZm2A>
    <xmx:EGarZsittnVFS-hEJ3RvKivDhaIEdBSFiTXlKP7bjUJD2r2fpy1jYg>
    <xmx:EGarZnpKMGSo082eQaTfB5-oYfrE2qdAwzofAS46YylD5Btc-sMkOQ>
    <xmx:EGarZnjjjvJIigKsdaog_bUbcBTocRMVrDCqRJaPqSNuraHSx-2i7Q>
    <xmx:EGarZmaTy8X9meP8ZUoxrrjc9nTNBCt6M5uHbCzP_kGLq1jHPoJTxvTi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:40:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id afe224b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:38:43 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:40:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 11/24] builtin/remote: fix various trivial memory leaks
Message-ID: <384203c34ba1d747866dd782165bf81b6280e896.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9FzTuhgU9WMYo+z1"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--9FzTuhgU9WMYo+z1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are multiple trivial memory leaks in git-remote(1). Fix those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c          | 39 ++++++++++++++++++++++++++++++++-------
 t/t5512-ls-remote.sh      |  1 +
 t/t5514-fetch-multiple.sh |  1 +
 t/t5520-pull.sh           |  1 +
 t/t5528-push-default.sh   |  1 +
 t/t5543-atomic-push.sh    |  1 +
 t/t5570-git-daemon.sh     |  1 +
 7 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 303da7f73f..9d54fddf8c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -555,13 +555,16 @@ static int add_branch_for_removal(const char *refname,
 	refspec.dst =3D (char *)refname;
 	if (remote_find_tracking(branches->remote, &refspec))
 		return 0;
+	free(refspec.src);
=20
 	/* don't delete a branch if another remote also uses it */
 	for (kr =3D branches->keep->list; kr; kr =3D kr->next) {
 		memset(&refspec, 0, sizeof(refspec));
 		refspec.dst =3D (char *)refname;
-		if (!remote_find_tracking(kr->remote, &refspec))
+		if (!remote_find_tracking(kr->remote, &refspec)) {
+			free(refspec.src);
 			return 0;
+		}
 	}
=20
 	/* don't delete non-remote-tracking refs */
@@ -668,7 +671,11 @@ static int config_read_push_default(const char *key, c=
onst char *value,
 static void handle_push_default(const char* old_name, const char* new_name)
 {
 	struct push_default_info push_default =3D {
-		old_name, CONFIG_SCOPE_UNKNOWN, STRBUF_INIT, -1 };
+		.old_name =3D old_name,
+		.scope =3D CONFIG_SCOPE_UNKNOWN,
+		.origin =3D STRBUF_INIT,
+		.linenr =3D -1,
+	};
 	git_config(config_read_push_default, &push_default);
 	if (push_default.scope >=3D CONFIG_SCOPE_COMMAND)
 		; /* pass */
@@ -688,6 +695,8 @@ static void handle_push_default(const char* old_name, c=
onst char* new_name)
 			push_default.origin.buf, push_default.linenr,
 			old_name);
 	}
+
+	strbuf_release(&push_default.origin);
 }
=20
=20
@@ -785,7 +794,7 @@ static int mv(int argc, const char **argv, const char *=
prefix)
 	}
=20
 	if (!refspec_updated)
-		return 0;
+		goto out;
=20
 	/*
 	 * First remove symrefs, then rename the rest, finally create
@@ -851,10 +860,15 @@ static int mv(int argc, const char **argv, const char=
 *prefix)
 		display_progress(progress, ++refs_renamed_nr);
 	}
 	stop_progress(&progress);
-	string_list_clear(&remote_branches, 1);
=20
 	handle_push_default(rename.old_name, rename.new_name);
=20
+out:
+	string_list_clear(&remote_branches, 1);
+	strbuf_release(&old_remote_context);
+	strbuf_release(&buf);
+	strbuf_release(&buf2);
+	strbuf_release(&buf3);
 	return 0;
 }
=20
@@ -945,12 +959,21 @@ static int rm(int argc, const char **argv, const char=
 *prefix)
=20
 	if (!result) {
 		strbuf_addf(&buf, "remote.%s", remote->name);
-		if (git_config_rename_section(buf.buf, NULL) < 1)
-			return error(_("Could not remove config section '%s'"), buf.buf);
+		if (git_config_rename_section(buf.buf, NULL) < 1) {
+			result =3D error(_("Could not remove config section '%s'"), buf.buf);
+			goto out;
+		}
=20
 		handle_push_default(remote->name, NULL);
 	}
=20
+out:
+	for (struct known_remote *r =3D known_remotes.list; r;) {
+		struct known_remote *next =3D r->next;
+		free(r);
+		r =3D next;
+	}
+	strbuf_release(&buf);
 	return result;
 }
=20
@@ -983,8 +1006,10 @@ static int append_ref_to_tracked_list(const char *ref=
name,
=20
 	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst =3D (char *)refname;
-	if (!remote_find_tracking(states->remote, &refspec))
+	if (!remote_find_tracking(states->remote, &refspec)) {
 		string_list_append(&states->tracked, abbrev_branch(refspec.src));
+		free(refspec.src);
+	}
=20
 	return 0;
 }
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 42e77eb5a9..d687d824d1 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -5,6 +5,7 @@ test_description=3D'git ls-remote'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 generate_references () {
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 25772c85c5..579872c258 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -5,6 +5,7 @@ test_description=3D'fetch --all works correctly'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 setup_repository () {
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 47534f1062..1098cbd0a1 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -5,6 +5,7 @@ test_description=3D'pulling into void'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 modify () {
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 14f7eced9a..bc2bada34c 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -4,6 +4,7 @@ test_description=3D'check various push.default settings'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup bare remotes' '
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 04b47ad84a..479d103469 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -5,6 +5,7 @@ test_description=3D'pushing to a repository using the atomi=
c push option'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 mk_repo_pair () {
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index f9a9bf9503..c5f08b6799 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -4,6 +4,7 @@ test_description=3D'test fetching over git protocol'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
--=20
2.46.0.dirty


--9FzTuhgU9WMYo+z1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZgsACgkQVbJhu7ck
PpSTxA/+LeVlevP/iHymTgkDS4LkRWDY2L4FmNSlZfJKHdC1Cm1Qz212ybUvZPUd
29Fcv1Pi6FkcYPYmMu0b0leHjor0itkvSOl9/BVXt0dk8SJcjoD3eHoCVt+1Ilvq
UwqjhhcXcllpt0fsbuIdXbLF/5f8NnJYns+tYz5n0U9ZPJt/wvrqR/tQKhWgsNgZ
9kzkLoaD3QKvABQ35gthOTanBm8AroHY4fztqrM8HiEiCDD5b4ZXFHQJeEoBcgh1
CUN16F1D1ijraUi2mDulXDGPLpTV3BvvM7t6S9OeTkCZbhpUPAL7wGDDh6IDNkxl
2pMspuk42pm7BHzpoqqRma420tCze5U973A4SuXwObS5vAeai40W5lEKEWFhK1Nu
HuV6TDOLSZ4/eu659frNFNupMtvx4SW/qrIDwOxWr7j14hYptfV9jeXSYEsvsv5N
ZoSxf98E+bf2/7biBxNBXrZ2b3rcZCmiGVCRtKQRGa5Vgt60jSVeGHvcTjazPMtG
Tk+sVFESmKzOU6u03gf6VPOszz3CTjZJcp0YvlM23QR975zWddG5rPf3gc+46b/U
BxzIwSG6i+pdgqbO6ySyEUWGqKPWCjz1ngsC2HLKdCQSoBL6tnhkTPqG+g51O2Hv
One1N+bi3NhFSbAmnl9yqtP5T+8NRsWEqoZ/rVUWYusRbVHyT/0=
=kFpk
-----END PGP SIGNATURE-----

--9FzTuhgU9WMYo+z1--
