Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC633A713
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406123; cv=none; b=aesreB6yPjoIfL1tnct9O2d5UASbiGlU3YhSq/LlqYkeCrmuk10UXgGnIxMXgEAs4vFbDWwjCpccWUaQyWel6F+WiLtZ06fSxoFwuw0Xhxclzm/+EM0Cj1uclb+MDPhK0pODh+AaJ5fm8tXOrqQdT1BP/mB//eeLCku1jmkZrxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406123; c=relaxed/simple;
	bh=JG8FBDA1wCdfiU08BbGa4qunZx7HTSdP/Qd5hsUUj70=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tfMuXCkykU+jIV4JYb1vKKbcU5AXvJxptVM0ZNlAU7uQyiPqRr1i3qMZRFf1CZpSmxdwAmVm8+Ee01+InB6Om7nvh4dB00HQa06M4bz3Q/kVaG5e0/rY8DHNhyiHOMiHnLfGE1KPl67waJSF9//8tN0wPkB/D2V7tyEHP/68gj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBS5AKx1; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBS5AKx1"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1270adc5121so6885652c88.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 01:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771406119; x=1772010919; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CQGfuiso84IbmE/wsuppdts8mNwf5Zi6yGwbBGw55U=;
        b=ZBS5AKx18dtWVF/c/wZKCeXNDNsviojm6f6uHJsvq2MQyhz8YtYcSxiK6dNTJKgdoU
         ioIUwbcMJT0dHolQcUz0zqoL+2m0qQHc7ig3czJjE4lO1GhkISGCtNeIRYzoGkYI5AFm
         twrJe2s0Hcg7bhUa2S+Z4evrokA6bEWO2Puy3GhLMpwGgmIIN6L8jadnK8QFqbP4fbMO
         8eFIrsJL5iT7clUZLlx+F6ECIoBvJdPR3XnGIJ85SSWOOPGjLSZxClDJyY7g5KXs2w/G
         DQlmczCrn9asXF5YclSVX1CTsg1aiNtiOcfoJ/V9rwrDIoRa29unkwpYNeIKNvGEaRTu
         GLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771406119; x=1772010919;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+CQGfuiso84IbmE/wsuppdts8mNwf5Zi6yGwbBGw55U=;
        b=MEulPlaKwoY+6CiGAQSvISB/x65Dv+umj1x2JoiRKkiAuQlk94W/KifASyZ5aeIWUF
         9tbDQy6qMycMGQO/R+XMX34zXPfFFbtLSXNEIkf7nG+/uFk1EnXgnaDxPyDuCwXBz5Mn
         iUrOMUXPNBjcPO99sLH7D/ilUN2aYNQYvUKO1E+3J1SteDtXTB2sII99IA+gIeubq5Li
         exvPYtkf8UpuayuBu4ZFvz0XmpbRU4masDZ6KhUp00Mx5bNTPpnSks8BuxjxgZzl/UGf
         3kLBfkR8ZA8+Y6XaViTVCT3ZkpQyvh/p/DaUI1fzOx/5Ix7sUm1nEKmD5KQqcjoTPSR3
         GBZg==
X-Gm-Message-State: AOJu0Yyjo2k7DG0WHK5TUrDofQBzEfZaLF2sAHv/T6WrdrQt+5UoJd3o
	mGRKRVBUGhhHIESzFSSzHFvuRxjsm5Yec/66AIfo1BxhIXQztYY7JNEtC26MAT9a
X-Gm-Gg: AZuq6aIZAEw82YDB3cTfgAlIwiaykdSxblnITKsINTh59CWlyVtCXw3Hsd4QlZftdsd
	2eLyh7QOYUycXqx70aDzqFa5gLsm0EYNCBSrhSD1v94wba8OcuL9ky/lBNwk6x8aSaoVUQH6W1K
	gaqpRqBnm3vRsvWm7AvKIYBh32Ih0ytuuu6CZgOz4RJeu7+B52e0v+xC0xYX2KBnFqmHiXW2s76
	yVb7OEUH4UkgSJFO+3J4MUSi8Epl+j2WKRj2dlUv41RxlLkDO4cXRSp+VUDuSPIr1GNIaPFYfAv
	d11wOEQoFV/35r2YZkgYkMM0ljMjrhCPxLAiQVxy/VCJg3evZ7qixVFG4IuS1PcDRl5kK43zNAs
	PKTCzIfRN4p+7NH8NaVRbr9t5nb9d0KGrlD0KE80BBv07NPg/JCX6Bffxj963zkUB/iudm+/O1G
	hWVSF1+BxF4351f24xyWOIKKkgWg==
X-Received: by 2002:a05:7022:4186:b0:123:2d9d:a90d with SMTP id a92af1059eb24-12759a14d49mr527838c88.17.1771406118747;
        Wed, 18 Feb 2026 01:15:18 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.48])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb555b6esm18078754eec.8.2026.02.18.01.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:15:18 -0800 (PST)
Message-Id: <620c4ea38bc539d87a07e4401f98fbf23be0df5c.1771406115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 09:15:11 +0000
Subject: [PATCH 1/5] merge-ort: pass repository to write_tree()
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

In order to get rid of a usage of the_repository, we need to know the
value of opt->repo; pass it along to write_tree().  Once we have the
repository, though, we no longer need to pass
opt->repo->hash_algo->rawsz, we can have write_tree() look up that value
itself.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 0a59d1e596..42499f7b43 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3822,15 +3822,16 @@ static int tree_entry_order(const void *a_, const void *b_)
 				 b->string, strlen(b->string), bmi->result.mode);
 }
 
-static int write_tree(struct object_id *result_oid,
+static int write_tree(struct repository *repo,
+		      struct object_id *result_oid,
 		      struct string_list *versions,
-		      unsigned int offset,
-		      size_t hash_size)
+		      unsigned int offset)
 {
 	size_t maxlen = 0, extra;
 	unsigned int nr;
 	struct strbuf buf = STRBUF_INIT;
 	int i, ret = 0;
+	size_t hash_size = repo->hash_algo->rawsz;
 
 	assert(offset <= versions->nr);
 	nr = versions->nr - offset;
@@ -3856,7 +3857,7 @@ static int write_tree(struct object_id *result_oid,
 	}
 
 	/* Write this object file out, and record in result_oid */
-	if (odb_write_object(the_repository->objects, buf.buf,
+	if (odb_write_object(repo->objects, buf.buf,
 			     buf.len, OBJ_TREE, result_oid))
 		ret = -1;
 	strbuf_release(&buf);
@@ -4026,8 +4027,8 @@ static int write_completed_directory(struct merge_options *opt,
 		dir_info->is_null = 0;
 		dir_info->result.mode = S_IFDIR;
 		if (record_tree &&
-		    write_tree(&dir_info->result.oid, &info->versions, offset,
-			       opt->repo->hash_algo->rawsz) < 0)
+		    write_tree(opt->repo, &dir_info->result.oid, &info->versions,
+			       offset) < 0)
 			ret = -1;
 	}
 
@@ -4573,8 +4574,7 @@ static int process_entries(struct merge_options *opt,
 		BUG("dir_metadata accounting completely off; shouldn't happen");
 	}
 	if (record_tree &&
-	    write_tree(result_oid, &dir_metadata.versions, 0,
-		       opt->repo->hash_algo->rawsz) < 0)
+	    write_tree(opt->repo, result_oid, &dir_metadata.versions, 0) < 0)
 		ret = -1;
 cleanup:
 	string_list_clear(&plist, 0);
-- 
gitgitgadget

