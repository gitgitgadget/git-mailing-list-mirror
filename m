Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5F288514
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667170; cv=none; b=ZafbS9BLIxsvgeJUbve6Bhi+6oB9eN1+5YHgaPsogr3T8VqFVSBCzjhwYbhqFeqphdk9t7rci+FOEO9FZ9j4pJ8B47xMxI28EOfpq/Tdlz5VRWiwND2m3HJwShi00ZEvogU34tC49okD+q4T1f6gT6fXvWRZYadPLKa/aRiXtno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667170; c=relaxed/simple;
	bh=PuljyolBPeLgFJ8Eszp9a83ZNpI8I2qjoRoNkfUVQkY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GabRJmSMHgkypmpCJQbUXQMx14ildpd+reHEe0d/Ge9212u+rYVOde+yypuc2KDqJa4ygZt3CaPvtWvoIRR5toLmuW8EpJVkaOTH2tsa7jhCrfz6H4CJMJ+sttbMqg6yngqwwTCn7X1w4aIlhHVfQbnT8q4arg6Ahm0aE+5g6Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YqTlLGC1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pnx91Nwm; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YqTlLGC1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pnx91Nwm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 41A21EC0378;
	Thu, 20 Nov 2025 14:32:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 20 Nov 2025 14:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1763667167; x=1763753567; bh=pFkiHxi0y9rJGZf3/QNrzYtZdaJ4VFCm
	mEPYSVburCI=; b=YqTlLGC1/IJp7mlAIYY1EAVuSJ6l7rFWSgJUh5Kg+QYRxrhL
	zufGhWQNB56/cOQQqIjhpJTvmwwI5wX3LYbL6+NNCZaznkXOTRI9azbE4w/K9hqb
	t0HKc1fMuISK74P8ZNaF3kUYF0vWMiKfStvQdI2Y8nL1v2kdOaO6YOVv/KENejo+
	UolpBH0xN/ZHKId07NiGBpphz6Peio355ZMHhALVf38Ni0nYJNkGoCvtykqzrMoO
	U0+D3z8k+8FAlTeJlCsYd2/2iYCbx9MMTr1OQDaqHFHKESkOgir7h+vD/YGDEnQ3
	CtJmjlZ1JRtdb7AhGiLWo1LVZeA7ItDjN7gHVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763667167; x=
	1763753567; bh=pFkiHxi0y9rJGZf3/QNrzYtZdaJ4VFCmmEPYSVburCI=; b=p
	nx91NwmStQL8krN6SI5A//O8a0LvV46GsYKKa5bo3Gz5aqPNCGGZKJLzcfLw9kaC
	eODWKpynIdYlLvjXikjwjTfMpJ83AXakaxhSDT0xnsxj+vcJkkupaWLkXqQ7JZN4
	jFo7Zh7qyWe7745T2odnZaV5nuKEJcCifYwDMM1UabeDYWwJMwZ5E+/PEqW3+uEG
	+T7ZmFUCMB3/ADk9FIxGEV5sqXqYYFeCxjUzsJlSLapUZlF6St7d6nzoPoMfIlXx
	SA/UIvrUHpDdFI2AA1sdhN0lUARDQT1l7g5TiwHk84Cdcmzv+HLm7PkHed1eT7SI
	PqetcERaAD4gKKKlk3RQA==
X-ME-Sender: <xms:32wfaSmBzUQKpjcEesw9QqBff4GLVah5wNZKsmMDUgaarkQRbDtLtg>
    <xme:32wfaf1z6mUviVhgu__UfcTzJcoFSPz2C9R0C8LiLYt1eflw0QEIabeuQdSz23BwK
    LTe0B46GVYrO_sRlrkbVD5nnPKGchPIsgpjwlcNuZ6atrXm8Muhyz4>
X-ME-Received: <xmr:32wfaeSmjZAgWFSDTQJceGojoje4ISoHe42OX_6NiOM_2W6DSJc6GkBriYzI8Hs4u9OgOs6r5YrVBqC8_A7X-XpjwYtu1ZDf1wQZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:32wfaRswS4oq_sJF7lp5JzMMa4sjO0MNlHnLRxPJjHg60sjvLpBtzA>
    <xmx:32wfaTY75hsYVTasBO-9egEDE6DMeyzX7LzY0B4nFx2J8PHyWhbUKw>
    <xmx:32wfaWulmcGX8Hd5N8O13PYJyT5LLNWAWVDwcJGpiHDPAxL-fTU4bg>
    <xmx:32wfaVFDQp0B3as2rlgAbMSIukewMyaYCwxEUc9Fpy90g_iViOt_Fg>
    <xmx:32wfad9X70yjlxpgxclRZrUUMGFNLL1i9RZv3Ehok1aWYIILJU1lc9me>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 14:32:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] config: mark otherise unused function as file-scope static
Date: Thu, 20 Nov 2025 11:32:45 -0800
Message-ID: <xmqqtsyo7b4y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

git_configset_get_pathname() is only used once inside config.c; we do
not have to expose it as a public function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Not related to anything in particular, but something I noticed
   while I was in the vicinity.

 config.c | 2 +-
 config.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/config.c b/config.c
index d55882c649..1738c0cb0d 100644
--- a/config.c
+++ b/config.c
@@ -1954,7 +1954,7 @@ int git_configset_get_maybe_bool(struct config_set *set, const char *key, int *d
 		return 1;
 }
 
-int git_configset_get_pathname(struct config_set *set, const char *key, char **dest)
+static int git_configset_get_pathname(struct config_set *set, const char *key, char **dest)
 {
 	const char *value;
 	if (!git_configset_get_value(set, key, &value, NULL))
diff --git a/config.h b/config.h
index 19c87fc0bc..ba426a960a 100644
--- a/config.h
+++ b/config.h
@@ -564,7 +564,6 @@ int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned lon
 int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
 int git_configset_get_bool_or_int(struct config_set *cs, const char *key, int *is_bool, int *dest);
 int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest);
-int git_configset_get_pathname(struct config_set *cs, const char *key, char **dest);
 
 /**
  * Run only the discover part of the repo_config_get_*() functions
-- 
2.52.0-101-g4c43c53c49

