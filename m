Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBF931D725
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155529; cv=none; b=kiyOCZZufmAqQXGTprLBcstC9kzfJlFPHKmuktqvJk4GFPgSfaAECSUVW9HAMXPOIfZsVO4lOLh6v7fzsWZlNbS3aT46B+Fwb62as4On4FBXB6m1aN+u7yJWZ/Otxgd7YzbxBMESwtyRzuGn9bkTvJOMraXPVEAReTnBrlkBZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155529; c=relaxed/simple;
	bh=WIxNZ7GGRNrJ9UlqA3RqLppeKSghXC+okMwrsA05lDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P9krs+kYULUJgrpuQGlC/Nq9XIn4KcIMnGFjmADWsQ8s1V7LNncTFpfFZI3qoKb5jFqT4OFOezWF9+6P3vxxAte7cSUJqzcmkmjIbKT4B3lRiAZPCQIsPlXJJTZX3ui7s36O1mhzsiqfW1Hj4bhVfKAaUJrHl6ufUHvxuZ65+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKBr+RMo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKBr+RMo"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b739ef3f739so613553166b.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 03:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764155525; x=1764760325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUEIiucLLAgj5KEN47cu77FlcE3S6DjH7KS/U66tBwc=;
        b=jKBr+RMot8IkzyxSfmXVJ+vuCq3d18TBxa3gSbersjRCJpMwWLE21qMtu38lEe3uqG
         RZI5ds6ntC6Re59pmEanDdEqcb2I4YdFvV914iai+BUh7i0J+7DJHQkAMkEFCf5O4JO7
         Zd9H+QY8Wnlk+x/fLEYeCkFOxlMCW3NklQ7yEvrKUle+3Yt4qj6NOOt4DvEkW/wr64/A
         lYOBsg2RiU83Jsqx9IGwCVta32dxJNoZw2DI2OMujyFG2saqRAsUZ/UDgA10ChbGyl2/
         tw3jPS+KI44JnS95OP5btT6P0RA8enWEfrXeUuTkW8AGvXCxuhSaLenyrrh6dwYLCO+L
         vxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764155525; x=1764760325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LUEIiucLLAgj5KEN47cu77FlcE3S6DjH7KS/U66tBwc=;
        b=qaA7p/AKsUfJfVKMnqZV+f8lJULoxJa5NGvxgzyI4kP5H2v1dqjaUM5m2vMgFcOBgO
         8oMrpWSBI/QOxg6NxkRvSEZ6YrfKc5Fq+Aq/Me44IKTkirMQuzeL/ng7bU432NWvA/oM
         BLvnlREyh5Atwcjy2XAzQ1DWwT39rPJDeIuY790Un8OJeX+RxkOBiT+L0SMU0zqdTVq1
         yeSSb32U3cVXnsuWJzdvr3HlXmM3z4Jle2d+FL+s8XCc4gRFf+AYgsJ84bAEFWWUwRs7
         Xypz7k3t3RPYsekqAkwBBW9YeO7NP4y7OfHF943px4ntwogo1vO5po7ToJx66by5X+Hi
         95JA==
X-Gm-Message-State: AOJu0YwJYEQH1L86mKlExcQwXa7BfdlLjdqsPvCftzC1T+69evPpPU4W
	OLYMcPogVOE6wCeuwhfPVQNYJC9qndLCBXO9JP0dqGZFKA9vKCY32UMl
X-Gm-Gg: ASbGncshljlGeIr26DfIbx/OqpfSKmS6kLfMOMsleqCfrooBCieaL0VWSjAD56kU9RD
	3c95muzta7BrV+nm9GpAUcbkkMSDknYGujgT48POrFsXzmjIQVN0F/XkInMqPY6n/FUqThb4Z8m
	QQkkfud0iNc6I9sCU9OnfAHfTcs9xoNfPUh73k27hEgBS7i192kYIG08l7bxw3Fw79X86cU9LqL
	Iv5TxYx+H8HFKkboCb285YUKgIIzBbgzyu2FUebRApOV5M5xP0s2/Y7tFR7CVyaJIVA7ogF76Vl
	7JaVJYtYQtBqE5ABF0xXTAb4JBsJJXbP3M5XUZJSkq5M9nBW9PIHXMUDt/Dwwi0orCxVhq8vAQR
	oYrBj719B6UtfvEoOph7hyJKYxOYGhirNaYbj6n2MZD3uglBpwXh75gGraddxwqPxnvqOqeOmU6
	d/KqvCMjz2Qc01hIRn9Q==
X-Google-Smtp-Source: AGHT+IFSZKGjibb31jP4Ud9R2n61WZ5B+DSHifuvhPX8O7xmHVTAlOXqLGFiddNx2svJPMcn/2MoPg==
X-Received: by 2002:a17:907:7f10:b0:b76:23b0:7d89 with SMTP id a640c23a62f3a-b76c54b9c79mr680621266b.14.1764155524908;
        Wed, 26 Nov 2025 03:12:04 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:e97b:ea4a:70d1:4f56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d54cf2sm1835186866b.18.2025.11.26.03.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 03:12:04 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 26 Nov 2025 12:12:00 +0100
Subject: [PATCH v2 1/2] refs: support obtaining ref_store for given dir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-kn-alternate-ref-dir-v2-1-8b9f6f18f635@gmail.com>
References: <20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com>
In-Reply-To: <20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
 gitster@pobox.com, toon@iotcl.com, sunshine@sunshineco.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=WIxNZ7GGRNrJ9UlqA3RqLppeKSghXC+okMwrsA05lDc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkm4IMQc2L6cpsYHnw0IDfq7GqhbDXuUfk4I
 Jh2HVlS55+oRYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpJuCDAAoJED7VnySO
 Rox/LFML/1hy6tPqmrSQvIJhaGahGOhCDvjPUlyvoA7cul0dLatPoBYOx5LzdO40C+FJ06Npfo2
 WIaUdQWSWSfxCNp1JX0aCfxiRFFdYIg4YgNuI8Ze6uMA/wyAWLwkukgy3S+xvaGX35kLJEWYwIc
 N6VvZy5E+ypfKvnlom8uPgaY7N1pApsTHRkG4FuOIt85tkf3YIho50atFb9bBIp4RAv7UpmSfIM
 Zbz0fbI7Wkw7FVc28fIKJ4EphiZxJaYkbcgGy70VbAQmulNOUcCRcOEW+M/o4RqwWoA0dSd5ubg
 DLVDgpz4Nydk5CXShejcTmsVLjQahlhzb8ReCFQvGE8/9wMDBfzUxs93e/SF1nPcBF509AKzHsC
 WPNju65M+qqdDSepESwtI1jq4lVa+KP9Zt72Xa31VrydBFL/fC7+2KK6MCbT+k2ZoFxFRlreT3u
 xffFq+dIP0ukgoVm4wuLIBqzGpPNpnWuGnkk5QWPM9jSWPu54VFLn0Dg3dwvcEqkEk+oc1bfU55
 yc=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The refs subsystem uses the `get_main_ref_store()` to obtain the main
ref_store for a given repository. In the upcoming patches we also want
to create a ref_store for any given reference directory, which may exist
in arbitrary paths. For the files backend and the reftable backend, the
reference directory is generally the $GIT_DIR.

To support such behavior, extract out the core logic for creating out
the ref_store from `get_main_ref_store()` into a new function
`get_ref_store_for_dir()` which can provide the ref_store for a
given (repository, directory, reference format) combination.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 965381367e..23f46867f2 100644
--- a/refs.c
+++ b/refs.c
@@ -2177,6 +2177,15 @@ void ref_store_release(struct ref_store *ref_store)
 	free(ref_store->gitdir);
 }
 
+static struct ref_store *get_ref_store_for_dir(struct repository *r,
+					       char *dir,
+					       enum ref_storage_format format)
+{
+	struct ref_store *ref_store = ref_store_init(r, format, dir,
+						     REF_STORE_ALL_CAPS);
+	return maybe_debug_wrap_ref_store(dir, ref_store);
+}
+
 struct ref_store *get_main_ref_store(struct repository *r)
 {
 	if (r->refs_private)
@@ -2185,9 +2194,7 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = ref_store_init(r, r->ref_storage_format,
-					 r->gitdir, REF_STORE_ALL_CAPS);
-	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
+	r->refs_private = get_ref_store_for_dir(r, r->gitdir, r->ref_storage_format);
 	return r->refs_private;
 }
 

-- 
2.51.2

