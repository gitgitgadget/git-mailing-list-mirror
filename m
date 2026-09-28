Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1345495524
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589119; cv=none; b=W3R+UKgG5xmpjV1YdUpqprru/xL52KJUfVYWM6CKnqv4V40FOs+0Mp/E4tgdTKlsIPN/MYP0WB+tW8a1OvHHM3PxUh5JU3mntIEw9N6lao/txNFMOJXUpaADAEAqajyLsJDaXwuweOFdMRCPAGTmHMqL5rMilVUhBDH+3IHonzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589119; c=relaxed/simple;
	bh=QELEx7yQDzxOJN/8x5wJ6PllRnR75skSsk23WY44Jow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jjE7jR8YzllKNdxRqtq18ZamqZXe31LoADN8R/9GJ8q5kNvIPAc6H13Q0KYCOSEh6GGbGyJVburdigzRn1MnPVByTc1sikNdVi3eOVdGYzNyjDjJks4JfCQWyAPTu87y5nfX0sPKeEyLwbF9vgFIHpCAiAJj+dt8kDDK1LwrpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fnM5R2D2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nwO8PWKZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fnM5R2D2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nwO8PWKZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1173B140001D;
	Mon, 28 Sep 2026 05:51:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 05:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790589117;
	 x=1790675517; bh=zDowPq66ocYHSJI+rGe+yEABaq5cQjUwV8mUopyb7Ps=; b=
	fnM5R2D2zpBoWDYfm2idkLZay5dfy8RcLJ8RSYWgjdhRe+MlSWkywS7c69bVyOSp
	mKQ5d50VNq8P7E3TghdHI+VKolIkyWklWhfiL0WUPF7d304UnWVWPaJK4UmQhpjw
	MuK5NbkSpU1gFkiIoCr3Ln5gjAMGUDTtlPTY1FGSHTunqEr2vgVuGskx5e9Fgipl
	BBhA26/tZldu/lYyulsQR9sJGgaS6/lzB1/5XDAUoqpV8eub0pGBPsO2BkslMjIq
	9TeUKmoMRDD8rwxgPuNKQgeeYZcH2Gc0rpJtmffPxHJmVVhoklnHz37V2ahrsve9
	1rq7310MQeRFgCRXkCKbJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790589117; x=
	1790675517; bh=zDowPq66ocYHSJI+rGe+yEABaq5cQjUwV8mUopyb7Ps=; b=n
	wO8PWKZKXEU4WJ79T8/CVodZ4GO7FVQsmrzsny48FIguIcnTghmVC/5YFLVP7CHO
	+o3qhduEtSKBCfy8vyvXQDiTsqr1Sntx9fo/wr7ekpueiKkWBL3D6IKpUUvPvRim
	bnwiq6a9yJM7BqsaKD4T8GnmMfiEk2tsYTO8QxebO5B+Eg7hDQmdps/yuSYpH7eq
	SVA+CZpE0c61R9gePTlTfuyDKkSOtps9Lb6wTjCxUiI68lKMAylcsvZJOp9R97Sv
	wDH38wH+TXLeijciTbuJRjlJl0fFB0EpF8TVoUU4GGSi7A46jDApXcveOiYzIwP1
	zxfVne2U37/PDVhirdvrA==
X-ME-Sender: <xms:vTi6aksBFxrroXlyaG-v9eyJkEU9SjXDYEqM6y4jiRJlNCg5UfzCfA>
    <xme:vTi6ao7m6rNyKWwP8OmNBdsnHUZLOr-dEAlUDENq1-p_usLHHF5hAzOTwajG_r-Hq
    IhVD3GXTTmGHD_wvdNb2CxJjX9s6_d-fXvPKhgampc5NGOG_hQIKg>
X-ME-Received: <xmr:vTi6atLGjYl8byjq_2ofdV5xJiSuzpx4t-0fxTkP8pM9Gu7LVFTLbA>
X-ME-Proxy-Cause: dmFkZTFf3wbZ+K2hbzfSgpgETsMz+NBy3J6MpFvFZYdyyTeL1iI2BFDj1IOSxm4OYKC0H3
    1Aperekeoh01XU/Affr9YDGewK0XTpFuAvdOqXRnkn1hAQOMt6Cmug4wAR/cLjxT0+YYyY
    V0ix31kC1wU9qb1Fc8l0wzUB6/ndZQ/KZS4bdHqUX1yu2WFUdfLdGcye3K8VFjVWdme6dj
    VB+FbRki+xZ7UJmHTn7m2FhlNqt4gn7r8JRqnyPx9S2V0Cn7eSTMCsJkqZ9Q8z0sAb/7of
    tUBRJGNrdn5okkLUJRR2FTKTF+T7dMnEgQWAA9cfkQE6WEt+aDQyOttxx4ijBJAJTShybR
    vAlrGMPl2sd1qs0FcK5jmXZbmv3fn3ugFHWg4q/tvFSdEBcK0J76OczSdhkpr8ryZlzm06
    UVaLtO8Y+sJB41k2TrHbiBlbP0/DdLd2Q/yXF/b/TZCqL4dYVSojHBij9M0OiJPVTWYnPs
    TDCGnokQFY2BeU7RcQzGZlpQ5nLXHQ9xgODTFZj1vlscEEs97qxzQWQWyXMr4xf8bgddxq
    HjBhd/Jsk4C/l5pgUOpkyeVF0Y/hrMP1y68BsDaIROsNtQ7yZMoZ27gTvoFw2Pnrg5Lyh5
    6FEevVyWmDfwgi3lQTiv9lvZZUzsoIEkDkMn2KNyDX/p8ywLxMf1PyN5DLOw
X-ME-Proxy: <xmx:vTi6ag7XYEBUWO0qHT2rvWzcvB8S-aiwfbuwPOQ6upv53aeHLjG2Dw>
    <xmx:vTi6aoyguzljHn9hcSWhuaHQ8QvyQ_aH1-cYcRexrqvKWPw2Lg0JQQ>
    <xmx:vTi6asakwpr9KM3-xLO6A2Ys7N1Xk18Axp-qg-tNOIg5Q-AV1HTcLg>
    <xmx:vTi6aiQWRc2W5APGP7P4Q2tvQ8jehKlVBOh43pFqOSZ1jPHYQcQJHA>
    <xmx:vTi6arX3WRSgbQwT_lDK3rJ0iZcqt4oh-8PQPeWMonRbiLq9TJb9WOLV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:51:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 48f66e8e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 09:51:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Sep 2026 11:51:05 +0200
Subject: [PATCH v2 4/7] builtin/init: move handling of
 "core.sharedRepository" into "setup.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-pks-create-repository-stateless-v2-4-a03612f703fa@pks.im>
References: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
In-Reply-To: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

When initializing a new repository via git-init(1) we know to honor
"core.sharedRepository" and adjust permissions of newly created files
accordingly. The way we propagate that setting is quite awkward though,
as we have to set it on the repository that we pass into
`create_repository()` and pass it as a parameter. This is because there
are two different scopes in play here:

  - We need to apply it to the repository so that creating the
    repository's directory uses the correct permissions.

  - We need to reapply it to the repository after we have created
    default files so that we know to override any configuration that we
    have read from the new repository's configuration.

The effect of this though is that the repository works as an in-out
parameter, which is quite awkward.

Refactor the code so that the caller only needs to pass the value.
Starting with this change, the passed-in repository can essentially be
completely blank as it doesn't carry any state anymore that we'd care
about in `create_repository()`.

Note that this change in theory also impacts the other caller of
`create_repository()` that exists in git-clone(1). But that caller
already passes `-1` as a value for this parameter, and neither does that
caller modify the repository it passes. So there shouldn't be any change
in behaviour here.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/init-db.c | 3 ---
 setup.c           | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index e45268f1ff..34215bbf18 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -171,9 +171,6 @@ int cmd_init_db(int argc,
 			die(_("unknown ref storage format '%s'"), ref_format);
 	}
 
-	if (init_shared_repository != -1)
-		repo_settings_set_shared_repository(the_repository, init_shared_repository);
-
 	/*
 	 * GIT_WORK_TREE makes sense only in conjunction with GIT_DIR
 	 * without --bare.  Catch the error early.
diff --git a/setup.c b/setup.c
index f335111d1e..0d0a4abbe6 100644
--- a/setup.c
+++ b/setup.c
@@ -2896,6 +2896,9 @@ void create_repository(struct repository *repo,
 	 */
 	repo_config(repo, git_default_core_config, NULL);
 
+	if (init_shared_repository != -1)
+		repo_settings_set_shared_repository(repo, init_shared_repository);
+
 	safe_create_dir(repo, git_dir, 0);
 
 	if (!reinit_ok)

-- 
2.56.0.rc2.329.gd58861e689.dirty

