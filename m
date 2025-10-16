Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB582DECDE
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599618; cv=none; b=gTrLM5eXyL2kK8CMEvhhjUxERWfDJOKbi2BJakgHplM349gLjN91cfTbXr0VKP/FOXbM7ZPQWnIPD4mwGxhLuQ2GqkR5cEX2UIBajxNHfzWn2mmo+B5PDafFdvcCQo9IOSrjXJ+awzyuD8CV7tH+t+q4ySH4QAaHLGIkwpX53lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599618; c=relaxed/simple;
	bh=OENeV5UGeBO/Ef0H+8zmquvy20ojd9g+MyoCYVQ64Eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LkV1vv8QGZQ0xnXKCvaI/m+X/xbJOzEqFd1AFMlLpD+O9zwzAxpeNffMjQxtiKCHllTjlhHdB00dr9mOuMb6oZRZ1b9i7pFVH5jfgLm/mnnzdPeAucahMQhZ6YcFAST0GSr8TuI12E5+QR5K4wkMFKaxqv5KrySbf69EgJcpvJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GxIpNZzD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=veenQDyG; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GxIpNZzD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="veenQDyG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 086921400124;
	Thu, 16 Oct 2025 03:26:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 16 Oct 2025 03:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760599615;
	 x=1760686015; bh=vdweUmy7d+ouH7vhw+VpqjQT7N+S+8ghxaHrfdPOwIQ=; b=
	GxIpNZzDuXilEKtEvRBMzJhBrc2BjytsZkRf7ecjhxV3P+F9kI3mrfUK+Rbmg/me
	ijb3totG5uMi2AnHFhmZ8f5GluM6/6WT4V7nQYGgX1Br7TsE3rhWJxVA8+2iZAki
	XvVSie8FNCBNMbtF4jJRMo3oH2TcbSMY3ofGuqXoAH6dvMR/bHzieTfxlOLTTRte
	cQz7eG4E0HwjECLANHEKAtlE+SHTZI2eQzM9iagLMGdSJuXP3+B2JjoXJRIXc2oz
	MElxRD1zFCt0epIeQlFNKHFeZv+Zjhb+gbvud1w8hbLU5jOAQyJvalK3cYjmNod9
	mOg7yXVGfXyJjWa9R4YeDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760599615; x=
	1760686015; bh=vdweUmy7d+ouH7vhw+VpqjQT7N+S+8ghxaHrfdPOwIQ=; b=v
	eenQDyGmjpPqpvdFBAFcG2pfy2OnIdVVPqzSp3T7gK5XUpLgEBEs4VBRPPnJ43m3
	qSkyDJDTKX2Rephr40nTllsHFX49h4araVG1yCqwPzRnZqD+pKbjXiyZGo84+i/8
	ySTOKgRRqOgaolfqDIKdQ9TE6Lsw/K35VJ8g3MMWVMpj4KgxojQY6NF1ZyLormkh
	Oi+pq+67WzL/VvZWJHJUz6F7fCH/9laAToPSdrASJ+mAvgsAMzAHlcfVk6D/3OPD
	jmUof9KNpwzXGAdD+g6Tut5FjrMUNSJQm3cjPJoiC6oZn0g+vt82lppZC290imwE
	W7T6OOUq/6NkqeJ/rSGRw==
X-ME-Sender: <xms:Pp7waGPOiePwFGpJUU1L_SIARHYBAqA6h_IWlvqNPStGE5A0Wbx2dA>
    <xme:Pp7waMbJL4CeMm6JEATFhUUE6rcfTNssES1ABdUvI7aKskfap_0m_szWMeHi2_-dL
    rSdTzzejtPK8Jw73U23WFqTuCCAgx0qjAJp5oXend6FmzMm8Ghu>
X-ME-Received: <xmr:Pp7waKrVpm7_8HxqH_xZOedqW68d-E-EJ8AIMu18H9cCLL1VsKS__I2sbpzCI-TDe4S2Rdg3C9_i3GsrtlvFhLZKPyiGz2_vu5S9clTsfYfBOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehieelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Pp7waAY5gk6auTBY76RNng1jVuCAftgnApEHORaFjvJX94bDIz6y4A>
    <xmx:Pp7waCQnl5y_bpex2taUBn7z4VjejPPzIRDHA1FFXTsC5IaLtZiT1Q>
    <xmx:Pp7waH6DR9FqwaPOtzPNAEuOMkFWZde3AHrLNNrZx_fHYZHoJHmkfg>
    <xmx:Pp7waHw6kUU7UfbHc2NMb-sbjDScwZGvqZQEeOVm4zeJ091xJ9iSuA>
    <xmx:P57waC2wUFhpkEW6GVCAKh1DyCPq-3VS32O1q0P_OmuPS7aRqtgMYmZr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 03:26:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e1331b87 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 16 Oct 2025 07:26:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Oct 2025 09:26:34 +0200
Subject: [PATCH 3/8] builtin/maintenance: introduce "geometric-repack" task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-pks-maintenance-geometric-strategy-v1-3-18943d474203@pks.im>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
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
 t/t7900-maintenance.sh                | 137 ++++++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+)

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
index ddd273d8dc2..83a373fe94b 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -465,6 +465,143 @@ test_expect_success 'maintenance.incremental-repack.auto (when config is unset)'
 	)
 '
 
+run_and_verify_geometric_pack () {
+	EXPECTED_PACKS="$1" &&
+
+	# Verify that we perform a geometric repack.
+	rm -f "trace2.txt" &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		git maintenance run --task=geometric-repack 2>/dev/null &&
+	test_subcommand git repack -d -l --geometric=2 --quiet --write-midx <trace2.txt &&
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
+		# to merge both packfiles together. This should be turned into
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
+	AUTO_LIMIT="$2" &&
+	rm -f trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		git ${AUTO_LIMIT:+-c maintenance.geometric-repack.auto=$AUTO_LIMIT} maintenance run --auto --task=geometric-repack &&
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
+		test_geometric_repack_needed false 0 &&
+		test_geometric_repack_needed false 1 &&
+		test_geometric_repack_needed true -1 &&
+
+		test_oid_init &&
+
+		# Loose objects cause a repack when crossing the limit. Note
+		# that the number of objects gets extrapolated by having a look
+		# at the "objects/17/" shard.
+		test_commit "$(test_oid blob17_1)" &&
+		test_geometric_repack_needed false &&
+		test_commit "$(test_oid blob17_2)" &&
+		test_geometric_repack_needed false 257 &&
+		test_geometric_repack_needed true 256 &&
+
+		# Force another repack.
+		test_commit first &&
+		test_commit second &&
+		test_geometric_repack_needed true -1 &&
+
+		# We now have two packfiles that would be merged together. As
+		# such, the repack should always happen unless the user has
+		# disabled the auto task.
+		test_geometric_repack_needed false 0 &&
+		test_geometric_repack_needed true 9000
+	)
+'
+
 test_expect_success 'pack-refs task' '
 	for n in $(test_seq 1 5)
 	do

-- 
2.51.0.869.ge66316f041.dirty

