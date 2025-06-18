Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870531C5496
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750227832; cv=none; b=nhQGXiRVcz0j5USNn9hHSXajcH7999jc5fisbUxDto+PMM6yD+nfNhDva3ONGMAZXtCYahBWJpOPh/kUqRZKpAWnBp4+hv2zfVHgzzjYVEhVTYamUfP130azWs8k0ANsvNkbjJXof9WCvgyBv4ck/Jj4/JjRJZwRohb0VzwqhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750227832; c=relaxed/simple;
	bh=rti71r/On1Un2vfp9jTIxVqtZ7pQTJTM26VyzNvv/Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YrUPKeMRUM99pZKSs7+9kzw80y9+CgVHMEdfVrNll39K9xwkvYuHVrKsn2YwuKeIoEd3AwXE5952NF7B7W0PI3C3foX/tHndoKDNkR2tqKB6HCyjqxFJ2VkebuZaT0ZzIa+Xcs0GP4KlM0O7qhDFhpCgG+twBjTd455/jJr9KAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hc3rANGx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc3rANGx"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748e63d4b05so220090b3a.2
        for <git@vger.kernel.org>; Tue, 17 Jun 2025 23:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750227830; x=1750832630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qE12bVu0n4EgolE88dDRrlMVCrmRZ3IbAnp/2jwl5l8=;
        b=hc3rANGx5ZokMeSjLGuRtqCLtW6MafXJjPVx/EkOc3SMR14Y76q4L4aoxwhfT/hBWq
         xf4yPY22BEzO/80c/ufJxDg9jaBYknj3/VvaG5RBG6niYiv5ALuKWCCGeJB1wCIJo/Lm
         PdFuI8I4ZXg8JnEudPkNZ3+wyxHYv7NB2a8VK1EePyVVnsR6thjpv+CEN6bNumK+FhHZ
         YzeU7gQ8M7i42QyG2Q6hHtMwRINdEVXjZ19VAq9Wxq/cIQVgr4vTgkJqOkb+YLQX2BmD
         uefs+0qa4u3ZFMJQPWxcRNGc8642slhWQNKPy0SwkmVPA4WXTxPze5NSWERjcnDznlvz
         FtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750227830; x=1750832630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qE12bVu0n4EgolE88dDRrlMVCrmRZ3IbAnp/2jwl5l8=;
        b=c55hSt0dr4r2xbJ8SUfxt+Z8kViKeRwgI08mC8e7Za3spsKJ0M5gxrDpmlE0oxKNrV
         PDjIrXavJW0y3No3Uz0duiKqV46vUS+c5z6mZ+4ad9o3dxrMlIzjaX2FPlzJ3t2s5+dK
         CXn7ClZ4ER0en3DNOd0Dx0zwxHkL6voMHqlxWW/fPZY0uB2dJMM84tRmhXGNtSTREzds
         6MfQUT5TBUHO9LStnkzlBm4//CFCJp+pBA7vnZ+WySldvMOsnikhb7Z78uc8Wgmey8IT
         OpsyNIcq4RynGtI3IhSmnwIpiuc2aiIfUkJxQ/En42Iru7T35frgF3fb0EXnkgTV1DBv
         vXeg==
X-Gm-Message-State: AOJu0YwB1fiw+R/MzyM00JEfNAKxtEbDH9VcSuor52/nLnzihHXWwUtT
	OY8x2DA4/qqkUqVio8zTP5iwDwjDXuBuJPQIzPvRn4gisaZvqFmeCQQEkkMpkA==
X-Gm-Gg: ASbGncuSCkoISX8ggCo15sElWuzNj5L30PA02WTGRDI2ENNICWt412ARslSW0iX1nXi
	NyoIhiV+SVgfUe5lCoR4narjajjsw6bXVoRSi7TaOWcsmBHi7MikSWgxf/u/zeBuzs3JUvSrj7E
	tji6cYXE+rxYWF5IIvveDV1imVZKWQ+XdytsbeOn4pSAbKkhf3tcc+VM9aORAUk5sc8O7JBL5iv
	qBVpvpVKIF1WGT27hf8PNhedJHPAgg6Rw+UL5HLKCBkMgdmV9MIkyHM4An4+OI2UanzNVhPFBA2
	0Hke54pvjAHMDcqnuSp8gHTB16mQP6RdZtXAuQFVHZN3wQWb/7szvp1y5VtvQ7Y8NMznduW/4Qm
	mr3qtlPSuFz5DHlQd
X-Google-Smtp-Source: AGHT+IF+9mu3va6aojtP7LtBvaMCj2l4ByR5P1zT83Zkv2VK7bR30yc9I7SLHQNflzRQ679jkJvB8w==
X-Received: by 2002:a05:6a00:b95:b0:740:9abe:4d94 with SMTP id d2e1a72fcca58-7489d00473bmr23874281b3a.21.1750227830165;
        Tue, 17 Jun 2025 23:23:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:55ae:6bc4:8c5a:1603])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900050dcsm10127252b3a.37.2025.06.17.23.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 23:23:49 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH] portability: allow building in systems without d_type
Date: Tue, 17 Jun 2025 23:23:31 -0700
Message-ID: <20250618062331.78059-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.53.g63c9ac04f7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since 09fb155f11 (diff --no-index: support limiting by pathspec,
2025-05-21) will fail to build in platforms that don't have a
d_type member on their struct dirent (ex: AIX, NonStop).

Use the DTYPE() macro instead of a nake reference to d_type.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 diff-no-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 4aeeb98cfa..7c95222ba6 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -46,7 +46,7 @@ static int read_directory_contents(const char *path, struct string_list *list,
 
 			if (!match_leading_pathspec(NULL, pathspec,
 						    match.buf, match.len,
-						    0, NULL, e->d_type == DT_DIR ? 1 : 0))
+						    0, NULL, DTYPE(e) == DT_DIR ? 1 : 0))
 				continue;
 		}
 
-- 
2.50.0.53.g63c9ac04f7

