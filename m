Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148B158879
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578614; cv=none; b=YCk7Ia1d6zD4zEpQ2niKsfnTqu38mUmQcUh3Wy1aV4uOgpbsIxSUYFJWW9Yp6pQm1jfskcp19462LQPRRzd8qCTvwk2f16m9NkW41CViXrd5ZibPOTYc41g0yHgjeGovicKJLJab+O/eaClX1fedWZy6RyCIQEQeARsfTCp170M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578614; c=relaxed/simple;
	bh=mKI90b/YGFpefVFGNK/0fVqAD9pGjE9PJw08JNb6Gps=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PIRW7csIuWLaV3paesnsJwdbpuYK5qtYaJDvQpnsaRQx1cCKH4KaLwDSia+XVZ5p4LdAL7knK093G/l/cfPEDpWY1ePd597IyQXbDXpP9aXkVxYqrSu5AouxFvTSldZAV6S432TulcAG2SKSlPCZ3Edws3nzJSJH7ZOhZzNN/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2Zq0BhT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2Zq0BhT"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-361785bfa71so483956f8f.2
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719578611; x=1720183411; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xO1bF8/D+K6VmcsbNZerxp108u1S6w5egvhSyaxchUI=;
        b=C2Zq0BhTB25Ri4tkE8nEOarFGx+naDRW6vGRckmtftXxuSKBCSiMgbExsbr591RzXv
         Sqw8UUcTj0I3OEK22j/9x3tvp/UoybgJSUZgourXkOWAY2ebjbczopimuXOg4wkEul0V
         LdGuh0lszagqpAF+smJsyX+ZNm/kmAUyBHs9IeSLqjXqfAfCsaP/vvLVOlSFomI+c1+g
         QfA4qEb8MCInvna9HskbeSTRXqLfh/dtBSofldBm83HnwHDrYGsTwxPndMuba+E5ZdGx
         ZWmlhVWUeR9TzEey1pPC9ghm1a+B+g3bbC8aKICjFw3XkL21HxFKE1LQbLiwd8uoEaCM
         EIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719578611; x=1720183411;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xO1bF8/D+K6VmcsbNZerxp108u1S6w5egvhSyaxchUI=;
        b=F/qGYrH18GqdLb896rWZoWDVQvkdbrnojzxclKmkqr4U7+izWx8sCGIkzkrPvOY+C4
         ojFUCVPlIIC8ShAyeQbQUexO1LtPgrGbuVFgOdZH0Zhva8mQatA9gLuIC00xfjWSafZ8
         6htsY045/PayI4jGA/1vgk4iZKF/wBncg3qF/6zSqw9fMTd5e8vO+d0VzUjWXk8tRZ/w
         R48agswuTBt+jRR6OiC9XSLai7MiHIjh5Z7FQkmcHQtIuEPx38nw7jCL/gi/LRGK7Ezh
         IN/QmdMOJf+mYVg6v9FNW7BTNrDZk5jMC2nzROks9lyK9Z2kKQnBLO6d1WXPuuFUuDXs
         3Jfw==
X-Gm-Message-State: AOJu0YyMlyTkv3EBJ8zaYT7g81Med74jAfddvzVbKMYlITtRiJ1I0qEU
	al3y3Df0n829QlhHmoFJrrrXRb85FPMb7r7T/hLjVaFeyPBI9IUHonnnCw==
X-Google-Smtp-Source: AGHT+IGe1nOyykNhj+8nD266y61XJTEXdE8O/bd+fWFIkDSh/LEIwGD7bidiPjKsPVdsNTKrgF2TJg==
X-Received: by 2002:a5d:4982:0:b0:35f:d70:6193 with SMTP id ffacd0b85a97d-366e7a1111bmr10759823f8f.41.1719578611125;
        Fri, 28 Jun 2024 05:43:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd66fsm2271224f8f.8.2024.06.28.05.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:43:29 -0700 (PDT)
Message-Id: <ad63bf746caccc0f3359053826d102551dc519e8.1719578605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.v3.git.1719578605.gitgitgadget@gmail.com>
References: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
	<pull.1754.v3.git.1719578605.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Jun 2024 12:43:23 +0000
Subject: [PATCH v3 3/5] sparse-index: use strbuf in path_found()
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

