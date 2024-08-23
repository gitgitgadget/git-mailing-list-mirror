Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0041865FF
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417051; cv=none; b=I2sW97YOK7tTVoGQMQ2lcRt9za7P2ifbn/0dxMQa6+tfsWEmLHmVS88oMBFtoB2eQb6TJ9iJSo1JJD2efuEvguDslW9DTGyWBbfQ62YPrb73aQk9MbFCBUSYOQdSCHxjmHZcWHuMa7gF5atJk2S49uQ/h1JotM2FBFukrkuZ3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417051; c=relaxed/simple;
	bh=FCzEY//xf+BuvkOHSIO2PRce52V9VJzjIAVmO9+r4/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWjApxp1M9fgpI07XP+yY6xXTIXdA0hEOdCW3pRh5ddlX6w+TAoBMBdYMxHUXVrIdve37Idg6uqJwMOy+RW2Jp1/xYQOwTAB1ohWR7aRvY8Skx2CxH3MphjM+ONew3h93gZC8tjXPwZAx47uOqR5RGI73MI3mFjFdSSZMhSKsUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fY950a1h; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fY950a1h"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70949118d26so1715850a34.0
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724417048; x=1725021848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xluoJfrGQuCVGNWsP4HfqZmlgMsgKyVuqdL9urqyK5U=;
        b=fY950a1hKg4pCte9CH2LQFXv5pwn8UGDBahlcuik0ZNqvoO4eAU6m1SEJg81Nkr6Mr
         mB6fdcECk+ZLzKHm/TdOw35pmUp+VXvjIdL7AHN6hgoAf5nna/pa9LHuZwVNMnlQGYNu
         NlK6iMO0TJpkwQzwkLuBRiZrZLB2Zo886tBXZY2uAFHi7EveOzGYIi4Fb4VTws5hC0t5
         Wl32o3CrE+Vgv2NahJkra8taSs12FdNF8a9u90KKDT3/3bsIrTFg4NdweOrDTaMF0/71
         z8MKEYp+asuqosr36ot4g1XjE4gZas/DtPQ5zF9i1zhs7ztpqs+PSAYrxZpwRVn9c8ub
         RS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724417048; x=1725021848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xluoJfrGQuCVGNWsP4HfqZmlgMsgKyVuqdL9urqyK5U=;
        b=b8LDnTFfsTEJOTngvNf5v2PLMfB4M4g10ye6TCWZyXI07LfRW4OcDR6Zw7jrslwWb8
         3Q5RbtpfUVo/C9RhXA7a+srzvZVFmtvbITIFXRG5bOltFWUiuRPcPhrs7gSgMQSWFR+U
         Q3nXHdjJY3TTipceXUbr8+QwMmgOAE4FL5zA8T3SkDXq8WLz1i7jBbd+c4jEhYI2QfJF
         fMl1XdJxFHNEdqPfV1ZBi1FRGzxD/2vlRYoF7OJ//TpkMRjBwtUaSLjbCnpSCWkvwxXy
         XNw9JugoN3WNQB6kBMaiVma+zOZyOpirYlmHzayb0zZbjFOZO/ulXBlFKzEYcP718JZW
         qVnA==
X-Gm-Message-State: AOJu0YxS2xZmmvg1hT40dgVDIFH75X/eHI8gBAmCm2xYh1ymWRJfIRf6
	C7A2N94dS5e1BVy2F3sknf/y+/3JL26a/E/XWn0IPOFGEc39c8ccnU7pnyW7WMGAZ5TeoZ8aYJi
	/
X-Google-Smtp-Source: AGHT+IFD3doH1CNCudkkoxff2HgItgP9Tkbe7Ne8KsL8SrFfxcwE9mwjNEhprXR2rM2p2CENIhiMXg==
X-Received: by 2002:a05:6808:3988:b0:3d5:64be:890c with SMTP id 5614622812f47-3de2a872691mr2493624b6e.17.1724417048125;
        Fri, 23 Aug 2024 05:44:08 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad56c5esm3068023a12.75.2024.08.23.05.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:44:07 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [WIP v2 2/4] revision: add exclude-promisor-pack-objects option
Date: Fri, 23 Aug 2024 20:43:52 +0800
Message-ID: <20240823124354.12982-3-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823124354.12982-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20240823124354.12982-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add --exclude-promisor-pack-objects option to revision walk, this option will
be used by git repack in following commits. Unlike --exclude-promisor-objects,
which exclude promisor objects, --exclude-promisor-pack-objects only excludes
objects in promisor packfile, objects referenced by objects in promisor pack
are not excluded.

---
 revision.c | 13 ++++++++++++-
 revision.h |  3 ++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 6b33bd814f..7bb03a84c2 100644
--- a/revision.c
+++ b/revision.c
@@ -2701,6 +2701,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		if (fetch_if_missing)
 			BUG("exclude_promisor_objects can only be used when fetch_if_missing is 0");
 		revs->exclude_promisor_objects = 1;
+	} else if (opt && opt->allow_exclude_promisor_objects &&
+		   !strcmp(arg, "--exclude-promisor-pack-objects")) {
+		if (fetch_if_missing)
+			BUG("exclude_promisor_pack_objects can only be used when fetch_if_missing is 0");
+		revs->exclude_promisor_pack_objects = 1;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
 		if (!opts)
@@ -3908,7 +3913,7 @@ int prepare_revision_walk(struct rev_info *revs)
 	    (revs->limited && limiting_can_increase_treesame(revs)))
 		revs->treesame.name = "treesame";
 
-	if (revs->exclude_promisor_objects) {
+	if (revs->exclude_promisor_objects || revs->exclude_promisor_pack_objects) {
 		for_each_packed_object(mark_uninteresting, revs,
 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
 	}
@@ -4275,6 +4280,12 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		if (!commit)
 			return NULL;
 
+		if (revs->exclude_promisor_objects && is_promisor_object(&commit->object.oid))
+			continue;
+
+		if (revs->exclude_promisor_pack_objects && is_in_promisor_pack(&commit->object.oid, 0))
+			continue;
+
 		if (revs->reflog_info)
 			commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 
diff --git a/revision.h b/revision.h
index 0e470d1df1..6219c35c45 100644
--- a/revision.h
+++ b/revision.h
@@ -229,7 +229,8 @@ struct rev_info {
 			do_not_die_on_missing_objects:1,
 
 			/* for internal use only */
-			exclude_promisor_objects:1;
+			exclude_promisor_objects:1,
+			exclude_promisor_pack_objects:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
-- 
2.45.2

