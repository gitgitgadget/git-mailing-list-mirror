Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE174C433E5
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D7F2083B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dit74pY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgG3WYw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgG3WYt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F35C061575
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p14so7023731wmg.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/R5LWWXKMmJRdlNwqXfPKs3HG+n52TuWAZYKO2N8KvA=;
        b=dit74pY4t+qxUdyx6M/ZLbReeNW8q1UjjHRHM5+06QMmiEYNiprxmQElBJXR6AXJ8Z
         yOvTL+/pQ9RDFx0R5aB6kqQOomteGY+oYCVLN9GE8Z0Cs1IRbFfBlyqz5r4YA1UEs/mU
         jRKZApj43pFHkztAU8Xu4PtvlYJXPmPYuTGBb/qEXnVJhAjptmk3R2hV/a++SyFYSqLp
         FFRxPn1WlfjBjPmlH1+FRGdw6qUKsEcAKvtIoRfiE0oTMmx9DYA2EvvIfSq1s9fvIe5v
         xKBjzFHt8b7MrYOOLFx1k3wVKEP+d9q0eX6GRW5xqCg70rhxd7d8RcS9bLEYVR8AL6R8
         24XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/R5LWWXKMmJRdlNwqXfPKs3HG+n52TuWAZYKO2N8KvA=;
        b=G03D4szn1VSXCtOQ4QRdkeWf+o8HhMzcXxglmd8gjCAEN7TY5IaiXDBW7jkjU6cZ8r
         6Pi1lBZo2BUyxWUxplYkgKmidFGQZbCfTBtHHPWOyJu6+xp9Fb1gQb46IspReN5nFAb7
         Xn5mAP0AOBKIzX2cGLJeUUZIt+3XGIIbT7zk4XszNMmQXL3uGHlTd3lXSDYu54Aor3GS
         ISEHrSii65PNVpS4k9yK2Daw9X1J30li9hjaPTrkd8g0v68A34NweiqG9UL2jfVNgxKp
         1R4x6UNpCf9bapMc5zlkkvnUScl/5hlfy6XE6FpW4WKxY0UozX+sfkPoXRm40/FIw//2
         ynwQ==
X-Gm-Message-State: AOAM532aLG4bxAB65MrSMbbBMTqydhZI2f5iVWIj33g/6R2OXbPT5OWt
        f5M1Bz7CG2sgUQnWSAgPaPnyun9v
X-Google-Smtp-Source: ABdhPJxu7//6q3j6cv4sSMdh/UdYZSMtpCs574sZN2bFxZv7qn9DcO0+onOJj4MU1bNGFDnMD9OzRA==
X-Received: by 2002:a1c:b7c2:: with SMTP id h185mr1221009wmf.168.1596147887319;
        Thu, 30 Jul 2020 15:24:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm11328819wrm.52.2020.07.30.15.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:46 -0700 (PDT)
Message-Id: <0128fdfd1ab286ea27437bfe93a9dbb532444277.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:16 +0000
Subject: [PATCH v3 10/20] maintenance: add loose-objects task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

One goal of background maintenance jobs is to allow a user to
disable auto-gc (gc.auto=0) but keep their repository in a clean
state. Without any cleanup, loose objects will clutter the object
database and slow operations. In addition, the loose objects will
take up extra space because they are not stored with deltas against
similar objects.

Create a 'loose-objects' task for the 'git maintenance run' command.
This helps clean up loose objects without disrupting concurrent Git
commands using the following sequence of events:

1. Run 'git prune-packed' to delete any loose objects that exist
   in a pack-file. Concurrent commands will prefer the packed
   version of the object to the loose version. (Of course, there
   are exceptions for commands that specifically care about the
   location of an object. These are rare for a user to run on
   purpose, and we hope a user that has selected background
   maintenance will not be trying to do foreground maintenance.)

2. Run 'git pack-objects' on a batch of loose objects. These
   objects are grouped by scanning the loose object directories in
   lexicographic order until listing all loose objects -or-
   reaching 50,000 objects. This is more than enough if the loose
   objects are created only by a user doing normal development.
   We noticed users with _millions_ of loose objects because VFS
   for Git downloads blobs on-demand when a file read operation
   requires populating a virtual file. This has potential of
   happening in partial clones if someone runs 'git grep' or
   otherwise evades the batch-download feature for requesting
   promisor objects.

This step is based on a similar step in Scalar [1] and VFS for Git.
[1] https://github.com/microsoft/scalar/blob/master/Scalar.Common/Maintenance/LooseObjectsStep.cs

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt | 11 ++++
 builtin/gc.c                      | 97 +++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            | 39 +++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index d134192fa8..077929b691 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -76,6 +76,17 @@ gc::
 	It can also be disruptive in some situations, as it deletes stale
 	data.
 
+loose-objects::
+	The `loose-objects` job cleans up loose objects and places them into
+	pack-files. In order to prevent race conditions with concurrent Git
+	commands, it follows a two-step process. First, it deletes any loose
+	objects that already exist in a pack-file; concurrent Git processes
+	will examine the pack-file for the object data instead of the loose
+	object. Second, it creates a new pack-file (starting with "loose-")
+	containing a batch of loose objects. The batch size is limited to 50
+	thousand objects to prevent the job from taking too long on a
+	repository with many loose objects.
+
 OPTIONS
 -------
 --auto::
diff --git a/builtin/gc.c b/builtin/gc.c
index 1f20428286..96ded73b2f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -832,6 +832,98 @@ static int maintenance_task_gc(void)
 	return run_command(&child);
 }
 
+static int prune_packed(void)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_push(&child.args, "prune-packed");
+
+	if (opts.quiet)
+		strvec_push(&child.args, "--quiet");
+
+	return !!run_command(&child);
+}
+
+struct write_loose_object_data {
+	FILE *in;
+	int count;
+	int batch_size;
+};
+
+static int bail_on_loose(const struct object_id *oid,
+			 const char *path,
+			 void *data)
+{
+	return 1;
+}
+
+static int write_loose_object_to_stdin(const struct object_id *oid,
+				       const char *path,
+				       void *data)
+{
+	struct write_loose_object_data *d = (struct write_loose_object_data *)data;
+
+	fprintf(d->in, "%s\n", oid_to_hex(oid));
+
+	return ++(d->count) > d->batch_size;
+}
+
+static int pack_loose(void)
+{
+	struct repository *r = the_repository;
+	int result = 0;
+	struct write_loose_object_data data;
+	struct child_process pack_proc = CHILD_PROCESS_INIT;
+
+	/*
+	 * Do not start pack-objects process
+	 * if there are no loose objects.
+	 */
+	if (!for_each_loose_file_in_objdir(r->objects->odb->path,
+					   bail_on_loose,
+					   NULL, NULL, NULL))
+		return 0;
+
+	pack_proc.git_cmd = 1;
+
+	strvec_push(&pack_proc.args, "pack-objects");
+	if (opts.quiet)
+		strvec_push(&pack_proc.args, "--quiet");
+	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->odb->path);
+
+	pack_proc.in = -1;
+
+	if (start_command(&pack_proc)) {
+		error(_("failed to start 'git pack-objects' process"));
+		return 1;
+	}
+
+	data.in = xfdopen(pack_proc.in, "w");
+	data.count = 0;
+	data.batch_size = 50000;
+
+	for_each_loose_file_in_objdir(r->objects->odb->path,
+				      write_loose_object_to_stdin,
+				      NULL,
+				      NULL,
+				      &data);
+
+	fclose(data.in);
+
+	if (finish_command(&pack_proc)) {
+		error(_("failed to finish 'git pack-objects' process"));
+		result = 1;
+	}
+
+	return result;
+}
+
+static int maintenance_task_loose_objects(void)
+{
+	return prune_packed() || pack_loose();
+}
+
 typedef int maintenance_task_fn(void);
 
 struct maintenance_task {
@@ -844,6 +936,7 @@ struct maintenance_task {
 
 enum maintenance_task_label {
 	TASK_PREFETCH,
+	TASK_LOOSE_OBJECTS,
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
 
@@ -856,6 +949,10 @@ static struct maintenance_task tasks[] = {
 		"prefetch",
 		maintenance_task_prefetch,
 	},
+	[TASK_LOOSE_OBJECTS] = {
+		"loose-objects",
+		maintenance_task_loose_objects,
+	},
 	[TASK_GC] = {
 		"gc",
 		maintenance_task_gc,
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 5294396a24..27a423a4f2 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -67,4 +67,43 @@ test_expect_success 'prefetch multiple remotes' '
 	git log prefetch/remote2/two
 '
 
+test_expect_success 'loose-objects task' '
+	# Repack everything so we know the state of the object dir
+	git repack -adk &&
+
+	# Hack to stop maintenance from running during "git commit"
+	echo in use >.git/objects/maintenance.lock &&
+
+	# Assuming that "git commit" creates at least one loose object
+	test_commit create-loose-object &&
+	rm .git/objects/maintenance.lock &&
+
+	ls .git/objects >obj-dir-before &&
+	test_file_not_empty obj-dir-before &&
+	ls .git/objects/pack/*.pack >packs-before &&
+	test_line_count = 1 packs-before &&
+
+	# The first run creates a pack-file
+	# but does not delete loose objects.
+	git maintenance run --task=loose-objects &&
+	ls .git/objects >obj-dir-between &&
+	test_cmp obj-dir-before obj-dir-between &&
+	ls .git/objects/pack/*.pack >packs-between &&
+	test_line_count = 2 packs-between &&
+	ls .git/objects/pack/loose-*.pack >loose-packs &&
+	test_line_count = 1 loose-packs &&
+
+	# The second run deletes loose objects
+	# but does not create a pack-file.
+	git maintenance run --task=loose-objects &&
+	ls .git/objects >obj-dir-after &&
+	cat >expect <<-\EOF &&
+	info
+	pack
+	EOF
+	test_cmp expect obj-dir-after &&
+	ls .git/objects/pack/*.pack >packs-after &&
+	test_cmp packs-between packs-after
+'
+
 test_done
-- 
gitgitgadget

