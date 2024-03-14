Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07969524C
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710388823; cv=none; b=hGk5EHuvCAZjRAyXF4mIXqapKVMUVRrJ0s29r2ipGrjLi1A0XTSTH8il/Qj8rmQBac+lcrN1rMYXjxIAnHTtILUwWsSEGijJhgPZwZIv5wO/rzUGrKqI/qBTswFAWFUqpK459LHv0G3eDUF8+If7vaMFEWUdTMtEUp9IOl/ffzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710388823; c=relaxed/simple;
	bh=k3se3ze+5sVAWDqVkr7a8wUAmrJDPBdJZtGG1OMkNiU=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aPD/RxL/50c8aMfFhPlsg8/4pIvRYLMkgrDXTaIMCz/HZK9s17hA0hQP3SCtVkZyRh9d5SB4O2VVwGsCxz4+5PLnocCBXmBTxuXftqEomWNjd2p2nQUcGfYXT6tsfZIetM9BQ38SPUj5DIJs/oknN6d+4IHpJi++HjjLC5yNLWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzcbwbrO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzcbwbrO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-413ef770149so2892495e9.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 21:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710388819; x=1710993619; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXOQflVjU3XVdYNuEF9TyGPhlMjOhrDrn0gd0lJ9wu8=;
        b=PzcbwbrObet3Fj6schC0YfMvxaIYlsDzG1qHknczIXLVQmNmMMncsugBJD53r3SyS5
         zCsaw4os3+P4zwVUTgbu26VAkutZbyEXOsMknTy6STiBQCdj04EFmIjOnwLoPJ21zbhs
         paeUmusXFUgZ4KPk68owk/7w7+Zol++vXUGxkRO8uvrwo4mPUH7Y2+YkMRUCW/G2aMCl
         +zWTqRrauTxXfx5RPx5AVI1vRu+cRPXP4b8jQSwnvohTrj5JMuONfhdbKR0v7gM52YGa
         PvrSieBHLrhTD6OLVzIvkMSUlkoPnDg05p/dTInQik4wxib2CMngu6xmoMKLk144IdFP
         21eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710388819; x=1710993619;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXOQflVjU3XVdYNuEF9TyGPhlMjOhrDrn0gd0lJ9wu8=;
        b=XCZaImxbaDCO1YTd7n2DIbhQskQ+DGshgwcklA5QO65JJzZTcTKlxKZoOuDM4QvgZ/
         YVk+FQtSLWd9TTTuMaelAEf2JPMRDlo4yR5Hkxbw+sFlDZh8tK9A/74QF5KHp3tDT8vj
         13omP6KU6wNqgDZFf/6n7xKsYBlDfK29n1Z72UKAAkWh689i/DLMOk7SowCafPAk9aGE
         SSpEwnms+/mEwOZqhNIG/wjcYPQVS73spM3DTJ4QCYgfj4ZCjqPOwi6GAheDfI8SavYE
         ktX7sz3YjMZjvG7mnV03F4/U+hIDoVxkNiy65t3H0a1kkbwZquscZrC/bhWLpcREbnyf
         Gp/Q==
X-Gm-Message-State: AOJu0YzwjE2BBmmz2+YSNJ7AhEsqoVb/FeK9FuBUdntS3/4r+R5dNbp/
	HJKTGmu/tqefj+dMz8BVKhSPXCBpXmVZ9oN8/EW6Qh8nQBv0Xk/B84ZuQFl4
X-Google-Smtp-Source: AGHT+IF30khTswCXbJIvbRfyxK+/1YSkbmuQPWXciHMcspXKBPNpOy3Y8YD5jrS/dJHgKL729/Lyyg==
X-Received: by 2002:a05:600c:4f01:b0:412:f81a:48c4 with SMTP id l1-20020a05600c4f0100b00412f81a48c4mr431019wmq.13.1710388819243;
        Wed, 13 Mar 2024 21:00:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c354900b00413ef6826desm1012858wmq.4.2024.03.13.21.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 21:00:18 -0700 (PDT)
Message-ID: <9c6f3f5203ae26c501a5711e2610573130bfd550.1710388817.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1693.v2.git.1710388817.gitgitgadget@gmail.com>
References: <pull.1693.git.1710260812280.gitgitgadget@gmail.com>
	<pull.1693.v2.git.1710388817.gitgitgadget@gmail.com>
From: "Jiamu Sun via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 04:00:16 +0000
Subject: [PATCH v2 1/2] bugreport.c: fix a crash in `git bugreport` with
 `--no-suffix` option
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
Cc: barroit <barroit@linux.com>,
    Jiamu Sun <barroit@linux.com>

From: Jiamu Sun <barroit@linux.com>

executing `git bugreport --no-suffix` led to a segmentation fault
due to strbuf_addftime() being called with a NULL option_suffix
variable. This occurs because negating the "--[no-]suffix" option
causes the parser to set option_suffix to NULL, which is not
handled prior to calling strbuf_addftime().

Signed-off-by: Jiamu Sun <barroit@linux.com>
---
 builtin/bugreport.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 3106e56a130..32281815b77 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -138,8 +138,11 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	strbuf_complete(&report_path, '/');
 	output_path_len = report_path.len;
 
-	strbuf_addstr(&report_path, "git-bugreport-");
-	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
+	strbuf_addstr(&report_path, "git-bugreport");
+	if (option_suffix) {
+		strbuf_addch(&report_path, '-');
+		strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
+	}
 	strbuf_addstr(&report_path, ".txt");
 
 	switch (safe_create_leading_directories(report_path.buf)) {
-- 
gitgitgadget

