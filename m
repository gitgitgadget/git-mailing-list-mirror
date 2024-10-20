Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199A194089
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431826; cv=none; b=EyC5Qcf1Til0uFMPeFifkXW2FYQ08dFCtdDzdMPBWw+JilMjAW1wbGhq8YaIbK4ke3e2e/8L1j+BqozeYWcSr4o45cUbofFVECDmrpDL2OMXyUpvgmsvfsnTNWwha3XBAoNN1oIWJG4x2kozc0uch6EsaO2DCanVtwHWmv0csG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431826; c=relaxed/simple;
	bh=FWW0Yk4EjQQ1LYFwR1ffznyINczb6AXTwXpT8uITqmI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pRFAfrZRlJJbN4XNW7BZ4c4PH4FA5g0cBVk1WKGvPQmEvVUuG2kmwMcQRB57DBo17BZbpwEgmWfW575v6rlxArSnXrRWIr+6K4MyewrRAOFVciRKUaNMyHW/6ncAVRExbTGxh+BeW1vHJ2WQFXbbXxrmNEUVm2zBOI5nnRsg8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+Zqkr7I; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+Zqkr7I"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99cc265e0aso513188066b.3
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431822; x=1730036622; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+vaodEh/Yx/Ff4Tz8iCfMqaXhTzdOjL/w83oLvkHm4=;
        b=C+Zqkr7Ig3VvOtS6q4TXPPgLuVfCuEfXmNzK0r47nZzFkJBf/sQfY7BjcRYs+F94yu
         ZVcpOHYB7Qnes6CNQskJTuUKhZz8YtddznFnkMoxFIwoZDvYqEaMCcwUJBucF/cPXl7f
         YfMby2Z7lJH0k2bnK9sAHjdAiwsKO0rb3RxK6tvQjcVTmukUi2QNHKhhzADTzqTyG5Bk
         sBNaZaFwdkQa0zb6XEU4FrS1RxPMryWGnYCZuIxOu8vcElmFupmUJnusD/qI+DYRnbjB
         wHCymGUqK33SNIKWkpeBaEMtuBVdLNXhtqFY6S+WJ6jYWcdbgNZsU9is+XF8clVymJ8b
         xhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431822; x=1730036622;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+vaodEh/Yx/Ff4Tz8iCfMqaXhTzdOjL/w83oLvkHm4=;
        b=TAeccPvYDYu0WvlajJ4VDLPATl9cED/tHvwvGDsYNzp6QzjtSY54ygiobNtGDkG2Jj
         UdvCpcfYFG961XrugLDZTTIuYndbEhlpeJxFcp5Xzbk5ZZqVvywMLMx9zDzR6ImFhfsv
         wsfgcp+Uh77XcuwHK4aEACxeQAfFafPkx3N0YsCl08bI5MwlJeskJIb8rcxaevK6UVmB
         Zoh2j1bJ5ESBjxqHcdqO/QX6kpFdF3JShKFDNKKZjxLLyOhEdAcWbUcEjgPSMqkOxXqx
         BHCGZBBaI/GD0BpGd3cYevWF4JexMTYOZm7ZBTquAreUxyKyPCgr4qZnGEK32x13Uj/7
         F21g==
X-Gm-Message-State: AOJu0YzR6ymiaBCmqntDKAsjpzNE54CAYAvoQXySM349HHNv7oCTQFdl
	/vT22mfmSzbHl6YH8376Y2db7NVnB5Set5BfGFwHM3mMWtf+GiULlo51yw==
X-Google-Smtp-Source: AGHT+IGYuZI+WCHM3Z5n2SfNpd6Y/JXtspZztPehD/Ghn7Ja/FTA69r+gKogJnM57XS0ctyOPBFTFQ==
X-Received: by 2002:a17:907:a4b:b0:a9a:421:720 with SMTP id a640c23a62f3a-a9a69c55b5cmr851243966b.46.1729431821843;
        Sun, 20 Oct 2024 06:43:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912ed80fsm92675066b.46.2024.10.20.06.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:41 -0700 (PDT)
Message-Id: <3fdb57edbc504fbad572f21f309b8ff6a0ce1a72.1729431810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:20 +0000
Subject: [PATCH v2 07/17] pack-objects: extract should_attempt_deltas()
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
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This will be helpful in a future change that introduces a new way to
compute deltas.

Be careful to preserve the nr_deltas counting logic in the existing
method, but take the rest of the logic wholesale.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 53 +++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fc0680b402..82f4ca04000 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3167,6 +3167,33 @@ static int add_ref_tag(const char *tag UNUSED, const char *referent UNUSED, cons
 	return 0;
 }
 
+static int should_attempt_deltas(struct object_entry *entry)
+{
+	if (DELTA(entry))
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
@@ -3197,33 +3224,11 @@ static void prepare_pack(int window, int depth)
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

