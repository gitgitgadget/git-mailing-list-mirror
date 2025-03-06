Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593EB170A23
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271800; cv=none; b=la4kYUg5Qgfon2ihly7Bd8CwC9q7PrEBVxiJxCZYJ5B+/oFDM1WJ6/MpRn4eGUcELdjYHIXDeqo3ADrLKEVQtEUoyRPx2Ckr6Ipk80hRfI6ay3sQSRp7YVxDEU1z4IsaynTQkD8z6DTIKwMXAAC5WmuvfXV2perjCxn3uruIxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271800; c=relaxed/simple;
	bh=AwaaxAYt87FZHQCnDAzkqih66IySqenZOCdDZFOkilY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJ3JaA5SX8rCUI4rc0U1fq4458+939BptvdyxzJla4gFOMrWc7suEdPPrwvXgjkqJIB0UXxCfIpRDsYScpko7AySeLBZf0t+3eGi9Dji51d0V/Yv3vHQFTEa0t173B63GJ8yrrtYP1FcO2+Z5iiPoQqHW2bT2aiDGBJ5XA54XF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlYPcARs; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlYPcARs"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fce3b01efcso1118730a91.3
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741271798; x=1741876598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0AZ4mEL8WspowItpDJ1/3XlhUBa1leXLVag5E4GWpI=;
        b=ZlYPcARsyf8jby3Xbpb0QsZ265/mwhR7CKbRj1p04qQXTgaNyc7HxeKMJC7T7L4YOS
         vZhJW3rXFT6aHcahAdvk3B9bxyHNySq2zKE1ZR7lMEij5Mm5ogdw0cTfCOo7JJTOJOhj
         3bmmq6Ru4OsU2PoOr5skIBE9GFndQjgl/WtjsI/R/mTQMr+7uUypHJjuzGhml4WMRF8L
         IL+3WCT14ZaGwF7Y7Hi6ks1m3fCN+yHge3Wq9ftBr3/10NK9JETaUCbqsnO/y+BPmENY
         KZM7rp3U3fuSnsTXuShgKfgZrTm8Nn1yscoD/Fh3xnZPVOcsMQxpDV48FRXM6lutrqIb
         owlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271798; x=1741876598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0AZ4mEL8WspowItpDJ1/3XlhUBa1leXLVag5E4GWpI=;
        b=JDdJ3I0k3yxxlUHJjJHRwZ5JFrB5sTxUBtjO9r/VWoKVPPAQotPPJ4AQgbzgQZeBkH
         QlE1hqMz3IZgN30piFZdRjhECNAkTvsW8Q1JIh7G80nMLm2K3YIurGd8W4iD9z+E0dPH
         p6K3LDmkNrJPE09vB5ZoSw9hpY7L1FK03Oaxi8P0Npk5YbgtzupmlbESRGFPO1vhalhn
         gJ7EZjBmX4tKi/JjU1i/IZpfyUC0IASviCPcIB7nvlqzH7284CIf4ieQh6I3JQ/9cGtB
         pKmL4pW/EGO64Ec8AcakB0QAVQWY/cmUF84+Sr1bmao6tZ2V7FGAc6JcWUeD6F5bpDgC
         gNDg==
X-Gm-Message-State: AOJu0YyboSJq7Xo6jgz/93NpKJkw63Se4IcoyCM783SuEco/ItGITlSz
	kI7Nrydw6V82SfliMtPGQVVgjKB4fJRA23lWZUbDExAvFkyxxIs0AXU60FJb
X-Gm-Gg: ASbGncuZSSN/yAvDwUY/gZu1mg9y/GHJ8JhVc/3PZx0ZmDszpcUewd9hQgkyz1vMgGv
	mdsCEXLMzVXhgXlJWa9dck8Gvsuc8XyNi/0BNx58oWeLMG8ldVNwinCVrA3aKC4TTzRyoNnF5Wx
	QIyV8FftTpcAYKozr7XPbtA7B1Jm+4CLb6A8LD8D+NVeQPSIAuCH4cjqvZKXJiSIEgt2CBK6Nbp
	K3B10bthpdnLUN7JyOVadjTTw5ODkUygZsiGcLfT2oKXcNjxm193F/4dVy1cNiyVs0IY8fo13RM
	eDS5R5mlXvtpxF00EENlkY7D0zilNcicCERqB572VomXwiVjb8WVgu8MuhDsnG4T08E7/Q==
X-Google-Smtp-Source: AGHT+IE9+MKNQkhdO6XdXm/NEFbbloBqHEeWMrO4c3jcrpp/I+NAenzarnWHWoVlbRBsTfdSQ6oiGg==
X-Received: by 2002:a17:90b:2e42:b0:2ee:96a5:721c with SMTP id 98e67ed59e1d1-2ff497acb35mr10096547a91.21.1741271798277;
        Thu, 06 Mar 2025 06:36:38 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff944sm3561184a91.34.2025.03.06.06.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:36:37 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/8] config: teach repo_config to allow `repo` to be NULL
Date: Thu,  6 Mar 2025 20:05:45 +0530
Message-ID: <20250306143629.1267358-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
 <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `repo` value can be NULL if a builtin command is run outside
any repository. The current implementation of `repo_config()` will
fail if `repo` is NULL.

If the `repo` is NULL the `repo_config()` can ignore the repository
configuration but it should read the other configuration sources like
the system-side configuration instead of failing.

Teach the `repo_config()` to allow `repo` to be NULL by calling the
`read_very_early_config()` which read config but only enumerate system
and global settings.

This will be useful in the following commits.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 config.c | 4 ++++
 config.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/config.c b/config.c
index 36f76fafe5..c5181fd23b 100644
--- a/config.c
+++ b/config.c
@@ -2526,6 +2526,10 @@ void repo_config_clear(struct repository *repo)
 
 void repo_config(struct repository *repo, config_fn_t fn, void *data)
 {
+	if (!repo) {
+		read_very_early_config(fn, data);
+		return;
+	}
 	git_config_check_init(repo);
 	configset_iter(repo->config, fn, data);
 }
diff --git a/config.h b/config.h
index 5c730c4f89..1e5b22dfc4 100644
--- a/config.h
+++ b/config.h
@@ -219,6 +219,9 @@ void read_very_early_config(config_fn_t cb, void *data);
  * repo-specific one; by overwriting, the higher-priority repo-specific
  * value is left at the end).
  *
+ * In cases where the repository variable is NULL, repo_config() will
+ * call read_early_config().
+ *
  * Unlike git_config_from_file(), this function respects includes.
  */
 void repo_config(struct repository *r, config_fn_t fn, void *);
-- 
2.48.1

