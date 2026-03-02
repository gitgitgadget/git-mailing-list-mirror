Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6F53112BD
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481680; cv=none; b=PhtIqLw45t2rUqhVwxkNiDMZT3X8+oFIIGY+w1nb7K/DxbyM8GLIX8YOlGTHZP+FPR3lq/kPDa3pcsihTiEIM7XdT0DT8wM15xTh4jt/xmrA1OYF4Xq9qfb66b48VXJ8YHpJvKKet//CfFujkSUA3Kf9orYQp3cC01tv9h869NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481680; c=relaxed/simple;
	bh=mlzJEw6JEvMw7iJ2ttuiQyx/7g85Z0oxyXwRXGivzxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PICAOXUXSpgMOskfX0tODI4Pk0vSzCfE3G4nVO5dTAaHqvwFRkxTPkChLIR52CSMQvxePhKbe3NyW193Kte8QtAr/NNigDlFcw9bhDUu5ngshrVUXCuy8/UsXHfmqn7SETeFemiXIhrEsbqoLumFpCTOai1HCtoDY18kyPi5HnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzeWTc9l; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzeWTc9l"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso44167675e9.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 12:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772481677; x=1773086477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wI5EGYyWEW1cyUezTJTLtE683buKJEjDOwsfAOa4zMo=;
        b=EzeWTc9lI690I6CyB5UQz3TtT4AvVJmI/ChHRX+YdOGZNkQNxhmG1BqeIGVcFuUBVX
         8uFnfbRnGlR4/hNFRQuP0J5OY4UEBCm+pQKBeKU01kv8JuRpRPnguE6MxhNwPCQjwrsN
         yY44siufJJMfsbNYYC2ZdOcBYnNdwepQG/3EBej1VXx75Es6cdofUQMtVApjW1EU1yh4
         T90x1G6n/xCaVdeydKKF4pULZzhNOUgEiwCKLysjj8VsDjkUPOHFZlcCsPc1LhkxKEth
         AbqXq/gWfRSHELLAoRAE0qAeVNQqV3eLX6RVbvxylJK2jXS3YqU1bt0VupKO15LD/mWh
         cMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481677; x=1773086477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wI5EGYyWEW1cyUezTJTLtE683buKJEjDOwsfAOa4zMo=;
        b=Ta+Gl7ZE7Q/SBpfCXnOz5L+kA9CegmLANs3rrzeR4tx2IWwyM8LrLQ1IwPG72Rj4aN
         8PuJmZWAj0gYxo9RMjB5LH6pNOQxatY1+kHWjl8OvPKd6aF/FBTrYIDNpcvstn7GW1wY
         bWckKE+dIKqnuqvWbUYFt4nPzLh+DpYjezoZLa6xgm/E5J73UC51kCYrk+l8443isWmi
         MeuQdqAVwkuGftmRYqjy8Dz4fz4PhxXHyCwg7CNig6Li8GGWynot57bDJGmtjac6ZPGj
         rBsIDiA5J56LNl1UbOQKAc3FN+P7IjmM/blC+wbRXt1dAcGljAIROhjfn34K/CQmTH1n
         52gA==
X-Gm-Message-State: AOJu0Yyr3XkniVjF5iWnPKrHVrwB121AGqLGMwMfe02+EFADkTaCCPWW
	IdQNcKvBuRI7OhSNLWzMDKr7R4AIHpP4jkRQ7GFrlu97no5xuW4ihFbuEayuCg7m
X-Gm-Gg: ATEYQzwrF+KcsI2SayX8DIzJmk5fiDvYmKmOcx0cJ3WzUgl1I0DGT4tOIPmt4s+l2RG
	pa9OXgGwlTtLO6WOWkJ28RFXf4c2nRVVD0AEprY8YOqgvN/uXtdfrebBek3+rTFV0PSUfJKNkbN
	QYGhUWr9qdzTvxHiLTQfhqTx1PMf3+k0kQUoF1O/iGSNuMx94Uv9tlwRh3Yq4pcSQoFMd6d4hTU
	STCHrE/NCVL9PszEKFw0j9GmsuZTiHpLYrGB9DbZ4sUPRdThwOH0NeMB2w7a6kJC/vEGWNvBOJL
	JBEYI3x4NEsQp94NfI+ooBthCNC+KclA6293Xl/xbjzAV9C0klH4XoOAM0lVmOeckHsTxTqveK9
	fS7f+GXp2iQFe7mVdAP6TKhsyoh+j9pmhYEhDBR7vaBVgywTiomSqwECctItYvmMT6u6cE7IYFo
	HcmPOS3fbwh4gQZWGqV++N8SnH93GVQPi+LUUr/qGRZ4jfP5Y0S2suJ8yqIaW/E+8cL1abpHY=
X-Received: by 2002:a05:600c:4444:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-483c9c323d8mr211513765e9.34.1772481677199;
        Mon, 02 Mar 2026 12:01:17 -0800 (PST)
Received: from localhost.localdomain ([105.113.67.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485126547absm446875e9.7.2026.03.02.12.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 12:01:16 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH v2 3/5] list-objects-filter: use oidmap_clear_with_free() for cleanup
Date: Mon,  2 Mar 2026 21:00:15 +0100
Message-ID: <20260302200018.75731-4-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302200018.75731-1-kuforiji98@gmail.com>
References: <20260227234213.17633-1-kuforiji98@gmail.com>
 <20260302200018.75731-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kufoiji <kuforiji98@gmail.com>

Replace the use of oidmap_clear(&seen_at_depth, 1) in
filter_trees_free() with oidmap_clear_with_free().

The seen_at_depth map stores heap-allocated struct
seen_map_entry objects. Previously, passing 1 relied on
oidmap_clear() internally calling free() on each entry.

Convert this to the explicit oidmap_clear_with_free() API
and provide a typed free_seen_map_entry() helper to free
each container entry.

This makes the ownership and cleanup policy explicit and
removes reliance on the legacy boolean free_entries
parameter.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 list-objects-filter.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 78316e7f90..0038bfaac5 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -143,6 +143,13 @@ struct seen_map_entry {
 	size_t depth;
 };
 
+static void free_seen_map_entry(void *e)
+{
+	struct seen_map_entry *entry =
+		container_of(e, struct seen_map_entry, base);
+	free(entry);
+}
+
 /* Returns 1 if the oid was in the omits set before it was invoked. */
 static int filter_trees_update_omits(
 	struct object *obj,
@@ -244,7 +251,7 @@ static void filter_trees_free(void *filter_data) {
 	struct filter_trees_depth_data *d = filter_data;
 	if (!d)
 		return;
-	oidmap_clear(&d->seen_at_depth, 1);
+	oidmap_clear_with_free(&d->seen_at_depth, free_seen_map_entry);
 	free(d);
 }
 
-- 
2.43.0

