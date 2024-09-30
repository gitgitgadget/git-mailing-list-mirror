Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7660C17DE1A
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696431; cv=none; b=lxV79Zsu3nculKR9HWqh1iNt8CLqFCxJ10HFredWMyUgTds+NnFfRnQA0bIv5UjRhuU+HhIx1f+ClY82dlgkP10GhBrFaKOmhs0f7bKmdr96qomw664tCut6v5EXNvPa3Vs+D8sKSzdFhNRLU+mwQGJXQIdPcuSyYHJTlz0bkCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696431; c=relaxed/simple;
	bh=oKSzbXVM5M0OtGUGq9xsIinWnNWGHnKx1Ds5ekVnxnQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SexlUd8R8J8c7gOkHIf7sYK4duZkiI3VLn9Hk/7p0fE5+rPFu4isGA6+rpK+i+B/rAhD4m9zXFuuWnHdrQsQo8YJsPqO5qYG4zVJ5aFxoguBrBnFEKA/KsGl7gbT4EWKA+b73MMQdVJJ2A9wWaCoUFQrCfz+0xbbUxrldqe0L64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8IlGDdc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8IlGDdc"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so5959133a12.2
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 04:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727696427; x=1728301227; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XN9iLkUoAnGJt4Q6gmQPoaOhS5ahD7+RUYguHybe96Y=;
        b=h8IlGDdcT2GgIr9iQ4qir4P9cnbtKt76v0cB7YY0VViG4GtS1BWe5mIdS7EBbldoZ3
         mMrx1ptGsrgHJrPLqtGSNXvLnXUJazFRPtO5PcSbv/347Oj/uTMkZXeqDA3cprZuo6Ih
         VLMVMqL7MqJoLCwQlJPY24gMNmzwEX8jhJWUiy70GlNasEd+pY6fBwVJy8IjgDrQRsi+
         7WxM21CPPi02HrPl/jj7bTw1e8E2nD910oWMVjBhgUKPR7J8zziab1wfiFAmdEaXpe58
         1MGymY0I8oZX3w982J26XmrzlxpP39jz4S6e8CuMKN9XiPTCZcuaNqupgGD/UKNH/b8N
         Na0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727696427; x=1728301227;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XN9iLkUoAnGJt4Q6gmQPoaOhS5ahD7+RUYguHybe96Y=;
        b=gzpjPV3E4yWaOqDwAcVY2tR5g2sWncW1FbX/4zJliDMTQLyaICfQweRm0dDzkrnDjf
         4U6bMzTEu5xW15iB5/cEV0mi7TSLbp85cmRfJhbMw/eVPovQ5aogM4X2ExNbuasGLpdq
         ZoDMXKYPpeTD8GuWE7uX2R5dvirhW6gKPYWR0xziFv4iNmCXiFlNRs7oKcTk51DiwTa8
         nVUEhA30s0uNbL84qyZMATUKczjjVLrbH7aWt61Er0KlVZrgfcC/AN059thJ0XMMgECj
         dK3MCfGu5KgaiIyXyAWKmPKENH0Mwmh0inLkOriC7W81pKzlUL/jOvG/pQ4omx44uBLd
         v+ng==
X-Gm-Message-State: AOJu0YzULrgHX3kZkNRwogpWxrmSxcnrRlXN9r3VlEjsDmm90yYv4aMV
	yCdG1V70K1K54HC626qh9VtFxGpqMi3+gRrEga5TD/XzE5tG3IARiQewwg==
X-Google-Smtp-Source: AGHT+IHlQWXM5nK/TIDTfH/tfk/Sy4RQa2vcI1BmtkbcJ5VGT/pyi2FOa1zlLpgnDtJP8jpMT+OWTQ==
X-Received: by 2002:a05:6402:1ecd:b0:5c8:8322:b159 with SMTP id 4fb4d7f45d1cf-5c88322b203mr8763677a12.26.1727696427229;
        Mon, 30 Sep 2024 04:40:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88249540bsm4360217a12.96.2024.09.30.04.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:40:26 -0700 (PDT)
Message-Id: <b6fe5b3ef7e5f4ac8cc339685d92e3ac39fcb456.1727696424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1801.git.1727696424.gitgitgadget@gmail.com>
References: <pull.1801.git.1727696424.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Sep 2024 11:40:24 +0000
Subject: [PATCH 2/2] read-cache: free hash context in do_write_index()
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
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

While writing an index, a 'git_hash_ctx' is allocated for hashing the
file contents. This should be freed as the method exits.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 read-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/read-cache.c b/read-cache.c
index 3c078afadbc..51845c2e611 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3126,6 +3126,7 @@ out:
 		free_hashfile(f);
 	strbuf_release(&sb);
 	free(ieot);
+	free(eoie_c);
 	return ret;
 }
 
-- 
gitgitgadget
