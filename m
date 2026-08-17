Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6973F5BF0
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964972; cv=none; b=EgSYgXqrbbwed3rzxfMbS59x0gbDrN6GPr7ImpwthtzzUBG3iSYMap/RM4iSIMGfQ3uiVNa7cm/o9M+a8pr7weAeY2P2dPItDKMzbFODBxi9naeVojY1Dk8aJKlZAw8/FDeSFKkNS3cdwldowIYAWhQEP00FVbqvHb4NBaKFkXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964972; c=relaxed/simple;
	bh=uS4YoEzyRLEYanbrW/1ext+lLNQaxRzFAyLiLVhjQwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j3ZG2h+vaDQVHZ6gNrJsO2rdthB5oPFQqDUR3MG8oog8RrjOm+XtMF8dORgVRhib1AYObCla+v9dn8AIDe0sUyYkfPezjjl3r6u3t2blV61azppso8J2zQbW5ylGZ9FTG1xngLww3TjikzIQKPQCL4kTOTHoAdrFgvVJbYZ3lyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cXvtH/S1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+BBDn5G; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cXvtH/S1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+BBDn5G"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F027140008D;
	Mon, 17 Aug 2026 07:09:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 17 Aug 2026 07:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786964970;
	 x=1787051370; bh=QCQBabY3D9fCVt9PUdNf9Yg6XSz+qRP2GI2JpAhnOxA=; b=
	cXvtH/S1YxmmzvtCuMdYsfR9fIuKHLT1FAIx7K4RXhoiNbWND+3u6mjKvteUjxKe
	3N7L9GXrpWlgveUc7yS3G8+eFZ2DduWviL24lEFEyUi7/NoF8duFJ41gLqU4ZNhu
	q1Nq+fEAybAUGpGxbkyOm3C32GsV+IoUrLERKyfA9mUafxTCCQ/pMvy1jhus39Ct
	huvm/ZUKtBt6GxkKFKFKl8F5mYSfGY5/TVcIIgulqtwRZAV0hEfTl2fp+hGPnyDi
	LuqVvllj+Lb68fNYXuPdydo76sT46nIAbCI6EMts9BoGT/hzM1lts0k3GXZHx+ck
	1PRmro2JK15QA8/H91kT7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786964970; x=
	1787051370; bh=QCQBabY3D9fCVt9PUdNf9Yg6XSz+qRP2GI2JpAhnOxA=; b=U
	+BBDn5GeFjEx5F1EtuXBGTssVP7gM8uJAqGEIC/yktzVWQAXWCBaBpmYYTf0GETA
	1kHd6afyGbCdAk314kEcbhpcokCQ0tEeM3oFkaJGg+lv2/47zjiF41nbF/G5+4xI
	mFqm4bt5XDWgkbJQOFe4/mPsS3OFkTxisN3COco0acQS2mnyWCi1oXiDxSy00TiW
	o2f/zFuhmgtYRl3OXOtftJtufJfxCu+yQvPEBNZNDRxb7WaqWgZf0+1hzM6yM21Y
	FYCvFDoQgm3qfOWt8PnUjiKX6LbWDid25VezFVikh/l/dCkVbFjP+2usXWSyTY8h
	fCt+hPGIaCtSt+Y1EfhOg==
X-ME-Sender: <xms:6uuCamMdu9lMfYIbg_CEDDMFWyB6zG0zb2oXG_hHwIfC93JjbYXbrw>
    <xme:6uuCar81hSXr-yYZe5n5M-BLVPa6wRsWBstL2LlGFrgeGF3uwyZ4F1qidKX7Np5mp
    kqTFE9LyWkGJIC1gAOk2-YyO7zJrkPfcH0ztbrh6q53hg0Indp9W7A>
X-ME-Received: <xmr:6uuCaiSK_0Pvezt1Ard2AR3pM2K_5uaNfEW6vfIClOLTakbnJvRcGDqF3sY5ac2dmr0JHPyk1dFAvJK0YeZtbTWu8n6Zs0ibx5Z7BxBh_A>
X-ME-Proxy-Cause: dmFkZTE0eWXkes4XlOQBdKc18d880nW6QfIMWFYb7a8QQf4iZJSFuinH1Y7BJmr1nulgyL
    /gCAPq4KSfNVDgdjkIT4hVSdBswG45MGLiWeiqP8FyfzC6A9fqNtxZYerIVMs6pAXrY5OW
    LIip91M1XjiXpn20gjr/OWRRESaE2gszqRePJgKGg8fFk6p3XbPmFvhS/tnb5Y/3RV32Hn
    ouSktO+rf4GbVK1+oj4bVUOHoMv2nVR7YmbbPAAfW+TIjwooYOeYVHrv93kYB8eg7HV8ME
    7+EQZjBmp1WQax6pxz7LcHraJsZKxOFqu4KJNGgu6omnT+HjcMcIXT94xPHduRUXMb7Gmt
    6j8Qlbt/FkZjxqu41Y07NlLbBJ3DA3GzjQ4uqpoBktm3MV8Mvt9F9hhOKnfR+NoxjJzbG7
    aSAJiDzqruG82iS0hNKkb31W9ieTZuoEGeU3royYe8UgvlQBuZF5Y+c7Fi8IWo/5rpLMaj
    XWYKYUrS1Zfe4lw/jzeFDZRrZj4rOtvt5R+Vke6PI7n5GZkHlMqwKMkUfC86MMk3DVo10W
    qIUSvIR56invImRub/K2RX7Qk0jyQ1ubOWlEd2PNfig7yEbChsIPzcnLVfWXw/F/dy/t11
    tfqHSbrMew4F/ieGholaCbWKjq0xCHtCrF6sAVOvRc7OP0MJ3yLpcU2CBiBg
X-ME-Proxy: <xmx:6uuCalk3OvRcNMGQDrdZ3kjCDs_N_tlLeftZck1sdaDt6VBfBKBtXQ>
    <xmx:6uuCaqS80CuPZfzUAbljrTV_NYd6o-Wii2H7eWzQf2vfoqF2k4UM-g>
    <xmx:6uuCarP3IZ8rvidV5Gl3mKXrMpc-65P-tx3gt_Ap2JC0ILdHxO5gCQ>
    <xmx:6uuCarVc8GDjdz9ExqxFVo0ag16LIQ38I2vToCy4ktO0iRr0UobCpw>
    <xmx:6uuCauOGKrVe4GqoRgloNX_1e9_L18a6Kc0noYD_113JQUDHaIqFmX4c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:09:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 24654a61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 11:09:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Aug 2026 13:09:21 +0200
Subject: [PATCH v3 1/5] setup: create ref and object databases after config
 is written
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-pks-odb-eagerly-prepare-alternates-v3-1-1115a7e02467@pks.im>
References: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
In-Reply-To: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When creating a new repository we create both the reference and object
databases after we have finalized the repository. This ensures that
those subsystems find a fully-configured repository at the time where
they are asked to create their own on-disk data structures.

There is one exception though: while we have already fully configured
the repository at this point, we haven't yet written both
"core.sharedRepository" and "receive.denyNonFastforwards". The latter
configuration doesn't really matter to us, but the first one does as the
"files" object database source reads it.

This doesn't cause any problems right now, but it will in a subsequent
patch where we will start to read "core.ignoreCase" when creating the
object database. Move the initialization of both of these data
structures towards the end of `init_db()`. The only thing that now comes
after is status reporting, but that's it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/setup.c b/setup.c
index 20d29f31f4..d90654f584 100644
--- a/setup.c
+++ b/setup.c
@@ -2880,12 +2880,6 @@ int init_db(struct repository *repo,
 	reinit = create_default_files(repo, template_dir, original_git_dir,
 				      &repo_fmt, init_shared_repository);
 
-	if (!(flags & INIT_DB_SKIP_REFDB))
-		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
-	create_object_database(repo);
-
-	startup_info->have_repository = 1;
-
 	if (repo_settings_get_shared_repository(repo)) {
 		char buf[10];
 		/* We do not spell "group" and such, so that
@@ -2907,6 +2901,12 @@ int init_db(struct repository *repo,
 		repo_config_set(repo, "receive.denyNonFastforwards", "true");
 	}
 
+	if (!(flags & INIT_DB_SKIP_REFDB))
+		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
+	create_object_database(repo);
+
+	startup_info->have_repository = 1;
+
 	if (!(flags & INIT_DB_QUIET)) {
 		int len = strlen(git_dir);
 

-- 
2.55.0.822.g20453c30eb.dirty

