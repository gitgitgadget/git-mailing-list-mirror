Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DFB7BAFF
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040220; cv=none; b=dIT1kfaA9nJ58zJUBMji2pIxj+9xXbNj81FQAga9z02ab+naYGdsZjzZZ9WnGRo/33KJE8EgzI+Saq9OOiTqN9CEIaU6hGO+MdnYrBmtSoe6Bqyl60A/utNRR+jQ/nsHu9PRdeRrsPgW++PXpN6xaduzhy54lc6qf8Pip1La3ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040220; c=relaxed/simple;
	bh=W7USWDooWkcEvUhlGe44fC9J7Hisd3kdMpQXKM6JAOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDIvzUKQIN5Uo1JB/wmgU+FFt7PLgME0jrta62v7h2DQfHnNrxKlp62r/PZ4MioLJNGBl6Aglab45QGiTikaUO+cvlUf9yJXVMwxgQB/b4ATCtcXpaDySFvHjIp7MGn7Ub9R6LFVCMrXknxB/fM1QD/wv4sqfUSrqHT0PYXb6JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNXV0LZi; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNXV0LZi"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb5e0b020eso1407089a91.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723040218; x=1723645018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7OgYFBtkBdCtX7syiausLF4DmD8poKJ5EHK6kAOs/8=;
        b=RNXV0LZidZ7aZVUz1pd9QJ98/gEJwvNDXNLhOgOZODGdw2HkzO3ktLOunh4pgZl45E
         f9OxVQwihSpU1VdDG9lI/fU7+Fb5F7lxYyg14Co+Rrw2NReHvJaR5j3cXq8bkeRmAgUz
         Haqn70IhE5W3sZhxIUuVRXSKDemFpf7l0ocA8fB0H2khuVpzCQYXnoCOWFmFB3/+kqlf
         yr/Bf4/+wj5ogAoMIoKRAAJ0PCvJoo3uZFdll8KREqbIOKgwwEVXhzNSzOzKRKeo29am
         028sH5lpn6SBOM7JFEYYwSMFyMgc3AekE13ohLOshxI7UA1WKHlEJ+LSDZeCEq0Y+B6D
         IzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723040218; x=1723645018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7OgYFBtkBdCtX7syiausLF4DmD8poKJ5EHK6kAOs/8=;
        b=qDHLBx+pFWZO0rOeYnFHx6xTkZKo4JX3iZT5hk+lvMuhptVQEHRr8XNGpDhWTWaXv9
         bAslEyIx2TbCZmtPJ19lyNNjAK1OvRtKmAR31to9p1O7NU3GjSlLWrd7XGZQO3FsfOJP
         N48VHqMmMQdfaSFXtqN2YqXzGO3vbCgO9D+1GtpdBWti04MGSHxllcTaKdtYe5JLdU+z
         WV6AlyMobmYCE7h7gextB0XuZVDm1UaQDH+ycDmVMJH8ooBRGEEO9dsyAFw5kNPcK5xO
         yZz9/uyfFUff1IAbRmEQ8McRJt3bk6jfz96x+y7EjPZid43GEOUxU7S/8xYgXusW6igr
         U94w==
X-Gm-Message-State: AOJu0YweK1NoEE5ptINdnG1FY3Eu42iGYa2MxlhIWhyv2STKt2XZD1T9
	qx7niT7x+6VEbOFs6eVYLYKjccJLeGqwOlmwCQneI17sWMODyiZRS21vB3f7
X-Google-Smtp-Source: AGHT+IHx/2KfrA1DsOOgDyum/YEkft1Php/BgrkGXVcVoWLpcxqXBfzMXSwE+OEMfmkALpchGEBkUA==
X-Received: by 2002:a17:90b:30d5:b0:2c9:9f2a:2b20 with SMTP id 98e67ed59e1d1-2cff9488090mr22705804a91.22.1723040217799;
        Wed, 07 Aug 2024 07:16:57 -0700 (PDT)
Received: from Ubuntu.. ([106.205.252.196])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d1b374b3cesm1635059a91.48.2024.08.07.07.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:16:57 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/5] t-reftable-readwrite: use free_names() instead of a for loop
Date: Wed,  7 Aug 2024 19:41:58 +0530
Message-ID: <20240807141608.4524-3-chandrapratap3519@gmail.com>
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

free_names() as defined by reftable/basics.{c,h} frees a NULL
terminated array of malloced strings along with the array itself.
Use this function instead of a for loop to free such an array.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-readwrite.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 235e3d94c7..e90f2bf9de 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -413,7 +413,6 @@ static void t_table_read_api(void)
 	struct reftable_reader rd = { 0 };
 	struct reftable_block_source source = { 0 };
 	int err;
-	int i;
 	struct reftable_log_record log = { 0 };
 	struct reftable_iterator it = { 0 };
 
@@ -432,10 +431,8 @@ static void t_table_read_api(void)
 	check_int(err, ==, REFTABLE_API_ERROR);
 
 	strbuf_release(&buf);
-	for (i = 0; i < N; i++)
-		reftable_free(names[i]);
+	free_names(names);
 	reftable_iterator_destroy(&it);
-	reftable_free(names);
 	reader_close(&rd);
 	strbuf_release(&buf);
 }
@@ -498,9 +495,7 @@ static void t_table_read_write_seek(int index, int hash_id)
 	reftable_iterator_destroy(&it);
 
 	strbuf_release(&buf);
-	for (i = 0; i < N; i++)
-		reftable_free(names[i]);
-	reftable_free(names);
+	free_names(names);
 	reader_close(&rd);
 }
 
-- 
2.45.GIT

