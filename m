Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BF17FBC1
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556652; cv=none; b=FEFkS97rUpGY54i1wD5YrYt+KdmDOwQHxNzCyzK1/7z1FLe11UHg7sgzdPLhuAiBhtw0uPXPRVPpqh9HPX5Uw2CR8GGWxSQH7bNQhiVJP28C7FZzFigowK9y11MLxD5tjjwWXGSMo7r3bt9f/6dcNeSDckgEcvMdT1WNAH/qcmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556652; c=relaxed/simple;
	bh=OiNQkyy0wmBiN4odcZ/SHAVkGfyF5vW1xrvjmW//pUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onpvkbFsAcqABE70XZuHhDQ/Oh/Oulo52ci5z8CxV2BC/0GyYY4q3obKjqbBL5+Jsw+33YvNnRNmO8Skm7uMjZyewpYWxRFwNwsCffokXc3j6i7lvR89k+tZvXbN7wSUA8L+aD7NDVDPB9J+4HaK6VyFdbYuxFAOStbsLewqXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2oMBdfd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2oMBdfd"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70699b6afddso226042b3a.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 23:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556650; x=1720161450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntGe1fp4qI/haA+jyjU2pwEYgOjKnHwAHyi65t3Eo1U=;
        b=N2oMBdfdzcSMhy8TIwMM2GOE8hMaqXs82kP0MpKQWnKVGeFoPEIG6ykX0Xj81B7Y0e
         ATj/IQRZLScY/UPOxsijixfAa9jMKHzMnNjAR1+6XfNKpMLYMNaB5IMEvel6NXtlGR7J
         m5xipwfkoqg7LRYMP3jn1w5Syqqm+8rq0g7TqAOQSnLmLcCe+bEouA2KMPqUUIcy4S23
         Jfc/d9qfr31Cxv6HOOoXKGFrhdEMxw+GOE9FafbmLHBwQWRVo4H10nZRpXyNDBpXxYy3
         +RYaAq4rmYUgLgTHgQOT5lb4kzlb6qdL8VYFBfGIuoGMb2uTeYs82r2Xdaq9KYKm9klC
         sOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556650; x=1720161450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntGe1fp4qI/haA+jyjU2pwEYgOjKnHwAHyi65t3Eo1U=;
        b=Bx2ylS3z2HrYNQyN2pwg7suGWM2KK8r26wkOuwEqpbvmSd7ULHWVzpMaDDciKxpfec
         dUSQZzI8wJsrU3kknm/9ipiDpRV0nRmmJxiLSieFQzX/aDPhv896AENZESAH5I5OCkhg
         2RkvM7P3KNDuKFn+RDvFT1a3OrAUUaXYKOO2ngVewivzLXUREkwspR6D+OYvIYV4gWpI
         GSAt65XMWeC4fxdpXlJhXTjumWoTeBdCzs8jgVcQpiUYZbwSK9alQCaXEldTZFRbKOyS
         l3PAxdWDxyt6Krz2Vllm+1ZhhU1yYCug/EA3iZLk44i+j0qlAS9d58cO4x+36RjyVTkF
         vrDA==
X-Gm-Message-State: AOJu0Ywo6TeiDaePLhpe5XS1QgVVdwZQ5XwoYXlKc/WPLRdtjpHT3dxK
	h6+2HdT8mQ7CuoZ2nWgGbTKVSLfkpTullZydUnCzhg5gmnwEwc/NNXVVlVL9H6I=
X-Google-Smtp-Source: AGHT+IHjVh4QEoMU60DZlXpwVH0S8J7q4hJ3s9HiJC7Vi4Prt5uZLokYYTF/Ih5+AtjIJtYZqdnHdQ==
X-Received: by 2002:a05:6a00:69b7:b0:702:38ff:4a59 with SMTP id d2e1a72fcca58-70670e79d03mr16299352b3a.6.1719556649846;
        Thu, 27 Jun 2024 23:37:29 -0700 (PDT)
Received: from Ubuntu.. ([117.99.235.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70804a93ce7sm786003b3a.207.2024.06.27.23.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:37:29 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 08/11] t-reftable-record: add obj tests for reftable_record_is_deletion()
Date: Fri, 28 Jun 2024 11:49:38 +0530
Message-ID: <20240628063625.4092-9-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240628063625.4092-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240628063625.4092-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_record_is_deletion() is a function defined in
reftable/record.{c, h} that determines whether a record is of
type deletion or not. In the current testing setup, this function
is left untested for two of the four record types (obj, index).

Add tests for this function in the case of obj records.
Note that since obj records cannot be of type deletion, this function
must always return '0' when called on an obj record.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 8983d54bb3..f2422a7af0 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -384,6 +384,7 @@ static void test_reftable_obj_record_roundtrip(void)
 		int n, m;
 		uint8_t extra;
 
+		check(!reftable_record_is_deletion(&in));
 		test_copy(&in);
 		reftable_record_key(&in, &key);
 		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
-- 
2.45.2.404.g9eaef5822c

