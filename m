Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED414D439
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084146; cv=none; b=k34adi/Mmr/NkEuztQG9y4a4//fwtTL+KsUl3Btg66bwt73Rn7uglEWA33ZhSzYAowt3CKenWvrnBrMRoDq05g4EiNUM0XKDMGv5flcnFohWf2GHopGW7jdAiD+rIS39pr0Wh4iQzP19h1Z6zBPxYMuumHrwu1h7WwKf5sQ4kJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084146; c=relaxed/simple;
	bh=4SmrDHfP6PewiJgiSvMZ5PuC9ZzxKTYFmgUlbHAOsbY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jHlUOfIf0dzwKkv7xOjlQQdRSr9sYoEM9YSbBYFhWok9GXs58E27liZjjtxwIwhA9B/tfWydabjzxr4KRS5u/CnMWaOKsLagYhFOPBJomEIKQy3dvpiEUwiv433leNSK1N3Yv2xJsNrSOk9O3SjkaWVSHyXBEhmVMucv8C2fKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k567Nqub; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k567Nqub"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a90188ae58eso327561466b.1
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 16:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728084142; x=1728688942; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kkS+In6yQgzAbHkCxON6BqZe9id4DITd+V0dyIXwZQ=;
        b=k567NqubrIuccY3m+9AOpH3EzxoctdykpCV8mxfd9YyP0+IL9TWwoN/VSI7N5IVdaV
         b+sNydb15hNmL1FDaqCAUXih0N6i2uirOwelDVmIRz5OkUH67YZR4Z1lSa6cDLtXFOQu
         jAvHmdl6bqvF/0bp/4NoZraKn0K6XM9R8wb6S036raNnvOM7sXNdSBPkyamEB+bToNcF
         uvxmXenDcxTKq7bBreb22U1KjDoVeevdDtLF2ZlCZY/rVn2OzQYIKe4IsllY3ZCrt4WC
         E/MO1UFbW8nRq1rV36SbvPN/VSdAHlDNaKw4AeT7ezuKvIMbsLeIrZWXruIYwT1itRmt
         yjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728084142; x=1728688942;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kkS+In6yQgzAbHkCxON6BqZe9id4DITd+V0dyIXwZQ=;
        b=NJL35JRnmopbVe+etA1uzzL4265TRlZit3CU0y71EGfWxWQzVqdnHxUvlr5LlyupZJ
         hp6dOsZob2D7YMrBeX9PX+d3TUHxDCTBsF8ikb4yxd9cUV8yQ7RUTPkqfSGxLXroIL2T
         j/mvE1G5dxeNyjcslZbcD/+PGi6w78Tw/lBIM2Xy63YQ6JYF23nr/jpTLgkj2oxZcmF+
         dszvngVHfgLhX1igpxJBMEbIUiPBw4y3Ye0m5qa1XYSR1bkg+SPmfHrnWsiBkDMTEY6M
         xFq0ZwX3Fmd7rBT3zcLUqQn6k6OMX3sc629K/FoCvBVRwwGOsCE4V5xHykgLdoVL5OZ7
         11pA==
X-Gm-Message-State: AOJu0Yx1x4ntbToFY22e3mXozq4/UtY3oI0TzP217CJxK7bdUU5hKld7
	9/ksgFjjGvePkhMGZPEOyOgr457D8LIaC+d4xwNSQNaZ4CwGhTk5tLgM0Q==
X-Google-Smtp-Source: AGHT+IHiitbL3ZbDhwsX3b6/jQmDsnsUMIlqQiS1hagO1rqOe51bsX0dR47L4TqE7UE8P0BtCksYVg==
X-Received: by 2002:a17:907:940e:b0:a99:3050:db95 with SMTP id a640c23a62f3a-a993050ec09mr88318966b.37.1728084142318;
        Fri, 04 Oct 2024 16:22:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7e7254sm51968966b.216.2024.10.04.16.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 16:22:21 -0700 (PDT)
Message-Id: <6250a7f6d6c84654093b383744c59d3559de717b.1728084140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
References: <pull.1784.git.git.1726943880.gitgitgadget@gmail.com>
	<pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
From: "Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Oct 2024 23:22:18 +0000
Subject: [PATCH v2 1/3] load_branch_decorations: fix memory leak with
 non-static filters
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Nicolas Guichard <nicolas@guichard.eu>,
    Nicolas Guichard <nicolas@guichard.eu>

From: Nicolas Guichard <nicolas@guichard.eu>

load_branch_decorations calls normalize_glob_ref on each string of filter's
string_lists. This effectively replaces the potentially non-owning char* of
those items with an owning char*.

Set the strdup_string flag on those string_lists.

This was not caught until now because:
- when passing string_lists already with the strdup_string already set, the
  behaviour was correct
- when passing static string_lists, the new char* remain reachable until
  program exit

Signed-off-by: Nicolas Guichard <nicolas@guichard.eu>
---
 log-tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/log-tree.c b/log-tree.c
index 3758e0d3b8e..cd57de2424e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -232,6 +232,11 @@ void load_ref_decorations(struct decoration_filter *filter, int flags)
 			for_each_string_list_item(item, filter->exclude_ref_config_pattern) {
 				normalize_glob_ref(item, NULL, item->string);
 			}
+
+			// normalize_glob_ref duplicates the strings
+			filter->exclude_ref_pattern->strdup_strings = true;
+			filter->include_ref_pattern->strdup_strings = true;
+			filter->exclude_ref_config_pattern->strdup_strings = true;
 		}
 		decoration_loaded = 1;
 		decoration_flags = flags;
-- 
gitgitgadget

