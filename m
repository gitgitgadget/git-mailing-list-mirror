Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3462CC43217
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiKGShP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiKGSga (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6890D24F3F
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:23 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so2299466wmi.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf2uJpX9giLjZADQIFnMMNnHnj/OzmZFTvDuR/mGwNg=;
        b=THHQ4G/SAjiN975lcWjUbIMVFjaBrdQu3XzvzdN8xFo1PMHRh9RXUkJSBtOAkHrPI3
         zfLtLM+ox45tsASR/slf/8Jb0UxxptjvX/a5b89kwGFywbBSBxivtzz3U3YF7q2i9MKl
         vHF1Biu2PxiU/6GIPTlLLnrY+is3uR8iaEUQTkSc753J4OiC4P9YZBjq+IcPZ0fTKDWM
         Go9cWvr5NxV8Y4Bc/0r/1gxvrCszdNUhL5WugeOoGjnn66gTtWCzEXAXwuHJkcMENuyp
         k3pgBPi8OlzgHbdYY6lWHXPyzEvOABnDvij9rgwZhlju8e1/mSeK4l+IrAjtnLpGcwgD
         0zUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xf2uJpX9giLjZADQIFnMMNnHnj/OzmZFTvDuR/mGwNg=;
        b=Nu5wbObV+pJ0u1LZOgc3JQku/PMfo/44WH7R4PTgoy+N4FN/rDjMlbU/aICZ59+9lg
         9aC2RxASBnvu9Fz3qJBbjH84yeflB2ZZexiUWZ0ouhZLk6lMm4PGOpXXYz6NGW+bj++y
         7y969GT4rjohKEznu1tQ47J4nFuPwtkYUfc9boT+kd26PY0ws7PuALXzp5rfjLTC6X7Q
         xsr8kaSOZXybjQW3YoeDYeYXLzh6HB/snnWncXOiGJoZnmevsv2/Vxfo50Yfm8kAkONN
         Ek8fZLWsZfu8TIOThn3Nd7K4WklcpC3mA+RPYbACs/wGwX8p3cHi9iIpprh1pl/OUWY8
         5MNA==
X-Gm-Message-State: ACrzQf3yCs7Paf6zEDGAuhCh7YwiMU1GnusRmaOMD3P/hhcUSzAzrRqy
        EKhX7WPdW6s+t/bpkT/KdhIC9BK/CKw=
X-Google-Smtp-Source: AMsMyM4eIWq2FZMmv57FA8hNKHY6QyowzdnCsbrX3hcz7KJ5EIVVIHtYyKh5eVPwJ9cI4hxyIuhZCg==
X-Received: by 2002:a05:600c:358f:b0:3c6:da94:66f9 with SMTP id p15-20020a05600c358f00b003c6da9466f9mr33447744wmq.142.1667846181582;
        Mon, 07 Nov 2022 10:36:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c26c500b003b50428cf66sm8556509wmv.33.2022.11.07.10.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:21 -0800 (PST)
Message-Id: <a3819f665977194a8f44061d4a52f86d44cf6e0a.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:49 +0000
Subject: [PATCH 15/30] packed-backend: create abstraction for writing refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The packed-refs file is a plaintext file format that starts with a
header line, then each ref is given as one or two lines (two if there is
a peeled value). These lines are written as part of a sequence of
updates which are merged with the existing ref iterator in
merge_iterator_and_updates(). That method is currently tied directly to
write_packed_entry_v1().

When creating a new version of the packed-file format, it would be
valuable to use this merging logic in an identical way. Create a new
function pointer type, write_ref_fn, and use that type in
merge_iterator_and_updates().

Notably, the function pointer type no longer depends on a FILE pointer,
but instead takes an arbitrary "void *write_data" parameter. This
flexibility will be critical in the future, since the planned v2 format
will use the chunk-format API and need a more complicated structure than
the output FILE.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 refs/packed-backend.c   | 26 +++++++++++++++-----------
 refs/packed-backend.h   | 16 ++++++++++++++--
 refs/packed-format-v1.c |  7 +++++--
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 0dff78f02c8..7ed9475812c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -535,10 +535,11 @@ static void add_write_error(struct packed_ref_store *refs, struct strbuf *err)
 		    get_tempfile_path(refs->tempfile), strerror(errno));
 }
 
-static int merge_iterator_and_updates(struct packed_ref_store *refs,
-				      struct string_list *updates,
-				      struct strbuf *err,
-				      FILE *out)
+int merge_iterator_and_updates(struct packed_ref_store *refs,
+			       struct string_list *updates,
+			       struct strbuf *err,
+			       write_ref_fn write_fn,
+			       void *write_data)
 {
 	struct ref_iterator *iter = NULL;
 	int ok, i;
@@ -634,9 +635,10 @@ static int merge_iterator_and_updates(struct packed_ref_store *refs,
 			struct object_id peeled;
 			int peel_error = ref_iterator_peel(iter, &peeled);
 
-			if (write_packed_entry_v1(out, iter->refname,
-						  iter->oid,
-						  peel_error ? NULL : &peeled)) {
+			if (write_fn(iter->refname,
+				     iter->oid,
+				     peel_error ? NULL : &peeled,
+				     write_data)) {
 				add_write_error(refs, err);
 				goto error;
 			}
@@ -657,9 +659,10 @@ static int merge_iterator_and_updates(struct packed_ref_store *refs,
 			int peel_error = peel_object(&update->new_oid,
 						     &peeled);
 
-			if (write_packed_entry_v1(out, update->refname,
-						  &update->new_oid,
-						  peel_error ? NULL : &peeled)) {
+			if (write_fn(update->refname,
+				     &update->new_oid,
+				     peel_error ? NULL : &peeled,
+				     write_data)) {
 				add_write_error(refs, err);
 				goto error;
 			}
@@ -725,7 +728,8 @@ static int write_with_updates(struct packed_ref_store *refs,
 		goto error;
 	}
 
-	ok = merge_iterator_and_updates(refs, updates, err, out);
+	ok = merge_iterator_and_updates(refs, updates, err,
+					write_packed_entry_v1, out);
 
 	if (ok != ITER_DONE) {
 		strbuf_addstr(err, "unable to write packed-refs file: "
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 143ed6d4f6c..b6908bb002c 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -192,6 +192,17 @@ struct packed_ref_iterator {
 	unsigned int flags;
 };
 
+typedef int (*write_ref_fn)(const char *refname,
+			    const struct object_id *oid,
+			    const struct object_id *peeled,
+			    void *write_data);
+
+int merge_iterator_and_updates(struct packed_ref_store *refs,
+			       struct string_list *updates,
+			       struct strbuf *err,
+			       write_ref_fn write_fn,
+			       void *write_data);
+
 /**
  * Parse the buffer at the given snapshot to verify that it is a
  * packed-refs file in version 1 format. Update the snapshot->peeled
@@ -227,8 +238,9 @@ void verify_buffer_safe_v1(struct snapshot *snapshot);
 void sort_snapshot_v1(struct snapshot *snapshot);
 int write_packed_file_header_v1(FILE *out);
 int next_record_v1(struct packed_ref_iterator *iter);
-int write_packed_entry_v1(FILE *fh, const char *refname,
+int write_packed_entry_v1(const char *refname,
 			  const struct object_id *oid,
-			  const struct object_id *peeled);
+			  const struct object_id *peeled,
+			  void *write_data);
 
 #endif /* REFS_PACKED_BACKEND_H */
diff --git a/refs/packed-format-v1.c b/refs/packed-format-v1.c
index ef9e6618c89..2d071567c02 100644
--- a/refs/packed-format-v1.c
+++ b/refs/packed-format-v1.c
@@ -441,10 +441,13 @@ int write_packed_file_header_v1(FILE *out)
  * error, return a nonzero value and leave errno set at the value left
  * by the failing call to `fprintf()`.
  */
-int write_packed_entry_v1(FILE *fh, const char *refname,
+int write_packed_entry_v1(const char *refname,
 			  const struct object_id *oid,
-			  const struct object_id *peeled)
+			  const struct object_id *peeled,
+			  void *write_data)
 {
+	FILE *fh = write_data;
+
 	if (fprintf(fh, "%s %s\n", oid_to_hex(oid), refname) < 0 ||
 	    (peeled && fprintf(fh, "^%s\n", oid_to_hex(peeled)) < 0))
 		return -1;
-- 
gitgitgadget

