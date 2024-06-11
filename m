Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618272746D
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130296; cv=none; b=hUY+r189WTUD2ptJOHE8PJxNizAom5uHHMGy9iTL5GFJX3x4FCuOzdtA/fqJ8e0lonhzNgVMqmeeG/pYxv88JwQtcW+lMQF+0d84Zt4DrHyMC4B2EBpofhpsL2JuwITUac6D6l3L9oyyZPy5nkVNeBnetcc9MMSmL6swJg1sNeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130296; c=relaxed/simple;
	bh=Y3uGIenf3VzNzcILgOt57Fdj/xN4aa5LA6kSN4497Ug=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sNbRTxslLKq7Z17CYI4e47n+TQnIhEg3zK0aGIxi6AhhHdzy2D9y33r0Izvy+FejoY8C+JaHnNlt++dbLWic0s57k8mnySaQ7clGk/thH4Xy6QxD7fLpsICypg1ha8cn4FdpJJkexgYa8n7EvfuHGs9fDt75gj5Q685rsDeFC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBMpXOYG; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBMpXOYG"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso64444081fa.0
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130292; x=1718735092; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Urh7rNdpn2o/o6whqr985oqkaAGHqzZf69s+OZ65PsE=;
        b=jBMpXOYGyaxiCKu4F+h6nmnBOw2lbi+sugBIWRDqHC4Tj7wZLbZ5XHkH5B63wXbPff
         zb+EaxoFGYS6q5doJSvOvGTv1BzCDJiPhCvBemt7R79lEyOBXfi9LDTLJUnn+S+/VZlm
         wVV1ZRQRDdgH80RbqU85HmeSPmX0yhO+l+a4Otbg3TJFqCdXU5j1FSPIq4RrFgXHlmYN
         1I3GRbd8LgsQsoPXM3tqzrkLfOAzg4WQNj66sqZsq+aE3TFsiuZsFpfHBP129AN5U18a
         ART1OetZuvkvKNgBZniELYfJzeb/RInesOZz07/m0At1V2TSOYEZYhiPeViOwoTynU2L
         aYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130292; x=1718735092;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Urh7rNdpn2o/o6whqr985oqkaAGHqzZf69s+OZ65PsE=;
        b=YnYCiR0FHfBjjZ5LRm+3fKXXDGQ2MND8yrrNjYaiTycqu+PfqDjNi7+sJ4cBqESlRq
         WQ1lGzew0CQzdQnPL7nVGrqjfkT0Huo80WU2WHFxjQOSES7pWiTRGqWyle/77m4J6XHg
         /uvZ3i0XfQZ9qSg8ZSmwFdMC1QA4nzecjjb7wgKs3vjhN9ymLhvY1p65lmgBQjD71S8A
         4toE7CmhbPwCy3G1Pke9bEcIGFdKgAjKy0+5wi12ikOTEukrYViuijWVvHsmB/UpkynK
         eij93tjyDvf4n1umka+KPXBIMJ4llPz2Y9jD2QCnIRGXtDLRhiL/3A44jxvj+QCRq6ai
         aO0w==
X-Gm-Message-State: AOJu0YwpqBnH/KbJC27syB1HKVOzJkzQVrel5dv/DQBVJnxSyOJXy+yz
	e+c+CSv40zYvvSZI9tIl7o3ay00AJlSph5apugug5SGznuIfFfjTDFtZig==
X-Google-Smtp-Source: AGHT+IGtTbd6ANRM+Ti0MF8j6dXWqQ3Pjyax1fgrjO+XE/QlbJJWwZ58lX0beMXqjfTpE6xOdnGhaA==
X-Received: by 2002:a2e:3615:0:b0:2eb:e9c0:ab69 with SMTP id 38308e7fff4ca-2ebe9c0ac3bmr33700901fa.39.1718130291889;
        Tue, 11 Jun 2024 11:24:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421f053bf89sm67305055e9.26.2024.06.11.11.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:24:51 -0700 (PDT)
Message-Id: <4558f35e7bf9a1594510951ee54252069bdcfc5b.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:34 +0000
Subject: [PATCH 02/16] mktree: rename treeent to tree_entry
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

Rename the type for better readability, clearly specifying "entry" (instead
of the "ent" abbreviation) and separating "tree" from "entry".

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 8b19d440747..c02feb06aff 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -12,7 +12,7 @@
 #include "parse-options.h"
 #include "object-store-ll.h"
 
-static struct treeent {
+static struct tree_entry {
 	unsigned mode;
 	struct object_id oid;
 	int len;
@@ -22,7 +22,7 @@ static int alloc, used;
 
 static void append_to_tree(unsigned mode, struct object_id *oid, char *path)
 {
-	struct treeent *ent;
+	struct tree_entry *ent;
 	size_t len = strlen(path);
 	if (strchr(path, '/'))
 		die("path %s contains slash", path);
@@ -38,8 +38,8 @@ static void append_to_tree(unsigned mode, struct object_id *oid, char *path)
 
 static int ent_compare(const void *a_, const void *b_)
 {
-	struct treeent *a = *(struct treeent **)a_;
-	struct treeent *b = *(struct treeent **)b_;
+	struct tree_entry *a = *(struct tree_entry **)a_;
+	struct tree_entry *b = *(struct tree_entry **)b_;
 	return base_name_compare(a->name, a->len, a->mode,
 				 b->name, b->len, b->mode);
 }
@@ -56,7 +56,7 @@ static void write_tree(struct object_id *oid)
 
 	strbuf_init(&buf, size);
 	for (i = 0; i < used; i++) {
-		struct treeent *ent = entries[i];
+		struct tree_entry *ent = entries[i];
 		strbuf_addf(&buf, "%o %s%c", ent->mode, ent->name, '\0');
 		strbuf_add(&buf, ent->oid.hash, the_hash_algo->rawsz);
 	}
-- 
gitgitgadget

