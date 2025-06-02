Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F9520E026
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748890562; cv=none; b=BQi0+aHGNmCt/GR9aZOIHCaTM7BLwj8sSstYuBtotCWFFGLhcXjOX+VjIfydKaujVI0gCqc7ZcdCPT4abgd0THHU0l82VYgjkrqI9EqbpwbVy4+1C3Di3n6op4SwRePOyE34A7fYtCylPrnaxKbOd9FwVaBcdXtby0whBQ4d5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748890562; c=relaxed/simple;
	bh=yY9Lw8Oq5Tl9B5Z9Ebqv9fgfZmFpQEZS4EvFchJRoh8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gR+xhzEvX8UwXUjucJX9vgyfZ5+KbKCSmls4/NPSemjFJxJdOTsgbcck86XU+TzoMVAhNt0YjdvT40/pppqgk3CuccgwR1b9VpgEOh9yP6qzlC6w4u/pLL8FzKuGDUBFYWmkedols037QuAmfROnrkJrTSCHzV2G85F4CrbxfkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIezGcfv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIezGcfv"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a375e72473so2769475f8f.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748890558; x=1749495358; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDxEhixIwaT5kIny1V8tYoE5T5FJZm1FyDgIvnsMzgE=;
        b=lIezGcfvoi/8gou9pmOu+5wIf4MAHwdCCI5k0SuRa7p+RLKCDAbC7eEWUt8j9jvOF/
         eA1isxlPDL8X8fN6qf2aDpUZU3vNrE/bRemMAF1NgRR5bs39fLtk2QbcCN6Xe61z/bD9
         pTuj6T2qJW/kpKQ8ToQbIGbRKjuBn98WcWz49H1A2sOf5USF5JJg2tJ5Vv0hfiLOOkT1
         wQIcsBC9p0ys0UlBH2brjFyGc6R9uxSJvDGcQOFPigLICI3AtxCDaygw4uwf3/XZ4b0D
         unyg5JZhDIiLZef1Hw7NcNf6G1tiXYrvlk9LiG4ux+VcqYBHoRu5kRHr1UmLB2EqEUBD
         aU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748890558; x=1749495358;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDxEhixIwaT5kIny1V8tYoE5T5FJZm1FyDgIvnsMzgE=;
        b=qqBV9GzquR/UTfhrGrDnQ7C5hR1ZCmPsO2ymGl4pvJ0mPToLlpSMuRbUX2sXNvPwep
         s+Vq5fRxgRA/N0UMsZRNxFz0hTao9/U9QKMu9CUKG4hnOu1bfxuxQJvRLtS6VvHYI5hC
         3rnFCPVE2kQhy79LP9vkDZr/6R4Dr2DRP0GPahrUZTyNDilNsB1GU8BGOliZe1ZAfHlX
         V2fM2hr7fEibJuIImN1wNVlnEQMiNTrBtjuVEKL9aJf1ahCtPXZgRbBSHiozB36ooAsp
         SG9uAyJkslf9sIGJ/RzkgTsyMQV/r3ZCatfRw+RIOEcU1JNkuDtYZat+hWtJMydst/3e
         zvqA==
X-Gm-Message-State: AOJu0YwwmJd80SUp9lBOMQN2rtV2clc5FfJYZJTfyVI38FSzKunD2Lfg
	VcZ7deH4icPB/EULwagDMmozPztwA3hkXLgpkjehl164ThSEa93m4jw2EfWA4Q==
X-Gm-Gg: ASbGncuApNC52G8t0UA8O18XOdkub1sr4cvE7DFIqssDYwikTkgNUP7XAf/gO7VqGxS
	QczlJ1oklGig1siYV9tBvlStdqOZWSHQ5VpsOPIz66TtoLLjIPQ5OVVbipaoY2E3xW4ezPMegw5
	Tqs2zhSyM6KBDIA77j6lbtC2v2HY3MZ38CkliRjMeL4PjD5mMNWuj/DDoXBUZ3n+aSf3GxGAX0k
	D9XjciKikNTli0QWd5NChUa2InF+EEVIEOdq2EDL3oAC9ddq/IRwxg6aKEYf6Or6AspWQdZLKyy
	N5JhdDY1t5RW7eaS4/K7DOJRGnjbKd7ssazSY8GeOYmH9anuqVl0
X-Google-Smtp-Source: AGHT+IGKkw9rL43A4AWqIHU8ENO9si9uxcKSxm4gR6i6ZNUGqbkeyySUNKUJk9fHEOAfMTvRFfesnA==
X-Received: by 2002:a05:6000:25c4:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3a4f7a7d0c4mr12378062f8f.53.1748890558211;
        Mon, 02 Jun 2025 11:55:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb80f6sm131853305e9.28.2025.06.02.11.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 11:55:57 -0700 (PDT)
Message-Id: <1ff39aa3c6e613137edde9e05321a7df5c165e99.1748890555.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1929.git.1748890555.gitgitgadget@gmail.com>
References: <pull.1929.git.1748890555.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Jun 2025 18:55:54 +0000
Subject: [PATCH 2/3] cat-file: add %(objectmode) atom
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: peff@peff.net,
    gitster@pobox.com,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Add a formatting atom, used with the --batch-check/--batch-command options,
that prints the octal representation of the object mode if a given revision
includes that information, e.g. one that follows the format
<tree-ish>:<path>. If the mode information does not exist, an empty string
is printed instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-cat-file.adoc |  5 +++++
 builtin/cat-file.c              |  9 ++++++--
 t/t1006-cat-file.sh             | 38 +++++++++++++++++++--------------
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index cde79ad242bb..5c002c0499e4 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -307,6 +307,11 @@ newline. The available atoms are:
 `objecttype`::
 	The type of the object (the same as `cat-file -t` reports).
 
+`objectmode`::
+	If the specified object has mode information (such as a tree or
+	index entry), the mode expressed as an octal integer. Otherwise,
+	empty string.
+
 `objectsize`::
 	The size, in bytes, of the object (the same as `cat-file -s`
 	reports).
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 67a5ff2b9ebd..b11576756bcc 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -275,6 +275,7 @@ struct expand_data {
 	struct object_id oid;
 	enum object_type type;
 	unsigned long size;
+	unsigned short mode;
 	off_t disk_size;
 	const char *rest;
 	struct object_id delta_base_oid;
@@ -306,6 +307,7 @@ struct expand_data {
 	 */
 	unsigned skip_object_info : 1;
 };
+#define EXPAND_DATA_INIT  { .mode = S_IFINVALID }
 
 static int is_atom(const char *atom, const char *s, int slen)
 {
@@ -345,6 +347,9 @@ static int expand_atom(struct strbuf *sb, const char *atom, int len,
 		else
 			strbuf_addstr(sb,
 				      oid_to_hex(&data->delta_base_oid));
+	} else if (is_atom("objectmode", atom, len)) {
+		if (!data->mark_query && !(S_IFINVALID == data->mode))
+			strbuf_addf(sb, "%06o", data->mode);
 	} else
 		return 0;
 	return 1;
@@ -613,6 +618,7 @@ static void batch_one_object(const char *obj_name,
 		goto out;
 	}
 
+	data->mode = ctx.mode;
 	batch_object_write(obj_name, scratch, opt, data, NULL, 0);
 
 out:
@@ -866,7 +872,7 @@ static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
 	struct strbuf output = STRBUF_INIT;
-	struct expand_data data;
+	struct expand_data data = EXPAND_DATA_INIT;
 	int save_warning;
 	int retval = 0;
 
@@ -875,7 +881,6 @@ static int batch_objects(struct batch_options *opt)
 	 * object_info to be handed to oid_object_info_extended for each
 	 * object.
 	 */
-	memset(&data, 0, sizeof(data));
 	data.mark_query = 1;
 	expand_format(&output,
 		      opt->format ? opt->format : DEFAULT_FORMAT,
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 7c9512a6b439..97052b3f31f1 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -114,10 +114,11 @@ strlen () {
 run_tests () {
     type=$1
     object_name="$2"
-    size=$3
-    content=$4
-    pretty_content=$5
-    oid=${6:-"$object_name"}
+    mode=$3
+    size=$4
+    content=$5
+    pretty_content=$6
+    oid=${7:-"$object_name"}
 
     batch_output="$oid $type $size
 $content"
@@ -209,6 +210,12 @@ $content"
 	test_cmp expect actual
     '
 
+    test_expect_success '--batch-check with %(objectmode)' '
+	echo "$mode $oid" >expect &&
+	echo $object_name | git cat-file --batch-check="%(objectmode) %(objectname)" >actual &&
+	test_cmp expect actual
+    '
+
     test -z "$content" ||
     test_expect_success "--batch without type ($type)" '
 	{
@@ -247,8 +254,7 @@ test_expect_success "setup" '
 
 run_blob_tests () {
     oid=$1
-
-    run_tests 'blob' $oid $hello_size "$hello_content" "$hello_content"
+    run_tests 'blob' $oid "" $hello_size "$hello_content" "$hello_content"
 
     test_expect_success '--batch-command --buffer with flush for blob info' '
 	echo "$oid blob $hello_size" >expect &&
@@ -286,12 +292,12 @@ tree_compat_size=$((2 * $(test_oid --hash=compat rawsz) + 13 + 24))
 tree_pretty_content="100644 blob $hello_oid	hello${LF}100755 blob $hello_oid	path with spaces${LF}"
 tree_compat_pretty_content="100644 blob $hello_compat_oid	hello${LF}100755 blob $hello_compat_oid	path with spaces${LF}"
 
-run_tests 'tree' $tree_oid $tree_size "" "$tree_pretty_content"
-run_tests 'tree' $tree_compat_oid $tree_compat_size "" "$tree_compat_pretty_content"
-run_tests 'blob' "$tree_oid:hello" $hello_size "" "$hello_content" $hello_oid
-run_tests 'blob' "$tree_compat_oid:hello" $hello_size "" "$hello_content" $hello_compat_oid
-run_tests 'blob' "$tree_oid:path with spaces" $hello_size "" "$hello_content" $hello_oid
-run_tests 'blob' "$tree_compat_oid:path with spaces" $hello_size "" "$hello_content" $hello_compat_oid
+run_tests 'tree' $tree_oid "" $tree_size "" "$tree_pretty_content"
+run_tests 'tree' $tree_compat_oid "" $tree_compat_size "" "$tree_compat_pretty_content"
+run_tests 'blob' "$tree_oid:hello" "100644" $hello_size "" "$hello_content" $hello_oid
+run_tests 'blob' "$tree_compat_oid:hello" "100644" $hello_size "" "$hello_content" $hello_compat_oid
+run_tests 'blob' "$tree_oid:path with spaces" "100755" $hello_size "" "$hello_content" $hello_oid
+run_tests 'blob' "$tree_compat_oid:path with spaces" "100755" $hello_size "" "$hello_content" $hello_compat_oid
 
 commit_message="Initial commit"
 commit_oid=$(echo_without_newline "$commit_message" | git commit-tree $tree_oid)
@@ -310,8 +316,8 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 $commit_message"
 
-run_tests 'commit' $commit_oid $commit_size "$commit_content" "$commit_content"
-run_tests 'commit' $commit_compat_oid $commit_compat_size "$commit_compat_content" "$commit_compat_content"
+run_tests 'commit' $commit_oid "" $commit_size "$commit_content" "$commit_content"
+run_tests 'commit' $commit_compat_oid "" $commit_compat_size "$commit_compat_content" "$commit_compat_content"
 
 tag_header_without_oid="type blob
 tag hellotag
@@ -334,8 +340,8 @@ tag_size=$(strlen "$tag_content")
 tag_compat_oid=$(git rev-parse --output-object-format=$test_compat_hash_algo $tag_oid)
 tag_compat_size=$(strlen "$tag_compat_content")
 
-run_tests 'tag' $tag_oid $tag_size "$tag_content" "$tag_content"
-run_tests 'tag' $tag_compat_oid $tag_compat_size "$tag_compat_content" "$tag_compat_content"
+run_tests 'tag' $tag_oid "" $tag_size "$tag_content" "$tag_content"
+run_tests 'tag' $tag_compat_oid "" $tag_compat_size "$tag_compat_content" "$tag_compat_content"
 
 test_expect_success "Reach a blob from a tag pointing to it" '
 	echo_without_newline "$hello_content" >expect &&
-- 
gitgitgadget

