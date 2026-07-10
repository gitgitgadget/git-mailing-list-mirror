Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C75416CE3
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683607; cv=none; b=G5JJQKeasByV5gGoxJBG+Z+V7j+jNo7IWzEF4wfDXWkGTw7CZxfbPIk+t5gM9kdC7SrQUyc2V2/k6ZdhopTe0g6SXogA+sPplifJwNdvI1eeHJhF2tyZotlPSTGjRBDJCi3uCIhm7Ri6S9GOkW4yN+hzjCaFOVFEvMK3s4ARtXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683607; c=relaxed/simple;
	bh=FZJ4dKeEn8dSVL7kQJ8qLKo6j18zYGZjF5gXeFsuJN8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lEEI/UY3DfxbPrZeDMcqRv2BnIB0PGySs5+cnhzBgsDkMyv4TZ9FKrzgDqGYewA+XsNmq6TWsDzhn+qoosyZftOSc5leFh5EUYu8fcuhtRdcacXXE65LrS+GDpAN35YNGw/H0tGrkfOZiNlcrXyFdnBZqhSyPcM1DJ3bvCQ0hnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9T9CZG8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9T9CZG8"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8487088510aso843434b3a.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683597; x=1784288397; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oo64mSVxsNrDBTzOviWQ8YBqaTyICnpjnqhRxvUtm0c=;
        b=o9T9CZG8lZ05U23skrJb5OL1jBDX35v+hF/bV93bMSOywQU76IaBh9TY6ExAcj8jaw
         hXb7iC1xTxl93jLEvE4+mnmzhHQD2/3LpFGoQUnwrNz6kdRp5YJw1ia+07r+JN4gAm9O
         4pM7FJqTnHFP/iuZteAaTk01d62GQZj9kKh/Q2utWtMeXPXPyRbE9KPbzsq3h0AIBwix
         j1TMCx3/r7aqozw5j6SZB5ZfjcfBqzyvhMmCDycLJyIRxPXVijEg5k3JeMOvcgLDRynk
         2xHUL7EWWTCnPUtkb1+J+MP6z4Fx0xzlKeL1DlMujOUwWLDu8ixb9UBL9ynPj77JvvJq
         bZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683597; x=1784288397;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oo64mSVxsNrDBTzOviWQ8YBqaTyICnpjnqhRxvUtm0c=;
        b=f0prTPJaCa74qoJCNgx23wdEUBbRfFMMbsrtE5oJ3rk3rklAeecSKu3v5dcamUATNq
         UHvsAR4rhicmaq1R7CWMnseb4kFEaw/zEsvzLjcc7Iz0+RnTlv3/1ZnjiOohRr/zO0Jn
         +hDqVPR+/TDAVwi633Pxholbk+bXHQEXQW59MmtrWKrqv6iGudTnO86v6fyQqKawHcxc
         sRY3faAcR12FnkYbEP7dTMA66L1l9bAuk2U7UTbiBiYvSjzGFnst5bZramXgw5/L+cdp
         JZEGOBO3pCuu7ioghievuXRTv5t6wzRn4odY5nMhmaJIMQ4mcFvNLRo2S1tatg0G9cnz
         wVRQ==
X-Gm-Message-State: AOJu0YzbNeucGNlHlQxE/EXuNKAqwmy3FI12trCB+m20vZeyUAkC5nSS
	+sC69PRXsyogrV+L5fMYuQF3JnkG/vX8JSjQg5eZh3YrrfoOouJO+KIwY3+Iepgq
X-Gm-Gg: AfdE7cngU0YXNx3sle1PSAuKceVroREhkgeByLq4D2sp91pdCoiXcI115Y1vJstzaes
	V8FCNzFJTiuMu5e3OpoM/1T3gaog5V5T84hGMIuouXgwrQj8fVwZYXXm2yztKcpYMb7+lLo3syf
	rPYIVsnqh9tSuKGcfLpKgL9w5X2IpgBje85GzAKtz+8eHoefzfOdR7GqJTTlwxGGiPkqF1Yov5a
	KculAOS5QPxIiXu9wHa9DgNLUj69OXRVW8cZcoq9UjXVuD7tgUhC4KFpzI0s0aLt6VnzASoXtlH
	uQNwVFc8hZjrnpgfXYwT1fus3vQVtN6kJZoqHbXeoO6k6QmEQ/feKHOUBtXxI0FC3i9mEsXDquv
	mANIbDs4xgPi2Yc6Pkuje5qbHinerG2RBQHKbgg5yh32PB/vPVn/70NMYBDj5gFn+WVjlxAmRle
	dvs5e8JD1JZ3NWTHy5vxU+y2DLpmE=
X-Received: by 2002:a05:6a00:3026:b0:848:2e7e:353a with SMTP id d2e1a72fcca58-84842e7e06cmr10878094b3a.0.1783683597157;
        Fri, 10 Jul 2026 04:39:57 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.47.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4edb4sm10133064b3a.33.2026.07.10.04.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:39:56 -0700 (PDT)
Message-Id: <e581bc91ee41731a79c1843f648a11e969c2e16a.1783683577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 11:39:35 +0000
Subject: [PATCH v2 11/12] shallow: fix NULL dereference
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

After `write_one_shallow()` calls `lookup_commit()` to find the commit
object for a shallow graft entry, it then checks `if (!c || ...)`.
Inside that block, when the VERBOSE flag is set, it prints the OID being
removed, via `c->object.oid`. But `c` can be NULL (the first condition
in the `||` check).

This happens when a shallow graft entry references a commit object that
is not in the object store (e.g., after a partial fetch or in a
corrupted repository). In that case, `lookup_commit()` returns NULL
because the object cannot be found, the SEEN_ONLY check correctly
decides to remove this entry from .git/shallow, but the verbose message
crashes before the removal can complete.

Use `graft->oid` instead of `c->object.oid` for the message. The graft
entry's OID is the same value (it was used as the lookup key) and is
always available regardless of whether the commit object exists.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 shallow.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/shallow.c b/shallow.c
index 07cae44ae5..2f96db5170 100644
--- a/shallow.c
+++ b/shallow.c
@@ -370,8 +370,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 		struct commit *c = lookup_commit(the_repository, &graft->oid);
 		if (!c || !(c->object.flags & SEEN)) {
 			if (data->flags & VERBOSE)
-				printf("Removing %s from .git/shallow\n",
-				       oid_to_hex(&c->object.oid));
+				printf("Removing %s from .git/shallow\n", hex);
 			return 0;
 		}
 	}
-- 
gitgitgadget

