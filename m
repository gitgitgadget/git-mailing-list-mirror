Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5A61514FB
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487136; cv=none; b=GQ67OEiFn2eC6yU0iBwxNYcI/S9t5pQqZ/LnJbBwvj0QswhmsFB7NFabIIcpD505rVEzA2HZr9yYfDyZI6s7CD8pWyPCahvOEujqd67mkFf90Ovd5dZ/X6LGo7cz/8gr7JYfvSp9IpzN/cYf9z9F/muN1ZYVx42A3C9S2naZJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487136; c=relaxed/simple;
	bh=LLbz5IQ2Hpng9oCBhfL3oytcF3UIzuFiu7/vsHpy8yo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fyj3nJwuxCyJ2E0YrXH1bowUvvvAygVD2i7OqX+o1xKx2eQyzlcfXlpDp/ROyJuRHVQ3jI74kCoCckOS5wvV+SiLJjGVKE2bpj2iKFTqv4CIaYm34OZz9P0hV2ew7qW9df0GEw7jgJv9AlN3aRSgQRjy+7EXfEdD9YDaVNXviPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CtNqBX/h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X/JIZWX/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CtNqBX/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/JIZWX/"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id D884113802DB
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 16 Sep 2024 07:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487133; x=1726573533; bh=4UlVmbcIU6
	hlCZV36ZST1c4eY/CY3uuz7TalS6uIvLM=; b=CtNqBX/hoWmHRnBy4qzXu60310
	AYazb/Us4YSI936HUTQ3+IUZBf4xIKUbZjTLSAUcKhmOPZ2q0zt6f9gXj3WYdRGz
	jHkRRM3GwZPAXMg+gTrcNepLS6TBiuS2zm9oUJnQo7SAe1LHmqAL5p/tvF2Wxdt7
	D/MBkkW/JPsoQyamj7v9jzkiBo8ViNxyp5z0Co6k9GUSZ63HEy1akKp9Rt9h/PpB
	vrw9zAfWQkO9b5SgDedZsJfVXf9iVirLNcb2ko9ph685g76ML0qkGhEMIZfrgVil
	Mh16RldorHrsuqNKf02MUZ8EdMwNV0px10pV7aPbKGmJhXA3w+/MxqaI+jBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487133; x=1726573533; bh=4UlVmbcIU6hlCZV36ZST1c4eY/CY
	3uuz7TalS6uIvLM=; b=X/JIZWX/CzmRakJtmZ8emScuz243oEDQDZeD81MvvvnK
	9CY3nzxudvLnXSv85azjYBdpgqAcQaG5MEy87Fh8jvGRo6PsOd1iDBoSY3xstDOu
	fWN9ui9tE0EbKqXVq44mOf1JQUxFXVxm5tYTBxbRtwVaayG0M+vYVqeGiJ3EGkpR
	QvSxc6QfiLXAF5SlFrgO7kQPeWmN2tSGEtgWNDmdTJut7J/llj1cl5SIpQIKr/zO
	zSB0xxlksq+7UI/05lqwtvGXKnROQqOo+3YchnXDCX1VE9nWVa3Z/n+4EUKeL31k
	ZZB/Tm0pCfj9JqLlaOc+LYQPSLud9ZuYD0AU9yVqLw==
X-ME-Sender: <xms:XRroZv1z9a5ptugp83gqa1JhVviziS7wC8czdocazaYUAFNurTivsQ>
    <xme:XRroZuHM6Z8r2vVjH963bLgVW3VRZ-waZyDVBJwPqlvFDCbFpREo6EAGbqZLRNQh2
    -5NADMHnddnEMOjaA>
X-ME-Received: <xmr:XRroZv65ahkOQZNCgxbF6cVv3AQGhw0M4dtjTxmFL9cWjUM3t3xH-I1-zzSwX7FTE7BviUpmwuZ-y6xYB3PdHPQnwdfrcPkVkQc9wdtUs8f7kLfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XRroZk3RlrSQPFjHd-wsO0SKlalK9xwJi9wkpua94_L6fQinARzozQ>
    <xmx:XRroZiEQglnc597BK8xOz6n5Rq44WJb2WQtExZL3wEoTxJmViRMv9w>
    <xmx:XRroZl8gMfRy-o2yscRQIEQuLfZ3pGsiNDUdr2R6bg2fjUsx52fZBA>
    <xmx:XRroZvmzMchQu-q1R3qL04wve3NmcZvU-RC68fd_yO1eFMlr117CvA>
    <xmx:XRroZkPZ5yGr2nTmKuqLI4KxnG3g2wpztoovWoA6C2B9W6w_Z3Ree6N0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d93791c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:16 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:45:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/23] submodule: fix leaking update strategy
Message-ID: <7cdd2691b77d328447855f898540f7efb2a415c3.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

We're not freeing the submodule update strategy command. Provide a
helper function that does this for us and call it in
`update_data_release()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c | 1 +
 submodule-config.c          | 2 +-
 submodule.c                 | 5 +++++
 submodule.h                 | 6 ++++--
 t/t7406-submodule-update.sh | 1 +
 5 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bf8f9a40128..ed05dc51347 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2021,6 +2021,7 @@ struct update_data {
 static void update_data_release(struct update_data *ud)
 {
 	free(ud->displaypath);
+	submodule_update_strategy_release(&ud->update_strategy);
 	module_list_release(&ud->list);
 }
 
diff --git a/submodule-config.c b/submodule-config.c
index c8f2bb2bdd3..471637a725a 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -95,7 +95,7 @@ static void free_one_config(struct submodule_entry *entry)
 	free((void *) entry->config->branch);
 	free((void *) entry->config->url);
 	free((void *) entry->config->ignore);
-	free((void *) entry->config->update_strategy.command);
+	submodule_update_strategy_release(&entry->config->update_strategy);
 	free(entry->config);
 }
 
diff --git a/submodule.c b/submodule.c
index 97d0d47b561..0e67984d770 100644
--- a/submodule.c
+++ b/submodule.c
@@ -424,6 +424,11 @@ int parse_submodule_update_strategy(const char *value,
 	return 0;
 }
 
+void submodule_update_strategy_release(struct submodule_update_strategy *strategy)
+{
+	free((char *) strategy->command);
+}
+
 const char *submodule_update_type_to_string(enum submodule_update_type type)
 {
 	switch (type) {
diff --git a/submodule.h b/submodule.h
index b50d29eba4f..4deb1b5f84e 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,6 +41,10 @@ struct submodule_update_strategy {
 	.type = SM_UPDATE_UNSPECIFIED, \
 }
 
+int parse_submodule_update_strategy(const char *value,
+				    struct submodule_update_strategy *dst);
+void submodule_update_strategy_release(struct submodule_update_strategy *strategy);
+
 int is_gitmodules_unmerged(struct index_state *istate);
 int is_writing_gitmodules_ok(void);
 int is_staging_gitmodules_ok(struct index_state *istate);
@@ -70,8 +74,6 @@ void die_in_unpopulated_submodule(struct index_state *istate,
 void die_path_inside_submodule(struct index_state *istate,
 			       const struct pathspec *ps);
 enum submodule_update_type parse_submodule_update_type(const char *value);
-int parse_submodule_update_strategy(const char *value,
-				    struct submodule_update_strategy *dst);
 const char *submodule_update_type_to_string(enum submodule_update_type type);
 void handle_ignore_submodules_arg(struct diff_options *, const char *);
 void show_submodule_diff_summary(struct diff_options *o, const char *path,
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 297c6c3b5cc..0f0c86f9cb2 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -12,6 +12,7 @@ submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
-- 
2.46.0.551.gc5ee8f2d1c.dirty

