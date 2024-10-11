Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC65D207A07
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624759; cv=none; b=kXK4Py3sy8qSCYYYwBXwhxwv5G0BiccxRJA4HP0HrozIRFc6VAyd6E3SZbryatsof6WrXIjIidD7fHsy8CCO+jPswcSjLS+Iad0MJ41pbFj2uOAYFCc/oOr5gmDiSuqa7lVGFBdfKkV+KvOTg0Ej72djUEI7EA/9eKG5olJRr+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624759; c=relaxed/simple;
	bh=bBi4qB3iFZLBb8pz/84IHwjAnposOszMOzZ2eKrmric=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeDfo2zrFafR/74GlP83D2qy4LQYfR0NRlBesU4phuGJScYB4ghMQ70lesBkjFK44ptZ8Zztxm0NFApUEW0Bs7jymCcPRyZceF+vOoC7LzzzErtdX1jRREp+avEEXigzcoRq9UiqFZRAR8GMESqXLTnnimBY5chHWXGet+yydyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rdqwJCtr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mLfk3OuK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rdqwJCtr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLfk3OuK"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16CAA1140139
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 11 Oct 2024 01:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624757; x=1728711157; bh=sYRnfP4hGi
	0Olig43R02iSA1smd3zS6lNqahH/JzB2Y=; b=rdqwJCtrVT6V2UpyrERjW8kDgD
	JqIw0FM8wS/T2bS5l/6cMj1bFdPKiC2OJFrOojdBMhsYHTgnIDHjBOLuNplpHtb5
	9HKlXDmzb5nrAvnfVJOVSwumIDWVyrim3dkCrWq+caIstH6KY7Hq+9A4ohIr948H
	CYYS1j61DO1L+dxP32Vohqg77iIWl491yofqXMRwDiIN087Lx4600Hp2GcMe1DpA
	mxe2TmTNm+VFZE0Cq7o0Z+J4RwQfYum79F1BeRiDLg/zvBHlMjwdNOcwTENrvZWt
	kgoUVJDrvuWaidv+HKeJtWvSgpnRcgDksXJQZaRsna1And1/6G69kRZw0Rug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624757; x=1728711157; bh=sYRnfP4hGi0Olig43R02iSA1smd3
	zS6lNqahH/JzB2Y=; b=mLfk3OuK2Avz+CUG6jFvxN11HlBhk1UCTZQNS2NUH84Y
	2XYGsaOI3xup3eP/WjRR7SBarSzrmNZQc7LwwLQV47kgBqmKnQKo767wrdKURiAb
	y2kmuYZzw/zhiNw+4Zu+gqaF+RzLBByicZFLQBMnNWlRXCQLGGe1/R6cqlubDNWI
	P/iQ5a0EYu9t+8Uitrx9utaSUN6rpchBJaMWp7/eA3yXfBZ0j3hUByEs52cgFkz0
	sxgJQOpywCm9w+1AXrYGPM9a2v7OlmehWv8uYk3Vs93tGW64i6KLPbTD2X81VVYQ
	sYD/twQTQp5K0fqyvyqeWH5tf+niJXEpCxvEUHOjQA==
X-ME-Sender: <xms:dLgIZ6dtsQ8kvWpOCGtCibuGS8mwFoISiXZtNhxv09xpUevMFAcQEw>
    <xme:dLgIZ0PW-UaUOziRhCDfs17MCnCTx66LdrYSUFp52QcH8Uihh9kc1SVwBXifOcwI6
    gcbpu9ElBS6cKABtA>
X-ME-Received: <xmr:dLgIZ7jEBEZ5159mTDBsSzWfDs_VNoUuncrWA9CmcPqZKjZjC5z6m6EiKze0LdBjca5TkiYhWsnTYZLwAclxB0zJD7L1rcOTVOAvyAnO0ZQl1AE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dLgIZ39-SEd_JtHcWUTZKRYxwmDaAwAs_fLzEFaWmTgLA-HO6ehfdA>
    <xmx:dLgIZ2u623Z4Q3ziro6dfZfZg6TRDc7kyVL0PSlyQ-A6ojFeMifqgA>
    <xmx:dLgIZ-EdlSpIp5UVzS0wtDBwdK2CqGbJwzRoiden1jGNs2BVykLdww>
    <xmx:dLgIZ1NwXzbjrgI1J3v95V19RA--apdjRlCOQjOowXdyVSEdpHIy9w>
    <xmx:dbgIZ7U6m3vyiUSX3nsxk4uHIwxQ4P-ZGFUaZaXUKr_zYRu-LK6i60t8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3eec2174 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:30 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/21] builtin/commit: fix leaking change data contents
Message-ID: <9f967dfe5d55ca7150bf3e118279388290f7d28c.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

While we free the worktree change data, we never free its contents. Fix
this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit.c                          | 9 ++++++++-
 t/t7500-commit-template-squash-signoff.sh | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8db4e9df0c9..18a55bd1b91 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -728,6 +728,13 @@ static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
 	repo_unuse_commit_buffer(the_repository, commit, buffer);
 }
 
+static void change_data_free(void *util, const char *str UNUSED)
+{
+	struct wt_status_change_data *d = util;
+	free(d->rename_source);
+	free(d);
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct commit *current_head,
 			     struct wt_status *s,
@@ -991,7 +998,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		s->use_color = 0;
 		committable = run_status(s->fp, index_file, prefix, 1, s);
 		s->use_color = saved_color_setting;
-		string_list_clear(&s->change, 1);
+		string_list_clear_func(&s->change, change_data_free);
 	} else {
 		struct object_id oid;
 		const char *parent = "HEAD";
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 4dca8d97a77..379d3ed3413 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -7,6 +7,7 @@ test_description='git commit
 
 Tests for template, signoff, squash and -F functions.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
-- 
2.47.0.dirty

