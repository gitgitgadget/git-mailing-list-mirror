Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0862E175F
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673402; cv=none; b=JDJXAHwVI7rnlsYG+mtI0A2FOYpMr7SxCk0BBPI+74VDGVL4DJJvhTP3IxoYwK+S1FvsG7VQxkJS3b3Zha2QgrSeBWuA2UbSnJ8MUwv8F0q/ku9q4Dnn4exyaMIgJl0ZzBfnkpcIT76TwaFT2UoL4ZUSo0PT+rv32tiBriTR5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673402; c=relaxed/simple;
	bh=HLyqf5SJJVK+n0qkPNhguI5oI6lLObt0xE2UtXyqbBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fd5gqmIaqy1JbDEfrctN5YgPWeMJJ5dWzcY2Yzh23TVAS/TqhLOcox3dZuL72m8ED6ahda3AYmuT4/UBlYSLxXz/+LjWyqz8wv9dFgb2Z48hP6YYX/ncC4RZhZwv5VYwlyzq/MrxsY54j1ttUvPFaUo3zSwQgX8ZOfOJzOr9I3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QWQjtoU8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OX2o0XyU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QWQjtoU8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OX2o0XyU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3328BEC036B;
	Mon, 20 Apr 2026 04:23:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 20 Apr 2026 04:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776673400;
	 x=1776759800; bh=qVJn6UfaQssQM51SBdyCs6ttrq07wn7PrEyOeWjAp9k=; b=
	QWQjtoU8VwdayoomwTfBn04/4KV+IqEaLR0mDAG8/7w1N5OCG08U+w26nMCkk30E
	lZ33WPpVUGsgBZx4Ukee6FsBgB5PTEhCewnmwdFDZzWRHH/HeKPhZe0eB++6qUKc
	2nEa1MBeRsN5VXFwdYZr9/NiGDfnQacm2S81cAtuo8NsJTxPVavQkXkDRCAejXI1
	ZU3pBXx/kfzg0S0ZRF6YWuFt8WOP05H9LGcy2cF7p+axskUYTaRgLJfIMUtZvw7w
	ccjkeibO90WRdl9CDmC4W8TbDLIzC/dSGkOrA4X3NJaoN7VQkgvHDY5S1wy2Pe3t
	I3BjDNr33ObeRKT+208LtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776673400; x=
	1776759800; bh=qVJn6UfaQssQM51SBdyCs6ttrq07wn7PrEyOeWjAp9k=; b=O
	X2o0XyUHQgbctjwx2XCbKiAvB906TSIqCadqb0aLBz699iboCrG1TbUl15rarAak
	x+UQSYF5moGpQEhnyNS6SU/uLfju/a2yF0mF4fjbFsrkWxXLuIspCojciWjXVVtS
	c6FBmpZKoTm/jHvgF8S7Y0PxMRG8YGOQTj5v+qF9jAC34A6fTqlKuEwn50rBXOUU
	uXp2RhROGH/A0STSwJpxpfqiUwOBqd+sJ4U2zDzGS/NaEmKTwD62mAIohOGm7xJY
	M3f0WLRlsJuI/wb6tc0bVcr0++0eBjtyCkon6OfCLkhN1FRfhxrYMoPomXYiBVcx
	PCIA907m2pUUbVcaLcLAA==
X-ME-Sender: <xms:eOLlaawJGqPPdeG_scB1v3omgDuMVcBIffYaN20cLrObiUFlDOlY1A>
    <xme:eOLladRmhUyxgLr7_i3Wf2K91MZxkqvusgJkeNJEELJ2vu9tdi5sU9nYPHbRJup4q
    Mn_dvksXylAazTFqVwsG6xut0hOUc-_DiW8KwGKX_i3D9bNgkkDgw>
X-ME-Received: <xmr:eOLlaRVOiYC8iBGCkqVOqN9oneBcW1XprVdWzhOMe859Phpto1SMXR6wlou2sBF-6zbNEH1QhWPPRIR9X8qMTeQl1afTDoy_1HnEdZZqOPpp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:eOLlafYqGSFt_86GVuwf_LPtMXVn-Gb3Eulbq4IbLcoJ07doh-3AaQ>
    <xmx:eOLlaX2EWVAcZb1l_NNB6scl28Rb3Kwz3VvkbhKLimoc-KBx609kWg>
    <xmx:eOLlaRgF-HpyF-GG5vVULTkHDJBBPIhgAOgeHMfueinozmZQY3UvAQ>
    <xmx:eOLlabbOODpX50YKOwdTQGB6lldNMOGa7yhQRELnRTQ2u-gqc28iqw>
    <xmx:eOLlaY0AXkHWzlE62cu8rG0qM-gBVuvH8aMqKvr4msgyqjqKZCO6HLOT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:23:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0f62f177 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:23:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 10:22:41 +0200
Subject: [PATCH 11/18] setup: stop using `the_repository` in
 `setup_git_env()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-pks-setup-wo-the-repository-v1-11-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

Stop using `the_repository` in `setup_git_env()` and instead accept the
repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Furthermore, the function is never used outside of "setup.c". Drop the
declaration in "environment.h" and make it static.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 environment.h | 2 --
 setup.c       | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/environment.h b/environment.h
index 123a71cdc8..9eb97b3869 100644
--- a/environment.h
+++ b/environment.h
@@ -147,8 +147,6 @@ void repo_config_values_init(struct repo_config_values *cfg);
  * Please do not add new global config variables here.
  */
 # ifdef USE_THE_REPOSITORY_VARIABLE
-void setup_git_env(const char *git_dir);
-
 /*
  * Returns true iff we have a configured git repository (either via
  * setup_git_directory, or in the environment via $GIT_DIR).
diff --git a/setup.c b/setup.c
index fa9bb39cdf..24f230567c 100644
--- a/setup.c
+++ b/setup.c
@@ -1065,9 +1065,9 @@ static void setup_git_env_internal(struct repository *repo,
 		fetch_if_missing = 0;
 }
 
-void setup_git_env(const char *git_dir)
+static void setup_git_env(struct repository *repo, const char *git_dir)
 {
-	setup_git_env_internal(the_repository, git_dir, false);
+	setup_git_env_internal(repo, git_dir, false);
 }
 
 static void set_git_dir_1(struct repository *repo, const char *path, bool skip_initializing_odb)
@@ -1979,7 +1979,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
-			setup_git_env(gitdir);
+			setup_git_env(the_repository, gitdir);
 		}
 		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);

-- 
2.54.0.rc2.529.gd9106f7525.dirty

