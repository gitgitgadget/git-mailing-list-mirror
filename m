Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A6480DC0
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908348; cv=none; b=cpkFyBxu5XPWRD7hvivj4vv2G1MjeU7fUzQYPx8L9PDElc1Au3vcdRbtLhj4eec1JRVc0fkHKvb6gPFKBvq3OlbufA6OlbaXpGq54MXI6XXeGuHUa9kXcGs9gE4qAxPMubyJPyw3MdwOmmLiHZRjVa9O+WnxtjFTd8nJI55pLO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908348; c=relaxed/simple;
	bh=K9Tu4ebtFOawo+Yjglf3T5N3oGqEq5vdpH6eUM+FV/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/YBjs0x9ygzxz4+Ji95NhfS6qni5P64Ry8bQGA9c2UmLICuNHtg41wiJa9aRoIXT2ySyVf7fGslW76NON0oJF/BTRuiwHVdMlzlhL5lku0SseVH/PTg+IM9onc3ilvBJ2vNnVVeLhkMuGKunFC1rBL7K1XK5f+IW+6YsMiqfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGIU9pgw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGIU9pgw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so3921265e9.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908345; x=1783513145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM25NlFMlvFGGy2VEEZPYzjQCANwWeCvxdbWGbKCBBs=;
        b=bGIU9pgwAaHKX6SaHg20/NvDPPKaBH9pOOfBGBcje/l/PsJkrPD2CqWvpA5uFV2Ttf
         cuQZPDwbR+DP13u25D7YhNrexxIvCbLnYKFkaojk5Z9WoBDCLCLl/Brp/+/jrFdZYIpx
         2i3wkyxiLtlPnedH2bFn1ib1bOJbsfa5w6PePcxbBQro3MDjVSBBfjyRnPn8LjdBT+fG
         FZqF5ynAp2FZ0DHadlM8BTEbwnLdppRviUUvDL2ROdT/PtWph+7GNm8r/I4qE9hU0pSi
         IRGAtE8zVskfk5b8F9yl6CbGaf8DPXgOilWMwhJDiQyjHJ/z30Of/uc4VhFQcCeUSt+J
         UYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908345; x=1783513145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZM25NlFMlvFGGy2VEEZPYzjQCANwWeCvxdbWGbKCBBs=;
        b=E9DrzXMSPtZ9nhuaToFoiTTNNfyG0WIEmrhsVBw1tNqu6zyhPKW3jQRUaHZ40RzcY3
         Vey7UFGVh/POLZZJjigIcTsqCJyh8gAWBMjHxxOdjlASaltDaBRoinU6p1g67eD8XqnP
         HYRI7NrGpeZt5cm92k6PRHJQ9ZA2WQCXKVoXMdpGqclq9+Y8dx/UBlKy2lqyVklcvBXm
         p69u1M7oZciAZ5EnGNg+3nV+Nv2qTA0KZl7Gfx84UF0laJLLzzNEC+eRdkYiiJgLUIs+
         L3d7dNuGE1FZYjsAJyfk4c5Nc/MuBhPXJMbvdsHlAuF3BnMdfgLI5CTe5mChTkxL5bYD
         MMng==
X-Gm-Message-State: AOJu0Yx77VoLwVmcxWRa1IjU5pzg68DfMJXADywJaY6GDzmZazZFVHqG
	mpfUgh3sOUvPRZbnTM0bP89YkE+rA93VfDVaZFAfzG2GBVD5G8HO4RyKlbDIWxzL
X-Gm-Gg: AfdE7cl36ME4zdKW163hbbDU7aZgR0yoUnPj3AwOD4dBjve+zxsohUWNZwGWSXSLHAn
	KnVxQjUI6rGEihDF+on9iW5OyV4GbbnRTglpwPZef+mQ7qGAjz2hD17q8FBpP9HUdDRRPJ3k7dw
	yBBcxT7UgsQKQ1bElTPI3WH9pzaiRiiyhNohICmFQP98KX0S584n4Lv0wKtNZ8kevmx7sbbgGnj
	azJP7NXvF38nZkiLVHyAzzg6GDgRB0X9BJ3DRlVytaIc+DOusIx65ljiT52Fdk0VNmlP9iIn8Ad
	WfwgDhfjzeplnYLD61raoJRDhu3Q8H3UTvAYj+mUThVB/7W5oh2Di/WPnCi8fBFeGgAw5w+qd3E
	Xe2NyE+XQudtoqeSweZ8UG7LLVnn6NWLjtcKSf0ZrnETeK+KRzVcUVh93INDftXsyEebZ0Rsa7P
	qPQFA8j7N+k9CnshCXb91h5xXVYw+GK62Koe67nPLwXi8mPGcOzRP4uMRLPd+36SGWx7riHCS5E
	TwtIYiqph0e+sti2GlGrEt+1AdTVpLt2TDphGcDwnhC2zaRW5v/MNZC8pEN3D5QaZecQ8QU8boN
	uZA1TJ2pYkZTF3JELAFyBHZKB96CjVABfTQzGc42DCEk+4hEHDgVD50hFY+dqiOu1e0vJ0Uq19L
	kFb1btpjCVFVUxzoo56Xw
X-Received: by 2002:a05:600c:6a96:b0:493:b750:b565 with SMTP id 5b1f17b1804b1-493c2ba9d58mr16921335e9.35.1782908345211;
        Wed, 01 Jul 2026 05:19:05 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm68267235e9.9.2026.07.01.05.19.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:19:04 -0700 (PDT)
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
Subject: [PATCH GSoC v15 12/13] cat-file: validate remote atoms with an allow-list
Date: Wed,  1 Jul 2026 14:18:46 +0200
Message-ID: <20260701-ps-eric-work-rebase-v15-12-c88a43b63917@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

`strstr()` is not enough to validate the format placeholders in
`remote-object-info` causing two errors:

1. Atoms recognized by `expand_atom()` but the remote doesn't returns 1,
   but `data->type` contains garbage causing segfault.

2. `expand_atom()` returns 0 for unknown atoms, calling
   `strbuf_expand_bad_format()` which ends up dying, blocking local
   queries if the same format is shared.

Add an allow-list with the supported atoms at the top of `expand_atom()`.
In remote mode, unsupported atoms return 1 leaving the buffer empty,
honoring how `for-each-ref` handles known but inapplicable atoms.

As extra safety, initialize `data->type` to `OBJ_BAD` and add a `NULL`
check for `type_name()` so uninitialized data doesn't cause segfault.

Update tests that expect previous `die()` behavior to expect an empty
string and add an explicit test for empty string return on unknown
placeholder.

Update cat-file command documentation regarding `remote-object-info`.

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
index eb133113c0..eb7c5ba489 100644
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
@@ -706,10 +733,6 @@ static int get_remote_info(struct batch_options *opt,
 	CALLOC_ARRAY(*remote_object_info, object_info_oids->nr);
 	gtransport->smart_options->object_info_oids = object_info_oids;
 
-	/* 'objectsize' is the only option currently supported */
-	if (!strstr(opt->format, "%(objectsize)"))
-		die(_("%s is currently not supported with remote-object-info"), opt->format);
-
 	string_list_append(&object_info_options, "size");
 
 	if (object_info_options.nr > 0) {
@@ -839,7 +862,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
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
