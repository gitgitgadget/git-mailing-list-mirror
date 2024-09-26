Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93EC173357
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314764; cv=none; b=HZvUXXlX7UhtjronNrXsovzJLJ+QhjhSqwO+RG9Da3DZz/uYuVdix0vbKgL3HsWjtSY7/rJiesDINX9ujj4+ldCrvKu+dCj8V9uqAwxOBBuVXhzcFA/ICYgK1xIvg1XfIgNb0hSHdmPHxVAjrVnY1LT5471bcJ7r7+4dYX2tVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314764; c=relaxed/simple;
	bh=roJnz3/INk+HZyKj9E77jJo6PShL3RtE+vAwUiFE+jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBj01+QU9lk1EuuTwBdcX6nLLcOehfzqz39OGB+Fg+xTPCwX/KHkS+SZGLwNONOnWmnosNEQiDhCBGPrCLejd+hhaLz8wfY01GKV+vvPfPp6dl/Pwz047b26mtdf6jcaqWg8dvG2QICT5N5G7r5nOby6J/S3VcWsZV0P2TiZ1Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxUeF7YW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxUeF7YW"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a99de9beb2so31701285a.3
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 18:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727314761; x=1727919561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEF983QoTeqLkFSOWELrllUkyyi8a+7N5tL4bv30djU=;
        b=VxUeF7YWmQ+8vBRtHCTmS5bGUOYfLp0WMoxg+DW7CpLfTofCwX+KdYLDK03Rv1GCFK
         Scrk+7m0m4ZZj1HVnmOxSW7LThYS3O2ile/XN2kzidPU114vqWNrKybT8Pr16Kbd+rEA
         tKah6Brkft1h7XbJZIA4+5RfKZA66wS18AE1E1stkSkOwZBocEiYTI69kA9royDKOzNE
         4i5J947s9y8p0AFTlqQ+w4sj2Y/KCNXRVbHw/N4Jj9vjQqxMddFH/2I9FHuLewdW/JPG
         lrDsU7stHpfIlYH8A6vbLppBfCMxH1RGv++Mfg40YxFz6LQduSxrZt9Pr/tFjCPNpyVy
         ViyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727314761; x=1727919561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEF983QoTeqLkFSOWELrllUkyyi8a+7N5tL4bv30djU=;
        b=rbczhHjUdMdEiJXQhmDbmVF3DegVJjKobgXu2EactJwUfcRwgyQ0Dyy8NKszwjimsH
         VjGH42Vp8plxr9/gVwhnCgr4yHH4W1YkQEaXfwtixoLN3udzaiOf5eKToWRDu15mUX0M
         hIY5naLZ730tVNf1OAPDlPZX4FDHtaQya+RUgW5b47hgJ7HB9MFEgJVooTue61aBYFc9
         TPOj8ZJqFK4644o/GXIW66K2xr5e0b7dTYGwJFvBzUv1RTUnVzcIzd4Le5soBTYy3QlQ
         VoWP76i2PfsNhnSxWoYfJQiZYB3iVdU8FWCGDM3e4Wx2Bskaw6OM20BYG0EtsAKb7QFR
         46nQ==
X-Gm-Message-State: AOJu0YxVHMZsDDcP3QdwsBwrSkPoUlxReLSf+7BVoQQU7/CG+ouZ9KKU
	aLNuop8IFRiXEbcsfbcM8TI6gGRoNNfT9zGXZRnxnknaKx3nxLwlPCsBGjJc
X-Google-Smtp-Source: AGHT+IH6kQkauDoZBlJ6K8A7LIeUy3ZFtiZEjDXQnCEi8zR1kTilQ4oaL2ZIhtDPRUotyi5/faT9/Q==
X-Received: by 2002:a05:620a:28d5:b0:7a9:d115:90eb with SMTP id af79cd13be357-7ace744e427mr642452085a.52.1727314761214;
        Wed, 25 Sep 2024 18:39:21 -0700 (PDT)
Received: from localhost.localdomain ([142.188.15.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde49acebsm227789985a.0.2024.09.25.18.39.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Sep 2024 18:39:20 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v3 3/6] serve: advertise object-info feature
Date: Wed, 25 Sep 2024 21:38:53 -0400
Message-ID: <20240926013856.35527-4-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926013856.35527-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240926013856.35527-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This will allow a
client to decide whether to query the server for object-info or fetch
as a fallback.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 serve.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index d674764a25..c3d8098642 100644
--- a/serve.c
+++ b/serve.c
@@ -70,7 +70,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -78,6 +78,8 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 
-- 
2.46.0

