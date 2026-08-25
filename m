Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A452C3C9896
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684461; cv=none; b=ZA3QjgxWwFLNn+d0apMerza0ys+PavyTSM7AIeeizn1U/gNKRYBovRB6DWOymn4MiuakRDAVvw81Kw/f8VfXPxj8c++bVfr61wGBLX7sNReiIdqys0sQJ4rA1287PvY0c6p5rqQ1quIJjxRZgULKf3SyM6xyII5eobFiQaK0kkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684461; c=relaxed/simple;
	bh=y7Xd2QRkKexfdLqprlJZvhTfEP1S7P+RadLOG22Hc1g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=neugRQh/4aGh+3Y7Fqjpmn5A9x8iVWBXKn2VUlIUj9pVzma7IngmYvrKMPiLjtARjaivMRQYRuVf4ksCT5AFusWS2EHHE1VHJ5Q0F/KHTVs0jBBnNoj3idGyh2I8nSJfGMY95//Knv1XaLVwAjsfLx7a7Ts9J/88At43L9rsTxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mix9gThR; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mix9gThR"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-936e8bd9caaso3300485a.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684433; x=1788289233; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YKY8oUgSl0zYFpTP2jqrH1GyvgrY7187VZjR009U1ek=;
        b=Mix9gThRkd8SAPOFYoLnHerwGaDWQcQ+F6HKe4NJIEuBtpGqtcwTRLadBKdJLkbkk9
         rgDsxMrX/Yh3kZTy5GX1p8SaZm9qf5DmKgcHj9IwlOPn7NrN5XUmfyrmLsoVigL/EX2j
         +/t9JROFPU6hVo34YHYWsvBkcdMdpn1DYan5PjDOYdcZy/I/Lm9OxdQ91dL8fAC9t+ZH
         sFb5iz6BoEqm5GaAOQih2vSCuHgSU5uIYlEjqlPzvkrhqpIdkJ6AVCYtHfhh+RYPS+YI
         QhzZ1lJv4Ft7FeicCmRLC++caAXInWgf6wX27QtQzEIIyZeuxdfzrFdXZcqDqqOyaUpv
         moqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684433; x=1788289233;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKY8oUgSl0zYFpTP2jqrH1GyvgrY7187VZjR009U1ek=;
        b=j1EeuG9MumWiPma1K5JakXwzgWkG4NRe8l2AaAnd4UWX+6i658ymbK2I6bHQ65ZIls
         uS4kiKXLLJ8FqXfzrtdvV3FvAFgodbPFgD5CXhIKmL8ptaKN9hn5IKCMM9mUFpHbqSSU
         uz1UBXud3oLK6oK27IT66BcjuXwfce0gollCw56AbXIOyM9regJpVcucIYP33MCt760f
         3xQfMxzVwZtYr2SAWWmt0BH5U2lLDztB0MhaAZiN0Vn1Yuw7sv9hyIWZNpp250zjLUjf
         1cjzGDmkem2GocnGVMRMtMesNJb6beKfUMYbAtbj9c3bHUwHC5q/XqIcGgjGQxocAM8q
         9h1g==
X-Gm-Message-State: AFuF++khH56S8kdZbrSx2YNVpmuEMOC4pRY0EVIX7nYvqOM4Wfwm2r7S
	5NmV6Lm4kLNjIws20NOm+E+mq7QYlKuoIQRqK73SF1SVcq1zFrCod85gh2z0o4GB
X-Gm-Gg: AR+sD10rvaPkS0RweB02/5thluFrV1g5/hZr8LWfX872jNTgT8ivVie/Es/+A6QRuVD
	ZVpyybA6yqitKjIqbHv6QzFIzfTlORib+EVUBHL5IGp8sXzQQoux1NuOV0unuCcvg+GpAssix5S
	8nqXnN9OoDNcnCsxliGj+gLZLJjXdyHjSSJB8JyB4JbgNXyg9G6L5BDUKs6G7a7xiMfI0DPsvAD
	8HvcqMKoyddmN8o+eOGDS4yDAGBNQPCsS2NstZ2epGH5cl/fmkipbxz8FP62BwCUOtULeMm5cQt
	7Lai/mvBNMXML4HR3pG+fD90p8oB4HHw0PvLaCknRV3vlnslu7ZgeLxuxMD4FYLF5MzW58L6jZj
	ZCifjMHajvudefCyWvCZIJOa1aSGNcdO1mdZtw82Jlku/p8PjEqGlOwfrIG6NZAAQc7O3Kkjze0
	KauPolsqgTRW8jEUJt/Li09nRSMOdea5d4WtSsHh+X3MSpGE6pWFKqTmFKFoHsTuas
X-Received: by 2002:a05:620a:6303:20b0:937:78a7:1f94 with SMTP id af79cd13be357-937803c22ccmr56129385a.18.1787684433311;
        Tue, 25 Aug 2026 12:00:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.245.161])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377f072156sm32410385a.30.2026.08.25.12.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 12:00:32 -0700 (PDT)
Message-Id: <3f3b75690eea02960c7edc8d318ce7dff654f1bc.1787684429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2207.v2.git.1787684429.gitgitgadget@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
	<pull.2207.v2.git.1787684429.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 19:00:27 +0000
Subject: [PATCH v2 2/4] mktree: plug per-tree leak in --batch mode
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
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

In --batch mode "git mktree" reuses its entry buffer across trees,
resetting `used` to 0 after writing each tree.  It never frees the
`treeent` structures the previous tree appended, though, so once the
next tree overwrites those slots the earlier allocations are leaked.  A
single-tree invocation hides this, as the entries stay reachable through
the `entries` global until exit.

Free each entry when resetting the buffer, and free the buffer itself
before returning.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/mktree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 4084e32476..dc2d293c3d 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -200,8 +200,11 @@ int cmd_mktree(int ac,
 			puts(oid_to_hex(&oid));
 			fflush(stdout);
 		}
+		for (int i = 0; i < used; i++)
+			free(entries[i]);
 		used=0; /* reset tree entry buffer for re-use in batch mode */
 	}
+	free(entries);
 	strbuf_release(&sb);
 
 	return 0;
-- 
gitgitgadget

