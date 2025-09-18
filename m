Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008F29E0F7
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174439; cv=none; b=ISXzNvz8dFARPrj6ysuGVgHT8Kokq7XY0N/JAXTTStll3rrCA+wBzRXh4wsGDqHAc17Ffv/d1Az0dMHrzuQA/rFlor3B8Chjj4tzBdYD9guId3Mm2UlD6nh9yt7gg9gUFfgP7dAQjigXkGDqVudkUeGAk51QRqCAiZqbpVk5FJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174439; c=relaxed/simple;
	bh=eZ4LgpuPGRTcTUhFhM7DeKDSMCXGaZmfgP3HQg2LRxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ll+CG7B0zM13eBnmW9RCIJjw07a6EJi3Jto6nvpJAhJecH5sPjzoV9TsXbzpzrYL65q64G3qU/ABAFrqR++EanLgZEvXv/8ut5FkZWoDsuLmhYlJp5M13psZoF5NwVlKHYI5yP8JhZBrwgtsw6oD3B43USe6PosoYw230EfCyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOUv53oh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOUv53oh"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-269639879c3so4978925ad.2
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758174437; x=1758779237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ff7nGsuJqU7Ai40kXon7NyLWGPpHvW/rCcKUhcpHjJM=;
        b=SOUv53ohf/sofynewlwaRWRaZIS7CLuYMUDen8OzArNz6jQa0DwNBp7EanQKHMzH7l
         abTrpdO9Y0Va41rXKxFn7VArd5Vdkpx5ysOuuNRe+ilEkPeQAVeOozN/Q6sza3V7HCWh
         l3h8u8zp5ioeYe6XukhakkitB3VBrPg5NT5gmHkDP9s+Gkc36Jg8OY2IYq742vqSDnA5
         HePOTchmnqh/hyGitkqD7cYpqgqot6NThL6AB8QxTELK//M0M+NaFRnjAGJhXV+s8Yub
         7kYaLovNyWw1h+FxWUQ+PCrFaW+0/5mEJ8voO6Zv4ZwiXAsYci+/qLobJ5nhNfvlHQTz
         pB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174437; x=1758779237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ff7nGsuJqU7Ai40kXon7NyLWGPpHvW/rCcKUhcpHjJM=;
        b=crafJRHkAkpwdp36mdnUAemooq1zgKkZ7gW+9UcT1FHvPeiHiC7+sYt2ptzGHq9Grx
         SxFy9ELYPlExNj9oAmIpKd5IL1gG/Jw7CXy6EIu66bVOKZxGxV5or9c71tCqPM2Z7WGA
         szuk2r5RAZAnKy08JmzEvep2JxS9rC0/6vp1Sp7MOaBSKMxWHZg4l5byGez7FZqwIds2
         k5Gr3v8O+oghk5iY8gaXGGeEPOMGnglih4V1g+DdtK5NpnvTbOQTyu2/7QCvzT9VsUkT
         /rORncV3Dv8uSHKIvK+QZz0FDI4xIr9SEyWEk61TAX910WBos6encaQy9wexcJ3jTcTg
         pYQA==
X-Gm-Message-State: AOJu0YzCLzij/tGP8aW2g/K1Zi4gFkyyShIwtySjBtoWOuFwCIuou9J+
	QxvhoyQsPAQ4S2eOK1ctLDh1gWYnZS50Q9U6urD6V6/B2QLNAzPFTK5O+nPcIw==
X-Gm-Gg: ASbGncuhwyjLz0Isb1XrNqDrQScDF+u/jJH3Ger71O90t6ImeK5tN48xeilrw2suVX0
	OOCh3tnbVx8NE5Mw9MIQldrHpURi9m62pYZ52NC65PpzG1L6K1ZY1tN6+HmpFIKf9tM2CtdE2/L
	7v2abqCB7klXRMLScSTAksljpn2q+cVl3mIfJYA+6zoBFclx321XBt0ZpheOlpH6sQgKVC+lFpV
	j25hS1hyrZSs88Ei6Nq89gD8kd+FGIKM4fzchqs1hhTr6Bquao488aMaLKA9PF/TG+OOkXB5+Qh
	C+iysZYQ3Yd7WAvchG36/jv4fN6YiGyATjlXjFazyi1VqHECoAFXMRgnlBB5P/ZjWD1ufAM/h47
	Pu/Q3ADdjHAXSfqdu28+6wNvXnbbgx/5guBZg7A==
X-Google-Smtp-Source: AGHT+IGDMwbxUEbQ9HJ3Hidxq/c4mGiR+IJScxwV4Wu110jkEW36UfFGM9FEWp2pBGMsAtq676nGPw==
X-Received: by 2002:a17:903:248:b0:267:e269:4181 with SMTP id d9443c01a7336-26811ba6088mr57744255ad.14.1758174436793;
        Wed, 17 Sep 2025 22:47:16 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802debfcsm13621535ad.86.2025.09.17.22.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:47:16 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v3 2/9] files-backend: implement 'optimize' action
Date: Thu, 18 Sep 2025 11:16:57 +0530
Message-Id: <20250918054704.544254-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918054704.544254-1-meetsoni3017@gmail.com>
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
 <20250918054704.544254-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the generic `refs_optimize()` API now in place, provide the first
implementation for the 'files' reference backend. This makes the new API
functional for existing repositories and serves as the foundation for
migrating user-facing commands to the new architecture.

The implementation simply calls the existing `files_pack_refs()`
function, as 'packing' is the method used to optimize the files-based
reference store.

Wire up the new `files_optimize()` function to the `optimize` slot in
the files backend's virtual table.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refs/files-backend.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index dfc8e9bc50..1428d3a6f1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1473,6 +1473,15 @@ static int files_pack_refs(struct ref_store *ref_store,
 	return 0;
 }
 
+static int files_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
+{
+	/*
+	 * For the "files" backend, "optimizing" is the same as "packing".
+	 * So, we just call the existing worker function for packing.
+	 */
+	return files_pack_refs(ref_store, opts);
+}
+
 /*
  * People using contrib's git-new-workdir have .git/logs/refs ->
  * /some/other/path/.git/logs/refs, and that may live on another device.
@@ -3909,6 +3918,7 @@ struct ref_storage_be refs_be_files = {
 	.transaction_abort = files_transaction_abort,
 
 	.pack_refs = files_pack_refs,
+	.optimize = files_optimize,
 	.rename_ref = files_rename_ref,
 	.copy_ref = files_copy_ref,
 
-- 
2.34.1

