Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9338E29BDAE
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274333; cv=none; b=Zm+LYSbVqvZQIrdzisrVVxAOC2jkG2C6U6BSyanKXeXK7aWZoAEU0buIiOLzQV6ecNLomN1L5+nIER3hrTrt8iTa/2kd/uqA54Sp1mq3rHv0sA9RIwlG3Kl0xQX02v9D7IycGcpr+dYQSAr88GT1M7cGmn9AnFuLvzSiBG92km0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274333; c=relaxed/simple;
	bh=mhM/5S8oUt9F8OJttb4MDZoRi7ftHGyzLc9NEnv+39E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Lf37SzJNtERlgj9F0Wh33hAW0b2LbZwz6lOIf6VjGKBFCt1Eq7dSQEib57Q4LqVJK6c+XBb0fBFYj5EzJ2Xycc+ptpINjKLmO1321uRZYvfeoTeDnbId28DcRdkP90RAVm2S2BeU3bfNc07EP+43njFbDTkYQVm6UE4Q3Ambmyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bg4gu3F+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bg4gu3F+"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-81076e81a23so385609085a.3
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274330; x=1757879130; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/3jKXk1oUL2qvaap0jVONYmipugfqOzBJ1R2uh2KoQ=;
        b=bg4gu3F+4P3Q4lq02zoRQNAbIJEwZlIl9zIY4ZY1SZQ1nN/ntbPbKyXsVwkhnlsEyD
         Pisb4+njgaV8t/ASXu5LcQMRoRSwE7lL98K/G/SSn0E6aqVejj+3m1Plrw0bH7XDasK6
         KRiTNYqXLQnY9jmL6QJQHyj+Fse6RGsPX9EA+HkRPPcwkJ7CESQKDcr/iPFXYTk5dMIc
         5xTJlL19n3B9/PEbz4taD0fHB41AjOuOWP6BSwN1r93Jfm9bbtOSkaW5oRt06IUA4Oam
         WkMqYYD2UunKzoDOQa0ErX12vB5kRmh45xUS2kdSUxHRk4IQplpePw5HabaFNfql17WX
         jCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274330; x=1757879130;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/3jKXk1oUL2qvaap0jVONYmipugfqOzBJ1R2uh2KoQ=;
        b=rGQv7q5mGJ7g5UsdpqetsqB077sACd3K7ZOlKAO+5+rs9HYI5Pl3UpPBTV48e6qSqT
         qtwbzJC8a0MnaARpWURWrkW8L0DY4yBzhFWw1Iy1hGA8DQjrU0tH0SshRcLltfTkoWrB
         wV4J+0QQFFeh+IMsRBe0lpvhcpFN75AMkDxXA95CunnxApXan7REZNIGsM1QAsJT6naK
         KRV81z2K8Op7sG3NzCnyNGqHPAW60xtC8JVLpGdTg74mq5P8fKr4XHN3WxbqciBF4VL3
         BCHBnUF6sd9Sj5TuWWnJEonDa3GEJ1DRUju7+Mdigc7HgaNDp0z79ZjA3bXvFmiyUhZN
         pkgA==
X-Gm-Message-State: AOJu0Yx4wnN9VTAM7UNFkzWxH26iEy6086n2xhKBQhA7saGzQPkHJtXc
	++KFTkj8F1st94QZZ7hYn7zjTScKEf2PX1lOW2b/pRFtADYWXNjEg7dNs+fvs21+
X-Gm-Gg: ASbGncu3aoQ1nf2vRsp6Mt+ROPc4jodg/8SuGUSvVQxAuQWe9pLouTLeCUxTiRX0v8I
	KQOnkUneDqp2n5CxQYshqkDT7PQgPC/6hTohfXPI0iO3R7tTdqgxODBM5lh4+1c1adiTLYrBDAY
	YlAUFH2Riu4yixVmguKKJ2gtUV3PY1AsWiHOHsN58YhgIi0kInE9yFAm2EwLssFvhqzQc2BUwei
	N1RN6oONrsGSghj8wPDHQoVeJtWJ+7Gob01EuNXYWVtXwnF3q0ejetGOj0wfZ+d1uIwyqoXif5M
	aQ+40jH86S4eWy7nYNvudcrwpJHGJdYsxwtlR9fySVkl1+Iz7nY81WzVkNvJ31U9eiAFyYExUBY
	t+DjSGqYZ1YL/u2EfNahyBPQ=
X-Google-Smtp-Source: AGHT+IFi8ImP0++YWD6kTIAuX6SlNKG6JGDgVcNi+wU9bugmPVfJAQ3uicE0rjOwQ0INfGHTMpYYvg==
X-Received: by 2002:a05:620a:172a:b0:7e8:3c18:9859 with SMTP id af79cd13be357-813be24a231mr542542785a.2.1757274330024;
        Sun, 07 Sep 2025 12:45:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b5d57c6e0asm69809981cf.51.2025.09.07.12.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:29 -0700 (PDT)
Message-Id: <db3d4e9a89d4b72dfb7e59dd38c6dad31f5c1cf0.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:10 +0000
Subject: [PATCH 07/17] xdiff: delete fields ha, line, size in xdlclass_t in
 favor of an xrecord_t
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 59730989a3..6f1d4b4725 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -32,9 +32,7 @@
 
 typedef struct s_xdlclass {
 	struct s_xdlclass *next;
-	unsigned long ha;
-	char const *line;
-	long size;
+	xrecord_t rec;
 	long idx;
 	long len1, len2;
 } xdlclass_t;
@@ -93,14 +91,12 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 
 static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
 	long hi;
-	char const *line;
 	xdlclass_t *rcrec;
 
-	line = rec->ptr;
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
-		if (rcrec->ha == rec->ha &&
-				xdl_recmatch(rcrec->line, rcrec->size,
+		if (rcrec->rec.ha == rec->ha &&
+				xdl_recmatch(rcrec->rec.ptr, rcrec->rec.size,
 					rec->ptr, rec->size, cf->flags))
 			break;
 
@@ -113,9 +109,9 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 		if (XDL_ALLOC_GROW(cf->rcrecs, cf->count, cf->alloc))
 				return -1;
 		cf->rcrecs[rcrec->idx] = rcrec;
-		rcrec->line = line;
-		rcrec->size = rec->size;
-		rcrec->ha = rec->ha;
+		rcrec->rec.ptr = rec->ptr;
+		rcrec->rec.size = rec->size;
+		rcrec->rec.ha = rec->ha;
 		rcrec->len1 = rcrec->len2 = 0;
 		rcrec->next = cf->rchash[hi];
 		cf->rchash[hi] = rcrec;
-- 
gitgitgadget

