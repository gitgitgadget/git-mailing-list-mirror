Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677AF10785
	for <git@vger.kernel.org>; Mon,  4 May 2026 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777853495; cv=none; b=n9FspesuiqDDCkotpVQNDmT2KXZ89RW399SJWoZZcNNYi+6dSW8utQR51z3UPhIFxEZwzaKzLJU3cu2vkLuMkcEdtoMTuAa1Kl2uHU9gUkM4eqYGY60edcb21LY3sqgeu7Jhd/foxzCJ27zCya5WiXWJ3BVpIinjpVO9Ml624UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777853495; c=relaxed/simple;
	bh=rRJX4XQzHRDGD0/UG4t1dEExRZkzGaXWvhd05cMmXKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACpDoA1fO5W1/08wOsr1GCCUwmRqwp3T5bC8tjFDpICh614kUQTbXuKjY37OFZdrtz4ZSDq7F+Wq4rgKvZBtWRq0aZUdfLFCYgYjLiGyOvo0xgqO9rMOWRQrpLIYdBAUKMz5/5nJHZ0E2vuoDYjBAeGSeHpuRzak2xUwGy6U9bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Vqd0VU0G; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Vqd0VU0G"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-794719afcd4so31235557b3.1
        for <git@vger.kernel.org>; Sun, 03 May 2026 17:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777853493; x=1778458293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9ay3lBowJfPin5qIdsaOQykRADsRhgO2fTFgY/Pg2Q=;
        b=Vqd0VU0GTmTkptvqp+U1RfuJuPDc/0sPaERi0PFGMAejCzpVvjgeX5iSDvxi7HAIdY
         2CLkvOUuyltEsI4JgOqKhCDKp31As6l1roPWCaWtf9NnH9FbZ+75o29dWBcQaeNx0ofF
         fLGPEfJIX3Br3dgf7h5kvXBXdQHOcjF/MnERJsbF/7efBKWU58CLy8dhhqRq4BN5K+Q9
         L095AzcruH+NjaR7oAlT8OSiMEgstYm9aJkcC5hp+A5a/bc6Z7NaE44mjEDBUYZjzCkM
         acJvHroxOXx2Y6Y8CObhdV/bE9SnDuND26ytiOW+++TnT1XoTNHtidT5rs/XB7DtREQU
         iUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777853493; x=1778458293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9ay3lBowJfPin5qIdsaOQykRADsRhgO2fTFgY/Pg2Q=;
        b=ojxBuTzGeqKMPm2FIw1Cp3n7PtQYX9zX4qOV9wu+IYiEyfcxHuiejU/i6TKBn0F/F4
         aDYzDBE1u2QTYahrm0sSNfmN+TWYZWCmMQdgy0+bGP0NQB1TPv61JkFv5BIEdTqk7iO3
         nWU80815oH9klX0Jhsz7Yxrl2mRfz72sPBetigp4IAEcS4WA88Copp9hmM4luo+VjTlP
         edAba7lQKOZlQA37pcAPYdhuuTZ8/pdelET/ARkggZ+DImvGlgSV5WOP+2ysIZOdh7I/
         xh+XylnAQq9DPHWpDcDKPOrXNU8IVQ178ZLAmer13qQFbnOPlMStLKMtvjtsscZKgwUt
         5COQ==
X-Gm-Message-State: AOJu0YyOD4akbAtMk8ECH+3fg3KFpg0cPTxnHyvJiE8By2GbibRH3XQl
	wbUZK20wmEgGCRDF3aeHpL/72wFh3hVXz13O/zrdJjKwQ/MH/K3YzzyMaQyKO2NtVh9Bm6ibJAo
	PAfSGhzCpdg==
X-Gm-Gg: AeBDietRKG7ffZNnN+N5uyPYE40ykr7dhuaacT7ZH7hfzh2YV83UPTuGU0FlMBJtpyX
	XZlxRxQLAeBnghTGI29EQ4Cw82pFDA6XHIu2Ex9jha3q9nwqfsupHZ+/6j0ZNIFUAm7Fhp/Qud2
	xjQBmL5SZUsRcpC80C/Z1Etj0Yqs8K/nGm6Wje5ij0FcdRIAVa0qVgINBAyPp9UQYcvKqHJUr00
	Z2hSVr4qlw4hfaSBX/anpEAoIcRNUH6bwfilgW4ZnCH7Acb7MeQTTEHAS1lqD1o57mmdnyc+p2g
	uP8X9ChCKIi72I+ONSunSF7y69PHOrWE55y6SWiMjT6W3+JhC2KrzETWTZWByoe0cD3Ns/mxvEN
	RfyDJPIWTP363lD05CXPUON9KKeLxYvUXZv2EZyVKvko+5iejCnbR+R6qX9SyDzjUnn0qPLNFIE
	2zgyrQ4zmv/kqQ/UjnICTioX7M94ZmA1tf+hXBYpvpt7n80lMBNZzXGUSxOGmxfjTKDOEnfHXN5
	fuLEI/6Z7mlWcB810RbftwnV0zP7tVBP2heGxJnVZYlHAc6rzmgMCkNKw18zmBcS3saeOSTUBMe
	BunQYIv4o360HAaBQbjlbmGkryQ=
X-Received: by 2002:a05:690c:968b:b0:7ba:f907:145c with SMTP id 00721157ae682-7bd7710328amr83353487b3.33.1777853493266;
        Sun, 03 May 2026 17:11:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686fbcdsm41910847b3.40.2026.05.03.17.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 17:11:32 -0700 (PDT)
Date: Sun, 3 May 2026 20:11:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 6/7] pack-objects: extract `record_tree_depth()` helper
Message-ID: <35b4485fa5258f63d0e0996be7760ec83e9adac6.1777853408.git.me@ttaylorr.com>
References: <cover.1777853408.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777853408.git.me@ttaylorr.com>

Prepare for a future change that needs to record tree depths from a
second call site by factoring out the delta islands-specific portion of
`show_object()` out into a helper, `record_tree_depth()`.

`record_tree_depth()` takes a tree OID along with the path that
`show_object()` received, and computes the directory depth from the
slash count in the path.

While we're in the area, make a few minor clean-ups:

 - Gate the call on `obj->type == OBJ_TREE`, as we only care to compute
   the depth for tree objects. The sole caller of `oe_tree_depth()`
   resides in `delta-islands.c::resolve_tree_islands()`, and only calls
   `oe_tree_depth()` behind `oe_type(...) == OBJ_TREE`.

 - Defer computing the depth for an object until we know it is in the
   `to_pack` list.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1a5f1afd32e..842d1fcac29 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2722,6 +2722,24 @@ static inline void oe_set_tree_depth(struct packing_data *pack,
 	pack->tree_depth[e - pack->objects] = tree_depth;
 }
 
+static void record_tree_depth(const struct object_id *oid, const char *name)
+{
+	const char *p;
+	unsigned depth;
+	struct object_entry *ent = packlist_find(&to_pack, oid);
+
+	if (!ent)
+		return;
+
+	/* the empty string is a root tree, which is depth 0 */
+	depth = *name ? 1 : 0;
+	for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
+		depth++;
+
+	if (depth > oe_tree_depth(&to_pack, ent))
+		oe_set_tree_depth(&to_pack, ent, depth);
+}
+
 /*
  * Return the size of the object without doing any delta
  * reconstruction (so non-deltas are true object sizes, but deltas
@@ -4375,20 +4393,8 @@ static void show_object(struct object *obj, const char *name,
 	add_preferred_base_object(name);
 	add_object_entry(&obj->oid, obj->type, name, 0);
 
-	if (use_delta_islands) {
-		const char *p;
-		unsigned depth;
-		struct object_entry *ent;
-
-		/* the empty string is a root tree, which is depth 0 */
-		depth = *name ? 1 : 0;
-		for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
-			depth++;
-
-		ent = packlist_find(&to_pack, &obj->oid);
-		if (ent && depth > oe_tree_depth(&to_pack, ent))
-			oe_set_tree_depth(&to_pack, ent, depth);
-	}
+	if (use_delta_islands && obj->type == OBJ_TREE)
+		record_tree_depth(&obj->oid, name);
 }
 
 static void show_object__ma_allow_any(struct object *obj, const char *name, void *data)
-- 
2.54.0.4.g6aa0d38a4ec

