Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5818E04E
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604551; cv=none; b=jEWJPiAoEGWOJd+QqWVq2aJ5ceRZcUJ+DecJpHRj0b+YhToj7r9SMQ3EBty5db4uzJ2JpuTA7fdvSwXg/nkEkiHu58XE9q9CVqVa6xY1IJXfR/1WiHZukao59kkSsrq7SNSJngRK6+cOpzEL5JQzRiPyBEMB79vPsgqjK7UFpZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604551; c=relaxed/simple;
	bh=tXsWlvhdZZPSSIeFvzoAMP3/5d9b+YLz3IQ0HtzSMZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KgYcYd1k5rMGIhqVsFWxLf4ihoix6WHDLWrOCTCMCBM3Mnf7jyuhK40RaKr5V2Z3OpUr/c8Pfr2oJjR8LBexW2JnYLWUI7AQT/uRPEi69XZ4DNUtoaV5qWHClpQit6rfm97oLhh753aNrGQHM2n9XJJkERKoqJJMAyY4BKuXVtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPOM1A9t; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPOM1A9t"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e681bc315so652185b3a.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 09:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731604549; x=1732209349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qR/8ePUe8qW0iV55zsMKND5tDGia91PDVvkk0/2pRYU=;
        b=PPOM1A9tjrobORpD2qTcz+U3b4LtS7wJV4+cSuihCA5Us151vVTd7uB3yuMAjs0M0o
         uOeGMRc4jVa4Qkr0T8l59tcNf57ndmhUlfG6zc+NTZumhnfMOVImuvFJhEyXaK4TUqRF
         3l+euERjXtEgzJb/30mm4UohpUIoDhtEkUEUPbGE08DY+c6TIT2PHSgQ7PXNzzF0B9v/
         GlXMmvlk5++WZ9lxHr0e7xo8N0e03TfOcR9Lbopo24YnEOGObE8rfwxUHtsiUFZX7Ei+
         Ijji4m1tF4tWgbbg70w08UV+le003HWlpyDrBdUuKU3+x2HpXW41rPA24hdVDw9sk9K3
         fZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604549; x=1732209349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qR/8ePUe8qW0iV55zsMKND5tDGia91PDVvkk0/2pRYU=;
        b=G5jj/LCX722ny17/FiFv5ZQqlIEaqtMSiGOMktPgseTkZWkZAhhCmxXlNWTBLbOgUu
         dLGZbLzma6aoEdWPMnVNMEiYD3k7fMTXGEzUXcbBxXKwzRVa23fm1bpUuWLHNUMWKqQl
         8n5BOvahZVcaaiHW9WJWZWmfEukmwhaZqMZeRtV1BZHGH1xi7Xl4KPC4GXRevmiFATNE
         yYi1LYHrXaM/iB+vOtQGSx8LYw81B0GdlkI/aAclwyTGmL5pxixmgCOiz2KookHgm7/8
         m8/6ZzgTO9Vbt4DvpOAMG8wAQYRj0cOa6otD28r7Kww0wDfCw/R9woNPgzLO75GCY8Qx
         ASqQ==
X-Gm-Message-State: AOJu0Yz0TnUgLa8RLIRF3cTedEwQSUIfFbnx+Bg5Q5LaVufABcuQJtII
	4ruNvpbPSBNihUZJdPEOfCwObvoGQ5JeXkwxihvHP3yWVeqQNiaZW69hZw==
X-Google-Smtp-Source: AGHT+IGuIrGL7J6a2iUjrC7aOD8xboNEshPg4kSF/53Lfs9iKUg2cZj8mzZ2xTYlHWHIXpn6ngOAew==
X-Received: by 2002:a05:6a00:3bf4:b0:724:6804:d663 with SMTP id d2e1a72fcca58-7246804d6ddmr4866002b3a.1.1731604549017;
        Thu, 14 Nov 2024 09:15:49 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a9bab91sm1539883b3a.149.2024.11.14.09.15.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:15:48 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH v2 6/6] push: not send push-options to server with --dry-run
Date: Fri, 15 Nov 2024 01:15:37 +0800
Message-Id: <9d11105d0d0ef5717c6c691a3648a1c1bd1aa988.1731603991.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
References: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com> <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 send-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/send-pack.c b/send-pack.c
index 4845f63737..89a2d47928 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -678,7 +678,7 @@ int send_pack(struct send_pack_args *args,
 		}
 	}
 
-	if (use_push_options) {
+	if (use_push_options && !args->dry_run) {
 		struct string_list_item *item;
 
 		packet_buf_flush(&req_buf);
-- 
2.47.0.rc1.21.g81e7bd6151

