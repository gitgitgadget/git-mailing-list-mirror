Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468CE1A8F7E
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733352271; cv=none; b=cgCFYj0JhFmxk/V/zzisWOxc/nvkGN+3jIxV3xSx7dn7Ng8FElrlRBcaLA8sh45pRKWbAm8pj2UX2pdRDzjWnxtEDvEU7IFpkWWecgkTRdeQOf6qEVB72va3ZeTJ8/XZ5D9Ca02xds9g5luDCaLyeUFMATOIcEgZi0pjx6UCt2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733352271; c=relaxed/simple;
	bh=GVOqrl0V+wczjATPQqqCyOY14srTs25yXnBuilhBtp8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=dga2DQ4cIS88+oGcMmj1ZnahyYjtssAcfh4CCg1raVoX4tvpKa5DedmJSeUTjXxN4Lkdb2fXLHsm5tYpcK+bMAC05FmVimEoBPzcLkHcxZrLs+FoRjle82/BAfMwUzAFCH6Bx1BJkNkYwuKHqv5CMiVMvdYyLKst0Q8X/DVMLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGzgHgvQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGzgHgvQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434ab938e37so2050965e9.0
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 14:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733352266; x=1733957066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW3X3iY7WYodMUjQ9uwLc/tBQKU/rrysrD2nOueHlOA=;
        b=AGzgHgvQP+KbCpQX4l4dVAsNnWD8bKJIL/5ESmaBjAij1rjqoz0ecTdrAecRV5Whke
         yD7AXqlQCzwM59E4C7jt/fys8y3QhWe2zfmXjZNULt297g5vrmpxiRSkRAie9/HYaqLM
         irPQiaZlHSWCFns6HAR3tkz0jcVjocxfqVOYmtVQw1KmHz2PIPWY6G6p8Zb4F+ZmcwGV
         g7buzOgQuf2gFc1Qpc+OLvSCuu2aAzkimL0iAD8wXlRLcQcCl3wvYMyZ3ejZtkWCo8AF
         t5qr1G1ibVEWPlirUOS198GvKQ6OONCeSpSsvGblIBIzZTuXciOogf8Pta7k8HGD/aef
         M0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733352266; x=1733957066;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pW3X3iY7WYodMUjQ9uwLc/tBQKU/rrysrD2nOueHlOA=;
        b=lq+Mc44HR7ya3AwX668rfin4Bt37N54b0Ylatp5V1aD+kq4+r79a40qA/ePQIH7lCe
         WqtITtGeyignGdatZH/qD7z2Q6v5m9I9pbJWJ37ho/OYEKhyFnIFjwNIdVrn73/pbT+Y
         secrpJa6eQOLW3lPEfe8JAuFRh8CzXbS88D9Gdi6Rk4OOu6Y+VQkiptpq/hls3FTyQU+
         T1Gt74Sv+0rqgQGYJieWW0iKdNT719FUqXvaECHxmIHxV3GTvfJo/+tAiy6GlAyEEYHU
         eoD5eSI2rOpIP5Dr8ThqHMOihUUvg/RRtf2JedIntz3w1ZFW1E5XteMgsFelOcPofJ13
         iXLQ==
X-Gm-Message-State: AOJu0YwhMRXTqyMyXb+b4cyVnA0bEGvxlZVaahQH2HnXXay3m23Nwz1o
	XQr49pPbEy+Jwg8zCw/kBpmgDlPAdt17mCzJY6uVpevv6EyeATbWzvwCPw==
X-Gm-Gg: ASbGnctJPFvkjIsxl9IwlLnFNJ6mjkIkYICpV1D6nSwmhrG1QKL+m7q3nax4UDPXhhF
	++ZAh3UcO/JB4d7LJe/pCeTDPQqR4cZzEOZ6UfKvbAB9l+J413LxFbwuv7vskeqTMbhhjPOTfxg
	Y6ogAZOwiaHYVJGSfcPZJAdvFTfM3o/zZWxorBS+n4J854Mq2VB03ykAyyXpZXxj72K/zimICx1
	KHgA2qkalZPdsV+tPOH6ae6I/3szfcOn/LocHz9
X-Google-Smtp-Source: AGHT+IE9s49Q+10aNEIXB1RTwq//2Tf9F4llJBvQmRos7ZcLCU2aifc9ajx2e8Kd+fGp2OwJvggxTw==
X-Received: by 2002:a05:600c:4fcd:b0:434:a968:89b5 with SMTP id 5b1f17b1804b1-434d3fa0485mr53765945e9.9.1733352266482;
        Wed, 04 Dec 2024 14:44:26 -0800 (PST)
Received: from gmail.com ([88.14.48.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d43a0df4sm35193955e9.1.2024.12.04.14.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 14:44:25 -0800 (PST)
Message-ID: <3c7b3c26-7501-4797-8afa-c7f7e9c46558@gmail.com>
Date: Wed, 4 Dec 2024 23:44:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] strvec: `strvec_splice()` to a statically initialized
 vector
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>, karthik nayak <karthik.188@gmail.com>
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
 <5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
Content-Language: en-US
In-Reply-To: <5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We use a singleton empty array to initialize a `struct strvec`;
similar to the empty string singleton we use to initialize a `struct
strbuf`.

Note that an empty strvec instance (with zero elements) does not
necessarily need to be an instance initialized with the singleton.
Let's refer to strvec instances initialized with the singleton as
"empty-singleton" instances.

    As a side note, this is the current `strvec_pop()`:

    void strvec_pop(struct strvec *array)
    {
    	if (!array->nr)
    		return;
    	free((char *)array->v[array->nr - 1]);
    	array->v[array->nr - 1] = NULL;
    	array->nr--;
    }

    So, with `strvec_pop()` an instance can become empty but it does
    not going to be the an "empty-singleton".

This "empty-singleton" circumstance requires us to be careful when
adding elements to instances.  Specifically, when adding the first
element:  when we detach the strvec instance from the singleton and
set the internal pointer in the instance to NULL.  After this point we
apply `realloc()` on the pointer.  We do this in
`strvec_push_nodup()`, for example.

The recently introduced `strvec_splice()` API is expected to be
normally used with non-empty strvec's.  However, it can also end up
being used with "empty-singleton" strvec's:

       struct strvec arr = STRVEC_INIT;
       int a = 0, b = 0;

       ... no modification to arr, a or b ...

       const char *rep[] = { "foo" };
       strvec_splice(&arr, a, b, rep, ARRAY_SIZE(rep));

So, we'll try to add elements to an "empty-singleton" strvec instance.

Avoid misapplying `realloc()` to the singleton in `strvec_splice()` by
adding a special case for strvec's initialized with the singleton.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

This iteration fixes a problem we saw when running with SANITIZE=leak.
Although it wasn't a leak.

We need to end the array because `realloc(NULL)` is not going to give
us that { NULL }.  I know it's something I considered at some point
because I thought about a change like `CALLOC_GROW()`.  Perhaps
another time.

 strvec.c              | 11 +++++++----
 t/unit-tests/strvec.c | 10 ++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/strvec.c b/strvec.c
index d1cf4e2496..62283fcef2 100644
--- a/strvec.c
+++ b/strvec.c
@@ -61,16 +61,19 @@ void strvec_splice(struct strvec *array, size_t idx, size_t len,
 {
 	if (idx + len > array->nr)
 		BUG("range outside of array boundary");
-	if (replacement_len > len)
+	if (replacement_len > len) {
+		if (array->v == empty_strvec)
+			array->v = NULL;
 		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
 			   array->alloc);
+		array->v[array->nr + (replacement_len - len) + 1] = NULL;
+	}
 	for (size_t i = 0; i < len; i++)
 		free((char *)array->v[idx + i]);
-	if (replacement_len != len) {
+	if ((replacement_len != len) && array->nr)
 		memmove(array->v + idx + replacement_len, array->v + idx + len,
 			(array->nr - idx - len + 1) * sizeof(char *));
-		array->nr += (replacement_len - len);
-	}
+	array->nr += replacement_len - len;
 	for (size_t i = 0; i < replacement_len; i++)
 		array->v[idx + i] = xstrdup(replacement[i]);
 }
diff --git a/t/unit-tests/strvec.c b/t/unit-tests/strvec.c
index 855b602337..e66b7bbfae 100644
--- a/t/unit-tests/strvec.c
+++ b/t/unit-tests/strvec.c
@@ -88,6 +88,16 @@ void test_strvec__pushv(void)
 	strvec_clear(&vec);
 }
 
+void test_strvec__splice_just_initialized_strvec(void)
+{
+	struct strvec vec = STRVEC_INIT;
+	const char *replacement[] = { "foo" };
+
+	strvec_splice(&vec, 0, 0, replacement, ARRAY_SIZE(replacement));
+	check_strvec(&vec, "foo", NULL);
+	strvec_clear(&vec);
+}
+
 void test_strvec__splice_with_same_size_replacement(void)
 {
 	struct strvec vec = STRVEC_INIT;

Interdiff against v2:
  diff --git a/strvec.c b/strvec.c
  index 087c020f5b..62283fcef2 100644
  --- a/strvec.c
  +++ b/strvec.c
  @@ -66,6 +66,7 @@ void strvec_splice(struct strvec *array, size_t idx, size_t len,
   			array->v = NULL;
   		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
   			   array->alloc);
  +		array->v[array->nr + (replacement_len - len) + 1] = NULL;
   	}
   	for (size_t i = 0; i < len; i++)
   		free((char *)array->v[idx + i]);
-- 
2.47.0.281.g735430a4cf
