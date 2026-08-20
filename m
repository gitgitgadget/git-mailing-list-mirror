Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B73D4126
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212554; cv=none; b=umOyI99PXAOShsV9QBVbT4yWtD613G3ItM/IOmv2TKeKrFO4j/v7JSQtObqOxMk3pSTMXlqduIbTdYHf9j531/r06Ta2ObvF/icZy3lFcNoSuKJMyFQXXzU/TfWMWj1bmejCojkP6nlOr+gFwGtV3M9NAClWhYb7GZXZaDyvrNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212554; c=relaxed/simple;
	bh=twmJONJ3bK2BVprrQ1f3S4g9SdikUQzON6MH+vrsy3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eqmp0NSShEkMpQNz8/HVtUQtKiL936eap4ZQj1WQ7SdTrdvymFOfTU2ApNZF9jEdfg7XzzlfWNndzRHNLunHKmFr5nM2CM+bzBYjjbIg+L1c821iycWvJ1qC4b2aumpCTHCfynpo81FMnHofY7NwqGuVKiJ6NXsW/UqrAv0L+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=emk281X+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CZfgu8NT; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="emk281X+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CZfgu8NT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C9B9DEC01E5;
	Thu, 20 Aug 2026 03:55:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 20 Aug 2026 03:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787212551;
	 x=1787298951; bh=8swb/Q1naTn8Ogq7bsQiFnDoy+bof1IvAOZx9Rdfvjo=; b=
	emk281X+RPRnMgvcRBQbA21bOmaq2FxXVXJpCmr2SnyP9MH0TF1UBT3jC2XLljpT
	gmxmlgSIzks/SsigL8bh2oXLdvvCwuFxXngjq/xVH1hUsjQBifB7lUa06slnuvHq
	d/hPb60eHmYQF5dgIzEj+MAFDj3B4UOj2PC31CAm9jcGRBrfqgIM/T3pNK3UAqea
	hlN3FyapepzFI3Pi72+OiPJQF7WEqEiKzU5kEwmqdEAar9xM4NnOgRNENG0TOOub
	auJ6D14k2FKrSBvXKXh/gfZsUfShm37u9Vozr9CAA0OX+3FqJAvcGCyxTjxT6JYr
	/EKdyq0zpcU8V1FYiZDHkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787212551; x=
	1787298951; bh=8swb/Q1naTn8Ogq7bsQiFnDoy+bof1IvAOZx9Rdfvjo=; b=C
	Zfgu8NTXE61uzTFJk1CdKj8LNydF/0QJ3xtKNy0Zp0Kc0qJxM4ljyd7iI/7lGxah
	+nwxGZRPlccbbrVHBBSTDnCTBxPUUw+MsT+6CslMNnoH8eeyYCfFtYZ7XNJf8I36
	I0K4BB4ZE29NIXsMfrQZQE83BA/zs+3rptI59KMdrPZ1L8Vj/qk+BJqxu3/6qDVY
	qJ2yTdHLJzdHMkMQ1h5Cyu0yXQGuD8Po8Sb52/e7rXeYTr/z+fPmkGNOksGxUETi
	N7f46JfQLFqQqbLzOVRE28tl8/X6Os1jm2n8yfe28AiZsZ6eHfeXUrU7vdjMUahs
	2h+W7Xhcys4vGsji4qESQ==
X-ME-Sender: <xms:B7OGanSm_dvRyxuArIkKZiIZEvmcknGtMLazMiUsVw99JRK7BBJOdw>
    <xme:B7OGavzXqvz7FBZNU5Kmkh_lsIY_4LSXj1oV7zXzOlhMe-7cgz8y0sATQFgeKsQc-
    N47CuyI_uy5rIUefb2AHojh7ODyCD4AgPXN-cdelngdioTHZWqmZRQ>
X-ME-Received: <xmr:B7OGah1sBCUTFLsrJGyd2bHTDaizk72hUrUMmnrZ3x3qGIipDRyYTsYHfEbOWc1e-N_5UPsTYwzZ6tQ-812vvS30cDfJ6ZxUtAKdkX39Zw>
X-ME-Proxy-Cause: dmFkZTFf6dj8/8V1XaAc7B1kVMFZTKvMbAEygAXbbhBXRMoJE0Q/MsehWCz6Zsr3VItoGJ
    sSOYPjnsDlfrh3lzEARCv0NJnfuJQJusLASMKcwM9uC/Tbs/YIBauNX4V2AuW+yb3o66jM
    JzMl+gjCx01/1zMiYhH+kC59/ghsfTubikmfaAxgUR/millS0tlPNpkYgp4jFToJY+LVEk
    c6s4D4aztX2xzEJ3LDQqGoLTd3S6W+Hcma/glCPpKbDpT9Cmp60wceni6gyM3ckjl3Tvge
    oRcfTlFV6iALm7ps8/b3emKy+rfSopq+d7NQ4EYMi/B5tNUxYa1zjgIENCda7YAb8HlkfU
    EpwLC2mZ/d8dGKoAiKwW0JQpIMikkK943+Frt02JlL+6FNSaf2Lnw5V/HSyucceZP17gn9
    HrAVDNyGr0BabmYQC58LcHP8iBy26w59phZXpNk8IDRBAszVVTg3fx6TncBcoLTnHaE/Fu
    7xoKpAFnz3C4OSQPNpQ0kPVJ56TE1Oik5TGpxLv6COkEZM9/gCJeeYF/24HiELVMqwH8G+
    Pu6tWe9oZ5dwlBJVFkyOwMFGHhpXv6UoVV5PD+r/bQYFkwY8zok4VWF9SupNHCw6qBlKXp
    VCzKGe5jMF4gWVnqYoINynBXjSHvok+7lWEpADsklp6XqCihdZ3DwbHUvuXw
X-ME-Proxy: <xmx:B7OGal4k4GWWmP3vR9NFQ7_RGi6srAacyLv_sFlxOgC-q6s4rfUOTw>
    <xmx:B7OGasUlBXnUNaXgY3ry8jFeeD7a0hR9KlD5_I7zpq5Z7PY7PfuJ6g>
    <xmx:B7OGasBgUh0nVku6MxeWRUC2X8ycDsT2HZL9fBuAn4KeW2BggUGh8w>
    <xmx:B7OGaj7F6reyH2GBGqkehYy0nZIJgOvfqIt-0mVzBonc2cDD85xvmQ>
    <xmx:B7OGapX4nzABJgVGfXWaAHwtqciuqShuqquZE7zmKjCJfjlQ3yHD8Lw9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 03:55:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5c389e96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 07:55:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Aug 2026 09:55:30 +0200
Subject: [PATCH v3 6/6] bundle: generate packfiles via the object database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-b4-pks-odb-generate-pack-v3-6-bc42252f6169@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
In-Reply-To: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

git-bundle(1) spawns git-pack-objects(1) directly to generate the pack
data that gets appended to the bundle header. While bundles are not
part of the wire protocol, they are a transfer mechanism for packs all
the same, so convert them to use the pack generation interface of the
object database as well.

This makes the pack generator the single spawn point for all pack
streams that leave the repository, leaving only local maintenance tasks
like git-repack(1) with direct knowledge of git-pack-objects(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bundle.c | 10 +-------
 bundle.c         | 69 ++++++++++++++++++++++++++++----------------------------
 bundle.h         |  3 +--
 3 files changed, 37 insertions(+), 45 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index bfafadc984..de86e092a6 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -69,7 +69,6 @@ static int parse_options_cmd_bundle(int argc,
 
 static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
 			     struct repository *repo UNUSED) {
-	struct strvec pack_opts = STRVEC_INIT;
 	int progress = isatty(STDERR_FILENO);
 	int version = -1;
 	struct option options[] = {
@@ -92,16 +91,9 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
 			builtin_bundle_create_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
-	if (progress)
-		strvec_push(&pack_opts, "--progress");
-	else
-		strvec_push(&pack_opts, "--quiet");
-	strvec_push(&pack_opts, "--all-progress-implied");
-
 	if (!startup_info->have_repository)
 		die(_("Need a repository to create a bundle."));
-	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
-	strvec_clear(&pack_opts);
+	ret = !!create_bundle(the_repository, bundle_file, argc, argv, version, progress);
 	free(bundle_file);
 	return ret;
 }
diff --git a/bundle.c b/bundle.c
index a9330bf0d3..f55a521b2a 100644
--- a/bundle.c
+++ b/bundle.c
@@ -332,51 +332,52 @@ static int is_tag_in_date_range(struct repository *repo,
 
 
 /* Write the pack data to bundle_fd */
-static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *pack_options)
+static int write_pack_data(int bundle_fd, struct rev_info *revs, int progress)
 {
-	struct child_process pack_objects = CHILD_PROCESS_INIT;
+	struct odb_generate_pack_options opts = ODB_GENERATE_PACK_OPTIONS_INIT;
+	struct odb_pack_generator *generator;
+	int ret = 0;
 	int i;
 
-	strvec_pushl(&pack_objects.args,
-		     "pack-objects",
-		     "--stdout", "--thin", "--delta-base-offset",
-		     NULL);
-	strvec_pushv(&pack_objects.args, pack_options->v);
+	opts.thin = 1;
+	opts.ofs_delta = 1;
+	if (progress)
+		opts.progress = ODB_GENERATE_PACK_PROGRESS_VERBOSE;
 	if (revs->filter.choice)
-		strvec_pushf(&pack_objects.args, "--filter=%s",
-			     list_objects_filter_spec(&revs->filter));
-	pack_objects.in = -1;
-	pack_objects.out = bundle_fd;
-	pack_objects.git_cmd = 1;
+		opts.filter_spec = list_objects_filter_spec(&revs->filter);
 
 	/*
-	 * start_command() will close our descriptor if it's >1. Duplicate it
-	 * to avoid surprising the caller.
+	 * The pack generator will consume our descriptor if it's >1.
+	 * Duplicate it to avoid surprising the caller.
 	 */
-	if (pack_objects.out > 1) {
-		pack_objects.out = dup(pack_objects.out);
-		if (pack_objects.out < 0) {
-			error_errno(_("unable to dup bundle descriptor"));
-			child_process_clear(&pack_objects);
-			return -1;
-		}
+	opts.pack_fd = bundle_fd;
+	if (opts.pack_fd > 1) {
+		opts.pack_fd = dup(bundle_fd);
+		if (opts.pack_fd < 0)
+			return error_errno(_("unable to dup bundle descriptor"));
 	}
 
-	if (start_command(&pack_objects))
-		return error(_("Could not spawn pack-objects"));
-
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object *object = revs->pending.objects[i].item;
 		if (object->flags & UNINTERESTING)
-			write_or_die(pack_objects.in, "^", 1);
-		write_or_die(pack_objects.in, oid_to_hex(&object->oid),
-			     revs->repo->hash_algo->hexsz);
-		write_or_die(pack_objects.in, "\n", 1);
+			oid_array_append(&opts.haves, &object->oid);
+		else
+			oid_array_append(&opts.wants, &object->oid);
 	}
-	close(pack_objects.in);
-	if (finish_command(&pack_objects))
-		return error(_("pack-objects died"));
-	return 0;
+
+	if (odb_generate_pack(revs->repo->objects, &generator, &opts)) {
+		ret = error(_("Could not spawn pack-objects"));
+		goto out;
+	}
+
+	if (odb_pack_generator_finish(generator)) {
+		ret = error(_("pack-objects died"));
+		goto out;
+	}
+
+out:
+	odb_generate_pack_options_release(&opts);
+	return ret;
 }
 
 /*
@@ -485,7 +486,7 @@ static void write_bundle_prerequisites(struct commit *commit, void *data)
 }
 
 int create_bundle(struct repository *r, const char *path,
-		  int argc, const char **argv, struct strvec *pack_options, int version)
+		  int argc, const char **argv, int version, int progress)
 {
 	struct lock_file lock = LOCK_INIT;
 	int bundle_fd = -1;
@@ -594,7 +595,7 @@ int create_bundle(struct repository *r, const char *path,
 	}
 
 	/* write pack */
-	if (write_pack_data(bundle_fd, &revs_copy, pack_options)) {
+	if (write_pack_data(bundle_fd, &revs_copy, progress)) {
 		ret = -1;
 		goto out;
 	}
diff --git a/bundle.h b/bundle.h
index d664b2f2d6..471da23d1b 100644
--- a/bundle.h
+++ b/bundle.h
@@ -27,8 +27,7 @@ int read_bundle_header(const char *path, struct bundle_header *header);
 int read_bundle_header_fd(int fd, struct bundle_header *header,
 			  const char *report_path);
 int create_bundle(struct repository *r, const char *path,
-		  int argc, const char **argv, struct strvec *pack_options,
-		  int version);
+		  int argc, const char **argv, int version, int progress);
 
 enum verify_bundle_flags {
 	VERIFY_BUNDLE_VERBOSE = (1 << 0),

-- 
2.55.0.822.g20453c30eb.dirty

