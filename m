Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA116D33F
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935349; cv=none; b=bfOLddMHBjy2xcOBVHZF4N8DeH4FID4JFa1aJDD/EsrmDoRM/rD8iVpRzNdxWVQ23Res1Ap3iMqpT3V1nse7oH1yhhRFQrvbjAIVdjmifimAo534wVD6WF1pk/PnC40v9nuyVKUFu59/pMbz5N9jb6rBRBm2iQ4fsTEtY8E55Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935349; c=relaxed/simple;
	bh=buS50GJxBqC3txCyMW9cio0rAAX/4QU+Hh9maMXHxxE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NTLJafPFVHUn5Az4oHA6EE+h+O0/QCG+tOlutjLmngpxkS8uvsVlCVn5Ra21gn4p4KhTyKTqJf4LGPYYTax4Rw+MiLhHRTeY40ijYRbIVOPm7RxQpSwp/kVtLhSPE9pDessHMew25F1KKD+hSFFkc5CHzl2ArYFK2yMHskHgy9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPygyZIo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPygyZIo"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d64b27c45so175540866b.3
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935346; x=1726540146; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrInDEHn9+e1E/ZYKB/gh9cxwB913Z/rr/mttm9VHnM=;
        b=RPygyZIotEdjBqTpG3xx/5up3h+Lt9QtPW6GMUpy1oeRYjgiQyEJBubsl5OVZ13xWX
         7KaJRdFOhlBAornrY/gXyb2y1xJ09INHM96LHC0/U/6cfg/QVj/uEBmjg/Mye2XhEXWD
         9mr4KSUQTXLrXWDpx0MER2zIwKRVGgPoTKWlSiUeT561vnGJk6u7B3qXiBi/N0xAiODT
         bBS73owXzcpRRhWk0JTO5kpZ2FoOcSRlvMyWN5pA1hWGV/+HByRqf7Okqql66d/qg8Xb
         1YRaVFyA9T8eNJnHYHzoJpqHHEYXII51gZ2EKzrAoon/j2bryeexW6JmUyOBIGE+vySN
         leEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935346; x=1726540146;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrInDEHn9+e1E/ZYKB/gh9cxwB913Z/rr/mttm9VHnM=;
        b=UtNaonGvOtpTzfCRKvpwHcpeGIFbRZG2HZXJhKYikXgh3BHsCzJu+xHcpU8YHvvToF
         ZfVWcx+k2NlvyPSOkmk6V8NdGBPTsBB6OWNwnTY8UHbWBbDxpaDWjk/vBT9eBX1WfEIJ
         IND6wXH256QJ+3LcmuvksPeUCtFQuA9fbcW+4yLJD3TYrdhKR0TpdyC3FJHHuaOP9Tic
         05vXEHkes6NDv8WIS48HSriEQdeSsvJjh4aunTk9Cbr11CXi9AzcSqnfQ9jyNcVcCXOY
         4PTR4kyn078V1gjvHx9H+EcG6gU8faFiyifFeP2yeqr9Gk07rIiiUF3O00ZIU4f2cswd
         mOuA==
X-Gm-Message-State: AOJu0YwmbLcLAWlcJwWvQeBoBytKbj8lAZFDTLTUy/GlPXdjslML5GSZ
	WYtxfNx1pDOuS1uMHWezv0unIrnQRSGJNRR6EZkBaUilooUvGNv02L5IEA==
X-Google-Smtp-Source: AGHT+IFzXK+x41L0VARFeeV8p1ItgSw9KmnkLgW08E1eik9afRRvY95RNhBLhMWjEh1kW0Eck7M7Rg==
X-Received: by 2002:a17:907:5011:b0:a8a:8915:6bf7 with SMTP id a640c23a62f3a-a8a89156c92mr733095466b.51.1725935345753;
        Mon, 09 Sep 2024 19:29:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d65396sm414836066b.217.2024.09.09.19.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:04 -0700 (PDT)
Message-Id: <d67679dc1a3cf055cf9357f2a6bc9ff990cfef43.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:33 +0000
Subject: [PATCH 08/30] path-walk: allow visiting tags
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In anticipation of using the path-walk API to analyze tags or include
them in a pack-file, add the ability to walk the tags that were included
in the revision walk.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 path-walk.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 path-walk.h |  1 +
 2 files changed, 59 insertions(+)

diff --git a/path-walk.c b/path-walk.c
index d70e6840fb5..65f9856afa2 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -14,6 +14,7 @@
 #include "revision.h"
 #include "string-list.h"
 #include "strmap.h"
+#include "tag.h"
 #include "trace2.h"
 #include "tree.h"
 #include "tree-walk.h"
@@ -215,6 +216,9 @@ int walk_objects_by_path(struct path_walk_info *info)
 		.paths_to_lists = STRMAP_INIT
 	};
 
+	struct oid_array tagged_tree_list = OID_ARRAY_INIT;
+	struct oid_array tagged_blob_list = OID_ARRAY_INIT;
+
 	trace2_region_enter("path-walk", "commit-walk", info->revs->repo);
 
 	CALLOC_ARRAY(commit_list, 1);
@@ -260,6 +264,60 @@ int walk_objects_by_path(struct path_walk_info *info)
 	oid_array_clear(&commit_list->oids);
 	free(commit_list);
 
+	if (info->tags) {
+		struct oid_array tags = OID_ARRAY_INIT;
+
+		trace2_region_enter("path-walk", "tag-walk", info->revs->repo);
+
+		/*
+		 * Walk any pending objects at this point, but they should only
+		 * be tags.
+		 */
+		for (size_t i = 0; i < info->revs->pending.nr; i++) {
+			struct object_array_entry *pending = info->revs->pending.objects + i;
+			struct object *obj = pending->item;
+
+			while (obj->type == OBJ_TAG) {
+				struct tag *tag = lookup_tag(info->revs->repo,
+							     &obj->oid);
+				oid_array_append(&tags, &obj->oid);
+				obj = tag->tagged;
+			}
+
+			switch (obj->type) {
+			case OBJ_TREE:
+				oid_array_append(&tagged_tree_list, &obj->oid);
+				break;
+
+			case OBJ_BLOB:
+				oid_array_append(&tagged_blob_list, &obj->oid);
+				break;
+
+			case OBJ_COMMIT:
+				/* skip */
+				break;
+
+			default:
+				BUG("should not see any other type here");
+			}
+		}
+
+		info->path_fn("initial", &tags, OBJ_TAG, info->path_fn_data);
+
+		if (tagged_tree_list.nr)
+			info->path_fn("tagged-trees", &tagged_tree_list, OBJ_TREE,
+				      info->path_fn_data);
+		if (tagged_blob_list.nr)
+			info->path_fn("tagged-blobs", &tagged_blob_list, OBJ_BLOB,
+				      info->path_fn_data);
+
+		trace2_data_intmax("path-walk", ctx.repo, "tags", tags.nr);
+		trace2_region_leave("path-walk", "tag-walk", info->revs->repo);
+		oid_array_clear(&tags);
+		oid_array_clear(&tagged_tree_list);
+		oid_array_clear(&tagged_blob_list);
+	}
+
 	string_list_append(&ctx.path_stack, root_path);
 
 	trace2_region_enter("path-walk", "path-walk", info->revs->repo);
diff --git a/path-walk.h b/path-walk.h
index 49b982dade6..637d3b0cabb 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -39,6 +39,7 @@ struct path_walk_info {
 	int commits;
 	int trees;
 	int blobs;
+	int tags;
 
 	/**
 	 * Specify a sparse-checkout definition to match our paths to. Do not
-- 
gitgitgadget

