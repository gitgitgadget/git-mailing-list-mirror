Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A634D8B0
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770895; cv=none; b=Q6iwlh1O/UJAZI2KyDKckGajCfJ7Q2I1Hs5fCagg1WRMSLYMdhjsIdqi/m156MjEpR9jh1FQva/RqPpJb4IaIw0REcf5qkyOWApSy+WvdVWOEPNF6aMWgm34dwsqL7cHUT5x/eSAsibTSaaLbBbPr38EiOd+X5b+afzZicB/Spw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770895; c=relaxed/simple;
	bh=xeydqswhttx8qrTOS1HU6Dfi6p4RkIKqlC7X18CHQYs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pWTGzTAro6dbkkiydKeIngUWdOLGE9QU7bgpdjrpFK4XHEErZD6p3YaT9ehozBtrhH5udxFZ/DAIiO62sPPVUXogMCgPR5OO2pH9EmvfiORYD92p5Px2CVqx4OQGx6Pj27BmDpQg5AX6sOHXFQryyBG8Ixu0jfruKQYgAl1FJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUQY+O5p; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUQY+O5p"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c42bd0386cso1506083a12.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770892; x=1727375692; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGI/o1jWuiIvLVlR9uSstn80JeywKB+u8U6G0acAcTw=;
        b=MUQY+O5p4qFFOtoRAs7cbwakhTLhaztMEbckG8ZXuJJwgzhxIiPvsVhAB+ExdIfJ48
         34ngM97ffxNzr+G0mVpxhLQdH18WKF9SNwHNpFzDL5zM1G1mkyZgXIpAaG2gNcR14w78
         APynMWvwLuiMrRUXOjTOd3SAMkBdoVcXfaEeTD1SufW3uQtpMahTfx9Vo0X3GtNPnf/r
         r7FBnQ+9bvcpRzhU+OTrJK+25KKlGqhbJsF5uI4v+XTE8l/AkHTzZSh/VKk1Msciq5ut
         OK8tcIki6k5GvkDVcPiz9eDiXvph0i1gvDyqQ8Ssr0ksTBIKLCXxVlUQkWjLHscw3PpT
         UIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770892; x=1727375692;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGI/o1jWuiIvLVlR9uSstn80JeywKB+u8U6G0acAcTw=;
        b=GKFihCziqoIgrrGdTOo/TQ8vAOWzGyggBR5nZ+M8VLYS9DWfblc/pRD1RzYnkfq9rN
         W98fQncKPIgY4/LjfWuZrKQb1YyxszBejcmF5tC6KZYLJJo8OUlWK+RMg50u+sAfuBtt
         MnR0w/7mKJiKIFdNJBugYOuVrW3EPUw8N0AdQBgUbqMwlTmcuNL2pBfSNPcT4MzW2ZYX
         8K3qG6UfHVW4kEjWmnhM5J3Mmypl5UmZUD2th4TJdJwvvfMZ59DfhzDneISv29p6ntjA
         ajgHIyM5Sx3eH7few2vYfQIRQj37BMLPBq/RTCpvyigNI2fjoE/GlG5K75AsctbZ1ZOM
         6hJA==
X-Gm-Message-State: AOJu0YyREFAGrvNW4cMCrWU3RdXT7OfuFZ6FGXLL39RCZe2ijltQLN3z
	3r2byGgFtUDMZn1mVvOoYfPcyxz0iJYF9RxzevExCwT5a5xzTmgTjnD4Fg==
X-Google-Smtp-Source: AGHT+IFCwUj8f2wzW+7WQlkpLEyYEiJpqpTsD5aI7yNe2S/6Iu1/Z7stZWI2uUHDOwm9pRlmq5A1JQ==
X-Received: by 2002:a50:cc0c:0:b0:5be:ed72:ce01 with SMTP id 4fb4d7f45d1cf-5c464a606d2mr99631a12.35.1726770891987;
        Thu, 19 Sep 2024 11:34:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb53620sm6339188a12.27.2024.09.19.11.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:50 -0700 (PDT)
Message-Id: <915f395cb9fbed3c5d3de5d31423e2145f533e6e.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:29 +0000
Subject: [PATCH 09/20] merge-ort: fix typos
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
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix typos in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 merge-ort.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 3752c7e595d..3460d14172c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1147,7 +1147,7 @@ static void collect_rename_info(struct merge_options *opt,
 	 * Update dir_rename_mask (determines ignore-rename-source validity)
 	 *
 	 * dir_rename_mask helps us keep track of when directory rename
-	 * detection may be relevant.  Basically, whenver a directory is
+	 * detection may be relevant.  Basically, whenever a directory is
 	 * removed on one side of history, and a file is added to that
 	 * directory on the other side of history, directory rename
 	 * detection is relevant (meaning we have to detect renames for all
@@ -3835,7 +3835,7 @@ static int write_completed_directory(struct merge_options *opt,
 	 *     	   src/moduleB  2
 	 *
 	 *     which is used to know that xtract.c & token.txt are from the
-	 *     toplevel dirctory, while umm.c & stuff.h & baz.c are from the
+	 *     toplevel directory, while umm.c & stuff.h & baz.c are from the
 	 *     src/moduleB directory.  Again, following the example above,
 	 *     once we need to process src/moduleB, then info->offsets is
 	 *     updated to
-- 
gitgitgadget

