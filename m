Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A50A192B95
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474597; cv=none; b=gxem8/suezvBrXijhcQMRiB1CRcMGVX93HPYS3pXwUM+RaVcOmyUzJqFOKyEvIs+xwOFdbZDQe+CUSW5VUdJ5pVNYryqpBBPVXv3+/Y7UuNEBWQKGRFV4H9XQXhG30tDC3LymduvtbQD+ZocCa1J8QodoI3ZweXBnooh24cPuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474597; c=relaxed/simple;
	bh=s3zV9bm4kV/Uk7i3C81iy5NEfFH2aPgUAnaIM7pL0T0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mgpq3KnoSdqyBUjBArVk4tQ3RqYmBoBQ2B2zWo8m8UoxDL0N7ww7bfRJ18SBClpG9WAADdNetpAZy1/gkIon2uTh/cR5c9JsvpxZb7RjWri6z5T2W2BVEkCB82QG+mhJItADx6pw8Koc9xm9od12ULYcZbRaDYmt1jWNOuMeSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv2iQRYK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv2iQRYK"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9951fba3b4so491268666b.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 04:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474593; x=1729079393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z8RTixM3nIaHdMluTkPgszSBcaglUKaNqME2dUD4v0=;
        b=Hv2iQRYKwQid8uRQp21BE24OyIBpE15bjFAr0z7iJkL6PBcDfdk3rwSPj/d9ZRCs9t
         veEuR1zKKiTBMzsarNt1V8DpiYdtPYv21HQOdEfAA7ga5cp+9LCXr0JFJeMEYIv/X9pF
         4xg0j2XT2DPLsV0ngJSJ7/V5GIZUc5b2auLlewSuIGVYQ9R2tLJwJnRY5FbXVIa2k4fy
         ITseYuaQq2uDCQB868pEsou1bAHrWKqEvdwWYUivSG2y775LE5I7wfs71PZUnjTN/X4O
         CzbnK32mG6IkMG0weEGmCC7+hZwPNNLPRbJrVg8yh9pmgPuiuCW0UZOZEkzRNt2hrn05
         1E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474593; x=1729079393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z8RTixM3nIaHdMluTkPgszSBcaglUKaNqME2dUD4v0=;
        b=emI/0sPoQ/IgOnBPx8eb1JSGiFq0A+Q5vacV2OdbFzBvOOBiCAzFnX8NFS1bUUJTqU
         J5t5tyqvEGA9exYrt3gjbFRdacI9j2NinSLDPRjLRF9AmEHarUNF6pLSJY8AATex9aU9
         fEwMxphHUNjU8pFgAjlRtCDBu15GQMm2UzRWubROQmNFbjmrdH5BHO6zsO5yhD58s/gZ
         opLMFAri/2JlWkpaBaSkKpaqTlmcat4JBz5fzU0R2t+6WyNRFXH04N5O6bEOmcp+fC2s
         wofa/2+6ArdJ5IlRU5cYRa3ltBMi6QMZBth/VbGUo4JH2noxzxWQNwYGpBekYD7xLwMW
         T/Rw==
X-Gm-Message-State: AOJu0Yw3w77QLC4fmYnXA/iGNKtxk+JI3sVu/o2nuQffocPN9StPPgxG
	uHoD7wEV7koa2JDKJGByV9sHGROiqQ8xPREmD5AWuaoFbuka2myRxmFDGuz3
X-Google-Smtp-Source: AGHT+IFlCdmBRl1M7b+uYMWeMWFj3Su75kygypnYTTcYjMP6BiG40ECbNXudDDJTn+WQ28cAgFpMtQ==
X-Received: by 2002:a17:907:9451:b0:a99:90b6:1b10 with SMTP id a640c23a62f3a-a9990b61e5emr129973566b.0.1728474593359;
        Wed, 09 Oct 2024 04:49:53 -0700 (PDT)
Received: from void.void ([141.226.169.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993a4ff9f7sm595800566b.26.2024.10.09.04.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:49:53 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 5/7] t/perf: fix typos
Date: Wed,  9 Oct 2024 14:49:38 +0300
Message-Id: <20241009114940.520486-6-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009114940.520486-1-algonell@gmail.com>
References: <20241009114940.520486-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 t/perf/p7527-builtin-fsmonitor.sh | 2 +-
 t/perf/perf-lib.sh                | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/perf/p7527-builtin-fsmonitor.sh b/t/perf/p7527-builtin-fsmonitor.sh
index c3f9a4caa4..90164327e8 100755
--- a/t/perf/p7527-builtin-fsmonitor.sh
+++ b/t/perf/p7527-builtin-fsmonitor.sh
@@ -95,7 +95,7 @@ test_expect_success "Setup borrowed repo (fsm+uc)" "
 # time is not useful.
 #
 # Create a temp branch and do all work relative to it so that we don't
-# accidentially alter the real ballast branch.
+# accidentally alter the real ballast branch.
 #
 test_expect_success "Setup borrowed repo (temp ballast branch)" "
 	test_might_fail git -C $REPO checkout $BALLAST_BR &&
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index ab0c763411..8ab6d9c469 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -282,7 +282,7 @@ test_perf_ () {
 #	Run the performance test script specified in perf-test with
 #	optional prerequisite and setup steps.
 # Options:
-#	--prereq prerequisites: Skip the test if prequisites aren't met
+#	--prereq prerequisites: Skip the test if prerequisites aren't met
 #	--setup "setup-steps": Run setup steps prior to each measured iteration
 #
 test_perf () {
@@ -309,7 +309,7 @@ test_size_ () {
 #	prerequisites and setup steps. Returns the numeric value
 #	returned by size-test.
 # Options:
-#	--prereq prerequisites: Skip the test if prequisites aren't met
+#	--prereq prerequisites: Skip the test if prerequisites aren't met
 #	--setup "setup-steps": Run setup steps prior to the size measurement
 
 test_size () {
-- 
2.39.5

