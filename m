Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D238812D17A
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212988; cv=none; b=njGGmVBWXr4OSsr3FDkVzJmeHda+bEfgHLl2EOYHE9WByqFImipHso9HxcNw7SKCQRiVCtjWayE8fP38smfC35BuTiSFpS5mQ31KhDj6CgDUoQzFO8ya0g46nv7lAbe6XnlXZbFuY0lAfjv4bD8rvYDrNVw5RoRpWEbYqGci3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212988; c=relaxed/simple;
	bh=Xq7WRXhxo0C1kRAmZ99K0pnF6HJm4Bw5bwfBCsQ5cn4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QT3DsQAg5pyxxZQmg6eNnKwfJwBMyV+2hqrcdArhyMWKX2MafY2UVAjYievjdndmCVr6/L5dcvpeLxy2Y7EygOvdQvhjdBFbu+Uz3Ts+BlDR+Ez/3dWV03AebcCFy1jzPi7HPJDn+NpEUnOJE9gFmyzAnFwuMVd6dunocFmHmYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS3WqAHW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS3WqAHW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fe03cd1caso7515305e9.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 01:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707212985; x=1707817785; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+i8PkXYJCTRN8cYGZeTF3cwl+HgYBrV1XX86X8PXc4=;
        b=ZS3WqAHWmJqqDIEj1EM1FSDoDG4fBWM6Ets73ZVN2CBINJn9NC7NXs4IUAl9WfY3o5
         t5AXVKkQw3JvSFhCzGHQB20+PWncps9jxYqaQa4/gzvj0nyVakGbFVPhK045mLM9DTND
         b3EScBXTR45HLjLJJqHczJG3Y+lYs2uz9XvtSNnFFe2+sGHhMUNKwBYKU/D3Sr9D0LXK
         B25/ZB03veFT9MOoVq/xnqWeYtyIfdyp6hqz5btYy9ir6QabHHQA9EvnS1S0iATuJbv4
         MBw5EZ+ayUfSRiQU58aIaAFC39Z5d6oDAi3rxAjxJm3wliAmgFOBVmymLdxD5QEHYFqF
         r/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707212985; x=1707817785;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+i8PkXYJCTRN8cYGZeTF3cwl+HgYBrV1XX86X8PXc4=;
        b=ct//q98UlL5UeDnQQbaSOIp+UsPvGJNPwkFnh/rKrhRIQtEP1FYzitJ4LlJeC5horP
         Wf/fBV5D6L0QlizH5PRr3w0fHh8fYFk8dro9JG8CMK5Fj2vIqtMDDK60lLSBh9DsX5Wc
         JueutQt0aUkfzJGZDmeOshaiGXaT01eB4HNTiVAei037lA2+vIERFM2Q9Zsko2/OB2i4
         fmRMoMgc3kRh1k77Ixem2qZSvx4MCOLaholuHN6ZW60487uOVxpasQ/7hD87gkg/nGSa
         HxlIgql260161/MhS1z49Kvp/c0/b3olsMGf3ozpgOVnGUVP+kRXXnNnH7HTXcDxkDs8
         JJUw==
X-Gm-Message-State: AOJu0YzlQ7BXa1cYVAlb72dC+c+1syDkIMYqKvEtkzOu42Fp3Ru4GLuX
	MfcmHzkfM1Hecz68QD+EYB91Y4H/PLMRjqmnUN16hKrBN3Y93OgzncGFgapA
X-Google-Smtp-Source: AGHT+IHNFwTQhESqdsmyyPot0gMSjHWRkTlgZDW5fH5tEcRzHeleYL8Kcfq+8RMSg04x6QMdDeRz3Q==
X-Received: by 2002:a05:600c:1d2a:b0:40e:bfbf:f368 with SMTP id l42-20020a05600c1d2a00b0040ebfbff368mr1848598wms.2.1707212984626;
        Tue, 06 Feb 2024 01:49:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c154b00b0040fafd84095sm1428314wmg.41.2024.02.06.01.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:49:43 -0800 (PST)
Message-ID: <3e5b787fc03493b1feaada7ef0011ca2d33f8820.1707212981.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 09:49:39 +0000
Subject: [PATCH 2/4] merge-ort: do check `parse_tree()`'s return value
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

The previous commit fixed a bug where a missing tree was reported, but
not treated as an error.

This patch addresses the same issue for the remaining two callers of
`parse_tree()`.

This change is not accompanied by a regression test because the code in
question is only reached at the `checkout` stage, i.e. after the merge
has happened (and therefore the tree objects could only be missing if
the disk had gone bad in that short time window, or something similarly
tricky to recreate in the test suite).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-ort.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index c37fc035f13..79d9e18f63d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4379,9 +4379,11 @@ static int checkout(struct merge_options *opt,
 	unpack_opts.verbose_update = (opt->verbosity > 2);
 	unpack_opts.fn = twoway_merge;
 	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore */
-	parse_tree(prev);
+	if (parse_tree(prev) < 0)
+		return -1;
 	init_tree_desc(&trees[0], prev->buffer, prev->size);
-	parse_tree(next);
+	if (parse_tree(next) < 0)
+		return -1;
 	init_tree_desc(&trees[1], next->buffer, next->size);
 
 	ret = unpack_trees(2, trees, &unpack_opts);
-- 
gitgitgadget

