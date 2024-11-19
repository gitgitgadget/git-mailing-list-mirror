Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F5B1D1E81
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030630; cv=none; b=Hlx5CHlp5Yc8v7gV/Ny4cXIVF3Y+ca3ogzg5fcsvhhc6bfLoYzlSSuX2No6PmpPjZtrFNQZlwX5cS9SEWz5/IoLYGOT/JurXnhxit7Ff3jfXa1xx3DWUPFlu1WcYeamrOtEtRMpQfQfjYYDxglNUaK8PnFizqQDAAzF+D0xNS/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030630; c=relaxed/simple;
	bh=ibmaTxuTE4m97YVIP84v9QXFINbELDmM9VNgsBQkB2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DnSueYhZjQbs/L1Ylg1EAX4ZU5o+mstok+mcG1wW8InMB7gScrAo023sJRDLISMLANgjrrTWzBNzp3H9S73XGhyvFv909BSok23SLurfnQDjgaAM6QjhgbRRIQw/WEl53pYU5dAT4EXHI7FBiUIrJFEEcWxHNTKr3JItlpD5K0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZKkXAvo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZKkXAvo"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so1258638a12.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732030627; x=1732635427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWZTAk5o0VG/+fgXNBcCRng07AR2WCFaM+PomdCWEsE=;
        b=YZKkXAvoQFhmnZlf7N+yjMsto6zH8Nav1cvSHT9sayhXqermWQmZmi47P0NghXZtI6
         SpYoYjsxATp2SEBb3wG+sOJgJb/fqKLzUvj09/5c4WXamW45pkeAFO3CC/HWCjTjPggR
         yewPlTpKBovQjFur3OhT8J91hoAVwGpTyI5a6EX50vzYXm+B+IQVy+TRhcaE1kAufn8I
         yQszby4NhVFoStxKx6gsvrwZT2v32RFw6fZzOki8IiF5fPbbYIsUlGPTC1uKS1Rhchsf
         RkFZSsVqujsAwYhDWYE+1jjPKnkLaBqVFO/9VVrx+7+3qoOPSef4319wMkdXPu7//9uo
         NiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030627; x=1732635427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWZTAk5o0VG/+fgXNBcCRng07AR2WCFaM+PomdCWEsE=;
        b=VqUhMfv/ODLk4rw/NhObxceDWb4wAG8Mo1f5snQyhQnDwPfsJvvEVZpIfuqbGHQzAa
         wGaGa4lW/PAzRGQ/ID6Z+9WN7kjndpZ6+Zd20ukRIodij+8CdNtoAyle+D21R4b9ROxd
         Yp3RXiWxR7JsboQGyP7MIyVbMm9VPkaf1XBCb5br1YEeAF6p2dxhYnHpnuYnUNIbBn0P
         ouMLzUWyQAQnQvTWJTU6JEJKgexk9IxEGjnOCXdND6+F61t44gq5pTGV6x6HXb0H+es/
         i/7bgemlR3kOD6FlY7+uO7ClfTO2YfrUxx8UzQSiRfgYoew9YyKUavGjjKVIFiyvOVv3
         zh2Q==
X-Gm-Message-State: AOJu0YwWnHCJE8+YyrYdJbLAF23iAgU0f0DNtXLFWP0uYcNhcQALgNEj
	KRkDerX08VXrQHckbW4m1KVUalHz5/V4MwgGWGTOKN8+GY8xjQMJ3GtkNDKT
X-Google-Smtp-Source: AGHT+IElFmG38O7kNHEDfu73gNHM+k/K/6P/B63iQFYPzVTfBK2+jct6VcsnPqVE/oYae0vRXSdCoA==
X-Received: by 2002:a17:907:7b88:b0:a99:ff2c:78fc with SMTP id a640c23a62f3a-aa483556b74mr1760350366b.57.1732030626667;
        Tue, 19 Nov 2024 07:37:06 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4e7bfsm661900566b.42.2024.11.19.07.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:37:06 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 19 Nov 2024 16:36:49 +0100
Subject: [PATCH v2 10/10] midx: inline the `MIDX_MIN_SIZE` definition
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-10-e2f607174efc@gmail.com>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, shejialuo@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ibmaTxuTE4m97YVIP84v9QXFINbELDmM9VNgsBQkB2E=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnPLCYxIgxs79BGzCbEKZJBq6d+19iYCj0MQhFF
 gX6uLMbsM2JAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzywmAAKCRA+1Z8kjkaM
 f8OcDAChSrEKRcwiY3VkNwWKrHz7fuCvw8ziAedpxQuB3sFMS/k4KUXnTjA+2ws8QLZmSoZnVZ8
 hL+BNglDK23RZyjjgR9M2y52l3j1kP7yQ8Ucak/Ksgn58exumNU4Oa7PXtnm+bl7gaPflRllAkf
 h6N8Mt8tE+GIgMED2spodItrXm6PwhQ9v/MLjYYpQnT2cf7KhXYkMCcYXDNcVFDqP5ZfPdnGdq4
 4dPQMQI6gU6t8WdRN7i9GJ+KjEskrTHMF1MZQIpj8u0pVg9vY8F+eqjA05lRm5fBeogQg6/JzaQ
 CNRDDPa1sKG8XnaxYNX9kqO0gW05ylqlT2yQ+6q9E1tTy+zQ/bqZMmhwdmmNbKAbPJPSBS1X7BO
 uus2OKf9tWTsHym7kiytSxfE/Rw2w1h+PnFp+fQzfsJyM/wP2UMCGmczzpOdAIQgBznpwqHxLFO
 PqWGQmeKkW2C1eGDdyCaEOGSfh7taNHM0WFkiyeuEKloirD2f2Ers4oyKJcvvgE+GbuPE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `MIDX_MIN_SIZE` definition is used to check the midx_size in
`local_multi_pack_index_one`. This definitions relies on the
`the_hash_algo` global variable. Inline this and remove the global
variable usage.

With this, remove `USE_THE_REPOSITORY_VARIABLE` usage from `midx.c`.

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

