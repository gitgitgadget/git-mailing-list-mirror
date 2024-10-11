Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B167820ADFF
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635070; cv=none; b=UbwOF/Er9wfy6GRinnop3+FdCxi+vgzDgKRPUJqt6JjJzXeYAdGS/9/jJr+E1ERvrn5Cj6lbmYEVAQCJJfqUZzX2LGjl/+lUaVT7qPPyOODGcfz3raQ1aj/UMy5DLw4fvrvZ6O42b7tpFUEDX5hnFsOQFVryh2dhXQbR/hSJ7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635070; c=relaxed/simple;
	bh=kaabz/6sfZ714al2ILcyRJYb9RZU37PfLSYbEjJMROU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYPBq0dw9ropnVwSxc9T3hzCYma5ThhNGY3GMH/XIh7/IsewgufMb2EFG/lR9AAUc4kBH8+ICgTaIvLSbuPLyo3y/KTK3VaO9MhtGJ9Zrt2FalMF7VWEBx/Y2VYMQGx2O0e8o0EpdWIthDPswJ3YEKfilLyu4v7QwVb6z1KknIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Nsbg9eEu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Nsbg9eEu"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20bb39d97d1so16643495ad.2
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728635065; x=1729239865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVi/K/K7xb3JdT6OhwnwPhP+OqrFV2WObVuQYLZqLAw=;
        b=Nsbg9eEumte9oKP0puNEyv4wd4rUVUm/Q1UPTOyhOkF/XNCOv2QS7FTfHPpPNgNkiw
         fD9zYdk4x40EzrhPAsCM/9m3eu5jCsTaaqQXGQTUZPnoziG/fdfb6Lu/5uvTIv3oLYRd
         fEriZ8Lu+aoganTVOuzJHbNgsDAJRMlNL8c7F3q/M2K1XhtmwSChQGwZY/Ma5qtrkll8
         KwCFT3nyp15oSo8oDyOEqFgeW/ekPXvvH3ZOMxKm/sVcIaxSFwW2+2vg5vw4HVtWcDo5
         /+qlTEZymvaDdYa28l+hWJaMaq1tGj6ir1hX3WmyclnLEdNtnmhKLrqjVKZL8Mcr+bhJ
         LCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728635065; x=1729239865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVi/K/K7xb3JdT6OhwnwPhP+OqrFV2WObVuQYLZqLAw=;
        b=MU5g3h+5243FZ3SIPGMxpX0Tz7HkmrwbBvc6Mb05KTJ+RD28tgCxGFKvaRVH/lLtCo
         5o1JEj0LbSdCeKvqvpTguTq4ctAqiz7DMnJXhUb+jbgIS0zHlpdxMxrAYyzYpEnHXcr9
         2lstfVpskKpcvqzY8Xnw18+NCW554WdjavKPJlkt5iyCfRC/QqYIkG2IpcXuGCTtf4+O
         jfuUTwEHXYknljfRmEwezSzZLEWPnRPyOIwOnD73cE6AJJ8FVhwR4BRW9dawWOOKyvf2
         qAMQwzqydQUAlZdNTcE+Yefc6xVyoWFhjHVEBDJc66a5mF5+ymn668vgT8q9NSub/qBO
         kd3g==
X-Gm-Message-State: AOJu0Yy0PkXz0b/gM5rXChtzWwNw33TWBqsTyZc7LpOR0xrqQYKM1cg8
	eNtttvOX1FOqDwbqNRBz3d+18+Z/Nn7V2a/484PhIczyiyie4ynF18vAz9OA92JjBARk1ED1QnA
	yviU=
X-Google-Smtp-Source: AGHT+IHXDpZRrIdrGjt9/R+ILhfqeaRcTdP15+f5N5NUNBjLFdu4P6OsVcktD+NN/e5QbgZZYFWKOA==
X-Received: by 2002:a17:90a:cb8e:b0:2d8:e7db:9996 with SMTP id 98e67ed59e1d1-2e2f0aa5605mr2461137a91.13.1728635065534;
        Fri, 11 Oct 2024 01:24:25 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5fa8ddesm2643121a91.39.2024.10.11.01.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 01:24:25 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v3 3/3] partial-clone: update doc
Date: Fri, 11 Oct 2024 16:24:04 +0800
Message-ID: <20241011082404.88939-4-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241011082404.88939-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20241011082404.88939-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document new repack behavior for partial repo

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 Documentation/technical/partial-clone.txt | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index cd948b0072..9791c9ac24 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -124,6 +124,10 @@ their "<name>.pack" and "<name>.idx" files.
 +
 When Git encounters a missing object, Git can see if it is a promisor object
 and handle it appropriately.  If not, Git can report a corruption.
+
+To prevent `repack` from removing locally created objects, `repack` packs all
+the objects into one promisor packfile. It's no longer possible to determine
+the cause of missing objects after `gc`.[7]
 +
 This means that there is no need for the client to explicitly maintain an
 expensive-to-modify list of missing objects.[a]
@@ -156,8 +160,9 @@ and prefetch those objects in bulk.
 
 - `fsck` has been updated to be fully aware of promisor objects.
 
-- `repack` in GC has been updated to not touch promisor packfiles at all,
-  and to only repack other objects.
+- `repack` in GC has been taught to handle partial clone repo differently.
+  `repack` will pack every objects into one promisor packfile for partial
+  repos.
 
 - The global variable "fetch_if_missing" is used to control whether an
   object lookup will attempt to dynamically fetch a missing object or
@@ -244,8 +249,7 @@ remote in a specific order.
   objects.  We assume that promisor remotes have a complete view of the
   repository and can satisfy all such requests.
 
-- Repack essentially treats promisor and non-promisor packfiles as 2
-  distinct partitions and does not mix them.
+- It's not possible to discard dangling objects in repack.
 
 - Dynamic object fetching invokes fetch-pack once *for each item*
   because most algorithms stumble upon a missing object and need to have
@@ -365,3 +369,7 @@ Related Links
 [6] https://lore.kernel.org/git/20170714132651.170708-1-benpeart@microsoft.com/ +
     Subject: [RFC/PATCH v2 0/1] Add support for downloading blobs on demand +
     Date: Fri, 14 Jul 2017 09:26:50 -0400
+
+[7] https://lore.kernel.org/git/20240802073143.56731-1-hanyang.tony@bytedance.com/ +
+    Subject: [PATCH 0/1] revision: fix reachable objects being gc'ed in no blob clone repo +
+    Date: Fri,  2 Aug 2024 15:31:42 +0800
-- 
2.47.0.266.g0b04b6b485.dirty

