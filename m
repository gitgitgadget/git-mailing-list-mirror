Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9BE2D59E8
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922777; cv=none; b=eERZVpjcq7i/dbGh5imRivtvumiAVnD2LxGXcoClSdIYj6lXtDM3uekRDLYOuFAbRqhDfxcgs2liBH8UYf7Cu4BvTqRq9U47PVH03GdKPe4z1IhFMypNy8lxz5Y3OKraw+u7ntQp5QNOX5sm1HIplBC+QjlXLiUI3g8Uerdo49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922777; c=relaxed/simple;
	bh=YY4bdoKONBi7LBxnhZX53Npwd/y9QNuuap34EnNuSHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWsL8V/lnwYRiiwt3MklF/DyIlRLzSJmacSSuCpI5TwKzs5y7O0nPl1K469yRIuriYaQX5y40Vtbjhw2qo9YY1TmokVjFGMdoxG9A308WTPNwYMaDJxFmxlB/3I5r4QJC7U3PIg/Xy8DWmsEqX5vsF8T0XRvVP0hWRG/4LSe5/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A07ZnO+5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hFc/6fBD; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A07ZnO+5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hFc/6fBD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7BE9D14001CE;
	Tue, 24 Feb 2026 03:46:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 24 Feb 2026 03:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771922775;
	 x=1772009175; bh=geujpZP3GceSlpX47G+QVeizVyChfhLm38Y7XtEl3k8=; b=
	A07ZnO+5pyoxtfR+5c4F1Mhb5yotXRRuWqI1JdyJgojmE/9Cl2QeBoR4hz/jBwnV
	a5jXGQ77F13CdGEfr2vYOTrr/fZYlGWuk5e/QVyGMh5SPfIRwP+7kqzoNRj/o1S/
	A7oOesfORftQMOX7QAh1dYT/Lkx1ICbE75V2n1ZoPvetlVqqQ3Fv87ZBBmDjvmX+
	O8dD01x5gm5xwqAeLUdytB1h0PBGKCNYHWnY6j4M8LsqJ3mW500n8IlmNHDToLnC
	ZkCzTR/1URzkdWyu2pcs1JJBdOsvlMGWDKyJbZovJeP949M78K1U67fm37lfw1Rx
	60S+RqXcZEwkTpzAMEP2iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771922775; x=
	1772009175; bh=geujpZP3GceSlpX47G+QVeizVyChfhLm38Y7XtEl3k8=; b=h
	Fc/6fBDlcmBJE/BXXBPxUDlHLkRUrcyOThlTSTxVJWanaHQOySzPqLuAsdGIRBqK
	0zJsJ6FQ/8x2ZjZWzZ2CIDBzreLIAI9ClXJPfgM/nycO9vdoGQ8BwezkyCs7hBj5
	ncFm2RJDzBJlagc6CamBzyF0P2uvJpu10HMcv+ryY44Mu3vDO0dq+/sacVwPlHUn
	Bni+iZlISWuX87arszALRm8o40OjLKKZhqmxZhyl8MdjMhV5kZu7JhNLp1/pNjNE
	sKoCftsgnlNNoog+NwpPSiZt52oEKmAbDhO8r7E4VM25OMDF+XXZ1OUk6gaxE0sE
	bgAz+HFQ22zynjWruZPEw==
X-ME-Sender: <xms:V2WdaRXdPEEijy82wRobpZm0RM4wbSnJiY71M9G-DSVF1tZGH9bKbQ>
    <xme:V2WdaYnAFd62g4OX8uBFRcyevSUS4oXKEntEENO8d9_e13T72iw1BXefCp33vCrXa
    UuxyXbJstqw7N1yIto3oNbkf7vYDabkyqQNXJ0WhgXgvmiFHg_3wg>
X-ME-Received: <xmr:V2WdaSYedNR6Lvp4wswsJY2CROMNFwtMIesE-lVRziuuJ-2xd-AJV6isfupG2-W_iOsgIqs2voDR_arpbjQxWbq8RQpbzxkFuV-u7U6MfC4WvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:V2WdaTMIr2C_PeShht83tf8-mYEANkjSyUpYFLYqzPLUyGdkxhkeow>
    <xmx:V2WdaXaFKeISjy90zoGIYAk3GrQ_mEjLYgcTpEB13Qhk85jC3pbq3A>
    <xmx:V2WdaR0l9ETMZvslc56JAiLT2pKh2JdG4UOsoyLZuB2V3mjLAEq10w>
    <xmx:V2Wdadfu8pkkZSiEyaCzKhKaiFTl2sHXQtnG50hGryXHvMKsbLdKJw>
    <xmx:V2WdaeVXYNvYpZXpuaot1dQAfio47H_ZMXVqzWQBf9xuDUAxPJzepxxu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 03:46:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 266b56a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 08:46:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 24 Feb 2026 09:45:52 +0100
Subject: [PATCH v2 8/8] builtin/maintenance: use "geometric" strategy by
 default
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-8-8657338c6fa1@pks.im>
References: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
In-Reply-To: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The git-gc(1) command has been introduced in the early days of Git in
30f610b7b0 (Create 'git gc' to perform common maintenance operations.,
2006-12-27) as the main repository maintenance utility. And while the
tool has of course evolved since then to cover new parts, the basic
strategy it uses has never really changed much.

It is safe to say that since 2006 the Git ecosystem has changed quite a
bit. Repositories tend to be much larger nowadays than they have been
almost 20 years ago, and large parts of the industry went crazy for
monorepos (for various wildly different definitions of "monorepo"). So
the maintenance strategy we used back then may not be the best fit
nowadays anymore.

Arguably, most of the maintenance tasks that git-gc(1) does are still
perfectly fine today: repacking references, expiring various data
structures and things like tend to not cause huge problems. But the big
exception is the way we repack objects.

git-gc(1) by default uses a split strategy: it performs incremental
repacks by default, and then whenever we have too many packs we perform
a large all-into-one repack. This all-into-one repack is what is causing
problems nowadays, as it is an operation that is quite expensive. While
it is wasteful in small- and medium-sized repositories, in large repos
it may even be prohibitively expensive.

We have eventually introduced git-maintenance(1) that was slated as a
replacement for git-gc(1). In contrast to git-gc(1), it is much more
flexible as it is structured around configurable tasks and strategies.
So while its default "gc" strategy still uses git-gc(1) under the hood,
it allows us to iterate.

A second strategy it knows about is the "incremental" strategy, which we
configure when registering a repository for scheduled maintenance. This
strategy isn't really a full replacement for git-gc(1) though, as it
doesn't know to expire unused data structures. In Git 2.52 we have thus
introduced a new "geometric" strategy that is a proper replacement for
the old git-gc(1).

In contrast to the incremental/all-into-one split used by git-gc(1), the
new "geometric" strategy maintains a geometric progression of packfiles,
which significantly reduces the number of all-into-one repacks that we
have to perform in large repositories. It is thus a much better fit for
large repositories than git-gc(1).

Note that the "geometric" strategy isn't perfect though: while we
perform way less all-into-one repacks compared to git-gc(1), we still
have to perform them eventually. But for the largest repositories out
there this may not be an option either, as client machines might not be
powerful enough to perform such a repack in the first place. These cases
would thus still be covered by the "incremental" strategy.

Switch the default strategy away from "gc" to "geometric", but retain
the "incremental" strategy configured when registering background
maintenance with `git maintenance register`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc | 6 +++---
 builtin/gc.c                          | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index d0c38f03fa..b578856dde 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -30,8 +30,7 @@ The possible strategies are:
 +
 * `none`: This strategy implies no tasks are run at all. This is the default
   strategy for scheduled maintenance.
-* `gc`: This strategy runs the `gc` task. This is the default strategy for
-  manual maintenance.
+* `gc`: This strategy runs the `gc` task.
 * `geometric`: This strategy performs geometric repacking of packfiles and
   keeps auxiliary data structures up-to-date. The strategy expires data in the
   reflog and removes worktrees that cannot be located anymore. When the
@@ -40,7 +39,8 @@ The possible strategies are:
   are already part of a cruft pack will be expired.
 +
 This repacking strategy is a full replacement for the `gc` strategy and is
-recommended for large repositories.
+recommended for large repositories. This is the default strategy for manual
+maintenance.
 * `incremental`: This setting optimizes for performing small maintenance
   activities that do not delete any data. This does not schedule the `gc`
   task, but runs the `prefetch` and `commit-graph` tasks hourly, the
diff --git a/builtin/gc.c b/builtin/gc.c
index 4390eee6ec..fb329c2cff 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1980,7 +1980,7 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 		strategy = none_strategy;
 		type = MAINTENANCE_TYPE_SCHEDULED;
 	} else {
-		strategy = gc_strategy;
+		strategy = geometric_strategy;
 		type = MAINTENANCE_TYPE_MANUAL;
 	}
 

-- 
2.53.0.536.g309c995771.dirty

