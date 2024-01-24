Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1B91643A
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079311; cv=none; b=V0i0eURzcZBjO3xYTyycUIoSFKfXthA+1rhPTDn3dBPYBU8Ktzhdwvv3a8grEJOCfLQy2X2Y4ozhWGWEXZeSjDwNK92MVYCrcKKgESspWvCRBZ89nslXT1YJz7CoX3YLSm2ggOrvZ9MJ7UpgKhiMLvQhCMEXY5Q3U+094L5YdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079311; c=relaxed/simple;
	bh=wFqnypwvu7JwUKxBJeE8hsJKjQheP3szGhpdUxNGD6g=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iN7krj3Rn9AxJ7voRjsAXsnDsPr6yHk/vB+DWGd+OGTX5jO9yWL3XOXLEjxV3VfDz0z4SoH2PavANQDjsFFEtWmnL8CmsAhKrkjscKis2XPIHNXDFZglyjjNjy3iOF9CU5CpRpipZMl4Amof+ysABrUOM5Q2KJ16zCi1rs1QUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FslE9ps/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FslE9ps/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso56829385e9.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 22:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706079307; x=1706684107; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ8nN93BjzrXAhTOlt++q7zDpixQGOdFTMnqvbtbopM=;
        b=FslE9ps/PZpJdi1fJWlX9vby+jgTvhCdP+p7terZ1KgOVjG0A5yoAWohGdxlMcTb2A
         8pihs3ceN/7QohVeLPHnC5CDUy4Gz8qL/CrfZFhmfr2Mic1rxqeYCkF+zUjp3xkgpl7V
         q1A8YwSTxYiUtFiAuhqoCqBMJvGb4FX9dW+fk7I0N4j4G8kTECrCWPIoRYMp6lu/J5gb
         SBVOeHJ7teAuxev23Df5G0XjYEga8Q1ZDDalv+9Wliw4wb+GQOz7x4S6/upiN5PadMGQ
         DIdBUyajPaUnWAFZ1F5KEtSOgtXvovBcRPEpi1dbYXacVG+JFwT/sY1wq7Zg61crsT3X
         cOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706079308; x=1706684108;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQ8nN93BjzrXAhTOlt++q7zDpixQGOdFTMnqvbtbopM=;
        b=V1InONMNd1gGOE/3Tyl4MLxFgrQnh/Gga01cGfn2JsSe1HV7phYcV3KjyQqtfUVCsy
         ZH2yaKWczCsAvIbdu6IvQ4Ui4oHMdR+0qWiRhKw5hGOGPwVXsTwj96M7jDVT7lgeEf7A
         V0zxaqeIe++yhYPdqY/DUoNd+Otdz/K4RDe3FoXpCrkGNW0lioNMukWN0+mTb9ioQB4n
         l5fAfYsi5Ewa56UomKzR9hSsESjjuHStEtOCcBQKkuAgymZ5N8qGdK/XARAo3YViAlSt
         bo/Y5U+OuANOTlCARdhcZTdwLD0LTrts+k77M+VSMN/1Ps/lJaG+uhVsN/MIvyksDJzm
         57cw==
X-Gm-Message-State: AOJu0YxhT1vIPD2T4pWoumEA7DAXjp8sTO4fclV9hMs0DFOQ2PSgqZqd
	jRtB9kIjpBQAnUxomr/h0qls3HVhMKn+KK1ybTU+UFK0v4z3QB0xXhlcsWWd
X-Google-Smtp-Source: AGHT+IEPPd73NewdcBIu672efQUdMvD0Vm+gj/kuJRZ1R7yrDGZUzkkjKSOZzbXs4sUtzPx++3lh6w==
X-Received: by 2002:a05:600c:4f0e:b0:40e:c31b:388e with SMTP id l14-20020a05600c4f0e00b0040ec31b388emr731941wmq.31.1706079307546;
        Tue, 23 Jan 2024 22:55:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b0040e56830a35sm44658316wmo.18.2024.01.23.22.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 22:55:06 -0800 (PST)
Message-ID: <17f2dda4907ec03b0783160c53c4896fd76cb053.1706079304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.v4.git.1706079304.gitgitgadget@gmail.com>
References: <pull.1646.v3.git.1706078885.gitgitgadget@gmail.com>
	<pull.1646.v4.git.1706079304.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 06:55:04 +0000
Subject: [PATCH v4 2/2] patch-id: replace `atoi()` with `strtol_i_updated()`
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
Cc: Mohit Marathe <mohitmarathe@proton.me>,
    Mohit Marathe <mohitmarathe23@gmail.com>

From: Mohit Marathe <mohitmarathe23@gmail.com>

The change is made to improve the error-handling capabilities
during the conversion of string representations to integers.
The `strtol_i_updated(` function offers a more robust mechanism for
converting strings to integers by providing enhanced error
detection. Unlike `atoi(`, `strtol_i_updated(` allows the code to
differentiate between a valid conversion and an invalid one,
offering better resilience against potential issues such as
reading hunk header of a corrupted patch.

Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
---
 builtin/patch-id.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3894d2b9706..88db178c905 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
@@ -29,14 +30,18 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 {
 	static const char digits[] = "0123456789";
 	const char *q, *r;
+	char *endp;
 	int n;
 
 	q = p + 4;
 	n = strspn(q, digits);
 	if (q[n] == ',') {
 		q += n + 1;
-		*p_before = atoi(q);
+		if (strtol_i_updated(q, 10, p_before, &endp) != 0)
+			return 0;
 		n = strspn(q, digits);
+		if (endp != q + n)
+			return 0;
 	} else {
 		*p_before = 1;
 	}
@@ -48,8 +53,11 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 	n = strspn(r, digits);
 	if (r[n] == ',') {
 		r += n + 1;
-		*p_after = atoi(r);
+		if (strtol_i_updated(r, 10, p_after, &endp) != 0)
+			return 0;
 		n = strspn(r, digits);
+		if (endp != r + n)
+			return 0;
 	} else {
 		*p_after = 1;
 	}
-- 
gitgitgadget
