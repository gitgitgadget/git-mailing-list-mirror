Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C812B7E76A
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196371; cv=none; b=J5El6slhrueg5bEn+WL/3o0aVbXSPCmma2CVlj7+wyi6AfPg7XK58bCVH1RFwFsqc2yirzETdEy1wqlqK+h7nffVTz4tWMVf2b3jUnZxRUMMFOI86cudXK5ZyJ2y2PaD+nw1QBs0poospYjm6Fx7rkYaij3Nvz2AjwV36xd1XdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196371; c=relaxed/simple;
	bh=9hvSa8WrDHCUaihb+X5z+TWaHXI6gtvLgDz/ok8BOjQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cPW25tscIml0f9sLFK9tn2dXMUPV51ErprLVRAA5pA6OoLQJOVVEFs60qfXD6s/GxrqnQlmgyaoilGBur3YXD4t5132E76RpKu2JAvGyTaFarMZKLEKHil27zy37RNjQayp3tdD5E4g0GXXzMnOQbvJasrVJOfRgbtjJFt++4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3ry4/gr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3ry4/gr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so45266625e9.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196367; x=1707801167; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5Zzk0WUsCLkmxXmChJvEQeJowFe443M24XcTYF5Rvg=;
        b=m3ry4/gr5FNtJD4uwnNysUgLZJAQiqJBdwvlJk2NWaXWY+gNgWqOpp1y2kIMpUd5cR
         roD8qHP8UE3ZpTiCV0umZ1hX2KhgUwapANn9RJkt0iWIJ9MeH6yxquTqETXRD6ZRTB6j
         a+PA8IxpVSJ3hyyONkj3BnAIZRX05cQV6UIP95xHbrIFxZdjElPeVDceD4rU9cvSrCPQ
         B1GODHPWLNf+mdGPTUAiKpqz7tiR25XF4vAn9+8kaNV1cePxEfzbR6fRFHggy3yvlkPG
         pVihRnzhfJ3NYQU7cGSz/hVBwauBHJ6RHerzBy6T2ltvUSvj7ottqcVBfMvTS+1hGIQW
         kOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196367; x=1707801167;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5Zzk0WUsCLkmxXmChJvEQeJowFe443M24XcTYF5Rvg=;
        b=P96u5MefomSK1IRJcuImit13u2fDltd5tDii8hGFamub7UW0bQQJH98v9TdFqBbwLs
         H88TDRrIRxZc8Tlo5gkisLQLf1uZrd9sfSWCHnN0MUNYtbYnsph9K5q3YMTVKHFDzYXx
         dOma7iQtxyPL9zGNcgI/XVHHa7x3kUKHR9BPztwSksRAsY5jOINpiU5LPRvYL1qBGkr3
         C+L95wWHTUzyFshgcn9G+hvrgT0PDSgDaLgy/FQSwMC9KazwP1rWU9Ls8ZoJ/XZcSPgL
         jzamZi726ls8y6ep2/Qf7YSE0MBuvZ1H9T04k59Ctp4FlvdOLnsM6Eq4j+huoHSjqU8/
         ZMTg==
X-Gm-Message-State: AOJu0YzW9sZQc5GRcNb8qJhCQPRiFSi4apqoAenCfj79bbH9/lZb5hv7
	VYVw7oR33VZFaWoUS1RauKV/fSX2Nx/nQ0VvCkXoWTDRyu0e7BiDZKvaWE4O
X-Google-Smtp-Source: AGHT+IHo+eviqWNUG8yjz+CzSK96AtTtRoo6nJU85MnXGPaePUbka/x/ZUuZ0oBbL5gMVMgRkks+1A==
X-Received: by 2002:a05:600c:4691:b0:40f:d84c:ac68 with SMTP id p17-20020a05600c469100b0040fd84cac68mr1211348wmo.11.1707196367387;
        Mon, 05 Feb 2024 21:12:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWC1oMhNyi5ZJTkk+6wDpVBwKH/Oebndc0IizUxFHG4/sZm+UsVGeb2ECgf0LyBQo1QKVkzBuSQxqDCMBsZ0HXJhVie4jA6Bsw5JVly4UWWzi1CXbMbdse2h3PANiRnA9gheROeRzrwff2JEuoaI4QghL4nAgqqutgPpTMmDJlLhrr5K58Ri1Hv3GodVmue9x+Htq6kxY5dhQ==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c350a00b0040ee0abd8f1sm647987wmq.21.2024.02.05.21.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:46 -0800 (PST)
Message-ID: <cc92dfb0bdadb8c3f1289e8bb9dd60994f3135f2.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:18 +0000
Subject: [PATCH v4 18/28] sequencer: use the trailer iterator
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

This patch allows for the removal of "trailer_info_get()" from the
trailer.h API, which will be in the next patch.

Instead of calling "trailer_info_get()", which is a low-level function
in the trailers implementation (trailer.c), call
trailer_iterator_advance(), which was specifically designed for public
consumption in f0939a0eb1 (trailer: add interface for iterating over
commit trailers, 2020-09-27).

Avoiding "trailer_info_get()" means we don't have to worry about options
like "no_divider" (relevant for parsing trailers). We also don't have to
check for things like "info.trailer_start == info.trailer_end" to see
whether there were any trailers (instead we can just check to see
whether the iterator advanced at all).

Note how we have to use "iter.raw" in order to get the same behavior as
before when we iterated over the unparsed string array (trailers[]) in
trailer_info.

Signed-off-by: Linus Arver <linusa@google.com>
---
 sequencer.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8e199fc8a47..35462a6a9d9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -319,35 +319,32 @@ static const char *get_todo_path(const struct replay_opts *opts)
 static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	size_t ignore_footer)
 {
-	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
-	struct trailer_info info;
-	size_t i;
+	struct trailer_iterator iter;
+	size_t i = 0;
 	int found_sob = 0, found_sob_last = 0;
 	char saved_char;
 
-	opts.no_divider = 1;
-
 	if (ignore_footer) {
 		saved_char = sb->buf[sb->len - ignore_footer];
 		sb->buf[sb->len - ignore_footer] = '\0';
 	}
 
-	trailer_info_get(&opts, sb->buf, &info);
+	trailer_iterator_init(&iter, sb->buf);
 
 	if (ignore_footer)
 		sb->buf[sb->len - ignore_footer] = saved_char;
 
-	if (info.trailer_block_start == info.trailer_block_end)
-		return 0;
+	while (trailer_iterator_advance(&iter)) {
+		i++;
+		if (sob && !strncmp(iter.raw, sob->buf, sob->len))
+			found_sob = i;
+	}
+	trailer_iterator_release(&iter);
 
-	for (i = 0; i < info.trailer_nr; i++)
-		if (sob && !strncmp(info.trailers[i], sob->buf, sob->len)) {
-			found_sob = 1;
-			if (i == info.trailer_nr - 1)
-				found_sob_last = 1;
-		}
+	if (!i)
+		return 0;
 
-	trailer_info_release(&info);
+	found_sob_last = (int)i == found_sob;
 
 	if (found_sob_last)
 		return 3;
-- 
gitgitgadget

