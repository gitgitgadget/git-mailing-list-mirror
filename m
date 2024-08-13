Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9118E03B
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541518; cv=none; b=H9rw3852UKyRbaO6/8ah/ElQf1/oknzbj2c2lINqBYnGWGeOaP5LWBpRrH3gXlXOOO3v3NJEIcJ4lx875YG3lJHjGfZdZGw6eE3+kJB2ZrFnLWNY/048dKojLpneaYWevLY/38m2EkJMCZXREza17NHkUpKNYyYo6Ac0BR/o6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541518; c=relaxed/simple;
	bh=waks8hoUfznjH12i0vKxdz5LLbjHaWq8lhvqfR9VQag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRHyrzrCRUoTyHllGq3/EMm1hzaOmS7lrh5TO8mrvPM+CSs8lTqICWnjyD0nKj0o70+7iZAMGuUCsgmlBbvSrmbgQueJ20IiINeO91Jc6fdRJGT8QWxCzuk7LSz+M3yx/p4hgJO+341W6TCwdxA9SH9PxQzJT7qGHfE6NoDShWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BhD6VaLM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a8r53hNF; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BhD6VaLM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a8r53hNF"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 63E601151A09;
	Tue, 13 Aug 2024 05:31:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 05:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541516; x=1723627916; bh=VsEJeKMeqw
	r010bAYWR8h0QBoC4ZOScl7Aq4HzEOYMU=; b=BhD6VaLMftzYJAGVsCdZKzHSi1
	N5wVbACDiuzwInfpfFaduPBdTWNSurIhXeQaMlL58gz9xTztqAFk6XdunE2tpYdu
	3zeAL6AHQUnOPD/jaEwjOy7ktN9Sv1uW5whEdDql4HmE1y8SQSlOM9zDzWfE5v5V
	E23eOJzz32D4ANJj2c7R8Kb+Qyf4WngrW59FaYLqY8qAkteXvNUMM385PqlPKJ/H
	G+isbLUzMIvbR2uDac0/rmBVkbIpSZibiNCfbFdAt5ory1l72Usqfc2DuJmYrNtB
	OwuSUh8FaK6qofd4SgDR7/XK8kC3MckAY8DgZFCs4P8OEyRQ+uhEGW6E11Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541516; x=1723627916; bh=VsEJeKMeqwr010bAYWR8h0QBoC4Z
	OScl7Aq4HzEOYMU=; b=a8r53hNFbWjvyM1ad925JKUjo0bFuEgqg86EDLmCXnNH
	6W5yQdJrxuMa5SyWeBGSGj8clbmtvzXIHsIMMowDOlCy74aK+6iAyUG8kXxWDBRf
	CUgSQ459pRS3r3RdyllaHaVKAACSFxrnXyfQL1zxBoENnON81qKxniFkQ5+cr4pK
	tY9BP7f+xP0n/mF7ddbbMn2414bZWLyIj54KsjutlbdMFP58nwTb5L1qZbQB+dej
	2hGilKtt7C4X5iV81MKmMNrcpXPdBaYhAxZeQaNcqa4BTG3WL/E1C1qt4t3T8+vM
	jwcYZp1dnx1nAdG7wvktSbJ31uHs0erMLORlhxpo8Q==
X-ME-Sender: <xms:DCi7ZmrxAo2ghtRepdRGCw9zhQbgWYD24fz4Iy1ASPbEG-rL-Y_EZg>
    <xme:DCi7Zkoi1HDi35uWwB1JZovigrN2L7yZMP9c8wbkmqvUKY3eX5eDq5fVIsez0-puC
    eXhRL_Qgw7NbRMXOQ>
X-ME-Received: <xmr:DCi7ZrNtuWBe83nUNbXHdKkkaWav7oSTJdO3DmcptbB5O7DhysfQbHKIoS6xmJ6hslI1kLQbKz3PNvvHMUVe02zUCiQ92UcmPV3Lrvf3oq6Ukw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhi
    ohdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DCi7Zl7zaWchiIzSglVDhJ2mR1b8TYnKT6fDeu_91SgGQt-qI2CfgA>
    <xmx:DCi7Zl7XrlNofE6Yed2rgGPx2eHwxumVB8IaMitH7O5FFOF3YTZXnQ>
    <xmx:DCi7ZljDfkbQz3aRfS2gYHaRUETP3ud_0cAxfUbQ8D1wCKPDWhJmLw>
    <xmx:DCi7Zv7NN78HVmnJWPnoOUCqOW6jJOiolXUA7KLR9WvpqDTItzN1MA>
    <xmx:DCi7ZiuFF6NwhhBDFz7x2ffOFsOnTMAPZh9tfAFIfWjGAhoRoyBZrMnb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d1f7c2ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:38 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 15/22] sequencer: release todo list on error paths
Message-ID: <9f08a859fb7481187310331c008317c4626a3a82.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

We're not releasing the `todo_list` in `sequencer_pick_revisions()` when
hitting an error path. Restructure the function to have a common exit
path such that we can easily clean up the list and thus plug this memory
leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c                     | 66 +++++++++++++++++++++++----------
 t/t3510-cherry-pick-sequence.sh |  1 +
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cade9b0ca8..ea559c31f1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5490,8 +5490,10 @@ int sequencer_pick_revisions(struct repository *r,
 	int i, res;
 
 	assert(opts->revs);
-	if (read_and_refresh_cache(r, opts))
-		return -1;
+	if (read_and_refresh_cache(r, opts)) {
+		res = -1;
+		goto out;
+	}
 
 	for (i = 0; i < opts->revs->pending.nr; i++) {
 		struct object_id oid;
@@ -5506,11 +5508,14 @@ int sequencer_pick_revisions(struct repository *r,
 				enum object_type type = oid_object_info(r,
 									&oid,
 									NULL);
-				return error(_("%s: can't cherry-pick a %s"),
-					name, type_name(type));
+				res = error(_("%s: can't cherry-pick a %s"),
+					    name, type_name(type));
+				goto out;
 			}
-		} else
-			return error(_("%s: bad revision"), name);
+		} else {
+			res = error(_("%s: bad revision"), name);
+			goto out;
+		}
 	}
 
 	/*
@@ -5525,14 +5530,23 @@ int sequencer_pick_revisions(struct repository *r,
 	    opts->revs->no_walk &&
 	    !opts->revs->cmdline.rev->flags) {
 		struct commit *cmit;
-		if (prepare_revision_walk(opts->revs))
-			return error(_("revision walk setup failed"));
+
+		if (prepare_revision_walk(opts->revs)) {
+			res = error(_("revision walk setup failed"));
+			goto out;
+		}
+
 		cmit = get_revision(opts->revs);
-		if (!cmit)
-			return error(_("empty commit set passed"));
+		if (!cmit) {
+			res = error(_("empty commit set passed"));
+			goto out;
+		}
+
 		if (get_revision(opts->revs))
 			BUG("unexpected extra commit from walk");
-		return single_pick(r, cmit, opts);
+
+		res = single_pick(r, cmit, opts);
+		goto out;
 	}
 
 	/*
@@ -5542,16 +5556,30 @@ int sequencer_pick_revisions(struct repository *r,
 	 */
 
 	if (walk_revs_populate_todo(&todo_list, opts) ||
-			create_seq_dir(r) < 0)
-		return -1;
-	if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT))
-		return error(_("can't revert as initial commit"));
-	if (save_head(oid_to_hex(&oid)))
-		return -1;
-	if (save_opts(opts))
-		return -1;
+			create_seq_dir(r) < 0) {
+		res = -1;
+		goto out;
+	}
+
+	if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT)) {
+		res = error(_("can't revert as initial commit"));
+		goto out;
+	}
+
+	if (save_head(oid_to_hex(&oid))) {
+		res = -1;
+		goto out;
+	}
+
+	if (save_opts(opts)) {
+		res = -1;
+		goto out;
+	}
+
 	update_abort_safety_file();
 	res = pick_commits(r, &todo_list, opts);
+
+out:
 	todo_list_release(&todo_list);
 	return res;
 }
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 7eb52b12ed..93c725bac3 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -12,6 +12,7 @@ test_description='Test cherry-pick continuation features
 
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Repeat first match 10 times
-- 
2.46.0.46.g406f326d27.dirty

