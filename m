Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364B25F965
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093350; cv=none; b=ThrjIOwZJAmavZMYepI4ABo09/pI+MeyBX1iSOOZCV0rqOtdLgXfHZqcPI88Sn7SZIhrcutfZx1RRkeMki8vXcBHoC4+/AAoKzePiRb28Uj1OffRNBtduLKaDwBcA/k18lmywXGNa4s0g7LJN7VqSBcI0cZdWtrOtzFn1Nuof6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093350; c=relaxed/simple;
	bh=Xvqs0fJ5UniBYP9oIwqngYml1BWLJwLqTMaDQR2Ta30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MOS0jsGEKtnfv/vmcc7WLpdxz0oOtZj/r2u+LmroHOF32iPn8HsruVtESoq4MMKMYlK+VLRwnx8EZIAN9dHIl44L5b39LoH3JYiDUN/Zt9/IRCCxhJOHy5udMZFE8BPKiyJP819A3bDzEW3cArSqeLs7eKQabdIIgWKbX/iQlAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bjRW12v8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gz7z0gV3; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bjRW12v8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gz7z0gV3"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 861E61140117;
	Tue,  8 Apr 2025 02:22:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 08 Apr 2025 02:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744093347;
	 x=1744179747; bh=fBrxCjme4uiCXTBLQSv+CPgvQwzNKBBWA/QNXPkrevQ=; b=
	bjRW12v8pHEUUsOOfbultt9r+eDWSRTym5ZtNIk/stcGjrM9y0aOcFqrgkEZcn+x
	+G2oO7Ri4cFYwRWMclBFPs9/yApQea8V9leACVTwhV135kHsgKKAz/8ciR2DAw79
	w+CTUFMVBQxZSbcMLCugfAmj1EK77B6ba3BpEiVmP24HuLMh5NBKTETeCzcGcCp6
	ExQsp32j2B81GmR+LSO8dhCGr4WNEJjbd+diHgFwtJH52JMdV3qzgd5F3YPfpO8y
	el9Cpn2h3KeDznwNg9iEyLL3iACsVgUX4cM2O+ugf6RDUHxreU7wWG0bBOEl+C+U
	xDUcj8CxmofrZKF8Ev8AZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744093347; x=
	1744179747; bh=fBrxCjme4uiCXTBLQSv+CPgvQwzNKBBWA/QNXPkrevQ=; b=g
	z7z0gV3CM5mvy6P2T7n7ZgLS7jE8gNbqtNhCQJs7d+3ye50ucpFa8YDlIztHq27N
	mnIe52WkK+OvNRLKPWalT6OUOkAGPizjQ7kgBi4kmjJ5p51/kDvybe6rEq2ijzTV
	G9woz8kp/qnp6JzbLvWbA27atqtw7Sd3smt8Zr88JaYvtzPDOwmz2VzVx3QwvdX0
	7CzO56XKvzsRoCiLqSHUJf9zAsVCr5xCdPOHDreEzh1afyNPeyRfi/dCrtrulHjN
	oa8DIR09s1i/pyN0sH+yYQDwaL7k34R3oxW3Dz48esiX+utCsFrGNrdQCoVIYzxT
	NcUU5wM70QW8BuqG88VAg==
X-ME-Sender: <xms:o8D0Z1MlBSYOC2G6UHojdofYcxhZzEtzwV3pWStLaH6pMgmXTgWtuQ>
    <xme:o8D0Z3-SM3oeE-uAvLXmAPwUvO0F_73fWhb9PPShOlMkJxWUXVi6_KVI4Yp2U_RO0
    NkBn_LM2KtU4lNMHw>
X-ME-Received: <xmr:o8D0Z0TSB4RzqjTNJCXNEF2psm76mT9Qbbdc3P-S8VsVH7f0xIopX7P9bt-KghsmKiVDlqOammkvIr3h77LSKqoJCl0J9MVQ9ISc38QosqdB0nrXVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeevvdevueevteelffetledtveethefgudekveel
    ieduvedvjedtfefhvdekffejteenucffohhmrghinheprhgvfhhlohhgqdgvgihpihhrvg
    drrghuthhopdhinhgtrhgvmhgvnhhtrghlqdhrvghprggtkhdrrghuthhopdhlohhoshgv
    qdhosghjvggtthhsrdgruhhtohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgr
    mhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopedvtddvheesuhigphdruggv
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:o8D0ZxsL0VE-duCYmt7F7_-Wz0QZ45S_8mIcikzneljKC698adYOSA>
    <xmx:o8D0Z9fAI4nk60MiMfarxgEzvK4kpQ2Mr_PuiYfPsWJ-xmTeebdHrQ>
    <xmx:o8D0Z93hlDxyGoCkIC7fP1qp3EYVvyVkcW-VptOqHjTIxIAWJVkxgw>
    <xmx:o8D0Z59Kqt6EpBNpqPKaPOmiRovsp8vy23AkJB4xuwGHceFd0_IzZA>
    <xmx:o8D0Z2qZCr8jqtOz0U7W6My-FpaRFA5rgmUMFZ0uaHSqzn7nnwcCGxif>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 02:22:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0f40fca6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Apr 2025 06:22:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Apr 2025 08:22:17 +0200
Subject: [PATCH v2 6/6] builtin/maintenance: introduce "reflog-expire" task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-pks-maintenance-reflog-expire-v2-6-1ad8634798b7@pks.im>
References: <20250408-pks-maintenance-reflog-expire-v2-0-1ad8634798b7@pks.im>
In-Reply-To: <20250408-pks-maintenance-reflog-expire-v2-0-1ad8634798b7@pks.im>
To: git@vger.kernel.org
Cc: Markus Gerstel <2025@uxp.de>, Junio C Hamano <gitster@pobox.com>, 
 Derrick Stolee <stolee@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: b4 0.14.2

By default, git-maintenance(1) uses the "gc" task to ensure that the
repository is well-maintained. This can be changed, for example by
either explicitly configuring which tasks should be enabled or by using
the "incremental" maintenance strategy. If so, git-maintenance(1) does
not know to expire reflog entries, which is a subtask that git-gc(1)
knows to perform for the user. Consequently, the reflog will grow
indefinitely unless the user manually trims it.

Introduce a new "reflog-expire" task that plugs this gap:

  - When running the task directly, then we simply execute `git reflog
    expire --all`, which is the same as git-gc(1).

  - When running git-maintenance(1) with the `--auto` flag, then we only
    run the task in case the "HEAD" reflog has at least N reflog entries
    that would be discarded. By default, N is set to 100, but this can
    be configured via "maintenance.reflog-expire.auto". When a negative
    integer has been provided we always expire entries, zero causes us
    to never expire entries, and a positive value specifies how many
    entries need to exist before we consider pruning the entries.

Note that the condition for the `--auto` flags is merely a heuristic and
optimized for being fast. This is because `git maintenance run --auto`
will be executed quite regularly, so scanning through all reflogs would
likely be too expensive in many repositories.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc |  9 +++++++
 Documentation/git-maintenance.adoc    |  4 +++
 builtin/gc.c                          | 50 +++++++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh                | 18 +++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index 72a9d6cf816..e57f346a067 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -69,3 +69,12 @@ maintenance.incremental-repack.auto::
 	Otherwise, a positive value implies the command should run when the
 	number of pack-files not in the multi-pack-index is at least the value
 	of `maintenance.incremental-repack.auto`. The default value is 10.
+
+maintenance.reflog-expire.auto::
+	This integer config option controls how often the `reflog-expire` task
+	should be run as part of `git maintenance run --auto`. If zero, then
+	the `reflog-expire` task will not run with the `--auto` option. A
+	negative value will force the task to run every time. Otherwise, a
+	positive value implies the command should run when the number of
+	expired reflog entries in the "HEAD" reflog is at least the value of
+	`maintenance.loose-objects.auto`. The default value is 100.
diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
index 0450d74aff1..8bc94a6d4ff 100644
--- a/Documentation/git-maintenance.adoc
+++ b/Documentation/git-maintenance.adoc
@@ -158,6 +158,10 @@ pack-refs::
 	need to iterate across many references. See linkgit:git-pack-refs[1]
 	for more information.
 
+reflog-expire::
+	The `reflog-expire` task deletes any entries in the reflog older than the
+	expiry threshold. See linkgit:git-reflog[1] for more information.
+
 OPTIONS
 -------
 --auto::
diff --git a/builtin/gc.c b/builtin/gc.c
index e8f5705dc59..ce5bb2630f8 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -33,6 +33,7 @@
 #include "pack.h"
 #include "pack-objects.h"
 #include "path.h"
+#include "reflog.h"
 #include "blob.h"
 #include "tree.h"
 #include "promisor-remote.h"
@@ -285,6 +286,49 @@ static int maintenance_task_pack_refs(struct maintenance_run_opts *opts,
 	return run_command(&cmd);
 }
 
+struct count_reflog_entries_data {
+	struct expire_reflog_policy_cb policy;
+	size_t count;
+	size_t limit;
+};
+
+static int count_reflog_entries(struct object_id *old_oid, struct object_id *new_oid,
+				const char *committer, timestamp_t timestamp,
+				int tz, const char *msg, void *cb_data)
+{
+	struct count_reflog_entries_data *data = cb_data;
+	if (should_expire_reflog_ent(old_oid, new_oid, committer, timestamp, tz, msg, &data->policy))
+		data->count++;
+	return data->count >= data->limit;
+}
+
+static int reflog_expire_condition(struct gc_config *cfg UNUSED)
+{
+	timestamp_t now = time(NULL);
+	struct count_reflog_entries_data data = {
+		.policy = {
+			.opts = REFLOG_EXPIRE_OPTIONS_INIT(now),
+		},
+	};
+	int limit = 100;
+
+	git_config_get_int("maintenance.reflog-expire.auto", &limit);
+	if (!limit)
+		return 0;
+	if (limit < 0)
+		return 1;
+	data.limit = limit;
+
+	repo_config(the_repository, reflog_expire_config, &data.policy.opts);
+
+	reflog_expire_options_set_refname(&data.policy.opts, "HEAD");
+	refs_for_each_reflog_ent(get_main_ref_store(the_repository), "HEAD",
+				 count_reflog_entries, &data);
+
+	reflog_expiry_cleanup(&data.policy);
+	return data.count >= data.limit;
+}
+
 static int maintenance_task_reflog_expire(struct maintenance_run_opts *opts UNUSED,
 					  struct gc_config *cfg UNUSED)
 {
@@ -1383,6 +1427,7 @@ enum maintenance_task_label {
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
 	TASK_PACK_REFS,
+	TASK_REFLOG_EXPIRE,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -1419,6 +1464,11 @@ static struct maintenance_task tasks[] = {
 		maintenance_task_pack_refs,
 		pack_refs_condition,
 	},
+	[TASK_REFLOG_EXPIRE] = {
+		"reflog-expire",
+		maintenance_task_reflog_expire,
+		reflog_expire_condition,
+	},
 };
 
 static int compare_tasks_by_selection(const void *a_, const void *b_)
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 1909aed95e0..ff98cde92c0 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -447,6 +447,24 @@ test_expect_success 'pack-refs task' '
 	test_subcommand git pack-refs --all --prune <pack-refs.txt
 '
 
+test_expect_success 'reflog-expire task' '
+	GIT_TRACE2_EVENT="$(pwd)/reflog-expire.txt" \
+		git maintenance run --task=reflog-expire &&
+	test_subcommand git reflog expire --all <reflog-expire.txt
+'
+
+test_expect_success 'reflog-expire task --auto only packs when exceeding limits' '
+	git reflog expire --all --expire=now &&
+	test_commit reflog-one &&
+	test_commit reflog-two &&
+	GIT_TRACE2_EVENT="$(pwd)/reflog-expire-auto.txt" \
+		git -c maintenance.reflog-expire.auto=3 maintenance run --auto --task=reflog-expire &&
+	test_subcommand ! git reflog expire --all <reflog-expire-auto.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/reflog-expire-auto.txt" \
+		git -c maintenance.reflog-expire.auto=2 maintenance run --auto --task=reflog-expire &&
+	test_subcommand git reflog expire --all <reflog-expire-auto.txt
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "at most one" err

-- 
2.49.0.682.gc9b6a7b2b0.dirty

