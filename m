Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F5D32BF59
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056019; cv=none; b=pCnPKeUDHbssgFbPBFWLGeCQYwwrD6yKczqzSPoZmXkqX0RM1JV2UofY+wxtlx2oaCfuwjZ8na34FwCZ5JsE88cmLbCf8S7VTJ/uhrY8F/BJs/SLUfJ2amq0F4Sfn8PjaGUjNmdVyc9lz4OGklN4a05a/dlaAnsxqF64euGxdtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056019; c=relaxed/simple;
	bh=sGhi587wUhXCLIJJcxy+rt6BaKvuzJq2S79iv21WbpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxnOwo3i1zThyS/HdHwMrYpwuGBYrIKWVv2DmWrKghaw9wjzPcPSebyP4YX1o6Kfz7tbu/JFa8d0QRvU+HKIeoDk9T2FarrrW11FsxME/br5PTTSvn/e73RyRHe18+RQzGMs45qXb7f9FQ1HD94Pphg0k1NYXJpmtuCS81+WTbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KDIXEsg+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h62ph/aD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KDIXEsg+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h62ph/aD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1C4F3140016A;
	Tue, 21 Oct 2025 10:13:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 10:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056016;
	 x=1761142416; bh=cwRfzzv93fJSj3m8E17naF5X/ONRGr48mJpqpA8WC2o=; b=
	KDIXEsg+mciQkiwrHC2L/zsI+SmRTiBnpl5im3hkutK1+frP/b0tes3kbwdOK6t4
	+IwrAdITbFfm0GliRou4GoZTwTp+1xIB/kqBG5IiqGVCbaZqTkULjxkbaCNy1geN
	AC0WgBPd0DZwKGqjhEVoezcXC4iuOE5R4EGst1VIZqGSfiALNn5QpSOFA8fd1sSF
	A9WkFUEJCDM0JnHAezIY/VyFXrm2xp5wRKB3EycFJ0sQcD1/fUmS/darMH3aN21Q
	h+/QCZZ2U4963mu6mdYaIpULaYS1KRvVsVJwqVLl3ioO2/UhiDsB7PQduFPX7QhU
	sy2BMTU4aNCEn24Zxk49Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056016; x=
	1761142416; bh=cwRfzzv93fJSj3m8E17naF5X/ONRGr48mJpqpA8WC2o=; b=h
	62ph/aDWc90IjBETaEMIk4B2g1k0vGFUoxXzskCSk3NM6AS3fC61oJeIrFAfg0z3
	DBH+4jTS5Nm2/rix86Wl7Ou1TqNhjXszL+3noMs0t98b1U3aX8RzxTR6sxc79Ogd
	srKZ94ljxYgf1n5QjWtuzClbz5TR0smhPYfBVAwjcUnP26AkuIT6lU9yUB4/DW9s
	uHgbbYcUn9BK1O+yoCcF60JEA2kRswJIBI0ibALWuX+7VKTP3T28duJV1rktOuVf
	ZVEXfwE0PO9icgbSoGpuiiBXinvZnsJ7/FaCl0PHyLaqY9G1lJu4H48uoEf4qx01
	1cUoin5gH+Gb+Za3kg71g==
X-ME-Sender: <xms:D5X3aCG4ijVbdf-ynhnD8PXzR1BNRHsDRlTwbY2c3rm8lxPreCHvTQ>
    <xme:D5X3aKwDvHtyF_hcAli613nW3lmazAzlyErdGenWlnRMwxLdwrIDd3C85u0JZyfL2
    JXfDy3CDoi4Lhekb8CKQ_A1NlU0-clF8XHuXkQJXIvqFz6oMIpKUsU>
X-ME-Received: <xmr:D5X3aJggaFkMPUD6kgb3D1ZfkKcK7A0Zn75_4obKUfKIayIyvykcXCh-plFV5N2BLXcolpewRZjUn-qKpjkgHUtH_BBLjqG7C0ViV6eNETICQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetteelteektdelffefuddvgfdvieefveeifeeuiefhjeetkeektefhjeegfeduvden
    ucffohhmrghinhepihhntghrvghmvghnthgrlhdqrhgvphgrtghkrdgruhhtohdpghgvoh
    hmvghtrhhitgdqrhgvphgrtghkrdgruhhtohdprhgvfhhlohhgqdgvgihpihhrvgdrrghu
    thhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepph
    hssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:D5X3aFz0iGNU7H-jpQImUXuE28qypVPIFhxBZKwNoo4KaV7pjY5z5A>
    <xmx:D5X3aMIuDORpuCUpSIClGsO3KLvbJS7PC2AtENXB6EcICkaVd20eFA>
    <xmx:D5X3aMS1m2zWLVt0Kr-AVDg_pT-Mr8uCPKEb3B8FqfVUHkbWhYH76Q>
    <xmx:D5X3aEqGHRqdca2EmLP_ABaFHA_rP_DVrnhdmeLDO0FafDSIxERjgQ>
    <xmx:EJX3aLos8QJsnFsdb6jE361Oa7V9fPj2dJrfb-ynSbPwEgXd0ZFWiqx6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:13:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7eadcd3c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:13:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:13:25 +0200
Subject: [PATCH v2 3/9] builtin/maintenance: introduce "geometric-repack"
 task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-pks-maintenance-geometric-strategy-v2-3-f0d727832b80@pks.im>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
In-Reply-To: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

Introduce a new "geometric-repack" task. This task uses our geometric
repack infrastructure as provided by git-repack(1) itself, which is a
strategy that especially hosting providers tend to use to amortize the
costs of repacking objects.

There is one issue though with geometric repacks, namely that they
unconditionally pack all loose objects, regardless of whether or not
they are reachable. This is done because it means that we can completely
skip the reachability step, which significantly speeds up the operation.
But it has the big downside that we are unable to expire objects over
time.

To address this issue we thus use a split strategy in this new task:
whenever a geometric repack would merge together all packs, we instead
do an all-into-one repack. By default, these all-into-one repacks have
cruft packs enabled, so unreachable objects would now be written into
their own pack. Consequently, they won't be soaked up during geometric
repacking anymore and can be expired with the next full repack, assuming
that their expiry date has surpassed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc |  11 +++
 builtin/gc.c                          | 102 +++++++++++++++++++++++++
 t/t7900-maintenance.sh                | 139 ++++++++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index 2f719342183..26dc5de423f 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -75,6 +75,17 @@ maintenance.incremental-repack.auto::
 	number of pack-files not in the multi-pack-index is at least the value
 	of `maintenance.incremental-repack.auto`. The default value is 10.
 
+maintenance.geometric-repack.auto::
+	This integer config option controls how often the `geometric-repack`
+	task should be run as part of `git maintenance run --auto`. If zero,
+	then the `geometric-repack` task will not run with the `--auto`
+	option. A negative value will force the task to run every time.
+	Otherwise, a positive value implies the command should run either when
+	there are packfiles that need to be merged together to retain the
+	geometric progression, or when there are at least this many loose
+	objects that would be written into a new packfile. The default value is
+	100.
+
 maintenance.reflog-expire.auto::
 	This integer config option controls how often the `reflog-expire` task
 	should be run as part of `git maintenance run --auto`. If zero, then
diff --git a/builtin/gc.c b/builtin/gc.c
index 026d3a1d714..2c9ecd464d2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -34,6 +34,7 @@
 #include "pack-objects.h"
 #include "path.h"
 #include "reflog.h"
+#include "repack.h"
 #include "rerere.h"
 #include "blob.h"
 #include "tree.h"
@@ -254,6 +255,7 @@ enum maintenance_task_label {
 	TASK_PREFETCH,
 	TASK_LOOSE_OBJECTS,
 	TASK_INCREMENTAL_REPACK,
+	TASK_GEOMETRIC_REPACK,
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
 	TASK_PACK_REFS,
@@ -1566,6 +1568,101 @@ static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts
 	return 0;
 }
 
+static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
+					     struct gc_config *cfg)
+{
+	struct pack_geometry geometry = {
+		.split_factor = 2,
+	};
+	struct pack_objects_args po_args = {
+		.local = 1,
+	};
+	struct existing_packs existing_packs = EXISTING_PACKS_INIT;
+	struct string_list kept_packs = STRING_LIST_INIT_DUP;
+	struct child_process child = CHILD_PROCESS_INIT;
+	int ret;
+
+	existing_packs.repo = the_repository;
+	existing_packs_collect(&existing_packs, &kept_packs);
+	pack_geometry_init(&geometry, &existing_packs, &po_args);
+	pack_geometry_split(&geometry);
+
+	child.git_cmd = 1;
+
+	strvec_pushl(&child.args, "repack", "-d", "-l", NULL);
+	if (geometry.split < geometry.pack_nr)
+		strvec_push(&child.args, "--geometric=2");
+	else
+		add_repack_all_option(cfg, NULL, &child.args);
+	if (opts->quiet)
+		strvec_push(&child.args, "--quiet");
+	if (the_repository->settings.core_multi_pack_index)
+		strvec_push(&child.args, "--write-midx");
+
+	if (run_command(&child)) {
+		ret = error(_("failed to perform geometric repack"));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	existing_packs_release(&existing_packs);
+	pack_geometry_release(&geometry);
+	return ret;
+}
+
+static int geometric_repack_auto_condition(struct gc_config *cfg UNUSED)
+{
+	struct pack_geometry geometry = {
+		.split_factor = 2,
+	};
+	struct pack_objects_args po_args = {
+		.local = 1,
+	};
+	struct existing_packs existing_packs = EXISTING_PACKS_INIT;
+	struct string_list kept_packs = STRING_LIST_INIT_DUP;
+	int auto_value = 100;
+	int ret;
+
+	repo_config_get_int(the_repository, "maintenance.geometric-repack.auto",
+			    &auto_value);
+	if (!auto_value)
+		return 0;
+	if (auto_value < 0)
+		return 1;
+
+	existing_packs.repo = the_repository;
+	existing_packs_collect(&existing_packs, &kept_packs);
+	pack_geometry_init(&geometry, &existing_packs, &po_args);
+	pack_geometry_split(&geometry);
+
+	/*
+	 * When we'd merge at least two packs with one another we always
+	 * perform the repack.
+	 */
+	if (geometry.split) {
+		ret = 1;
+		goto out;
+	}
+
+	/*
+	 * Otherwise, we estimate the number of loose objects to determine
+	 * whether we want to create a new packfile or not.
+	 */
+	if (too_many_loose_objects(auto_value)) {
+		ret = 1;
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	existing_packs_release(&existing_packs);
+	pack_geometry_release(&geometry);
+	return ret;
+}
+
 typedef int (*maintenance_task_fn)(struct maintenance_run_opts *opts,
 				   struct gc_config *cfg);
 typedef int (*maintenance_auto_fn)(struct gc_config *cfg);
@@ -1608,6 +1705,11 @@ static const struct maintenance_task tasks[] = {
 		.background = maintenance_task_incremental_repack,
 		.auto_condition = incremental_repack_auto_condition,
 	},
+	[TASK_GEOMETRIC_REPACK] = {
+		.name = "geometric-repack",
+		.background = maintenance_task_geometric_repack,
+		.auto_condition = geometric_repack_auto_condition,
+	},
 	[TASK_GC] = {
 		.name = "gc",
 		.foreground = maintenance_task_gc_foreground,
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index ddd273d8dc2..60029a65a35 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -465,6 +465,145 @@ test_expect_success 'maintenance.incremental-repack.auto (when config is unset)'
 	)
 '
 
+run_and_verify_geometric_pack () {
+	EXPECTED_PACKS="$1" &&
+
+	# Verify that we perform a geometric repack.
+	rm -f "trace2.txt" &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		git maintenance run --task=geometric-repack 2>/dev/null &&
+	test_subcommand git repack -d -l --geometric=2 \
+		--quiet --write-midx <trace2.txt &&
+
+	# Verify that the number of packfiles matches our expectation.
+	ls -l .git/objects/pack/*.pack >packfiles &&
+	test_line_count = "$EXPECTED_PACKS" packfiles &&
+
+	# And verify that there are no loose objects anymore.
+	cat >expect <<-\EOF &&
+	info
+	pack
+	EOF
+	ls .git/objects >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'geometric repacking task' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+		test_commit initial &&
+
+		# The initial repack causes an all-into-one repack.
+		GIT_TRACE2_EVENT="$(pwd)/initial-repack.txt" \
+			git maintenance run --task=geometric-repack 2>/dev/null &&
+		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago --quiet --write-midx <initial-repack.txt &&
+
+		# Repacking should now cause a no-op geometric repack because
+		# no packfiles need to be combined.
+		ls -l .git/objects/pack >before &&
+		run_and_verify_geometric_pack 1 &&
+		ls -l .git/objects/pack >after &&
+		test_cmp before after &&
+
+		# This incremental change creates a new packfile that only
+		# soaks up loose objects. The packfiles are not getting merged
+		# at this point.
+		test_commit loose &&
+		run_and_verify_geometric_pack 2 &&
+
+		# Both packfiles have 3 objects, so the next run would cause us
+		# to merge all packfiles together. This should be turned into
+		# an all-into-one-repack.
+		GIT_TRACE2_EVENT="$(pwd)/all-into-one-repack.txt" \
+			git maintenance run --task=geometric-repack 2>/dev/null &&
+		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago --quiet --write-midx <all-into-one-repack.txt &&
+
+		# The geometric repack soaks up unreachable objects.
+		echo blob-1 | git hash-object -w --stdin -t blob &&
+		run_and_verify_geometric_pack 2 &&
+
+		# A second unreachable object should be written into another packfile.
+		echo blob-2 | git hash-object -w --stdin -t blob &&
+		run_and_verify_geometric_pack 3 &&
+
+		# And these two small packs should now be merged via the
+		# geometric repack. The large packfile should remain intact.
+		run_and_verify_geometric_pack 2 &&
+
+		# If we now add two more objects and repack twice we should
+		# then see another all-into-one repack. This time around
+		# though, as we have unreachable objects, we should also see a
+		# cruft pack.
+		echo blob-3 | git hash-object -w --stdin -t blob &&
+		echo blob-4 | git hash-object -w --stdin -t blob &&
+		run_and_verify_geometric_pack 3 &&
+		GIT_TRACE2_EVENT="$(pwd)/cruft-repack.txt" \
+			git maintenance run --task=geometric-repack 2>/dev/null &&
+		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago --quiet --write-midx <cruft-repack.txt &&
+		ls .git/objects/pack/*.pack >packs &&
+		test_line_count = 2 packs &&
+		ls .git/objects/pack/*.mtimes >cruft &&
+		test_line_count = 1 cruft
+	)
+'
+
+test_geometric_repack_needed () {
+	NEEDED="$1"
+	GEOMETRIC_CONFIG="$2" &&
+	rm -f trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		git ${GEOMETRIC_CONFIG:+-c maintenance.geometric-repack.$GEOMETRIC_CONFIG} \
+		maintenance run --auto --task=geometric-repack 2>/dev/null &&
+	case "$NEEDED" in
+	true)
+		test_grep "\[\"git\",\"repack\"," trace2.txt;;
+	false)
+		! test_grep "\[\"git\",\"repack\"," trace2.txt;;
+	*)
+		BUG "invalid parameter: $NEEDED";;
+	esac
+}
+
+test_expect_success 'geometric repacking with --auto' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# An empty repository does not need repacking, except when
+		# explicitly told to do it.
+		test_geometric_repack_needed false &&
+		test_geometric_repack_needed false auto=0 &&
+		test_geometric_repack_needed false auto=1 &&
+		test_geometric_repack_needed true auto=-1 &&
+
+		test_oid_init &&
+
+		# Loose objects cause a repack when crossing the limit. Note
+		# that the number of objects gets extrapolated by having a look
+		# at the "objects/17/" shard.
+		test_commit "$(test_oid blob17_1)" &&
+		test_geometric_repack_needed false &&
+		test_commit "$(test_oid blob17_2)" &&
+		test_geometric_repack_needed false auto=257 &&
+		test_geometric_repack_needed true auto=256 &&
+
+		# Force another repack.
+		test_commit first &&
+		test_commit second &&
+		test_geometric_repack_needed true auto=-1 &&
+
+		# We now have two packfiles that would be merged together. As
+		# such, the repack should always happen unless the user has
+		# disabled the auto task.
+		test_geometric_repack_needed false auto=0 &&
+		test_geometric_repack_needed true auto=9000
+	)
+'
+
 test_expect_success 'pack-refs task' '
 	for n in $(test_seq 1 5)
 	do

-- 
2.51.1.851.g4ebd6896fd.dirty

