Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA9191F81
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804270; cv=none; b=Qul234whZquDe7+EyxKNYQ9iidebM1zrHE5D+5QWSYScxtMePSbMrcw0Y9XNhjL5i9R8IC6mWSjvnRKrXAmQbcWTW/LxV84f6DR7gJUF9ya/Nrt2nJOmQsYctrOF6w15bKt2arpc2c4es++2XF8/7yjrO0yb0WouoHCV2glUKWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804270; c=relaxed/simple;
	bh=wWpIezsGcT/WUFX8UA7XDX9Q1fwFWAgPPsqjRR8U0Vk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KhvsANrFGkwMjgm5F8SFuneFEkgvFYIAZ3auO22iOtv3xA07Tp1Oqqb+uSpJhW+zhmrWDn9VyWb9UQ75YzeYbvXi6CYy0sC89lz81i2m1hTVlez0Eky2dX8MouBRNv99EHd4gKogrdpTgpxqV89/y2HeQ73XTw3fW4vpirdcz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WA99qgHT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA99qgHT"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so8545666b.0
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727804267; x=1728409067; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWBAVfPkB9x3Oagx3K7gqidcrLLvjYnoMT+jiAh1+lU=;
        b=WA99qgHTHcXiQo/qdvMLgYFkOc1kbcSrL7z7LnjJCaLGoaeNDXTdydv4Wu25aidBaU
         ucei1d+A5o4Y0fiBoM607W1PBirgKTRMcrONku6mOjvkXegckBiOBeszpasWlAtmWJpu
         NUqLWq8VJ6nI5FpR6fTZJqJiRVrZzkOd9U+KYsALBDfg2LYydrhyJCgMQMaMVm4Ts2C8
         amZTuwfuDiUVcvdC/S51gVwwAbPA7lXxM2wjAY7C7o9XvgG7h7h+MH95EqZzk59feXgz
         eRd/NoMb3k+b9mw5iFXrOqhq0RJgRvCR0K+pn7cxo0pv8Rn81ewUNq3/8SYSmlv1BWix
         KFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727804267; x=1728409067;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWBAVfPkB9x3Oagx3K7gqidcrLLvjYnoMT+jiAh1+lU=;
        b=HeKOlC6GXbsHecXQlFSpVIfsjZ+b3c1AerQdPmymC1a42LeYEyzi1mGzlCQnnd4ydJ
         BOG7HURSZa3JjJ64sezYBmJnHGA7xZO+NmliN36EiRyPgxeLWCrl7kUL2V22NTaGYrQG
         +XyR1hT9M31YMsY/unJD+wbe4ejuXsoEjBeh4sm6Av0vIhqT9d4llVNF8MnmWTxe3L5x
         rWYSgClqFZPhOwP7yiA53iz3f1szx1Ven02WIHJ40xOXP2KfsChSwYVYKS2Z4arfSKIh
         zZlNfl+TPoMMeoHWUW6rSKtJC2q7fUNJMN12MmtcCPoUimce8xT/OiAK/17zoRIbUXVa
         aWVw==
X-Gm-Message-State: AOJu0YwQGeoOXuRJAyh/4K9W906ZEPXhxceT+RUwLM3fqY70jrgBxqov
	RGpGP7PeJUl4sx9hwTEBP+gYFfgjstmFpX3j8gd+/gXDhYq70sMNM21inw==
X-Google-Smtp-Source: AGHT+IE4AB4BcQyIDU4EsQcwQ7antztw6X9ra8KyitpvPqS3Oy2TDe1LDKtCsaMuaQkKoHMOCKgwbQ==
X-Received: by 2002:a17:907:6e8c:b0:a8d:4c83:d85d with SMTP id a640c23a62f3a-a967bee906fmr471966366b.12.1727804266374;
        Tue, 01 Oct 2024 10:37:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c29a0f83sm741801966b.210.2024.10.01.10.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 10:37:45 -0700 (PDT)
Message-Id: <pull.1801.v2.git.1727804265033.gitgitgadget@gmail.com>
In-Reply-To: <pull.1801.git.1727696424.gitgitgadget@gmail.com>
References: <pull.1801.git.1727696424.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Oct 2024 17:37:44 +0000
Subject: [PATCH v2] read-cache: free threaded memory pool
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

In load_cache_entries_threaded(), each thread allocates its own memory
pool. This pool needs to be cleaned up while closing the threads down,
or it will be leaked.

This ce_mem_pool pointer could theoretically be converted to an inline
copy of the struct, but the use of a pointer helps with existing lazy-
initialization logic. Adjusting that behavior only to avoid this pointer
would be a much bigger change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    read-cache: two small leak fixes
    
    This v2 removes the duplicate patch and updates the commit message.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1801%2Fderrickstolee%2Fleaks-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1801/derrickstolee/leaks-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1801

Range-diff vs v1:

 1:  9a45b15ea4b ! 1:  220a098c93c read-cache: free threaded memory pool
     @@ Metadata
       ## Commit message ##
          read-cache: free threaded memory pool
      
     -    In load_cache_entries_threaded(), each thread is allocated its own
     -    memory pool. This pool needs to be cleaned up while closing the threads
     -    down, or it will be leaked.
     +    In load_cache_entries_threaded(), each thread allocates its own memory
     +    pool. This pool needs to be cleaned up while closing the threads down,
     +    or it will be leaked.
     +
     +    This ce_mem_pool pointer could theoretically be converted to an inline
     +    copy of the struct, but the use of a pointer helps with existing lazy-
     +    initialization logic. Adjusting that behavior only to avoid this pointer
     +    would be a much bigger change.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
 2:  b6fe5b3ef7e < -:  ----------- read-cache: free hash context in do_write_index()


 read-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/read-cache.c b/read-cache.c
index 764fdfec465..3c078afadbc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2188,6 +2188,7 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
 		if (err)
 			die(_("unable to join load_cache_entries thread: %s"), strerror(err));
 		mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
+		free(p->ce_mem_pool);
 		consumed += p->consumed;
 	}
 

base-commit: 6258f68c3c1092c901337895c864073dcdea9213
-- 
gitgitgadget
