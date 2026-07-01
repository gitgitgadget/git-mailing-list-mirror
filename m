Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF4148123B
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908342; cv=none; b=Let3nMnPzFlL9je2x8NhI7I0O/y0w/48K+45QgueEI5Kz2fnMQu50dghM4xPZTCOaEPPF49qT+S55SsSo/RfVwqTv2Auu3pjoY749cdI7wbuoPeSBGWUvvlafybHaEhEpddRE6rBasEQ2ZVn+lAk89xd1Qe53nM+n5Zl3WAuj6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908342; c=relaxed/simple;
	bh=eol08BwB3I9StoJOwxQzMWe4wy/cQvg9DiPvc7jm3f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbljV+Nn33nm8uMGh/W+xC83v9e463NPq5R1KkpbK9eOkeW5CBqy4dSedNd7sR36PeKsW2+PLZX498FyXKhKSsZHjwrlwLDqO690tt7Y634ayBIRS5tDhdXIHWdYsIHDPEOGPuMqpFjGzBr7N4FeysyLBB2JKtCcvvX1p7ReVJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG8Bm5D0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG8Bm5D0"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so5010065e9.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908339; x=1783513139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJFLcHfGJprrVpngznBcmtiMjl5IBaOwv2hCvFWMglk=;
        b=VG8Bm5D002Kz5Gg9qn/N0sNfltoeyjIBW8Y150ofhk5U61xoYkYAadLTjFk25Q2wEV
         FWD4ZjBlMelFZDdaYCP+meBe131+qDPgdE9o0BfXdgYutGKM+xczvyumtBkkpMR2n+zX
         4tcd6Fiyll/45vddomi3bE+/7bdjCj30qKe6fmPH5FICAlPlAAgJoAcOaAoFzRcaDz2K
         NT/dSVgiBqPDsFNnLaxJPl+m+jhaHnfF4xMMV6h6xvX6OuGIeYRB32GalfK7Ss11NiSP
         4o50bZk5oRjfhVbodJ2aKNA417Hfj8fyis1dcVhud4zzmTvP9FF41XI3xlHQbem4SnXg
         0wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908339; x=1783513139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LJFLcHfGJprrVpngznBcmtiMjl5IBaOwv2hCvFWMglk=;
        b=rHmJs847+a9XTPFgd/oXz/5/uv7wG/lINF3m+ybku8OhFRnw7iF6hdCacYlfl/YF8i
         5DE7m0ZFHigR/KcDhXWAG3BnDI9LYCyDEw6ZMKzVkvEcUaMZtlCU2VhPRnlf7UmfmdDP
         ftLK4H5yzQs+MpYkf8y8NrG2wsrd1LaKFy/h+57CD+p8XA58Gnj6Ra02D30a2RL11XQf
         GsqqxE3o0J50RDS6fu57mP2D7Jvnzl+buc9Eo92AEjlUWRXJbI/EdmYLUeGt2dtwt9Zd
         H5iXl18Y+RG4hl0WKHb5fZSUsnsbkcPv0eNX/3buI3ucQXLMlpJqMvzlF0dJedUEU/rA
         vdCw==
X-Gm-Message-State: AOJu0YwtoeZMxQbVgLZozucD2Vmrzi83hJ5GLQ7qVTwFxlfTwSSKT8en
	0TkDADkpZ6vUcMgsWsn2TzZUdAdCY2N56tAI7IVPjUvtTmFz04Lul3G6+xj0ulmi
X-Gm-Gg: AfdE7clO+vcQNr7AvYECLu4w6rgBT8rU4uHZ2tcwc5je13SNZ7ywPn17T+/bOTORNYK
	M6jEjJDXvcy0VYi2EVh0HZseomfVhJyIgGjIZh6ob9jbrMEGxZ1ibt7HHCW4aOIK9TRSM/U3QTo
	PO/SCn7mOHPGg3UVRNYfeq4PQG/c789XAtsATiUzkFJQs5pZYgm8xfoKHUrSDYJBaYWMNIwhk23
	EqjWGFPAwaN1ZOQanAMm7c9lyemWwrnOD9nLpIozi4+RoXlaQv1zYWDc/Zr0T1ry25RKdy/gH/n
	aagFp3yxzmaUFbh3NYl6ROYc3+x/qtYjJvjCxJ2X/GmKXFIOZFORmJlNhAUVzuSc7n6c+9Ozv/4
	lIEEkBvbWhsGabRJtw+WR3zClEqqGw3yWMd+0rXdosWx2R1jNnT+Y3RPTSSHrkquVpATu7CoZK5
	FixnvZqgMhclJoCePdPMS7LsMw6wkhgB7Dij78AfJuY8crgK8EtrpgIfFrlBmAiDoPM/sIxlxwl
	JZxbENU8uBcSla81bRPtFov1nF9EGtab8lLFYCJVAZ7gdvGa6rWi3NEN7E4aZoTKT3YGuLAbqDR
	rSHJVTmZKPH4CrpNswp3l2PpqnC7+2wjfp+mYJk71ZvKcbNTAyNTvdFGXJDUIGP4DZuBLGNyeQG
	mMY7t4gLHr30WRtmI2Hye
X-Received: by 2002:a05:600c:524a:b0:493:af0d:484c with SMTP id 5b1f17b1804b1-493c3df2fb5mr4990205e9.34.1782908339172;
        Wed, 01 Jul 2026 05:18:59 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm68267235e9.9.2026.07.01.05.18.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:18:58 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH GSoC v15 08/13] fetch-pack: move fetch initialization
Date: Wed,  1 Jul 2026 14:18:42 +0200
Message-ID: <20260701-ps-eric-work-rebase-v15-8-c88a43b63917@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

There are some variables initialized at the start of the
`do_fetch_pack_v2()` state machine. Currently, they are initialized
in `FETCH_CHECK_LOCAL`, which is the initial state set at the beginning
of the function.

However, a subsequent patch will allow for another initial state,
while still requiring these initialized variables.
Move the initialization to be before the state machine,
so that they are set regardless of the initial state.

Note that there is no change in behavior, because we're moving code
from the beginning of the first state to just before the execution of
the state machine.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 3d32114907..cdebd3476f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1736,18 +1736,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		reader.me = "fetch-pack";
 	}
 
+	/* v2 supports these by default */
+	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+	use_sideband = 2;
+	if (args->depth > 0 || args->deepen_since || args->deepen_not)
+		args->deepen = 1;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
 			sort_ref_list(&ref, ref_compare_name);
 			QSORT(sought, nr_sought, cmp_ref_by_name);
 
-			/* v2 supports these by default */
-			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
-			use_sideband = 2;
-			if (args->depth > 0 || args->deepen_since || args->deepen_not)
-				args->deepen = 1;
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);

-- 
2.54.0
