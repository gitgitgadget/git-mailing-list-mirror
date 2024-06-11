Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A81F74E2E
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130298; cv=none; b=VsN0vzqOCRdRbDhTbJ0cPo8fVoOU84LsmD2PqmS3y3RcqUKZi4DCpD8v6cm71uCz7sJigwgYw6N0yREk5jXwWcaYHeFLEZwT6ZtSK8XEB6ZbDvjMp9n9RwG6yzjsSnXlAOGSRkKSyzn0araqILtr0qNS8xb8yotjty5Jp6QRxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130298; c=relaxed/simple;
	bh=kEfIRVZqmQ7lQD9kQ6ckbaiUmjNHuzqSf9NtVk8uWsA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kuXJLfHvHljICB8oAKzp8FnGoW/+06WC+tJ4xGx8fYtKNKZMldvVuNsIoG8YgVTxTdneU5DPQgTqlaSa22egoYtMtN3t9DpGojHKSgL1vm+1+Yb8CklAhR2oNrecYMPYt3GqXx5n3XI5HZdE0fklfq+QQBOhQIDYgak68upKgaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWKoTwCk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWKoTwCk"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35f123bf735so991646f8f.1
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130295; x=1718735095; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SavWhNI94OBdgyA467GiVzYUN+BXnMl+ZcQRz1bzBfE=;
        b=lWKoTwCkOhyiKtuJFJn8va2dW/FDSl8lwOo7AZxoKMM+p3xP/JZrecJZ2evYJ2xziC
         /JZYEOJtyeEcK2IXumA3JzlzVxAHO5DHZxiQmeTRRg802Y14KwdT0rkpQ19Q7he0CR7C
         /LuoJMxLcqU8E6YqiU2KZlXTv15kmE8Nk/sImOKVdVYNwo5yXaDV4KG0J4Yx3RLEHy02
         8bbVeU1olneXZPU37+xtt8T4IADkMuPPQELFcmsjRZVWuY8tQYrBV2jI69E/9lnuYm5J
         imb8jopxcODvwc6HAoi/OqHLfoTWWNSeILznZzNiG3rXe9J7fDFuuo4/aCIi5zN8DtsB
         6gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130295; x=1718735095;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SavWhNI94OBdgyA467GiVzYUN+BXnMl+ZcQRz1bzBfE=;
        b=VhG1l6sQ1KyqpdNYKVAcA6uSGFfaQFOugiDvnzXnLU45k3WqaGFE8Yb0ZIkOaBi/4y
         QuAkdV0FKBclm+hTzgD+/YZ+7eTarQ8AI79Wln4dgQDA/T6HwULB/k4hoy+nAPPoe509
         fA53IN8ZdHNAVrevoJgaq+WLQz4T5ZP8aPqwhisWYOlSrRUgF+pwOG7+W82XtUuJii67
         RUWEeDbuReq+/NbdN15BxYxE4G7zHf5XnSnAtKQCVsgkTCrmE91Anwvd/oDyiEXRwE2F
         EFMfuNswWEZwJyQuDpoTSv0xS0uACcVq2b0vsQw+O64bAoPUAv9P5rxjJ4FUyWgCDhtX
         VjFg==
X-Gm-Message-State: AOJu0YzKumQBKNEk3RN+cGuacWyNnk61XKWQ5VulIkGZWnWW01klWqJN
	XMAtvSlN4XCvA81UReWJw9VUMq2lovOKyp7QLQqyY6K9rUl2Uh93PYPKuw==
X-Google-Smtp-Source: AGHT+IEYk3LsqNrF+/ysSXYFf4WB/q5xwoGKAHiyEi0AXRJ6szkdCGODBlXdW6tXy7TlF6Hl++BsiA==
X-Received: by 2002:a5d:618c:0:b0:35f:29da:2345 with SMTP id ffacd0b85a97d-35f29da23e0mr3755340f8f.16.1718130294741;
        Tue, 11 Jun 2024 11:24:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f23df9f3csm6347945f8f.76.2024.06.11.11.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:24:54 -0700 (PDT)
Message-Id: <f56eee0b48da907a27edc99ca135cf8f6c19af35.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:38 +0000
Subject: [PATCH 06/16] index-info.c: parse object type in provided in
 read_index_info
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

If the object type (e.g. "blob", "tree") is identified on a stdin line read
by 'read_index_info()' (i.e. on lines formatted like the output of 'git
ls-tree'), parse it into an 'enum object_type' and provide it to the
'read_index_info()' callback as an argument. If the type is not provided,
pass 'OBJ_NONE' instead. If the object type is invalid, return an error.

The goal of this change is to allow for more thorough validation of the
provided object type (e.g. against the provided mode) in 'mktree' once
'mktree_line' is replaced with 'read_index_info()'. Note, though, that this
change also strengthens the validation done by 'update-index', since invalid
type names now trigger an error.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/update-index.c        |  3 ++-
 index-info.c                  | 16 ++++++++++++----
 index-info.h                  |  3 ++-
 t/t2107-update-index-basic.sh |  5 +++++
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index b1b334807f8..8882433b644 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -510,7 +510,8 @@ static void update_one(const char *path)
 	report("add '%s'", path);
 }
 
-static int apply_index_info(unsigned int mode, struct object_id *oid, int stage,
+static int apply_index_info(unsigned int mode, struct object_id *oid,
+			    enum object_type obj_type UNUSED, int stage,
 			    const char *path_name, void *cbdata UNUSED)
 {
 	if (!verify_path(path_name, mode)) {
diff --git a/index-info.c b/index-info.c
index 735cbf1f476..5d61e61e28f 100644
--- a/index-info.c
+++ b/index-info.c
@@ -18,6 +18,7 @@ int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
 		char *ptr, *tab;
 		char *path_name;
 		struct object_id oid;
+		enum object_type obj_type = OBJ_NONE;
 		unsigned int mode;
 		unsigned long ul;
 		int stage;
@@ -56,18 +57,17 @@ int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
 
 		if (tab[-2] == ' ' && '0' <= tab[-1] && tab[-1] <= '3') {
 			stage = tab[-1] - '0';
-			ptr = tab + 1; /* point at the head of path */
+			path_name = tab + 1; /* point at the head of path */
 			tab = tab - 2; /* point at tail of sha1 */
 		} else {
 			stage = 0;
-			ptr = tab + 1; /* point at the head of path */
+			path_name = tab + 1; /* point at the head of path */
 		}
 
 		if (get_oid_hex(tab - hexsz, &oid) ||
 			tab[-(hexsz + 1)] != ' ')
 			goto bad_line;
 
-		path_name = ptr;
 		if (!nul_term_line && path_name[0] == '"') {
 			strbuf_reset(&uq);
 			if (unquote_c_style(&uq, path_name, NULL)) {
@@ -77,7 +77,15 @@ int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
 			path_name = uq.buf;
 		}
 
-		ret = fn(mode, &oid, stage, path_name, cbdata);
+		/* Get the type, if provided */
+		if (tab - hexsz - 1 > ptr + 1) {
+			if (*(tab - hexsz - 1) != ' ')
+				goto bad_line;
+			*(tab - hexsz - 1) = '\0';
+			obj_type = type_from_string(ptr + 1);
+		}
+
+		ret = fn(mode, &oid, obj_type, stage, path_name, cbdata);
 		if (ret) {
 			ret = -1;
 			break;
diff --git a/index-info.h b/index-info.h
index 1884972021d..767cf304213 100644
--- a/index-info.h
+++ b/index-info.h
@@ -2,8 +2,9 @@
 #define INDEX_INFO_H
 
 #include "hash.h"
+#include "object.h"
 
-typedef int (*each_index_info_fn)(unsigned int, struct object_id *, int, const char *, void *);
+typedef int (*each_index_info_fn)(unsigned int, struct object_id *, enum object_type, int, const char *, void *);
 
 #define INDEX_INFO_EMPTY_LINE 1
 
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index 29696ade0d0..9c19d24cd4a 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -153,6 +153,11 @@ test_expect_success '--index-info fails on malformed input' '
 	test_must_fail git update-index --index-info 2>err &&
 	grep "malformed input line" err &&
 
+	# invalid type
+	printf "100644 bad $EMPTY_BLOB\tA" |
+	test_must_fail git update-index --index-info 2>err &&
+	grep "invalid object type" err &&
+
 	# invalid stage value
 	printf "100644 $EMPTY_BLOB 5\tA" |
 	test_must_fail git update-index --index-info 2>err &&
-- 
gitgitgadget

