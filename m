Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3027978C
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289055; cv=none; b=o8DiRVsZQLIuDy3LBQ6U4VqzlgjeTSviW8YiVCFEfw7W8vVAKnWLEbpaaualIu9EHtwdq6YxUFvUP7GDSbcpIjIJo5KODZ9l4uDpODkl2vDAlgCnxja1MuXAIv6VWrUULBve1T3ognc778p/0Q3no5fsl31K8gAexhNEPz8mkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289055; c=relaxed/simple;
	bh=e2+CfIXa2aOcRMAMZsYS5ybroSAnEF235bjdIty6UGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PTj5wdsODBugZRxMLxf0B+bP6eUVscaUWLqw4BK4UPTtTNeCJLtNd8KPxpHhEylUPao+vGR+XCjzUiSMOWQablRXmJUw71S3jjXMeAl4cbFw0wvgZI6os4x+eZ3yDAUW42ybWlwXkpyP73xOmBQDtzbeOtfdx8e+QNRHACsOt98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pOEcwguw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M4BHY1hX; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pOEcwguw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M4BHY1hX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 04926EC0278;
	Fri, 24 Oct 2025 02:57:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 24 Oct 2025 02:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761289052;
	 x=1761375452; bh=tRh7MqR44ObBEIZZwLDtlpIYXGBexT8syrV66B3tBS0=; b=
	pOEcwguw5/M+P7AwwPZWS+wHI9On/l5YvOY/YOfCCxrBrd3R3Zpk95HptpHTt0Qs
	yvYvvRXhDr0n6O3LByfFUWe0jnHb08KWj9fBTWWauuE6YIJEOJPzKFF7LmAYP0Q4
	roobx9MSKIXvSJc60KP8v1+MHcgrLcB+MsYnUbfIrjOMZDD3L6GaUP+xNjl5IQSN
	DCAI66maciZUvuUsu229PYlnumr28OkJfvtGtQvl9I3JXiva+rhIF5mdAM3nKf+h
	iEK0TycnmkCzc5K04mVpa/tjsXipHlb8OGX2pZIdDk2QWtdqP5eFphQeCR2FbikZ
	CN4OsbJahogFo+TRuIaXGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761289052; x=
	1761375452; bh=tRh7MqR44ObBEIZZwLDtlpIYXGBexT8syrV66B3tBS0=; b=M
	4BHY1hX7BZv5sICln3vci6nF9GSH53lfDlcMU3qPHJ0jHUI6eVHaXVyG2TwyukW+
	mmYPIMG7jkYtuQ74Pr5wEu9pqpU2n07WnT92CdwgopI3rvENZwZ2cybgJ9ebCoO/
	TXS0pW7lUm0tG/GqsRGAr5lxCST2sTTHA0lgzjhpYRcmWN7AbcAPbE4AnbTCM2dM
	wNnd1HQrBE81RTW67yoNCG73wWWawomPdl6m/ssEB+eINhxx2lBloaHHOaS6WCHj
	xqMtLgyE9vVt9X7OYcNg4mx+2mJtKSPSpmh5tDvntgaEMsTo+QnjmwsqnnBeqiyC
	JfYIQtRRM2QQg4bkye6nQ==
X-ME-Sender: <xms:WyP7aBf7wwFRr2nER-qRcazo6glOLJ1LOM7tCRDfr27lVnijGxqiXQ>
    <xme:WyP7aGF5aVqyfNuvu6OJiJ-vlegoJ9e95c-B141RTsek7TfKzgN2ESBx8KVORR_q-
    RO0p4xxK9wLK5JeW0Aho_yWVgYJ8Ww7TJnDD_ZwCAC2bk6uRf5B>
X-ME-Received: <xmr:WyP7aC1ndOgUQj5nO6OJjLnieCSOfOEqGkOwPnqdMb7BgKpvYG0f-qVgqq81vE8kU30CXlpJoqHqgWKN7PDcqm0qwQngc6YFkcGnWuGQsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekveejhffhjeevjeefjeegtdejffeltefgjefgfffhueeuueeivefgudefiedthfen
    ucffohhmrghinhepghgvohhmvghtrhhitgdqrhgvphgrtghkrdgruhhtohdprhgvfhhloh
    hgqdgvgihpihhrvgdrrghuthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:WyP7aGmGXzddR3__jIMQQ3Lihwtgiju72r-RCf5AaLM7tnn-YvPk_g>
    <xmx:WyP7aK9NUJLY2QbJ223H6efYH4EIGKx4Y4ScPhcR6u7wij0xx7r2kw>
    <xmx:WyP7aDqnTNVRrjvSn8DN5IxHmgkIEhETM0lTS0DL-tZMx8XSxjJn5w>
    <xmx:WyP7aLmXknuJCEJMoJZ2LOZ4VMBxnRRdYSJga7JbKz18OtJfpYtOpA>
    <xmx:WyP7aA-KUL87dI462Rmd6_dG90JPggrFx4WBqTbONBjlfmY5_0FYUIQb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 02:57:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a9e6d85 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 06:57:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 08:57:17 +0200
Subject: [PATCH v3 04/10] builtin/maintenance: make the geometric factor
 configurable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-pks-maintenance-geometric-strategy-v3-4-9b5b3bdb4387@pks.im>
References: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
In-Reply-To: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

The geometric repacking task uses a factor of two for its geometric
sequence, meaning that each next pack must contain at least twice as
many objects as the next-smaller one. In some cases it may be helpful to
configure this factor though to reduce the number of packfile merges
even further, e.g. in very big repositories. But while git-repack(1)
itself supports doing this, the maintenance task does not give us a way
to tune it.

Introduce a new "maintenance.geometric-repack.splitFactor" configuration
to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc |  5 +++++
 builtin/gc.c                          |  9 ++++++++-
 t/t7900-maintenance.sh                | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index 26dc5de423f..45fdafc2c63 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -86,6 +86,11 @@ maintenance.geometric-repack.auto::
 	objects that would be written into a new packfile. The default value is
 	100.
 
+maintenance.geometric-repack.splitFactor::
+	This integer config option controls the factor used for the geometric
+	sequence. See the `--geometric=` option in linkgit:git-repack[1] for
+	more details. Defaults to `2`.
+
 maintenance.reflog-expire.auto::
 	This integer config option controls how often the `reflog-expire` task
 	should be run as part of `git maintenance run --auto`. If zero, then
diff --git a/builtin/gc.c b/builtin/gc.c
index 2c9ecd464d2..fb1a82e0304 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1582,6 +1582,9 @@ static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret;
 
+	repo_config_get_int(the_repository, "maintenance.geometric-repack.splitFactor",
+			    &geometry.split_factor);
+
 	existing_packs.repo = the_repository;
 	existing_packs_collect(&existing_packs, &kept_packs);
 	pack_geometry_init(&geometry, &existing_packs, &po_args);
@@ -1591,7 +1594,8 @@ static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
 
 	strvec_pushl(&child.args, "repack", "-d", "-l", NULL);
 	if (geometry.split < geometry.pack_nr)
-		strvec_push(&child.args, "--geometric=2");
+		strvec_pushf(&child.args, "--geometric=%d",
+			     geometry.split_factor);
 	else
 		add_repack_all_option(cfg, NULL, &child.args);
 	if (opts->quiet)
@@ -1632,6 +1636,9 @@ static int geometric_repack_auto_condition(struct gc_config *cfg UNUSED)
 	if (auto_value < 0)
 		return 1;
 
+	repo_config_get_int(the_repository, "maintenance.geometric-repack.splitFactor",
+			    &geometry.split_factor);
+
 	existing_packs.repo = the_repository;
 	existing_packs_collect(&existing_packs, &kept_packs);
 	pack_geometry_init(&geometry, &existing_packs, &po_args);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index ace0ba83002..e0352fd1965 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -603,6 +603,38 @@ test_expect_success 'geometric repacking with --auto' '
 	)
 '
 
+test_expect_success 'geometric repacking honors configured split factor' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+
+		# Create three different packs with 9, 2 and 1 object, respectively.
+		# This is done so that only a subset of packs would be merged
+		# together so that we can verify that `git repack` receives the
+		# correct geometric factor.
+		for i in $(test_seq 9)
+		do
+			echo first-$i | git hash-object -w --stdin -t blob || return 1
+		done &&
+		git repack --geometric=2 -d &&
+
+		for i in $(test_seq 2)
+		do
+			echo second-$i | git hash-object -w --stdin -t blob || return 1
+		done &&
+		git repack --geometric=2 -d &&
+
+		echo third | git hash-object -w --stdin -t blob &&
+		git repack --geometric=2 -d &&
+
+		test_geometric_repack_needed false splitFactor=2 &&
+		test_geometric_repack_needed true splitFactor=3 &&
+		test_subcommand git repack -d -l --geometric=3 --quiet --write-midx <trace2.txt
+	)
+'
+
 test_expect_success 'pack-refs task' '
 	for n in $(test_seq 1 5)
 	do

-- 
2.51.1.930.gacf6e81ea2.dirty

