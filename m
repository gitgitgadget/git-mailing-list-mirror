Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EAA418A55
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768021; cv=none; b=qSxgvSvq3lz1S6gdAqshHek0esiLlTA6vstzcw9PPtUFKwuyAumXREzlMgLkfWSSCZG+VSWL2f40OZqwFQh5b4DbTLaaA54POu2agYJUoUdaw/tiVBEWoNOvO1cqgN81OQx+WCYEBeiLk0VSH0fer3jtYYyDk+NwSXotFyZBTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768021; c=relaxed/simple;
	bh=pCIKOAPItCyr9X683fu9AiRTvfGnZQ0ckBL+K4a+4rQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4YRty/CA7g5/9H4/jSe/LME2yTXbbFxCEb33FVtoFendnHiEnQPWiPiNHlkoMVK1VKxhGU6LvIDcSS6LC36Ik0LnpouHqS0i4eB9efCti9lvzg287aQtTXDCGwp2wWXXjpsAs4GTTer8JFWK/Wne5P1HkMsfIy1VGKVxgiPUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxbNYSWX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxbNYSWX"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so20150475e9.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785768018; x=1786372818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ak899zHQbVsLIOoOO3wjKXPg/mcRHMgCAHoOrzhch5k=;
        b=dxbNYSWXms239+0IsSkcHJHaFtyctjjHtLyPsxzwd3HiKzqGtRX3WriqTjDzyRC3YK
         JF55XsfRBOx9b6dsW4lSsYBGGK7r0eegUEv1zlMp8pPEzG1FkHkwZQ2fDb0RswGjH0WT
         TLGpeiuLsM5jbCw1AEgzsPc4hafunT+8cW5SZUVVxk27OK1KDBnJUVmolXbsaZ92su93
         BI7mzQ6IaC7++FxqSYjpZOYw5IROLVPrtluw3NQYveamrxwPl3rp2EzUdTQm3sMrRczT
         GmHOxEZIZjPcilM4lcYK0Pap2F6WanEADNA5xgXxe5eyEhU1PKSp+PGQCoj7yrBGEoM5
         X1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768018; x=1786372818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ak899zHQbVsLIOoOO3wjKXPg/mcRHMgCAHoOrzhch5k=;
        b=P3pnoqpeMlj9PIAUTaaDwpqZpOdIPil2ui7MHot8FKM9B4lcrpxlnzjW7gkPPb5yMj
         X96NI/+Uq8+vgLwbxwRxPcOfAiFguMwwJR2SPjo6WUEPyLEPWTZ6U9lgjsGceaweKx5G
         nRjDL0ZEZ6dKUD8jlxdj8PgYrOUpdQVyUOoiKoMGZ11GBfU9E88IzYYizJXuMqLN0v5u
         aRL2YeUuP4O73fbvOH0inIDMQwwMnQ0bKcDhnmFjm9uNs03foeOUj9yvfIR8oniIkb0u
         L+lDh2c5Mq2CaDAM8LHTAszATpGSeIU1RFeMLgfYYlfyPMsplY3fLBjI3/mNR4Oa1/4i
         EsZw==
X-Gm-Message-State: AOJu0YzOWclHo4Az/iPwd3mrQyGT9LKbe+9xotq9kmrqHqQSb0OQ9bMg
	wkO+pxD0kLQDjHAqA8mPenan9VUET2FHHVLSIPwugqBh3KYwWsUtJZWy
X-Gm-Gg: AR+sD12j/+x+vx7JLkKm00032LaNglGaR/WTmmpKGqxUBOngt0aIJ4CCoiSTlrfRo1o
	Cqf53ne/I0DZp4pPSPm7Tuy7OS5a9ajg3/2BrHT0zomXCC1rpHwrFCbHUfWpzIDp3dog56pWBLy
	IxCFfT7qspm5TcbTHAHhoTm9jRHWs/ACgReGDKrN6x2SvEEioReOiLKUtqVduyrJaBjUA/NwE7D
	kHkMmZoREXRMo/xUuOx0vEbJqhHigDsn6OWiQibCAg0qYEBbAR/Ib9jTWsStOM0CBe/2Sim+QAI
	Ra1O2zrRR57demMijBc1mwDI36JYhAsqEC2NHobrtTPna7WHkDcRiVXUyPWcYTMPXSaEx98I50c
	dHv3I9+M7kCSFLttW92xHrNDSWYC1LOxS7JpWenNrYoNjDcVBrelIdsXPKqN4DJiq5O1a6V0qnp
	x7WsDfM7wWztaoOSZMa1PGd0DnhqHOlclgufPh8AZlvbTL+x2wRvxe+/DV56/k4IRyaBmdbb+9X
	bVOzvAr/5lnVSBsdMpEjgcSgvw7EfyYmM5LUXciPSBPTC8FWSb3v3r19wjvJfFEoBPVmQt2yuLZ
	YGs9uUjUoD815zPrheIJuAJ4k16DbhvZOS6ev7jp/Bzj4vXgXiedC7J2VcTK7gAFg3nGkRSA3z2
	LGpWAtM6yR6fSiIvD0A==
X-Received: by 2002:a05:600c:46cc:b0:498:ee7:e407 with SMTP id 5b1f17b1804b1-4980ee7e5e9mr184776615e9.17.1785768017315;
        Mon, 03 Aug 2026 07:40:17 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b86d66sm106482575e9.1.2026.08.03.07.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:40:16 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Mon, 03 Aug 2026 16:39:35 +0200
Subject: [PATCH GSoC v3 8/8] cat-file: unify default format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-objecttype-support-v3-8-7176fecf7950@gmail.com>
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
In-Reply-To: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

%(objecttype) is supported both by the client and by the server.
Change the temporary default format to the unified version that the
other commands use.

Update documentation to remove %(objecttype) from the caveats of
remote-object-info and show %(objecttype) support.

Now that type is supported and the default format unified, update the
tests to expect the new default format.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/git-cat-file.adoc        | 17 +++++------
 Documentation/gitprotocol-v2.adoc      | 18 +++++++++---
 builtin/cat-file.c                     |  7 -----
 t/t1017-cat-file-remote-object-info.sh | 52 +++++++++++++++++-----------------
 4 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index ac3b528c6f..514bfc0032 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -348,15 +348,12 @@ newline. The available atoms are:
 	after that first run of whitespace (i.e., the "rest" of the
 	line) are output in place of the `%(rest)` atom.
 
-The command `remote-object-info` only supports the `%(objectname)` and
-`%(objectsize)` placeholders. See `CAVEATS` below for more information.
+The command `remote-object-info` only supports the `%(objectname)`,
+`%(objectsize)` and `%(objecttype)` placeholders. See `CAVEATS` below for more
+information.
 
 If no format is specified, the default format is `%(objectname)
-%(objecttype) %(objectsize)`, except for `remote-object-info` commands which
-use `%(objectname) %(objectsize)` because `%(objecttype)` is not supported yet.
-
-WARNING: When "%(objecttype)" is supported, the default format WILL be unified,
-so DO NOT RELY on the current default format to stay the same!!!
+%(objecttype) %(objectsize)`.
 
 If `--batch` is specified, or if `--batch-command` is used with the `contents`
 command, the object information is followed by the object contents (consisting
@@ -453,9 +450,9 @@ scripting purposes.
 CAVEATS
 -------
 
-Note that only `%(objectname)` and `%(objectsize)` are currently
-supported by the `remote-object-info` command. Using any other placeholder in
-the format string will return an empty string in its position.
+Note that only `%(objectname)`, `%(objectsize)` and `%(objecttype)` are
+currently supported by the `remote-object-info` command. Using any other
+placeholder in the format string will return an empty string in its position.
 
 Note that the sizes of objects on disk are reported accurately, but care
 should be taken in drawing conclusions about which refs or objects are
diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index 7bf62014c3..dd52fd8110 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -558,14 +558,17 @@ object-info
 
 `object-info` is the command to retrieve information about one or more objects.
 Its main purpose is to allow a client to make decisions based on this
-information without having to fully fetch objects. Object size is the only
-information that is currently supported.
+information without having to fully fetch objects. Currently only object size
+and type are supported.
 
 An `object-info` request takes the following arguments:
 
 	size
 	Requests size information to be returned for each listed object id.
 
+	type
+	Requests type information to be returned for each listed object id.
+
 	oid <oid>
 	Indicates to the server an object which the client wants to obtain
 	information for. They must be full OIDs.
@@ -580,11 +583,18 @@ space.
 	info = *PKT-LINE(attr LF)
 	       *PKT-LINE(obj-info LF)
 
-	attr = "size"
+	attr = "size" | "type"
 
 	obj-size = 1*DIGIT
 
-	obj-info = obj-id [SP [obj-size]]
+	obj-type = "blob" | "tree" | "commit" | "tag"
+
+	obj-val = obj-size | obj-type
+
+	obj-info = obj-id [SP [obj-val *(SP obj-val)]]
+
+The values in `obj-info` appear in the same order as the corresponding `attr`
+lines, with exactly one value per requested attribute.
 
 If the server does not recognize the OID, the response will be `<oid> SP`
 regardless of the number of attributes requested.
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7a3ae11a70..867079a62e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -823,15 +823,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	char *line_to_split;
 	struct fetch_object_info_results results = FETCH_OBJECT_INFO_RESULTS_INIT;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
-	const char *saved_format = opt->format;
 
 	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
 		die(_("remote-object-info command too long"));
-	/*
-	 * TODO: Use the default format once %(objecttype) is supported.
-	 */
-	if (!opt->format)
-		opt->format = "%(objectname) %(objectsize)";
 
 	line_to_split = xstrdup(line);
 	count = split_cmdline(line_to_split, &argv);
@@ -883,7 +877,6 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		data->is_remote = 0;
 	}
 	data->skip_object_info = 0;
-	opt->format = saved_format;
 
 	free_fetch_object_info_results(&results);
 	free(line_to_split);
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index 190c45eefc..e2919aa061 100755
--- a/t/t1017-cat-file-remote-object-info.sh
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -139,10 +139,10 @@ test_expect_success 'batch-command remote-object-info git:// default filter' '
 		set_transport_variables "$daemon_parent" &&
 		cd "$daemon_parent/daemon_client_empty" &&
 
-		echo "$hello_oid $hello_size" >expect &&
-		echo "$tree_oid $tree_size" >>expect &&
-		echo "$commit_oid $commit_size" >>expect &&
-		echo "$tag_oid $tag_size" >>expect &&
+		echo "$hello_oid $hello_type $hello_size" >expect &&
+		echo "$tree_oid $tree_type $tree_size" >>expect &&
+		echo "$commit_oid $commit_type $commit_size" >>expect &&
+		echo "$tag_oid $tag_type $tag_size" >>expect &&
 
 		git cat-file --batch-command >actual <<-EOF &&
 		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid $tree_oid
@@ -152,7 +152,7 @@ test_expect_success 'batch-command remote-object-info git:// default filter' '
 	)
 '
 
-test_expect_success 'remote-object-info does not change the default format of info' '
+test_expect_success 'remote-object-info and info can be mixed using the unified default format' '
 	(
 		set_transport_variables "$daemon_parent" &&
 		cd "$daemon_parent/daemon_client_empty" &&
@@ -162,7 +162,7 @@ test_expect_success 'remote-object-info does not change the default format of in
 		local_size=$(strlen "$local_content") &&
 
 		echo "$local_oid blob $local_size" >expect &&
-		echo "$hello_oid $hello_size" >>expect &&
+		echo "$hello_oid blob $hello_size" >>expect &&
 		echo "$local_oid blob $local_size" >>expect &&
 
 		git cat-file --batch-command >actual <<-EOF &&
@@ -209,10 +209,10 @@ test_expect_success 'batch-command -Z remote-object-info git:// default filter'
 		set_transport_variables "$daemon_parent" &&
 		cd "$daemon_parent/daemon_client_empty" &&
 
-		printf "%s\0" "$hello_oid $hello_size" >expect &&
-		printf "%s\0" "$tree_oid $tree_size" >>expect &&
-		printf "%s\0" "$commit_oid $commit_size" >>expect &&
-		printf "%s\0" "$tag_oid $tag_size" >>expect &&
+		printf "%s\0" "$hello_oid $hello_type $hello_size" >expect &&
+		printf "%s\0" "$tree_oid $tree_type $tree_size" >>expect &&
+		printf "%s\0" "$commit_oid $commit_type $commit_size" >>expect &&
+		printf "%s\0" "$tag_oid $tag_type $tag_size" >>expect &&
 
 		printf "%s\0" "$hello_oid missing" >>expect &&
 		printf "%s\0" "$tree_oid missing" >>expect &&
@@ -448,10 +448,10 @@ test_expect_success 'batch-command remote-object-info file:// default filter' '
 		server_path="$(pwd)/server" &&
 		cd file_client_empty &&
 
-		echo "$hello_oid $hello_size" >expect &&
-		echo "$tree_oid $tree_size" >>expect &&
-		echo "$commit_oid $commit_size" >>expect &&
-		echo "$tag_oid $tag_size" >>expect &&
+		echo "$hello_oid $hello_type $hello_size" >expect &&
+		echo "$tree_oid $tree_type $tree_size" >>expect &&
+		echo "$commit_oid $commit_type $commit_size" >>expect &&
+		echo "$tag_oid $tag_type $tag_size" >>expect &&
 
 		git cat-file --batch-command >actual <<-EOF &&
 		remote-object-info "file://${server_path}" $hello_oid $tree_oid
@@ -467,10 +467,10 @@ test_expect_success 'batch-command -Z remote-object-info file:// default filter'
 		server_path="$(pwd)/server" &&
 		cd file_client_empty &&
 
-		printf "%s\0" "$hello_oid $hello_size" >expect &&
-		printf "%s\0" "$tree_oid $tree_size" >>expect &&
-		printf "%s\0" "$commit_oid $commit_size" >>expect &&
-		printf "%s\0" "$tag_oid $tag_size" >>expect &&
+		printf "%s\0" "$hello_oid $hello_type $hello_size" >expect &&
+		printf "%s\0" "$tree_oid $tree_type $tree_size" >>expect &&
+		printf "%s\0" "$commit_oid $commit_type $commit_size" >>expect &&
+		printf "%s\0" "$tag_oid $tag_type $tag_size" >>expect &&
 
 		printf "%s\0" "$hello_oid missing" >>expect &&
 		printf "%s\0" "$tree_oid missing" >>expect &&
@@ -618,10 +618,10 @@ test_expect_success 'batch-command remote-object-info http:// default filter' '
 		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
 
-		echo "$hello_oid $hello_size" >expect &&
-		echo "$tree_oid $tree_size" >>expect &&
-		echo "$commit_oid $commit_size" >>expect &&
-		echo "$tag_oid $tag_size" >>expect &&
+		echo "$hello_oid $hello_type $hello_size" >expect &&
+		echo "$tree_oid $tree_type $tree_size" >>expect &&
+		echo "$commit_oid $commit_type $commit_size" >>expect &&
+		echo "$tag_oid $tag_type $tag_size" >>expect &&
 
 		git cat-file --batch-command >actual <<-EOF &&
 		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid $tree_oid
@@ -636,10 +636,10 @@ test_expect_success 'batch-command -Z remote-object-info http:// default filter'
 		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
 
-		printf "%s\0" "$hello_oid $hello_size" >expect &&
-		printf "%s\0" "$tree_oid $tree_size" >>expect &&
-		printf "%s\0" "$commit_oid $commit_size" >>expect &&
-		printf "%s\0" "$tag_oid $tag_size" >>expect &&
+		printf "%s\0" "$hello_oid $hello_type $hello_size" >expect &&
+		printf "%s\0" "$tree_oid $tree_type $tree_size" >>expect &&
+		printf "%s\0" "$commit_oid $commit_type $commit_size" >>expect &&
+		printf "%s\0" "$tag_oid $tag_type $tag_size" >>expect &&
 
 		batch_input="remote-object-info $HTTPD_URL/smart/http_parent $hello_oid $tree_oid
 remote-object-info $HTTPD_URL/smart/http_parent $commit_oid $tag_oid

-- 
2.54.0

