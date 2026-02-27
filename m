Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248137B3EF
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235793; cv=none; b=NNl1vAPGBTo8Nza1zK2V9AALFC3qHkurRrvszKdLW8STqhuTrfxuh8JX/srj3UKd6xKKr8JqolKLP9QZhSifREXWdnjFQu0sMNOk1JQuYFxH1jlu9AgJgMkmeBwIavjjYMn+dw8r2f05/2F+CcHikPxuw+gMAqyOoWKPQpzgYW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235793; c=relaxed/simple;
	bh=7TJmEU09q6o9ZCY8HIpJWc5f0fYGSHifFnqjXd3Shx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWAhZAJ5OyAwyDtiOs4mQdKiwOP+Vr4D4G+6WWdnSjPulwtlBHQguE+HL+YvHDPZTczmzR8b+TLqQ8KSCGHdj3bwuM3gk1JT2aNCkUXsy+iM54ML4b8z8WBbXou0ngTO5pShT/nDL3OWVEX0yGKU5PbJnbewvWs1vPG4gSTaAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf7LLBeV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf7LLBeV"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43988056dc3so2567053f8f.3
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 15:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772235791; x=1772840591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzULlE63LFxZBQoSsZXHWwuhbFzQmDJQhb9f4JifcSo=;
        b=Hf7LLBeVnm9MiWU80JDEOALHH9DsbbTYq8tgs8LKe/Z0YY5aQoWGdZRrBk1DqfeKND
         VfDMiDj7hVhA4Cu1hIviBZq+4RGFd+lb0kyB4YelhMLhoNLFUWxJjh8U7zEQu6XqX3q8
         PwgYDXYeaFldNJNW9f/kG3RYg1+ai3WBkxo5Vwb6rHi2IRgaM+70+4BgGpJrMlNbtcfd
         ZaqBS7z5bnFvkdsYkViAUm2sz+lju5PXPkjiWazh4ZQXL7gcOD8MscZznnTfv2ZBpClV
         huUR3CiW+bvQI4B9Olf4Pna7+X3gu2vu8UFGJghsdUdhvLFE2bAsBP/C1niNd59Lm5Mn
         S/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772235791; x=1772840591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AzULlE63LFxZBQoSsZXHWwuhbFzQmDJQhb9f4JifcSo=;
        b=Tzlrn2sYH8NQHRvyRkH+RV5p2BFqrt4w+YmXnpQDcITr8poUpMLRLF4uL2+G1IhqGE
         BndwFD7ugGy7YIuBJ381PxriSp47UqKr9qNF04imykY5DQbLvDCOiqWob3UHgVgpEWZB
         S1vqIP2Xpicpm3oONOrB+r6v7dHIPTIoz+lFxj7ELgPsNLFw0irGtMjbAylaSY1H9b4A
         yjDtMMv9wizNeW4IkjiOl3xGd5lwTxar8ySTlJwjqT8wpaEkZungZxl8vXuJqFLo0SLF
         /FHjmsaDzmcGHYT7nI5uerWHC7fXwjAEnH/lIpKPlZl8m6I7Rkhldyr4/49GuP67OWFH
         UNNg==
X-Gm-Message-State: AOJu0Yx97f3lmVmKSN5YVCcWOavOVPaD4f69QKuETDegxtykG1eQxaah
	EOjhgVFUXlKuC62TiYhpKpLG+Qthgecf8fx8YSE2ch33GT2c4AN/LKlbemLDCuhb
X-Gm-Gg: ATEYQzzjQiB7bPPgOtfmpzB0fh6+AS4o81SOgyVyH65l091dn11zRzBUsX/trTvWT+T
	0A/IR19QtKAiQj0Jx8JHuMOPzIokg+77whLU3Qac+4NYTmBekxRlo8dCNameK97LSPLp/oStVFx
	ttrDZ+bUnza69B2KF3ICFAG6WzwJMZEumaTIuGzyLqULyhchyZDi5oSK7Luh/6BmfWFud7pOcOR
	GL+PqLdU7rT1gnqbmpu62MBbXme3kMMx/UKNK0ilLN5sXLg9Y0FBdFZF1NG0T2KYuCJe91sdqK9
	r5TFnIGTg4Gx+tc9+pSzJ/JOAR123Delm+kiKWMAkRytz6h6oyQVZOQ3Zu0D+xysk4st2VAqQzu
	gin/3MdcJP0ZArMpvNAryv/TqHSLw+UVmxdVKbdpN8+JypIwqE20dIPx44O+2TaHLZkOT+wgbZx
	2d+h4wPCWhHPvATiK5fxHraL7Ovjgm2z7r/baY5+THDatoKCFG3qhHMTvLEDrKEcw=
X-Received: by 2002:a05:6000:18a3:b0:437:81b0:6650 with SMTP id ffacd0b85a97d-4399de559a4mr8587155f8f.56.1772235790631;
        Fri, 27 Feb 2026 15:43:10 -0800 (PST)
Received: from localhost.localdomain ([105.113.107.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c76b40esm9710899f8f.36.2026.02.27.15.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:43:10 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH 5/5] sequencer: use oidmap_clear_with_free() for string_entry cleanup
Date: Sat, 28 Feb 2026 00:42:13 +0100
Message-ID: <20260227234213.17633-6-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227234213.17633-1-kuforiji98@gmail.com>
References: <20260227234213.17633-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kufoiji <kuforiji98@gmail.com>

Switch cleanup of the string_entry oidmap to
oidmap_clear_with_free() and introduce a free_string_entry()
helper to properly free each allocated struct string_entry.

This aligns with the ongoing migration to use the callback-based
oidmap cleanup API.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 sequencer.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a3eb39bb25..75ef2ace4f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5654,6 +5654,12 @@ struct string_entry {
 	char string[FLEX_ARRAY];
 };
 
+static void free_string_entry(void *e)
+{
+	struct string_entry *entry = container_of(e, struct string_entry, entry);
+	free(entry);
+}
+
 struct label_state {
 	struct oidmap commit2label;
 	struct hashmap labels;
@@ -6044,8 +6050,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	oidset_clear(&interesting);
 	oidset_clear(&child_seen);
 	oidset_clear(&shown);
-	oidmap_clear(&commit2todo, 1);
-	oidmap_clear(&state.commit2label, 1);
+	oidmap_clear_with_free(&commit2todo, free_string_entry);
+	oidmap_clear_with_free(&state.commit2label, free_string_entry);
 	hashmap_clear_and_free(&state.labels, struct labels_entry, entry);
 	strbuf_release(&state.buf);
 
-- 
2.43.0

