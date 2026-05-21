Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0584C39E9B0
	for <git@vger.kernel.org>; Thu, 21 May 2026 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349374; cv=none; b=iSrrqQsnPD+Ov0ybNTbYYdFhosH9pXkvdJIYWqtnrIsELchr1APucQqkTRy87bX4icMuG5VN/iTzjb90L1F1xVED3aZ4ehu2EJTuWr3eySkKr+RxmYVrsXne+BxgrKtFm9uwt1e8SDsOOtF4zOdrDNIj2PSnCHBKU2DMcIvuSoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349374; c=relaxed/simple;
	bh=W5E58cR702ktCVYrRdaM6eqfV9Mae7hHEllrH3vgGrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brIDL96MIFDCRArkUxVrQT5OtW9Rg15NkcjMJUaZdEM6Pr+9Na5mpR/Pz/wMf/wD4GTs0CbD893qkxsFIBkU2TlALb8T9TsCInoajWSS/8lmpmTxYEd/6r40VnGRXra16czXzBON9ypchV1IbtlqY4StA8ZHSYAWvROcfI1PFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q5mL1d1x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NdwI7BBW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q5mL1d1x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NdwI7BBW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 16FFEEC009E
	for <git@vger.kernel.org>; Thu, 21 May 2026 03:42:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 03:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779349372;
	 x=1779435772; bh=hlbrUA446SwoGRpUiVVd0AU9KVJ3C31A0LTrp8IK9So=; b=
	Q5mL1d1xRCAUMpzS2bke9ptqr0CSkdOZe+QvilUpgtphIUMa91eYc3vD+WkJbdge
	lrMQFgbRvJvedYP/kBAxbwyLyRRmvFMm1Od9gGs401Yw/F20Ql57wgrCOzwl2At7
	Ch9iXdlAIly0Nnw35xhOgNPmx/XjU7dpBd/2ErxKHluJJe/XCGjbGMNQJCiX0S6J
	ilMPWnL016gd26FrlBGgJZY7VJcyWdKm7/izC6WvFHpYePCsXSk6Mz61PwokCUYi
	QtrxsqocW3WOPchJpoG6q1Q/yT13mrgYPUkhjxJ45MLVQ9twUPXBy3OFHAcKfwA9
	R8/9cO7In9u91kO9VehrXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779349372; x=
	1779435772; bh=hlbrUA446SwoGRpUiVVd0AU9KVJ3C31A0LTrp8IK9So=; b=N
	dwI7BBW3KDz6CoTYrk3WIt8otaT/SbSl3NF1vgK+zvZdNDe4HL4vhiifTW1IcpC6
	4H4PB16ZkkldgnhLeDUkuxsK7+7gBWTFOksZmKrsYxxgo8YVt3WAkiMoc+tR1Wib
	s69rk9zAh5+XAT8q/NgXJ4jHscfafWJj3tdviTp1gS1Lnf44+b6mhwmnzk+Ykedj
	9+BsmuqFqzGQuarwD9WxFlGXpoXjvU7rB2QMyNfsXvjDMzExD8k6jue6kLaw+ekk
	VA8UQ0gNa3mcyuPb8MG5NAoz0rSF6ewd7BaDdWyDFpjepkObvoWL/Dpdojh98mQf
	6cgxnpEqRDv+KtbF0qqbg==
X-ME-Sender: <xms:fLcOamQAmXPLarHotP37RQU6YO-wGE0NrAc0MdP_C_JCrq9p96Es3Q>
    <xme:fLcOaisXT2kHYmFKS44MiBxj046O4oIiaWNE9mZRsHBJATRhGdTYjl6iTzqu8bkrs
    PA2J2osS4k5ujagolirdL1KYQYfeOe9NpXeTODBGLj7hlzVmA98WA>
X-ME-Received: <xmr:fLcOapfqQwd5SNFi-q4cXfpo9sKeI8CZzThsZDfy2MAf0E0IZR-LDmE6CCZ3PeEpUjZh8qNoZ3qIo0-78OE-0USsKQHZmhg3kgJpOl2XAnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:fLcOanINWLo5EUA3_LUsfG6On5c5UYHF8g2t88S-1C0csjQ9Lvo_cg>
    <xmx:fLcOavYaz1X4mNgFppxRxScg5GomObre1SBX85WDPt8SGL7HdRkVSA>
    <xmx:fLcOaqtr2osxxdBzGxqc_gXPQ_zdhhKhOKdtNFaChkU-OP7Q9hXssw>
    <xmx:fLcOakuDXmMMloJt9FFsuLnwkjk1KpTkadKBlvCAvczS5lP2ZTZreg>
    <xmx:fLcOamSdEjrzng6VYaS_gCbxZLo7AHLw1BSih3pNBeV3isvIciUo1m7u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 03:42:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f4b04c7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 07:42:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 09:42:33 +0200
Subject: [PATCH 6/8] setup: stop initializing object database without
 repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-setup-centralize-odb-creation-v1-6-f130d2a7e8ae@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
In-Reply-To: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The function `setup_git_directory_gently()` is responsible for
discovering and setting up a Git repository based on various environment
variables and the current working directory. The result is thus a fully
usable Git repository.

One oddity of this function is that we may set up the object database
even in the case where we don't have a repository, namely in the case
where the `GIT_DIR_EXPLICIT` environment variable is set but points to a
non-existent repository. If so, we call `setup_git_env_internal()` with
the value of the environment variable so that the repository's Git
directory is configured, even if it points to a non-existent directory.

Historically though, this function didn't only configure the repository,
but also initialized the object database. We retained this behaviour
from a preceding commit, even though it really doesn't make much sense
in the first place -- there is no repository, so we don't have an object
database either. There seemingly isn't much of a reason to construct the
object database, as we typically won't try to read objects when we don't
have an object database.

There's one exception though: git-index-pack(1) may run outside of a
repository, which can be used to perform consistency checks for a
packfile. The code path is _almost_ working: we already know to call
`parse_object_buffer()`, which can read objects without an object
database being available. And that works for all object types except for
commits, because `parse_commit_buffer()` calls `parse_commit_graph()`,
and that function doesn't handle the case where we don't have an object
database.

Fix this instance to check for the object database instead of checking
for the Git directory having been initialized. With this fixed, we can
now stop constructing an object database completely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 4 ++--
 setup.c        | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9abe62bd5a..0820cf5fb8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -740,13 +740,13 @@ static struct commit_graph *prepare_commit_graph(struct repository *r)
 	struct odb_source *source;
 
 	/*
-	 * Early return if there is no git dir or if the commit graph is
+	 * Early return if there is no object database or if the commit graph is
 	 * disabled.
 	 *
 	 * This must come before the "already attempted?" check below, because
 	 * we want to disable even an already-loaded graph file.
 	 */
-	if (!r->gitdir || r->commit_graph_disabled)
+	if (!r->objects || r->commit_graph_disabled)
 		return NULL;
 
 	if (r->objects->commit_graph_attempted)
diff --git a/setup.c b/setup.c
index 0dc9fe4565..4a8d6230b1 100644
--- a/setup.c
+++ b/setup.c
@@ -2043,13 +2043,12 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			setup_git_env_internal(repo, gitdir);
 		}
 
-		repo->objects = odb_new(repo,
-					getenv_safe(&to_free, DB_ENVIRONMENT),
-					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
-
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
 
+			repo->objects = odb_new(repo,
+						getenv_safe(&to_free, DB_ENVIRONMENT),
+						getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
 			if (apply_repository_format(repo, &repo_fmt, &err) < 0)
 				die("%s", err.buf);
 

-- 
2.54.0.771.g3ed373ac14.dirty

