Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40883CF203
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029532; cv=none; b=LbGn1EeSj0a3Hpg2xaM5pVYfu+k4bBtIy77oHoPy17pp5Z+jwp8UUkE29oanAoISg3u4qmldhOLvA7ybDKNn+9g8OhsyKsaFwECtYTbzGpOBVQqscnwBf25CNbt62QKANzhVY9Mt7u49w2JS2z22P0y1OaaTf3oLphOb6tQkQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029532; c=relaxed/simple;
	bh=QcOgyY4H6bldKVYsT1VJv9DlmAj5JgvpGs2D1+lwCzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsqYv/1O7wB/6K0NNeDWYoScwwwgpkZa7aPwqZ7Gr5/IjwpGRJp41Gncbb9Hig/7gnpudLc9lPGsNBFxwvTPVXOLYPG4VVXSnWbeKu4wfKvxSojfxBecF7Wa+4W5JUQvH9vLRJiVIZ5gv4Q22l+BoM6Q9sb4C+ywFpn6KJf+p5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzcZxND2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzcZxND2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so22823015e9.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029528; x=1784634328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BGhD57xwUgjscRN8Qmzjbu6VVG0b3sQWcOgA13cfSso=;
        b=MzcZxND2URaQCcVU7h8XYbz4Jxdnxf2ala66mCz/K0Z3nMKajy/tE/6cetYq7rcwf4
         k5Za9gI7pAGwf3pk6J7V/QRH05apwhVMh9IcoBz3eMi058IloqIxZFZab+8v8+Z7DV6H
         RTHMyOO7dSznBUbmcO9i9sKRHsWYsux0BMCHGZagu2HHsmLRhpFefORCK/xbLHsBDZmW
         0PYaKbYwZVDb+mOMAzjjh1gGeGdrWitK0OM0eWbKcLaQ0dQhbCoqrrp69E2O1tHH7/Jl
         38oxGyiuvsSkorCf4w3mv6TE5PnVyYUlh59LzAIosTsovyV7U3wZfVLJcXTJyI1vv8W7
         m3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029528; x=1784634328;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BGhD57xwUgjscRN8Qmzjbu6VVG0b3sQWcOgA13cfSso=;
        b=XHG0j4B6M+Viqg+kBdyJ4XAepcM5o/pqO3F8HXCtwLgK1bxzyVzU7pHLvPvBdJLH8K
         /a16Bt5eEgLBZcJ+5CdPBEd8y95UjMAXh5f5Ags9L9v8gFfGobn122pqwsg8VJsRH8jW
         RkG8jypD/HoyIg2XHLntgPQUFJEApzdCYQYOOLrl5f/FaHxULbXfQKKRjAE22X0bUgTw
         o6EGAqilHfrTe+5a3nbOS/7MJilh4jtbP5jTRg6PrVUBcpHFdlBlko56lx1FH+52BMjP
         nEYRTAAvQsCXR065NjqBFQE6+9qxoyfKCitBKnqmV/YDbBwbmtpcjLQZTkggRiPmPkY/
         5ePg==
X-Forwarded-Encrypted: i=1; AHgh+RovFAlM/Ole23FlRxoU/FVDy315OTGAmm4EyRNw1tm0qmOyqnX9iZgN7zL94F7WiGQ2rCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXuqjSwV8UYFjmB5RKRg1dLJrHzvn0Rkl/K+WdP7/CyTWvWOkl
	vCuGAMoIDGHfYCqvrF+pFbY4naIykJCgQQn5Zk/o+zQSJQHeQpX8NAOhqJABtWlI
X-Gm-Gg: AfdE7cnwlBBrDZRs0Z/BXZvjLkK+u+k1ElukFn+wibq6626z48Xjeem+GWP46OpzXA6
	7N3RwlUO2npJOlYZztvjmpWJ4VYoT3NeogwohsjVdi5gpBIfQGKWJVejAvKz/RiEMyGU2bNCc80
	oL5uDFNSHCvK1H/qgfiUI3ZNOk6vKqquEiEgyYBNsn3CfSZkSfuO4FC2vCpd1tPe4ou0XW4DGir
	WikDD4r8ipzlH4Cj9MY7C1mHXsEogILLw0eJDgtSxdBxsApl97KVptdB9znUiMMOkI0WYNVdFXF
	1Qn/t89tRJfkaCI16k1+bTNHywEup+CsaJbVSlwrHGcdLbE2ghLo6eDmHuxRo5Wi2avT/pptHvm
	JHYA3Sgnd3TrYf5moLcLqFOP6H8hXNK6X2U2FfUWUtgJw0Qp79yQF5isgJ7gn622PxVCYG7PkoY
	Hi2+h3fuL7eVRYBPf2/J6WgxOxDlX+7xbZ4shqfawQ4CX8R2PQ8I3TdQEgG0rvsimPqzuB74afX
	UladxgCmkAL0bLryDVIsI2Zgib0dtL6K5TdJKlxJqk41LzMjPhpD9BaE8Zqzey6+OCWvcc4+EhP
	hfeJGqxT6glYlSy8H1coZFCx1wMFm4Z6KAt9YSsUgeBvxNkDETpxNWt7Ivm7XjnFb4+486Rh/OM
	w+l1rZIF1zP0IRWYlWN4R
X-Received: by 2002:a05:600c:8289:b0:493:c84c:2b57 with SMTP id 5b1f17b1804b1-493f882e13bmr120860945e9.29.1784029527929;
        Tue, 14 Jul 2026 04:45:27 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm179791355e9.2.2026.07.14.04.45.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 04:45:27 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v17 12/13] cat-file: validate remote atoms with an allow-list
Date: Tue, 14 Jul 2026 13:45:08 +0200
Message-ID: <20260714-ps-eric-work-rebase-v17-12-afabfc83260e@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
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
