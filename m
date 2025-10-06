Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EBB2D47F4
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760589; cv=none; b=jFzAtzg5haj+2nxk6oZc9HNHeptVtFuhBzTQLBbemO6o32tAmCDBsuMXRqk4VGeiSBjWZaCIJ389ZEOyFCX5wlcvaANV7zgLCpKINNAWjwPFNCYR62UryKS450kJKS7vir0qztSWyuRuq652LBfRjoavXGeb8+G9rcpn8szaXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760589; c=relaxed/simple;
	bh=3k16jgWne/sZCXaN5YVsSxK2mGomSftW3+D4WvWJm/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eBDUPNZ1ZHuglSn83h0jeOItttQTsdrbjV7pD+wltXZ8jhWwXHm4uHuINDDxr7dPQXpsQotW3Y4EatINLUA3JVdY9KM7Mh1Lv/pM5mCAinK7ETE+n8GlY93/W0Uohmo7slwgotIjT8SKKbHikBtapFNouOi8W8fJndexBgyWGyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtWMo6+7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtWMo6+7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e47cca387so53728205e9.3
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759760585; x=1760365385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKMwCIBhkYIyGQOtpuXcYpTTuSgs/gHJw3UWimfUWI8=;
        b=BtWMo6+7BvhY3SStmtaScBaEtz4VuZXVB06a+3ZiBSBJQD5dy/AqTo3mVgHnJCBmG4
         BZFWxSkgeTnuwvXhAGDXhtol2aNdVD7uxvS8NqzBOgeDONR4HORboGL+LtAv3/XIRNZe
         AoEwpdNZkrnHdFucYpjWfVaL3TF2OZhHMaa0tcIxvzYMFCEkK+p3s0uy1No1CW16tV/n
         SGGuFpbaU3N8eNbvf/OEtnfEoGG1Nc+cGXrP9CP3A+GKNY8t4GgmiwPLsJ5h0P88WtXK
         Njg9pLxb5JDcdybJ/LkNSeOdL1pXvIKF5eN69K3/4sbQxe31mqVGjTS2Kr2mMiQ0hoyI
         vMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760585; x=1760365385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKMwCIBhkYIyGQOtpuXcYpTTuSgs/gHJw3UWimfUWI8=;
        b=WPSU8nhoW+EBRoJ1ZBx/o8qz+Kxzfa9/2LSSJoJ1t58VHIeRFGcx0vWY4PH6Hrsd73
         5+eGC2xRkNRhR8aHcOYRKrkrre5DIQmf5S2+TFtz6YjpGzRLIUoAG0Hf2pAA1YZQYu65
         hj4liPPOZx5LOGXzf0Xchi9kqIsU1dt6Ap4bPYrSt+KrYWjmrRIfO4o4g4qC1h1cX/Ql
         q17hn0KAeStmvlhYlgqHF2bnekfPuL2PaFrC+Z0tb1Cp57XGMb3UovXNR7mjjRpOyVwf
         44wWn6f1B34OiQ4Kyg9XpJl1V+GsYmCrmKK0euOlIu5zMVIEB7GGqEPjkfUlaQYl6woh
         dNtw==
X-Gm-Message-State: AOJu0YwZkb3XjSkGvOzsKrCLLDdLMk4BXRDoH1eg0gvLU0NIH2t90CLE
	aigVUFcLxFr3QAAId+2LYYTCbJcrkj6/whrM4Yl4MhbGoH+2l1BB6RV6/aSpR/4B
X-Gm-Gg: ASbGncuKtXt1lyyd+F0SB5hoBP6ozAi7RrTixaojuUJ93GHegE7jn6C7MGbuzXhKkBW
	04spWlsMTQ440DUhID49Mu6lRLCW3KwtNpGIim8Wbtm7TxnVp6US4CQbNn95K+1NRUXvcwt0TYl
	uc9NnlbuhvxTiap+h2fPobZygwhHDnLLK6Q6V08MD7TonAYX4eqCJB1uzxAgkar7F/Wl3POwFoK
	Q4M8TtwfR00SRFyUrQoAdyuBt/TgZ3/B39D+C0AvsmMU3jQLqhDus3TbjpKTyDqXmZCS1a2L3X7
	SPMLK8bK3z6YP1xU20gNOu8cN6llgRzyVlcUXL4t/ngFCv7ewFeqDCX8+jy/gbHY/ca/MG7YCko
	A8PxY//r/g8FX9UyXpVMYR47M/eW8kyuylsAVJRbm4n1T34Qom2aChM8SMieWTpG7u9w=
X-Google-Smtp-Source: AGHT+IHn/S5DRFq7k9Fgl2tQMAOW1TqqYlP3VSIPT0oSCY4bH9V3QFKHU3j5rjCAhtKNgvnqEqpSdA==
X-Received: by 2002:a05:600c:83ce:b0:46e:48f9:a17c with SMTP id 5b1f17b1804b1-46e7110ee58mr89519865e9.9.1759760585512;
        Mon, 06 Oct 2025 07:23:05 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234f547sm171237555e9.9.2025.10.06.07.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:23:05 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 06 Oct 2025 16:23:00 +0200
Subject: [PATCH v5 2/7] refs: move consistency check msg to generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-228-reftable-introduce-consistency-checks-v5-2-f196d386214f@gmail.com>
References: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
In-Reply-To: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=3k16jgWne/sZCXaN5YVsSxK2mGomSftW3+D4WvWJm/Q=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjj0MUP6wiOV43Ql4HT5awHhk0Xe3/LDjNgB
 ThuV+kX2dL/rIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo49DFAAoJED7VnySO
 Rox/ycEL/iAwG4ykD+Hm4cti4aPQWwgEU281kqlE6d8BTM3QWEEYeQKsym+SpmulIu6NHNXyMOr
 PbBEwmrwB9NjXRNIkT7Is12v/TyA3YTdX1TQkAx7aHM/m7mx6erVCxehjgTcVVT8Qcuz4UDFH6Y
 r63U0jlHBHkZJTGsGVnXHR8LurUmDTnsmDcvHQFQPmpdHj8NGoZEM/81edhysUNVMysyXcXR9Kg
 Mga7NSIxAAR1HvVcktvoXziRkTadCQmTtZuXiXemC56UMTzJaHjdZRCuZYE5H0DghKbvxYFSi1b
 6JtBlSITv1xGlFQ5S3yZ74R4zu/kLojGWUIceIFwXoAiFmDTDL+ZeVOr8t7Wv6p6fln3fEI826Y
 4kvb363dwX3QtGcGYvr5XFNOyOnFG/llvXSTnJ8c2JGHBtNVA4/g3LR+snDGHuS+wvWWj8SPtrB
 mp8GdGDltO5H/QdvHek0Ib1PllRXMdusNAmvqOAtWwhfQ0ceiI0L9PEdKvLr8hbEKo89mqpX597
 eg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The files-backend prints a message before the consistency checks run.
Move this to the generic layer so both the files and reftable backend
can benefit from this message.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               | 4 ++++
 refs/files-backend.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 4ff55cf24f..4a7c394226 100644
--- a/refs.c
+++ b/refs.c
@@ -32,6 +32,7 @@
 #include "commit.h"
 #include "wildmatch.h"
 #include "ident.h"
+#include "fsck.h"
 
 /*
  * List of all available backends
@@ -323,6 +324,9 @@ int check_refname_format(const char *refname, int flags)
 int refs_fsck(struct ref_store *refs, struct fsck_options *o,
 	      struct worktree *wt)
 {
+	if (o->verbose)
+		fprintf_ln(stderr, _("Checking references consistency"));
+
 	return refs->be->fsck(refs, o, wt);
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d4fb033417..603b1343d8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3906,8 +3906,6 @@ static int files_fsck_refs(struct ref_store *ref_store,
 		NULL,
 	};
 
-	if (o->verbose)
-		fprintf_ln(stderr, _("Checking references consistency"));
 	return files_fsck_refs_dir(ref_store, o, "refs", wt, fsck_refs_fn);
 }
 

-- 
2.51.0

