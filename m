Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A2017C222
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533467; cv=none; b=TeaW5o91eHbs1TzmEefgNrNh2Nqswt+GJOGGGTJa6AqTsiUi8ihsikNIKVu+IRAYet/oHuLYEABR1NF8ARwgequwbAp/lD2R30UivHyS8N9T9U2UfnPKaGiLcOgfhdjb1bkZofamvnjCxR82B292eTa8Up9wv5I3rfBuSghLiqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533467; c=relaxed/simple;
	bh=TSy4hW9tqsU10Gu3DsDfyJ5qj8UbJdsDpUvI9jQtP7Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqIA1wvy2+FCh14HIP/B7AHu8vfFk2qIuUutudopuaTR4ffjEMhIRU6XDhMcTn89+Fc4aLiI8FG9HodCIF/0qW2YenJwZmH6FHwdUzHPqtauJYeqps+b9Uf+XKwW0P0S8y3MrcIhui5fEvhe59qK5JJrZsSpT2mNrbJK4gbO2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pQK6E1xf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=olwPmzqT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pQK6E1xf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="olwPmzqT"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8D752138FCFE
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 03:17:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 03:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723533463; x=1723619863; bh=bQynbxy3ZS
	cPk+bnalMGOTQzDIBCdG9RCnZWRnMufJg=; b=pQK6E1xfmEUhlo+r4sm8XtiXUB
	Mp2oSKE9BC48EUbXEDdGg3SoGryH1A3SUjEjbYqQ6qL5LBtbiwm3utey7SDI07OJ
	CK3qsoDyc3Cg+B/Dcd0ydSPFxZvqpHx010XdfcpcPi6Smk9mnSGxWVAd9+pYfNe5
	WeLfuQVdy6NQ11gesgw7UrYSKcCcxlcm6SZ9U1IrwPVH5sgmYCXub4Hsry51XxJx
	xZvmXUN6zf6ckNcpO4l8t5N/T5tjr9esrjWnHe6rU/eHsC3ZgLrhqddV2s2HYkGb
	6PDF7QeZtEd7oUo8uMiXX8t0ppS4cYz29zZbrm1BgMD++fXW+bQBRplq19qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723533463; x=1723619863; bh=bQynbxy3ZScPk+bnalMGOTQzDIBC
	dG9RCnZWRnMufJg=; b=olwPmzqTWdBesnKuS+hvcjTLAaJ4x8EBGmRcoQjS/nZ6
	FaMnoqr1BlP/euE5A1bqM6ALk/CWaCiLD+k5wwb0ttrOiknLKwzdfJbJ+WchCN3g
	dSpROZvXj6TjfNksDTloHLxg1BGYXIzUMbbEKZzZ7FPCwJ0mnMAX6p+afFwVpfdv
	aM0HxFQ2qjVsD52M+1UFHC/SAv1j7sLOtU5jjYW8oPd4i83pqaxvn7tSto4ieRAG
	qnVWXqnmfuSjatS9Mglzo459N8+AxcSocrRDC/VfgoYzciNw9skZHQyS8Pd44geC
	aL9ois/kzOSVLtMg0/MX9Z44ruOWqsjmXlKMEAit4Q==
X-ME-Sender: <xms:lwi7Zte5ESDv2l53TuCluetrqg1ChEsy-Y7s9X2MCb1MKcvc9QL5iA>
    <xme:lwi7ZrNmraAhLV5dG5LQqmmO9AaMDI1o8D2CordAFfEYYPTZe1OOthEm25a0lmh6E
    8Brda7r1A9x1qOIBA>
X-ME-Received: <xmr:lwi7ZmjkfRKgatmzmNBzugo1_JjmfbfuIrNb4QAiew8XZbVAcyDpoAHP_yuP7i1Ch-cPQxqK6oimBFvNha7mahbPOBc_tmMCUgtjprWuaNxwdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lwi7Zm8ck__ecRMCjtuxReXoFkApu0_-VQCzFZWhbtxXvyS9AnhDZQ>
    <xmx:lwi7ZpuZxrEvKZiF9kQP6ZSRV0IDR44v1gzZYu_6Fe04vg7heOWVdA>
    <xmx:lwi7ZlFFW6VAnJ91ABwMLpSEZAtHZ_DAJAJbyVKNBmMa0COQoSdbsw>
    <xmx:lwi7ZgPbbP_Ep7f07HXUsnFNERKKSjhc8gPzh0PUYMUQsRtXqJbufQ>
    <xmx:lwi7ZqWmAXlFUzAunyBoAFT9yKwvNz-UsdLOZRj2bx9yZJ2rajWU_PoY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 03:17:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d294eda9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 07:17:26 +0000 (UTC)
Date: Tue, 13 Aug 2024 09:17:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/7] config: fix constness of out parameter for
 `git_config_get_expiry()`
Message-ID: <040453f27f0b2755bb359fe07a703ce66e071ab6.1723533091.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723533091.git.ps@pks.im>

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

