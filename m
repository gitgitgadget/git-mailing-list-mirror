Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669217ADE1
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375253; cv=none; b=M6mkBJ8lDRwmr2VLgOk0BpEq05bjjO+6aEhFpjzFgD8NEgXbpx0mbG5LbLAautaE9ZIkKxi8rb0Om+uKJY7sff8HpT2uQ61O5QhsIlv72NrjCM43T85zYRjFBV1D4jf9luaqmLsEZIcM4KomPRPM86eWxi16AoLPTp/emIEqcV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375253; c=relaxed/simple;
	bh=Q0ZkySsPRgXuKb99NgsCtB5/hyfsAxgtEAsGiYMgx2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzemVt1UL3ys5Wx8JPfHHnPaS0Hs7efhsWAEeuSCiGF1Az3rg95vokRPqHG3Aiv/oiqpMabTcTsHzrkpMy1MGscOXJeiMGA23bD3Q0aEoojYwHsinK1l0lJ9YMNLbZotff+MYVenZszhqWxSajMCI1PURza7BCV/HhyjmKqyKTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZOKKNURs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZOKKNURs"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e0946f9a8eso3653642a91.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 01:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728375251; x=1728980051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WVxW3kjCUYpN9aCAR5CYmn0Sg+BnR1VvxehgUzJ1yE=;
        b=ZOKKNURsMpixLgXbsq4Y8X1+uK9eg5OOn++1d5zPqRdIqFWXz6zOicjdeLW3JDk8Uy
         I82DabiG3BrpOI790mTFxQIUsjjAeIFvBFdHQuGlTjpt4Ixf5YSAXoMYz7Yee35teB6v
         axLpxYfroVf8EPzv0b4DnoWBgRKzvWPn0bU/yAai34XqcIyVBB59C2wboep7tcs3Ezb3
         /XjnIVlPUO3p+2CVqkoa1ueDHpJnWgmFUu3JDWP2NPNMR6jYkbkT7BkECqswsLV0B0sG
         5kcSEY7y969s/fFbiMNGQOFdFlIp06YOk1DaMfFrhqDlb8jHbW+c+VGZlx+1qRjVtW4e
         UKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728375251; x=1728980051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WVxW3kjCUYpN9aCAR5CYmn0Sg+BnR1VvxehgUzJ1yE=;
        b=pJypD3FrM18X1u7hoKvcW5FX1YpHFehDDX4BxAsmGTuvgCnKBFJpT9RGfrJvDyr1WE
         +lxo5emZRDXKbaQwO2HnjDQjAOc1P9TuF9wvmczfCGNCBX+Pr09W5dbqPsFOuCkpGAgo
         vGpYxnr7fK5unWwNrRD/W6aCoeLVSG3VNqMhRuo98lzHZbTg9uqQU0dKBMtSdMnXkqor
         Zd+Ob1El0aVv+5ETXAlhgoxcBHj9NhcUrB6T+REoll9xfAYUssoRhcwlTK4w+Nwj3UQj
         5CAEoviR5cOYR3uw6fgec9Mmc89H2g4soT4T1q0Eif402WYP83ZBOjdPHk3ntZdleONX
         2PDg==
X-Gm-Message-State: AOJu0Yzu04QQnTjfft/cZEUHEPq4unTqQLl/kos+Exlq3re21/NUL0sz
	Pvms5xwPdEJx59q3WvifHKLAQKWPZgMCQq5vYC0Q4+h3SwG51uuhUGswqCYJoOqDyIN5D6KmhWd
	K
X-Google-Smtp-Source: AGHT+IH+zw+8nboMV/aYOrvEq5lQDHXyJobwoN99AEsUNiX98Z1Zw8rrFjvRTNCA2LjCCLoq4uHrVQ==
X-Received: by 2002:a17:90b:370f:b0:2cc:ef14:89e3 with SMTP id 98e67ed59e1d1-2e1e622226emr16255975a91.15.1728375251022;
        Tue, 08 Oct 2024 01:14:11 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83ca28fsm8739647a91.7.2024.10.08.01.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:14:10 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v2 3/3] partial-clone: update doc
Date: Tue,  8 Oct 2024 16:13:50 +0800
Message-ID: <20241008081350.8950-4-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241008081350.8950-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20241008081350.8950-1-hanyang.tony@bytedance.com>
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
2.46.0

