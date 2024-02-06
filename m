Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93B128803
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707202575; cv=none; b=Y3x5W0aJ/78NDGR3ZsgJBsdI0OwLa9QcwwD0hp2OxAe7CGrX7/iLX3EyqoZD9AFzY8NnIs7mTJ0Fmq0MI0uOhlZB9FV/QPDmWQjaR47+jVKILd1NlqLcnL2Ek4KlpNU4t16BjesuQzHrh5lKNHPY34soBDt+64daNj9dRhFuFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707202575; c=relaxed/simple;
	bh=I733DBitA44mxz6ZCW9hxmiHgOSGrrg2Anx1hjQKGng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M4bvUgXDiXD4HPvEWIeSiIvzZnRJmEj5gLiC+JqwNHZO25ekww2Al3CBlqnTXVsKbe5FNXwXp7KauRwSranbL6CWgrvNGiTJOZ80xmHOeVKgejteUZHpTO6LGamoH3KGzfkUdnoBSYC/71KeMSEW2C6qFYmM8DdWqck9bygSg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aV/oBQCZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aV/oBQCZ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d95d67ff45so34727915ad.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 22:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707202572; x=1707807372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AlQta/nF1Z5/rsZ8liFN/QHYQssdbGdnJQDQ5cuIJW4=;
        b=aV/oBQCZ4pF5us9CPlBXauoeIUK70UAhlwyODj4V66zrrZyfnTbvfXv7EUW42GwV+Y
         Nr633N91pAiJGVykrGczeujQBDnXapZtZf6H1mlX9bJSWEvOfR0NYtK5tWlI6VnG0pm/
         AwksrhPxNw59aqbwrsE7fYwZiFpA+evALpPJaa2BQt5AhMjuG564Q0FOHmmVBeT92dp3
         /ckBLRfl6deq5uSygMYObQWgTAbx07AILp5dVUWT1wXkGTMhg/xLvmZQ0GOFpzhDudUs
         Nq4W+jZUc9iKdlapqase/dPkryIMl5sbTn5so3yp4jmseBcXoybmsGQ4b/d4LsU8Ywiu
         owSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707202572; x=1707807372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlQta/nF1Z5/rsZ8liFN/QHYQssdbGdnJQDQ5cuIJW4=;
        b=DH7UNrRb2xZznTxL/acRIceHK40gnhAPuYSd3N1K0oprpbTzsvR25kZHeAdthclHNf
         3AD0csmJPqejWJcT4aCprb4/a+Fcq3mfB9+UO7FFnEtaK6c6TmTctJ3Qy5z0lyioqgmr
         f+APp/U2xY2gXB59pONOimGSjC8jfcvPSOcIVvJ/WaOPvmtgtBBmx8ZQUE6tlvHAUHXr
         FvJX0VupR1XnURXDeoDg+WxkXtjgCcFB3GR7kE6lLACSgSnj8p93kRv9VcUBltwE1D/G
         soZzgsE7vqoRday7xhi3tfvy9avezh8QHnqRUdmUrMLVKAMAh8+ext9G2wiLp2ogbTuk
         z8jQ==
X-Gm-Message-State: AOJu0YzcR+ZCw3ioLhd7YlXEVRG4zmbXV8dMBgUfHT7ngM0fO7FloUQF
	p1oD0efyvc+/pRWIQzTdin99CsMycVPLaTETPb5vUG5+yNsjk3jKD8ZVlPFo83PUYim5acrAw/g
	t
X-Google-Smtp-Source: AGHT+IFT4V7YEPQVeL2T2zL68i2E/UWgny+hujvSEU0XXtwkCe7NdAqNOk2XHsLNVyWRA2jM0nWEoA==
X-Received: by 2002:a17:903:4288:b0:1d9:7095:7e1f with SMTP id ju8-20020a170903428800b001d970957e1fmr837406plb.67.1707202572106;
        Mon, 05 Feb 2024 22:56:12 -0800 (PST)
Received: from C02FT0QBMD6V.bytedance.net ([203.208.167.154])
        by smtp.gmail.com with ESMTPSA id jv12-20020a170903058c00b001d6f091ca04sm1070750plb.13.2024.02.05.22.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 22:56:11 -0800 (PST)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH] doc: diff-options: clarify --relative option
Date: Tue,  6 Feb 2024 14:56:05 +0800
Message-ID: <20240206065605.44457-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In c0cb4a0679 `--relative` is given the option of specifying the path to be included in the diff output. This works by assigning the path as diff prefix. The documentation of `--relative` only mentions subdirectories, but in reality `--relative=foo` will happily display changes within the `foobar/` subdirectory or even the `foo-bar` file. Clarify the option a bit.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 Documentation/diff-options.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 53ec3c9a34..b651e442b1 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -762,8 +762,9 @@ endif::git-format-patch[]
 	told to exclude changes outside the directory and show
 	pathnames relative to it with this option.  When you are
 	not in a subdirectory (e.g. in a bare repository), you
-	can name which subdirectory to make the output relative
-	to by giving a <path> as an argument.
+	can name which path to make the output relative
+	to by giving a <path> as an argument (e.g. `--relative=foo/`
+	will only show changes inside `foo` subdirectory).
 	`--no-relative` can be used to countermand both `diff.relative` config
 	option and previous `--relative`.
 
-- 
2.43.0

