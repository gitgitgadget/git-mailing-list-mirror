Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121121362
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745117713; cv=none; b=DZo3IJc5iMUWLYLFwQ7u3p4FVgy7MsleeXqXChULRwJ63+XimAfP0K+XcNrMitPj/jF2o1wSsBJYQ8SH6ONgMr5uAoOHIUQBBBBOTOafMK4bbE2ziVO12jvspghy0n9GtnrUeXsZXsImqoKTnlSSu4OliaFpCmqiauixQvYfrn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745117713; c=relaxed/simple;
	bh=aNGAP+8ccfvSQ4Q9+r+lWCx9zpSkjt+SyUQyFW0TOxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIItl/tlsFxe6IGJUzSfzkl32e9yuJDLB88oTLT6DiGPyEhGAOc7/0AuSlK1aPu7ow/2pWmGvC1xo1HUikivMP1a9AGM7FdG/bBKeQ8b/GZUmAWhNnbYg/AWvYXWbBwZ7qx5Twc19NqDpbzOmnUutRWN48OJPRn6PVq9jlSz9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNXrF6qM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNXrF6qM"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c336fcdaaso32357025ad.3
        for <git@vger.kernel.org>; Sat, 19 Apr 2025 19:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745117711; x=1745722511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rr1xVIM7UwIG0JazfQD9HxhakPambzJ+lnASbRLXCTw=;
        b=fNXrF6qMZGasW1ml35JOeG7eTDXKpkHI5aMo4XGcIPGx61PK98NgGt21KG4KRhegXF
         lpN3hvBmwFILeYcmGn+YK/8AkwENO7emsg6kQyP9GsMPpB/tg120CI2qrKWlFRWBslEt
         jPb83uH2Jo2LASGrqlpZO/oeBQpuaybTImRegYkn8EpjE+VEpu5ITQNYY8cVMxRtoiov
         oeyTFFYP8ZkfL/MJUcfHH//Tp0+quf/7E2o8DB/BS6HHdMyX6h8zD1L/Mo2ecYpmJLIW
         VGHg9Xok6rJexhVC0/VEY+y74xoXyYEcGuOUghIMhEJq3kxT75tFpDWvrzAUobttMU8v
         19dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745117711; x=1745722511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rr1xVIM7UwIG0JazfQD9HxhakPambzJ+lnASbRLXCTw=;
        b=EFs+XA5XHIq0Azp8tv9YLZHX8TWxT/wkvl5htnWog/Mf2Fqt5tUlPn2G6KU0kZr9pc
         PVdJ3jh2RGKVuQuWyBvJm4g1NvHX/ngLlzGdftt4jAS3te5qT2Re7/Id5iyWXixzjnBM
         uTGLbUZ1PXohe5JMqg6BedtNQRyTfaZJ1XhsWGU8+uSEwi2BsgGS4Ay8Pa6zYiNFqEZq
         zxv+pLtS2zixk2YWtRak+f8c5TxoJLTp8pkjkYcbss4zJ/MHoGyid6dHDCTttUcfusdZ
         JC0mLk8EdTx0u+o4oHuMyN6iuKkAp1bYaZJV1HaBS/i/0xR5hqFB6kK4jHb0KK16tt1B
         Rhvg==
X-Gm-Message-State: AOJu0Yx4tCmTRNTmhp6AjhsmyGToDi7JH3yvn1rRUTcEZb/Ks/Igxv6M
	CM892AMRx2yWctaT1fvsFYN10umtpiGceKTRu+4KiNnwYVsdg2KXtjduqDlP
X-Gm-Gg: ASbGncsrq2+wJvi+XY7FasBjdMYBo7E61zP5fdgv7Y1Dg28EHtDB2xKuXjjmQzYl+xd
	3JyhNBzT7s907mJBlEohJ5EIHTywevws4iLz7VVvZh3NBZiagXCS3bfcljAnmIjPlqlGTDh2Hb3
	/bqw88A/nTxmFbDZTXPGeloX90v9aN3pWioxFRR2judlifbJYrMsZlQ17Cdwh/Qs5XbhNjOwMF/
	aS0P6m/C/borc5izY0ZwXxHrYwDzS8xIdXiyNq9jvH8DD5kad0yxtZituIWzLf4aNoXSBkhLECM
	xh1sdtwopREKJlcT3Bgbz2vBXuaTdVd/J0nNRBhy0OfoYzZku0QrrQ4cLfRym54yYQ==
X-Google-Smtp-Source: AGHT+IEJMLI9LE6/h6C5cv+s0XF3N57FdBnAlVpkPoRumfREy3tjXNRZjyEyp7sdLdmES4dou5tnTQ==
X-Received: by 2002:a17:902:f607:b0:224:11fc:40c0 with SMTP id d9443c01a7336-22c53572eadmr117842535ad.11.1745117711019;
        Sat, 19 Apr 2025 19:55:11 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ecf362sm40568605ad.164.2025.04.19.19.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 19:55:10 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] builtin/add: remove unnecessary if statement
Date: Sun, 20 Apr 2025 08:24:32 +0530
Message-ID: <20250420025501.183290-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250420025501.183290-1-usmanakinyemi202@gmail.com>
References: <20250420025501.183290-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we already teach the `repo_config()` in "f29f1990b5
(config: teach repo_config to allow `repo` to be NULL, 2025-03-08)"
to allow `repo` to be NULL, no need to check if `repo` is NULL
before calling `repo_config()`.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/add.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 78dfb26577..747511b68b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -386,8 +386,7 @@ int cmd_add(int argc,
 	char *ps_matched = NULL;
 	struct lock_file lock_file = LOCK_INIT;
 
-	if (repo)
-		repo_config(repo, add_config, NULL);
+	repo_config(repo, add_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
-- 
2.49.0

