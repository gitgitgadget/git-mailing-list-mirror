Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C449634
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632294; cv=none; b=a8BIXiGU2Sj3xB3xv5wkGMlVANGWT3RT6+9hxPbbAk7WbZwTfLlwFvKfIlo3dy56qwYu9FUqjGTloDKxHVGgx3MdLXSIHL4OlSc/GvgB6ODTbCXITT8k1QQYhTeniTMDOuW9ppN1v4MAlJayRuCxulUzOE2kuaBiE4aeNIyBu24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632294; c=relaxed/simple;
	bh=LCQfj3yvljHS4ZQEAU/Dd+Azf/aRhLAvu6JOZ0jt9GI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=h7b2inPTtYFWcVxqLWlCOSj8cZbtCCXjN1M5sDFhQUQU/xBn7mjle262mDVOlgn79cM7LCdtSz3diVHYm8CWUf7oqkfUwBnKUhPJ7yNaZBdmXHT1mDRDUNRbi84aFH+13kU0kigbzu2ckXR+j3JRGl2a9f3EQuJHog4TH46oCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8pMHjSC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8pMHjSC"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-368313809a4so2124605f8f.0
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722632291; x=1723237091; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q9jWaEEVSHSpUVon8iuemQjMxj0VGUTacBAHshjoh0=;
        b=W8pMHjSCxanWFjpXji1RuohV+JMFIv6lf9GaONnn4dIy8QhfUlW+NasSMXu2jbJi49
         IjSk1qxhWnZELS2KOYu0hLFFeUtaV5ZELEghgdc34Bf0zlZdbTxib4OJUgfzJNIaS7Sx
         iKdVhJMn0M0YeHLiGY3mvOe8Ys9wgCjZbXwOzsNpttSUV5OfzFOCegWYvoifzQNX9Gsb
         c7vUJ25tOlgxtcdZbqoSaHD+CK6Ealp3DLV3nHCcVZC4NYt/ienMZFADhcRkHq8HZJF2
         twFmB72uBHaQENd5BmyE5wzBUkpH3aKzLt4WW4RimfbtWnvQ1IDg+Zf7CmEnXF78/UfG
         xeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632291; x=1723237091;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q9jWaEEVSHSpUVon8iuemQjMxj0VGUTacBAHshjoh0=;
        b=XVvW/N6aSz2g4ndMEm/rgvI1z+i/A6ukXTZLC8DhZpR3sciYthd5db7wuBM+F313uD
         v8Rht1bg4RaHqC9cWB0N3Zlbi7JqoFZ5J4923irWur7b0dX0oX1s7TRzcFNlF13eOY3c
         ucGG/YNs3RTbYJM/3/oTUIQI5eL26gkoMqTA6B/nwnUytPawW7DD4R+dT/HA8+PJaaZ2
         nUKL7Uw1bz++ShUYx2gI5isGO5M0Bthv6Z9Kv2nqIm+wyxx8pM43Hhpl4AmU19SCZeKE
         yNJPCJYYY+S3YkGKXzVfSwQsOKVF/xPbjgXtIU0LM/10pGjXuGyKLtIo85iNl0hbK4xO
         NtvQ==
X-Gm-Message-State: AOJu0YyvItliTA6ICyLi4jhA8LsROy9Y5BK6100tWsn4I27oNmTJ0y51
	XGoGZ3LRXeCDb/jALJBf2R/QdsKMO/bWQUQ47cSXruC2mHGM7/Erupq1GA==
X-Google-Smtp-Source: AGHT+IE7B0zk1DewGroAOOOcqIZOFbEGXS+3ASahFjsVbNDfSEQke++IYDwR56nQfhB2GDF2dGTplQ==
X-Received: by 2002:a5d:64ab:0:b0:366:ea4a:17ec with SMTP id ffacd0b85a97d-36bb358466fmr5882385f8f.2.1722632291095;
        Fri, 02 Aug 2024 13:58:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e329b6sm44193225e9.20.2024.08.02.13.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 13:58:10 -0700 (PDT)
Message-Id: <0ed09e9abb85e73a80d044c1ddaed303517752ac.1722632287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
	<pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 20:58:06 +0000
Subject: [PATCH v2 2/3] strbuf: set errno to 0 after strbuf_getcwd
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Kyle Lippincott <spectral@google.com>,
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

