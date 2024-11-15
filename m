Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E961D0954
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678164; cv=none; b=ES9xsyUPU9K7Jo8BhZt9CYu3W9Pud1fjAGgtBCuXDq5tcplPG8v5xuLO+GDVcdAZcJFOGg1oyXRhGRCrrD6AYId0gFN8UeNvUS8yqBpz/uigJOXAPMOu0QRQp2+ROhjOUclCv8OrPkFSUbnOWVGczvbSKwacbcHpAyATfTZpSIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678164; c=relaxed/simple;
	bh=F1LO7al6imbCTLk9bZoU+6X9wqwrtpG6VcWrOeJG/d0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GsdzZJqX4Y4TiXHWeDManrXlNZwDxLIz3ePegsbopVB3YT6aXiMIDCCVpUrOHkSjDXoWtk+zSgWLs7b746mzC3jHvActy+0IlwsjJyejnKU4o1o48Di6jJPx5O2ojG3w2biNCPga4xvQwMMng4AsBqqJdbi945CSne4S1FX9fwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkKGPvq6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkKGPvq6"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso100053766b.3
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 05:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731678160; x=1732282960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ASwbRa9N0QXA1OfFmytAaSSMyis9H/tFdEaKHwmdO0=;
        b=JkKGPvq6GJqnMGF8g521uE7oQL2VIMHql1OunLmfa9wRb6+1WFZToXWptQLhqJFMCL
         rKqIWRXMu8ROd7/dLx6zMMllBfNeg+LACp/s6zzNcc9zk9Yfwjzabc018hPlWiLkQqpg
         1KHWeBMmigmxfIVhAGK9YwEH5uPKa9BWGi6F6HSVRGRuc5LTUB6JIJv7ybEblk54vfw8
         Q4ELStwX/2QG15TwfKTuxB+NCYFT9zt7UdXno7G8/MU5waVmFPOM65RQwH2xPdNGhmXL
         66WWj0nvqqaaLCJUxAHR4KyLc6tKiNbqAsZa0ZxEzUWaHJJkKINMUL9tw2IT2GWltoTH
         C2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678160; x=1732282960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ASwbRa9N0QXA1OfFmytAaSSMyis9H/tFdEaKHwmdO0=;
        b=wWQteX4qM9E3Q6kjmZPp9dQ2Ce7OBtODq0N4mBRjZHsPT9KrZk4MtnY8UiqmWWsY1I
         lk1YriZY2HkPtUyNJmb5sfaB1IAxHhzg+oGL8P73/3Vjh/2R6Q5HICht4TK6smVKBAME
         n5CrzBWRHWIEkdDn8a/x7bNPvYmOAIwiMnNFX8fLVKUUQuP/sCiGv6eP33NGj3mjWPUR
         GE/boYIwjKAAEN87duzKmYBRHR9e3tW16qUzlTDIIJBgGFKV/ATLiTQhH+JnvTRPlNl3
         r6f6pqiOzoBDuIiK3FaSGsQd2XqDQ9K3C8Mi4mVGoXihyzXOizmpunoEbvQaUy3gRTWJ
         y19A==
X-Gm-Message-State: AOJu0Ywg5yjarU+1V1RW35Y5AMzJhLO27uTJBvwIYzYPvpO32MjzBPoZ
	FxyW8jhWcpey9dICbcOq9tPZCDMFpouZWFf0NLyxwzsYAPapCj/c
X-Google-Smtp-Source: AGHT+IGXXzljMoDsXfJqvGTrk6yqWgp1DJz+DjRdkVL/uRYeardBSSLmQrdQ4ay2VSGIpc/H/oCMtg==
X-Received: by 2002:a17:907:2d0a:b0:a99:e82a:87ee with SMTP id a640c23a62f3a-aa48354d154mr271124866b.57.1731678160354;
        Fri, 15 Nov 2024 05:42:40 -0800 (PST)
Received: from [10.82.5.93] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26a69sm180753966b.34.2024.11.15.05.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:42:39 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 15 Nov 2024 14:42:21 +0100
Subject: [PATCH 8/8] midx: inline the `MIDX_MIN_SIZE` definition
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-8-761f8a2c7775@gmail.com>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, peff@peff.net
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=F1LO7al6imbCTLk9bZoU+6X9wqwrtpG6VcWrOeJG/d0=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnN0/Igl4uyjPN1S5aEQDCDZgnsgOh90WlxdRhZ
 pDcpoxCZZCJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzdPyAAKCRA+1Z8kjkaM
 fwEfDACH/rqmKS8oFR7/oQ1NfwFrA2hi0cHZ7lS/eI2R2sPhVk5rCjAaaVzyMe/8ASB1Oz7BRoi
 9HGHL+RZIDOwoIXp/ACxQK3mViaNRhQjhW8io5y7C/P/IR7DOYQ2v6mzcTt+XLXzqfCgK+T98VS
 iwt6+5cLqoNFoJWPajyJtJNdxT65kA9kIg7Us3VjkpTYuDhP/DcVF0masqqaQL7Rv8/Azb+RiEa
 OXzt/y0b7Qk9WkQlxtL8aD3gcVVDsO/KxEmQ7exsVK09BY0Y/Ixy2eE9kfG5VG1mXEwg12LjJgr
 t2P+N4cZvRwFgSo6iWT4I1oQWamwswGVNZi1JitbaapRP85bBzYX28RnvIETYzKMC1Epql/nn+n
 K1rjB+OiS7d8aslw9TrmYeQy4v4O19gGeZAU9nhFluYPXgQ2J8HINbEd5p8xDMzKoK48msGCD8J
 f7jDvJyPU9+i4OgejNsG1x+nk0JrIysVPJcDnd9qNvMNwubaCvi6r9OuwlC7cSEnBzrpk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `MIDX_MIN_SIZE` definition is used to check the midx_size in
`local_multi_pack_index_one`. This definitions relies on the
`the_hash_algo` global variable. Let's inline this and remove the global
variable usage.

With this, we can remove `USE_THE_REPOSITORY_VARIABLE` usage from
`midx.c`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/midx.c b/midx.c
index f45ea842cd6eda23d2eadc9deaae43839aef24c1..e0eae1c25ec91f7db5670ff9bacdf0e195c35795 100644
--- a/midx.c
+++ b/midx.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "config.h"
 #include "dir.h"
@@ -94,8 +92,6 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 	return 0;
 }
 
-#define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + the_hash_algo->rawsz)
-
 static struct multi_pack_index *load_multi_pack_index_one(struct repository *r,
 							  const char *object_dir,
 							  const char *midx_name,
@@ -122,7 +118,7 @@ static struct multi_pack_index *load_multi_pack_index_one(struct repository *r,
 
 	midx_size = xsize_t(st.st_size);
 
-	if (midx_size < MIDX_MIN_SIZE) {
+	if (midx_size < (MIDX_HEADER_SIZE + r->hash_algo->rawsz)) {
 		error(_("multi-pack-index file %s is too small"), midx_name);
 		goto cleanup_fail;
 	}

-- 
2.47.0

