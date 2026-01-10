Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B9B136672
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768022023; cv=none; b=rJQ8n2+3hONtYKJROJDnnmCo0RKZg5oZiBWu9P+ylU+uoWSMxGj35DYBAEtfW5vww1NeP16e3LsR1HGDa4+w8sD0/nVaeKKdYzs1uruoMZ99zLdn/LvHoc7WE1zi2bij8B0WaR3Y4IbqcZLDD6vA/0bGZ0sSwoygPyYzmEEWPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768022023; c=relaxed/simple;
	bh=KD2RtFcwUeJkXktSOj6HvbXoWGmLF6gGN+QXt6P1/jc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=MnmllSQMXFf37gsZwEInKziXLRFHFCJ6A2n9w/qQHWNeYQSGyxnMpSjhygWuA2EHWMNDsveQQU5vMGNTY5JWw0Y/PQSkKxwiLQw+MiaQdvsMZOhopTb+W/g51yOJnJ4hMwqabx+TX+NP593UhQMmXkPBNn8wO7I2Mbbazs1C6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gp+knJpr; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp+knJpr"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c07bc2ad13so342289985a.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 21:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768022021; x=1768626821; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Wu+WJEVcS+59yiwWCWqOgegceD0+jNFFCR6539Uxlo=;
        b=gp+knJpr+PAmrt/PPbrgjQUOjO4fB04b+XqGF8XNQu/Vhd0s0TJrXCauPsF3lfjPl7
         8bixH2FSXS7GCmBTlTi1AA3W3SJRltGQPqNrmz6LX7jN3QcoG7TuGREWSuLuPWZ4gFzH
         9dJDZy4AVPQojLF1k9x1u7JSVq4XwFtrmxqxpbUEu3yH5M9gn5ZaGXuqljFvsZpvNVRN
         QDWddgWlvsS4N3eTqAQNzbDNBpMcaJ91Ogtjvk9A6f3SqXKrm8Qexx405tBkmqADB1zq
         XsmzspSGXKHnUO9AG7Nwqs5dPACLDpyGMu4Cc2s/9uHjd88sM14T8wMQq87haQdgcZA4
         Vivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768022021; x=1768626821;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Wu+WJEVcS+59yiwWCWqOgegceD0+jNFFCR6539Uxlo=;
        b=gAz2OlczxG8xfq+h2p9MQT94luYC1a9FDgNj+q05VR2NdHAsN6n2D650gTjL0jobWc
         Gg8PjaPXtFXcv9JChx4pdeGVDra3Q5IwK4mDZIX95sLOWPsRGe2us0KvJHRK3sAvrful
         WQ9nMaLWIXxU2tuULtsLOV+sQM85vKl3PegrnykGmt7krquqeOoXM3ALj/Th6KOyQkXo
         nkjJgyp+h9C9FZIafPmU73avBcxMuSzjeUg+mVl2EAH2/pL/aba/wWadfHuc0bPtj9uX
         q8DU+E/tWwHynuf2nCIawAk3wBtTF7OXv98YAZ3tpeQa27vRQGqsjmN+WOEIjyUdUBoL
         oG6g==
X-Gm-Message-State: AOJu0YyJoImJw+9BqSzHZjv1iQ5TRQ0r9F6PdhZHKy9FBgzJ3G6r8z3K
	INAr+PnUJf9INRMpkIVltEJ7e0ZtFNd+7Wc7cg6oEAZKlXuyQBt5c7RE+ozv0tRe
X-Gm-Gg: AY/fxX4BiY3/SQ6Z2W4Y8G4cXP9zq7EIcKFETIvlOuQ53nKakXUpGQ4+aqUlaBXBwSo
	LbV4x7aFe4wiCZBrr2lzL7rs+tb2QmEkf/XvA9oW90DgxgM3ccuRj77vbQ72MEpMGVNTw3GdSIS
	+jimLsJGR0fSgU8KqV5VWVmFMFGFCISl27f6N/WR3U0YX+zM9yJj61XmNoAUe3NGWY0nSKo2VXn
	py9fDDhrsnfwJGc1++gt+0qZ40AFoid+IUBbTRCuVIQse5vDos1jq/slF7pi7yocOxv+300QaSB
	br8oqMCMPA39g02pPn/G9dCStms+HQ9NUDb3UZx90sinrcd7MwKBp6TuLMl+s/uBbQg7efYYhB3
	PSnVPQKxvt+hqXTyA9/khVFioPGMT48H/GtOqfwSvJCpQy6OcP8bgt/2IcnUFZrKoH5cpmaA5DC
	pcX5sMmwh8u/xpgg==
X-Google-Smtp-Source: AGHT+IE5EEvxJFiWN3EeCuBpjUBqPdR4HOI355cJcjV0MNhMNDsn60+e/rqNrsDLPpW5B56DPs21nQ==
X-Received: by 2002:a05:620a:711b:b0:89a:68c5:25e2 with SMTP id af79cd13be357-8c389354ce5mr1657630185a.8.1768022020561;
        Fri, 09 Jan 2026 21:13:40 -0800 (PST)
Received: from [127.0.0.1] ([172.172.153.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4bc1e7sm1002340585a.21.2026.01.09.21.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 21:13:39 -0800 (PST)
Message-Id: <f8a8d077cd7203663406bf656287ed7e0d6e6d90.1768022018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.v3.git.git.1768022018.gitgitgadget@gmail.com>
References: <pull.2121.v2.git.git.1767997426.gitgitgadget@gmail.com>
	<pull.2121.v3.git.git.1768022018.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Samo=20Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 05:13:37 +0000
Subject: [PATCH v3 1/2] shallow: free local object_array allocations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>,
    =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

The local object_array 'stack' in get_shallow_commits() function
does not free its dynamic elements before the function returns.
As a result elements remain allocated and their reference forgotten.

Also note, that test 'fetching deepen beyond merged branch' added by
'shallow: handling fetch relative-deepen' patch fails without this
correction in linux-leaks and linux-reftable-leaks test runs.

Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
---
 shallow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/shallow.c b/shallow.c
index 55b9cd9d3f..497a25836b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -198,6 +198,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		}
 	}
 	deep_clear_commit_depth(&depths, free_depth_in_slab);
+	object_array_clear(&stack);
 
 	return result;
 }
-- 
gitgitgadget

