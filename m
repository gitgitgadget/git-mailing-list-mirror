Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00F39A813
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582221; cv=none; b=T7Z0dM10SMKWHYXLq5iRSxNCQwMuQKeSxKrn9WtrjKlZdP5mIpCTTWTJ/uk+J+SB7sLP5jwf6lZPGohFc0YT91B/Ehx6Lx/WfQl3xsx736pB8ALpCv8NmwbzxGB+k49xhYf2dMcFSbEyXabtB5Cv4wqrHYujKJuL+oBT3qk7BN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582221; c=relaxed/simple;
	bh=noodlQ9usJldUwgMDYZSK9Lu3ezuUiJ83b7HFrM9D4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0Z/6WKw8xCfAAl+gDchvMz/ZY7mu5U6hcIgFKYKmmdrj9GiLJF+EN2MP/ZRxneQoOYEytOYNzN8+hBbkucI056KchhlZlybqQACwhb+mGb9bAK9kmLrdwrO948fhr8IhRwchiL8FCpCVw9imBZszfPBvKPCX/oUg6Ga3HuwGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuOHXT/M; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuOHXT/M"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so1246789f8f.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 08:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768582217; x=1769187017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5PxYlYLy1nOxAfjUxCRCwO6n18GXO2NJyS+HkyJtZ4=;
        b=AuOHXT/MhPpo3s2YUKKyOQs+bbRChHHh0hRLRQcqpF+PHfaADqbo57KucP+PApSTD+
         TmAdScmx8tTi6FNTixdsPJj0CQZEdZP5t6LMy1Z+y+tSV+Py6CH5tBLs38IU5Ewb7SER
         2ikSDkJRIX4sxd7kf35Vij+7E9GyaIXKBPdb9sM5kYPEIWT1OgSIDB6TICBXbIOTO34x
         LJnzY447B+oFIfUlWI1MTQ8IJ/591GNoMijDmlWBXVUy09oSEiZ1yRGDPeSasoUXxwl/
         GSgY+R7iGQPWcH+vROlUNpObgMMdbnqh6jScVCcA3X1rnKS1A/+8FTWTwDL+fIu2fJOT
         mnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768582217; x=1769187017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n5PxYlYLy1nOxAfjUxCRCwO6n18GXO2NJyS+HkyJtZ4=;
        b=QPM3cwbr4ReIlKAveYhkJvRaIi08ObLqJB8jjXzYDay/pLKk/uxKGVIIXRn3ClWDiC
         LJWnbcf3YAO+ypwlKhSzurmap0XoZkJJ8pdpQA5KfFx+62fJFE3fkP/CwFPatpFYihKk
         mwSvZ800UIM7fjWYGtVoa5AqJhLw7rIUbKE6Mpymv4N6rLk8O48kTpXyB5CNCruymL5/
         hHKyHmNC7I3OEtkU6LkPJziOdP1AF3CDES0+rAViVq61mUnTdoeXFlhuxDLQIdqMbPEm
         j/1J2QaYKkowD2/KVmTzf8FToweoC0BNnlShnxhaTCfo2aVrExtwNCm+LlHF3eDfQNVC
         nrOg==
X-Gm-Message-State: AOJu0YzMl8FEehpiUteNF4greAbLnZS2qdVgrhC+4xJJZ3paLvv/rAy/
	TH4p+cCQbPyNAVkxLY/f1CofBIY6JSR/co0KEehpK+398I9sb+ZnaA33
X-Gm-Gg: AY/fxX7HkfwB0xVzl1sOnj98OC12ORUr2HODJAutdzvz2CgQZk8kVsCJz/QeVp3i3ts
	85gdzslbdya5Gja7etsCmzIpYW+fot6vfz5JtlZ6R4CcD96nrWFwKvqxlW7F2BeS0Q5n4E8OluQ
	jh7e+96xmQfAyqxgWXPvN9t856ZNoM3A6Pc06ruSMmMNMFhSUdhWzFDYAYThvd8M4DmDVq6lCiE
	V1yhiw52fEdt6Kunpc3PobC1na8G5P99xGz86deDSC3CmXDKTd5SXJSDwcKEYPdJU0gX8wW9fbw
	pIuTZEpM+ZEKE29wcbVREtcMYMWYmulQARP25MOUxB7l7QMpG+sBXvmlZG37zy5tpVAB1E05bsd
	fhJfca+aJGJA8jGpdyqFmGjXgk6u/bZbHSjfYs7k9K7EYxQOG7sKKYjwk7XrTolAx4jREl9SZio
	oVrhFkOAuE9hs72tUS4ex7xr/K8Wt3k66zgcek1+gX0imBPOXMLPF/rMdo0NhC9Yx+GL55
X-Received: by 2002:a05:6000:430a:b0:430:fced:909 with SMTP id ffacd0b85a97d-4356a029c78mr4444341f8f.24.1768582216345;
        Fri, 16 Jan 2026 08:50:16 -0800 (PST)
Received: from localhost.localdomain ([115.98.235.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569922032sm6299816f8f.8.2026.01.16.08.50.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Jan 2026 08:50:15 -0800 (PST)
From: amisha <amishhhaaaa@gmail.com>
To: amishhhaaaa@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	stolee@gmail.com,
	newren@gmail.com,
	peff@peff.net
Subject: [PATCH] sparse-checkout: optimize string_list construction
Date: Fri, 16 Jan 2026 22:20:03 +0530
Message-ID: <20260116165003.95314-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114192803.4852-1-amishhhaaaa@gmail.com>
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amisha Chhajed <amishhhaaaa@gmail.com>

Improve O(n^2) complexity to O(n log n) while building a sorted
'string_list' by constructing it unsorted then sorting it
followed by removing duplicates.

Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
---
 builtin/sparse-checkout.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 15d51e60a8..7dfb276bf0 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -91,10 +91,11 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 
 		hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
 			/* pe->pattern starts with "/", skip it */
-			string_list_insert(&sl, pe->pattern + 1);
+			string_list_append(&sl, pe->pattern + 1);
 		}
 
 		string_list_sort(&sl);
+		string_list_remove_duplicates(&sl, 0);
 
 		for (i = 0; i < sl.nr; i++) {
 			quote_c_style(sl.items[i].string, NULL, stdout, 0);
@@ -289,7 +290,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					     pe->pattern,
 					     &parent_pattern))
-			string_list_insert(&sl, pe->pattern);
+			string_list_append(&sl, pe->pattern);
 	}
 
 	string_list_sort(&sl);
@@ -311,7 +312,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					     pe->pattern,
 					     &parent_pattern))
-			string_list_insert(&sl, pe->pattern);
+			string_list_append(&sl, pe->pattern);
 	}
 
 	strbuf_release(&parent_pattern);
-- 
2.51.0

