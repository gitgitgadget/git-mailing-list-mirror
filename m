Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D11865E6
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417048; cv=none; b=LxvqigVAvOaj+REOlMSKkl6Z2HdSTQpyyqCVsvqCDTcuY3b117E7m9qvmLURjtGDaJRhQgf6P3P5W1XUPYNRxfqa0tDtrZs0zEH69JI8Jpj0L1LCQn+Yc/ZyDuzFdyoHL5/QhMFL65DeBpn5DjjPEkw6Pky/UimXNeHA6tprcj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417048; c=relaxed/simple;
	bh=5X2gGPNSjcvh5L6n2+4Tq6OHPKuZZLW3d1bN6RRzH2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4Ab5ZRBExUyykXGYbzSKWoHkTKiznixzBjqd710glQPUOrzJXnH1GLi5tNlun/Br+CCiBUTZK6QSVd+Z/krOvXe6LEyMn+P/0MZpSA3XRTxDIduuySZP7oCL27HIMMCe/jNKNB38s7pMTGBj3n6145mIUhh6dQE25go0bCiisQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZTCrWl67; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZTCrWl67"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7093472356dso1427789a34.0
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724417045; x=1725021845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKDvxLwxBSWoHgEM9OE35/1hK70atfgbWuJ7BPwNOEU=;
        b=ZTCrWl67K6pSzFSYlXEZRK3jVOPkoCaJhGo8solhZVlvNDcWNDdWtPAxy/Jpv4XSAg
         I5T1gUvOeIvEjvFlBkIRRdfksSa1dvlSv0oiEtwDtysjK86NMkcFfpc049pKQu2anUjH
         Lz3Xcdb6ILpB+tplqtWFmPAcoTrLLVDhq1Ba6OJhkRS1ztMH00XZr05X8aaKSZVnX8Kt
         PtJ223XHHe/AYP+L5Thy392CP/8oCQJ6KYqjdyrtyAzqNa57XyqHk8FHtE6y88JkPY10
         viBIWKjvM0AvMGY+o6zVfs1J2c7cww7EL70JhPy8+NekEh+k9E1bNyWOG1cnsvXkNlq3
         iIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724417045; x=1725021845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKDvxLwxBSWoHgEM9OE35/1hK70atfgbWuJ7BPwNOEU=;
        b=WDc5Ehol0nV8dZ+/QELnjO9ThiQF0b6gUsHJl7Jlju5fZ49h62q7p/GLsYlcDW1HXy
         DJbt43pVcvA8Qbdtu1HsVLQWNEGzDymN4KkEUPRfzQtrn1VN6mgo9X2+NQ4dP1+3gvp1
         L4aob8rKrkkl40pD+49F07MpVpPvRVO3s+/b6Gx5lNub93XljBrx2VwRxW+B+6gkZtsW
         GniCUKT/CWBvCz1M5wu7LNIVZa8eW4hCUy3x0SkGsr/wJFY8yF4SFbVfpPzScibzO4s+
         /8H+QylqvILOPqvBdyweLIOIsbQMJQRcztiGMfD5bFDf7o8tB5/WHRwYn/1FNXIABFDf
         CgXA==
X-Gm-Message-State: AOJu0Yxo7MnNnqG7GEOWiXNlJASZonpwvPskCd0uJCpUsuOezk17Vqh1
	KifGpsxsl4M51MhIEpzXFcmKJ1uvA5SZWsqeLTrI255lLNG1i2rC/lmxqIyXSypSx/TSmrcUN7C
	9
X-Google-Smtp-Source: AGHT+IH/IK0gt4voxFO7nYh+Z3wdXp2/FenUKr9X3GzdO5xFLNhfr9BsaILTfTGLWP7+Bx1X2WgyHw==
X-Received: by 2002:a05:6830:661a:b0:703:61bc:e3e4 with SMTP id 46e09a7af769-70e0ec1c44dmr2357030a34.33.1724417045357;
        Fri, 23 Aug 2024 05:44:05 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad56c5esm3068023a12.75.2024.08.23.05.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:44:04 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [WIP v2 1/4] packfile: split promisor objects oidset into two
Date: Fri, 23 Aug 2024 20:43:51 +0800
Message-ID: <20240823124354.12982-2-hanyang.tony@bytedance.com>
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

split promisor objects oidset into two, one is objects in promisor packfile,
and other set is objects referenced in promisor packfile. This enable us to
check if an object is in promisor packfile.

---
 packfile.c | 25 ++++++++++++++++---------
 packfile.h |  7 ++++++-
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/packfile.c b/packfile.c
index cf12a539ea..1cf69a17be 100644
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
@@ -2303,5 +2308,7 @@ int is_promisor_object(const struct object_id *oid)
 		}
 		promisor_objects_prepared = 1;
 	}
-	return oidset_contains(&promisor_objects, oid);
+	
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
2.45.2

