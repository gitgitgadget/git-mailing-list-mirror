Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6598060A
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040225; cv=none; b=lvw4LRrMrrnNPjBxP39FHtkjFFp99wlcKJJvl/BZwxa4YBXNg7zrrKwZWgLs6BskNsLjR/RczGs7Q2VnU8JAIITrpuGRdgxNw1ijevKoBSUAbVFPX/6DPPDXuQ3Gsc9Hd/oZWBy6I9Y2fTtOqrSTZVDWu5JGaGg9SuGzwkkocEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040225; c=relaxed/simple;
	bh=CS77GZaKmbqjoRwfTMFlhcsQ9bukzaXFxtqoDthO32k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkPGWbe+jS4T36/PzE/9MdbnytqZ3kDVC1rIAr9GMPRiYYy/GVkAr47i3TpLzjDkM6PAZj5SwmhVyPUE3jBkbVDlwIkKefPduOCdkgJq4cupYOsBkkLQ+FamORxlCdDg8baXuvKKEScQiJ6ZYF0N+gmxwWBnWq8IVTHJiNxMnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1suW3Ig; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1suW3Ig"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so1205513a12.0
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723040223; x=1723645023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay7cmSxiwFmgG+lInLAEoiXWb4RJh7Hitfijj9jFTcw=;
        b=U1suW3IgX8Vtfbe5sY46Ob1K8vzE5V/ko/VsEtAEwY0iSfoPHxKKeW7ETGksGrvdE6
         Gx03h6jS0S7h1/mUFBF4Oa2vqGw+avd4ZANT+65ziua2p/S28XbWx19MnkIi0ZAneAU0
         TYEQZT5CAN/VIJxN1VZW+eMgyPOhfeiNBB7qy/7lLl8+UTDGGPIuQrZ2wob3mH2dyyjT
         dwNVj87OBDaOVLhfcs32Yl08+BPLwX6N9HB4U46RR5IBY1QKDMcO8ibRVoRhAn5Fkwzy
         hiPksXr0VIpAO5YA02TK2XGUT60n2PGNZpMDldAhqpBtdm3nS3uaFV+mNOiYofJ2KtjO
         XTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723040223; x=1723645023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay7cmSxiwFmgG+lInLAEoiXWb4RJh7Hitfijj9jFTcw=;
        b=Y5sPBNpdSqehSEsf0yJTF4PP3XoIQOCR6E2kNLfwapMRry3UbKX/4uEnkKmpeX1/DH
         MJnckEXvnWPQJ/miG3XLzV0oeEmVdhte4Jul6lK0qbCKHpMuw9w8ESKE1GZekVB6k897
         Tkiqwvmc9+fJI8IHgFm23d/Ibeom6GVnBNgOwO8wjl0pA74TuEpIcWqR5jgLKQK51hU2
         b58mzc6054E9FuDSyGYb63F3ABGHFB+M7qAZNAIbRqCOMwACnp/GpqncjLkWos5P3b0M
         Im0bxCcy6AHvU+kGaT41yhzfzSiubTTP4esNMAnZq6Ze5GrhpUhHa+xmHQeLBq/S1hO7
         ZcvA==
X-Gm-Message-State: AOJu0Yz9MvOExD0fTc0cqI7MaRFtOF11oCX8Eg9xySNlFkCj9awhpVCK
	XO75p0lKuuEPDxJTyxpwEGIkd6lB/ROlLeLz/IC6ab9JWW+n4U2ndsUljEMO
X-Google-Smtp-Source: AGHT+IEOnLWxZLwi4uz1QGqC1Oi1yXOVLr+cdbRAutgwZ40xm7Soojo5+Oxx4e1FS7RVjxltQvUxWA==
X-Received: by 2002:a17:90b:1c8c:b0:2cd:619:6826 with SMTP id 98e67ed59e1d1-2cff952bd3amr21673814a91.34.1723040223120;
        Wed, 07 Aug 2024 07:17:03 -0700 (PDT)
Received: from Ubuntu.. ([106.205.252.196])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d1b374b3cesm1635059a91.48.2024.08.07.07.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:17:02 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/5] t-reftable-readwrite: add test for known error
Date: Wed,  7 Aug 2024 19:42:00 +0530
Message-ID: <20240807141608.4524-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240807141608.4524-1-chandrapratap3519@gmail.com>
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using reftable_writer_add_ref() to add a ref record to a
reftable writer, The update_index of the ref record must be within
the limits set by reftable_writer_set_limits(), or REFTABLE_API_ERROR
is returned. This scenario is currently left untested. Add a test
case for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-readwrite.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 7daf28ec6d..a5462441d3 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -773,6 +773,11 @@ static void t_write_key_order(void)
 	check(!err);
 	err = reftable_writer_add_ref(w, &refs[1]);
 	check_int(err, ==, REFTABLE_API_ERROR);
+
+	refs[0].update_index = 2;
+	err = reftable_writer_add_ref(w, &refs[0]);
+	check_int(err, ==, REFTABLE_API_ERROR);
+
 	reftable_writer_close(w);
 	reftable_writer_free(w);
 	strbuf_release(&buf);
-- 
2.45.GIT

