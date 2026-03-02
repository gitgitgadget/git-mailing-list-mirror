Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4F2375AB6
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461336; cv=none; b=FUDqhJMVDyLxqR3hkvpoeqwlSapw6UxUCi5S0/8h/OO9bJ26nTxneQWnKStM0kExbFM79h75e/6qmA4N6c4nSt3FWmx8mla0UR5s15fAbbrNVr0PGvYbh7p/Ki+gaZ+iBhIqcfBh8TWXq47YSSuMqpgJihD1rdW6O2nwheBOUbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461336; c=relaxed/simple;
	bh=TLy0uMdScopkBynOa1ZGtUnegb9yWeWf3rG9uGAY8Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXzViLj4OANqZEvvH9kvRKrj4FZ04/+wuAH9I/edpsDvK2UYLFzj3l3rWxpM2BRn/WpxD97/G/n7otoRzTmZzYr9BiIEvfJei/ZCWMTfuhBvAyNjaNRmOXwbp4JoR/QGO+7MY+46YI9lZ5rsSWV/PXxOvPnAMbdQA4LL/69pKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eotvGfQW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eotvGfQW"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-824b5f015bcso5124347b3a.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 06:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772461334; x=1773066134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoEN9anUjuCocpUSpP4xJtzY3okg6/GrP+YLvni7UhQ=;
        b=eotvGfQWJK23TvGj0iyP3PDzJRBgg3UnVRIPgXIoIat7h1RESKhv5T1E9UG9qfser2
         iDhljEQN/jHqGHFyyEo9E2Xobtfu7hx6R4HJHpqZvFzqoMnz3T5H1hkVQT7Y0/+OhZz1
         RAT16Z0fJDk4nPt6nCn3viwZObU6tkeMPLytz76QBEcxMFI5qWFvcpBnx+n+bc3GncP8
         ZYwfP5BXRFAWmd7b7tz6crwEwDbBGnlTCZzKCe9DT7c5wWOtcPlRY5M5tmGxQR+AqDge
         QpwxNRQkMKkbOuOmeLF/psgrVZbD7Lr9YKPLAUiEUiF76/1Aq2AO2+lvbIGQz1xkDHQ8
         Fvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461334; x=1773066134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aoEN9anUjuCocpUSpP4xJtzY3okg6/GrP+YLvni7UhQ=;
        b=hK19MTFlUjk0jfqJ+LwRqfMyoqpTLRwJlMgLEho9y8vp2Hn9zBUiuFWT6i5KMN3tcM
         6HB/bfDEmXt0T5b7rVoijj5HLGU8uoSBFCYlJlI4ShsumUAMfS05ABHzNooqsvTLx2q8
         YiCkFa9LfpEkvNujaBzFpkhsBwj10VdyB/3ta/cyIQVG2QqdDevqzKYHwNzj7EuSGuvu
         66n7Wjr2JRKQXKwriQ0kOvMtH9HRVxhJu3K3rA8WkHlUHKokOXHWJNz+A/zmDK5Edkpc
         otTYAjJqy6RfX2zJTODgxYPZDiHmI3NiVml/Un70f51MoginEc0Dk2xFDGSsUEB143vQ
         bG8w==
X-Gm-Message-State: AOJu0YzdnhPE2g7UW8AilOSEA1JTeqhnCdSLnQ4znVkXTb6N475eQFQo
	iK/NL6aHP44fUEWMl89zj4EKukHLrLd4MaDd3fy+0QGp8ZQz4jk4rtaacr9xDmaF
X-Gm-Gg: ATEYQzznq28vn/4YTE1JWP1feBGSpeSsxbZtfQ5VfAw4cJ+hHdCeBLNrnAU4Fke48z9
	YWP10lDxkX2WiyOjst7daJofeFVsplHnbkKeuVTNc1/Jr39LZgzhstBDXpquviXI+PFNVN8LOVN
	1V7dNGSvEz+Txcr5gQkLmLABT0vS1ghFZ4Ztf+1fCG/NIBneHkENMnIsxFi98LV29XY/IEsMB0K
	lVWGDye3AXu1kie26FoFD1Unb4SUGd8WqJVN5XNuaqbyk3dAqd9XLwtF9o71rVe9Fr9lHpYTK6a
	c24MhTgJ/am1x2aR14WdOEWdhludqVk9kB8HQRtE5+137L39j+Z4BzVbuJ+smxIQfzTLklI+dC6
	0XUP9ICCzYboQRkhHS36DITpyymDJahMa6STLMzfN4KHvWGB/cImdkIQ4Ic/ZVF47LFko2hGiv8
	HE4U8WKT7Db2QPfFi7ngyiRQ4S2LvHYtYjR/IDyVAJ0bFYLfhsvJJCc7QyGw0iVW0+/LK5ymGit
	VsKEhtNE8l4dNNZe/5l56RJdH/4tiGT
X-Received: by 2002:a05:6a20:b787:b0:364:33f7:6099 with SMTP id adf61e73a8af0-395c3b3dd88mr12331921637.55.1772461334470;
        Mon, 02 Mar 2026 06:22:14 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912fbc363sm11329843a91.2.2026.03.02.06.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:22:14 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH 2/3] path: use the right datatype
Date: Mon,  2 Mar 2026 19:51:37 +0530
Message-ID: <20260302142138.712273-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
References: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strlen() function returns a size_t
Storing this in a standard signed int is a bad practice
that invites overflow vulnerabilities if paths get absurdly long.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index f613d8bbd1..56be5e1726 100644
--- a/path.c
+++ b/path.c
@@ -58,7 +58,7 @@ static void strbuf_cleanup_path(struct strbuf *sb)
 
 static int dir_prefix(const char *buf, const char *dir)
 {
-	int len = strlen(dir);
+	size_t len = strlen(dir);
 	return !strncmp(buf, dir, len) &&
 		(is_dir_sep(buf[len]) || buf[len] == '\0');
 }
-- 
2.53.0

