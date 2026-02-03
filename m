Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4B8363C74
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142373; cv=none; b=nP0F1Eo6FGUbt5PwijxicrD3GpyEAImFlSRPZSDOXF/japPSeAfPYAcP2mf+76S8caNb3eFamLxRrArTy7U7ocFI2adL3uzRy1XjU81eAE2QxcVg44f9DHiTKPsM8ZAhN2qUMWfMd7zNaw87zQURiFheH3aa2CD+rhfddfbBNwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142373; c=relaxed/simple;
	bh=2Vid7g0tkvm0aM+cMRQK0H3Z+QqUvxQpizXKDDGlwCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XiyxvoDFBFmxde6pBI2YDS7szC/Mpwdbn3loM9GkWtRJtNZIz0YPePJQ1kAnDYRoJGaO1CyxTrtKFMwKu9MMIrX6smwKnvdqmXlafZd+JnUBjZHfkN/wqngf/5o8/l0jV/UwJV10mvSDuqlaCUmsXxiW8AUZBydIIcA20KFzIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJjZgEmO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJjZgEmO"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8860d6251bso905826866b.3
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 10:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770142370; x=1770747170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=09GkdQ+4gJ1ssY6uCpIR6T9U/4CDhH+j+ipDxp3tWs4=;
        b=aJjZgEmONP7pOx8jz7swa9LlBwiSTQYxLIQowsO/9k6kjkYnqosc2KsA7TtqQKedO/
         9ImO5Va9OFGpZ9MJ+j0SY+xdPV3nFks6gNitmIEAORw+tk79hVTfYeO51MIareMXTACk
         QLjbYBg9LyHe7uUpM7GdUum1GeWvjyX04L1RpTa2c3yjEdn1Hcld0G1zAXfhfGbUDHxE
         Q77uH/wMY2y9qIehHHSFNX/GWchGIqDYzgHpdVLS1csX+OlKBbEjB3PO+VOXBTQlURHx
         iNGXaarLcy5h+PGbDmHkaa6uUCUlE1cyWjArbztsaO5JDBwNry6i29kyIt1jj0dHag5w
         +B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142370; x=1770747170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09GkdQ+4gJ1ssY6uCpIR6T9U/4CDhH+j+ipDxp3tWs4=;
        b=hV5fubJxL/keaTtANV28QxBbRTiL6z2f7ToY6d7WIANqnkS4i1eFYWKMVShqDWSTzm
         09rHxPsBKRIC/tSny2gybtEOUvh8YYokoHx6wTGAVFbuynCVca9gyrrKhA8nEbh8pPjJ
         6RCgWR+0vvPzrNV8BTK+ZtKB+5YITvkIt4x/HkCiRrNUalk/crn1l1ndEMC4QL6RP7a3
         avsIItucZvMQA9OKr1xe/N1QJYRlrDlvhi3uNhz8IlxpvdjnmLitMB+Az1DA6sQYAJR6
         po1nz4jVbC/m8nGSRwEph+0+doHwZEuixj/tRy4NPsOQVWTmr2c+zZrZQd61pxQSE6Wi
         p6Xg==
X-Gm-Message-State: AOJu0Yw3SmrQE/FBylobERcTSrg/q+ugX+MBqy+Rj0mUsLqYJHUoN+0E
	TsUC7A2jtz22/MFikKUNCpSCmwOTyj2mSKSnTzKDBLcuOg6H1v2Btfh+R0/sog==
X-Gm-Gg: AZuq6aLv9ImkSmYd7tb671EHbI2cbLRxhuqMFntqaurCMWtYshwTvDCi+/ObVkbWIiv
	FYsnFZ4kq+WGbk8o8deMRX9ki3tEEvPSf3hDzw6m67mBdtxzKI01Fk6GJWgq7gtCY/DFCvT1oSN
	eg1ZVXeFo36BtuxAgbrfDW5nes+scZHqUSdX1xgPnmF0hYlYUG0eG6rrLMF1r0pFmX8iJADCplk
	3a5aBCcd3Md2F6RsHE+Nin5O7fM14sGz2obXZJKUAhkvNI8qtYuo0YmhGt78HUizDVNnQuNHdyQ
	qfZR90cGoZAjPsdtWPaKRAfGwevm0Zctz0HxClHWKZhCoUUxOr4fO9JSn9uD57gOWh7f9ZpYLf1
	62LXM6CoAdK1E7h93KB7l9W5p9QMrU5udbWZn7fYBKvCwnlbMw0HRBNFxRB9dI2yYuKsomfFS7O
	W0ht3+bHE=
X-Received: by 2002:a17:907:3f16:b0:b87:34e3:a79e with SMTP id a640c23a62f3a-b8e9f14be8amr26180566b.12.1770142369577;
        Tue, 03 Feb 2026 10:12:49 -0800 (PST)
Received: from dev-phord.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fd0a2b6sm11138966b.18.2026.02.03.10.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:12:48 -0800 (PST)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: git@vger.kernel.org
Cc: Phil Hord <phord@purestorage.com>,
	Phil Hord <phil.hord@gmail.com>
Subject: [PATCH] .mailmap: fix email for Phil Hord
Date: Tue,  3 Feb 2026 10:12:13 -0800
Message-ID: <20260203181215.1615818-1-phil.hord@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Phil Hord <phord@purestorage.com>

My canonical and old emails were reversed, somehow. Also add
an entry for a new email that may sneak in.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 1337b199c3c9..8a39e93bf85c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -224,7 +224,8 @@ Peter Krefting <peter@softwolves.pp.se> <peter@softwolves.pp.se>
 Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwolves.pp.se>
 Petr Baudis <pasky@ucw.cz> <pasky@suse.cz>
 Petr Baudis <pasky@ucw.cz> <xpasky@machine>
-Phil Hord <hordp@cisco.com> <phil.hord@gmail.com>
+Phil Hord <phil.hord@gmail.com> <hordp@cisco.com>
+Phil Hord <phil.hord@gmail.com> <phord@purestorage.com>
 Philip Jägenstedt <philip@foolip.org> <philip.jagenstedt@gmail.com>
 Philip Oakley <philipoakley@iee.email> <philipoakley@iee.org> # secondary <philipoakley@dunelm.org.uk>
 Philipp A. Hartmann <pah@qo.cx> <ph@sorgh.de>
-- 
2.51.2

