Received: from mail-ua1-f65.google.com (mail-ua1-f65.google.com [209.85.222.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B53C3E95B8
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044643; cv=none; b=K/76uthNl/sJSBCa79Z1HALu8PM86mXgRqqaf9yMcoWHeRj9O4YPTsXIp8oHxMBfFDlTASKnAc5oRsEe3jVHiA9Mi2eBl8SOVYxeMmNXi5gfda1Ws3kPOxn6xpCmPAfVhRk4TSBifDAZHJ/yLF40aAmoX6YJcJnBtBrbgMTDGHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044643; c=relaxed/simple;
	bh=Zbixd4cWOi79zJj5Z5gKHOK5kM4B8QWTsH/fNyVd5Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phslu4Hue4apvreqhkuZo64P30Wo2qUXmCUNDTb7P1mra8n4Vc+FwN0coxknPox4EN9i7ut9hqScQ69EqCPA5VvytmJ6bHPGliEpA3LpIuTKJ0gEppgnoLwx/Ye6tKttxMiGT/6qOpy/fqjV0Capa97AJ1iIHrW4NIyvCqbJtP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPnRPBdh; arc=none smtp.client-ip=209.85.222.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPnRPBdh"
Received: by mail-ua1-f65.google.com with SMTP id a1e0cc1a2514c-94ac5cb71feso5497241.2
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 10:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772044641; x=1772649441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnUeiFhoTHduwHjgu2hhVKAc5fEPnG0IVlbrM1G5vDo=;
        b=fPnRPBdhhf0TDCnNnH02mmx/taOTs9TpGI5O/1AYBCSJj92yWxfW7h+ETLyEmDdknP
         YQ8rs8DGmRNxlI6cW4AMBN4K8X/V72/FDnUYBe9LyKbVhCXJbg3GWi2vc/8Yc/axmW6W
         JoU+9hnfR4Z+jdvduBiGQEOZ6BjU63hoEiP27WB8r/d3y2WM7Mi4ZPfZtNlaHJY4fFmj
         wrnn9cci8/zuFD607MJfd3Jk6Kmpm9GvAWYADTCFBVeoC7l8+a/mRwDjKYgRj+9i0puA
         3M73M8lEwkeM6tqveUwxDxYR6C1q6w1ShuIwLx6YBFR1XjxxaDYog44gxe5WL2CUt2H0
         yaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044641; x=1772649441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YnUeiFhoTHduwHjgu2hhVKAc5fEPnG0IVlbrM1G5vDo=;
        b=isjwNfvvttMCCOhMuQXQ4RCenP7FeAHCpDMI7ah7lvxDucDhp6J3+BAufTVllGa/aR
         Wk1bLmf6J4FQe/SCFYL84fr4zrv3nEImJeVs0hxcxNeon2rhU3RQt7KPZTdrmlzqKp1W
         zu6iyZeKfuQ1m2/hitXLcLX63CqPbPppuwFdq4EtxRqedyqLw9Sc8wUam1V/vT94ZjG0
         0RFUoNon8qytqB38FV4E1T3CFUhNbnRnLoQNwcK7GXSxq2qZZl29jjlQdR852nXBGVD/
         iucU0yHc1kJMF5phWGhTLqAteS5uvlStasLVIaGcZAEMyxpkpFXsBfchyZZrg6v5KSg7
         KauQ==
X-Gm-Message-State: AOJu0YxppQ9ujP/fHv2cTEsqPWAGxttd8IEc0RIH3nGk80X+Zc5NtMZT
	41woNuJIIisP+lyq+nvVKxnSii9UG0eI0YdbtCXgO67011hVH9dtJAgJzf4XFKkZ
X-Gm-Gg: ATEYQzwQTKUoWifOzXm2rYOyDF0vMwYvv4LCrV2jsfEDXsp2yHQwhinsXibQIbY+i3v
	9c3A9GijZkSr2+Acb4398qiCbKa885p48XSZdpBKxPl+WHz6sWVppn19c3eWZMaVJNEpxYoaZlu
	Unjzk4CmOs1MBeX49BKBGxPsikNbMnVkHYHtQ2Tm0iglMSEy7jI51Pn6zxtO4+zN74BcmFB1YNz
	HmipeLDPcnIdOwq4jGNFXFL7J4XFrzfCFCcBXjRaBMOKGYqhx8+9O6HFDH+l84/O1w7v7M+CEO+
	ARfKMAvXUFzId81idOKq86AkiJIghnSy+T+sodeDVb6BuKVW4OIRqIuBDSexKTQOOMpCbLzods2
	T6X3h2kZnXpnb0LiJxejmfiiE1xsE835ucojuKnXa1zUwqL7CTEi0kRdwnCiSeNvHLIAjITuaPs
	c4JHSkYLx1R6EvFFkc32t8p07BhOqfuYfYAOqidmd6rVK63Yth+ydEO6noymKo
X-Received: by 2002:a05:6102:3f0e:b0:5f5:3638:776f with SMTP id ada2fe7eead31-5feb3056369mr5848002137.25.1772044640692;
        Wed, 25 Feb 2026 10:37:20 -0800 (PST)
Received: from localhost.localdomain ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da89e129esm13457485241.5.2026.02.25.10.37.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 10:37:20 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 8/8] Documentation/git-repo: capitalize format descriptions
Date: Wed, 25 Feb 2026 13:32:17 -0300
Message-ID: <20260225183559.79303-9-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225183559.79303-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
 <20260225183559.79303-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The descriptions for the git-repo output formats are in lowercase.
Capitalize these descriptions, making them consistent with the rest of
the documentation.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index f76f579b20..5e2968b707 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -33,13 +33,13 @@ supported:
 +
 
 `lines`:::
-	output key-value pairs one per line using the `=` character as
+	Output key-value pairs one per line using the `=` character as
 	the delimiter between the key and the value. Values containing "unusual"
 	characters are quoted as explained for the configuration variable
 	`core.quotePath` (see linkgit:git-config[1]). This is the default.
 
 `nul`:::
-	similar to `lines`, but using a newline character as the delimiter
+	Similar to `lines`, but using a newline character as the delimiter
 	between the key and the value and using a _NUL_ character after each value.
 	This format is better suited for being parsed by another applications than
 	`lines`. Unlike in the `lines` format, the values are never quoted.
-- 
2.50.1 (Apple Git-155)

