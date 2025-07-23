Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9394D1FC3
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279720; cv=none; b=A4BHbhlPaDgJaTqvJjjlY2yI8ZUUR/xwJcFVlxpIIYIBiVWFXwWE5h9JbU52Abpk6CgRs/l/sothNyAfkqwuSGRuv3gPWiCL5jvXA4DnU/kBRwkX6Y1lXZx8sJ3exhPQgVfHrDqtJdFomjg6Mt8s+07Lcn89n+tchgjaqOlda7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279720; c=relaxed/simple;
	bh=1DnojbAiMPuRDCUnRTjlAH+Vf/RTqWIWILuflhyS0Bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YvG+qaMTH37IYxw4XJUnbq7iYwq7K/8NR9kgrFfzRCCSvwNx4Cn+1rqD3gy0uyKXBd6p4SgIKx9Y27m8XQHLYqeiYPAIxXHP9GSdDOrTJU81KpWmiN1T84jDuE1BkgMAw4zzALwAf9pK356BQ9uIgBMXISNaaVECDovsv8OLyjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qzMZyhex; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kxms+Zhc; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qzMZyhex";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kxms+Zhc"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 79BD1EC1B18;
	Wed, 23 Jul 2025 10:08:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 23 Jul 2025 10:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279716;
	 x=1753366116; bh=TBAx0xq/oTYZ0Zju2wtDAqAmBUYly2/ycgRKRrF6FHA=; b=
	qzMZyhexMDeY7dQlSvyl7nH0GxAftZZI7aBxTh+nuqu6J4XFbEyYYohn2CZZ1qXX
	egvBhDt5GaH6YkVHUmyeC4wxCubiqBdtrJBuZABz2EinapVHDRQGiUM6/db2hVX/
	TaXwSzz5NVZRuQbXvW23qpnWbwpp8zLHHG+YGQegzoX6LzO2ydoXiW7zvLOtlXOj
	i0mpTGfxilz0QEVDIP7Q7rlkzRap5pAoi+MCOnvJxtTwhT9ZY8ZFRiOMfaZhJdWs
	9cU7gkOcDEKzjvtFeKEjNtpO4vPSEe15yn6UCwzEKKRtLE3fEVnDeK9hTfyzhwgr
	1FTJhWeHDi2AOnGPPnT68g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279716; x=
	1753366116; bh=TBAx0xq/oTYZ0Zju2wtDAqAmBUYly2/ycgRKRrF6FHA=; b=K
	xms+ZhcoNzO9mzmANtBLRcqZEXATmFHRX29RTdmYlnXB6HPxy9G1WxS81+5/YeX6
	qXOdFDq9aKdqCHUYcEIlVbtOgCxpNE6zkiiih6iUcXPffClJxhSFrC6xrgCZp4Ut
	S2Jdeo7ueMIAfF/mT5ZBZtWqxGJieKHexYpx68fQVOGFhx7MdROdjwBadDFxOKem
	WZT1/UPOMENZyaO4XNGLLjXtUOqJGqorNwxqnEUrnnBrazY+UMoM8EyTvBezOTHN
	7ucZDuUMM2L2bwOL5JjJUPYTPxlzbgmG2e0ZMyXRgkSb+CbmJeOUEnzImNtywdMG
	hEzKzCZiGym/psclHi73A==
X-ME-Sender: <xms:5OyAaE9VzcOkiQveJPOKhD8eeYr5Navu7suoeSnglO6wuvJSVT6Bmg>
    <xme:5OyAaM5CLzTiaF3km7_wikkX2p4Tb572EtPtmpMny0s0W47jyWCqnaO8YhUcy_Yoo
    -2BaWJ2CJwc3tHK2w>
X-ME-Received: <xmr:5OyAaL3O5g9PgdtUvhTsQ-WAP1sQ5yKAhSkw897y-5euKu2gQitI94m9-aohcwKgFVjfSMIrE6YSmFV6gpFjjT7arGbEqzZx5Hbm8mKNh-1M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5OyAaDBSBonx9dH0hM1XZigaHt3PwCVAILjFEhKMOq1REQZQUffmxQ>
    <xmx:5OyAaN0JYAcqCezEyf3D0vuSRpztm70MF35d-a6ZzbAiPQ8JOAbuPA>
    <xmx:5OyAaNtzEQZQQ0lVC7kgMXXGmP38sP8GoNlU7Gg27fCdjXORskVRTw>
    <xmx:5OyAaN4NO63IXEmoItYjJcdS4m3hVSKSxgl0siim3EaS-2YC3YWs1A>
    <xmx:5OyAaBNfDvMilreH1PhHON-_ceABlC2cOzI4xMYAqPpQtsAasYoQM72F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:08:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 46dc83c1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:08:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:23 +0200
Subject: [PATCH v2 02/21] config: drop `git_config_clear()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-2-1502d60d3867@pks.im>
References: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
In-Reply-To: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

In 036876a1067 (config: hide functions using `the_repository` by
default, 2024-08-13) we have moved around a bunch of functions in the
config subsystem that depend on `the_repository`. Those function have
been converted into mere wrappers around their equivalent function that
takes in a repository as parameter, and the intent was that we'll
eventually remove those wrappers to make the dependency on the global
repository variable explicit at the callsite.

Follow through with that intent and remove `git_config_clear()`. All
callsites are adjusted so that they use
`repo_config_clear(the_repository, ...)` instead. While some callsites
might already have a repository available, this mechanical conversion is
the exact same as the current situation and thus cannot cause any
regression. Those sites should eventually be cleaned up in a later patch
series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.h | 5 -----
 scalar.c | 2 +-
 setup.c  | 4 ++--
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/config.h b/config.h
index 6b729fc6bbf..4eea99e9b95 100644
--- a/config.h
+++ b/config.h
@@ -719,11 +719,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
-static inline void git_config_clear(void)
-{
-	repo_config_clear(the_repository);
-}
-
 static inline int git_config_get(const char *key)
 {
 	return repo_config_get(the_repository, key);
diff --git a/scalar.c b/scalar.c
index 3b713abca3c..2aaff5aa109 100644
--- a/scalar.c
+++ b/scalar.c
@@ -763,7 +763,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 			break;
 		}
 
-		git_config_clear();
+		repo_config_clear(the_repository);
 
 		if (repo_init(&r, gitdir.buf, commondir.buf))
 			goto loop_end;
diff --git a/setup.c b/setup.c
index 91a3affdd8f..9661c5d5d5d 100644
--- a/setup.c
+++ b/setup.c
@@ -1741,7 +1741,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 * configuration (including the per-repo config file that we
 	 * ignored previously).
 	 */
-	git_config_clear();
+	repo_config_clear(the_repository);
 
 	/*
 	 * Let's assume that we are in a git repository.
@@ -2337,7 +2337,7 @@ static int create_default_files(const char *template_path,
 	 * disk).
 	 */
 	copy_templates(template_path);
-	git_config_clear();
+	repo_config_clear(the_repository);
 	repo_settings_reset_shared_repository(the_repository);
 	repo_config(the_repository, git_default_config, NULL);
 

-- 
2.50.1.552.g942d659e1b.dirty

