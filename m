Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCD043B484
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701701; cv=none; b=f5HJ8/blYDMcz5TRYqWWD1WTxxJiOd8y/WWNll8GwoziFP/FMG2uqNuBQeXHVaIKu+pj/yK87rsFLhDuiSJpcp3wewZfLup7sjuZCeZs6IhiA9hJtJAa1AgJTxylbT16oJfjkFgrIAuGXgT73cYaCvqjzPYekqfP2988Lnr8rRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701701; c=relaxed/simple;
	bh=QcOgyY4H6bldKVYsT1VJv9DlmAj5JgvpGs2D1+lwCzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvK5MuS4bUci/CaYpKCcJuNWQAAqavSrqLKiaVm22GMbF0hZT0VTVe82u/8Z7XAeAGTRir+smXITvl0cEbZr/iZ6WGjG0P6kOTJAI7d0IXz054xe1r1qw4gz5oVL3k7wfrEJXu5ZE9XgJ2sy/Is83yE/PFaGgUCTCo6O/VITjGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qo1DNazo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qo1DNazo"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso9138345e9.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701698; x=1784306498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BGhD57xwUgjscRN8Qmzjbu6VVG0b3sQWcOgA13cfSso=;
        b=qo1DNazoebEK4Evk1cHs/tdy2wndjJpENZjSfRurLC9lusWq/S3xTe1D5Dndu8k8JD
         L5eqo6JOcbetdTBxr24OjDYXQJeEiaDiAkRFJ+L4VHIES5/a0aG1/JsWfaonJ/uA2arE
         JnY4htRKQe468Jzckw6v+SuDRki5yf5zjk1xH97QJhVutRhQtfuDsu2bxA6RMDGT83Wz
         6NxhSFmw7We8PbFRpAf3IRaJ3Gm90IpBxk51rWxMYZItmJWH1fL/YUEVwyZx46rfSSs+
         624h9ClrBR1xhhoVtC3yn7vr14BDz9GscM7ayH9oXP8Lc6q9Oaie+gKuhZAwiV4G70QC
         h4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701698; x=1784306498;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BGhD57xwUgjscRN8Qmzjbu6VVG0b3sQWcOgA13cfSso=;
        b=grf/IefmR2BkyEQsji98KoSxb6LsRTPs8wOtkvv6vYGg8lq/GdHuG7/QZrNkEWBwRo
         zHPqM3110b11Mv2Q/+ZBSNkdJWWD3BeYTnf3O4r8fArFyKiZmI1aZMHN7KcFD0o+NUBQ
         9t9y2qiJuNOZk6VeyfvsjjzlkRMhXEgFHCA11CviZWHtqclAIQ3BzDb+r+92qClzORMD
         MsZJYKZQwxHNDYD2fqCGd1PYLJs2FE+zw4C8M6sB8q+O57sAvYh7MDCshf4P2cnADIuD
         17Af3DaLVQxjPpyDT0dZt4039+ccseLzJXfXswIOAtX7/0jR5Ul76JCwgfI++35Zn1Tm
         qNrw==
X-Gm-Message-State: AOJu0YxKFg3PoK89p8OogbFXCO7Q1Llic6KtgZDPxwGTlbIi4SiBskPf
	aLaXviaeBLWk8atEvNlBhQiPNNJtQPmi6MYfWpfC+jFhai5QmI+Th0ic2rbVER/B
X-Gm-Gg: AfdE7cnO5ZDkUgIm8YfMYcGUwuGwjZpesPL9m3iNM+t8bCpgyws0IGKXL/MEo0W7LXf
	emaFw3fJnti2EENaaZXvyLgxXKgrawucda5bv4Mo1PVHgMOcKXu2WNirPCiN3bH/cV9oD1qzi2I
	JZX4XwDTG1BI0y20C46nHLXQuNtMxhRYtb1OOBfIFWgHCKbeNRz+Updx9yXMR+YvVR6iiNYqBHK
	SZv751wne1KJ/ZnHC98mb0D1OlRazWaxcA8Cv0jrcLm0fiSL9T23gnsuG2adEt/Lp4SnjXjfLcS
	kMbJtAH6WK1Y4JLFCZjVfxvox+/h0TwEUvmAqyUiEeeQtLJrPLzBmTeRoyJzHkDI6hN8khgvEm0
	eQrhXgTZ5RK/avXgQGGDHAMpaVLI28cd4hiDas3Q17LixLDqcjnysnOdviKWPpSF/ZCN+ncS/Xy
	CIrV3OJCw/kutQ+AQnByv1ZXPABZdLgPhk7Ht2ogIj4KlxxC0imCkqlyorSA9yOCTbFJImR6NhM
	v5vcXPM5CYcp+twf1cgtZCWM9EwR/HSYPUGTdiuRUZikgKA3RV2idzSqgjwmu22ZYv1mCROEjBy
	GhQ+UUx7qozO9ETqhxDWd2tIeEBemYCvyMq4jtWWwywcnph8vnFDOkUA4Zdhs5JhWbG+02GwESy
	dJlhZX1UWtQ==
X-Received: by 2002:a05:600c:8486:b0:493:e365:7630 with SMTP id 5b1f17b1804b1-493e6844d66mr157537695e9.14.1783701697314;
        Fri, 10 Jul 2026 09:41:37 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm63643639f8f.2.2026.07.10.09.41.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 09:41:36 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v16 12/13] cat-file: validate remote atoms with an allow-list
Date: Fri, 10 Jul 2026 18:41:18 +0200
Message-ID: <20260710-ps-eric-work-rebase-v16-12-66e07b58a8fe@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
References: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
 <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

strstr() is not enough to validate the format placeholders in
remote-object-info causing two errors:

1. Atoms recognized by expand_atom() but the remote doesn't returns 1,
   but data->type contains garbage causing segfault.

2. expand_atom() returns 0 for unknown atoms, calling
   strbuf_expand_bad_format() which ends up dying, blocking local
   queries if the same format is shared.

Add an allow-list with the supported atoms at the top of expand_atom().
In remote mode, unsupported atoms return 1 leaving the buffer empty,
honoring how for-each-ref handles known but inapplicable atoms.

As extra safety, initialize data->type to OBJ_BAD and add a NULL check
for type_name() so uninitialized data doesn't cause segfault.

Update tests that expect previous die() behavior to expect an empty
string and add an explicit test for empty string return on unknown
placeholder.

Update cat-file command documentation regarding remote-object-info.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/git-cat-file.adoc        |  2 +-
 builtin/cat-file.c                     | 41 +++++++++++++++++++++++++++-------
 t/t1017-cat-file-remote-object-info.sh | 27 ++++++++++++++++++----
 3 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index a7fa6674c3..643eac9245 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -451,7 +451,7 @@ CAVEATS
 
 Note that since only `%(objectname)` and `%(objectsize)` are currently
 supported by the `remote-object-info` command. Using any other placeholder in
-the format string will raise an error.
+the format string will return an empty string in its position.
 
 Note that the sizes of objects on disk are reported accurately, but care
 should be taken in drawing conclusions about which refs or objects are
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 77ecccdda3..af388b6238 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -333,8 +333,18 @@ struct expand_data {
 	 * optimized out.
 	 */
 	unsigned skip_object_info : 1;
+
+	/*
+	 * Flags about when an object info is being fetched from remote.
+	 */
+	unsigned is_remote:1;
+};
+#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD }
+
+static const char *remote_object_info_atoms[] = {
+	"objectname",
+	"objectsize",
 };
-#define EXPAND_DATA_INIT  { .mode = S_IFINVALID }
 
 static int is_atom(const char *atom, const char *s, int slen)
 {
@@ -345,14 +355,31 @@ static int is_atom(const char *atom, const char *s, int slen)
 static int expand_atom(struct strbuf *sb, const char *atom, int len,
 		       struct expand_data *data)
 {
+	if (data->is_remote) {
+		size_t i, allowed_nr = ARRAY_SIZE(remote_object_info_atoms);
+		for (i = 0; i < allowed_nr; i++)
+			if (is_atom(remote_object_info_atoms[i], atom, len))
+				break;
+
+		/*
+		 * On remote, skip unsupported atoms returning an empty sb,
+		 * honoring how for-each-ref handles known but inapplicable
+		 * atoms (e.g. %(tagger)).
+		 */
+		if (i == allowed_nr)
+			return 1;
+	}
+
 	if (is_atom("objectname", atom, len)) {
 		if (!data->mark_query)
 			strbuf_add_oid_hex(sb, &data->oid);
 	} else if (is_atom("objecttype", atom, len)) {
-		if (data->mark_query)
+		if (data->mark_query) {
 			data->info.typep = &data->type;
-		else
-			strbuf_addstr(sb, type_name(data->type));
+		} else {
+			const char *t = type_name(data->type);
+			strbuf_addstr(sb, t ? t : "");
+		}
 	} else if (is_atom("objectsize", atom, len)) {
 		if (data->mark_query)
 			data->info.sizep = &data->size;
@@ -709,10 +736,6 @@ static int get_remote_info(struct batch_options *opt,
 	CALLOC_ARRAY(*remote_object_info, object_info_oids->nr);
 	gtransport->smart_options->object_info_oids = object_info_oids;
 
-	/* 'objectsize' is the only option currently supported */
-	if (!strstr(opt->format, "%(objectsize)"))
-		die(_("%s is currently not supported with remote-object-info"), opt->format);
-
 	string_list_append(&object_info_options, "size");
 
 	if (object_info_options.nr > 0) {
@@ -842,7 +865,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 			 */
 			data->size = *remote_object_info[i].sizep;
 			opt->batch_mode = BATCH_MODE_INFO;
+			data->is_remote = 1;
 			batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
+			data->is_remote = 0;
 		} else {
 			report_object_status(opt, oid_to_hex(&data->oid), &data->oid, "missing");
 		}
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index 49b6660934..6bc863c391 100755
--- a/t/t1017-cat-file-remote-object-info.sh
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -236,6 +236,21 @@ test_expect_success 'remote-object-info does not die on missing oid like info' '
 	)
 '
 
+# This tests depends on %(objecttype) not being supported yet, once supported
+# it needs to be updated.
+test_expect_success 'unsupported placeholder on remote returns empty string' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		echo "" >expect &&
+		git cat-file --batch-command="%(objecttype)" >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
 # Test --batch-command remote-object-info with 'git://' and
 # transfer.advertiseobjectinfo set to false, i.e. server does not have object-info capability
 test_expect_success 'batch-command remote-object-info git:// fails when transfer.advertiseobjectinfo=false' '
@@ -575,10 +590,12 @@ test_expect_success 'remote-object-info fails on unsupported filter option (obje
 		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 
-		test_must_fail git cat-file --batch-command="%(objectsize:disk)" 2>err <<-EOF &&
+		echo "$hello_oid " >expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize:disk)" >actual <<-EOF &&
 		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
 		EOF
-		test_grep "%(objectsize:disk) is currently not supported with remote-object-info" err
+		test_cmp expect actual
 	)
 '
 
@@ -587,10 +604,12 @@ test_expect_success 'remote-object-info fails on unsupported filter option (delt
 		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 
-		test_must_fail git cat-file --batch-command="%(deltabase)" 2>err <<-EOF &&
+		echo "" >expect &&
+
+		git cat-file --batch-command="%(deltabase)" >actual <<-EOF &&
 		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
 		EOF
-		test_grep "%(deltabase) is currently not supported with remote-object-info" err
+		test_cmp expect actual
 	)
 '
 

-- 
2.54.0
