Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFBA1B29A9
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899885; cv=none; b=Au+eV+nzLLBSkubSUU1Wtd8jnUx6xOFLybFIABM5AsHFMx8XL4sTyzgqD80ttJh6Jz0cpDU/4Df2IR2rAmH9sGXoQzPPCiZ5N0HHTxIdthgNzr6sOwj34gsPRl9u2ltw2C2xCiSMXr8Fv3kFE5rkkf+X3/3IyyS7M5xSyQQtOUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899885; c=relaxed/simple;
	bh=mKI90b/YGFpefVFGNK/0fVqAD9pGjE9PJw08JNb6Gps=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a47+9UEvep+2mzgOVPdTpvEg8M9PoK6r5daozt4ZKrwXddzJHSkxiA70bWTJdVHstU4Acl0A0UWb248aqOiZhSTdC1T2qn9+IGRyy8wyznZt+Iu6rnfscx59LBAyIbReQNDfRoisGFaVMzWwOVLqNS82nNv754yb0G9Ul7heup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lt8Nukdm; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt8Nukdm"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so12234491fa.2
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718899882; x=1719504682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xO1bF8/D+K6VmcsbNZerxp108u1S6w5egvhSyaxchUI=;
        b=lt8Nukdm/VyejH/nls+g12CT4K1AHNqdXskVd2zaKYhftBIg7v+MaDL9R/PVIPP0C6
         oBnY/IMjRFfPb9nHe+7PaVLiYfWBYd9f+kgaOvQk3I3VehkQDYt3LlbKZ1n1vG2vCOOD
         XBy7bDALQdsExQSUg2b2XqTxCzffPL8r6juxS83KWCHUfqh1z5dSHURwqaivRfk3QcCb
         Gg4PrTdi2X30q5GHy+3WpJhEGkwFypNs+QjqGV0Ijm9J9H7W8VFm1zNqOxRJH7230Xly
         XrCVyt27SUxP0fWHqsGhjIkA0IBb1aFHKUrtGQOvkB9CJzI9KsDGuvNr7XVTDb2lKGQU
         7Qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899882; x=1719504682;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xO1bF8/D+K6VmcsbNZerxp108u1S6w5egvhSyaxchUI=;
        b=ov3RPnTXix8Vtw7A9YS4v9w8C6BypFlZZ7EgA6+xKILsWxsXNYz7BQG99SNZQ9jPU7
         Y7ePmOq5Bh2l6bfKt8C7HUMzKRdiUDmh8JUEqPI+SI3M4Netdltiseq8CkwKGksRWhOv
         N/UF7DBn8cs3eA+3c73vaxJo9qSylRmjXRl6UYM006u0s+f7hsOxA5see2z4v4t4SFzN
         aMVzkOVScouqv5srdo24Cimq8YCaV3dHne8HBQbRRZUfAR4AIDkwYgJB54kQcwLR2aMR
         rXeEcMOMMMRqtwjAD4WsMxcVkHdBPPd6cRjkU7C9k7qN6YrCGMH81J8t7lrFE5SHiOX0
         sdMQ==
X-Gm-Message-State: AOJu0YwDXpakOmLKN+o4cdxa5Fo2jQTisSQj7oflyd/77QjZynyJtUkP
	RALvZvWZPNlGjZ2LgasF/s2KX38V8u3XR+lEptM7O25y25IB8DiwTNL5zw==
X-Google-Smtp-Source: AGHT+IG56n83uSNh5lOQBXb06vifRPGD7+uASq6D+3Vnt6BJtxTdRg8kld8WE5MGLGilqYECTCyoHQ==
X-Received: by 2002:a2e:9612:0:b0:2eb:fda7:e366 with SMTP id 38308e7fff4ca-2ec3cee1278mr44798021fa.39.1718899881759;
        Thu, 20 Jun 2024 09:11:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d1f6da9sm30398715e9.44.2024.06.20.09.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:11:21 -0700 (PDT)
Message-Id: <217594ffb103969c1a6debc07a6c7f72f6ee4749.1718899877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Jun 2024 16:11:15 +0000
Subject: [PATCH 3/5] sparse-index: use strbuf in path_found()
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    anh@canva.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The path_found() method previously reused strings from the cache entries
the calling methods were using. This prevents string manipulation in
place and causes some odd reallocation before the final lstat() call in
the method.

Refactor the method to use strbufs and copy the path into the strbuf,
but also only the parent directory and not the whole path. This looks
like extra copying when assigning the path to the strbuf, but we save an
allocation by dropping the 'tmp' string, and we are "reusing" the copy
from 'tmp' to put the data in the strbuf.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 sparse-index.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index de6e727f5c1..fec4f393360 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -440,31 +440,30 @@ void ensure_correct_sparsity(struct index_state *istate)
 }
 
 struct path_found_data {
-	const char *dirname;
-	size_t dir_len;
+	struct strbuf dir;
 	int dir_found;
 };
 
 #define PATH_FOUND_DATA_INIT { \
+	.dir = STRBUF_INIT, \
 	.dir_found = 1 \
 }
 
 static void clear_path_found_data(struct path_found_data *data)
 {
-	return;
+	strbuf_release(&data->dir);
 }
 
 static int path_found(const char *path, struct path_found_data *data)
 {
 	struct stat st;
 	char *newdir;
-	char *tmp;
 
 	/*
 	 * If dirname corresponds to a directory that doesn't exist, and this
 	 * path starts with dirname, then path can't exist.
 	 */
-	if (!data->dir_found && !memcmp(path, data->dirname, data->dir_len))
+	if (!data->dir_found && !memcmp(path, data->dir.buf, data->dir.len))
 		return 0;
 
 	/*
@@ -486,17 +485,15 @@ static int path_found(const char *path, struct path_found_data *data)
 	 * If path starts with directory (which we already lstat'ed and found),
 	 * then no need to lstat parent directory again.
 	 */
-	if (data->dir_found && data->dirname &&
-	    memcmp(path, data->dirname, data->dir_len))
+	if (data->dir_found && data->dir.buf &&
+	    memcmp(path, data->dir.buf, data->dir.len))
 		return 0;
 
 	/* Free previous dirname, and cache path's dirname */
-	data->dirname = path;
-	data->dir_len = newdir - path + 1;
+	strbuf_reset(&data->dir);
+	strbuf_add(&data->dir, path, newdir - path + 1);
 
-	tmp = xstrndup(path, data->dir_len);
-	data->dir_found = !lstat(tmp, &st);
-	free(tmp);
+	data->dir_found = !lstat(data->dir.buf, &st);
 
 	return 0;
 }
-- 
gitgitgadget

