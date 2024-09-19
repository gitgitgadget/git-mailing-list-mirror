Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FFB14A09A
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 23:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726789692; cv=none; b=AVuBooEMDEbVA88pSdrnmqCf2/Q1FPPGC+ju8lktvrgqfq8/bmvBmDl/dirmbx0WXfYhrFSuCjAjnUXo0+AKW+h87wLk/AeUQKoCEw3F0TOsUhF7SH/nGufmqJ1yJ//wPvQl1hZmW+FtlQreRfnEG2FliPLTaBlfkJ3iqz+zytE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726789692; c=relaxed/simple;
	bh=hXuFNuB771EpvrovdcJIHjwiRhUdaJsC2cWGHZyP0IA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K7fc3b4RtXKCYftjujEzrSicM8fY+oAEXIoWnFx8JlCV41gR/jwtDUTUbpwcDdqHky15GcngqS19KCLEGxl0kwknQB3lOIQ9K4IpZzdhWFdRI60MYTmpmUG6SqYauQbavI1KPfVXCTNUK50mVRdJg5i1j3YPElKpLpT6S7UpdGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0tfGkAL; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0tfGkAL"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7db6dbaca2cso1736909a12.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 16:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726789691; x=1727394491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wfPDgKzGO7nQW/V73yiOorGkHtzyTnJ2NqmA6lAcUvY=;
        b=J0tfGkAL4hT3T/VGeLDIX9eCfWSQjpifYUzNNI8/q3rVTNiOmB/iavblMdb0Kf/fXF
         We/KkriTtgiSFCNOXLSTStZ0lWTnDbM7708Gd2j8eZ9IX9H1Hi0YWuk04TY3RywnBkhQ
         sH8naxfgRyFo29J6U07+sQabMMPz1p7VUxqTybpx4IEpUQeG3IGEcPJqhAwdXghpmkZc
         cO+kPOSAjrVv8H8d7YLr1WviRCHGY0XMVZsrXTAaZ1Ipmr9dEmHiYDTCRS7B04vAfkUT
         k6/Q8gp9yu1P9d4eHcpP9cUVuEPzBt4TwTaVdx+1gsnU7GDxThl8xJ1xFFFPMCF711PM
         AeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726789691; x=1727394491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfPDgKzGO7nQW/V73yiOorGkHtzyTnJ2NqmA6lAcUvY=;
        b=gc5GzAw+K80wMQvX7fcSVDD2TpOyI9RTSVY9PSst1/SNGSCz3tH0gDmuZqG/o1BSvn
         h32zHRZdAlvM58mC+jMPjspWEuuJS/azlEMjGNXVJQtgMDEVw8QAZDA2jfJ8cVrF5iM/
         w2kaCt3aJyAYtwyR6zkWT0bcOvtOZ02ivqkbKl48yhKrlwE1BISJ/HhRmW5Dh+5vP4Kx
         BnFOTnjqk3PW2kUVHYnTU5LK2Ek2rM1EdN10XlcorNPROrHhUD148+yvpsdbppDHAHkK
         cVWLoqrDB7ZDMfjJSRqUet/f+N4HIsURo3KRf2cgP2W4oqcpRFbybrTONDh3SoaTOoLw
         ogNA==
X-Gm-Message-State: AOJu0YxYXbhwKYwtUypqqISiQWY7WRmAcTsBj0Qsb22a2R23LMH2S8we
	iCoIP5IWoxJp17NkjzJdMThDjc7M9Wv+GT5OSRZ5k/43nMNBTJJk1eYX+tuuFAM3fIizwDT8mRZ
	KJTw8J1ceo57gndzr/HNQW6/V+h2cIWj7I0whjCdqgl7MwFjDG7COK27y4baxHSJvuGrbouqvWB
	6QUjKboyTqjwNvtdGBT0cL1ijmAVHZv4Wz9cgqZ7oBLwS/
X-Google-Smtp-Source: AGHT+IGPsjmKBvw6S3Yyj+lKv2fcTGOTPeH0H5PE0f1F9+XmvqNvrOSPVecIOPFlKcMVbWDVdNQL+OatmMm00zQ=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a02:e89:b0:7d8:449f:134c with SMTP
 id 41be03b00d2f7-7dd400a833fmr362a12.6.1726789690111; Thu, 19 Sep 2024
 16:48:10 -0700 (PDT)
Date: Thu, 19 Sep 2024 23:47:40 +0000
In-Reply-To: <20240802073143.56731-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240919234741.1317946-2-calvinwan@google.com>
Subject: [PATCH 1/2] packfile: split promisor objects oidset into two
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>, jonathantanmy@google.com, 
	sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"

From: Han Young <hanyang.tony@bytedance.com>

split promisor objects oidset into two, one is objects in promisor packfile,
and other set is objects referenced in promisor packfile. This enable us to
check if an object is in promisor packfile.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 packfile.c | 24 +++++++++++++++---------
 packfile.h |  7 ++++++-
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/packfile.c b/packfile.c
index cf12a539ea..3ff191b2e7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2234,12 +2234,17 @@ int for_each_packed_object(each_packed_object_fn cb, void *data,
 	return r ? r : pack_errors;
 }
 
+struct promisor_objects {
+	struct oidset promisor_pack_objects;
+	struct oidset promisor_pack_referenced_objects;
+};
+
 static int add_promisor_object(const struct object_id *oid,
 			       struct packed_git *pack UNUSED,
 			       uint32_t pos UNUSED,
 			       void *set_)
 {
-	struct oidset *set = set_;
+	struct promisor_objects *set = set_;
 	struct object *obj;
 	int we_parsed_object;
 
@@ -2254,7 +2259,7 @@ static int add_promisor_object(const struct object_id *oid,
 	if (!obj)
 		return 1;
 
-	oidset_insert(set, oid);
+	oidset_insert(&set->promisor_pack_objects, oid);
 
 	/*
 	 * If this is a tree, commit, or tag, the objects it refers
@@ -2272,26 +2277,26 @@ static int add_promisor_object(const struct object_id *oid,
 			 */
 			return 0;
 		while (tree_entry_gently(&desc, &entry))
-			oidset_insert(set, &entry.oid);
+			oidset_insert(&set->promisor_pack_referenced_objects, &entry.oid);
 		if (we_parsed_object)
 			free_tree_buffer(tree);
 	} else if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
 
-		oidset_insert(set, get_commit_tree_oid(commit));
+		oidset_insert(&set->promisor_pack_referenced_objects, get_commit_tree_oid(commit));
 		for (; parents; parents = parents->next)
-			oidset_insert(set, &parents->item->object.oid);
+			oidset_insert(&set->promisor_pack_referenced_objects, &parents->item->object.oid);
 	} else if (obj->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) obj;
-		oidset_insert(set, get_tagged_oid(tag));
+		oidset_insert(&set->promisor_pack_referenced_objects, get_tagged_oid(tag));
 	}
 	return 0;
 }
 
-int is_promisor_object(const struct object_id *oid)
+int is_in_promisor_pack(const struct object_id *oid, int referenced)
 {
-	static struct oidset promisor_objects;
+	static struct promisor_objects promisor_objects;
 	static int promisor_objects_prepared;
 
 	if (!promisor_objects_prepared) {
@@ -2303,5 +2308,6 @@ int is_promisor_object(const struct object_id *oid)
 		}
 		promisor_objects_prepared = 1;
 	}
-	return oidset_contains(&promisor_objects, oid);
+	return oidset_contains(&promisor_objects.promisor_pack_objects, oid) ||
+		(referenced && oidset_contains(&promisor_objects.promisor_pack_referenced_objects, oid));
 }
diff --git a/packfile.h b/packfile.h
index 0f78658229..13a349e223 100644
--- a/packfile.h
+++ b/packfile.h
@@ -195,11 +195,16 @@ int has_object_kept_pack(const struct object_id *oid, unsigned flags);
 
 int has_pack_index(const unsigned char *sha1);
 
+int is_in_promisor_pack(const struct object_id *oid, int referenced);
+
 /*
  * Return 1 if an object in a promisor packfile is or refers to the given
  * object, 0 otherwise.
  */
-int is_promisor_object(const struct object_id *oid);
+static inline int is_promisor_object(const struct object_id *oid)
+{
+	return is_in_promisor_pack(oid, 1);
+}
 
 /*
  * Expose a function for fuzz testing.
-- 
2.46.0.792.g87dc391469-goog

