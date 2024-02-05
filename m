Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA6E137C44
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166186; cv=none; b=jvt6jfKQUv38ZfPNu1k+vB6RKyBEF+FIr4JRSZbqkWap6BDmni/rgU7Z3w5iod3ueK4YlWmAeJcx+oxelMEyfN9xRWsPgR2OGBPlEfqkqzxgvD7oL7t2jE/1M5xTbzCcmT5nGyxXNFXu2ZxKAEupXq1RerkQQ/0/GLz8GZixFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166186; c=relaxed/simple;
	bh=r+eMscN+u2lebYp+j5Yz65g9tIpg/pdvuUHQu5E34J8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aDV7XXgaSSPvtErIfdUIJg3r1m+LwjjpvfA4mfT1W+i2/m5uzNB+RtB2YV/p90dVfm4jEM0W/dhPnUw4Lzsj1sWSQzXzB1xdysD0JrDrFNcOcwEWIiq2dXbg+7mrLeLp2PpsPWrOOXrpE5AgrUjpne2OgQ5gd+OrU++gtRHz2Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRtpsjdx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRtpsjdx"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so1116345e9.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 12:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707166183; x=1707770983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoRbM9KNwqZFIsos/PbuK+rgr5sQlhS/jSX5Fs7fFfw=;
        b=fRtpsjdxBdFjykST81Vkm36rBS7bu/7hoFHu+T/RcBScMb6VjUmkzE/u5BlYyDmcNh
         3Pg2xQDlVVN4dXmG2zfjZQh6vpZLcuebXNSMulU28bgSXaDMRFJNhxcSPG6XPKSSuAM2
         esmNuOlTOcfuMkCssEyjbSmOATzLArut1/jU1VSXf0KK5ZN/e63yPWnDV81sDRJcYjMf
         8T/mcgrGZMF7Igk+M/jwZz94kb5Hvn4IX6rbUXVjqxVlKNC/j8LgkAINHdH/8fpHJb8c
         XAf/k21kFwHhuTgxVf1z3jeOloSEADCXPEygVoZc6T8gesMn1/y0JMtPo4EfgP+wV8+M
         F6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707166183; x=1707770983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoRbM9KNwqZFIsos/PbuK+rgr5sQlhS/jSX5Fs7fFfw=;
        b=YnoHQ0SeM4FL193xFms+EJP+BiGiPaLGmZLpEKwTvJrcA2xQQbmVv3VZq6+wNSeOAp
         iVEqd6pMne3tSVGCj/8kt4O0h823rSePWqBQCP7FAVXTbcGzHFNZhbeWbGY84TwioJew
         Q7c+62tGUduJqxA9epCfoQO4A86VgoI6pLaxNRVk0h8hWSsIrGePTGtTgYZfp0f31jR5
         Gh8jxaQwItxX4yzVkUOw9V5kwR9N8j0CDBNBGyRxjCTsyhKXzsa+6bCNEZJHQsEr5T8F
         ZklXef9ag1+dBj4ndLh6EyB4wjCw2fjxjj2KoElEgZCYCZQPE0dUqT53/V51IcxG3ipm
         aJLQ==
X-Gm-Message-State: AOJu0Ywyfld+z9QWA/kb/xZ/dlqvxphjsUJS3lo1rFFlJ5+6wOJ8fhrR
	SUfXj9BcFEgEZl1+vfzlxIJKpAGdtp1/JpRUQBKw8vJhOGYirKRL7+K3D/3l
X-Google-Smtp-Source: AGHT+IGdI77wZIKysEvhGhbP1xiSnXFIYnLOeyCX3c3A3ztEQPHi5fQL6Dn89v3eDuDiwnQWBx+UIA==
X-Received: by 2002:a5d:6d0c:0:b0:33b:295f:ddd5 with SMTP id e12-20020a5d6d0c000000b0033b295fddd5mr474663wrq.42.1707166183062;
        Mon, 05 Feb 2024 12:49:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUYjBIwbRnvZo3QBeTCkjFi7MZaCt2xFirXs70emT3JrBhBnQW5vCic2oc6cn9Yfi0aHsY1Py77FDFoL8c8VwhBk3JJK6vw0z2Hog==
Received: from mkb-desktop.bosmans (89-224-201-31.ftth.glasoperator.nl. [31.201.224.89])
        by smtp.gmail.com with ESMTPSA id be28-20020a0564021a3c00b0055ef4a779d9sm275551edb.34.2024.02.05.12.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:49:42 -0800 (PST)
From: Maarten Bosmans <mkbosmans@gmail.com>
X-Google-Original-From: Maarten Bosmans <maarten.bosmans@vortech.nl>
To: git@vger.kernel.org
Cc: Teng Long <dyroneteng@gmail.com>,
	Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: [PATCH 4/4] notes: use strbuf_attach to take ownership of the object contents
Date: Mon,  5 Feb 2024 21:49:32 +0100
Message-Id: <20240205204932.16653-5-maarten.bosmans@vortech.nl>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maarten Bosmans <mkbosmans@gmail.com>

From: Maarten Bosmans <maarten.bosmans@vortech.nl>

Avoid an extra allocation in the strbuf when pushing the string into it.

Signed-off-by: Maarten Bosmans <maarten.bosmans@vortech.nl>
---
 builtin/notes.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 0e98a820dd..71f36667f3 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -313,10 +313,8 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 	if (type != OBJ_BLOB)
 		die(_("cannot read note data from non-blob object '%s'."), arg);
 
-	strbuf_add(&msg->buf, value, len);
-	free(value);
+	strbuf_attach(&msg->buf, value, len, len + 1);
 
-	msg->buf.len = len;
 	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
 	d->messages[d->msg_nr - 1] = msg;
 	msg->stripspace = NO_STRIPSPACE;
@@ -702,12 +700,11 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		char *prev_buf = repo_read_object_file(the_repository, note, &type, &size);
 
 		if (prev_buf && size)
-			strbuf_add(&buf, prev_buf, size);
+			strbuf_attach(&buf, prev_buf, size, size + 1);
 		if (d.buf.len && prev_buf && size)
 			append_separator(&buf);
 		strbuf_insert(&d.buf, 0, buf.buf, buf.len);
 
-		free(prev_buf);
 		strbuf_release(&buf);
 	}
 
-- 
2.35.3

