Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C07DA80
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720924; cv=none; b=dCHVK3r0uSFh4kWiKRvllcWxGumaPNaV85tY1FTh1VbCQ+ZF5LuiOhJIWdJ80p+3VYRsyLnZXmpyw2IYSyd1UYn1/y9Psv+SL6UUryNVLrFw8WP7iAtTofwBkeBPhDKO/2STdZ8ISsVZj6RA++L06sZ9LvZiwjEfABYQEZEMP3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720924; c=relaxed/simple;
	bh=TSy4hW9tqsU10Gu3DsDfyJ5qj8UbJdsDpUvI9jQtP7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1P7+pcDDtacmzp5jYihSKGldJqVtaFt2eNAfTf2P9XbCFwie4zHqJ+W52DNh8PXgFFxwDXsx0gqPaceOT38OYHY/jnYtj06AoiGaDrC4UywFIOPdtSE7+EpSAvjXQZysOLWYlfxjEj2YIQL8k47CYpptR5EbjceeqgoKAyPyX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JOlg5mv3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kwxZkl/j; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JOlg5mv3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kwxZkl/j"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 44DAD114EA05;
	Thu, 15 Aug 2024 05:12:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Aug 2024 05:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723713151; x=1723799551; bh=bQynbxy3ZS
	cPk+bnalMGOTQzDIBCdG9RCnZWRnMufJg=; b=JOlg5mv3auZ9E0x58mNBVyVMqh
	q5zxm1K8thKza8b3FQ6aeUDXQstPvkyhPUNP9++kSoYiPjSjBo6qsfWEeSAj4ZaA
	mlD8iYT9+Ugt2iGeGP7V0c6dGVkfSl0SqFfUvwdmnHLKqGSda3LN66a0fifgOKt7
	OIbhZaBfy6F3OocS8wlT5cX2cygW3T562lTfyXfhglO93SqWumWDez0PQDAdhbrf
	E6vEf57Ad/kz/6QRdYjEIByGxxnll+UDtq7580Hhi+cUGixfcS8wxbt+0GVlM8ZN
	qVxIfYvGSxgZec3NQyEZRPdyKSGkOgUoQHSMtdiQ5Jxt6evYvs6ixPVnhKkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723713151; x=1723799551; bh=bQynbxy3ZScPk+bnalMGOTQzDIBC
	dG9RCnZWRnMufJg=; b=kwxZkl/jgbkkXC2Mr7S1ExlIn5zBkc9HhbGkdTT3WTgv
	NsCIEp6bbb33zkxbyfF4hVJFFt2Y8Dzn94z+SzC7zFKrEqMSEeii23dDHhWW2f82
	oy2+UIS4HnR39/oF1bIlyNqv8/hwVvT4Nm781A1o7wMD6w2RP5GgZP8nTn/DKtsr
	QEt+mV1rg7qCCbIeASRuBv5wr/lN+eLCaLvSgmSRjC+nzHfF/7PrArvAuRXo8wqk
	88T0yFdcljS8S9gr04+eIKGroaEt8lBWDrpvsok49q2Kkg0/9dDfN7GCldukmiO+
	Zw/C5QYrbeD4+6xEMHD4pZ8kXwa9bvrS1Tukz6VLCg==
X-ME-Sender: <xms:f8a9ZkSrxJ5c7FEP-8Pb5xW-w92tZBeHTIWX0y06Gc0wu5TUJIEQKQ>
    <xme:f8a9ZhwgQm5M_0KokLtZNTOup-CKcUfGefdFi-YCUzUw11VHZgVyFsMRG13flFx7N
    AQIdEqrXoOUdWCb_Q>
X-ME-Received: <xmr:f8a9Zh0sMTRmxAE0ylGcMlOxFDGperjxjjIz298T2rX13p9t4obrD_wp6kTQeoiR9TByZ-ZcMJC9wYf08TERhHoCyODYjfaAsJKKUporoFpODQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtph
    htthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:f8a9ZoBCMXwOrez6dTZg0bUmkao55XvSjeOaBZgWbEYalo0G2VpI4Q>
    <xmx:f8a9ZtgU_KwfCpGQmQ5CGmtBNBYCgCM3YqKgPCL45RkiGWHc308-4Q>
    <xmx:f8a9ZkqMFSre1YAtOWBQ7v_aDzNTShEoYgdPxafzGUqPjvbCu_Wx4w>
    <xmx:f8a9ZgjJDDrauN4FQ9vl1bfmSV_FoG1Kmh2sG0MV3XXgXrZYDw3x4A>
    <xmx:f8a9Ztdwm8fqgmVHNS9RD9bd1ztr4tGKYe1MybWHx9kppD92NQU8g8uc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:12:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d4000361 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:12:09 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:12:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>
Subject: [PATCH v2 1/7] config: fix constness of out parameter for
 `git_config_get_expiry()`
Message-ID: <040453f27f0b2755bb359fe07a703ce66e071ab6.1723712608.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723712608.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723712608.git.ps@pks.im>

The type of the out parameter of `git_config_get_expiry()` is a pointer
to a constant string, which creates the impression that ownership of the
returned data wasn't transferred to the caller. This isn't true though
and thus quite misleading.

Adapt the parameter to be of type `char **` and adjust callers
accordingly. While at it, refactor `get_shared_index_expire_date()` to
drop the static `shared_index_expire` variable. It is only used in that
function, and furthermore we would only hit the code where we parse the
expiry date a single time because we already use a static `prepared`
variable to track whether we did parse it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c |  6 +++---
 config.c     |  4 ++--
 config.h     |  2 +-
 read-cache.c | 12 +++++++++---
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 72bac2554f..e7406bf667 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -167,9 +167,9 @@ static void gc_config(void)
 	git_config_get_bool("gc.autodetach", &detach_auto);
 	git_config_get_bool("gc.cruftpacks", &cruft_packs);
 	git_config_get_ulong("gc.maxcruftsize", &max_cruft_size);
-	git_config_get_expiry("gc.pruneexpire", &prune_expire);
-	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
-	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
+	git_config_get_expiry("gc.pruneexpire", (char **) &prune_expire);
+	git_config_get_expiry("gc.worktreepruneexpire", (char **) &prune_worktrees_expire);
+	git_config_get_expiry("gc.logexpiry", (char **) &gc_log_expire);
 
 	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
 	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
diff --git a/config.c b/config.c
index 6421894614..dfa4df1417 100644
--- a/config.c
+++ b/config.c
@@ -2766,9 +2766,9 @@ int git_config_get_pathname(const char *key, char **dest)
 	return repo_config_get_pathname(the_repository, key, dest);
 }
 
-int git_config_get_expiry(const char *key, const char **output)
+int git_config_get_expiry(const char *key, char **output)
 {
-	int ret = git_config_get_string(key, (char **)output);
+	int ret = git_config_get_string(key, output);
 	if (ret)
 		return ret;
 	if (strcmp(*output, "now")) {
diff --git a/config.h b/config.h
index 54b47dec9e..4801391c32 100644
--- a/config.h
+++ b/config.h
@@ -701,7 +701,7 @@ int git_config_get_split_index(void);
 int git_config_get_max_percent_split_change(void);
 
 /* This dies if the configured or default date is in the future */
-int git_config_get_expiry(const char *key, const char **output);
+int git_config_get_expiry(const char *key, char **output);
 
 /* parse either "this many days" integer, or "5.days.ago" approxidate */
 int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestamp_t now);
diff --git a/read-cache.c b/read-cache.c
index 48bf24f87c..7f393ee687 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3176,18 +3176,24 @@ static int write_split_index(struct index_state *istate,
 	return ret;
 }
 
-static const char *shared_index_expire = "2.weeks.ago";
-
 static unsigned long get_shared_index_expire_date(void)
 {
 	static unsigned long shared_index_expire_date;
 	static int shared_index_expire_date_prepared;
 
 	if (!shared_index_expire_date_prepared) {
+		const char *shared_index_expire = "2.weeks.ago";
+		char *value = NULL;
+
 		git_config_get_expiry("splitindex.sharedindexexpire",
-				      &shared_index_expire);
+				      &value);
+		if (value)
+			shared_index_expire = value;
+
 		shared_index_expire_date = approxidate(shared_index_expire);
 		shared_index_expire_date_prepared = 1;
+
+		free(value);
 	}
 
 	return shared_index_expire_date;
-- 
2.46.0.46.g406f326d27.dirty

