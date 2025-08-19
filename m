Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F4B340DB8
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606073; cv=none; b=OBB0KbQDQQXmdVwp79Its5tZm5NgSNyk8ylkh7cgabGv6KJ9HKAT7/b6l1C4fcPLsiHJnV2RJSsr9QspYZBrOUEkXeADEoNVv+nIWuoALsl9YpbARnqqtLo8jXW4EbRGSY2Cqf9WcldI20KIOzmmrT3krsLu14FP1eu8WYqGWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606073; c=relaxed/simple;
	bh=mdOVCnYhc8iRJZxX5nwUv2T6y7i0YUVzfGhVZ4wRL8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wr4jCcuwq2YdzwRphwiWIZSVd3BLALiylLB37suDcGsfF1hcPkLptxXKoNe1537rwPY1mi/eOCoDM3VhOusfZFr7LIqDn8BTwyUqx2owB0OPuXgw6Hcd4r2b7t8c1c5YzGJ4MUzF5QlGRpt+QJGulocqrdPLGs9SG3nacTlBNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8eK4Nez; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8eK4Nez"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9e7437908so5054063f8f.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 05:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755606069; x=1756210869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxKOV5fxUmFFpXzY9Tdv52EfPWvwJkJBQEXJshqhADQ=;
        b=V8eK4NezYeLMGi+p9BlzSH8BedE/LlMblCKALgptQq7b021mkj36yEil0ifJrB9Bhi
         BA4guZnTpgzUCWYSJ1+ZAtJViNhTiw7k050zWLs3ohDfJqZTzwHmrZq0V9Ol1rRB8E4q
         JfSANpKbrnzTeKNb1iSo9/dP6AYipcXTN/7Eyzx8yVUqdLmm2fxCLLHg4en23eNhWsM6
         OmXpfnpXdTHon7FYMBJJbgmxt6X4wQPOjBuW2y9PTXyEVCJSj9NzHENS6cK7UV3L9MTu
         zItOrFLI8bOz2+DO0QvmsJKVmcO/GnvhjOFlYCBoXATOXvhCCgGTdsUc07Vjpox+D9gT
         06Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606069; x=1756210869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxKOV5fxUmFFpXzY9Tdv52EfPWvwJkJBQEXJshqhADQ=;
        b=uY5PloW0LQ9tT7PNFqE6wsXZEP+96ipMe5j4QjyQfRPgG7+fnqTQkT/ypkP7XaWU1/
         S+dEgV4HF5chMf5V7xVivE7MBvYu4o1O1JYM6UN/Jl4qzG9L9nkpnSlOWbXtXssQLGnf
         iBc2XbrEVh01iQs5L/yLwuA6zG3XxoLpDQCPRWYexMuQYqxOkGuCBxmgGgiXEVrEv2F7
         ctf25BAynHGNF8AMGHtGLmhAmgtrHITzMgrNS/MYVxY7lZgaliebCEbXq8Cjo2+UJZ5/
         RKoyj4nEh2eSYQAO08tXzZ4EJqDl8H+KzEnrwnJx7B1ocyrLnBLanUlNSA3ZPjc6hiwj
         mQ3g==
X-Gm-Message-State: AOJu0YwmDfs3bbjwTduWbZjSzheebyMuXVk4MSlDDyvcAIQCcGXOrGVG
	84S1wb51hAb5REZjvJPPVuuJFe0HED0gdhxTVXd6qzQHQxNnF0jsEYr4sgtqRw==
X-Gm-Gg: ASbGnctY9ZNOITLAvjTGYgYK7DUQl9PNYv32gJTDOkq+hdz9lXUXLgE1BgEDFP+MSFH
	dxdhnlurEGUlYKT157sDLYAIpniYmomyOhQM/zdUTsL6mr2dWmS8IvwGAq06M51dGrTi8n7qe0Q
	OoZnY6D5Ju6sZxXJMJ9CSxPzKXKsPTQ4v+EWx+zkTo3WsNg7xot74fn7e+bkOf0QO5EjtrN6UlW
	ZOzVFnbo/MnG3xYaifqDEm0ySAw/ntGGoPhhzpUAVajFGgejbrpu+F7GMejuN5g+8GDbo9BlfM9
	TxxT6nJvvRCEwLOlwh0mlrtNTREoTzIWyssND5EbxDHEf2PcfTgpawuJc6cU96Nx7jfWUg+UHnE
	wmRZ05uxsVxaZhm4Lo2bJ+0fNnGAtzuVJJVg=
X-Google-Smtp-Source: AGHT+IFCH2gWQKCUJu1EOPU0v6Cws2dlqTaTzfBnzf811Oo7DkIEk+iGx/dfPZI9//dm1FYCme4UcQ==
X-Received: by 2002:a05:6000:40c7:b0:3b8:d271:cdc5 with SMTP id ffacd0b85a97d-3c0ec09e23amr1692715f8f.34.1755606069446;
        Tue, 19 Aug 2025 05:21:09 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.216.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1a97sm3501954f8f.31.2025.08.19.05.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:21:09 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 19 Aug 2025 14:21:00 +0200
Subject: [PATCH 1/5] fsck: order 'fsck_msg_type' alphabetically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-228-reftable-introduce-consistency-checks-v1-1-8b8f6879fa9e@gmail.com>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
In-Reply-To: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8717; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=mdOVCnYhc8iRJZxX5nwUv2T6y7i0YUVzfGhVZ4wRL8c=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGikbDP6IO12lSsOczrOZJsGORcYoCl+fXVMJ
 c/qQ7w7+Wm3JokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJopGwzAAoJED7VnySO
 Rox/PE8L/jHBQK2szwc5fYz9F5qs3tOg86OCp0qdwde0WwCqnaA2mE+JUqH2lbZ2kfbitpLbVIH
 Rx6fJTxWndoEyDMOMaA/PiaB3EomG4vuWAAYp/qiJyTDi6wzqswqbyBzjyhN+SsKdtUKNSBlKgB
 Vmxo7bzNj+qhgehJHD581F9LIzHl/yejrmkoKjxA1gzEucixAr6km2b4J3d0cXCIL7Yksg/9rHD
 WmJ/Mo3qvCIxEke2JiwDi8nzXAeUQEbqR4+2MgPG4S8t2dK5bZArBwokIdmpPfXK+iwINRBsE6z
 kxfHsWvw94MHEE/NBH5huJ0QwXmtUwviEUWWdCBqsQkrO0AiMjgaLO72R2g8edppai5Se+1nQFJ
 ixm+jv30an49EYxRPyst8H5460NmJrb1afNWh3rOKyE+PjI5/M9CBObkWBcfVAwf3oiSytHgdG/
 5IwIt5fiuRLWvrg8vN3TJRtobdugY2SOlyrwOiokxmRrJwKXuaDtASLSqr0LFDtcZp1hFbdiyJ5
 lw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The list of 'fsck_msg_type' seem to be alphabetically ordered, but there
are a few small misses. Fix this by sorting the sub-sections of the
list to maintain alphabetical ordering. Also fix a clang-format issue
where the escaped newlines are not aligned.

While here, remove a duplicate instance of 'gitmodulesLarge' in the
'fsck-msgids' documentation.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/fsck-msgids.adoc |   3 -
 fsck.h                         | 150 ++++++++++++++++++++---------------------
 2 files changed, 75 insertions(+), 78 deletions(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 0ba4f9a27e..1c912615f9 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -104,9 +104,6 @@
 `gitmodulesParse`::
 	(INFO) Could not parse `.gitmodules` blob.
 
-`gitmodulesLarge`;
-	(ERROR) `.gitmodules` blob is too large to parse.
-
 `gitmodulesPath`::
 	(ERROR) `.gitmodules` path is invalid.
 
diff --git a/fsck.h b/fsck.h
index dd7df3d5b3..559ad57807 100644
--- a/fsck.h
+++ b/fsck.h
@@ -20,82 +20,82 @@ enum fsck_msg_type {
  * two in sync.
  */
 
-#define FOREACH_FSCK_MSG_ID(FUNC) \
-	/* fatal errors */ \
-	FUNC(NUL_IN_HEADER, FATAL) \
-	FUNC(UNTERMINATED_HEADER, FATAL) \
-	/* errors */ \
-	FUNC(BAD_DATE, ERROR) \
-	FUNC(BAD_DATE_OVERFLOW, ERROR) \
-	FUNC(BAD_EMAIL, ERROR) \
-	FUNC(BAD_NAME, ERROR) \
-	FUNC(BAD_OBJECT_SHA1, ERROR) \
-	FUNC(BAD_PACKED_REF_ENTRY, ERROR) \
-	FUNC(BAD_PACKED_REF_HEADER, ERROR) \
-	FUNC(BAD_PARENT_SHA1, ERROR) \
-	FUNC(BAD_REF_CONTENT, ERROR) \
-	FUNC(BAD_REF_FILETYPE, ERROR) \
-	FUNC(BAD_REF_NAME, ERROR) \
-	FUNC(BAD_REFERENT_NAME, ERROR) \
-	FUNC(BAD_TIMEZONE, ERROR) \
-	FUNC(BAD_TREE, ERROR) \
-	FUNC(BAD_TREE_SHA1, ERROR) \
-	FUNC(BAD_TYPE, ERROR) \
-	FUNC(DUPLICATE_ENTRIES, ERROR) \
-	FUNC(MISSING_AUTHOR, ERROR) \
-	FUNC(MISSING_COMMITTER, ERROR) \
-	FUNC(MISSING_EMAIL, ERROR) \
-	FUNC(MISSING_NAME_BEFORE_EMAIL, ERROR) \
-	FUNC(MISSING_OBJECT, ERROR) \
-	FUNC(MISSING_SPACE_BEFORE_DATE, ERROR) \
-	FUNC(MISSING_SPACE_BEFORE_EMAIL, ERROR) \
-	FUNC(MISSING_TAG, ERROR) \
-	FUNC(MISSING_TAG_ENTRY, ERROR) \
-	FUNC(MISSING_TREE, ERROR) \
-	FUNC(MISSING_TYPE, ERROR) \
-	FUNC(MISSING_TYPE_ENTRY, ERROR) \
-	FUNC(MULTIPLE_AUTHORS, ERROR) \
-	FUNC(PACKED_REF_ENTRY_NOT_TERMINATED, ERROR) \
-	FUNC(PACKED_REF_UNSORTED, ERROR) \
-	FUNC(TREE_NOT_SORTED, ERROR) \
-	FUNC(UNKNOWN_TYPE, ERROR) \
-	FUNC(ZERO_PADDED_DATE, ERROR) \
-	FUNC(GITMODULES_MISSING, ERROR) \
-	FUNC(GITMODULES_BLOB, ERROR) \
-	FUNC(GITMODULES_LARGE, ERROR) \
-	FUNC(GITMODULES_NAME, ERROR) \
-	FUNC(GITMODULES_SYMLINK, ERROR) \
-	FUNC(GITMODULES_URL, ERROR) \
-	FUNC(GITMODULES_PATH, ERROR) \
-	FUNC(GITMODULES_UPDATE, ERROR) \
-	FUNC(GITATTRIBUTES_MISSING, ERROR) \
-	FUNC(GITATTRIBUTES_LARGE, ERROR) \
-	FUNC(GITATTRIBUTES_LINE_LENGTH, ERROR) \
-	FUNC(GITATTRIBUTES_BLOB, ERROR) \
-	/* warnings */ \
-	FUNC(EMPTY_NAME, WARN) \
-	FUNC(FULL_PATHNAME, WARN) \
-	FUNC(HAS_DOT, WARN) \
-	FUNC(HAS_DOTDOT, WARN) \
-	FUNC(HAS_DOTGIT, WARN) \
-	FUNC(NULL_SHA1, WARN) \
-	FUNC(ZERO_PADDED_FILEMODE, WARN) \
-	FUNC(NUL_IN_COMMIT, WARN) \
-	FUNC(LARGE_PATHNAME, WARN) \
+#define FOREACH_FSCK_MSG_ID(FUNC)                                  \
+	/* fatal errors */                                         \
+	FUNC(NUL_IN_HEADER, FATAL)                                 \
+	FUNC(UNTERMINATED_HEADER, FATAL)                           \
+	/* errors */                                               \
+	FUNC(BAD_DATE, ERROR)                                      \
+	FUNC(BAD_DATE_OVERFLOW, ERROR)                             \
+	FUNC(BAD_EMAIL, ERROR)                                     \
+	FUNC(BAD_NAME, ERROR)                                      \
+	FUNC(BAD_OBJECT_SHA1, ERROR)                               \
+	FUNC(BAD_PACKED_REF_ENTRY, ERROR)                          \
+	FUNC(BAD_PACKED_REF_HEADER, ERROR)                         \
+	FUNC(BAD_PARENT_SHA1, ERROR)                               \
+	FUNC(BAD_REFERENT_NAME, ERROR)                             \
+	FUNC(BAD_REF_CONTENT, ERROR)                               \
+	FUNC(BAD_REF_FILETYPE, ERROR)                              \
+	FUNC(BAD_REF_NAME, ERROR)                                  \
+	FUNC(BAD_TIMEZONE, ERROR)                                  \
+	FUNC(BAD_TREE, ERROR)                                      \
+	FUNC(BAD_TREE_SHA1, ERROR)                                 \
+	FUNC(BAD_TYPE, ERROR)                                      \
+	FUNC(DUPLICATE_ENTRIES, ERROR)                             \
+	FUNC(GITATTRIBUTES_BLOB, ERROR)                            \
+	FUNC(GITATTRIBUTES_LARGE, ERROR)                           \
+	FUNC(GITATTRIBUTES_LINE_LENGTH, ERROR)                     \
+	FUNC(GITATTRIBUTES_MISSING, ERROR)                         \
+	FUNC(GITMODULES_BLOB, ERROR)                               \
+	FUNC(GITMODULES_LARGE, ERROR)                              \
+	FUNC(GITMODULES_MISSING, ERROR)                            \
+	FUNC(GITMODULES_NAME, ERROR)                               \
+	FUNC(GITMODULES_PATH, ERROR)                               \
+	FUNC(GITMODULES_SYMLINK, ERROR)                            \
+	FUNC(GITMODULES_UPDATE, ERROR)                             \
+	FUNC(GITMODULES_URL, ERROR)                                \
+	FUNC(MISSING_AUTHOR, ERROR)                                \
+	FUNC(MISSING_COMMITTER, ERROR)                             \
+	FUNC(MISSING_EMAIL, ERROR)                                 \
+	FUNC(MISSING_NAME_BEFORE_EMAIL, ERROR)                     \
+	FUNC(MISSING_OBJECT, ERROR)                                \
+	FUNC(MISSING_SPACE_BEFORE_DATE, ERROR)                     \
+	FUNC(MISSING_SPACE_BEFORE_EMAIL, ERROR)                    \
+	FUNC(MISSING_TAG, ERROR)                                   \
+	FUNC(MISSING_TAG_ENTRY, ERROR)                             \
+	FUNC(MISSING_TREE, ERROR)                                  \
+	FUNC(MISSING_TYPE, ERROR)                                  \
+	FUNC(MISSING_TYPE_ENTRY, ERROR)                            \
+	FUNC(MULTIPLE_AUTHORS, ERROR)                              \
+	FUNC(PACKED_REF_ENTRY_NOT_TERMINATED, ERROR)               \
+	FUNC(PACKED_REF_UNSORTED, ERROR)                           \
+	FUNC(TREE_NOT_SORTED, ERROR)                               \
+	FUNC(UNKNOWN_TYPE, ERROR)                                  \
+	FUNC(ZERO_PADDED_DATE, ERROR)                              \
+	/* warnings */                                             \
+	FUNC(EMPTY_NAME, WARN)                                     \
+	FUNC(FULL_PATHNAME, WARN)                                  \
+	FUNC(HAS_DOT, WARN)                                        \
+	FUNC(HAS_DOTDOT, WARN)                                     \
+	FUNC(HAS_DOTGIT, WARN)                                     \
+	FUNC(LARGE_PATHNAME, WARN)                                 \
+	FUNC(NULL_SHA1, WARN)                                      \
+	FUNC(NUL_IN_COMMIT, WARN)                                  \
+	FUNC(ZERO_PADDED_FILEMODE, WARN)                           \
 	/* infos (reported as warnings, but ignored by default) */ \
-	FUNC(BAD_FILEMODE, INFO) \
-	FUNC(EMPTY_PACKED_REFS_FILE, INFO) \
-	FUNC(GITMODULES_PARSE, INFO) \
-	FUNC(GITIGNORE_SYMLINK, INFO) \
-	FUNC(GITATTRIBUTES_SYMLINK, INFO) \
-	FUNC(MAILMAP_SYMLINK, INFO) \
-	FUNC(BAD_TAG_NAME, INFO) \
-	FUNC(MISSING_TAGGER_ENTRY, INFO) \
-	FUNC(SYMLINK_REF, INFO) \
-	FUNC(REF_MISSING_NEWLINE, INFO) \
-	FUNC(SYMREF_TARGET_IS_NOT_A_REF, INFO) \
-	FUNC(TRAILING_REF_CONTENT, INFO) \
-	/* ignored (elevated when requested) */ \
+	FUNC(BAD_FILEMODE, INFO)                                   \
+	FUNC(BAD_TAG_NAME, INFO)                                   \
+	FUNC(EMPTY_PACKED_REFS_FILE, INFO)                         \
+	FUNC(GITATTRIBUTES_SYMLINK, INFO)                          \
+	FUNC(GITIGNORE_SYMLINK, INFO)                              \
+	FUNC(GITMODULES_PARSE, INFO)                               \
+	FUNC(MAILMAP_SYMLINK, INFO)                                \
+	FUNC(MISSING_TAGGER_ENTRY, INFO)                           \
+	FUNC(REF_MISSING_NEWLINE, INFO)                            \
+	FUNC(SYMLINK_REF, INFO)                                    \
+	FUNC(SYMREF_TARGET_IS_NOT_A_REF, INFO)                     \
+	FUNC(TRAILING_REF_CONTENT, INFO)                           \
+	/* ignored (elevated when requested) */                    \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
 
 #define MSG_ID(id, msg_type) FSCK_MSG_##id,

-- 
2.50.1

