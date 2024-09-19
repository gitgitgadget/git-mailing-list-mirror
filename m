Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C2A839F7
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770902; cv=none; b=WFbg5uid2a4OvKfrJejGe2OQ3z8XgTiU0Aere6ApE3xibzLTOZ21qF7ZimC6FRiZ9Tjs0c2pnAvwYP9UI7GlAnxLrVdHV6Ui57ILdSKZ1iGWoHmDhDzXgiQQ6JxYgeoW/VaLmLeJkwOjioYlTE+uQaCaMj9zvFr0FyY+6QWMfEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770902; c=relaxed/simple;
	bh=vLGQRQ/jUwOZIArZpqGYDLFtRW14Jmu/D6T3Zd3lzUI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hwIM5iQvknQhOVOb0hA5l4VaPRBo4TetEqPz69woWvfS2o5fL1sZOgcVOwdlGynab/+0tHzfFm6WT+GlN/PWrcQmQPZDUBHkyosIMnJBzUUoNxqtzQNKDhyW5yS1Wfk36nrqespaMJg2vQ08IR7hDRW17RtP3P2q7+xFyUSzllM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd4jbd5w; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd4jbd5w"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d4093722bso171176666b.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770899; x=1727375699; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4HA0sdeZbKDescBxM5DwfxJEVp/s585gMw7kbmSrZU=;
        b=Qd4jbd5wKLEBn8biLNnrr0CIFylQQ9Zv46eTvuBMKMNBwVmKovqvZlFltN5Vn4T3El
         NnBcCiShk3KStmOmncavIrHIDH/aTGpVJOXJJjEcTL6gJ4H96OATAInx9pPM7b52buQ7
         li3+YlelDiy7gV/e2tx8xKybl0JG6SwtnLktcuwD5jmhxEVFs4aFSwHwzhXIheULcD4g
         2+fKmUklpUqkaYrJKLWtGgHYDBKcKiKSDZGOz3JKG1hmrVHobKO5E3/B0Nuv4/8NvlCn
         ny63EdO9W9NE0CVS8UpdcilIDabejpM73FHHIP1yXl7sr4/TCxEZtiSW80XzPUsqr0QT
         imRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770899; x=1727375699;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4HA0sdeZbKDescBxM5DwfxJEVp/s585gMw7kbmSrZU=;
        b=QfXkVv+M7JrDbtsIT2uahQvDUlJ9TmnsSP9pL3iNExrGxBAD/pxJ3GqASwLlyION4/
         hrOQCC6YNvokl+qazIy0oJHvX8vfBIq1CGn/8DOLreb+lEm/OkX39wtiVXiRtjbakSXy
         mPX7MphBNET0PNqMti7kdR0dEGpT8C8A1yss8IaxOvKDuwF2EWfOMnisbtg9eVPDtHYr
         ijw9cXnAloWEvVoMcvEikErnaLTFWk9IZUUUpMi4uWmbyg4HKDlgMFs03EaHikSMVHJE
         M/uwFpMFy6cRg4nGEaYGhlHmDdjkjhXXCSzfXWkCUZizHmU2uxY/lpZF4yYBKQ1lQdPx
         oWIg==
X-Gm-Message-State: AOJu0Yxxp9mvESTeDrWvfMU8+QEn0KrGEQVgQwvyww18BDqyPpPAKHJ3
	X/TPsIqytb9dqt3Ap2uufhUGQFZUU9qdNGy9cfUCrFRAzQxm1elBE5ON4Q==
X-Google-Smtp-Source: AGHT+IHz3C05B+I24tChjB9oVuf86LQ0hzhuVbw9y22O5tRV9tIqJoVYkXgDG1r4eCn9/HLmACvzvg==
X-Received: by 2002:a17:907:f199:b0:a86:fa3d:e984 with SMTP id a640c23a62f3a-a90d56136f0mr6473666b.20.1726770898619;
        Thu, 19 Sep 2024 11:34:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061330c73sm744073866b.208.2024.09.19.11.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:58 -0700 (PDT)
Message-Id: <1f12c379b8ff1253273f6d0b33a6640ec7125e0d.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:36 +0000
Subject: [PATCH 16/20] revision: fix a typo
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
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 revision.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.h b/revision.h
index 0e470d1df19..71e984c452b 100644
--- a/revision.h
+++ b/revision.h
@@ -549,7 +549,7 @@ int rewrite_parents(struct rev_info *revs,
  * The log machinery saves the original parent list so that
  * get_saved_parents() can later tell what the real parents of the
  * commits are, when commit->parents has been modified by history
- * simpification.
+ * simplification.
  *
  * get_saved_parents() will transparently return commit->parents if
  * history simplification is off.
-- 
gitgitgadget

