Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3861684
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857551; cv=none; b=oGA7Y4LDC1Z/NwToeEkBECOJ2ruX6nYIicI2jwGUVW+0QxnmR0Yrx7hB17v9t61/ikAreHiYyjPl6wGoAYQ7Ptma1C1FMWblUEpf15XgrPrv5WdtaGe27jq/AoQtmh+NO2AVuO2Z19wIIC1srHUHXogN2HG+7zc49zy8HfFyn+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857551; c=relaxed/simple;
	bh=jgB3VL0aShC4tYrJuzj+QOGMT+Ag6jFrQX2enk1siBA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g6SoTFRa2rnT7L7lQD9NaeS4TDgwSFVL5a/bMCv5REGXZ5RcwX1WV2dcAgwo/2UaVP3ooxDRbJZkAw8ORg02YJ4OMM3cGtzFTMjJX+LzZQoMs9rVfbKrgDxDYX8EM2xHCSg94rOg6q+i1y95Ym9jHhUaXf3aCdEN9VjrLm+D4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kM1rGIZS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM1rGIZS"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-411c3b299caso7519405e9.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857548; x=1708462348; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+BhL80c8uewTd34a/xkpNgnLwIZgGYER9EumuNmNj0=;
        b=kM1rGIZSJNt/hHRu1pCnZLLBWx1Pv/pLCtRKKO8DeECpnEupeTCLhHp8dMV/Yrj2wF
         BX5XxyBPHfFU68trBvfDpVB9WykZR8wkvkt9upDyVp4mUr0likCVXcuDdk0J2lMUfwl2
         WlJ9OGNtK07q4TEPVPgkgkqYE/mRD4yWU2ICMvKR2j2j1u3PEHLNWihW0d6SLxU7I/Bq
         EL5RwO+qsPylul9VO37ZCCVtGEL4k6+cbd0AmKGK8FdQzV9y4ALG4wCtfsDtK7XAkyjJ
         WBksw/fdshX7BYd2qt+S0sEmEL3zOY5uzve1k4DElM282w6rgVLs3yGWT1wIKJr1eIAs
         Ddgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857548; x=1708462348;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+BhL80c8uewTd34a/xkpNgnLwIZgGYER9EumuNmNj0=;
        b=tUY8j3sGQqC4MsWgT4zQ0Ala9bRNus8p2ArNj36h7tPUaHHQhglEvhRDZcSh/BXjiO
         cmK9TiRwBQZ5qGN/im8K0cSAgtxK4eazyAKRU5WClxCgj3/cTQUkx5/D4tYWBUCqQjcE
         1t7kS9zWTn7ylcN1P8iw3wdzO0NdPDHj51Sgns89D+ue/lvVeg2BrQpod3s5nmNpURAW
         MmLaOtsJocCCAPZedl0g1xhpnUFwE7V2HmW5KaFAL+leFAgmTeocBBHR2Owi+n+M3WSx
         Rn6eCrKgygRsPKB0lzq6Jrw/oIOann8guNLSuKUCIaYf0ESQLICJv5mDY8VcUaPSh26M
         xhRQ==
X-Gm-Message-State: AOJu0YxGgxppjSSWCp3ykZg6d4rniG1rPynHMc9MiJ63VwHPCPg2PNrg
	+S1qRK1BYwB1hxR+uVw63FUKXgC6nGviCs3uI3hPghsrRZixMmudeAk47xF8
X-Google-Smtp-Source: AGHT+IHJDQ6hX3DUe218WPM6nVi6O1zQNH7W9zme1VCS1/SbWN6yEKTXyC5qDkn2q3/6xDy3CF5buA==
X-Received: by 2002:a05:600c:34c4:b0:40f:b01d:61a8 with SMTP id d4-20020a05600c34c400b0040fb01d61a8mr556086wmq.38.1707857548083;
        Tue, 13 Feb 2024 12:52:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10-20020adff38a000000b0033b0d2ba3a1sm10423650wro.63.2024.02.13.12.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:52:27 -0800 (PST)
Message-ID: <5b6f8bd1fe7b6c742b25a5a1ed95b528f352215e.1707857541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 20:52:15 +0000
Subject: [PATCH 06/12] fsmonitor: clarify handling of directory events in
 callback
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
Cc: Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 614270fa5e8..754fe20cfd0 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -219,24 +219,40 @@ static void fsmonitor_refresh_callback_unqualified(
 	}
 }
 
-static void fsmonitor_refresh_callback_slash(
+/*
+ * The daemon can decorate directory events, such as a move or rename,
+ * by adding a trailing slash to the observed name.  Use this to
+ * explicitly invalidate the entire cone under that directory.
+ *
+ * The daemon can only reliably do that if the OS FSEvent contains
+ * sufficient information in the event.
+ *
+ * macOS FSEvents have enough information.
+ *
+ * Other platforms may or may not be able to do it (and it might
+ * depend on the type of event (for example, a daemon could lstat() an
+ * observed pathname after a rename, but not after a delete)).
+ *
+ * If we find an exact match in the index for a path with a trailing
+ * slash, it means that we matched a sparse-index directory in a
+ * cone-mode sparse-checkout (since that's the only time we have
+ * directories in the index).  We should never see this in practice
+ * (because sparse directories should not be present and therefore
+ * not generating FS events).  Either way, we can treat them in the
+ * same way and just invalidate the cache-entry and the untracked
+ * cache (and in this case, the forward cache-entry scan won't find
+ * anything and it doesn't hurt to let it run).
+ *
+ * Return the number of cache-entries that we invalidated.  We will
+ * use this later to determine if we need to attempt a second
+ * case-insensitive search.
+ */
+static int fsmonitor_refresh_callback_slash(
 	struct index_state *istate, const char *name, int len, int pos)
 {
 	int i;
+	int nr_in_cone = 0;
 
-	/*
-	 * The daemon can decorate directory events, such as
-	 * moves or renames, with a trailing slash if the OS
-	 * FS Event contains sufficient information, such as
-	 * MacOS.
-	 *
-	 * Use this to invalidate the entire cone under that
-	 * directory.
-	 *
-	 * We do not expect an exact match because the index
-	 * does not normally contain directory entries, so we
-	 * start at the insertion point and scan.
-	 */
 	if (pos < 0)
 		pos = -pos - 1;
 
@@ -245,7 +261,10 @@ static void fsmonitor_refresh_callback_slash(
 		if (!starts_with(istate->cache[i]->name, name))
 			break;
 		istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+		nr_in_cone++;
 	}
+
+	return nr_in_cone;
 }
 
 static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
-- 
gitgitgadget

