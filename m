Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EBB3DD514
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559207; cv=none; b=GHLDZXVr4VqKmGcrE0z3SqnybvjQIGNcsBPQv9vL+tL8mnBRCDrAq67q9Wz3QNBYQ8EpQQ5yux9rqYc0d3bR6TcMzvRXcatGWxS89YcF6Xk0Ln02IeTDzmroV9peHAK1nN0nONhfDprC4kVhbgWLLTnFNUxC+sT+ysbbotwh6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559207; c=relaxed/simple;
	bh=YoG9Y8m119rtdNuyiYa0QQBWGDd4OvTKLkmJbbiRAno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6z3rVBoB6jr1cynhvRMZXn3AGA/Jk9GFjDNIv7WZ23WyUNlPICmT6nhURhu53RPZBYkwPlP4Bwvo4ZluHX6Z7GQGyiWmS0JnRsoNVmNS+vQ+s/0sNkvWPOgjYVxXYgv7sWXA9X2BeUGKDiVAAt4yt/5cFdYDUIOr+QNr33DOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NPszLN9u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hE4uIiNI; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NPszLN9u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hE4uIiNI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 01503EC012A;
	Thu,  4 Jun 2026 03:46:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 03:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780559204;
	 x=1780645604; bh=lAYGtuIAX7SVgQNR1+QJYrFJEX+QmMyI7Jb8OHW1r2E=; b=
	NPszLN9urcGKR1hF6MchkecFzi/J6yTIVSo3+yDSRSF9OLhuNjrL3rVFvZ6Y/BIJ
	rue86UATi6G0fMTBYQcrYShKmTz5fJx2DRfjNvoTbPJej39O4wGDXh1sdWt68yDm
	P5/0S7gDMC6XY06pWukxalGRNrZGPjovrrVRxdontCU4xuhfEu9A/xp6tH5rPY3m
	XqbzFB/9yLTsOCFz57bWyV91ix/jpVommwQhjugHGhrTdCmCZzTPdTcOPCdZyG/A
	pr9659SLOKK0V6GQ2IVi+cZHxIDAJGgNBPp2WeBa3lN6/s7sfu/kFJ384nfgSw2B
	IAV9aYq9q6+MhXc5+p/WbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780559204; x=
	1780645604; bh=lAYGtuIAX7SVgQNR1+QJYrFJEX+QmMyI7Jb8OHW1r2E=; b=h
	E4uIiNI9d5/DDrr35H/us6xqT3r45DxEIx+pAoNGG3fy8ADHbQ9yI2i5IuTTvZ8x
	AmM6yM0cm67NWqpKIpVnT6CebRVFNeF4+coCOluMdxGfAemjULWJjkYIERoZjEAR
	ECXXCGBTHhI9tIXL6hNKTJFi7CDmWxOEf4fecANKExMaHAES63BZ4oUlbaH9izQ7
	Ci7z+BEkObKXUzi9CJPHEn3WI3SOElXol9zNEx39PWBuAoYAEly6/KQi6zM6mVoS
	d1I2JRoxmKL+DJGcVTrSl0Pf2kW9SpgVtaOnTC6XMawCY5wU+zspsLozLjiqDqDU
	0XJ5rcdhAcpaP4h7AFvHA==
X-ME-Sender: <xms:ZC0halkxLxXn6SbPsarpZQSphq3T-g_4E7XqCaGicTelG8sSvDbTTw>
    <xme:ZC0han25qHo9891uMMb9z9nC6bm0F0yptQWUxYwbDgXooq8GYkT5qe7C3X0GW7Gat
    6uI59Lia_78FMgYhwsbRV-F1XG6YLbHKbg2pyGa-gj_OGBb51NW3Q>
X-ME-Received: <xmr:ZC0hagpWo6OslCYO6v5DloUiEXnYwd07UcwP8Tchzhkl7KyxYe3bZIUOQnBIB-QoCWC3eoBND1daLNqMjonWYcYETJi74E5hZw7Q__FjbzM>
X-ME-Proxy-Cause: dmFkZTGhxnEHpPYRfkYwrVk9CvMD/gy9+RwFxuxewttP632BuodwIhLBPqS0tGa/W0UmLv
    7dRtKxJAyCQXYHS1ssdOVK4eYn6AQPxqA2nPPXNw33ZvSAryoaIVsd9m2fF98906KDu89E
    0dwdOj/gFzkYPI2rh7o0xGlm56B6RVfGjglopqL39L4tATVvd1Z2/tUfcF9LAKFfVywOx4
    9kQmC+TuR6fWOqXkOMYNzMgYGfd1SXpHm/N0LhqxKv8HZrQ4j+pd53HQ7tm61Lb1dGIavo
    hGfj9Ry8AN4Mg7aMmuQhyLLzW5lBB/9q46FjrRfoBhVa/sD93g86VYmknHPMphOd72Rxte
    MnlnR2jHwEcPyaiRUFPKDDe8L+JZYOmeWBIJE8FnW+6LwL2VXBs00Wk6s22RnwfJ3CGKt2
    rA/m0VCXi9DcogNLSfppzgjqmYbTYVeGAXw1J2S2GXSME46wQP/qBE8aIdgJvhKD26Erjf
    JxH+EuUwFsZLYAII2FEEf5Uosg4OlrSvEc+ZZWecl5mPIdaTxT1JSwOan1le9yL8NgDaKc
    NFHfrk0GyVwpETECg3IsX5TUtZ1T2BuWLxcEucB5MLy3wqUn+I+wUau5IwNb+2FqAFIgfu
    D3mJzcfD8waXlz9di57K9CiI0QXbVTxf4cE96os07IiUkGE1/6w13jkp58DQ
X-ME-Proxy: <xmx:ZC0hakesMEJbKd9oyHpZCH82ER3SS9gkwidzyoEFtaOePhIg6Tu19g>
    <xmx:ZC0havpZNvqAu4eK2rhkfHRzOgbR-rwC9EG9N4Obf-JYYAKXy3Fotg>
    <xmx:ZC0halE5CWspgoaDPNGeC3G6ysH_kSmmXVkrqiDl9w_5GHrauFf11Q>
    <xmx:ZC0havtAA3lvyzsN1qFNIahYvfKM3XJgFfaXBiyUrWIrPPTPH2ZTaA>
    <xmx:ZC0hasKsQLtdxojufIb2FwkEgfBnzSVQhFYqNl4_PoLeuFCN44-IlddV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 03:46:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 932e0fd3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 07:46:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 09:46:26 +0200
Subject: [PATCH v3 2/8] setup: drop `setup_git_env()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-b4-pks-setup-centralize-odb-creation-v3-2-0691834f318a@pks.im>
References: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
In-Reply-To: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
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
2.54.0.1064.gd145956f57.dirty

