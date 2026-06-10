Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F5F3F4122
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103448; cv=none; b=KBhZCspLevY8imLk4FfJW6TKIxRJ1QdRO1b2442eLD5wCcZAZoyM2m3fY6Uyw9+2MuohZFpoKwl5e5MLuwtXjNkMXA6BUk2PcII0rIcmkt9IfzhBB2Vbpnm61VrFpUEXyJjkxN1C9Ii/cWsn8mRVIhT1Bw0TvXYCH1BaI/ru3qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103448; c=relaxed/simple;
	bh=O0odF6WxzckPQ1J/+/d4IAalP25le1lIOU7RKdi0PXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TD5b2zzu6HnlUVMFPrFAfGEDto4UjFX3wzlFsBI2Fl7mYvLQj5PSsFZpfY2mZS9tzoanZtqk+lfGT6qCTvI4hEnQERfQb+hIsVID+zSDScGzgMFN6p6zQ/60Nh6xlRmhuqNrgmmPJW6yP06oa/AZK8IOqE7lIZaGnztDMiIl464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K0CQHhFn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Md7N1h18; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K0CQHhFn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Md7N1h18"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E6F19EC01C3;
	Wed, 10 Jun 2026 10:57:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 10:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781103446;
	 x=1781189846; bh=kDR6MexPNGuLlI1tyR9ENqIoXDfPYID8rwf+fcaOlbY=; b=
	K0CQHhFnn92G84eAp4+j1gSQL6q4X2neHi4Y37ExFWXewAfRmn4IExu6w69HvEDn
	dU+hs9W9P0F1CQa7zJPZUjbt9T5XyoK8Hb+iuwEpsrmsoy4I/V0BowbbptlhOUKC
	TXO2vOKWyLNzaYTHcMA14Ct8FzzSEMPN/eemIwaf1PlocqTc9Y1uBYAWuq+/b2ab
	u5bVadlXEUxk1eRGXPWWuoQgzBZ0iqnN1sSQWPk3lUdK2K/6JW587WHCH+GYFxoV
	k2M0w6889vyuJVny3fcZjK6Jm9Sbya8ROzqC9KNzfyziIkLuy7zClUzacCiVbtOy
	RDJmRX7tpMSGTVtybt/IFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781103446; x=
	1781189846; bh=kDR6MexPNGuLlI1tyR9ENqIoXDfPYID8rwf+fcaOlbY=; b=M
	d7N1h18q51jA91Ziy/w8uo15b6gB8eAutTkID93HC/25YiULoZwb8LeL33jqDL1i
	TWZbzhdhZgDQfeb9aWvmIv8WYqz1FzLK5AvPKwiSYJauf0YyVx1h0LKi5tqe6m49
	SB1qbJajPIQ0DjaJZbzdVINpKjifudGiWdx9G/f69vyOTk0qX/y5yXMok/10+PCN
	SfpNpclTDBIwkedjvicMN62KeLGC1EDVXm7gtfvkAlT3+OxqF8HLpcjv6p3oE+Op
	Xdx60LYh2rD9Zp3+Ada7j0gf2DKPloY2eqKV/M3s8HZgNBFGXGM/FEP1h6a/qZh9
	upN4ld4LrcbVXg4ZZtSQA==
X-ME-Sender: <xms:VnspasY2t7AbpqTav-eiraD5Ap5l0V5eWifRAcEWneMPPKzcbQmlhw>
    <xme:VnspatbVU-SbiSWcZmWYv3IbSHHpxStWljwuSGKO2BOUzcXnDoqfK1qTNOPmTfCAe
    XVMeRWzQwHjaMQkNJRhMDNteLTIi37vrCKpkxGWN1ypa2u5OgcTa2Q>
X-ME-Received: <xmr:VnspaklGYXMAyaevNKglc3ia-gLaW00FGtrmwRhUcb3-DVv-xc7qmqrydLqDiIPV3AyxpNZDqB_etFqOkleFd7K26P4ynTVSFcBFgdSapA>
X-ME-Proxy-Cause: dmFkZTEJn+HOU7rfleF8wtEqd8n463JF/vFO1XgyixYBoTlaS7cpi00RU70QgROPWwUdI8
    Y2g43EXoqSDarANLeg/qY2LquMRGd0tg55WNrjpoPOxekNmdm0CiNmfLlAe8VSeyDVX037
    1j6uyoB+HxekonkoUDl50g7yk3LRnYScK6sStb5pBzwl/bteJm6VFNzksB07RoD4dmcJZY
    VdiIKVbEs3XzVwXK7AqTzvu/5bPY1eoMkecDU5MTuqJ0bbzDKf6zfqc/3gVc1Tt/VrPF+4
    ykKleLBBcmf2l0TF3giI6aolK2tMnS7lvcFPqLcY2GjwARLogkLqndIPr0EeRum5dexwB0
    H27p1FFLGwjCrwki9lO4CUOZEfUlvHEEkgkXya5Itc7IqjRrSubQZzrta0vor+JW/1KR+q
    pq6Xhcf9W6OX/Qbt/pvQDL+v+lcT5Ar/+O0GVBjWtjkBS7Hr027pxOtAcvIGY3UlT0tLiS
    tc+Ea79ETZjScc4cuJvQU66lWweNtmh1TBSLy79jIB7NngHZlrdUyJm4Kt3Nbp07C+Xu96
    bMvsOitQ4zWZpjTuqPnkl4zJvjQEIL7ljyP1KpVFphfZwd22QBElt9l9RBTbrhfZKB0aBG
    DmfjiT9c+6YDYubtcRQS2YNvtZ/97nGL8v4oZBvJm91Sh6EQWEOSOwPp6VTA
X-ME-Proxy: <xmx:VnspahzMtsYACj5RtJoFh1ZOVIM7-BeY5i3oZFnIDiS1htGv5NXBsg>
    <xmx:VnspaqONzDKH-E4E-vhkIItHp0aV6TWuwIvj_WX6NywwPhBWffz3Kg>
    <xmx:VnspatSrNPKDWwemwFcTp9ifps_Vza6FX9PfL0_yg63BCwhQ6xZjQw>
    <xmx:VnspagZU0o0A5qwU_cWYHCPGokXkTJHxeuV_ps_9Opy9PBf4t9i-bw>
    <xmx:VnspaiKuRVu25II_m65kmzZhhBFSQRfOw4ljvl3lh9i3WhZ2sxjvYSyt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:57:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e085e0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 14:57:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 16:57:08 +0200
Subject: [PATCH 2/9] setup: stop applying repository format twice
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-2-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

When discovering the repository in "setup.c" we apply the final
repository format multiple times:

  - Once via `repository_format_configure()`, where we configure the
    repository format for both `struct repository_format` and `struct
    repository`.

  - And once via `apply_repository_format()`, where we then apply the
    `struct repository_format` to the `struct repository` again.

As the format will be applied to the repository when applying the format
it's thus somewhat unnecessary to also apply it to the repository when
adapting the discovered format. The only reason we have to do this is
because we call `repository_format_configure()` after we have already
applied it.

Refactor the code so that we first configure the repository format
before applying it to the repository so that we can stop setting the
hash and reference storage format multiple times.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index a9db1f2c23..2748155964 100644
--- a/setup.c
+++ b/setup.c
@@ -2710,8 +2710,7 @@ static int read_default_format_config(const char *key, const char *value,
 	return ret;
 }
 
-static void repository_format_configure(struct repository *repo,
-					struct repository_format *repo_fmt,
+static void repository_format_configure(struct repository_format *repo_fmt,
 					int hash, enum ref_storage_format ref_format)
 {
 	struct default_format_config cfg = {
@@ -2748,7 +2747,6 @@ static void repository_format_configure(struct repository *repo,
 	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
 		repo_fmt->hash_algo = cfg.hash;
 	}
-	repo_set_hash_algo(repo, repo_fmt->hash_algo);
 
 	env = getenv("GIT_DEFAULT_REF_FORMAT");
 	if (repo_fmt->version >= 0 &&
@@ -2786,9 +2784,6 @@ static void repository_format_configure(struct repository *repo,
 
 		free(backend);
 	}
-
-	repo_set_ref_storage_format(repo, repo_fmt->ref_storage_format,
-				    repo_fmt->ref_storage_payload);
 }
 
 int init_db(struct repository *repo,
@@ -2830,10 +2825,10 @@ int init_db(struct repository *repo,
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	check_repository_format_gently(repo_get_git_dir(repo), &repo_fmt, NULL);
+	repository_format_configure(&repo_fmt, hash, ref_storage_format);
 	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);
 	startup_info->have_repository = 1;
-	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
 	/*
 	 * Ensure `core.hidedotfiles` is processed. This must happen after we

-- 
2.54.0.1189.g8c84645362.dirty

