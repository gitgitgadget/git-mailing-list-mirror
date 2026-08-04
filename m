Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E7416875
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868994; cv=none; b=cUIwodFsTJaJbVk3MNkxMwAyr6ieqX2cnori8CrIPpwByNTuB0HI0IXEmj2I81AFAalG5VgL5j96D4GekVOycDFYEEb4fq1RH2jdKnyJPVKMsAwT2QLWuFAz3qXjRL2o/jxDw/hZYoEtk8oSJbvALKm6ikQZrItX5AQluBiPS4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868994; c=relaxed/simple;
	bh=pCIKOAPItCyr9X683fu9AiRTvfGnZQ0ckBL+K4a+4rQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mNVP5aSotDND/MGtnS3ZxZwo9mFbi7N8fxRVuE+MKS2O95lqI6q1xVD3+Nv3k3DsR67xh3Hr+SOG5/mOHcsacbUwPYRvpEJh4QxFPjxu+HTUpxO5ldNMV0IiwMA64c7IJLq9zTkBYGsACNPndyuGIO07sy0mHzmMKlXazLjrPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMC4l6oQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMC4l6oQ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954aff6088so1136735e9.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 11:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868991; x=1786473791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ak899zHQbVsLIOoOO3wjKXPg/mcRHMgCAHoOrzhch5k=;
        b=nMC4l6oQVgyPZFeFk9OkgH1fwVcmOw7USsgzyLG77FGJmGGZ67sRPWZV/P3TcLPI04
         +020/7znIddFGlRbseXOB4hpf6vL2x8hrQZsMqp1CYpO2sNJvIFxcbgrF+ZGJ2g8dP1x
         FWgPbzU1gIYSAjvMTphEUxE/jsne5lfvrZYxaN9VSghzGRIvW+Pthb/YItrzuvZej3xf
         s0Vck0WDJX4L7Pup6kKExssfEhcTf7onxdtWU3LIexYAz2VUJI7rLJJeMqhdxcdXXJg9
         XYAxn3Ku0shBpWPWgP8SAhXV2E28k/t5/GC5V2hFWm42BFpkJyikz10clzdMpIDx23qZ
         4xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868991; x=1786473791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ak899zHQbVsLIOoOO3wjKXPg/mcRHMgCAHoOrzhch5k=;
        b=h4Eddj/pinMFZF3pweotMN+DgC4GmF13UMJpg5W0+O/QZ6/xg2OUaXvlnH1RcT5Hc9
         HAJld5OmH3I9RUVWGaRACUpozDOl8qXzAgZAW4yVlBwBbmZhr0VhxWhJTWwdE9l/6Szj
         Q4SFsJqThYIH14jcyebmatEduLteIe0kmK1TKPzVaDq47FvrFTX1zazLuZ8N+vQEv1GA
         BhcTGU13fJBRbKSsqBx+i7VIP4Oxsi8V9AQ0uEwyJISnxMJDKnYA1x5SaGev2NoGHEli
         4WOneQq3vl+5BUg2Ss2pVG4Zz51QyZ4JmrPGsu81tzmcJ86nvzSI8EI+jiyooZUgYB7T
         dM0g==
X-Gm-Message-State: AOJu0YzKnIR6NXMlLvI/aD42BqFB8SXGBv4qIU14dmFDxT/WqD7gEwtL
	QxgSrWk8TgF8d5tVjsGgedhmhWbo6h9VWyk2GWhWqnbmV8RN2e6m21xV
X-Gm-Gg: AR+sD13Dsnd5O6kBS6bqh3ZTrOPsKNmxOxW2k0JjR3PA7V10cNuQuuOtZ1l38ysLb5M
	h9XKNU+NKAv3yHRNc7PjIZYK5D6ZrgDrD9wLMArIi4EeDikP2WnqgoxqN9u/mVRlo13dQxrwwoE
	fFCRm4mBD37gLZWclQ5aBn+GiwZzeXKEQGvBduMHun68k1OBbmuG2goQ1PZDLUh/C9mB71ptn6A
	JfpKKORXKWQYIVzJLbMoNtnopwCOlD/5QKydyyQ5jACoBIqFuMhazsAd93OJxDXYmLlpwmc/BJb
	j6P+lhPcwFdxOSP0t61TJBNkIlD+Dlu7NVGHMIzVS0dYSmH6I3YjTfn5xsXs711TnDCFr+ze8WO
	mWJ9mqHj8n3n4OHQL0T54FIo1DA1el7HILql2GP1h/qlkb5SpL8U4HMkQSZPcK8Y9vD2PyP+kV/
	s04Q4rgTtOH6LvterZQa8JqwS4R5kCxv4WRIrTeISxHk6/Y1l8B6TRdx4UxPo9ISYs/WaoByIAO
	qKv4jiM3wO8IMfLSE4vsK0lH9Snl0RBDtL5tFGLfuLfbOWjl+IO+M7wlEpc87zQLH9Ah/qUjb3V
	ue75gU3p4iXiJGxJeSqIKDtB+BADn9F7rlx+N9V2pczFlhO+d9//1WAU30p2NsHlDIcq61NEuEJ
	+dUpLviKZzwqCNnW5
X-Received: by 2002:a05:600c:8b35:b0:493:c634:952 with SMTP id 5b1f17b1804b1-4994e79e668mr3521045e9.7.1785868991047;
        Tue, 04 Aug 2026 11:43:11 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7b73sm138877835e9.9.2026.08.04.11.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:43:10 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 04 Aug 2026 20:43:03 +0200
Subject: [PATCH GSoC v4 9/9] cat-file: unify default format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-objecttype-support-v4-9-31511b0231be@gmail.com>
References: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
In-Reply-To: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
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

