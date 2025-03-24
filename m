Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D435F4964E
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829777; cv=none; b=YZ/MQlL4UiWVMN0j1oBiQc7CHlXx39Q4NHgkzS+FWfhJ0MNtCKwnVC1LfEwypmqKOfVsrtq1m28bdqj/Ni+PHjnkreBZLZ2/2HMBtUupAk7prJsqhuwI7gXT7iYnpCAJmWIEN42VvYMkku8PP5bwoTJ15GwVU7dZyUBzqYKZOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829777; c=relaxed/simple;
	bh=v8LZnescrDVzeeUCNdIfN6UlcKTQw08afA/JLUOT9P4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sx5SCAF0nuYN0prqIN1A/7XYkkIopw20GESLlsyWqjU+70hwqBLGylFdRjJItNK1q+pxs2kG7b4LHnszUdmscFt73LX3ulSGx7fZsnO76oM6mygWI1DTAix59rbhD139SIB4oydo3abKE3c2E6VA6v9/+aEcf784YBuqon40p+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMwdwRrx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMwdwRrx"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso49788275e9.3
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829774; x=1743434574; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLF1r7PAEn3B8+tXJt7njpgeq2h9wMxAx9WDzs4XelM=;
        b=iMwdwRrxQ5FJ1UG854dofzbHhnxXcmU2ZIRZHy5aEP0xcLrGEaypEobrK7ugUvXbai
         GseiI9AlwT0AM34NeZwgB9LzQxewCWl3JlYAEUHVfzvM36jL3fFMxiRDwcsmfAQCwcWn
         5GxNNtC7U7oTe6NlzsIWxS2MdnOsWsb68y+v3ZkkpwzDYL4rA+cjHwyIMQUYe7T7ctQG
         IvAYuKxPBmYE34rf2vPaoZVUv8nKlj54Dg+o5AhCALqdWcviwq3/Xj/uNsWFgiqxBXwb
         mrzGKZrkZFY2Eh8swB7yMdwy/T9FNEh0U9pMA+czVO9mnjPTje0ZY9WdOJgM4U1TxmXD
         bZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829774; x=1743434574;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLF1r7PAEn3B8+tXJt7njpgeq2h9wMxAx9WDzs4XelM=;
        b=q+qt/nsqnkf68euB1tJDhv+VbtVDavjUO56S0bN3BWESpfqZzNYIxEspnWZ6LQL768
         slRZXA+QYkimUACo0aNKDdG/ND/rNnM0nmYqVqfm4MkAwVpAlR2lU3ACNCC0AgXT0s9d
         babe0BLGXijHq7QZlcY36EpjNWXxNMkSo6F//MZiIQyBHK0EhTRIoe5zCkas65mB3va9
         r5iNj0B15zsv4U3jVLa2/HJGf68FWFQutZhtg8NkheJgzLc3djswbDvk0+Mk2sdNX257
         RucMZZf4KtqcSHUXmaCbLWcVgRMqg33UKso6fdOrrVlNjdrY++NHLE3uks2CPCb7Y73e
         l4pA==
X-Gm-Message-State: AOJu0YxFcWsn2wIs6ftzORoFOPYqCW5MfU8LiZat6qDAyNpXDXadkuVb
	0ymjqk3lFEHOqDjVz66dNk/CRSu7TI4pu1rBhWmeAeBSs6V3ZAkwxwaiQQ==
X-Gm-Gg: ASbGncvyhQUYqUYl5t3VcRR9n/qAEvs3sJg+uk67dbQZX2nuDMmRNU651B/krR2FXL5
	O29lnTYlpAMBBDUnF9JSV6SVnv2uFXUuHGI4swqoRIplOUolTHGa/rdLDis+Z2VnHV23qfydi5u
	iMSPelvf1cbi7j0knzEJSOyTDWQkEcjvrt9lVsuXk5WK4/wXBfOmkjstM9jhbQqSxJ0T/+AFnqr
	eZ1A7eQZt2XtyC/4BjdRJhRuKS9ktY8F7LBW9l/+8qEBeuurEqhsTbHrHqKmD84IUiuS4DJK+be
	lSBzJWIPcGU2weifAr06NDmdhx/eATJw7spk/I/1sRICtA==
X-Google-Smtp-Source: AGHT+IELtlp/nYQopXVc1NEUlMC5XFNdD5XXXoOGYZnebLkblDnEkXOuaSikX4SbZaTFjQnLVUJacg==
X-Received: by 2002:a05:600c:510d:b0:439:a139:7a19 with SMTP id 5b1f17b1804b1-43d50a1d901mr104373225e9.23.1742829773377;
        Mon, 24 Mar 2025 08:22:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceb780sm126588525e9.4.2025.03.24.08.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:22:53 -0700 (PDT)
Message-Id: <57c1cc20de0c80b84ad11a6546763826fe4b1a09.1742829770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
	<pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 15:22:37 +0000
Subject: [PATCH v2 01/13] pack-objects: extract should_attempt_deltas()
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This will be helpful in a future change, which will reuse this logic.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 56 ++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 58a9b161262..7805429f5d1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3196,6 +3196,36 @@ static int add_ref_tag(const char *tag UNUSED, const char *referent UNUSED, cons
 	return 0;
 }
 
+static int should_attempt_deltas(struct object_entry *entry)
+{
+	if (DELTA(entry))
+		/* This happens if we decided to reuse existing
+		 * delta from a pack. "reuse_delta &&" is implied.
+		 */
+		return 0;
+
+	if (!entry->type_valid ||
+	    oe_size_less_than(&to_pack, entry, 50))
+		return 0;
+
+	if (entry->no_try_delta)
+		return 0;
+
+	if (!entry->preferred_base) {
+		if (oe_type(entry) < 0)
+			die(_("unable to get type of object %s"),
+				oid_to_hex(&entry->idx.oid));
+	} else if (oe_type(entry) < 0) {
+		/*
+		 * This object is not found, but we
+		 * don't have to include it anyway.
+		 */
+		return 0;
+	}
+
+	return 1;
+}
+
 static void prepare_pack(int window, int depth)
 {
 	struct object_entry **delta_list;
@@ -3226,33 +3256,11 @@ static void prepare_pack(int window, int depth)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = to_pack.objects + i;
 
-		if (DELTA(entry))
-			/* This happens if we decided to reuse existing
-			 * delta from a pack.  "reuse_delta &&" is implied.
-			 */
-			continue;
-
-		if (!entry->type_valid ||
-		    oe_size_less_than(&to_pack, entry, 50))
+		if (!should_attempt_deltas(entry))
 			continue;
 
-		if (entry->no_try_delta)
-			continue;
-
-		if (!entry->preferred_base) {
+		if (!entry->preferred_base)
 			nr_deltas++;
-			if (oe_type(entry) < 0)
-				die(_("unable to get type of object %s"),
-				    oid_to_hex(&entry->idx.oid));
-		} else {
-			if (oe_type(entry) < 0) {
-				/*
-				 * This object is not found, but we
-				 * don't have to include it anyway.
-				 */
-				continue;
-			}
-		}
 
 		delta_list[n++] = entry;
 	}
-- 
gitgitgadget

