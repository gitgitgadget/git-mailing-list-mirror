Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7949CA3D
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996127; cv=none; b=ndWTmBLe/bNQwWiBhpuqL8I/gqY0EnYFmJl62h0WnWj3IRXbioaDG2WDRJKU60vjdw65v7RfsJzOuV/QDEyIsO0nvWCSq3n8gPuCRN32nCC/0VeXIktwoKaAqswg+NeD+ce+0mxT/85Dye7s+uIfydIktBLFTdkrmdHUBkUMZ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996127; c=relaxed/simple;
	bh=96RY2/13WVoW+HZPFdCIAPrpzKngSKBdR//vRHgvrm4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWp2RwUPo6yZyPd3SC8i/dJsJxe/UXlmNExXGquCY6QSC4r4bQupMJC8E8j22VPvekyTj4x8r3mg96Kjj2LN8g98Ysf7UUTwvg4O9r3SXz+y9WzNwq7X6ZCGZqcdMTNTeaoFtcmkt0LpE11QfdjrdlffkfEM1sTBtB6jWuoQgDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qEo4d8wU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IkoPn7kY; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qEo4d8wU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IkoPn7kY"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9340A114028F
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:15:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Fri, 26 Jul 2024 08:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996124; x=1722082524; bh=eldXnVMZlO
	dgZ0DRIRRo/jb7RZ6Pkx7UrWNTf8iyBlg=; b=qEo4d8wUanyofDEbfCMCAnGQzE
	+0cGxiqOxiaJazqvrIMSpIS8fZ9ObtHYRCfHDgJEc72gzySCV177fDfGvwgJ3ySi
	v65NYLIOJ6xu6lELg1PVL/H3cVPNesoi8/47DUXcEG4k5mRJYjuh0vMNxaMl/OYR
	rWI0Mn28oI/VjNtDt+NK2uwZw9PQdAUOZLAaXQpycAz2Vh4020DSdR/Uyv3GxIzO
	izILhvKWBUZadosSwqhtBZkGZdS1WJ2OQfrKhAN7jiaAsCOxQ1ZD9S1CbWN9fQf4
	+OqekvbxpgqOGYCrIvtRwdHqW/5G7fG+2K9ffXIwnYBtmiTKNxiAkeULxiiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996124; x=1722082524; bh=eldXnVMZlOdgZ0DRIRRo/jb7RZ6P
	kx7UrWNTf8iyBlg=; b=IkoPn7kYNo4VwKH+K0gmeoWw8L85iZJ3bJZs3kJhT0dt
	gIOHYUFzOseBrLeZ0PQldVbKe8A7cydkcBWLzV1XoQ+6OgYZKZR0LvwrnHoRPAdb
	1W821nDmuF3d2n7/AmbSdW+SNNGk5Rd4pna1yH6eLXt9p32EwYZaC8yJSbwa5/sP
	WnYa6MILD/aUYdqG/zn0CuHYV/I0R0Lrnj4bA9qa84OLg0fPy9K4U/tYqDYVgY5r
	gy7Hht4fgkggL6rw6G13FCLl/6TjJh3TSR3AQDWQyDb/40miHrpwp6UKg4s36iwD
	MrwIzjrIr3jgzOvEEBMEGXAd7HS7LASKx88gufuQ0g==
X-ME-Sender: <xms:XJOjZpsVbt9F1wc0BHZ6neVCM5F0mYRypP-DZACLMwhXdlnl0xEHHw>
    <xme:XJOjZieRIqY5HjefBvxCkGbMdV7mFeZA6YZmVLcIlgn79Pl9BEihZfaumHaSB8-Gu
    eqYox7rnlk8F6lwug>
X-ME-Received: <xmr:XJOjZswvdWQDTnZebw-CAk7gaihEuOazEngk0MFINalnZZ7b8EV9dFXRbMFZtiNObm2j5_4qW9O8nyXK_B43P9_MuxWHmSovCVhkdznf51OmEwwu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:XJOjZgMOykt7MxsdW1eE9krJWjr675Iz_HQKiblprOvuzzebpDZgBA>
    <xmx:XJOjZp9tpo7xhHbrkoyUKJfiJYyNNKOrF9BChIC3N7A6IHB6mNhL3A>
    <xmx:XJOjZgUj1LSbIZ4nKNaFSNigiXKnjeQAJ1Oj_JDyHpRSrG8zPMqxaQ>
    <xmx:XJOjZqf4AqdyvWQadOGa2_Lv_svxjvelcExEeYjBXWW0fgjYX98cgw>
    <xmx:XJOjZrm2hUIup7mYndmoP9YOqQRbjT34UBLD0MCZqJhX_F6h1ZwTODiM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:15:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ae7ab6d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:13:58 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:15:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/23] builtin/submodule--helper: fix various trivial memory
 leaks
Message-ID: <5220c91bda7bc766368c2925499e5d244a03697b.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S4JuvBSe6dQgqKOO"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--S4JuvBSe6dQgqKOO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are multiple trivial memory leaks in the submodule helper. Fix
those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c | 13 ++++++++++---
 t/t7400-submodule-basic.sh  |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f1218a1995..5ae06c3e0b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2269,6 +2269,7 @@ static int is_tip_reachable(const char *path, const s=
truct object_id *oid)
 	struct child_process cp =3D CHILD_PROCESS_INIT;
 	struct strbuf rev =3D STRBUF_INIT;
 	char *hex =3D oid_to_hex(oid);
+	int reachable;
=20
 	cp.git_cmd =3D 1;
 	cp.dir =3D path;
@@ -2278,9 +2279,12 @@ static int is_tip_reachable(const char *path, const =
struct object_id *oid)
 	prepare_submodule_repo_env(&cp.env);
=20
 	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len)
-		return 0;
+		reachable =3D 0;
+	else
+		reachable =3D 1;
=20
-	return 1;
+	strbuf_release(&rev);
+	return reachable;
 }
=20
 static int fetch_in_submodule(const char *module_path, int depth, int quie=
t,
@@ -3135,6 +3139,7 @@ static void append_fetch_remotes(struct strbuf *msg, =
const char *git_dir_path)
 static int add_submodule(const struct add_data *add_data)
 {
 	char *submod_gitdir_path;
+	char *depth_to_free =3D NULL;
 	struct module_clone_data clone_data =3D MODULE_CLONE_DATA_INIT;
 	struct string_list reference =3D STRING_LIST_INIT_NODUP;
 	int ret =3D -1;
@@ -3200,7 +3205,7 @@ static int add_submodule(const struct add_data *add_d=
ata)
 		}
 		clone_data.dissociate =3D add_data->dissociate;
 		if (add_data->depth >=3D 0)
-			clone_data.depth =3D xstrfmt("%d", add_data->depth);
+			clone_data.depth =3D depth_to_free =3D xstrfmt("%d", add_data->depth);
=20
 		if (clone_submodule(&clone_data, &reference))
 			goto cleanup;
@@ -3223,7 +3228,9 @@ static int add_submodule(const struct add_data *add_d=
ata)
 			die(_("unable to checkout submodule '%s'"), add_data->sm_path);
 	}
 	ret =3D 0;
+
 cleanup:
+	free(depth_to_free);
 	string_list_clear(&reference, 1);
 	return ret;
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 981488885f..098d8833b6 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -12,6 +12,7 @@ subcommands of git submodule.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup - enable local submodules' '
--=20
2.46.0.rc1.dirty


--S4JuvBSe6dQgqKOO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajk0wACgkQVbJhu7ck
PpRsow/+PdDZHNqH7os/H4MFYBPeTxBAMEb8OaozSUOQQ8/7KirNDB5CT6hMapGv
zl8Daq6Mxf/36TnOQL/Sk6bbFf7tQVH82vks4uUfvtcO2bIax/BJIQCMrI6vzD91
4rRXP/95uQbID9l7PxAQOqg/E75ziBTe5ePu386aXP7KWXYuYilDxrCf+iZvG9KB
xBdK1jZALsn68xluxdBM/VxZ7+dfSyIumFERzVPXHo/Nx6aOrtG0Q1bsA7xBhTKR
cft20DNhNZpywUG7wTnCN54tIr16ZQV328KJf4AGUNxOxLPpniJyK3KPiJ22RTDu
p5vlSXeQMTapgH+s4yzrcVUykUcSb0ADMZSdf2SmBTmjYAi/UKnl7ul5r+Mq6I6D
Bf6sa+ZDy6Pmib3LPBq3Uikl5ddGeaSpEHN3DxlMvW/lB+kIU9CRJGlncF0mZeCb
ftE/0oY0LhARHp53oBLi6+sZNhOSdQXO5hgGrpFs4yKU3cCanyVej2awcMz69hF1
W/W/AjCKxD6y140aHk3AuzBxxjC4uBcqKHfABe4srBiqvfxCviYsCh4HDrvk4AAp
648nznpy4+86x+DpFaMwzvHz/WvM988LSK7949MGP6sT7IwWwgUgmi+AUv6XxnDb
Tf4c21kB9qr6/lD9GFrl5bxiFjYMzaiYXnUpEFNPuya8KwcaS7s=
=VDqZ
-----END PGP SIGNATURE-----

--S4JuvBSe6dQgqKOO--
