Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C44375F65
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241587; cv=none; b=QxD6ji8KkDYR28PLfcpKEirsfUKzpCqetmFX8bX11qL3NfWKtDFOJEvOCTvknnJiALFMm9VPoGhyizua5DUQDYXSr6cOAb3/FBhDbRm/MnVhH+FrQ88gb4SoMZZDbOpnoJtQ02vfZuspkYfQvkmIijz7jIdSVPuVgIhA0LRHkIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241587; c=relaxed/simple;
	bh=QELEx7yQDzxOJN/8x5wJ6PllRnR75skSsk23WY44Jow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JUhoAe7+Av8m9iKdcf468cx0UztsbfBvObTdmMVNOnDOpJTT/0W5Qi7i3hi2i7bSWUD6f8M+0rc52KbalGsz6c+ncOwF1u/GXXCFuyDiiFJMAgSHj5lx6iF8CWJqLrlYVSWsVbkQpunJmbysPOTPYNwTSNJh3gAN5LG8nO5RdZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fIXG7A/l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WYh6tLAr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fIXG7A/l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WYh6tLAr"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 511FFEC00B8
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Sep 2026 05:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790241585;
	 x=1790327985; bh=zDowPq66ocYHSJI+rGe+yEABaq5cQjUwV8mUopyb7Ps=; b=
	fIXG7A/lVYs657yXTOx4Uwlh0ph/G2nbCkxvoM1JVLvSXNPzapnpBj3lXgjZm3yb
	hO1O2kjLBQHpGMFjj/hb7aVzylmwj9bLVmOyqzyunz3CmoMR550l8ANDSaGPvUd3
	8etaOCeMuoiWH/EBQnOgriGF3kNgtmQjkoap3LClY9qtQyN9FZ5CacncMJJQgc9S
	sKpzRBCytPWSvA3lWQgx0s7rjKUrwbeKXMWYfcrpbZf0i8k1TxcqAi95bdz83e3o
	8ZYdut8kaZBmMfeaFra8hSy2v2G+Cb0HAjAWQVHMJ1kxtpL8fBKGAPmg7W8IiTwu
	qyS0gMHspf7e4Lslj5w/bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790241585; x=
	1790327985; bh=zDowPq66ocYHSJI+rGe+yEABaq5cQjUwV8mUopyb7Ps=; b=W
	Yh6tLArzIVQ8KnU/il2Ta5y7a+Yje7BWpK4ZljtWiZ1xxSvCbzfkBHJj9A5u7MkL
	rDjsgOnVeqzI/urv2YNmKoYkAd3VDKf+UbfxEtsi74DLMCV/9xD6YnqCQMmO6/9R
	HB8EQ+17uAmzRrD9lDPYf91ioOIYuHgwwBpWWfvUbfMF3XqRrMDaEAPdjgHeufdh
	3NBiynmPn6EG/DlJB4fsdAtXA3wPeu4qctiIJXvCyk9dZBTmwJb8Kkj4ct2C8B6n
	9ZhvJftmB3o5PANSQVGRCx5gnunX8B5fCz7gqA+kLfqpp3Zf2z4TwvNC7m0aQbIg
	VXdaOaBfLa+D5auHHjd5g==
X-ME-Sender: <xms:Meu0avhkElBrznTKSrKBIOlbwgrfy4dX-B15_ANgCopG-QEfr_Wu8g>
    <xme:Meu0ai_iy2m-qyG0_BO-RPtFH40G5OBzX4L3ybNUGRER8UMTx1H8EbGlt6ikpGfu3
    HSZOpLwc4C3Eu6D4OtQwR-T0O1_5ADfs_hoel0sMKKG25Rjvl9Hg9o>
X-ME-Received: <xmr:Meu0akvze_rHp5rCSMtzXB6eZ6st7Rkfy4Xe0cDCPJ43YUOL2h-eJjeZdP8ob19TP7xEcJw>
X-ME-Proxy-Cause: dmFkZTFPodOiLWcdqf6sGstU46dIiqXidIFd9cR4fooPG2VzhuQs4sgHwSSL0mI+zYrJki
    puKwTM6PzOLvhrOnHha7/ZqJXKFWeUZ7pL3PmhkuvlpM0SAOkWbZk3xZQvHRMhKdNhwt4b
    RD3a0i1KaVTQhiwtqarc8pf3XfoXA6W5MTyTZacFoe6F2umLNsXJ1ouYl3pIUvkblQZagq
    My5ETPa7FIKiTyNS2see97qCZqfu7GXNWEANEz90j9Xl651gCUX4FzvDgltnokz25gMaTM
    HthS5xNHFJNXlc52D+rP6WxTTQ+lRC0R4uRCl7fXgiak8N0bh0v8/Rl7rSKJ4fouMiwlCa
    T5rk2o4zICcRbfwe3aQ/xMO5e0Ubb9cqcyVN3urrI/EPphpGK+7YcexnJHhNYxy+6qNTUw
    /kOwGD5UvkbV+7YwfRTi89qzrbtu26Ob3tSvoHCfkAUjyVXQ2kL0kYltsos91ogDaQOAZE
    ZtFK6QqU7FFXVihMswrUzIxnczE4/E1hrczSaYJSlyCKLX1ahykWso0ooj5CyImsEWD4pW
    5gvJsmK1EoLt9gJBtp8/XlWmsFgi3HHTJ3pHyTMfeJXuYs40mWfOMuxZrm37KWUMfKDA+Y
    +cNhadbrBrCFJ7bAORLQFkHXQqI87oSmQRMlQ0IT5KuivDKJH430GxmgmT8Q
X-ME-Proxy: <xmx:Meu0ahZ69b5mRJuLWxm9Vb2XOZ4jvw0pOH9y10bv2kptsXQUYyrDzA>
    <xmx:Meu0asq0oRtAB3LArwSG7fAILAf16r37xtck5sWnUaKnWenD-8QLjA>
    <xmx:Meu0au9iKqSsx5WV5O4n0c7qFjHTRz0gVPa078jW1w4wj_5VuSO-Jg>
    <xmx:Meu0aj_jQYCWQcC9WkrvMco_S4OuW6Nxv4OHZdEYm1xL1eBTwUnxUQ>
    <xmx:Meu0agh7NFv678sr8Dc-MOuCbvx1z1y1OgdW-1sMCG5EgTNCABlV0Y0P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9da0b670 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 24 Sep 2026 09:19:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Sep 2026 11:19:22 +0200
Subject: [PATCH 4/7] builtin/init: move handling of "core.sharedRepository"
 into "setup.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-pks-create-repository-stateless-v1-4-11499557cf31@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
In-Reply-To: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
To: git@vger.kernel.org
Cc: 
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

