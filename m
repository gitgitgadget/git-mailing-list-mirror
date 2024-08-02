Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B88211C
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722571860; cv=none; b=NxVmsRLdpPvGqEApjU1id5avEAmqQoKaIzRjOlk/ZQDX42B+xW7Awecl0sf6RdXEYkdVAkb9h8gqzW714rootlEXSUgyqHwsLw/XLp/XF6F13HBS5Nsivk+sX4l06LL8bNjCFjy8xlvxg7cJ/N3Z+/6mmpP1EQ2P80Fdk66haUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722571860; c=relaxed/simple;
	bh=LCQfj3yvljHS4ZQEAU/Dd+Azf/aRhLAvu6JOZ0jt9GI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WTqKT84k7cdeNunSNnq2Ie1Csn0hmr6q/75dFSN0/YBchGYkGmtGS93H09suEVAvcXz0T/LBeBJUiEQgQue5y8wMIYflNDOHgIkTjkN712bFaTGR4fCRAe1hZhpq7+xH5ZFEVncht9vNssJaSGB31M0fM8x3TDrvVg/P+ODOwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMGy0Gm+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMGy0Gm+"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3687ea0521cso4999001f8f.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 21:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722571856; x=1723176656; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q9jWaEEVSHSpUVon8iuemQjMxj0VGUTacBAHshjoh0=;
        b=RMGy0Gm+NWjvE28JNqDyYxgn17X2WGlYKqSCZIIyCz7HbCKpVgbmJkxfFWPiHGgN8r
         JKQkAO9qMuGMvkf3qszAJ+Yq43dG1/Ga9dnjoYXZ+hg6GaBrxCC3m6hc5q4u20ur8U+1
         xtIKCD6XCOQI+TliSQEOc9MdNrsow2ySjFMZQqdWfOnx0BOlYQ/l9j7kVel/Ubjggh7H
         D8BvJJSi/HT1L2cE61UaQ4NqtiRso1tG4//AGsjNe6l9MSt2v0Xdx639ml0sfIDL3Xvn
         f6OP3muq4V8OQ+/0T86WJrhRN+rfL5YqvS5IhruL9AHB8IiEKmW6rCppNmAptGeZmTnz
         eLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722571856; x=1723176656;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q9jWaEEVSHSpUVon8iuemQjMxj0VGUTacBAHshjoh0=;
        b=Z7RBlhmUU5X8htedyJ96bkf/pkUitAibQa3munnwPN/fe3TkMMfdPJxTvzi7vDkTs9
         kYL3weHb8K2JXU8dDCS3JJfeD0LuPDbrYFvDU375srHxFmZ2v3VmEqoXWEyZwYjY/svN
         Ol7MP+Rt3awiCeDU5araNSrCpb1rtYOZhUJ4UuVUuDMN9cVKAsFXrm3v4LwmNyN1BqOK
         ov/ElzN9WrbFVgz4/Cn0f3k3biI4nzlynk2OuiQICB5ZVbATGGwfSUikbasD712++51x
         6y07Vok0eggdg04xymMU9pXPzRBODh034hAVaO71uqVAJgs4YdfkDaGHiiD8SQKgNZfU
         2+Cw==
X-Gm-Message-State: AOJu0YwbDVAsOnWx5LaKk6MDvSqo2ITMHCMj/0yV1LF3ti1iucPaWenQ
	VcKfBs1/yXX3xDjwmlKDyPFl3eR4Abq8nw48GRpr8jQ3yu+yWBfdv8gFCw==
X-Google-Smtp-Source: AGHT+IFnLmNYO/U1sFuBvVk8gorkrnijHR4GBhByVrRfKK+it/kkdXpCWDxmQ7Fcd9O5AXemmEPn9A==
X-Received: by 2002:a05:6000:1c6:b0:364:ee85:e6e4 with SMTP id ffacd0b85a97d-36bbc1c49a3mr1468885f8f.53.1722571856268;
        Thu, 01 Aug 2024 21:10:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e08012d7sm47911795e9.22.2024.08.01.21.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 21:10:55 -0700 (PDT)
Message-Id: <0ed09e9abb85e73a80d044c1ddaed303517752ac.1722571853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 04:10:52 +0000
Subject: [PATCH 2/3] strbuf: set errno to 0 after strbuf_getcwd
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
Cc: Kyle Lippincott <spectral@google.com>,
    Kyle Lippincott <spectral@google.com>

From: Kyle Lippincott <spectral@google.com>

If the loop executes more than once due to cwd being longer than 128
bytes, then `errno = ERANGE` might persist outside of this function.
This technically shouldn't be a problem, as all locations where the
value in `errno` is tested should either (a) call a function that's
guaranteed to set `errno` to 0 on success, or (b) set `errno` to 0 prior
to calling the function that only conditionally sets errno, such as the
`strtod` function. In the case of functions in category (b), it's easy
to forget to do that.

Set `errno = 0;` prior to exiting from `strbuf_getcwd` successfully.
This matches the behavior in functions like `run_transaction_hook`
(refs.c:2176) and `read_ref_internal` (refs/files-backend.c:564).

Signed-off-by: Kyle Lippincott <spectral@google.com>
---
 strbuf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/strbuf.c b/strbuf.c
index 3d2189a7f64..b94ef040ab0 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -601,6 +601,7 @@ int strbuf_getcwd(struct strbuf *sb)
 		strbuf_grow(sb, guessed_len);
 		if (getcwd(sb->buf, sb->alloc)) {
 			strbuf_setlen(sb, strlen(sb->buf));
+			errno = 0;
 			return 0;
 		}
 
-- 
gitgitgadget

