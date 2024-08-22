Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AACC1836D5
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318280; cv=none; b=p7e8FjMrSk4ZmR65yUL39lshG/F7H6di0yD/D+aIRZZ2X8odwzNKfrx409isT7RuUw503Fo2lq1eHKLVLf8c1YgHprGvynQHXnXl9bj57+IGBVSpLc75iP96KZSAbSwdmscRCXsUZ8JyG7t19vAbJYw8NxJcnOy+/WlK9vf73IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318280; c=relaxed/simple;
	bh=Br3jKC5gK8wl0Mwp21gqIuK66/tgOmHZ8tL7Z58VCHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKC/09HsODALwkibpEMud/8z3e1pAHbXy7jv8dVrO6Esp6m3CYNcyNJ9FHm+aoefcpRvkikhZxYTHg8llqSc45Lwxq6mps69fdj7LGFAXkmlnUzkNJAqfcx1gcLpz7M76eFYiNMdo9Pd2JYvLRJqvP2pz+uzSFxCM7SXdc99FvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VJ9P3WDv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f9u8rm7u; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VJ9P3WDv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f9u8rm7u"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B20B11151ACA;
	Thu, 22 Aug 2024 05:17:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 22 Aug 2024 05:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318277; x=1724404677; bh=5y/4KdAzaD
	VUjmsq6cdSaKltOTfA6iBNuSaHl1RINP4=; b=VJ9P3WDvdZ+VfugAzgB2Ci+HZP
	Lcx5aE8ayw5+pfD7Zy/lqbSwx/ANcvneoaZkVFJz3kZh06R6YdT/sl6jp5Hi+ZWN
	WyQ6X6JWfwLRl4t+bFhAk/LBRPc62xQ/sq7i77QFRUiNyzTUkMFsV2iw1jkZ9k5i
	KWMoFT1KjC3wX5WuNp3qX4jIhs34LYpOMBD8m946xyhVrnl5r9hDsmdgxnnr3f5S
	OCfO3hPAZPz14mM9AtNf8HLZFMTKaUo905BU2G0ck4za2LwRGOBFnXJ/m4mkz0CL
	kSRTxpnVQAmKiqTJXDTCg8EeC514ej6guZDlqO6eOPVZOHjzJTdh8nN2KDKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318277; x=1724404677; bh=5y/4KdAzaDVUjmsq6cdSaKltOTfA
	6iBNuSaHl1RINP4=; b=f9u8rm7uICHjdPl/+Ig8/RsGfF2gfU+aMqddU8kh3Uyf
	uzEVWJ9vDyQalVCPPjdqlBQfWkvbeeSy3lyE1pZS4VS7HMsiXNR6GK5TFsjiS+x4
	rEav1m++izvEntpgifWfesgClTcYPeYW/C1M3xvXDdZGOq8H8xIStwV+hP7+l0qZ
	EVxuQZShuHCbKAHQq4sBBqJfSDT6rGWRc1UUhCzsF3VbovbRhRzubQNL2KdDAVFH
	bspu5T4RTVMC35uDRWOZ28EoRXWqI353hm9Dm0SWittAodCNXFi8Iro3yuSi/lTe
	lZB11gCXUZfbxBoGVTdegniskIYUlTR3Gz3umFKODA==
X-ME-Sender: <xms:RQLHZjasA9CD4cMPjsyF78bNwtA3th4UwgfXPxjuV1bvhGIEMEesJw>
    <xme:RQLHZibzBry6TU4MDp5PiXQjsMHo0370JuD9wH3ZTDeGK4d-c5MWpldXo8Pz26WAU
    z4o1XaBnZfCSXjP4g>
X-ME-Received: <xmr:RQLHZl8D0l80IQqnIjrahs2K0GTqKA7JIu-fBJksWnd1lXScXe4ryObXoA9aQf7mf-Nf1FtHgSadAkV6qyNEreXIdItMp-qsD2LUkjZl1sHHSII>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:RQLHZpo16j3XF1WeFdmhZzUDv7rXmiq8LMrhOfgZvGa3suRuY4NTfQ>
    <xmx:RQLHZuryHPvvsQY3I9LsFoTve18B_fLPmBAgvjgadPWDG0tejLxiew>
    <xmx:RQLHZvRFMEpR8O9Yx70F9Ecv4jXNVjfb6vXxffdZF-jjJC3bq6MDfQ>
    <xmx:RQLHZmqS9HzzLGzh9Z_VLnXUIBHNUQ_OzIYxqXmeVrw6upSV9qfmgg>
    <xmx:RQLHZl2zN4gDHTUmxLV_kljgXl9VDGDqAHewsR4BrdHO-gQRg5-SEIzF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 45affc52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:17:22 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/20] remote: fix leaking config strings
Message-ID: <532328b78140620549385c7e2dff3ecc98036593.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

We're leaking several config strings when assembling remotes, either
because we do not free preceding values in case a config was set
multiple times, or because we do not free them when releasing the remote
state. This includes config strings for "branch" sections, "insteadOf",
"pushInsteadOf", and "pushDefault".

Plug those leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 7d5b8f750d8..2c52119bbb2 100644
--- a/remote.c
+++ b/remote.c
@@ -243,6 +243,17 @@ static struct branch *make_branch(struct remote_state *remote_state,
 	return ret;
 }
 
+static void branch_release(struct branch *branch)
+{
+	free((char *)branch->name);
+	free((char *)branch->refname);
+	free(branch->remote_name);
+	free(branch->pushremote_name);
+	for (int i = 0; i < branch->merge_nr; i++)
+		refspec_item_clear(branch->merge[i]);
+	free(branch->merge);
+}
+
 static struct rewrite *make_rewrite(struct rewrites *r,
 				    const char *base, size_t len)
 {
@@ -263,6 +274,14 @@ static struct rewrite *make_rewrite(struct rewrites *r,
 	return ret;
 }
 
+static void rewrites_release(struct rewrites *r)
+{
+	for (int i = 0; i < r->rewrite_nr; i++)
+		free((char *)r->rewrite[i]->base);
+	free(r->rewrite);
+	memset(r, 0, sizeof(*r));
+}
+
 static void add_instead_of(struct rewrite *rewrite, const char *instead_of)
 {
 	ALLOC_GROW(rewrite->instead_of, rewrite->instead_of_nr + 1, rewrite->instead_of_alloc);
@@ -373,8 +392,10 @@ static int handle_config(const char *key, const char *value,
 			return -1;
 		branch = make_branch(remote_state, name, namelen);
 		if (!strcmp(subkey, "remote")) {
+			FREE_AND_NULL(branch->remote_name);
 			return git_config_string(&branch->remote_name, key, value);
 		} else if (!strcmp(subkey, "pushremote")) {
+			FREE_AND_NULL(branch->pushremote_name);
 			return git_config_string(&branch->pushremote_name, key, value);
 		} else if (!strcmp(subkey, "merge")) {
 			if (!value)
@@ -406,9 +427,11 @@ static int handle_config(const char *key, const char *value,
 		return 0;
 
 	/* Handle remote.* variables */
-	if (!name && !strcmp(subkey, "pushdefault"))
+	if (!name && !strcmp(subkey, "pushdefault")) {
+		FREE_AND_NULL(remote_state->pushremote_name);
 		return git_config_string(&remote_state->pushremote_name, key,
 					 value);
+	}
 
 	if (!name)
 		return 0;
@@ -475,12 +498,15 @@ static int handle_config(const char *key, const char *value,
 		else if (!strcmp(value, "--tags"))
 			remote->fetch_tags = 2;
 	} else if (!strcmp(subkey, "proxy")) {
+		FREE_AND_NULL(remote->http_proxy);
 		return git_config_string(&remote->http_proxy,
 					 key, value);
 	} else if (!strcmp(subkey, "proxyauthmethod")) {
+		FREE_AND_NULL(remote->http_proxy_authmethod);
 		return git_config_string(&remote->http_proxy_authmethod,
 					 key, value);
 	} else if (!strcmp(subkey, "vcs")) {
+		FREE_AND_NULL(remote->foreign_vcs);
 		return git_config_string(&remote->foreign_vcs, key, value);
 	}
 	return 0;
@@ -2797,16 +2823,26 @@ struct remote_state *remote_state_new(void)
 
 void remote_state_clear(struct remote_state *remote_state)
 {
+	struct hashmap_iter iter;
+	struct branch *b;
 	int i;
 
 	for (i = 0; i < remote_state->remotes_nr; i++)
 		remote_clear(remote_state->remotes[i]);
 	FREE_AND_NULL(remote_state->remotes);
+	FREE_AND_NULL(remote_state->pushremote_name);
 	remote_state->remotes_alloc = 0;
 	remote_state->remotes_nr = 0;
 
+	rewrites_release(&remote_state->rewrites);
+	rewrites_release(&remote_state->rewrites_push);
+
 	hashmap_clear_and_free(&remote_state->remotes_hash, struct remote, ent);
-	hashmap_clear_and_free(&remote_state->branches_hash, struct remote, ent);
+	hashmap_for_each_entry(&remote_state->branches_hash, &iter, b, ent) {
+		branch_release(b);
+		free(b);
+	}
+	hashmap_clear(&remote_state->branches_hash);
 }
 
 /*
-- 
2.46.0.164.g477ce5ccd6.dirty

