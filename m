Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399A1741D4
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172353; cv=none; b=ivpzSajXcnRDUUM0fV1LlRpq9oTwUQ87Iy4RYviDMcu0+F9LFWZwpOp3+TelGtCUPPPBYy8/LYQM9yZJyMxhA0QWFxjydlHYLOzX4IRQI0EgvwVZ9JDE5s1RM24A3zokLJGNa0E+YWXMB4zqwiAI0X4pUJXR/JKQQsmezcQTJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172353; c=relaxed/simple;
	bh=2YcoQbV7u2fq1QyH5zbcMe+8M8EwD6twXYEtqrNpc/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/LRvIWVIcXQAXa2a8mDZz8C0PWECG9SFcOknPuhtlzaJUGC7MYFwUp4K4DmvsyvMZXTsfZv/mPKBTSOkDPZqS5g5qxDSTVjR1Zd3U48fgBrPuuKnRS2J1uQqPlEoxaAL6rIH4a3YBtMJvN6I8gpJZfZOYnex56OyyNzhsCEUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IepudqW4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eTlP2mrb; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IepudqW4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eTlP2mrb"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A24F1380438;
	Tue, 24 Sep 2024 06:05:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 24 Sep 2024 06:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727172350; x=1727258750; bh=6RhcABmOBB
	c/TlGTWqihYDEz+PNLqIqusq+DBWULCG4=; b=IepudqW42A9X8jI2vZ6WNytqRP
	S91RIq9k4e2HV75nUuZyf5/GkhDPZpbyLFk5vkDq3zN8y1kym8wXJ4MoLufUPhep
	WBpg8ChxOR9AdR6T3e7OxitTtFJvbuRnA2IYV1bKQCFdbo9BSfRmoYeZ4fMhdTRk
	jetDKR6XpLPV22B+baIf8Mi4g3P3FFkFVV8Pk1IUqwrrQMjw54l3ETFZAwXP/q/V
	UgGOrPLpZgALnxWOVAoklHI7F/BBtbh5LWi2DCEhjc66RsjEhWTUqTHwUloshw26
	U/rfJ+Nu1Xkc9WCc/f4WZW5ijwAY88sS/sV0/NQHoMxFhJu4QP9Zu2vDUXwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727172350; x=1727258750; bh=6RhcABmOBBc/TlGTWqihYDEz+PNL
	qIqusq+DBWULCG4=; b=eTlP2mrbaq9vFm5+BCnQS77rMaaqmeOvFlRvSqYSkyHm
	mg6RoASIR7zDv5VjKgAgLEBU08qJccMyyw+/+4CPLvdV00ODQykjK+/+p4hg79Ry
	rOJGFLEcdjSeQOjpBdMCKFyfab0yxlXhZepQgie6cQeQO16A/X75eUoUV0FQlY5/
	9epfRCEVm4/nloh75e0sDttj5Zb38mqluV+gWu3QfzXYZzs8VYHEjLQnRLzFbupD
	y+eGuv4ko9kxs8P4tsKtHQBNtR1uPG/ZvoYziK3UkdNEnauGDYIzAfFO840GCjpm
	4+ZcLcGRhof79uaQWEVvhWob+3Yg5HOrYALIbw3XVQ==
X-ME-Sender: <xms:_o7yZsTuoECm3eFzL47YYwYZHSICbEk_lWqNdEUc0pmntSeq2dlW7Q>
    <xme:_o7yZpzdr3fqEHr8sm89_5xZ-ou030KIU83YWXpGM_1zNXKPN_wpHr-YhDL6rVdim
    7pPqTlhUAIyeuBz0g>
X-ME-Received: <xmr:_o7yZp3bK4J2CFmGobXRsRyG6tRJVxOucAsL4sCVvS6mIMlg4nXAvstrQyq0GfgOn8dct-1JXA0pWjeHDeZZIZj-Ciz1hUq0wTDW3oDs50YIEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtvddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehshhgvjhhirghluhho
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhonhgrnhesrhhjphdrihgv
X-ME-Proxy: <xmx:_o7yZgD8mrOEmva3c5CbKTbhYvr1mxQf96u6jNsyZy1cfbXFTwBHrQ>
    <xmx:_o7yZlgQqUPbl1_y9myJVVN9kopyesw4_Jw6O90s1kWs4yjmwvHUeA>
    <xmx:_o7yZsqhsZVqi5mM0Cye9Aino8Xm6EyfUrYnfrnkbCAATlUnJyA9nw>
    <xmx:_o7yZojw0hjdqAi-T09ZP46gn1U7KAimwAfuoEgkRlMfXwO1WXOP0A>
    <xmx:_o7yZlcIL8fA3aapQW8Zz3L_wZ3zzpZiEBRvgGnI_RTyybxAx0gWajdz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 06:05:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 10b36b3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 10:05:15 +0000 (UTC)
Date: Tue, 24 Sep 2024 12:05:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ronan Pigott <ronan@rjp.ie>, shejialuo <shejialuo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 2/2] config: fix evaluating "onbranch" with nonexistent git
 dir
Message-ID: <535d0d07506e8248e47f90c1a7581679fc297b3d.1727171197.git.ps@pks.im>
References: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>
 <cover.1727171197.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727171197.git.ps@pks.im>

The `include_by_branch()` function is responsible for evaluating whether
or not a specific include should be pulled in based on the currently
checked out branch. Naturally, his condition can only be evaluated when
we have a properly initialized repository with a ref store in the first
place. This is why the function guards against the case when either
`data->repo` or `data->repo->gitdir` are `NULL` pointers.

But the second check is insufficient: the `gitdir` may be set even
though the repository has not been initialized. Quoting "setup.c":

  NEEDSWORK: currently we allow bogus GIT_DIR values to be set in some
  code paths so we also need to explicitly setup the environment if the
  user has set GIT_DIR.  It may be beneficial to disallow bogus GIT_DIR
  values at some point in the future.

So when either the GIT_DIR environment variable or the `--git-dir`
global option are set by the user then `the_repository` may end up with
an initialized `gitdir` variable. And this happens even when the dir is
invalid, like for example when it doesn't exist. It follows that only
checking for whether or not `gitdir` is `NULL` is not sufficient for us
to determine whether the repository has been properly initialized.

This issue can lead to us triggering a BUG: when using a config with an
"includeIf.onbranch:" condition outside of a repository while using the
`--git-dir` option pointing to an invalid Git directory we may end up
trying to evaluate the condition even though the ref storage format has
not been set up.

This bisects to 173761e21b (setup: start tracking ref storage format,
2023-12-29), but that commit really only starts to surface the issue
that has already existed beforehand. The code to check for `gitdir` was
introduced via 85fe0e800c (config: work around bug with
includeif:onbranch and early config, 2019-07-31), which tried to fix
similar issues when we didn't yet have a repository set up. But the fix
was incomplete as it missed the described scenario.

As the quoted comment mentions, we'd ideally refactor the code to not
set up `gitdir` with an invalid value in the first place, but that may
be a bigger undertaking. Instead, refactor the code to use the ref
storage format as an indicator of whether or not the ref store has been
set up to fix the bug.

Reported-by: Ronan Pigott <ronan@rjp.ie>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c                  | 15 +++++++++------
 t/t1305-config-include.sh |  2 +-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index 1266eab0860..a11bb85da30 100644
--- a/config.c
+++ b/config.c
@@ -306,13 +306,16 @@ static int include_by_branch(struct config_include_data *data,
 	int flags;
 	int ret;
 	struct strbuf pattern = STRBUF_INIT;
-	const char *refname = (!data->repo || !data->repo->gitdir) ?
-		NULL : refs_resolve_ref_unsafe(get_main_ref_store(data->repo),
-					       "HEAD", 0, NULL, &flags);
-	const char *shortname;
+	const char *refname, *shortname;
 
-	if (!refname || !(flags & REF_ISSYMREF)	||
-			!skip_prefix(refname, "refs/heads/", &shortname))
+	if (!data->repo || data->repo->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+		return 0;
+
+	refname = refs_resolve_ref_unsafe(get_main_ref_store(data->repo),
+					  "HEAD", 0, NULL, &flags);
+	if (!refname ||
+	    !(flags & REF_ISSYMREF) ||
+	    !skip_prefix(refname, "refs/heads/", &shortname))
 		return 0;
 
 	strbuf_add(&pattern, cond, cond_len);
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index ad08db72308..517d6c86937 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -389,7 +389,7 @@ test_expect_success 'onbranch without repository' '
 	test_must_fail nongit git config get foo.bar
 '
 
-test_expect_failure 'onbranch without repository but explicit nonexistent Git directory' '
+test_expect_success 'onbranch without repository but explicit nonexistent Git directory' '
 	test_when_finished "rm -f .gitconfig config.inc" &&
 	git config set -f .gitconfig "includeIf.onbranch:**.path" config.inc &&
 	git config set -f config.inc foo.bar baz &&
-- 
2.46.0.551.gc5ee8f2d1c.dirty

