Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7113E171F
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389637; cv=none; b=AnJ9S1lqZTy4RFpgJe+0HB1aGtHgz14kENlbSZon8tIf5aCOK2n9rFZXTymAAU54Rs2lFAXMKVSpbdeeKBMcHEYjYnv+dgCIAGJoeX8wpqsS8bFO9PkA+Qivhpa9olH8pTweAVjA5/OBl1eqvkpMobjRhgneupIshIczLS800fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389637; c=relaxed/simple;
	bh=ivA5Tu/9M00eXP9CDW83D6uCkw2wPIK5ByM22XgvWAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCH4Zy5zCvXKQ9b/I5zuJDTZyrJ4oAuFYyDoI3nLd9zWtZTBVBRSL+07T/XtCxvP1nwJIEI2KI2V0ruzIJutM1z0Pd+4WCq4ebyGOTx9bGb88fCHd8gbOUVZxd6nnH4URCXHNzeoBgxmCOQ1drT2g838TN670tonkKCxGcnUgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sS8nO7St; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sS8nO7St"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b9318997so12113455e9.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389634; x=1782994434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wTuSz/2g9b+YeNvxogWZxk86Xwv1XB/3Ql9UC5BmJM=;
        b=sS8nO7StMY76PFhZ5VfuSY+wxGuRHaQgNBNXTCIsu5zKHPFSDzGdAMOwXxE8YR8zHQ
         3ss07030Zz4wT9MgGr80lQosfWZ+yK1MjVWotXmgo2sLsY+Yyild+LVlgvz6Tgb59Qi0
         1CP0xX42d8tJ34IDT9TzbcmBx7SMhG4dcn103Q5qTcIq0HRR4T2cLbFOEpRWJjOYpDL0
         lkLX+B7qWhXIb2ZjQpQw7P38cE8bp8bOVPK8L61O4s2d0c3wYeUMmX/YtIL+F5ca/O3b
         WRvyiYWZHsWRdsYm+K/pXWhqbEcrj9Wvsl5UlP5HZShXIPmM8lD7EItL5sLQsx1HXNO4
         pYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389634; x=1782994434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1wTuSz/2g9b+YeNvxogWZxk86Xwv1XB/3Ql9UC5BmJM=;
        b=MRupQhnMVtWFsOAabUm/FX24hakwHYJErEKVuBp52g19AlPAVdquLjcxp3O1fQMG1a
         sD4ANeo5DhvRToF1uK3DcVE/Lc2nrFdIHtFbAw3kMFh4IKiH0BZm8v7l3QshoEsIDbff
         clblEajTV5hme+DOiB/ZQ4au24VM6gG7KTrmXN9HGDyW+PUzTzERt6de9dsx/gFevt1p
         kgNYMdLADDma5xZ4hS1reJtLVKPZOhZ27Bifsh8K559IhuMSd+j+aPFxkRl2pPll7zOO
         B4d3kv8hvk1YJS/UCrXQpBBvLzlkpk02NFsqB4UYrIXt4Dq1kunV1kMfmW0e6O92urTa
         D8QA==
X-Gm-Message-State: AOJu0Yx+EDXyfFlKyBj8e+bkSLjWgtyFSpjQ211IxlUMeAmTYltFm2rk
	+XkU15j5sGq+kM75K/oaxbFKGpkU9sjlxaZJXDEb0WD1B+7g+agtZ/e8c+pO1ga7
X-Gm-Gg: AfdE7cl7WDmwwgExkYWO1JQDbDcSDWRwV7CxDuuV1c8Ungg6vUtx0R2ys2ul+7wwEUN
	cZlHP3N33c48W/9WJRJor/mAwQ7oIgnWwLROFkdoQWpNBlmw1KUKXDb54SU8jUUYpwb9WBIbJ3v
	dYqv17+F7emWtsbaGAHEe5jZ0Q8/0Qlr9bLBpFdFo9jCzV4Zhdct6KSbPXK+UIM5VDkjpsqwmcE
	quebUXiWCynjFBaPcnCoo/YnL0zvxVpG/8sLTSyL0iiPJyNZNlukf15pknR1d7lmre2d6v4hbiX
	Ihv5ie+UtKg6maoqiQ9khy6f5ZDAyNULAuow5xEV8YVtO/PoSBLFiBJrUiljZNnGuiZeMWVDb0X
	Ob8IQ6visVBN2Syf7khJriwNjVcTG2TZXEq4HEh0ECQbHB7Sr5ziELMIrC121E+gtV8pAQp9wyT
	dgasZaoNfVjX3dfWwCJBV+PBp5ExHU5x16mz1Se+h8kredvd9xhcRKy08W9785ndZVC2qLTPkb9
	4B4B+6+eCg0zgJhWv2mLqY2QVHpPS+RXpYuTCyYjLwSbfCmbLCWn7EAjNINktxPfQe2Y30t7w8d
	jVbluENPtKg28YuzBis03JWLL6Z5cdHIOIeELIn7Vm36A+btq7uOw+rwy08QKX3P//yz9bi7Mjs
	8oj9PiNizDQ==
X-Received: by 2002:a05:600d:84ca:20b0:492:3fb1:e9b8 with SMTP id 5b1f17b1804b1-4926685bdb6mr22697875e9.12.1782389634049;
        Thu, 25 Jun 2026 05:13:54 -0700 (PDT)
Received: from localhost.localdomain (62.174.236.137.static.user.ono.com. [62.174.236.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660adaecsm62207245e9.5.2026.06.25.05.13.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 05:13:53 -0700 (PDT)
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
Subject: [PATCH GSoC v14 12/13] cat-file: validate remote atoms with allow_list
Date: Thu, 25 Jun 2026 14:13:34 +0200
Message-ID: <20260625-ps-eric-work-rebase-v14-12-09f7ffe21a53@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
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

- Atoms recognized by expand_atom() but the remote doesn't returns 1, but
  data->type contains garbage causing segfault.
- expand_atom() returns 0 for unknown atoms, calling
  strbuf_expand_bad_format() which ends in die() blocking local queries
  if the same format is shared.

Add an allow_list with the supported atoms at the top of expand_atom().
In remote mode, unsupported atoms return 1 leaving the sb empty,
honoring how for-each-ref handles known but inapplicable atoms.

As extra safety, initialize data->type to OBJ_BAD and add a NULL check
for type_name() so uninitialized data doesn't cause segfault.

Update tests that expect previous die() behaviour to expect an empty
string and add an explicit test for empty string return on unknown
placeholder.

Update caveat behaviour documentation.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/git-cat-file.adoc        |  5 +++--
 builtin/cat-file.c                     | 41 +++++++++++++++++++++++++++-------
 t/t1017-cat-file-remote-object-info.sh | 27 ++++++++++++++++++----
 3 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index aba20eb770..3b7a85b383 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -451,8 +451,9 @@ CAVEATS
 -------
 
 Note that since %(objecttype), %(objectsize:disk) and %(deltabase) are
-currently not supported by the `remote-object-info` command, we will raise
-an error and exit when they appear in the format string.
+currently not supported by the `remote-object-info` command, they will
+return an empty string for remote queries, matching how `for-each-ref`
+behaves for known but inapplicable placeholders.
 
 Note that the sizes of objects on disk are reported accurately, but care
 should be taken in drawing conclusions about which refs or objects are
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 49bd62ba3f..ea3869f3ed 100644
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
@@ -707,10 +734,6 @@ static int get_remote_info(struct batch_options *opt,
 	gtransport->smart_options->object_info = 1;
 	gtransport->smart_options->object_info_oids = object_info_oids;
 
-	/* 'objectsize' is the only option currently supported */
-	if (!strstr(opt->format, "%(objectsize)"))
-		die(_("%s is currently not supported with remote-object-info"), opt->format);
-
 	string_list_append(&object_info_options, "size");
 
 	if (object_info_options.nr > 0) {
@@ -840,7 +863,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
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
index b744e81701..9d8f114b72 100755
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
