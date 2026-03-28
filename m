Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D793132720D
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728201; cv=none; b=gbbEj87MiHynll4bHJNF983FqfaqxQEaNMX8WtttBJ8nWm3DMbejg8D4XjzMZzEzTsbO4EMjuRgAqc2835+Ymra0FNa1/fwgtMtLjtgOeA1i2BqlGprDbK3R4yOP97oVybZj7oBGe9e1KpzHkC9TK6n7RwM0V7b07yA9/u49cv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728201; c=relaxed/simple;
	bh=gCpS6doQxmmdnUqduKZwGDe0OvvuDsyoEswXzraYDzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDzNTyWZv3yqKxElzE35Dr5mEZY90d2e+nlExrInu4SgzgWz9tvONyyDQx12/YA482x4g+RuG9xgq2Tfq4bdwjmG8QjQuiRxNnrnKOvCdGspgXxU/m58o6X+v2rOCeRPf35IjDy3wpPxXcAmfI99DwjJZHaUbQ92cLZm0TvwYLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrNZxeWY; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrNZxeWY"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70f91776fcso1331112a12.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728199; x=1775332999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTbp2Nsz1IWkWGXfH/vsI/Rqi1BQbDPCGbJ+klakyjQ=;
        b=HrNZxeWYa04spdmztgt/KamemMh6TiGIQi9Jt0wb23ScR1YhPOvmO5bKad4+29aFGT
         3V3Q2HZSGVUGZWH09AreNbD3WI41F1FckPY8H4BMh6yH+0OJME8buxqqk0pn35ckgFrU
         njIAScWYmEQhAsH8vqJm9jCcbFcSfrazEM7gGWkRq1c7Sza3j2ZRixBMtoxbYxwcAfO5
         N9Jfzx5HthY+6cvH6epiIPI8lt7WNc0PayqsHYflqJQ14YqwKqcl23Bu3gybuIrE08DP
         Y3/N4yw7PLYQ2me57AW9ZQB9fAV5l/D4V88FA9QpckojhTQA1nvPs83dV1iw7NYD9f+N
         VBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728199; x=1775332999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TTbp2Nsz1IWkWGXfH/vsI/Rqi1BQbDPCGbJ+klakyjQ=;
        b=O9jZvd5lyVG8sevVtPVn1oHGAxm2o4v9LnraUtsSFSixUv3d2/qBa0TUsLl2ETMUVt
         cXy8sGMcRs+4OTnlR7YYk1NWqN6zYqhG6e8niasXQTNwqKicIhbpsiPi6Bwe5LTcqbQX
         6iJPStRdQEsV0DZQvbtntecInAhp3JgXU1B4yeZJCDYqh0ssfm/W2h0ftAbbcnNizzeP
         flLDg61c42tfz8K/rzHSScZZW/xhAHIxhCP3bw7DKosf6SCtvoZTSAxMyMkz/tG1P9rq
         U36kHxSujUhpRyFNTni6gH3G7TlC+jpUywkXlemkcYYIxUR4Np+p8lk7mHw4ZJq5ZvyJ
         r71g==
X-Gm-Message-State: AOJu0Yx4fSaNE3nhlLj1C7gGJQhj6FeC7dIFGbdA3TytlzcsA/pCjjC6
	oGFv+kiyZYRA3Fogm2rcv0o+5H989BCEyN4sTeuKPC7/JDUfblDsZUAxoOdiILcK
X-Gm-Gg: ATEYQzx47KAaUuwgbgONhdAvgPT31tungTrNlibWUUoajUWJIcEPmErO/hqrKWuRxlY
	OzHbcU42xxIIpkB1IJStrXRbPrqL4FtszBRLr5t29lqRE4ZuCdeXEyPjnmI0bNvpSsURNvWv2Bs
	8EEr8k6gh/GXrWyT7Yyye3Td7pzNAKC9HSkpkaP17VTTp97MaydQ+Px6Kri1h/aokuG+pxtuGRZ
	9zkd3Rp4xz4nJjNQv851AF2L8dja1z5eyhInqnsmXZ+zpf3Wkobg9ipFwrOJGbvInmEf/FVS/yk
	pMEjvYOcegmTnNaSDHqCrWF9jtQ8p+25zhThzm++3gk68HXCZkYKeWSUYP3s37eatSbrlX/CeTa
	+5eCUU8eeiLPCtf+ZeQSjsM8YmmJySzu8bs/uqXser2T84rzxKGvGXcgyo5vF98ds4GjrRJPqog
	AvomM11LvUBEfyOwn0sk12Y0Ew/MYw8dnwr9FTvAwaHSvPHOnLAnXWIjQBLZrWZ1T4Gvz3b1FIE
	BcsP50GjQ==
X-Received: by 2002:a05:6a21:7704:b0:39c:643e:f062 with SMTP id adf61e73a8af0-39c87855aa8mr8095553637.7.1774728198880;
        Sat, 28 Mar 2026 13:03:18 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:18 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 08/16] t4150: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:47 +0900
Message-ID: <20260328200255.247759-9-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t4150-am.sh to redirect git-cmds output to a temporary
file instead of piping it directly to not hide the exit code
of git commands behind pipes, as a crash in git might go
unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t4150-am.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 699a81ab5c..462e450c60 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1094,8 +1094,9 @@ test_expect_success 'am works with multi-line in-body headers' '
 	git checkout HEAD^ &&
 	git am msg &&
 	# Ensure that the author and full message are present
-	git cat-file commit HEAD | grep "^author.*long@example.com" &&
-	git cat-file commit HEAD | grep "^$LONG$"
+	git cat-file commit HEAD >actual &&
+	test_grep "^author.*long@example.com" actual &&
+	test_grep "^$LONG$" actual
 '
 
 test_expect_success 'am --quit keeps HEAD where it is' '
-- 
2.43.0

