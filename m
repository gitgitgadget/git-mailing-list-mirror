Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74DD2F5082
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279766; cv=none; b=NmgFgkL9kh+t10IwgnFkcWrWw/nF55mazq1XaorLt2Y3DmJC40Rz1e2cFlurdQDxh80K0xjey+2IddSw+mjqqO2OYp7EtXhM23UrU0EpoCZH6CATFaAb2SYvIGFDwrnvp7dOQcQyDCThW/yM9eInNdhDnE6jvE1x48rQvhL5JcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279766; c=relaxed/simple;
	bh=PBKQ7KKudZF0DbotrJNb3sBiRueJt0iRxZ/ftestew0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PxBy+0UWKFWswSWyBjB5sVacqpO2ylBI/Zc0pBB2U7E1e3Ow/HeJWhwe4ljnVhEiBSsHEdBOUSALvw4W14+wJqPfz6S2myt1GWDjq3iuE9TLWzhZ4YtTh2+bvK4C5Ak7Nyc71m1pcZz3kNvad6mHKDWOK1NQloY8qRyCNXPto/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SVpXbsNR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ns/4P3Od; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SVpXbsNR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ns/4P3Od"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 08E48140208F;
	Wed, 23 Jul 2025 10:09:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 23 Jul 2025 10:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279764;
	 x=1753366164; bh=Kqyxb1NXKmuO8v9Jbe9ft4rUuhfJl289rHLKy0ZF1Ik=; b=
	SVpXbsNRX0dzzi1vjRDo6VJP2tkX47ivsGxj9azfKO9glSnPmYpnp1IW8SAbl0iM
	UVeWAoawarAxs/mv1XD+aPqSW6vztJQy2+oXcwxl1fd3ZR4qexAN11ZuKNBG5n5P
	IokkhAMA+gg0HHxRTbtX8autV3AR/9ESgB5cNmJaihYWK9qZ9sUPFU6s+mTH5WP7
	5K9BVFEYmrXzMkhPME+eJHrX0/IlVt7X9UOiikE/jx8jRj5K5vBoSfloTZwRVhRI
	NccRvakMuQK9l61EObFjChl9KBJldjRpi6mX4YVLuNVkt4dfeSETUiUw2KlLj8+D
	TUWZ440I9zLhg4y0E1v5Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279764; x=
	1753366164; bh=Kqyxb1NXKmuO8v9Jbe9ft4rUuhfJl289rHLKy0ZF1Ik=; b=N
	s/4P3Odn8ZwzJx/8GANtsxRbs5d7o9fVhhs+i3Ob01hhmBZuRRUliK/hAGHltfy3
	90Y04kmqI+urvsEXT+t4ZxZOs7zyPIzyJmr7vSuTkk0EVIz8D95zm2n8bkCnHAki
	jJ4dFbBOcEV54O/HWRpA6ySe82VDxy+s5kYo41lWaobukAaMptuRjV32JEYqvYF9
	i/FAi/2PQ4FBkDVMR42aGkpf+6h+jizY/nBgS7dB2vznJxCIpeU/6BAZKT69yLpQ
	FrOuLc22v64fwuOCoJ8+5aR/tGTkCO8PQte3R/nB9AD+bgKftEjriGW5oDFykekH
	wahobAbbA54YwChPy4GzA==
X-ME-Sender: <xms:E-2AaHABAhMMestelDXZLtnRYVPwPLO8Dd25JH6f7ylUQgpXXT6U6g>
    <xme:E-2AaNsyrowCz7QfveudHVZ3iKJ2JAHnb4j6K9TUQS09w8_HRbjqHdE4dnlVuwudX
    ndmc0VTygEiFq7fyw>
X-ME-Received: <xmr:E-2AaEaymluyFfN03rHDEynDeb2lO0Gu0QjspMFzJKITeyHaCbsyc68YEc6b4nISXyU1Z3JPCfGrPlhgXjvLMP2Kbq3peeKZopuw66a3K91t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:E-2AaIVJV_Mf6KF4y6lZ1BJmo0uxTsywD_Db7rukc0BAd-lhAlp9LA>
    <xmx:E-2AaA63a8Jc9tk9IJCR0JT5It935urn8DefwUWW0Xkk8T4Y0ZueVQ>
    <xmx:E-2AaLg30E4-e_l-IHCsmaWOxts2eBfA7J-4d91fYXxGWTwIwHcOkw>
    <xmx:E-2AaPcAKUC5uLQFs351GrW1W8SYWcLcaAPQwbIKg8EhcCCjfsGdTw>
    <xmx:E-2AaEQlQYIlXgxLW-1aItT3z-rgi1Q5GwAL6267PqaDVjHFYLf6x5i1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:09:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 02147255 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:09:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:38 +0200
Subject: [PATCH v2 17/21] config: drop `git_config_get_multivar_gently()`
 wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-17-1502d60d3867@pks.im>
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

Follow through with that intent and remove
`git_config_get_multivar_gently()`. All callsites are adjusted so that
they use `repo_config_get_multivar_gently(the_repository, ...)` instead.
While some callsites might already have a repository available, this
mechanical conversion is the exact same as the current situation and
thus cannot cause any regression. Those sites should eventually be
cleaned up in a later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c         | 2 +-
 builtin/clone.c  | 8 ++++----
 builtin/remote.c | 4 ++--
 config.h         | 7 -------
 scalar.c         | 6 +++---
 5 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/branch.c b/branch.c
index 3dc237adf6c..26be3583471 100644
--- a/branch.c
+++ b/branch.c
@@ -130,7 +130,7 @@ static int install_branch_config_multiple_remotes(int flag, const char *local,
 	if (repo_config_set_gently(the_repository, key.buf, NULL) < 0)
 		goto out_err;
 	for_each_string_list_item(item, remotes)
-		if (git_config_set_multivar_gently(key.buf, item->string, CONFIG_REGEX_NONE, 0) < 0)
+		if (repo_config_set_multivar_gently(the_repository, key.buf, item->string, CONFIG_REGEX_NONE, 0) < 0)
 			goto out_err;
 
 	if (rebasing) {
diff --git a/builtin/clone.c b/builtin/clone.c
index f025a8f19e0..183297787cb 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -762,16 +762,16 @@ static int write_one_config(const char *key, const char *value,
 {
 	/*
 	 * give git_clone_config a chance to write config values back to the
-	 * environment, since git_config_set_multivar_gently only deals with
+	 * environment, since repo_config_set_multivar_gently only deals with
 	 * config-file writes
 	 */
 	int apply_failed = git_clone_config(key, value, ctx, data);
 	if (apply_failed)
 		return apply_failed;
 
-	return git_config_set_multivar_gently(key,
-					      value ? value : "true",
-					      CONFIG_REGEX_NONE, 0);
+	return repo_config_set_multivar_gently(the_repository, key,
+					       value ? value : "true",
+					       CONFIG_REGEX_NONE, 0);
 }
 
 static void write_config(struct string_list *config)
diff --git a/builtin/remote.c b/builtin/remote.c
index 827639e0398..dd340a33259 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1633,8 +1633,8 @@ static int update(int argc, const char **argv, const char *prefix,
 
 static int remove_all_fetch_refspecs(const char *key)
 {
-	return git_config_set_multivar_gently(key, NULL, NULL,
-					      CONFIG_FLAGS_MULTI_REPLACE);
+	return repo_config_set_multivar_gently(the_repository, key, NULL, NULL,
+					       CONFIG_FLAGS_MULTI_REPLACE);
 }
 
 static void add_branches(struct remote *remote, const char **branches,
diff --git a/config.h b/config.h
index e69592ada15..a90b814292c 100644
--- a/config.h
+++ b/config.h
@@ -745,13 +745,6 @@ static inline void git_config_set_multivar_in_file(
 					 key, value, value_pattern, flags);
 }
 
-static inline int git_config_set_multivar_gently(const char *key, const char *value,
-				   const char *value_pattern, unsigned flags)
-{
-	return repo_config_set_multivar_gently(the_repository, key, value,
-					       value_pattern, flags);
-}
-
 static inline void git_config_set_multivar(const char *key, const char *value,
 			     const char *value_pattern, unsigned flags)
 {
diff --git a/scalar.c b/scalar.c
index c09c5ca194e..4a373c133d8 100644
--- a/scalar.c
+++ b/scalar.c
@@ -196,9 +196,9 @@ static int set_recommended_config(int reconfigure)
 	if (repo_config_get_string(the_repository, "log.excludeDecoration", &value)) {
 		trace2_data_string("scalar", the_repository,
 				   "log.excludeDecoration", "created");
-		if (git_config_set_multivar_gently("log.excludeDecoration",
-						   "refs/prefetch/*",
-						   CONFIG_REGEX_NONE, 0))
+		if (repo_config_set_multivar_gently(the_repository, "log.excludeDecoration",
+						    "refs/prefetch/*",
+						    CONFIG_REGEX_NONE, 0))
 			return error(_("could not configure "
 				       "log.excludeDecoration"));
 	} else {

-- 
2.50.1.552.g942d659e1b.dirty

