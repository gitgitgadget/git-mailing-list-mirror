Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9905B39E6C5
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715279; cv=none; b=DeENlnhDYwCrAKgaMpmJOxCEUdJ0kknGQhJ5JM42ig9M7GeQn4CPI7t/BbyX0D/yAdDwNbBn9IJgHKZevpfInQcROhoVx/JfYvAzmzd2p8RNR3Naj2mJ45i6nzXKo0Hh2rRo9gAD0CM4PJXT6whtLAo/4Mtpm3jXNQ10mB3dH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715279; c=relaxed/simple;
	bh=tnUwt57+t07TzjXX2EiyZ/WmjFgyEVVDKWyOXqXe5bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlC0pwLXcz5MbSiNTbjcKso2X1/0w/c1fzvrUeLkyG1D/a1tyg05x8Epw37a+h1R/2ZvC1fvfpD/YYogTdTzh5/T0i5jypE3N2SArGsz3bwVJmYAYwhzu9NiliOPbf3N/MSdsnmnpMv9MCaVPo98ziqTjOtDtVukG2cqdfA9FKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH+7ip94; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH+7ip94"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8273e0fb87aso4505356b3a.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 04:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772715277; x=1773320077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzJnlgdPCXzHRkBzHFluJrX2uo8AIhSoz8jt2+gQMkE=;
        b=iH+7ip941q16dUSkOHYyfxTwjFrTFR/WXUP2R1WskaynHPpZlKseNCkafabxe07SZy
         597KKBIcVlUoWalQg1ouxdANWJoulKWrwP41781otJKCAYScCQ88jusK/t++40e1H+d8
         tFqRf7as3l7KVxzzqsIRCFaH1fvZyJQMb5xZlgaQM8//r8zRDd2e+liSDY3Uutpd3yxW
         0oYhofqi/D9bmJTTfuYjaT5HInxtr3L/YKUedUT+zr2omNKFGZrWO2CloEEN8IPEAAiL
         pB/92iXvddnXH6rGmIHyIpmBx0Jd7O9R7mgB/PCe9YGDyCuYpTpzGo7vGk+s4SaUkI12
         kmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715277; x=1773320077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LzJnlgdPCXzHRkBzHFluJrX2uo8AIhSoz8jt2+gQMkE=;
        b=EsIi+ftdFE5S1kmDwn3EYWkgM9hfHDolznKAOlMET7LV54TiBraPIPNCnzFJZIrg/9
         xyQyOSUzMWbbdruovKhcxTFwqCKAIlhoTOen8CvV2XKURdtWoFW2ndkygqspNdAzLDUI
         fqardcW2M8NdJT1K0O92WA5puUA4zp8ubxxay5ZSMaJYsoOc1m6o07lNOYq5B9VWOJCQ
         pHcrri+pl1ExjrXfRNW10B3iey6Jj+h5QiAeReJbp0Krm80wStghn5ELdb6K7Psm0baf
         f0WxuAzv8diXwbBCWuZeDu2y6SwxacDBJZrasf38R0/ghqpvcYqguJqTwBHPnN3R8jcS
         4uaw==
X-Gm-Message-State: AOJu0YxEOBB1hEokffqdlY1HBJlHiS+tw1jaNPWmiPzIlk15OiqzAiMj
	upzYFFts1QXrp88CCM39Or4EAG7wTh01mth9NoR9C5bdTzxfQnMnn30BVJGX/YHt
X-Gm-Gg: ATEYQzzDNg0yjil3PE5Y4xunyWEXZbRgGRKJ8j2ccXVYuIt1Q4lzTee4fJ/bLsXbZsg
	vcMZRLY7ZBhZhtasN12DUhwzLOZgvrct5746qADbpL1j/7k/wJZOIJL33U7DlAn6YRVE12jB1H8
	d+xHx4XqS9qAqTZ+vntTqVeGSmtBq3q+9Rp0efXcG8TnRnXktlG0rOfdHRR2ELpVL5kXXLNlEDN
	cW0N381Yw9CKxgjTCyN3Kd8nmgIdc22Lu/Ytyk1f/LqafEiXC1XwstycbGoGOJNsQqDomUyhIhe
	louVdCI/Vl5cfOapPQHUv5hdVex+mSuxxoroQaHn03/W9mZdx5jptcKsjY8iuCuMDaIQZdIZoQe
	LDTHr/l7/yhzPyBUygPoVQ2NPRAyranJgL9kOTklHqqjcVqOowa/JMUznaGtSqMD/L7FSF/ETUV
	dp+07ZMS4xXWemdC8X3nJ8CpoL+8Z8gEuLEkW9ZrezIa8blM/0Gkg7jnEoNJpE22QUfEVIsPCQE
	1zMOf6Ubbioa5yVSTLidWzi0xNnVCpV
X-Received: by 2002:a05:6a20:5681:b0:35d:3f07:ba34 with SMTP id adf61e73a8af0-3982df0cb34mr5260609637.31.1772715276891;
        Thu, 05 Mar 2026 04:54:36 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c738b823b76sm2578190a12.9.2026.03.05.04.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:54:36 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH v3 2/3] path: use size_t for dir_prefix length
Date: Thu,  5 Mar 2026 18:23:31 +0530
Message-ID: <20260305125332.27600-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305125332.27600-1-jayatheerthkulkarni2005@gmail.com>
References: <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
 <20260305125332.27600-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strlen() function returns a size_t. Storing this in a standard
signed int is a bad practice that invites overflow vulnerabilities if
paths get absurdly long.

Switch the variable to size_t. This is safe to do because 'len' is
strictly used as an argument to strncmp() (which expects size_t) and
as a positive array index, involving no signed arithmetic that could
rely on negative values.

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

