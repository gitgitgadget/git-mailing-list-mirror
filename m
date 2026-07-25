Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4B632861F
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784980541; cv=none; b=TXR2fsRYgneLEZaX19P6bPjqKpAytJn4wpgRsldKzzZAFP6ZawEpuZNDZ1vz3vGAI8klYaS81UoqLIcmyKcrfDXQ0jXY8eOb3CJik0fyteppmyh31RG7gkqPdn4MiSaWcYfvSXeuyieXjdWa9kWElehFfosBUuiVv55fUTQVFCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784980541; c=relaxed/simple;
	bh=8hn3j8bzPAFxwKK+MOU5caw/Zu8KGVFuwOt2C5RUQ/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkV4DlxX3YZLP/RCMEnziDP0S2uHrFetnbEt+SGVBdJhq5AiegxoOPMoEPPlYThcRU/9MLD8lAMhz+8XSQupluc90AeiC027jek0R9jhIVbhbzCYMpP3IXpGkshZwdG2ko/8PWMSnJvDGAewFYh8LRRsqXrgKexKIOb+qbkELGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qzg4lF4F; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qzg4lF4F"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4957eefd361so9645545e9.1
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784980538; x=1785585338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJ2viObx7K8Uz6MmwV0YLaizCiDIF52r7ZfvlPcG18Q=;
        b=Qzg4lF4FeBnWcCLAvA4Ajhkh+kNycjDqc6a8vKIK6oncE9ng8dXMUmLnGRCYHf5TpZ
         7N5U/oqeecUrJPLsaEgrImy8X59TFlO1UXxD5wvWPBCu9THh9DOsSsLV6Ks74i0Y8oLW
         l4lgfFhB1QFvwoOKhywY8hjA/PF2qO6DsqCRS62olF6UKCjWL77rzCof+l3K73kgqUBr
         qeIZ377APkzGC2WukTWbTNwyupHhmCt2xDOaGQ2BcphNrpCP0frbvNnxm1jP3HnLuMcW
         I2uz8EsN0LxuDwHmXzi6l5E9RlPyMIA1oataW/IbebsTYfh6LENo4lYL3HJ/cPYVAtTK
         QI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784980538; x=1785585338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xJ2viObx7K8Uz6MmwV0YLaizCiDIF52r7ZfvlPcG18Q=;
        b=cIJUNDkHl4uj1bXn8IU2mU6B59XLTbko581Z0CO0ajRz5/LFzJ54vjckkQ2AG5I6yl
         Dovo2hY/8l/cMNmD3mpGT+tDestwA619L+TFDIszlUdnBWP6ULQ5o43x/smN3ToJuK30
         Sc6TWzR0VFCw/GGWSmE+Psqrk1xqo72VUigpukXcmljzAHT9YAjDDgx5bGh/tWJmWAXr
         laCs6nRyQOOOEkQgg15Q1AYvX9nuCxunXg2SaAUwxNmi/6GXutKJf3AQC0HSiPRkgP/7
         nEXyjCJe2MYrrr8QbBJQh+MG46IshIwoHJCC/B8ADluyvXZdEhAmWedCbwH8RK4TJBIN
         Ek5w==
X-Gm-Message-State: AOJu0YxJizH/64v4w5u3gZYSApmfNCa2i8U8xZep577ygsfNfS3629B8
	lqnVaUjt5ismaPWrRkvYn8RoAguPDOAFkzoaxrsyEJ2TY674O2fu3GIK
X-Gm-Gg: AR+sD10DCbm2mXE9UFgZp+gn5eQUu3duVutDOZEjfd/ckDxYWrcMImkdduDwi4r5a1X
	IGw3kq0gZFSofDgAiAFAIVhe8jNGZB9D0YUZw2/eTA+MPVYT2qEWjo9wTehZUwvzn9XoOf3GwRL
	xgVBS9WnRweq/UVsBDaqLV/XQ8b62Y+3b+24yw4hlfBd3BHzx9f4/xAU1FiakDDncQVF3AXZbO1
	I/jaVW0MNvEtQdz/gEH7eBcDqA/AiHxAKVNToDqcObF/8JaEGU1j8nkEL+MGqKXyLDSMPCPixG6
	AnRCRU0AoQF1bDtLwmRpwUKn/11orDDEjy+4nRRhV7tpA+INxZ2ojy9CbE4LvLTJU64eh2gjrR0
	bkyWlJNKWvVlYOXV1FMNrPXWSPXDtF4uhHZy5z4YDuSjLv/SUHrpEYJh9h5zMy8r1wpHr760JGp
	pMhh5zqWRAlYuZTvP+87tY7qt0UrGsdo4UWOtMWQgfbVZD5u2ybkReJS2OHypfrHOJBZ36+Fy4v
	hfixF8NNJmUMpqPzlxb9Y5UVObKEcGu+XQDUXMPwWW3X4iK7ei7nW8MK6LwoYrizDNFyfOyy4cQ
	3xh/zyoBlXcWNz++uW0Iqkr422HdPcRxqSolqB/oFvzhPmMSO0jhg3DLu/JzmzWevOW62MLqZNm
	UnR0KqRQFppWk5uzYhs76cAc06qO+C6yBTgeB9XsFjX0KMRiW4hpXP//iWFuFn+3ulfy+b/yLIg
	==
X-Received: by 2002:a05:600c:8489:b0:493:f318:3bc6 with SMTP id 5b1f17b1804b1-496b56fa3dfmr24051485e9.13.1784980537308;
        Sat, 25 Jul 2026 04:55:37 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (132.red-37-158-18.dynamicip.rima-tde.net. [37.158.18.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4858e86sm41700515e9.1.2026.07.25.04.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:55:36 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 25 Jul 2026 13:55:06 +0200
Subject: [PATCH GSoC 5/5] cat-file: unify default format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-objecttype-support-v1-5-2d4ca3bbabf1@gmail.com>
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
In-Reply-To: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

%(objecttype) is supported both by the client and by the server.
Change the temporary default format to the unified version that other
commands use.

Update documentation to remove %(objecttype) from the caveats of
remote-object-info.

Update tests that used the default format to expect type.
Update documentation to show %(objecttype) support.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/git-cat-file.adoc        | 17 ++++-----
 Documentation/gitprotocol-v2.adoc      | 15 ++++++--
 builtin/cat-file.c                     |  7 ----
 t/t1017-cat-file-remote-object-info.sh | 70 ++++++++++++----------------------
 4 files changed, 42 insertions(+), 67 deletions(-)

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
index 7bf62014c3..de4bfb776e 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -558,14 +558,17 @@ object-info
 
 `object-info` is the command to retrieve information about one or more objects.
 Its main purpose is to allow a client to make decisions based on this
-information without having to fully fetch objects. Object size is the only
-information that is currently supported.
+information without having to fully fetch objects. Object size and type are the
+only information that is currently supported.
 
 An `object-info` request takes the following arguments:
 
 	size
 	Requests size information to be returned for each listed object id.
 
+	type
+	Requests type information to be returned for each listed object id.
+
 	oid <oid>
 	Indicates to the server an object which the client wants to obtain
 	information for. They must be full OIDs.
@@ -580,11 +583,15 @@ space.
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
 
 If the server does not recognize the OID, the response will be `<oid> SP`
 regardless of the number of attributes requested.
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 884b6d5ad3..8288511b19 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -841,15 +841,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	struct object_info *remote_object_info = NULL;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
 	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
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
@@ -904,7 +898,6 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		data->is_remote = 0;
 	}
 	data->skip_object_info = 0;
-	opt->format = saved_format;
 
 	for (size_t i = 0; i < object_info_oids.nr; i++)
 		free_object_info_contents(&remote_object_info[i]);
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index 175f778cc9..741bdf34a0 100755
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
@@ -152,28 +152,6 @@ test_expect_success 'batch-command remote-object-info git:// default filter' '
 	)
 '
 
-test_expect_success 'remote-object-info does not change the default format of info' '
-	(
-		set_transport_variables "$daemon_parent" &&
-		cd "$daemon_parent/daemon_client_empty" &&
-
-		local_content="local object" &&
-		local_oid=$(echo_without_newline "$local_content" | git hash-object -w --stdin) &&
-		local_size=$(strlen "$local_content") &&
-
-		echo "$local_oid blob $local_size" >expect &&
-		echo "$hello_oid $hello_size" >>expect &&
-		echo "$local_oid blob $local_size" >>expect &&
-
-		git cat-file --batch-command >actual <<-EOF &&
-		info $local_oid
-		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
-		info $local_oid
-		EOF
-		test_cmp expect actual
-	)
-'
-
 test_expect_success 'batch-command --buffer remote-object-info git://' '
 	(
 		set_transport_variables "$daemon_parent" &&
@@ -209,10 +187,10 @@ test_expect_success 'batch-command -Z remote-object-info git:// default filter'
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
@@ -432,10 +410,10 @@ test_expect_success 'batch-command remote-object-info file:// default filter' '
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
@@ -451,10 +429,10 @@ test_expect_success 'batch-command -Z remote-object-info file:// default filter'
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
@@ -602,10 +580,10 @@ test_expect_success 'batch-command remote-object-info http:// default filter' '
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
@@ -620,10 +598,10 @@ test_expect_success 'batch-command -Z remote-object-info http:// default filter'
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

