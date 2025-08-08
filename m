Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE12701CA
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647227; cv=none; b=OxmwWTexTlgtB4WSp5dELnqK+Hgie+RB1aed7Cov2XelTbnFw1AbpaoJ8Bxx1Kz3kdMW3uHArdlKvWBaHfiGJ0EBCsK3WOYZYLempM4A75qZ1OS4a6vlenvx4WXBfExnabb43rNqdlLv/j//fuXamh43ImOrwT1Fh31BXS2+YdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647227; c=relaxed/simple;
	bh=UVXC2U8GXaJQyFzUXz1k6RL7f0BOUSGKNnSyoKndKgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNspmUm3EozRw/IW4DIaegECsap40Wo0CJnvJClvWHyaCb7Q8kXibiNWrsjzUENrzW+gNju5b7b/s8naCFW/yfXsJGwA9DCbAUapSME0yojOzdRbmgzJX77Dxp+3RrSYONLnLLoVXMQYgjxQQfucQ2eX44tx/Xw6ZBao6vqH4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ruI/sI9Y; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ruI/sI9Y"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754647220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/i4TvRgG2SupWtDi4sXLJQrhRZE1+GPJqGCGGuIy7Q=;
	b=ruI/sI9YOHMbwWH3nyN9phr5zsGqPB4fnXAMzOj36JrZLCd72Y1VIYbzxyHcQxJjgxvf3d
	1VAnb95SS6nTjeIOhUlyBgTAr0iuiXwYwC97/A+LgqDOV/1GFQNsDi9I6eRzgU2VCq/z/m
	g743hlAKzGaRS9ZdLkdj4gd/R9qtMHc=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 0/2] Harden test t0450-txt-doc-vs-help
Date: Fri,  8 Aug 2025 11:59:41 +0200
Message-ID: <20250808095943.3312265-1-toon@iotcl.com>
In-Reply-To: <20250804073002.1586332-1-toon@iotcl.com>
References: <20250804073002.1586332-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

These patches add a few improvements to test t0450-txt-doc-vs-help.

When using Meson, some test cases seem to have been skipped. This
happened because it was looking for .adoc files in the wrong location.
The first patch fixes that issue.

But, because these tests were skipped silently (when using Meson), I did
not notice breakage in another patch series of mine. To harden the test,
the second patch adds an allowlist.

Toon Claes (2):
  t0450: fix test for out-of-tree builds
  t0450: add allowlist for builtins with missing .adoc

 t/t0450-txt-doc-vs-help.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  184290765e = 1:  cc1dd21b1c t0450: fix test for out-of-tree builds
-:  ---------- > 2:  b8c6d88c47 t0450: add allowlist for builtins with missing .adoc

base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
prerequisite-patch-id: 0000000000000000000000000000000000000000
--
2.50.1.327.g047016eb4a
