Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218BE61FE9
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728876368; cv=none; b=QaXwITEhAi3slIGNe7W6xleyL4RyJxulK2jnjTRYQTd+thkHnqtw5esmF5ktaAYFIjdhgFhkh4vzt5qfaL7TQ7+GOV7vzG+8r/6iwzDQYCMHBPO/eZT+nqUjpRoLA2BZH6SAIUlGK9NiVhUELjnO01nYQJx1WW72AgnrLFUgWq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728876368; c=relaxed/simple;
	bh=Q0ZkySsPRgXuKb99NgsCtB5/hyfsAxgtEAsGiYMgx2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PieD4n/YWJw8eUa9ccLyHd5Z82LZuBMT21/ExYJCO/4k7kJBebz3YR3Rv7TqEwCeqn9bSEv+CiOFBR+z0Bwa742tGDbgbt9vFJNgkvylXUj+hfUkQc7czO3c9JDHymSmuWsVDSoak7sa/iQMornlJJQyFdNXMXARowKEg0hX16o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jI4BvUQQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jI4BvUQQ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so2554889a91.1
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 20:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728876366; x=1729481166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WVxW3kjCUYpN9aCAR5CYmn0Sg+BnR1VvxehgUzJ1yE=;
        b=jI4BvUQQAUPjCmbtP+6Rj4yh4qMO+Q0ciqvK1No2uGu6UFAeu9Lb7bOHi62OVxFDYw
         8w2vo090RMmYfAn2bzoCHCLVV1QcG9FySaCoXR3C+ihn7L8mb8T57QMK8Ml+dezwuiA/
         jRG2nbFtghlDbHErV4sTccERyX4E0DC9RZejdFL4HcwWYvCDt8v7dOgg+GA9OiwlyQ2w
         Be2TrBmURA34s96SaCL4nl2eP68ecqcY1HFSUr4aj6Pfyt57/8h0G9kcPBoNYvzNvdmx
         pRiRtIxTQFlvI6kYYSSCpQzAHNLARDZ4tdMZlBppdSHXHHD5PRkk8MZC64DiNA33PiR3
         ylZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728876366; x=1729481166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WVxW3kjCUYpN9aCAR5CYmn0Sg+BnR1VvxehgUzJ1yE=;
        b=UDeLYSZRT8aaELpO6qYRCvpIz4q11O89MYKFFMJFf9EUCU9iwhYVdduvDI1oLoCWnw
         u+4Gnz6oCKqvoOcMRqph//FsQ4T5xD286CQzpD+2+/KJLsk2q3Ip7iEZD4J71ujYUO8W
         MypAMqIWrVQXmB3EwAw0gp00g3EPzMxoFHatoYvwdVpLTnTnE8D+fUN7VeBuX4aOV1z3
         nGneMOSXxF1HYBcb8TZTfwTXFS74fQNqlpcAle5aUtCA6P4q+DCB41rTfFBAP8HsNEo3
         C5B0vGJOYhW5HusyU3+dW8Y4XDM7k8aoTxL0rOdKe5ULsC3Ri6CvNOjU2KuTc9d6SGkJ
         +2Mw==
X-Gm-Message-State: AOJu0YyVL5tdC5E2yVSp+3fwQPN2wq+iYj1Wl+Rn6vo2ebYMpg9keyL9
	LqXC88AOuQU77FB1lQwM+Xc4LzQEM/lffGrHJfAeAYWd0Dc2Ric6CBAHgOPk9nRx8zOFqHgrgJH
	q
X-Google-Smtp-Source: AGHT+IE4NI7QfluFDu3lxaqNyydV+OSptjIEu7jXHkWZMogG+V1LOYKU0ZzvolCxTRDnjFCjeJhzBQ==
X-Received: by 2002:a17:90a:8d01:b0:2c9:6abd:ca64 with SMTP id 98e67ed59e1d1-2e2f0ae762fmr15403829a91.9.1728876366102;
        Sun, 13 Oct 2024 20:26:06 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2ea9d4145sm6256480a91.18.2024.10.13.20.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 20:26:05 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v4 3/3] partial-clone: update doc
Date: Mon, 14 Oct 2024 11:25:45 +0800
Message-ID: <20241014032546.68427-4-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241014032546.68427-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20241014032546.68427-1-hanyang.tony@bytedance.com>
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

