Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDD399010
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482586; cv=none; b=iCteSFl4nFhysPaQBglvXltiq0rJMn46dl5BppP1xN06ZvSA1ldD/VwJUDQsa//JA+67B1aMxvum/CzKzfbLeAg0gUF5qyEYs0XDQ94C0Ur2mJ61d/lDXUNBi4AmNJNSo+fj/zIYhx2Gb5tYMvFXrO/C50RNPtES9EAEnkOp6OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482586; c=relaxed/simple;
	bh=YqnR699D7UdHXYB73NXk5DdY3pa/YBoKXDyUQ6ugHY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2jbg6nZiXlDqAGgObtln/8LSoqSyZYkijktookEhlQh1RJCxLbn4XNuUXe9m7kuF2lRWMOn0SdrIzqYaCXg5CUANmllH6s3LhD1rqTkEd1B+786t21QQ8JzdxXuCstVrcPewwaMmJwNu+uB1EIG9ooXk5Ylq7l8bZAcjxkBxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDJ+L7Qw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDJ+L7Qw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0fe77d141so6684435ad.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 05:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768482585; x=1769087385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBYB5/aT2kVCc4FnVL0bxSQMpr7MaCXbVf0quttV7/U=;
        b=LDJ+L7QwBojz9a93BcZRl7sOG8zm317GHcNCFDeAz/rUX/s6BJ0Cw9wJ3Sm3hx/Yhu
         9OfSe8ZRejkqJSMBF6C0ArnROJU0ZQ7u4rZukHLDy1cxATLL0cI+WTJI/TWcxEbU9chb
         lxDkc100xX1WRg2u+1Ji43JWtSwAizkXm6b9Kw1xiJuubHS8VWSVG5T6B1wffrK5pVyn
         eZ2anDUylsjDBVUCpxsmJOvgSu/55Jdq4ltYAVz2CA4Tp/wp8b7X/cNeGdiHzR49xXEg
         Dapo1n0axaVmj/sl+E0B15PADgbchC505krTggEmOOXYZv2H5U/M+OoZsyuQ/zWsgymg
         Jj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768482585; x=1769087385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oBYB5/aT2kVCc4FnVL0bxSQMpr7MaCXbVf0quttV7/U=;
        b=pcPo6JsMrsH0hApkLJpklO5SHsxK9Z/RrzCKbW/l5w6UcMBz+YxjKVvawhiXKhju5P
         oyWMWz7K5xra8lPKAgRBhXC/y0k7eNHR6eHTQZvth6rq/3ADyhNzPhWNkaZyLkH0j3Ff
         JoX3jEf7RSECKM6Sz/dADc8T+BYnw0dop5nN67yHZHA1789WBMZW+p5pHkFcj4jUuSKq
         fcTUTY2ylQ8j1Fk0yRSvo9BjoCe0/2Ivg7UdvwvzeSSwsP43w5/VH9BS2GdrOIpZSi+C
         HK8oKTQHXNn1o6We5HpxEmCtWY4cQT6+I0itJ3t6rQF56cpafzvJ3MK6LCagzFAYn8Cu
         Iz9Q==
X-Gm-Message-State: AOJu0Yw666kJ35i/uWGCjKT6DVwk1oc1yG2kHQSJveuh1mjjYgvX7L5r
	KIELhTHLBvggMkx2ZDyGuRr7nU3XSclH+z3qz2TrySQ2uEMpjexrX0D+J5T+gzJ/
X-Gm-Gg: AY/fxX5ebForiNUvL7q1ZS8tx9RUf1tyhSa+e/uOQ6NaMCVBfBih9DDdgZYorRKfuR+
	VThEN7tXXfdpqPdsTefdm2cg2mjcX67Xpwt2W7UQvQGxBETrUSnkBf1AWiyBq1CQegEYNcxvx8n
	FQqZY60dSKNbJQEFKk0WhFsuyJ5sqZ/5j+rXFq4/YUbtuEHE1WLqdUuyj8iIlDt/K61c3QVKoDs
	tF69HfTfC0UdufCl0VzckaVzidNvO+j4V3Lswga4C18LR89duBHnj7b6aGUjhF697wvgo+8x61S
	qbQsO4x/vGU0pq8NVkiaOYteqo/aYvtquyVRfTl4pW36SCxPkcRdnkHjrht1FlLRLW0l/dCFDtT
	DYot3SOBcPlZ3R0PdFVvdwugMS6J1kw/HMi7HEoFguj3abuZVuUUiCNzy0hVuS/m4n+fjTGHyy/
	H0b3EjXdBbfLxxKuBBx0NjF2QZK3882Xrl3R269a219AUyg+T5oMUpcJf92BIY4HLE8tg=
X-Received: by 2002:a17:902:ea07:b0:29e:c2de:4ad with SMTP id d9443c01a7336-2a599dd2f39mr65256915ad.24.1768482584482;
        Thu, 15 Jan 2026 05:09:44 -0800 (PST)
Received: from localhost.localdomain ([115.98.235.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd4be5sm256118095ad.99.2026.01.15.05.09.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jan 2026 05:09:43 -0800 (PST)
From: amisha <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	stolee@gmail.com,
	newren@gmail.com,
	peff@peff.net,
	amishhhaaaa@gmail.com
Subject: [PATCH v3] sparse-checkout: optimize string_list construction
Date: Thu, 15 Jan 2026 18:39:35 +0530
Message-ID: <20260115130935.93526-1-amishhhaaaa@gmail.com>
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

Improve O(n^2) complexity to O(n log n) while building a sorted 'string_list'
by constructing it unsorted and sorting it afterwards.

Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
---
 builtin/sparse-checkout.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 15d51e60a8..edabe7cbd9 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -91,7 +91,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 
 		hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
 			/* pe->pattern starts with "/", skip it */
-			string_list_insert(&sl, pe->pattern + 1);
+			string_list_append(&sl, pe->pattern + 1);
 		}
 
 		string_list_sort(&sl);
@@ -289,11 +289,10 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					     pe->pattern,
 					     &parent_pattern))
-			string_list_insert(&sl, pe->pattern);
+			string_list_append(&sl, pe->pattern);
 	}
 
 	string_list_sort(&sl);
-	string_list_remove_duplicates(&sl, 0);
 
 	fprintf(fp, "/*\n!/*/\n");
 
@@ -311,13 +310,12 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					     pe->pattern,
 					     &parent_pattern))
-			string_list_insert(&sl, pe->pattern);
+			string_list_append(&sl, pe->pattern);
 	}
 
 	strbuf_release(&parent_pattern);
 
 	string_list_sort(&sl);
-	string_list_remove_duplicates(&sl, 0);
 
 	for (i = 0; i < sl.nr; i++) {
 		char *pattern = escaped_pattern(sl.items[i].string);
-- 
2.51.0

