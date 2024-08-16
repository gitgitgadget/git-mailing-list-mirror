Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814013B783
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805103; cv=none; b=cNp8xW5mNSlusVR7g7P0ZuhwAowwyh1Kkw0PdqETZ2RDylUaQr/8twygcM+u8UIfvusknn7tYHVORgsoSUOz0l4MznzbkUcpRNtINshFZsW5n32/rioVAwi6gXqtE1l968Nz8hnISVl4t5EKZd4oZZ9pkdql6iOJOWrexd3EUu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805103; c=relaxed/simple;
	bh=TSy4hW9tqsU10Gu3DsDfyJ5qj8UbJdsDpUvI9jQtP7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVlFig7k2On/FYaaOdDHEVVb7g7gyRAulYHyNG5D8eaYez32ToS/uRhCj+ixKvj5tvU1xEr9oYP+AmbPcLAJaVtIuFTulVVrFFd5Hu2oYbV9zSpCxy9RydkLQ/KmssILII2zJ6uwwNjtZciFcbXhwpVslH7T/IAtnUy3tOLX3h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CVt3FC3F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HkC5gFQT; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CVt3FC3F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkC5gFQT"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9B1CE138FF9B;
	Fri, 16 Aug 2024 06:45:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 16 Aug 2024 06:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723805100; x=1723891500; bh=bQynbxy3ZS
	cPk+bnalMGOTQzDIBCdG9RCnZWRnMufJg=; b=CVt3FC3FO4t7uMtVrCRGoFw3pn
	GOyFPMqxw8Hh3K1CSDx61j5uxfbWFjiX6JuGzQWH/r3+ZkTGzhnbBhE/ibVx7JRb
	Xt3UQUntULyxNutz/DiSCmpWGgWhSoLS4F7ngBZWT5pYcbJxpUXbebOiy/H/6KQ+
	tjCj6MVX4GSwdSRS3t2A0n+/m7DPJJzybkZu/ypuex6zCopyOMLPPl7Ozru8gsPv
	WK+JN+IdZhcZhr6JLjqcrUknXthVQQ5QfG3hHyEoUbkO3vj7xCnypqq9EY/XSjkS
	PNiVqYdOKocVMz44fwrkT3ngUXt5EjxK3uE4h95bFeorxSrwiNFaRfFFhbcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723805100; x=1723891500; bh=bQynbxy3ZScPk+bnalMGOTQzDIBC
	dG9RCnZWRnMufJg=; b=HkC5gFQTdXBeiokoBRSP1lOWme46X0Gm2WQUqxC33tSe
	7j9Vu9n+mu4ZwcSOvRlbw4HxH5AbFxMwGWxw7GpyLa1xT/7F0weWY1Fn7YUpqWrR
	DW7xKsdvcwAyjGKA5hZHzWbqaJaRNpBqWQaJ3K0/qGSzTOy9QV95rIexrcUWS1jd
	t55uW52m9MlzTcgLauKDqOEjFNhpdM89i73wBAoh4tT1Dk2XyavDSe3eIro3sxjR
	bFqtO8HhJFPGYync8SdQyog/nhTvMThCokOvF5UZHaY9bbvRn+bdp3jVa3DzHygB
	Sxcj3d23s9Ep3MmUl8hc8+aVK1a+gsPoYEsVyDbN7g==
X-ME-Sender: <xms:rC2_ZnGlV3he57xJLVkxvye-DGI7BG-PTjyBP8hk8zzmiivWj8OlVA>
    <xme:rC2_ZkUTF8bwFbpsndv0BZTj6GTYlQqc4yFU2iqBAhpRVnDMKTUpD4zCYPptxIGk-
    TrEjPjLLJUU9fyU9g>
X-ME-Received: <xmr:rC2_ZpKKH6Tn5n2oz1u58g5UVSzB0nRamaJGb3j69AJMn-mAShlr2pPgbGezq5NFoQzuMxeiyN5q5fvV5NsszmJzPhtc5YiAujVTACIXYuiky_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rC2_ZlGYaNc6IsZrJNp-XZbbsdzSzJUlNx9zziLQr445RmBtaG1kTw>
    <xmx:rC2_ZtVkUZXEaggoKK8rqIPnW7EEqN9zYv1j0NW3xU8_1Fot_wpmmQ>
    <xmx:rC2_ZgPpgd-9VUN7Vx3u_4JAYhTIsmcifPKKtkRqJB8JolR3d4AV0w>
    <xmx:rC2_Zs15Cr3MeuSKVji7bRAXkd3sekWi2hgMwZfRq9itzQNjPFUVqg>
    <xmx:rC2_ZvJILUC52eQKaSzPappVVM2x61wROdJ3_iCI8jtsuiLIBSmHdhTH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 06:44:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4b01eb3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 10:44:36 +0000 (UTC)
Date: Fri, 16 Aug 2024 12:44:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/7] config: fix constness of out parameter for
 `git_config_get_expiry()`
Message-ID: <040453f27f0b2755bb359fe07a703ce66e071ab6.1723804990.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723804990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723804990.git.ps@pks.im>

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

