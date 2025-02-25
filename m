Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47854260A53
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478358; cv=none; b=DWPvo72myXz2kjRGJ3FrtB4LmPR50vAhydOuOiFNe9bBh2JrEyiGxv5XGBEyBaS32E8BiCh85N9czq+xvkPJVc1XK2OnX4Iqyu4x/iH/p8dMXEOjrQ6fccN43NPldp2ItCme4yNy/EAI/UBvBM9Zd5vjc+oJbnzJ73QPWRoEy8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478358; c=relaxed/simple;
	bh=5+WzopyVE62YlnJKpFaSz9p1tBm/+YwlcbCs2B/gwXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCaG/Q/A2q6+Tsx8kEec67tcjXq+ZFw5JgeOIQAPXv6oudFfXRD0NLNZYVL835TAvo8eyBtqCQ6ejQPUgwmNCf86v1ANy4oLjW0IMwoYk6GuzVamW04WEaqKIYAP5N0Wq8zHHVMb5d7Rl0hyHQRGlwpCF5vgMcjb4B6D4eb0ey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBUvXhM4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBUvXhM4"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5deb1266031so9930805a12.2
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 02:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740478354; x=1741083154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=um/Ovg+q5pf2Cov+A4HTWGWlDyj97Qf395JMT3e95CA=;
        b=SBUvXhM4z09WuO3qmoNNg/lf2YE0MBc+kOGi2OjOoTx499KKEYcdNrAQ3KH9eY9k7q
         1D+PcsPuflGk6GDhFbXssRcqkTB8aM3LaK6LROJuBkAgu9M3A8BztkCgJcmqwq91jJZZ
         IBhg4Iamd8kahAkM09g7+A2XsAQm1XokhYdKwEQuQ0kC/7n4KA9Ev/+1nC0q1/+73jGL
         FxuvNf5OyvhJ1gOwfM1Peb391mAdxEWiv32JTvDLd3W3QdfBwQ7Rq/xEQLuAg27/iDcA
         IA3Z8zPeR3PEGI2whCrh6qAxNHfj6t4ak082dNB6eyJeKJjoJAbYcP4aICBkgfFllVfI
         7sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478354; x=1741083154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=um/Ovg+q5pf2Cov+A4HTWGWlDyj97Qf395JMT3e95CA=;
        b=lhsmRi7b3HOj3rcEPwth0fDrgvKcpa/cugM8n2fMgW2C1rmMJ+FFm5rbTIvcCPwirX
         ep3ylkS9atq/8VRUYrUuEtcl75g21UZXxQl1yp8cGnhdRU52nr9L6MJSxNyOOmL5WCvO
         +EPAO50KVMbYWNeOUtcVNwGu2vbVWhRA9PbCxYUDVH7LD/JZDnq7TkXO+MO9ejKYiM2B
         PYoOCva1DoaDsDv/NDYqyRGqs8JPwLw3Su0w/4/N9dxcazCmIVivvIBc6smMNz4iob7o
         qFZe5Adpy/wnDsiY33wH3F+4hrwRvvYG3f/1/m3A/l0/kxLlVOiL/7qz0bPrtAQZCqX5
         RqEw==
X-Gm-Message-State: AOJu0Yw1sW8NxhqPsedRYaVOzLeia8UBOvoFKtOqmpEQloO7hKlIdj4j
	SVGJwD3yfcIE3UqVkw7lU24Y8f8ihR0grAiFFBBGlhQm3cScxsTATttvJXX7szxuig==
X-Gm-Gg: ASbGncsp9tZjaGCVLCEXWBrmDZti3LwSiMj4/CPbBS54YMjY4sOhnLW06euuB1vABab
	HFVjtUM/qasRvkO4PnqxgvaACnEyK8U4B05p9mfFdtYbZXVePQIfSNr/kc5PKNeLF///YuQIVJM
	nW/b2DbT7NbhjMQz/mPTSts56ldaLT5a66h+Ce3r9LtRE5VbBQQrMWKfZuVrQDPg229lt4i8I3f
	ffyqN+nnEiT2haxtTJr4EDoTH6PejzwEpFG4UeemDVknuZ5HIFKdxCC1vW5RRO/c6DC97c/AiMR
	XIDZM7fDUuO1FSDBruyNMQ75Cli7FUsB8t53X+M=
X-Google-Smtp-Source: AGHT+IHNp94AAbV+jmVbUE7jK6o4ATwGBDuodVo+Mbe6Z092yv0qujCQ2tOmDC6mJFfywcC6jd/gbw==
X-Received: by 2002:a17:906:31ca:b0:abb:eec3:394b with SMTP id a640c23a62f3a-abc0de15da8mr1317709566b.46.1740478353866;
        Tue, 25 Feb 2025 02:12:33 -0800 (PST)
Received: from localhost.localdomain ([41.217.53.197])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abed20b7513sm115120566b.177.2025.02.25.02.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:12:33 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 0/4] t/unit-tests: convert unit-tests to use clar
Date: Tue, 25 Feb 2025 11:10:40 +0100
Message-ID: <20250225101044.84210-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250224152704.70289-1-kuforiji98@gmail.com>
References: <20250224152704.70289-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch series transitions a couple more of our existing unit
test files to the Clar testing framework. This change is part of our
ongoing effort to standardize our testing framework to enhance
maintainability.

Changes in v3:
 - minor code change based on review

Thanks
Seyi

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Philip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>


Seyi Kuforiji (4):
  t/unit-tests: implement clar specific oid helper functions
  t/unit-tests: convert oid-array test to use clar test framework
  t/unit-tests: convert oidmap test to use clar test framework
  t/unit-tests: convert oidtree test to use clar test framework

 Makefile                                      |   8 +-
 t/meson.build                                 |   8 +-
 t/unit-tests/lib-oid.c                        |  32 ++--
 t/unit-tests/lib-oid.h                        |   9 +-
 t/unit-tests/{t-oid-array.c => u-oid-array.c} | 125 +++++++-------
 t/unit-tests/{t-oidmap.c => u-oidmap.c}       | 153 +++++++-----------
 t/unit-tests/{t-oidtree.c => u-oidtree.c}     |  79 ++++-----
 t/unit-tests/unit-test.c                      |   2 +
 8 files changed, 177 insertions(+), 239 deletions(-)
 rename t/unit-tests/{t-oid-array.c => u-oid-array.c} (34%)
 rename t/unit-tests/{t-oidmap.c => u-oidmap.c} (32%)
 rename t/unit-tests/{t-oidtree.c => u-oidtree.c} (45%)

Range-diff against v2:
1:  7f14d0d574 ! 1:  c5b6613617 t/unit-tests: implement clar specific oid helper functions
    @@ t/unit-tests/lib-oid.c: int init_hash_algo(void)
     +static void cl_parse_oid(const char *hex, struct object_id *oid,
      				       const struct git_hash_algo *algop)
      {
    - 	int ret;
    +-	int ret;
      	size_t sz = strlen(hex);
      	struct strbuf buf = STRBUF_INIT;
      
2:  430f5c5007 = 2:  d6cc4985a6 t/unit-tests: convert oid-array test to use clar test framework
3:  319cea1265 = 3:  1087752df5 t/unit-tests: convert oidmap test to use clar test framework
4:  ea63a5c9f1 = 4:  cda8dc194c t/unit-tests: convert oidtree test to use clar test framework
-- 
2.47.0.86.g15030f9556

