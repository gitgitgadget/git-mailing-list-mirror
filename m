Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79DE132483
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608117; cv=none; b=pnyDpdxl+wJ0fpitHyF3g9XRkN4ZoBZxFu6AuZdn3lDRzmrliI3R5+qlbzlmGBwUj+sTIGfosQxanziv7SdmP0izeGbMcL3HRFZ3rL3wILqUOD6lV7cGb8+PGBl6BvRA0A6CScU/0VHQQFIm+fxKgb5BFiRWew9BgnCi7pc5vzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608117; c=relaxed/simple;
	bh=CIKQ8Bb1sUrqihQ5MJIFUcbno3QB/yb6ILzqtp+yaVo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IuXjSxhrLvfxa8nUxv98/kN7p3hbiO0DSDxGJC4s8c3iED91hzEPtiDmSzpxhI9kXFBo8fRdjLw+9++JYPprqHQMQOtjFWrMbVIHmfofjRI/yWFMdjLDH6q8PtRu/i5YWSTCtirPZdkA7XUFpYxLMBuIokGGAsFZewL1pWu58GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apHELFcy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apHELFcy"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d153254b7so4113678f8f.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 05:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708608113; x=1709212913; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTSR9XKJE4GOW6G6lNSpqCjAzTbfFv8qkdL27MvMrxQ=;
        b=apHELFcySwK2/APY5kr+S/8yLVWO29VXq4aQ3CVeOF2TjuamVk2TeqqC0Q9zH8A1QY
         J9haCAAcfIVUW91O6gpeOaYdjj/qzHIIu72sAZBgv4/PMSz/q8zEN/buRctjG6ULfTVZ
         2tlpsgoeu9zJ48VKG5aN/rPGzMC9uY7YktHmR4ErOLllMh+IRAQVTKG8zseXRyCe3T2s
         G97ISARj8xsmeuRSfNFinYFpX7ZNH0X9BHjfdMIv8/9fAFMZ0otDtlUYphXMBGv5nKgj
         r895C+4egr6tBtJhs6/TstCTtdgHwW5TEmUhFlrL6h9qZOkwNH63kBaeXHj50GJIk8GZ
         Ovzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608113; x=1709212913;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTSR9XKJE4GOW6G6lNSpqCjAzTbfFv8qkdL27MvMrxQ=;
        b=Mwfli+YVVNNZ7iNBzl/5j8XwK7BOSROzwhF6bp7a/WUMHSwMYNw3HDITTH3XmquyFB
         IGy9Ar+B3PPiIOXXskj9fyO0aMsF8e7ZBjHbDxocu6BML0xijnmQs3jS2Dnuc9CN5yIh
         zNKHi8QcDdfPMn64zPCPm6VrzpjUQ7Zj1Xo6qvtrnnec50XK33JC77119Usom4l1vHPk
         QWvyFwv10Wa1KsvY+Q7ElwLawG23uzdCxT0/zo7evjObnliYNMUucNnt5G6bn6WQhqb3
         0gZZPeqz+nhgnJTS4xoomtBDNf9QeDMEy1HsXUemM1EY5+5ZJ4KHPdKvkRceoaqby1vu
         fEMQ==
X-Gm-Message-State: AOJu0YyCmo1JRDaavFINywmbxH7GGL/o9gV8cSbHIlJuS21Rv4Xasx1I
	EozDGVXzl+PylXFva6/iyctMlNmR8jhyxdCOEMGoLaLlMbeV6EG1Wq4p1pC9
X-Google-Smtp-Source: AGHT+IF0CnRNdi2SmkJaGJv4oHy9lxl3Ap/+TYr61aZCZc3TMQ9UmK6/VN4GATv7EWXPnLvkAm5P4w==
X-Received: by 2002:adf:e2c2:0:b0:33d:73de:ca3b with SMTP id d2-20020adfe2c2000000b0033d73deca3bmr4469263wrj.52.1708608113249;
        Thu, 22 Feb 2024 05:21:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0033d06dfcf84sm20227058wrx.100.2024.02.22.05.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:21:53 -0800 (PST)
Message-ID: <6e4e409cd43bcf445f811e171958ef4a169a0163.1708608110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
	<pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 13:21:40 +0000
Subject: [PATCH v2 01/11] paint_down_to_common: plug two memory leaks
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a commit is missing, we return early (currently pretending that no
merge basis could be found in that case). At that stage, it is possible
that a merge base could have been found already, and added to the
`result`, which is now leaked.

The priority queue has a similar issue: There might still be a commit in
that queue.

Let's release both, to address the potential memory leaks.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/commit-reach.c b/commit-reach.c
index a868a575ea1..7ea916f9ebd 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -105,8 +105,11 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 			parents = parents->next;
 			if ((p->object.flags & flags) == flags)
 				continue;
-			if (repo_parse_commit(r, p))
+			if (repo_parse_commit(r, p)) {
+				clear_prio_queue(&queue);
+				free_commit_list(result);
 				return NULL;
+			}
 			p->object.flags |= flags;
 			prio_queue_put(&queue, p);
 		}
-- 
gitgitgadget

