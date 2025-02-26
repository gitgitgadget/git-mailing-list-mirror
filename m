Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D82224887
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583484; cv=none; b=CdePWCTkn/9l0yN9efFOJmeqDWXinLpysbj0kNDW+a8/XvpQzAYgLP1OXvX+2En1hieKrOZVGeqxEqjXIF0BzN2ngKJ/X3hN6kvszhgQCUI126zclqB4iUddgs4rJ8AgvTympA8w+vKoj29aV3TL1GkZ6AUaVdfWZmwfvdDHltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583484; c=relaxed/simple;
	bh=4VJyQ/BkAGoH1pdba73Yw+pDGvTnq2BtoguvoEOxkiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tvoT4h6IIBIz3k7llGLp/0GbtfyhxYEpe7DjqRfYfk7z+uoezeFOAHbALlHbD/Aj09AH3SmSHktMh6WDaDwef8m7kTTVgdzfbSgPTFXxNYsBu0gFwbdHla+7n/TvHTPGpl9psYPIkePFNt92YcxqjnX2869hs3/0uX0XWsjJMd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JgKRtUAo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kQqrnm7t; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JgKRtUAo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kQqrnm7t"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8ADA0254021C;
	Wed, 26 Feb 2025 10:24:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 26 Feb 2025 10:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740583481;
	 x=1740669881; bh=fkIyfdOggQOEGVzaEMOr3e4SSDoZ3GIwbZp5RCvdEmk=; b=
	JgKRtUAoKxHwrzBEUyEs55Aemc+5v0YOz5soFptUTTHqY2Aylm5urks4g9U0PuiV
	CkU47KHm9weylZjSIBe7doIQgP4sTwWb8niLwwVdaVPoMHEeBtVoJwUHw+xDfwPS
	ChqQHW31As5x+VmONsDmCGV3UwRkuV/WWB11rANYJgWQIBW6MGCvghCl02s5F155
	P14dq7M/rIEQ6wsmrERb7sfM+zyEN1tm2kPVKUKxmy3PDKE79V1ixWClgIR1wxK9
	BbTJjKTt86TjLIFEMFPDbjioPIRq+DLUqPsNE0+U9PWc+Ov+3x1MMihHk0+bnRnS
	emjxd2/DhCHivj4CsneBGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740583481; x=
	1740669881; bh=fkIyfdOggQOEGVzaEMOr3e4SSDoZ3GIwbZp5RCvdEmk=; b=k
	Qqrnm7tchgOXH3bV7GNgE81kuVMSpZzgqJjJa2cVbtTatyz9OKf4lYDjB11hCowm
	QCzQuduxpvk+ptGJmbkndSP/UWPszPa8Y/vBoA2DGJnL4Fuu47yLn7bPAlq0uJce
	oBnd22qWftjF800QD/4LzvehcIQVDz/d0sJkYBEbP0scWOU2UGFfdWBRqV6cGVni
	TNyfbwaT7dY8kzFB1dPTfdzuEoslRBkr5QxaFRNL74ggn+ZNlSPzBtLlpshSTi/5
	z1L6W45+ECfvKqWaJMcqyQkAZ3d8pLeS/ZYHobQND4xVcYCs2hDYhl/1wNlNL91q
	grX6zAPWz/ejO26lwXoYw==
X-ME-Sender: <xms:OTK_Z-4_afGnOwMcREvws75r2aaJPDrFbSerkMD9vkEhGd06bgTPjQ>
    <xme:OTK_Z34onvQCiaiwoGScAUXaxLcnEam-vUNKu7f7r0QfYXE3Z6gRUssRDyp9Pf40H
    AZ0nx2gNAFcAORKGQ>
X-ME-Received: <xmr:OTK_Z9fJQM-GArVG6yG-8nEyVvQnIfCTrmx5aHIF0nVxqpQV88o8FFgrjeQK1VulaT0_hZPaHUhv-Sh8iJEpCi2VQYi4wMtyYgXFoqZurXctsSa3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvedvveeuveetleffteeltdevteehgfdukeevleei
    udevvdejtdefhfdvkeffjeetnecuffhomhgrihhnpehrvghflhhoghdqvgigphhirhgvrd
    gruhhtohdpihhntghrvghmvghnthgrlhdqrhgvphgrtghkrdgruhhtohdplhhoohhsvgdq
    ohgsjhgvtghtshdrrghuthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvddtvdehsehugihprdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OTK_Z7KGBD0gsCAXQ4WToaHJf_XlPr0ioNHiRBSFhdbtqz4ucnN2xw>
    <xmx:OTK_ZyIKTdBt6R4HoVblzxUbVToqVxyeENJZJtLDDCYMGUow6NUFLw>
    <xmx:OTK_Z8x4JjwcwBwqDntqcRW66IGXMz8h5gYSxMKcPWUMHvyKaaqtHQ>
    <xmx:OTK_Z2JIluO6t2BsmmnEKcY_2dLla097fBz8BUqTb_BfOTfR-KqJIA>
    <xmx:OTK_Z3HBb1ZXR9BnXMZSZh6xmLa0YWpMAHCXLMgNwmOp7oskEPLtrWC_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 10:24:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e79b4ddb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 15:24:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 16:24:31 +0100
Subject: [PATCH 6/6] builtin/maintenance: introduce "reflog-expire" task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-pks-maintenance-reflog-expire-v1-6-a1204a814952@pks.im>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
In-Reply-To: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
To: git@vger.kernel.org
Cc: Markus Gerstel <2025@uxp.de>, Junio C Hamano <gitster@pobox.com>, 
 Derrick Stolee <stolee@gmail.com>
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
2.48.1.741.g8a9f3a5cdc.dirty

