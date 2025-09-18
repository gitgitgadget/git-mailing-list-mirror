Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6222D792
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174444; cv=none; b=U4fHsiaRzW6BzRjU8DmdtEWSa8P1oK9e+Vvo5g//Yn3DUhtQlpSuViejN1wgqOC5pDnjbDe2DeX+oNelkuq7IhAAWb9H6oSP3ZacyP/jAp71hvuXq1dlQaQulwoomklRRIBVTQd9iQHPpDI5j4ZPHuxgZtifvExRteRxhPghQ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174444; c=relaxed/simple;
	bh=dgt9tAC11TEuxeZaUdpur3TP7YOncEtLo4BR3dNoYz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ilT2gg/0APWacBNEtAyTHzH1yHDfE1UOVNh+HwVhjJk7CktpO4whRBKvTfXvMzflR1sEMfOD93MGRDlSTJ6hdT8H+K7hH5HgKBgjCEWA/6k2D5E2hUrHiOjHAwNyPY3eOe5bqVrVuj+9nEJQumNusy9w/01DI5GjnSpgsSDyjxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUSAseDD; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUSAseDD"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b54a2ab01ffso373836a12.2
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758174442; x=1758779242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmerwYIe0PaD2lGT4RrFQR+HS5DZnIgZFNArxdiBHkg=;
        b=KUSAseDDf31kvECv86P0O7I7HHlMoPnI+5OyiOPu+OVXWb8yRybuyFILuKb6n2S2+a
         7BqnC77jhUlqdpfw4EDhJM1OLFMrhR+2pTd638ThQZATgri8w7H9M22IY9NJBQ+TZEFq
         aqKALbSD2ELJbchFAi41FD2+bA1uip/TD8VXVUJGRbU5McLUKvFSNf5cz43Z+yK9nhj3
         Uny5Pk0H1HrFIkxs34Y5Vmo28b01XPBkgGy7UYtJzoEDlDp/b0mA58aXWMyiQnvd9KKD
         WEHGxn1fS+BIqLJJyn4GrWec1/yVTpNcvkwGG8k6jXy9OhHMEooqjR/g5ZLhwdVjDTIo
         rIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174442; x=1758779242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmerwYIe0PaD2lGT4RrFQR+HS5DZnIgZFNArxdiBHkg=;
        b=IqP8riKgkLNmzjjF4KYMudZSRScKpwwTsaoO1C9Igr73wTMW5BgqvkmEJxEqVFIWLm
         gYWpVCA1EcpmlPiYeq6817sg4GR2IiR+XLOunyIN4tPRXwgawvQSGf4P3GfYBJrW8nDV
         siG/ZhosNWG+99IOmybctVozQ7AHydzZ+U4Yrd+V/9E/8QfLMxXklhFbBlCEDG835o6Y
         yuEYBb6vZVi7kKczj6ZiKeGZwvuvDxOOI04qkg5hrK+nQyV4mkOgZAGbr9e92dH6EhQZ
         RQlG8dZqR2ycOtLFqrZ1i/6GH6oiSEB/stzVg597uNb1f/XiMTjT04Ha3CZWT7yFQDt0
         0vCw==
X-Gm-Message-State: AOJu0YzE/Xkz54slui1SpwW6k6+7xr8bvvzmOTwxyyIUcG+xD7fGTjoA
	quCxZJpUHdK1L7Y/W5txAu284ijo5ipyXLBrtL/ViaeId1f+E6s+eiP82ZlVbg==
X-Gm-Gg: ASbGncvG+23Q3tFJbCSedky0ZijhQIX4sVDPhf8qW7hEESV63K0ApsknMaEGWswD0qF
	9DuvHWVUTKlPZn5SQyVwsGlvYs/semQ0fRuXG2zINSOWC2QzpaqZ9zhNeBjtjxz9v+Dvbh/N+qC
	uzlbHmtfi2xwKMwYArjGAKUpUITVqpim1JYQzHj3GN/2PaQ6V+5I0tJBNDY3nYzgciPrqLUOHGD
	Jtl62OO2ficL+WYRWM2o6tfGbESWooaEpHnfnG8xeOpHrWj8DNsB+JSTHY94nY8aXJ5uN6mHkww
	wsCSz4hQpsXj8fjgPI9Lr5PrAOu5qylnOIq21RHfxEa8JER0hS8J+oDVFJXQvXMbsaivt79ryfS
	Zye5ZVNYeihHGnx0XOdLn6c4gKDfjNDNMshl63A==
X-Google-Smtp-Source: AGHT+IF0JeEt9sC9qy3IF1j4VVQu4Q/CHDFkgvn1z+eBvzu1CmHVihR5KuQSC06a0RArhbaoH3yH3w==
X-Received: by 2002:a17:903:1983:b0:24c:cca1:7cfc with SMTP id d9443c01a7336-26813f01439mr61857665ad.59.1758174442088;
        Wed, 17 Sep 2025 22:47:22 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802debfcsm13621535ad.86.2025.09.17.22.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:47:21 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v3 4/9] builtin/pack-refs: convert to use the generic refs_optimize() API
Date: Thu, 18 Sep 2025 11:16:59 +0530
Message-Id: <20250918054704.544254-5-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918054704.544254-1-meetsoni3017@gmail.com>
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
 <20250918054704.544254-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `git pack-refs` command is tied to the 'files' reference backend. In
a repository that uses a different backend (like 'reftable'), the
command is a no-op.

To make `git pack-refs` a truly generic frontend for reference
optimization, refactor it to use the new generic `refs_optimize()` API.
This will allow the command to automatically work with any backend
that implements the `optimize` action in the future.

The command continues to handle parsing its own command-line options,
but now calls the generic API to perform the action instead of a
backend-specific function.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 builtin/pack-refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 5e28d0f9e8..dfcf664524 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -51,7 +51,7 @@ int cmd_pack_refs(int argc,
 	if (!pack_refs_opts.includes->nr)
 		string_list_append(pack_refs_opts.includes, "refs/tags/*");
 
-	ret = refs_pack_refs(get_main_ref_store(repo), &pack_refs_opts);
+	ret = refs_optimize(get_main_ref_store(repo), &pack_refs_opts);
 
 	clear_ref_exclusions(&excludes);
 	string_list_clear(&included_refs, 0);
-- 
2.34.1

