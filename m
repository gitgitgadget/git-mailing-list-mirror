Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7772236F3
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717943; cv=none; b=jQv5HW+DbXeQMxI5BU9U43XPnw23xSV4UGyIvOEVgWYOP2dLW0ej7o+aYD5vq8JYCjj2Rv8v3aA/uTVhncoQku77i9nesfd2XF1yAZn8IjtHHR/PeeadanyY3AFjf3TvYGIGaN4hjUZ/tkstTxgYFJ0GFP/3geOhldyu3EsfoJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717943; c=relaxed/simple;
	bh=BvyfGlpELXcXsiCN7h+itl99oVtYt4g2tE8eAtzN/5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i83WnGOHRftYZHrca6oIk3F86ixLkeKxeoHQIqGRaCpKQYJKAV10vjtMnE5mKUIM5hhKpNqRFxA/xSSGFsGbnBsHx+yNmZFA6ZVSTK69IGRS1vrHRHsRNJaU4zP7SUeX2BvolsZu1lJYM2ZRyL71P7sbO1l7tjJ+QFlDIr3UxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=E030yUS1; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="E030yUS1"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7569ccf04cso3671349276.0
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 15:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750717940; x=1751322740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KmQ+ltDAtLuuSISCNITPqGnNpYyD3GCdrJkVP/mQm6Y=;
        b=E030yUS1iQZmkzqzCUnAHmuZNvfeEjZcthR1Kh6VcBfCzMl8+2fb/KOu3B4RxW6qN2
         qYeVUkGQOunZLGuvO2fi259ejja/0DnLXgv3a/d66hODhYtD8V9MkN1E6AUJjgbEVG+i
         Fc84wZN1Y/GdCo9eqBh+gKGXyXnaP4F0nZ+TwpvWK91hqU9GpsMWWCAu0ivRL2u815sd
         nEu+9bIToCio18raw6wSG32GIRD4r8LpXNRL5JSqRlh4w4XlvKz/XmSPqPVcpgcwxF3c
         iZgSua+MqdW1IZ2OSsU2TXJYbgMNVLDI8RLaNFGOimw0ay8RHBiemWyKpXD91hU+A5oT
         /mAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750717940; x=1751322740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmQ+ltDAtLuuSISCNITPqGnNpYyD3GCdrJkVP/mQm6Y=;
        b=kknSVj9aw6/v8Ffg5etUdyhcrTaN4kEuNoG+1iyzywNOT6oGO5auCq6gj9FWpMrClG
         bNt6PiczkOxHzuyNp2+KclbufhGszyIZypy1YFyuPfLzuccPID+n7Gc0xKqwJpnAwsOt
         KdhfnFqTPxJ4HFnMV/+rZ7u8Hou7PeGCilLl768iR7nR0dbKgA3gQI9jji2AObtyqwmV
         smBibQOXttWfUWoYqPrbOE5IUqnsIBQn1qie2PXv+4xPN2D5AmSgyAbajbpvliklfsZc
         h28Qv0rbldVaSB08pPNf+Gyh94k6PfKH89ihGya/sSQVfQ0/LIMNyFqbtZAAZ8+9sq+L
         154A==
X-Gm-Message-State: AOJu0YzQ80LO1/DO35wLPzzj/riKn9iia+BzS17jhu6YhKsiuSTVl+Ns
	cZx7j71kLCM9dUEo/5mmTQ/7dR8RCWmthlYxbb9+U6R/cRE0dRfgZIz3mNB6poeUJWl22q+KVrT
	YRjSt
X-Gm-Gg: ASbGnct0xmnEZMvV+TKQNkQrQcnu/zUvFdZlEp2I8kzfMbvLxFQinv1JVZXka/WT++V
	x0YtwDmfFheJIH9pckL77KEMFxUOGuozFQiQzgdz83ajhXGESDcLP9iiEvVHAhbPvKNnf3o3Puf
	CkAnFSUd7OGaYer96uxXgklbidnJPIdMK+tDRksTbFKoMoKK/AkdLR90s87fiSS2MrH2ozqFIdv
	Z3BFJ9Pt2TRZCHHD6Gl33jE9kYdQSkeXhFSR3ZGzVMOMhE+D6zFRiSgF3zn3XRYpJal3nely+a6
	phkWfw5nC/D0Q+VPj9AttjVy4L2yf7aicOjTOmgntSXMA1HOEPhc22bP8HQfpU12OGwlnEZWgLt
	pvujESipRI1mHbSNsoMMTxicBnfrnIiU+UQ==
X-Google-Smtp-Source: AGHT+IHfOVHWWR41c+6Ctvrr8sXs6LTZtdfJhRU7KgykzGlLq/O9AOEcsSqnDRdxE71toaeqwLxWoA==
X-Received: by 2002:a05:6902:230e:b0:e82:249a:7b83 with SMTP id 3f1490d57ef6-e842bc83b9emr18696207276.20.1750717939658;
        Mon, 23 Jun 2025 15:32:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e842ab0a7d9sm2690547276.24.2025.06.23.15.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 15:32:19 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:32:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 4/9] pack-objects: declare 'rev_info' for '--stdin-packs'
 earlier
Message-ID: <c9f874eb9470bf2a5d97614b89304e892c30e129.1750717921.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750717921.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1750717921.git.me@ttaylorr.com>

Once 'read_packs_list_from_stdin()' has called for_each_object_in_pack()
on each of the input packs, we do a reachability traversal to discover
names for any objects we picked up so we can generate name hash values
and hopefully get higher quality deltas as a result.

A future commit will change the purpose of this reachability traversal
to find and pack objects which are reachable from commits in the input
packs, but are packed in an unknown (not included nor excluded) pack.

Extract the code which initializes and performs the reachability
traversal to take place in the caller, not the callee, which prepares us
to share this code for the '--unpacked' case (see the function
add_unreachable_loose_objects() for more details).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 71 +++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7ce04b71dd..4258ac1792 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3793,7 +3793,7 @@ static int pack_mtime_cmp(const void *_a, const void *_b)
 		return 0;
 }
 
-static void read_packs_list_from_stdin(void)
+static void read_packs_list_from_stdin(struct rev_info *revs)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list include_packs = STRING_LIST_INIT_DUP;
@@ -3801,24 +3801,6 @@ static void read_packs_list_from_stdin(void)
 	struct string_list_item *item = NULL;
 
 	struct packed_git *p;
-	struct rev_info revs;
-
-	repo_init_revisions(the_repository, &revs, NULL);
-	/*
-	 * Use a revision walk to fill in the namehash of objects in the include
-	 * packs. To save time, we'll avoid traversing through objects that are
-	 * in excluded packs.
-	 *
-	 * That may cause us to avoid populating all of the namehash fields of
-	 * all included objects, but our goal is best-effort, since this is only
-	 * an optimization during delta selection.
-	 */
-	revs.no_kept_objects = 1;
-	revs.keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
-	revs.blob_objects = 1;
-	revs.tree_objects = 1;
-	revs.tag_objects = 1;
-	revs.ignore_missing_links = 1;
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
 		if (!buf.len)
@@ -3888,10 +3870,44 @@ static void read_packs_list_from_stdin(void)
 		struct packed_git *p = item->util;
 		for_each_object_in_pack(p,
 					add_object_entry_from_pack,
-					&revs,
+					revs,
 					FOR_EACH_OBJECT_PACK_ORDER);
 	}
 
+	strbuf_release(&buf);
+	string_list_clear(&include_packs, 0);
+	string_list_clear(&exclude_packs, 0);
+}
+
+static void add_unreachable_loose_objects(void);
+
+static void read_stdin_packs(int rev_list_unpacked)
+{
+	struct rev_info revs;
+
+	repo_init_revisions(the_repository, &revs, NULL);
+	/*
+	 * Use a revision walk to fill in the namehash of objects in the include
+	 * packs. To save time, we'll avoid traversing through objects that are
+	 * in excluded packs.
+	 *
+	 * That may cause us to avoid populating all of the namehash fields of
+	 * all included objects, but our goal is best-effort, since this is only
+	 * an optimization during delta selection.
+	 */
+	revs.no_kept_objects = 1;
+	revs.keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
+	revs.blob_objects = 1;
+	revs.tree_objects = 1;
+	revs.tag_objects = 1;
+	revs.ignore_missing_links = 1;
+
+	/* avoids adding objects in excluded packs */
+	ignore_packed_keep_in_core = 1;
+	read_packs_list_from_stdin(&revs);
+	if (rev_list_unpacked)
+		add_unreachable_loose_objects();
+
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 	traverse_commit_list(&revs,
@@ -3903,21 +3919,6 @@ static void read_packs_list_from_stdin(void)
 			   stdin_packs_found_nr);
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_hints",
 			   stdin_packs_hints_nr);
-
-	strbuf_release(&buf);
-	string_list_clear(&include_packs, 0);
-	string_list_clear(&exclude_packs, 0);
-}
-
-static void add_unreachable_loose_objects(void);
-
-static void read_stdin_packs(int rev_list_unpacked)
-{
-	/* avoids adding objects in excluded packs */
-	ignore_packed_keep_in_core = 1;
-	read_packs_list_from_stdin();
-	if (rev_list_unpacked)
-		add_unreachable_loose_objects();
 }
 
 static void add_cruft_object_entry(const struct object_id *oid, enum object_type type,
-- 
2.50.0.61.g1981e40f2d

