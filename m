Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0219066F
	for <git@vger.kernel.org>; Wed, 29 May 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002961; cv=none; b=lgkadi5/65cYv8pHjGPsFI0plemHe2lV/SumMHlNNWd0odeu1CO2CMREIhej8UfGfb8hUCpa97s4Itsd1aQwnXvlAQU8GXFn6YeRmnsX5HB1joAnbsUlEEcDkRpeTARdIlcmMUlQS9cTNtNeXMINnHpvmsmPHFwGwFAnVtBeEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002961; c=relaxed/simple;
	bh=fijzJDkuq8RIpqIOnXZkBl1yU6jFP9QouKhKuHe9jNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5RV9+gn35FVWHnczh+aNA3mV/IQOa6u5GZCu3GPOejlUJE30HHPH0BfIGhqYsXV5u8VK4MncgNrt83n0ahVWGOgtgjXCUX1W5XAtfL7PCCBf9aEsOlSKg20BHVNb4nIq93ouIA7FBXYwJ3M2as5CiZl+CDVsuIVrUgm+KgiBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkV0Zppd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkV0Zppd"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f32b1b5429so16635375ad.2
        for <git@vger.kernel.org>; Wed, 29 May 2024 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717002959; x=1717607759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WEdWttlzRRyVg20QgIAGZdIILyC7g5qVxk5PmFt3Bg=;
        b=nkV0Zppd6h9b2TmlOEOApeXKaCmx0qTPQ+DcQhWhbf2r6Lc4lD8jjNRg6ZxO5IBeez
         WNz2SFYOm5eiGNMgBaG1CPNK/E2m87WzU1PCL5N9iD9CnzwIQYCWtZ+l0FpZhum64Ox2
         VyX4FDV9b50At5x246HY84+n1GsJ2+OXjUEuBVGJoYxNNgYXrmmQ5DXbLftl4s69b3YM
         NougR8eFDrkfs/MYpcVT9jU6IuX9knD07lnae7extABGiZvhwOLC60RWnFDDTH1mv3PX
         1lS1/UsWT2Hsx4MsYFrFw5oIULlDoO9OqAOI9HoTxOOFH3RO6PIdOsWg0uZ/08tDpV4l
         MNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717002959; x=1717607759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WEdWttlzRRyVg20QgIAGZdIILyC7g5qVxk5PmFt3Bg=;
        b=B1DtkyMOeX/Ga9FSR2yMaeVKGLA2ToMdlg5nujGH5JAMNQ8s2HaMsRJ0G216RxmS94
         Qv/kH61XFbLNte+Fb8wQE2X8RViMRJ2rGQYkps2rlfO9SxnoVmRrgf8c5akTeFhO+i5q
         5exxfdlWAnrq6cN2S2iqpmxFVgiyy96oYbuKJ1biy/ot9quBOg8uiRAfHhOvWGd5kulO
         /qh/MiustngJ8iJELBWi379quJ08XE3IhsXd2J7X2LZXyhVuLcYLZYdDcP+Zv3UTh+ah
         EAMYt8+uPI5vWIfIEEwJMWTwAfkxcEvxiIniFf+/puJOsnymcRp/r6qd04aq+qOtL5gW
         e+tQ==
X-Gm-Message-State: AOJu0Yzrf4g7fUkl+mGM3NcMcPg14yl7ImT4SZIZxI20QoECyQ42JQrL
	UIGSB+F/1FbpikwuD0ToUFSbek0dPf+pNH/zsdr0/PIF2HQAEYL++s1h3GqSx1U=
X-Google-Smtp-Source: AGHT+IHP9uYEyyBKm4gF3K5D1uX5qyW+8mQBDpY1isgb3I1R8hOozmCwE7H5R+s86PrPBvwIJK0ulg==
X-Received: by 2002:a17:902:ecc6:b0:1f5:e6a0:c176 with SMTP id d9443c01a7336-1f5e6a0c42cmr19568765ad.26.1717002958670;
        Wed, 29 May 2024 10:15:58 -0700 (PDT)
Received: from Ubuntu.. ([171.51.169.75])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f4757734b6sm79720225ad.234.2024.05.29.10.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 10:15:58 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v3 5/5] t: improve the test-case for parse_names()
Date: Wed, 29 May 2024 22:29:31 +0530
Message-ID: <20240529171439.18271-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240529171439.18271-1-chandrapratap3519@gmail.com>
References: <20240529070341.4248-1-chandrapratap3519@gmail.com>
 <20240529171439.18271-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the existing test-case for parse_names(), the fact that empty
lines should be ignored is not obvious because the empty line is
immediately followed by end-of-string. This can be mistaken as the
empty line getting replaced by NULL. Improve this by adding a
non-empty line after the empty one to demonstrate the intended behavior.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-basics.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index 3c08218257..529049af12 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -89,11 +89,13 @@ static void test_parse_names_normal(void)
 
 static void test_parse_names_drop_empty(void)
 {
-	char in[] = "a\n\n";
+	char in[] = "a\n\nb\n";
 	char **out = NULL;
 	parse_names(in, strlen(in), &out);
 	check_str(out[0], "a");
-	check(!out[1]);
+	/* simply '\n' should be dropped as empty string */
+	check_str(out[1], "b");
+	check(!out[2]);
 	free_names(out);
 }
 
-- 
2.45.GIT

