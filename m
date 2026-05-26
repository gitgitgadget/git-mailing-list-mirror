Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522728A3FA
	for <git@vger.kernel.org>; Tue, 26 May 2026 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775031; cv=none; b=VUn61Ixuz9zYjjDJtHGXeh8MzYCwFmhnSv/I9W9oUaYXDHOOV0e/ZKWC/qUAWgv2rXUmVWCDxEQOmsIcWfawWLU1woBBbuD0XBM5ew1xHBsUmILK3xVhQOh1jJ4g1E5JPjKV89IeqYrgE6lL9QPfJmRE2AEv2e7ij0BZN5fp6fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775031; c=relaxed/simple;
	bh=BkOV15YYP9qwJC2sr7sSEo0n+DUNOGw5kZRd2ClJHik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SN6kcBqpak0wMuOOMy2yb2QG9wo9eAb22iAe1V7a8uZILrR2BPIn+QK/KEr1Mdf62QtUvHugwl/hodpu/WEDsDltVftYalUGLRGsonfNHVPeYY4dooisOSm4AUnRKbIHTi4gt+6csbCuPvR6oQAvt4dv7s7SML0CSyA+XH5mX5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Knaq3Wgg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vuZJ0gbc; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Knaq3Wgg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vuZJ0gbc"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A53F01D000C7;
	Tue, 26 May 2026 01:57:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 26 May 2026 01:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779775028;
	 x=1779861428; bh=6jYOzlAVEwbg+BPgVpF8R7pMN/aHiUUu2S/iWX2rNFo=; b=
	Knaq3WgghotyOU7IecCVIlJJnJqTCrECk+m2vzZqtXW89Z8h5BVnCcl8OXgVeaPf
	9sKO0eaoXkQlVLXtiDTeE0kMKQDakTAyQFd3pYN9tA6TNl83olw9nNjm2dQ6+Zl5
	Bmz3j08RwCmTXNJ5NvapoQpx5heo5JZ8FZ1MZQDmmjVSTydtz1SrIbrjh8aJjhbZ
	EQK2LEYTFl/1weG6AZTD80kve6VEr3xyRBkTRrFObxTeJNtmG2VSo525pB/+nmiM
	NbKSq1JC3o4RENd4JxXOM2UDn58wsN7h3Wzl6Eh5kv5PNh9Bda+fu7hK3eEpUaK8
	yl2eWXvBCzexpIB7glAJsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779775028; x=
	1779861428; bh=6jYOzlAVEwbg+BPgVpF8R7pMN/aHiUUu2S/iWX2rNFo=; b=v
	uZJ0gbc3Y1PmU4WsUliAkkxtOkYjYH13IuzvdScS3AzQ4LjMDXt89kAOiD83YUdG
	jtzDnolSzVH+bgu7RjiSoZNqJ0swGo0WgnJCYifnRvaohOOSrj5gKDy7hYJApzhW
	cdCahmS+TNna0aK+8Ef2m7PLkCUaF2wV54zMmI03gl0lzMsCiW7ZiAXkczczfB41
	LpoI8YzBBelAP0qTV49KJq2fNc7DJzfXG+6ZleAcPe+X33nh83IhWWCsOTD78H+j
	gCe3UxRFCHReed8nFFpt+JioiSqa3shk5a8oRZV7AnmE6fzL4PdF1Y/MipLghTuZ
	DyId7HQhrs2+Qrr2yPYzg==
X-ME-Sender: <xms:NDYVaj8aw3en7lfKYykOQKigpv20CY4WU6r-8N1qd3swjd6O-YNT3w>
    <xme:NDYVanK-jM18KP8KiItWtT67fNvLRk7hbKfHx5L4QUGKXOogw-7-NsuDhdeTiYG7o
    TWcaRD6wjHj4_hwMwC5XqBTf8E6mGScpENQFsdN4I811GTNQfawng>
X-ME-Received: <xmr:NDYVauaKnZnk5ynG1_4EQtE8AylP1IAnRPqddDzxu-LQImbGDkyKtxkptjZ1A4-ncMi_86AiB2z5x3ggbpQPFnSDdijoRh5qldYEprSFuA>
X-ME-Proxy-Cause: dmFkZTENDWPlIMehrI0p5s3nwkhC94E3+Vziz2RDPzn8dE1M2zUbfRmFf4UZfcnyV6gcS+
    CxVZxxC3667h+nAhR6pqpNggMXlVeZYl4wzEaI+cHAj5vReVVsTehM35WU8cFIvMy7RAR2
    sq0fQV5df/lYICvHIopy1DHD/0D9dQZ+yGFyfl6DCWWUsVYBztrbDdiCcnBYzMAu7+IeCJ
    IjvSOmbtjdbu+S0zT14pNcqslKmSRNuzmYU57jfQ53GS85OjSTswjgKmMrEguMgZ2qBqI0
    mjGPmHfCy62a9sJdy7nxYZhhmNtd2tZhnvvTcAoLqkPtY+35gVYtxanNVk7O0FGv4PbDc6
    b1y/QtPsC5VGdrZ3POEt5Q6GBPAnVQV8ER9jitzCs6Zees0ouRjsndNet7T+AB4jAj+zU0
    jzXGQEwVhQtQcTxZbJwADf7yA4jHjDyY69LVEGNxUxBMSHhmiA94KrvzD3hJ69GIiuxiL9
    DOHd+zUFCKbkjNnbzZFqHYkB8pyvyewDl6x5UlsMLLpUH5y3cI1zziJlc+aKTeyU+ZDLe4
    CZGFH2rU2s1v7G+FaTKJiv340vEPb94z2hPgy05uUWhGettJXvaLZa7muIcbAktsTK3N5w
    x/Rq/M284oH6XBkjN1YC39/zgXWRXQJNtSWaaIKUS52URrn0wwlHY/T9sJMA
X-ME-Proxy: <xmx:NDYVapJLsVtOSPNYrp38y9smhqFCxiR136k051YPtpF2TpZfZGyNzA>
    <xmx:NDYVasDUWwX2pCLi_PpzRzqxGm0O6BG35vw37HTbFDPs1hIllWU1Hw>
    <xmx:NDYVauqWz3Srxj_xSNChEmdGZT-9MgaCSS9QbCmuh7nC8XtGkWrFdg>
    <xmx:NDYVaniHhLc7f3PQelvF90lv42hpbwKShV87skLcdEGN-n5AEk75bg>
    <xmx:NDYVanRNknroi4dWnZ7A1cuIyzVatofXsDi150EInzKb8Bs9zhgxA746>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 01:57:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1aa3dfd4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 May 2026 05:57:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 May 2026 07:56:57 +0200
Subject: [PATCH v2 2/8] setup: drop `setup_git_env()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-pks-setup-centralize-odb-creation-v2-2-2fa5b385c13e@pks.im>
References: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
In-Reply-To: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The `setup_git_env()` function is a trivial wrapper around
`setup_git_env_internal()` and has a single call site only. Drop the
function.

While at it, drop stale documentation in "environment.h" that points to
this function, even though it hasn't been exposed to callers outside of
"setup.c" since 43ad1047a9 (setup: stop using `the_repository` in
`setup_git_env()`, 2026-03-27) anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 environment.h | 8 +-------
 refs.c        | 3 ++-
 setup.c       | 7 +------
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/environment.h b/environment.h
index 9eb97b3869..ccfcf37bfb 100644
--- a/environment.h
+++ b/environment.h
@@ -130,13 +130,6 @@ void repo_config_values_init(struct repo_config_values *cfg);
  * `the_repository`. We should eventually get rid of these and make the
  * dependency on a repository explicit:
  *
- *   - `setup_git_env()` ideally shouldn't exist as it modifies global state,
- *     namely the environment. The current process shouldn't ever access that
- *     state via envvars though, but should instead consult a `struct
- *     repository`. When spawning new processes, we would ideally also pass a
- *     `struct repository` and then set up the environment variables for the
- *     child process, only.
- *
  *   - `have_git_dir()` should not have to exist at all. Instead, we should
  *     decide on whether or not we have a `struct repository`.
  *
@@ -147,6 +140,7 @@ void repo_config_values_init(struct repo_config_values *cfg);
  * Please do not add new global config variables here.
  */
 # ifdef USE_THE_REPOSITORY_VARIABLE
+
 /*
  * Returns true iff we have a configured git repository (either via
  * setup_git_directory, or in the environment via $GIT_DIR).
diff --git a/refs.c b/refs.c
index 0f3355d2ee..e7070eb743 100644
--- a/refs.c
+++ b/refs.c
@@ -126,7 +126,8 @@ struct ref_namespace_info ref_namespace[] = {
 		 * points to the content of another. Unlike the other
 		 * ref namespaces, this one can be changed by the
 		 * GIT_REPLACE_REF_BASE environment variable. This
-		 * .namespace value will be overwritten in setup_git_env().
+		 * .namespace value will be overwritten during repository
+		 * setup.
 		 */
 		.ref = "refs/replace/",
 		.decoration = DECORATION_GRAFTED,
diff --git a/setup.c b/setup.c
index d723306dfe..252b443117 100644
--- a/setup.c
+++ b/setup.c
@@ -1074,11 +1074,6 @@ static void setup_git_env_internal(struct repository *repo,
 		fetch_if_missing = 0;
 }
 
-static void setup_git_env(struct repository *repo, const char *git_dir)
-{
-	setup_git_env_internal(repo, git_dir, false);
-}
-
 static void set_git_dir_1(struct repository *repo, const char *path, bool skip_initializing_odb)
 {
 	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
@@ -2023,7 +2018,7 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
-			setup_git_env(repo, gitdir);
+			setup_git_env_internal(repo, gitdir, false);
 		}
 		if (startup_info->have_repository) {
 			repo_set_hash_algo(repo, repo_fmt.hash_algo);

-- 
2.54.0.926.g75ba10bac6.dirty

