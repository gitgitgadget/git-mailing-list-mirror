Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4529E116
	for <git@vger.kernel.org>; Sun,  3 May 2026 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777822455; cv=none; b=JGDbq0AaVT2t8oHlivIU2wFOLXp8ijN61f1Lhsry3J4jE9ZYFIBOE07YLTHWuahOBfJbIqadUzL5sucHbjejR1gkDBWFwOpSdkVOz/Zd8Tt4f8gS5T1mm4OOjblduFNYnAUtMFATzDsLC9uTrEy9gKLmaKgDIg/Sx9q2gNIthcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777822455; c=relaxed/simple;
	bh=u6CGZHisxyJI0v4wtGWYWKrA/J4wqBRxV8pC3NZ1Qr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geN05bvrvkxMk2aGYdayjdkqGqRbiYuUU1lPpPQnhgEYo6t+El0wkRRY254H/own6CADR/cJAoeES/wGrT36FXv1oreOCo4dyhsfmgJDHkgLGvK3TQZ9mKKzR5KYc+WNnB5xUXQ/6CY82NQY1cSa5KwbluDbkMev3RGzO+Bq9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ul6ZHbzo; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul6ZHbzo"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-364f65f6eaeso2002705a91.0
        for <git@vger.kernel.org>; Sun, 03 May 2026 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777822454; x=1778427254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1iMQLnlmeqDjH/a7cpt6L900kfeABF6g9NvSIHnBCo=;
        b=Ul6ZHbzoASgnJ0/IVxwNhVK58dkkvN6SPa0zSwoDe3H71j/RMOmlvRQcMQDX5LHZjY
         +hOpeOojUaGQFUf1qAjDO24lFLTbvjIepRyXkWi75S5EAswdanZEqm+k8uEavUnjWBk1
         WB/wNABXplntOPSSyislZ8uqKhVFkzY1lZCwc1fENEUTjm7qwglGszKF3HyMQQUIm7XW
         pMNJSmnUvIIaxLi0dGqLffh+iMDva3ryW2jtzhuUYrIn8pLjmo5Vh83cmmuj2V25JCTV
         nZ/kti+TdNj+A/4vaN7x7hu25S1AV5pEZs3oLNO3yRBRn5uEjNQ0BOE5/nxSN/FwF14+
         BgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777822454; x=1778427254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f1iMQLnlmeqDjH/a7cpt6L900kfeABF6g9NvSIHnBCo=;
        b=V/oPi7ix3GRHxRaJSnxSqdANtYK6wLxbb9C/2P7v8dKqI6kvEsWX57qSXDIb0L84fV
         PIw9+krbaN8qrE1OZDy5t4RJY0+UHRyVn5ilqZRPD2VWkDaHMhZvdGCuHxPR91eLWiT5
         r847xYgCtgIAn6i+T3rzyPD0qXqGZQ8OkM0ooClQPGbyckB492pHrwO2vXsq829Y24Rm
         ANxbOBwaXvIF8uR6KVd62WnVmc7EW2cRQ+QeHLG5S8JbJCYsJsPFs19wSnRX9xy8b1/w
         45qsRpkC3AuQcraRTadIhsC1yLumIz9otuMaHnhcVJGuRbY9golgXZlAPDSs7I5i/GqC
         34eA==
X-Forwarded-Encrypted: i=1; AFNElJ8aMtBHIPd606BqIjf0R2vdHN/1WHJQxLeoM44KlFyI0hZ2Jv0W/gporsE0BTODKcdguIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcao/TwMHslLPd2pLHNGpVB78gwsID/QEA1n7zDrKkU6Mw4j0r
	g8/qxN7WqkxUDY3MTF3vSEQDsU7OMlpRyiljiY0E2mNWl1Qtx0yWnxFP
X-Gm-Gg: AeBDieuFvraiNZofl0NjEWxblMBqXYHTMIU8yfM9go3kqgL+I8fz+X0iFr4bV2/nd17
	jY6mth3q0NhUJe9MOkm7LBgOCgTMMKeHPoGrM2ryXqzRzicsxYf1r0O9ZcJKbYob/3EIQcvt7nm
	T2vCM+M99UdibnDCoLA5Sa417SgOV5QXjRzoZJl5MpejTsw7rMxYytysa+zgmmLZMNoKcerYhvn
	gmQSAOTIU815tRCTLwEef/s3tbFkdVJvNDs7x7WP4SUc6hQAl30STd4qg/sZ/MYWkVIa5YokLXl
	VDpiAerAFkimmqxEs85izKcq+4M5esEZyY16qnrzag3d8QoT+bWEaQ4XbxEDZsjee28ROc60UQF
	t8Gq9b86TbtcrXQC7VZfdQ0QsCSvuVtrlWcSHnHlNrVbR/tiW/fmLYQ5Sf2gjJGq6+wzi9bzQ2M
	qit0WmFVRRwWnlIhJiXupHGROmi045hJJAi1Iv4eEjNlfqK+g52t45qW6I2buX78uu6B8vKYss
X-Received: by 2002:a17:90b:38c7:b0:364:8c50:d421 with SMTP id 98e67ed59e1d1-3650cdd0357mr6438208a91.7.1777822453590;
        Sun, 03 May 2026 08:34:13 -0700 (PDT)
Received: from archlinux ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0f0acsm74618375ad.38.2026.05.03.08.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:34:13 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH v5 1/3] remote: fix sign-compare warnings in push_cas_option
Date: Sun,  3 May 2026 21:04:00 +0530
Message-ID: <20260503153402.1333220-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503153402.1333220-1-usmanakinyemi202@gmail.com>
References: <20260427140530.856125-1-usmanakinyemi202@gmail.com>
 <20260503153402.1333220-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `int` with `size_t` for `nr` and `alloc` in
`struct push_cas_option` to avoid -Werror=sign-compare
warnings when comparing against size-based values.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 remote.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.h b/remote.h
index fc052945ee..741d14a9fc 100644
--- a/remote.h
+++ b/remote.h
@@ -418,8 +418,8 @@ struct push_cas_option {
 		unsigned use_tracking:1;
 		char *refname;
 	} *entry;
-	int nr;
-	int alloc;
+	size_t nr;
+	size_t alloc;
 };
 
 int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
-- 
2.53.0

