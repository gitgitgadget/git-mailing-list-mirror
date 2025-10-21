Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7B33B969
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056022; cv=none; b=rumpbZp5VTLVjXpU40IvuMNnlnPi++Dpxjb5AamhaCFjXZAHjCZFbl1mm6dtMyCCOYgjkF5xhR1PmQOEWlnsjDRaEjkTuap+uxBGuYq/Y2AzpSiymcjifZgzR5mUxRIZ8MFtTvo+V2hes1PpqXKZWlXimtYZEiYk7CJwcEu6aCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056022; c=relaxed/simple;
	bh=jVmaC9NwNvuc0/0rIp6o2EuJJtiyCyLRG1SyDNbqXtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJfOHtrFejNA54XlQeRdXKSiQMFqWnUq2JvHnK7EigqJ6UBig40yDX7DD/jJWMcUFhHeUMai2bh/MteE4HOBgs0EQyz4tUxe8XU0PEyiQwQ/WH9ByZ3viEzLTt5pPDIqXIzk26dK/lSuR+Cuv8C/u9WKk2Yde9/nIw97Vk5nIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gaNzTvAU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VS9TSR1h; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gaNzTvAU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VS9TSR1h"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4DEC1140016F;
	Tue, 21 Oct 2025 10:13:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 21 Oct 2025 10:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056019;
	 x=1761142419; bh=H+MVHvoNlVjXdpylySDuMHmlJgjCi/n8dWR3xo9IycU=; b=
	gaNzTvAUhTaxUZNVJkjt68ANdterZ3epgO3zheM84FsZnTd8kklPGQXGeRLPyVNw
	SLyO3ZIdLSdfT+jkkoXFhsquK7qg1C+kHvZA1aMVsqDGDgpsMdvqaFN30MdNvHnV
	fkRr/YDd4IbqU26YQCCZuS0283EMgfrq7ubILc8LSYjV1Ns+gmCF5YFm07yfKVAx
	45UDHMOiBgcv2gkyxewPDUyO9PXfaOb4Ef++iBLG0mE3GzsRm0Lta6Nj/XnrSrzi
	AXlLhBfdWmHda5KXwZpy4tVYqKLNodkYMFI2IAN9PIZSnYFkLrGI1JS4H0iF8p0K
	4GPCWY6/1B0iLRZy3172IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056019; x=
	1761142419; bh=H+MVHvoNlVjXdpylySDuMHmlJgjCi/n8dWR3xo9IycU=; b=V
	S9TSR1hmYBzWZ9SVOQMQ0YWZaQn6aeyr181BoDQAy4XmoWOnZzsKZGz6kU8azHS5
	yXUxwA6M4n7Coy6HP8u3bunJY9GP4tx8E5a51MQhguYtuOOwfBXMZygW9gClGOz3
	mlsBzvgSQOmU1xmzr1fHcfs6tgOjkYGaxrNsqbmlV2jR8dDzgOaBoG0mS/u/6+Ch
	FQGhZuBjKmYq0fGkn1TroSyNLNdWQ0WW+CeX3Ny5Q4CJykXgv8jklWxc/XF0D8lJ
	S0KZgmm7E9d5YIgbr8CWs8/B/QxfNdB2zcxEHS8XCmZljv+P1kALy41LjdjMdWqT
	SdDfTWgz+S3BWx3WtoIVQ==
X-ME-Sender: <xms:E5X3aBPUwm9OEMij5oMtmsGM4wPgKXZcGYhNWElODaD-wcUlh0ytEw>
    <xme:E5X3aLZV0017UWByZjTrrhTahkQvYqqeRcmlSLFQ7yH_jW30EOJhjDs49wDBpvLOV
    nYtgTQd57oa-p7GmEHV4ALXgJZBLYtntzw_xXlgsB5lpSra-dUQ>
X-ME-Received: <xmr:E5X3aNoKQw4zHBu6olTS9_woOHn5r8lMVTEsMvElfQQU7lUtrGURXm-HX1JrWV1HimTfCFLPKzMjcwRyEq64hdv3NKVZSBTbGbtCEb-6Ze1DDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekveejhffhjeevjeefjeegtdejffeltefgjefgfffhueeuueeivefgudefiedthfen
    ucffohhmrghinhepghgvohhmvghtrhhitgdqrhgvphgrtghkrdgruhhtohdprhgvfhhloh
    hgqdgvgihpihhrvgdrrghuthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:E5X3aHb-DUR9S1beNKBDHINH50w9yXVzqDqZuk_iGyLARwPo8fVWRw>
    <xmx:E5X3aNTXvN9dlH4GljnU5ZTbHjPDCGkkxVvxo5PE-Hqoq4dA2iG7Vg>
    <xmx:E5X3aG7eUceb6bb7TUkldobkhH5j_ilszfYuIPto9d60G0qEVqlddQ>
    <xmx:E5X3aKyS7Upt6csa0dNjU3n2gGJh7m19EpEhm0hrXtiKXujyPL3Z1Q>
    <xmx:E5X3aB0hmyfSTfU6xmqOBA-3V5e5yPmDisywDMaQFYw7g8XUlhN2ekY2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:13:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 16b8c1a9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:13:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:13:26 +0200
Subject: [PATCH v2 4/9] builtin/maintenance: make the geometric factor
 configurable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-pks-maintenance-geometric-strategy-v2-4-f0d727832b80@pks.im>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
In-Reply-To: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
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
index 60029a65a35..8f332e7fbbe 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -604,6 +604,38 @@ test_expect_success 'geometric repacking with --auto' '
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
2.51.1.851.g4ebd6896fd.dirty

