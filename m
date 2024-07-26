Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD8176220
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721975240; cv=none; b=VOTOh6UKzTDM8EieJXP813YskE4Pgx+mj5/M76dbRzUrwXDhZnlyFE4gQa3f7TBo0q3r11F/8FplSdYzS8LJn88Iyq0fHI/bPAPqGC+2Oay64LfmRHfSDHW55XR/fTolUR22J8PdmhvIw2yq/D9Lpb27gE1f/zhmrRCCIwTd5s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721975240; c=relaxed/simple;
	bh=bCpo88NwXuQnAt2jhe0zC9g9SulU+25nr6WsLqEQBPA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ii2JUKD4GqM4BI9Qpy+P2HrutAmjCYLFSuqmeiYaJYMym5qJ8AcIx+eJA/huAsKGoW1XIFrm8cJYp8s7Y3qIkBZigd4fXkwCQp/gjAXB1ZyiAIBqH5XLZ63yvFBYQv1qKbKZuSciRZPtOMEmqYdfzJZg8y3CHgAQZkLxhFFJEV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mlrr8bq7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlrr8bq7"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-368313809a4so1675120f8f.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 23:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721975236; x=1722580036; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfhhGFJAUezLTY0WgQbolSr02P1hX9y9H/pSHiE5jyY=;
        b=Mlrr8bq7gQZDbVgjRlAr6wIddnhYsic0rE3ifBWgr0xrjUwzAA/uvSQrIsRQDm9QIv
         lsy8b0HO8AqlmrfbaW2Ia+/jFLJ7UssNyxiHJbJG0hc+ta11MQVjjf0msXAwoFEtcRUU
         QB9gyykLcuc2m6E7UawgwPnQliruwHehOfBKIxo+PkG36xHyKIyToju6qogQQhNrMdTm
         N+s/CyULJvIWrv23mkxwi/Q7o/5VZjcb+kKfvxp9aOPViRNaxpa0x3TWOWuyT6opQ0yv
         JHqWEfn7hjtURRT10o7eCu360GM6pWoy5eJl70XQhbJpkQHiQe7L6kC49pdiz7f12q+I
         f3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721975236; x=1722580036;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfhhGFJAUezLTY0WgQbolSr02P1hX9y9H/pSHiE5jyY=;
        b=TGhpyJNnZUub40oCzxQnVFuYKO9W25GCEUJi+ueaeH/kHf+LepefIvfes9YevoUOEC
         cCZyyuUaAZFukRK8Tal374v+uPZOGSnNio8Zn5uXHG5pnOc5eI9Ih8S/sBGnzoKuCKOk
         NuLowm0BiRxcaM93dl1wNXNe2uyZPYJZEkSs7fKXtIwwqPUN2BB8URt0QGWrEgDmbESk
         DlC2dMo6EVngzRIr3Q5xEBCcL6zkG03GQrUfqGjzgX3gHUkcSCrkLsYvQa6PVoZIN+JN
         6Dv9NmappelpswiESxyPyTFvvqGzacqD5Pzqei6HJi1y8ykeZTqZKshJFWGBaVupnCf5
         C9LA==
X-Gm-Message-State: AOJu0Yxon5ifuRn+9VDtKjgQ6XOJtScgoQmJSeHQy9TZBJ1k8xqt+3zl
	TO3lRD/dStvcRbtLrkS2/86G0aWwpcDYEwsFEYjvXCEzMBA7rHT+476QWA==
X-Google-Smtp-Source: AGHT+IHsJu6PvV664sJ2hH2Jj6owiIfRPdQil6LE4mbvdAnq+jmP8MbN7XE8KETmGZRl+ysC3neSfA==
X-Received: by 2002:a05:6000:c92:b0:366:ee84:6a77 with SMTP id ffacd0b85a97d-369f666825amr5226908f8f.3.1721975236181;
        Thu, 25 Jul 2024 23:27:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9576sm4180611f8f.31.2024.07.25.23.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 23:27:15 -0700 (PDT)
Message-Id: <pull.1744.v3.git.git.1721975234873.gitgitgadget@gmail.com>
In-Reply-To: <pull.1744.v2.git.git.1721821503173.gitgitgadget@gmail.com>
References: <pull.1744.v2.git.git.1721821503173.gitgitgadget@gmail.com>
From: "Haritha  via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jul 2024 06:27:14 +0000
Subject: [PATCH v3] Fix to avoid high memory footprint
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

Signed-off-by: Harithamma D <harithamma.d@ibm.com>
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1744%2FHarithaIBM%2FmemFootprintFix-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1744/HarithaIBM/memFootprintFix-v3
Pull-Request: https://github.com/git/git/pull/1744

Range-diff vs v2:

 1:  500b7eacf2a ! 1:  d864de64380 Fix to avoid high memory footprint
     @@ Metadata
       ## Commit message ##
          Fix to avoid high memory footprint
      
     -    This fix avoids high memory footprint when adding files that require
     -    conversion.  Git has a trace_encoding routine that prints trace output
     -    when GIT_TRACE_WORKING_TREE_ENCODING=1 is set. This environment
     -    variable is used to debug the encoding contents.  When a 40MB file is
     -    added, it requests close to 1.8GB of storage from xrealloc which can
     -    lead to out of memory errors.  However, the check for
     -    GIT_TRACE_WORKING_TREE_ENCODING is done after the string is allocated.
     -    This resolves high memory footprints even when
     -    GIT_TRACE_WORKING_TREE_ENCODING is not active.  This fix adds an early
     -    exit to avoid the unnecessary memory allocation.
     +    When Git adds a file requiring encoding conversion and tracing of encoding
     +    conversion is not requested via the GIT_TRACE_WORKING_TREE_ENCODING
     +    environment variable, the `trace_encoding()` function still allocates &
     +    prepares "human readable" copies of the file contents before and after
     +    conversion to show in the trace. This results in a high memory footprint
     +    and increased runtime without providing any user-visible benefit.
     +
     +    This fix introduces an early exit from the `trace_encoding()` function
     +    when tracing is not requested, preventing unnecessary memory allocation
     +    and processing.
      
          Signed-off-by: Harithamma D <harithamma.d@ibm.com>
      


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
