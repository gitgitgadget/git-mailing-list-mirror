Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B1274B39
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344902; cv=none; b=hULDtVfrsQRAn7+t67qlUmgf+yVjKhNJTTsw8rLW28JMqVRcPemv7PxdGfEtn0DtSSsBgIrrEsMjLEcS1wZIooQ0QCtOkAo/cPLXzesthNzuHyjZrX8Y7p3l0WjZWUU1rvkSsXGF86ngkJvzmaCL1avLcAb+hC5UjCqBJcTm8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344902; c=relaxed/simple;
	bh=eRwoI+TabiEZrasUgGTZKwU0ZMgystmgAqdDUKnTDS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qK/524NmWYopHyv7aH8oMhiGAZEVdoq3sGuKwR4ORt463w4u02FkMtDetBXpbMcBJkUUS1RTIxoWWWz2WspPvMkh3ZQp8bjAY1Y0o0yi2KyKHVavZpyszNKI7/AwcRjdH6Hq52nN/iwZWiDRL9lQr8QFR4aaP04/Fm3fyQs7/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boSym5kj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boSym5kj"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45634205adaso3202975e9.2
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753344898; x=1753949698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MorQArRCZ0rv6GSu5FNKJjUZJiDuB/C4PRsSU/Dt8oc=;
        b=boSym5kjnnwrk97jGRMIrKMmbZKSf575iH213sMYVn7iIrFIM2WhIbhk6gPrI4xTPy
         Aoa7xhkzy06sm13ZAWW7kxPwI+lfFN6phDsGy6HcFLbBBxTcEgtHssQXpncFFPxBipMu
         j/qJE/GZESdJf91EzQ1TTDUiKDVLPNIVGnUkQ/5TmDut7radQSFkEF1M4xymG+rJNA7d
         wA7V8qvsfPL4lHwP2wP/d5Dj/6ogYz2uj6lPb6LXQ3LsWr2SXM/6HBCaUH6vH2WrG+SZ
         xegCtGxf6DxoE4xG+EjOUUPIvgB5IoEgJhdR3m0FQkppsvDxbSpShl9XCQzBSDSZcuuk
         eYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753344898; x=1753949698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MorQArRCZ0rv6GSu5FNKJjUZJiDuB/C4PRsSU/Dt8oc=;
        b=waOGIelqUkmRTzFSUtw906g2IPZxa8PcfJw89iGEsjl0DCIkT0BXC6bUT3rlq460w5
         2a7g6SIfL1cBPwtFbOSlNgI9KpPg0XW90bnoUdhB72J/HEg2fI52UV6HQt7FJ43Vai2x
         H8UxIq4MYTVJ4vPE1L4QpDUN80vSXwOKtdjQ8HzbfeO3X82iIfaSS6doDf3vVDfd04Iq
         a0ogCKtveuEC086uIJs0X+yg8pd5NSWRVPUlKO+7HDvGnMtkMgEGrwlae7KMxvlXuq+O
         2c8tiIYQQT6mGz3+Jl6gLKCJ9suNTjxq/JnrAn/FbNKNgp+WB0XuZDRDBQHSKo4M7Ow8
         wjnQ==
X-Gm-Message-State: AOJu0YzFj+5Y9NvSWwYz/vzLaPIKVJupRM6LJ8JCkDmPFaxLijQSc3+z
	raOxBrkeR2MpHk9SSLLJmG+WCgeJx6mCvLWBktpqFJkqMAT5mUpj+IPJWuQgkbcd
X-Gm-Gg: ASbGnct/UXTAe/jQwZ3wJeEoybM4i+42r8jlz2gBzegckJ0lyUAKGejWPM7yLoZ52vi
	LuWy1wnloGdhR1O3aFUJ9imZDNAw2o/OVJDLfnF7BXfMZmDqqBf2Y/m3P2EZKz7NVIzzKPFsVA3
	CUKWmI4TpUCzNUJtaEhgETJMrbAVpO9evZMCcdHWZB6q20QIrBXV3vBShDnH8s3DwJeDl7rR8Qj
	nwqSQCz3hm+NwRfYV5//SSO3XntBsAhEtanxGi0wyc5QGIYP/Ax6LSXq/cxknUaJGiEwYwKZFif
	6qFK1RHm0K36plH2ZWWp/RiMGbd3OwFi/9L0ZQ8SjYvbyMeg5kc3pat8ijN++4odiSgSd9qAtPX
	rXH52/5rpGg==
X-Google-Smtp-Source: AGHT+IFCGqn35Z/+wAqBWHxxKE5j13drv38xDDXvb/B0RqjoyaSbLqkQHPZTMvtPttDE7hsAt5OBTw==
X-Received: by 2002:a05:600c:6992:b0:456:58:1114 with SMTP id 5b1f17b1804b1-45868c99924mr56134615e9.9.1753344898191;
        Thu, 24 Jul 2025 01:14:58 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586e7d1326sm14678865e9.0.2025.07.24.01.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:14:57 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 24 Jul 2025 10:14:45 +0200
Subject: [PATCH 4/5] t6302: add test combining '--start-after' with
 '--exclude'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-kn-small-cleanups-v1-4-0c70f591de3e@gmail.com>
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
In-Reply-To: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=eRwoI+TabiEZrasUgGTZKwU0ZMgystmgAqdDUKnTDS8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGiB6364z3ADsjn7sVPvzLOptpSlkawMg4ho9
 IfhfIXZ5sNRyYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoget+AAoJED7VnySO
 Rox/lIcL/iohCzzU1eExIVntYOeygSgtJ+MhQCfeg+shm57+J4rHWok49aOBSKC7dVNSVhlisMM
 r+46Z4E6DGBVl6/ka+VWAqKu6dmuxuIbgGG24J3zV7tQjoH1pvnSVs14bNjEcUrviaE5GLVlqrv
 gNVTabji5WfcrKCE7+g1c+X5lrbey1cm0ByFlqJFFFUhpvPBSXiL9s2Z2DCRE6/p1MJpwov5uii
 MFQAaTKyVRTZkn5Gk+2FIsPs3EEe4rmeEJbrxMMVcruOADsPq9wJLQ/AcZnCaoRZjW/9JQY2pQ3
 dgRScBwvNQ++BebAzjvRmOjPOLFcjkRzwWf5x4o58fp3Urq6lICZswPhfBDeyuI9fh/7AojuPYa
 rq8iLa+pCFhZUUgv10UMRCPQD8GxMh18dgtstgJDe8V9nFtx8W9IY1AaogCFG0vx+EroQTCCC3A
 Hdp6Af49wYg+mv1sDd7nlOImlyVdUXUe6b2cxPx5V7cm1Gejv7MLcghakHxACI40phevYB/MdR6
 Ak=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The '--start-after' doesn't explicitly mention being compatible with the
'--exclude' flag, generally only incompatibility is explicitly called
out. However, it would be nice to test the compatibility between the
two to avoid future regressions. Let's do that.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t6302-for-each-ref-filter.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index e097db6b02..9b80ea1e3b 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -712,6 +712,25 @@ test_expect_success 'start after, overflow specific reference path' '
 	test_cmp expect actual
 '
 
+test_expect_success 'start after, with exclude pattern' '
+	cat >expect <<-\EOF &&
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/foo1.10
+	refs/tags/foo1.3
+	refs/tags/foo1.6
+	refs/tags/four
+	refs/tags/one
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --start-after=refs/odd/spot \
+		--exclude=refs/tags/foo >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'start after, last reference' '
 	cat >expect <<-\EOF &&
 	EOF

-- 
2.49.0

