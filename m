Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0876E20D4FE
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437249; cv=none; b=p5QessaTwJVFmmVPoEDmduD4VNUG+GcnS7j6UxyRe+NVoAxXguGZRUIHDe6q252lMtC/fi0mFxOarULrqb0HlHGVt6TXaEJRU3UGl7XBrfhWgSWUvuxreymqywvwVRbsrtKExhk1dQ7TRp/oSR1RTB+kEmYN61O3+7HOWQYRqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437249; c=relaxed/simple;
	bh=Sy9Ta3R3rXLQ+SJzF7EshUZ7bQHhPxrQEkyoBaDWhiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKEf5irXqj1C3q4qoZG4XOoYg8b2IpyFUjQmsSl/M13OhsvnnFSWHeowwHVKdSaffbEeiMLWxX6PQLq7c5ODbwOuMIqSRMTQXcN5ihtrfHspWCoQEIptIM/QuKcpIZelXsbccpuOLenaFIyLRzyVSiT7x/0IoefdBbq6mFrhnBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emUNQcxO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emUNQcxO"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f2339dcfdso9462065ad.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 01:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739437247; x=1740042047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1WtfWc9Gi8raVQGPcC6HvQTvCP5sMueYommUfjaMCQ=;
        b=emUNQcxOcOFj/oGGxn7VBzb9hTet8s8NWHSuTT8nZOnOekzCEk0wf09IBzjWddUbKD
         lEh3g4H4mndDmuJmjya454xeoClxeAbCx19BnurM20llxu+41nzaaQ2vLDTRBrg5DKrv
         /0EbFh8uE/Bjpq7EOAeaEVt+o9NE6CViuXZ4nVLEohU5y04tdABpS/6nP3x7ODYPizqh
         FS7WVhw/KvzMoCzjweGFocxHQgnisAjpH4/pzXxroipwOASt28VgoPShdRzu8FgQpalZ
         JlzlXkl9csootja9XzRSTRZ2PRRATu3KzqqTlDQXi/NVVHVJ5CrWE2JmBD0mWgkId8aT
         tUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437247; x=1740042047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1WtfWc9Gi8raVQGPcC6HvQTvCP5sMueYommUfjaMCQ=;
        b=Bg8MkfGQfDuzMJ1GSBCzdWzFloiAzFHRu7RPs1asD58TgoaNWWgGH4dJrsqrVpK/1J
         iOu8bWAoStvOKvDAAjvJlsmPRzCL1XdiNsULVogCPMA9aR3vtPpK9sZzAe7S8IxuE/g4
         AZ5j4Q2GfP/qRHMUMNa9lUYjAk6cMrBzMYYcUdX4/aa9NBsvzfRwnG0LjTJlDsfWRv4n
         rdiqTXSUuYZgWDB6wLurg6VkiCBC+nQGWmrUf8S1jh5M7NO8NteuAXzLrMe7bqPdlJA0
         +XqPT0xSp2M12WRBNxFEFcGm1cFPTNOCgZuqwl1/NZLtjSvUkHeALuYK/Alhh9bBoxO/
         hTbg==
X-Gm-Message-State: AOJu0YxCH9t+7a2ZX+2wdKaKLr6srr5mYNhfeNNAI2Y6SwtV70uVBdsM
	DnT1Fn7+iA73QpZJwJGRwCBcOkERH6Nm8oY/i9+IL/TA39bqEMUjftiZqA==
X-Gm-Gg: ASbGncuCGbCZe9lWKTa2Q7SjlxNAsV/bjBy1BUNKUvyi5FzTYwTw6w4dPyju1BTPIHU
	NLTDkpaoBL75GPXADY8R7j0FialLA5QWJQ6AJg09lc9oBEHzUlGnMnyZeedYoVGug7cnfgFD672
	5P8OiWZGvThx8tRq1+8LMdck7bxNH0GxD+w6uuW5h+uaJftUjBXQTEPvR3MnWv8rwXuOO+K2p5R
	JKXj36DMyBRPq+KxFKQWto9vOFe61sSTCMCi4L2fMUZjpI9tZzrOQq3fiSl/ADfw54VyBZ+XEV9
	0t9ZAp975WF92A==
X-Google-Smtp-Source: AGHT+IFemIektP6vxUqWiMrg0RftTK/Z9/f5SYWDtjQdROn1O5D05E4Jga2ElhFDPqyXG/taCT3N5w==
X-Received: by 2002:a17:903:11c3:b0:216:59f1:c7d9 with SMTP id d9443c01a7336-220d373d8aamr40952085ad.19.1739437246727;
        Thu, 13 Feb 2025 01:00:46 -0800 (PST)
Received: from meet.. ([103.240.170.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536733fsm8086265ad.77.2025.02.13.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:00:46 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: Meet Soni <meetsoni3017@gmail.com>
Subject: [RFC PATCH 0/2] merge-recursive: optimize time complexity
Date: Thu, 13 Feb 2025 14:30:38 +0530
Message-Id: <20250213090040.16133-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211194334.20710-1-meetsoni3017@gmail.com>
References: <20250211194334.20710-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes in this version:
    - Updated comment and commit message as per review.
    - Added another commit implementing optimization logic.
    - added an RFC tag since, if the changes in 2nd commit are
      appropriate, we can apply similar logic in other places as
      well.

Meet Soni (2):
  merge-recursive: optimize time complexity for process_renames
  merge-recursive: optimize time complexity for get_unmerged

 merge-recursive.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

Range-diff:
1:  ec96e4010e ! 1:  c7dca6e971 merge-recursive: optimize string_list construction
    @@ Metadata
     Author: Meet Soni <meetsoni3017@gmail.com>
     
      ## Commit message ##
    -    merge-recursive: optimize string_list construction
    +    merge-recursive: optimize time complexity for process_renames
     
    -    Avoid O(n^2) complexity when building a sorted `string_list` by
    -    constructing it unsorted and sorting it afterward, reducing the
    -    complexity to O(n log n).
    +    Avoid O(n^2) complexity in `process_renames()` when building a sorted
    +    `string_list` by constructing it unsorted and sorting it afterward,
    +    reducing the complexity to O(n log n).
     
         Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
     
      ## merge-recursive.c ##
     @@ merge-recursive.c: static int process_renames(struct merge_options *opt,
    - 	struct string_list b_by_dst = STRING_LIST_INIT_NODUP;
      	const struct rename *sre;
      
    --	/*
    + 	/*
     -	 * FIXME: As string-list.h notes, it's O(n^2) to build a sorted
     -	 * string_list one-by-one, but O(n log n) to build it unsorted and
     -	 * then sort it.  Note that as we build the list, we do not need to
     -	 * check if the existing destination path is already in the list,
     -	 * because the structure of diffcore_rename guarantees we won't
     -	 * have duplicates.
    --	 */
    ++	 * Note that as we build the list, we do not need to check if the
    ++	 * existing destination path is already in the list, because the
    ++	 * structure of diffcore_rename guarantees we won't have duplicates.
    + 	 */
      	for (i = 0; i < a_renames->nr; i++) {
      		sre = a_renames->items[i].util;
     -		string_list_insert(&a_by_dst, sre->pair->two->path)->util
-:  ---------- > 2:  78a007be7d merge-recursive: optimize time complexity for get_unmerged
-- 
2.34.1

