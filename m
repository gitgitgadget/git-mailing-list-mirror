Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D8A17B42C
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996096; cv=none; b=Vu1eG6YhFxQdKh7+xP8W1gIY+EdGN+Lt7uFNyFJsrKIkvD151to8Tr+/d9KS5fhSWPXalJ7fRwqUnx77IYg5xPZmKFd66tftcHQcIBDzeh8LBV8U9n7feXxqKVTM2SkuTPmwjon+yNdvRJX8tPdMb2vNcOBb44KiFkb18VJllRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996096; c=relaxed/simple;
	bh=wTVBpgL8hBzwwDS290Fn6HP17/IJMNREl3gY3Gkq4hQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7NGe9/aQtuJ5F8exEOTBLkZbYW8Q9/b63QGoi0CPNXm2cg2NmZmdHL4FzWNkgC5aXODD7afzKnSKhRnOEAHAMyoXUohocBrNYAP1mGcLd9T/OiAIegEu+T3LdyTXRkBO++MSoficFTjsrY20cgcd9lDT9yVoU8aOKIwOvN9IXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ejm/w3hB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mkRqE+Sg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ejm/w3hB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mkRqE+Sg"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8A21313805F4
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:14:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 26 Jul 2024 08:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996093; x=1722082493; bh=XH+Et1wC62
	cOQQ1C8Q/p91G450lqlwQR0X9M0+vlIlc=; b=Ejm/w3hBJA5EA8jPKjboNSoVQa
	dzaMibC6Z5M5XFtdS+9+75v8ECgYHIqgIE+/phNuBNMrrOC47r5kzcQtUzomUhaF
	Et+MvAM04azWkC0epSNuqwh21eaUvlDtnXctc+J1NAKSs9ETtGXJ+xLQn61zSNst
	E8/hy+BKEzQrnBxMrdllSR6nz06W6q+3WfgcbFeipqYG5XgVDHl1lnNjMUS8wCOY
	y6MxmojcrymMQS3sCI+Ts+GEazhFMaGplm/ztAccYxeAZI26Pdcflu5mwVxgwrZp
	llKmD8DAEaBPS2desMxhclxtOZZPsBoDLEXSVUR2kqPFxXN5TeYYx3gXSGug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996093; x=1722082493; bh=XH+Et1wC62cOQQ1C8Q/p91G450lq
	lwQR0X9M0+vlIlc=; b=mkRqE+SgA4QuI5q43mHBMb8MWvBmJVBu8uOOXE+UHjIL
	UZKwv+wj1F56VKobiqfsglNI5byhgapChlLM+lWt4sqefrv6QMbKrVqYvbtTq/oN
	8Mmk8Z0PgGcyNzlMHh2Jl9h5RbNZpRLwmpiQkdEcDLJ7iB/wVlEg4okTyHc7LGt1
	a80fzQyp5cQixkywnfZLAWHskTZJUo38QNh2ketoaTnjWx2J6Es26DSeuRNU/r/p
	PUbuo0porRQUfk9YTrvmugQDzqtVPFsm+U3lNbWOat4+LI2u1nlV/JsJ4O4VXNTV
	0VM4imczK7AFXu7GTqdVOBIMuOHms8MbpaORCFfMhg==
X-ME-Sender: <xms:PZOjZkyxoNXW3ZnrUFl5aDgk2Zd98Ptd9vnkcrnHufmLKvk0lpmRgg>
    <xme:PZOjZoThu_bfWUPQrgxPR6X4aFzIGsnLN7L-5zE5sQWvLy4pleQJVmk-si4wQk8X-
    H3orBDTzYL7jMVFdw>
X-ME-Received: <xmr:PZOjZmX1qy-okITagyb1nmqshhnhsdIc9JcMSHbWWAzFT9xIU0UE3lLcOeuLlYZ3I2r_JaeM8M0KSv2u5Lb54RJ6OtJTeBE297hGmGWB7nB56uO7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:PZOjZiimr96Q5oN0xe3GEE0fCF0fo6MwhVzyvRFNFBZLpO1tkEwV9Q>
    <xmx:PZOjZmBzNbnevufc_qUiXOcvk5e4qPGbXkaK2ZteBBooCI0TTzjDQA>
    <xmx:PZOjZjL80P7bIzjqbqf5eyObdtCenXi-oAT8B7ncFYzE7XrIbORY6w>
    <xmx:PZOjZtDeRY4sjd3HI8C4Y6_t4hcdQtXKv07U5zcQ-4o2vBJTxJSV7A>
    <xmx:PZOjZn5O9sPzUnx5vTY3RONg8jlQ7djWUIkys-4T21yAodNd4_hAjVR6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:14:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0cedb960 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:13:33 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:14:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/23] builtin/describe: fix trivial memory leak when
 describing blob
Message-ID: <8aba7434bd3350ea98ad055c3f0acd2045b96960.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1ue9y6iOWPbM8WNh"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--1ue9y6iOWPbM8WNh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We never free the `struct strvec args` variable in `describe_blob()`,
which thus causes a memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/describe.c     | 1 +
 t/t9903-bash-prompt.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index 3b61aa1baa..aa5ec8d68a 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -529,6 +529,7 @@ static void describe_blob(struct object_id oid, struct =
strbuf *dst)
 	traverse_commit_list(&revs, process_commit, process_object, &pcd);
 	reset_revision_walk();
 	release_revisions(&revs);
+	strvec_clear(&args);
 }
=20
 static void describe(const char *arg, int last_one)
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index d667dda654..95e9955bca 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -8,6 +8,7 @@ test_description=3D'test git-specific bash prompt functions'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-bash.sh
=20
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
--=20
2.46.0.rc1.dirty


--1ue9y6iOWPbM8WNh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajkzcACgkQVbJhu7ck
PpSkpA//Qs/s76aA0aYLEG3jJBaB95kznFz8GhdAHTkGucHaYw8u5uZCyvjQYnOb
+gA5mBZCf5IlmA5ACkZlY1VkBuBwHezxxzxyw0r8fxju/1LGX+ZXv3jtwB+kGi8X
I/23IipqsMmMER3fhhIvJFWj3XSpvY3Aho6eKwEKl0UGyrQPh+3xFgvGGrKrAJqJ
yDesNC1oecn/zGJQA7br776Hc4kvI25hGl1Qfa4/ilB9DEJbzGSvuxKdhL8yHNjd
rFTm0sQAK4MkkQ4niYIMmIU1HYGlUdFqPLVlRPrSR73DZgt+4cXCZYVYfJn61D74
o+pIkI2mbZ8GILF1e1vhG1y49LNJtZs0a206RyvLdd/VFoFhgIAJx2JoXSxWRU9R
KWZEVvCvaeAl6khvzPFulVOCmUl2EaQ4XnWDouS4f63xF52gJn4tHkkiUhz4hsWu
Oh3A7D42pNKBPby8SymGy00JIK+yyFIVQh6hjkN9jgkIcXLEOMh7Pwk8cJk6e/gG
KFWxmuzUEatH+MZ6oEs7O16V6xWonQ6SLJFzdB9FVddIKWaHoMlAeHmN31WkFMU7
KqhXI/uih/KIBhwXnGbORyby9MX6LgS7tsq7WUxx0y5NhZCrt/ePck6gCUL7Ic5f
47VzLt5XTacj5oxbOPjQNcQ9Zxcai15FHFG5jSsrzb2cQOLHxr0=
=nWYY
-----END PGP SIGNATURE-----

--1ue9y6iOWPbM8WNh--
