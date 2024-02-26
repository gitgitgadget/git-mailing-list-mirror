Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C7132C24
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983580; cv=none; b=cXEokF9bY6Bo71pEj65U3UAJml5H7lhVPlODBz7gYIG0q0ZmCqkXP8GATpPbggqVJP9G5IB5woWAFatdLKLVFgX4klbd8cGIHUEk0BAxl/w62OVtbgx25c/i1UX+AgcVcuEjsXgN69hN6cR1CIouGzue6ZfdiXmYZyK4AbIlJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983580; c=relaxed/simple;
	bh=vqm4G/xjIG6sSMGS8RrYC2EUdXZeDpDy+p41OkIjzo4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LkfxFmysGsbtXZJuCfthhxCV60tRAr+BxcyLmCjv+spln2Y0Fki3WTVXvAMW1WTif7qS3czKxCdLYKSrSMimKSjJjbCxsc9FuDRyAz/7uO6haGsP8gb0IRlIA86VTQOh4SQOJ9v8pZqv1yChZ5qZ3ynE57l/h5rmOfcuyklJ/hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSYzlL7V; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSYzlL7V"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412a9f5f797so3341985e9.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983577; x=1709588377; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvR0LWAdDaI2P27IRzGTNNd7zrRvg64gWm3EaqhZ+Ak=;
        b=XSYzlL7VgtSkDplPpNezGxobkW+BWR1yx7tZiO6UbnBtfyBy2KvcxyeDy+mtDRpjwl
         dI0pwGPbRiLDciGo2s+knUfM3sjy1rFofsQ/wR7U1qYl9cy4jKSOCgsWVc7DuvvZSjH5
         7vFUwjlozsqdwSCn0WL0Mw4TFM0vtJ2BoKCnusGyjEQFLvZ0F9Z5gK5xaEvrV83CTTDs
         kplma2B26U6Mfdve5koeAglCSUsLu2+AWzLYhhrSgnmGFOXwvWcvByoILhtnklD1aXvm
         BufQMEyeD2zas64hiD2ILKIU+aoRK/70n2OHpxEKt0cvmj/RtEU8S93ErQUPSrupqFCu
         WwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983577; x=1709588377;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvR0LWAdDaI2P27IRzGTNNd7zrRvg64gWm3EaqhZ+Ak=;
        b=BdT+2NID3f78omvijR7rceeQYo0TY36ExcdpoKFBxgI+WHv8jSJM4zs+mwVTZRWuZS
         w5wANu9CXyUsFtTkyOXakAaxIjW6oosQQUvl77Ux4iDRWz4M0n2ZfGzjq39mXef0qaSt
         4f9u4DoCWOHtsL95S27AtCyRm/GgrmnVBtwthTTu4qQEcvbnkOGgBlPv0D0Rsp2GR9Ym
         vGRfnYICnd1wqhX475JmBY2LKRK2rnp8pflqdGeUAB895VYkSwqJCqWKycNU1KOFkPtS
         jekdsiwGEyfv4gmBRk6jPHZPRa60t1Ga4buAVGhZB2FHmambL52wSno+8bc32EnpieAO
         Q+5A==
X-Gm-Message-State: AOJu0YwLK4lj1XyEAZ2PfABHxH987W0mjBXITCN9sei4U+VLgQ7LH5/9
	eakiBcStqZh2CDSgTNPmkP6GvrL2w9LoXUfrtBPoo9SgLXX3oV1AmOFOu7iE
X-Google-Smtp-Source: AGHT+IHDSw3ej0RmLwJOCCJVZLDzm2K/slPnGOQ0zjlmcVuXn0zYgU3y/LLoZEmslcHCsYw/wlsEXA==
X-Received: by 2002:a05:600c:1394:b0:410:c25d:37e9 with SMTP id u20-20020a05600c139400b00410c25d37e9mr5965290wmf.16.1708983576778;
        Mon, 26 Feb 2024 13:39:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jd17-20020a05600c68d100b004129335947fsm13092423wmb.8.2024.02.26.13.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:39:36 -0800 (PST)
Message-ID: <53f73c1515d0f64bf13f0b30e9039dedbf441f2c.1708983566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 21:39:22 +0000
Subject: [PATCH v3 11/14] fsmonitor: return invalided cache-entry count on
 non-directory event
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
    Jeff Hostetler <git@jeffhostetler.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Teach the refresh callback helper function for unqualified FSEvents
(pathnames without a trailing slash) to return the number of
cache-entries that were invalided in response to the event.

This will be used in a later commit to help determine if the observed
pathname was (possibly) case-incorrect when (on a case-insensitive
file system).

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index a51c17cda70..c16ed5d8758 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -196,8 +196,10 @@ static size_t handle_path_with_trailing_slash(
  * do not know it is case-correct or -incorrect.
  *
  * Assume it is case-correct and try an exact match.
+ *
+ * Return the number of cache-entries that we invalidated.
  */
-static void handle_path_without_trailing_slash(
+static size_t handle_path_without_trailing_slash(
 	struct index_state *istate, const char *name, int pos)
 {
 	/*
@@ -218,7 +220,9 @@ static void handle_path_without_trailing_slash(
 		 * at that directory. (That is, assume no D/F conflicts.)
 		 */
 		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
+		return 1;
 	} else {
+		size_t nr_in_cone;
 		struct strbuf work_path = STRBUF_INIT;
 
 		/*
@@ -232,8 +236,10 @@ static void handle_path_without_trailing_slash(
 		strbuf_add(&work_path, name, strlen(name));
 		strbuf_addch(&work_path, '/');
 		pos = index_name_pos(istate, work_path.buf, work_path.len);
-		handle_path_with_trailing_slash(istate, work_path.buf, pos);
+		nr_in_cone = handle_path_with_trailing_slash(
+			istate, work_path.buf, pos);
 		strbuf_release(&work_path);
+		return nr_in_cone;
 	}
 }
 
-- 
gitgitgadget

