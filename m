Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC89384CE8
	for <git@vger.kernel.org>; Thu, 21 May 2026 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349364; cv=none; b=ELFheeDqQBOjcjxZKdgPveqXsWCZixFT9mzAkSxkre2NSOrPTuHNHpboOv5lJ+/aeQCmOzz1LyU68jFDydu6ECvttv9twSrh5TM2zy7KioJTjO5SLFnjHSdiIPx3RS3h46vl4CBLv3oJk1nIMoJYmmgXBeU/J9ms2heGrFkO74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349364; c=relaxed/simple;
	bh=oaXYKYaWmp6AcVJ2yFCtmidV1MLgRol1V3uEsuKqkSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yjq/oLtb7JPO6pzZvnCq0HktmrescqA256ewk99pX7vW3ZoFSNLeHoNl42Sjc+hSDdeSrOS64nTzzcAkKPN12HTX0F5GZd/huBC9ymhNas8dkuBhvBZK4SWZg8Tsva938RBINHusq7WuxfzFO0ME9E0gjqrsDIHG0UmyGko7Mzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DR2Lf5Qi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vmgNtRQi; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DR2Lf5Qi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vmgNtRQi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 408181400070
	for <git@vger.kernel.org>; Thu, 21 May 2026 03:42:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 03:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779349362;
	 x=1779435762; bh=2MXSWSNCRxXab41eIz4FebuQurEfYA3u0hpkVA2VZlc=; b=
	DR2Lf5QiWydkglCw8hnOdryC6/y/v2lshX6m5eDM+EVJAQ9cGG85bsja1ds9DRuA
	zGPq8rACcOv9fClG3gU+M8818kR6MdvbfdUxPpL6XyQXAIkYxiV46fae43eIAq77
	da9TC+XNWtsYWw2bE5AIcewNeKTe2M0FMZV4zaY2kHPJStAYKTEPE3ZnLALz4YOc
	exFNE/vcHaWqHqUizhnXZKUev275vPOmLm7N/s/R9cCzlI+dhJ7oIPDuHcJU5BS4
	XqgzNd8rNrxmh3uYeUad43R3Ah+i1M7/SRmJ0lOKr1ZEQezQAFiqmqSfX5pJ4d10
	8xiRpTEAJARvzi3RX1e5ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779349362; x=
	1779435762; bh=2MXSWSNCRxXab41eIz4FebuQurEfYA3u0hpkVA2VZlc=; b=v
	mgNtRQiCfsSjtmgcDExYKo/FUtiMrbdADneIxHu86J2h5t+rT+UeEugd1FhX9ddn
	a3YxYkZ4izyEzzVE3EiKffsefswgWmxnPBDGLGwR4gAlOnnff495JKzK7OnpNe5T
	+bSaPET3VRWB9yYaCoJ09SZnbnPBxjTzBi9MT2DBSo1GrsBDLIVepdXPe9C7incH
	dj4khzpWDNBdzgl3KBsL7P+Q0R0rllIjwm/xwEhwu9HVgHr/x6ZvTJH2IOe1qr55
	jz5lQXWLrCM1J8BXaFD1qdqMWiI9b1TMvZZ+thq+iEU10UvPnds/J/ScAu24fXfl
	QDPFYOsCFOjFe3T9JO6DA==
X-ME-Sender: <xms:crcOaqPP67njfQXL3fqYVcsZv-ioD-OhxgrWvMtjwsU2hJKsOAr2-w>
    <xme:crcOav7u13AOg-NP4W54dR2ELkhiGK64_5sRapPC7Ik-gLZcVMhHSeBo4YW1gKRhJ
    3ZytPeGa5OrqEdSbsiKDGna6L2mo55-8LF_R2lQnsR9JwAHkywQpw>
X-ME-Received: <xmr:crcOam5h8x5Jlsli5dNlhvY5dHkaNZn8tL_Uwq7TPqqWWNs-QKbWadU9LlSZW4aOQL-SMMhy2X5JKpmiYugT80RFWp7iLfM04tFkyz_MAlU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:crcOav3QBnWViOk066Beo5MSWXimOIoMpPalUyfRWAvTNommM5FUNw>
    <xmx:crcOaiU_C6QhQTWPGycjpKxUeZKMkahDQjxrIjWgzRDahPPTQ41WtA>
    <xmx:crcOaq4NTAH29eCrW0dN2TlQm0-wz1aM2N_Jpa9X0k2hdqWU1cTXrw>
    <xmx:crcOapIwE3GAqss4EW8VYGJzCqlH12a3Z-d_3zgmfE-FC-KOiHJfXA>
    <xmx:crcOaq9Z9biGImkXAJPZdtveqLfYsDBZe-2EV-nbKxqc7Xzo80guszf_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 03:42:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2939b102 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 07:42:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 09:42:29 +0200
Subject: [PATCH 2/8] setup: drop `setup_git_env()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-setup-centralize-odb-creation-v1-2-f130d2a7e8ae@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
In-Reply-To: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.54.0.771.g3ed373ac14.dirty

