Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB22F5A25
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588940; cv=none; b=H2biqBcKlZGBS70DqicrEQA4gyjejcLYF1RHs+oMy70LVXAXUe117uEJw+p0WKBo5MSR9HktwwdEqLrM9DFdOmEiSL+3wEDo0gi1Syled4ddUVZHkZ9Bk7JSqKGQCe+YxPyYYhsncwrvK9+WwBIhMWuMbivcbwm9UikVsgBkQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588940; c=relaxed/simple;
	bh=n7JCE55H/1m7ygcIGGtvDRTAtv08TkCf+Ou58Ha1tZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o6rgUTZbXjlZSgp7mzv4QFOE2cgFxfThPfjh/u3/LaWOpQMR9447PqhgqhNfBsIMb57OR0tJyuIPoRXcwIWc6JxDLUjI2KQCHeshQO477KwujsbyxDhyrBC0DGlcmNdXp5XaNiWgPWbc3bCFOlDf4SSnabUrY4H9GfAHWy27g0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQEdajnx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQEdajnx"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so321483a12.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 13:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763588937; x=1764193737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTdJD7nFP6kzqeqLBqT+8iPm8ISKMTBDPo1SXXL6+p0=;
        b=PQEdajnx3wcZQy+xaZYK8+sF4sHTu8dRJfLnQPF3Loy2fO5gnfZuYMs8snjltqo0oh
         x3hKaN/1nTBoYnykMHRJ01X174DBBQzDuipATGOo7GI0r4T/Waj2ohqRd8QWLqsALvJt
         GL7Aq7AFMbc8SXcOhvh8vwR+guFCm1GfEQnJhG9hcUDDFu/9gllgFHcCHydbWu10WAC3
         R9EBcsBUN8dUWUGFzOM0XwrJI4rlcf4ad0EVc3KycBmn/A5U8gJ/rpQRrnmuiQwHjmYL
         osWQrKjGCHYpvkObDkFkvYtG7yP+O96DqZjnJUSjEDcH/QUEjLjggKPji4vla2qiIoOH
         SHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763588937; x=1764193737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LTdJD7nFP6kzqeqLBqT+8iPm8ISKMTBDPo1SXXL6+p0=;
        b=XvgMz7wskLdw2UMU5i6p+ILQk4i2sARvsucZS7gc1BCp7v5Bc2gu4HxWz2iu48RfLJ
         Z3ojeJ3nDSw5M70YX2jkpjuYAfcbdMT59JpsfxAxZhXmmlRwtcVZ2z+W/aIB/sUPOAAO
         xFDAITaG103f2FitLvnfhin7cXoy6yqSHT/UgSEsYlrqcRP2pqwmWwke4wkll+M6oKIW
         haqpNSUxY8yxbiaUYqbdUMFv0ES8b/b+yvoPcmhdF2RPoCf405Mceh8kSiIYP+kz+Fiq
         iO3cf9kFQlvEKfiyoiqOcx/LUxjYxV8z62dAfgPj8lQ51VQ3gU3M8sEqB3Hu1Sts9BJ3
         9mZw==
X-Gm-Message-State: AOJu0Yz0uLOdaSwYDg2r0aed0lTwcKXhzZTXx0Jx1tLmxCF8aCIZWwB7
	Ji27Luyr8TBdylaT/kqxGHu/o766sRDCXQXh3NnGzJhuSVAvarLbSeYIsCXBBw==
X-Gm-Gg: ASbGncsShgBpGQ2yCx8ydmnbIrh3lafpNFknYQvQa67xlH/j0jSylp39RpyvlVqOgkH
	e5llHnArBn04kcVLLofH5b9sG2H3dXaCDiO9hjQYAfrpmMuG5Y40OU7Dbr0bT1YPqF5NqDF9iuJ
	1VH3GVOFMyCmzdTMiOGQuyKrJj+cSecrmFnMfMUc6y5Kkkmgd2YsgOWT3zNB0ifVZwaJEIBJIKu
	RCcoRglIZ84w1wGC7frgc64buKUCn/p7qSHZ+Tvc6MFvH2tJodS9XyiHgMtS7FPqGP3zHkG0a48
	qAZvIItfohd3LkohCukNOrsYaL73QJKSU/M5SaMXEuXvzHdZfcKARb/0pVOh6xJFx/HHk212ltL
	fddX9w+62KncE4YDSTunyKwb92PQoZzlt9jMFT7YtCMseYH/Z3j2Yf7wDEpifO0NDhZTBni/ohY
	2pDcGOCFbwcyIk5OI=
X-Google-Smtp-Source: AGHT+IFW1ISk3ZdpoGmpwFwoHSDKdli21Wsf9rfJFhz8ImSbtqfTKiVtEhcpgC3TNQbcNfvZNQSsYA==
X-Received: by 2002:a05:6402:2743:b0:641:5502:c8e0 with SMTP id 4fb4d7f45d1cf-6453821330bmr182947a12.20.1763588937089;
        Wed, 19 Nov 2025 13:48:57 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:119:a01c:1871:c4bb:6fef:656d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d307sm528090a12.19.2025.11.19.13.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 13:48:56 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 19 Nov 2025 22:48:52 +0100
Subject: [PATCH 1/2] refs: support obtaining ref_store for given dir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-kn-alternate-ref-dir-v1-1-4cf4a94c8bed@gmail.com>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=n7JCE55H/1m7ygcIGGtvDRTAtv08TkCf+Ou58Ha1tZc=;
 b=owJ4nAHsARP+kA0DAAoBPtWfJI5GjH8ByyZiAGkeO0angOLNjl8ydWZmlIGJFCJ3b2nEW6X/Q
 HMY7A7lH1ZlzYkBsgQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpHjtGAAoJED7VnySO
 Rox/h9gL933OhVJJ/yrYXijl+AskJKuzTG9puPQZLX6GJG9D3ls17Dk1mgImePl7c9OTLFCN1IF
 sBWffm1nAwkaNWc4134uQJfXQ31EGfZNjgs3mI5hOb7iRyZk42yUQLD6LDrr9TXJE+kMbmeVQXm
 bYAwNFQPCwXvzs3/ihCs5KvDz705BbWFx1xxjCt/3aXz4o+elhB02p9dSmcaZmx4QBpDymu8Sx4
 /Uql7ofLTFNVIRJhXu5+6UdURkzKNBep2U56evKmyyXbbrtzB6Gg82TsK4suGVU3CE7EPVjsgXp
 x9vAQJvVjgPq1ov5QmuHm10TLE5RwEQE7tn9yRAo9VNXReqiOPcm0n1uLNcoMKppQjo58uvSbf7
 +BFMh6tCot5s6OLXyt8BoTM7FZl63J2QpV3sr20Wu8aLVuOgY+ibmNCPKT2cgNNxV6MNObMqW5u
 2hpOPFDSbLV6PGRRLo7pFCrW27Aap4LOwdvCseG9blJD8XA+p362Kv48xM3f8VRZ+hQsds0ODty
 Q==
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The refs subsystem uses the `get_main_ref_store()` to obtain the main
ref_store for a given repository. In the upcoming patches we also want
to create a ref_store for any given reference directory, which may exist
in arbitrary paths. To support such behavior, extract out the core logic
for creating out the ref_store from `get_main_ref_store()` into a new
function `get_ref_store_for_dir()` which can provide the ref_store for a
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

