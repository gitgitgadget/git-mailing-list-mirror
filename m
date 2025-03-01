Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C2182D7
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740865646; cv=none; b=lMfFDh2GfnG7JbOtL/UITpd+yCpotqSDFQo51Yv0jDkWnbLSlFNgMcPdny9tiMmdOTObacrlN3s0I7pivmiE/J0B8Lrqr2OOFH2tiUCZmBFasLZsbXOr1hzm8vVY4TIUkny7FZQN1AkLYnVk+tbkSL5Kqnn93Fp5AbGKePJ8bVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740865646; c=relaxed/simple;
	bh=Eejn5IB/egIlJ1JC5v7+XMEA5HrZPBcrBDiM3XeDwWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4jU/XrPCfqy8dvoZ5kO63GMlNVUzLh6p+43XXJLJbLEySPeuPm/03RTVdAXYjuTEvdw9UoHuxoD+07idFNJST7UoWHmIkFCgNJimnliJICRsylk3J70WQWWGnScFk6gzaQf4rshJFiO54O+NVNN/3IITXkPNY+F86Z3T5EzFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxzJeZQs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxzJeZQs"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390dd362848so2535731f8f.3
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 13:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740865643; x=1741470443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xt63xmO/T33T1hYum8T1QdTVnZZJE+sG0fQf8ZIFaD8=;
        b=TxzJeZQsQ1jcpjbRMyfHQ2u5p0uCFj2uKJFlm0C5QexutJLuCS5kISwfLpmmNC54jn
         C146KBcXv5WQAvW7xyP45XBgqgL0NShytVZLzizoJqraIZNQdRPmv7DUPwCGhA4nGbsJ
         JRaGKwZHkM5gUFaCvIOBwYQcD8lGM92k5eSz7pWNaCEKe2aZ9l1IY+s0fxufHpeFUck0
         KyGAD5By/8pzfL4/xLf0rcmOyH7wn3L5LN+Dy021WgwPTG5cRK0IYqriBz7UwbbYRvsG
         HIhuDAxArC+xitG1M86WhNhd8gF6t4JwBzK+TBlIOTL4EPPo2stqssO3rfTlXvgz8wTE
         dHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740865643; x=1741470443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xt63xmO/T33T1hYum8T1QdTVnZZJE+sG0fQf8ZIFaD8=;
        b=sIN5gCfamr6v+cY+mMmhDX7s3ae5X8nB7s1tGeI/L8bfGSnIWh7pkiBye9P+DLPKcm
         yJRE7mpGgjxf33+E0PAJ0XFZQ/Xsfksgb3yIfNXnsWePy3V05nq5DzPiQuF8wdgu24fZ
         SWExs6VzPSR772g7QnNcxQ6tj57ZDnAGolNl+8pSq0kSim00ZTphO8JjX/cq31vSJ7+v
         LJX9VGtiSRZdyKT/qvw1DqfKSvvs1ZENV0rjQc/mQn1U//EHwW45CcZBMsVYFJPtLlZ7
         sWjB17IkA0N/e6ikWlxJVaOu9pheNKqWhPlXiBb8B6TFFq/MZTmdD4iLU1RpIjnpWmp9
         UcQA==
X-Gm-Message-State: AOJu0Yxxpeq1WO0G478uKDD7sdKSC7s2tCssliSrXOwPhr02TaihPI92
	VVPj6Y8afeTn90ZFJEw12u6mv2aouh/DW5UIP1QGYKtMwd2Esm/g8YdIfIKz
X-Gm-Gg: ASbGncuMts8ZBqnjSbQyl5slQHxoesjyo9CAYSQPC10KQRutWQF6vWJAGg1x7mGa6+y
	CT4KxfK4ThZaiR5L+aE871TxPauYNb/5g+OB3uO5stHHmYb5u/15qu00GulWuZTJ1U4WuSJJuwj
	SZw6GGMk7lJ5MYBP9mixbBn6FiBzt0hGc8cGGq1HJmoaW8PMKDy3UIaHmfVszISciqA8yOanqjV
	+VmUYIK5SVe5klPggMbSp/cMCoENghHk0rPW5/Zurcsl0Rj4KC/NLtRkALMBPzWbFxZl/RNEzr3
	3jQS7GF5oGcM7804F9dnTdIQt14Wx8hnVed31giGUg80ZhhOacCp3zMPmS60F3eGjIGIFgZkhTQ
	xBZHR
X-Google-Smtp-Source: AGHT+IFeW+GNTkGqamBUNNjppjOjTRejeFB8jzfCOVbzpBSsA5c2ZVwZT0L/9BNgSZ4Xc51sC1aGuw==
X-Received: by 2002:a05:6000:4104:b0:391:5f:fa3d with SMTP id ffacd0b85a97d-391005ffe87mr741677f8f.31.1740865642738;
        Sat, 01 Mar 2025 13:47:22 -0800 (PST)
Received: from aleksbgbg.communityfibre.co.uk ([103.205.25.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a72d5sm9603474f8f.31.2025.03.01.13.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 13:47:21 -0800 (PST)
From: Aleks Todorov <aleks.todorov.1337@gmail.com>
To: git@vger.kernel.org
Cc: Aleks Todorov <aleks.todorov.1337@gmail.com>
Subject: [PATCH 1/7] builtin/blame: Accept a user-specified format
Date: Sat,  1 Mar 2025 21:45:00 +0000
Message-ID: <20250301214652.536439-2-aleks.todorov.1337@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
References: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a --format / -F option to `git-blame` which allows the user to
provide a string with placeholders which will be expanded to include
custom information in the blame output.

Signed-off-by: Aleks Todorov <aleks.todorov.1337@gmail.com>
---
 builtin/blame.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/blame.c b/builtin/blame.c
index c470654c7e..437ac8bd73 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -66,6 +66,7 @@ static int xdl_opts;
 static int abbrev = -1;
 static int no_whole_file_rename;
 static int show_progress;
+static char *format = NULL;
 static char repeated_meta_color[COLOR_MAXLEN];
 static int coloring_mode;
 static struct string_list ignore_revs_file_list = STRING_LIST_INIT_DUP;
@@ -905,6 +906,7 @@ int cmd_blame(int argc,
 		OPT_BIT('t', NULL, &output_option, N_("show raw timestamp (Default: off)"), OUTPUT_RAW_TIMESTAMP),
 		OPT_BIT('l', NULL, &output_option, N_("show long commit SHA1 (Default: off)"), OUTPUT_LONG_OBJECT_NAME),
 		OPT_BIT('s', NULL, &output_option, N_("suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
+		OPT_STRING('F', "format", &format, N_("format"), N_("print blame entries in the given <format>")),
 		OPT_BIT('e', "show-email", &output_option, N_("show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
 		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("ignore <rev> when blaming")),
-- 
2.43.0

