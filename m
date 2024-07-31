Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3471B29A9
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432844; cv=none; b=WoOhSXNBnRFEy0BGOCzHs+4ulUiWPEDxhBNBx4oZAB1PGD/f3I3TQNorQG56Y97Vh9Ttd/h0g5RRvh6Me/i61CHCIFB+qGMvYbbx7uxXN46x5UVlIMODrlJLE/CnAGqPfbxeSmCwmPVtctoIR8Nj6bORLqIVNsqwhnYKObwIod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432844; c=relaxed/simple;
	bh=ZWM5FcuEWtj8gHhGrLuG/G/8KE3rjm4I09IjEQ7/Ank=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gj+3PqmN1TY1mICanzJL6Gk9W82yS8Vuajghal3fh5bcbZcMV7AB9imoINdlaKWxkvwrsJ+EoFOjucJzoDORyG5+TZt6mFI0DM4MhK4XSPeW13kkm4A6XUHoXliTHsbIYDS3uzT4FJnCD1ogbuWiuPDDjGM9PBsGjzh7lFsRVrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVq2/76D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVq2/76D"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4281f00e70cso25554095e9.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722432841; x=1723037641; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LRBZtu7GsQi3EF9vf8IIuJVSLgHPioA3gFOdXK9ZUE=;
        b=EVq2/76DM7JlE86L11SqSCLh77Z+iQkBxUH2CwI1DYvx2znhPgcdbNKKpTw7XMTx/1
         ++1mcgQ2PEI9pxHr+7IHa2Tm6lVxAPv5m9s2BxnUhIE2CXj7RI8jAyseQkZdJJXNEhsU
         Jd/vyuxq9S3BDU/3mdGrfht2UddZfjBv5tqfL/dTLgWwwJUSFBzYIVmZgF4sMG7faH0X
         GUqhabGBJtpROJlrTuuqEJEztT7k6OE0nZQNLxY0mwUXZRg6SBH/ONs6sGRuNz3Djphf
         gDtiYOecsGEWnFI0BKkBTqxLgb/o08WTdpOTy/fndtHGwyuPDWvuBk9fgKSddvzTSis/
         iKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722432841; x=1723037641;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LRBZtu7GsQi3EF9vf8IIuJVSLgHPioA3gFOdXK9ZUE=;
        b=KUuVTHLTrlMeI8gE6YmIXrbrrk+DssuXBLpYMKquF7JeQRYiaEetZOBv58zOtVGzqI
         Rfe7u7ipLG0OzRTe+daBoVlHwqwHc/BAZYnVZ09JHZ7yrkaWdOBROxCUqdNRM/y2xB4P
         jVZB6jL0j+mmN7kLCbw+yFLWwetSVXZ6vMNDP9RqIFJZKXaAoDlc/EywtmqT7qVlC2U/
         tMafsFs9OGpTqYMEDb5KCQk3FwUvcvAOrZYgUJPEPzQnq6ps7XQ6gnee9yT6oNlBlj+c
         tVXabJi17c4JCf7EqMY97me8jPFip8Qj3jp5R/BqMbPs0HbQBiWn47zPrAqXZ5jQKv0h
         LFUw==
X-Gm-Message-State: AOJu0YxyvlCqbhpdrb9LuLTTFM3eNIS9cvFG/6KrgS1IF6RSoEfhFFt6
	y2ZxDJ/T0V+gkK5oux85bTnPqzfNz4aOeGZdutxBh3Nz7o9qWwzw4asNLQ==
X-Google-Smtp-Source: AGHT+IG7TCFtbJlMVww7z8MkqD6TnWVEW6oBTcHn/vPnschKHG7+4cfjL2PdYnk1jBh9iTS1wUT8Mw==
X-Received: by 2002:a05:600c:a03:b0:427:9db3:46ad with SMTP id 5b1f17b1804b1-42811dd1a29mr88560725e9.23.1722432840889;
        Wed, 31 Jul 2024 06:34:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bac5ff2sm21541985e9.25.2024.07.31.06.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:34:00 -0700 (PDT)
Message-Id: <pull.1744.v6.git.git.1722432839473.gitgitgadget@gmail.com>
In-Reply-To: <pull.1744.v5.git.git.1722310937061.gitgitgadget@gmail.com>
References: <pull.1744.v5.git.git.1722310937061.gitgitgadget@gmail.com>
From: "Haritha  via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 31 Jul 2024 13:33:59 +0000
Subject: [PATCH v6] convert: return early when not tracing
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
Cc: Jeff King <peff@peff.net>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Haritha D <Harithamma.D@ibm.com>,
    Haritha  <harithamma.d@ibm.com>,
    D Harithamma <harithamma.d@ibm.com>

From: D Harithamma <harithamma.d@ibm.com>

When Git adds a file requiring encoding conversion and tracing of encoding
conversion is not requested via the GIT_TRACE_WORKING_TREE_ENCODING
environment variable, the `trace_encoding()` function still allocates &
prepares "human readable" copies of the file contents before and after
conversion to show in the trace. This results in a high memory footprint
and increased runtime without providing any user-visible benefit.

This fix introduces an early exit from the `trace_encoding()` function
when tracing is not requested, preventing unnecessary memory allocation
and processing.

Signed-off-by: D Harithamma <harithamma.d@ibm.com>
---
    Fix to avoid high memory footprint
    
    This fix avoids high memory footprint when adding files that require
    conversion
    
    Git has a trace_encoding routine that prints trace output when
    GIT_TRACE_WORKING_TREE_ENCODING=1 is set. This environment variable is
    used to debug the encoding contents. When a 40MB file is added, it
    requests close to 1.8GB of storage from xrealloc which can lead to out
    of memory errors. However, the check for GIT_TRACE_WORKING_TREE_ENCODING
    is done after the string is allocated. This resolves high memory
    footprints even when GIT_TRACE_WORKING_TREE_ENCODING is not active. This
    fix adds an early exit to avoid the unnecessary memory allocation.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1744%2FHarithaIBM%2FmemFootprintFix-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1744/HarithaIBM/memFootprintFix-v6
Pull-Request: https://github.com/git/git/pull/1744

Range-diff vs v5:

 1:  e2518b28f1c ! 1:  7b68aa9de1d convert: return early when not tracing
     @@ Commit message
          when tracing is not requested, preventing unnecessary memory allocation
          and processing.
      
     -    Signed-off-by: Harithamma D <harithamma.d@ibm.com>
     +    Signed-off-by: D Harithamma <harithamma.d@ibm.com>
      
       ## convert.c ##
      @@ convert.c: static void trace_encoding(const char *context, const char *path,


 convert.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/convert.c b/convert.c
index d8737fe0f2d..c4ddc4de81b 100644
--- a/convert.c
+++ b/convert.c
@@ -324,6 +324,9 @@ static void trace_encoding(const char *context, const char *path,
 	struct strbuf trace = STRBUF_INIT;
 	int i;
 
+	if (!trace_want(&coe))
+		return;
+
 	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
 	for (i = 0; i < len && buf; ++i) {
 		strbuf_addf(

base-commit: 557ae147e6cdc9db121269b058c757ac5092f9c9
-- 
gitgitgadget
