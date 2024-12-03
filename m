Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F631F7594
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255268; cv=none; b=cuZK3DnJuB9w+ELdiIoXxMkUs1yX3mO+c/f0jKqogm+zVpfrwqa2FKmfLZrdWJTipXCtErejyElTeFyi96GwEGE8ZqCbl0VErXoC0nbON9AoSSfiy4KqJirwLzfDfWt1nhRGXsm3YDz5jg3ywXROcpP+8wnPbVsRXj+ZsO5oSF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255268; c=relaxed/simple;
	bh=iwh0SexTppxbr6tn3mG6JKbZMUIBtsNix6esMAqFewI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=o3GuLCLeNJ66GPnCNkiHqEWTXyChMr+BqedtIjw7S/1KLtSyPk4YKaH3eHu0Xe6vnMN6zLLRl10H1yeH0XpyRWng7iNggPeaiF+1VqFEu+Menzwe9QbV3WDj40rmSg3HHvVBeZ/Xb/f87ijW9ebB1DTx0jsq9Le9mrkflW5ktaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Emt5lM9o; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Emt5lM9o"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434ab114753so50457625e9.0
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 11:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733255265; x=1733860065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhnoLyyZb8reECb5jsnlv71CQTVlk8detnypq8Q8Xrk=;
        b=Emt5lM9oX3t5+iwbnNCnBUnh541CtzuHPrJxgRHK4xHX/2+Wk5cMzXAwVf/af8jYnd
         2x5mGYgoSSl/oPNZ5R6LVASrrGgySaP42i5addHnNckeoyrJHnE5Jzx9G2ASfa+4IOOf
         9iXSyVPyf+9CcYpVj2AHMnvrG6sSitgQahQlfK8ISdnAOfhLgiaOWkCtCZ60A7ft2H5t
         mstvDNHus9//cJugFXyOhF6bvQHTNXdSYBdadt8ApBjdOeJS5UINAih8kZ0CoJa2bC3a
         LN2nAgeygM27ROhUuyRwAOsrFJh4igSvxMgktT/t+W2+fY/eO1zUTvH4eTQHUG6ZjEE0
         l0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733255265; x=1733860065;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhnoLyyZb8reECb5jsnlv71CQTVlk8detnypq8Q8Xrk=;
        b=fok2WMsbTw3bp9EXt3uYWAtcFZ2d9bpAJopV6JoLRCL+t79kgS/hH9IDzZJoL+HSms
         iVwBDoK6gP4bmRoN8+98BzXgJMeN+4eYCj7BnYVwSCjh7sBYBMZgJgiwUNMx4/F4VmY0
         25+CMDsFydsgFXl/6OagnFqXduhejKVAiDd+IUd2esZ3rMTE8blIpeLVClz5Ipkhv1mF
         l9MrCFWImxNwDB7Jha+rapO/lSfD7rIyw/bp1CudGBn4zzByQVWpHPpIWnzVZuZ1+9sx
         cWl7DhFWWOLtXNYOmGbyosNQedgVNKWRAzynykz2kjkiyRCWaz4jXNnsIvCmkkLkOWal
         pl3w==
X-Gm-Message-State: AOJu0Ywvh01aKOOHiU0IhTKcRXNQNLCHsOOJ7iIWbi9wRvUywPvgOKlt
	9/Ggi/OQJLssXcWGFe9ofYfAluAvDcLNZiKyHV+D5jC8XwWQr+jhGgcWsw==
X-Gm-Gg: ASbGnctyoXUr3BQREg4h9mUf0Z4O+tT32x55mLU+UeG2N5zBmQjUSd+wo9fzy7v/BcZ
	DGYY+Rw8GPjMWOrP4S5L4OFtEqkwtqc8XqXV9woytuX9oS+OeceAAxRvG6/7d4YYQPGrRB+0EuS
	2BRTTSqqJyDG3+xq49BNCUYP5K8yfd9Wd45Ow7pFT6gcPEe52M6NU5bUJS3GqszVUTFQzEjZe1Q
	OFcIIMiRVkIS7XG6pxkind4Ud9OXwz3+6tnO8ZS359njCzS9swX+3XlS9ZTvCmpiNplWnOqOYfF
	EuyVEyVz
X-Google-Smtp-Source: AGHT+IFGK1zfbWLZPIvePJBLbOrB/yY16ykQXErY2S3mzU2+RGQMt2/bWLtdtRJgDKlI+HmAGj+0LQ==
X-Received: by 2002:a05:600c:3b1d:b0:431:44fe:fd9f with SMTP id 5b1f17b1804b1-434d0a0549dmr28701775e9.23.1733255264353;
        Tue, 03 Dec 2024 11:47:44 -0800 (PST)
Received: from gmail.com (34.red-88-14-200.dynamicip.rima-tde.net. [88.14.200.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74ea95sm231466165e9.5.2024.12.03.11.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 11:47:43 -0800 (PST)
Message-ID: <5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
Date: Tue, 3 Dec 2024 20:47:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] strvec: `strvec_splice()` to a statically initialized
 vector
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
Content-Language: en-US
In-Reply-To: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We use a singleton empty array to initialize a `struct strvec`,
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
element:  we detach the strvec instance from the singleton and set the
internal pointer in the instance to NULL.  After this point we apply
`realloc()` on the pointer.  We do this in `strvec_push_nodup()`, for
example.

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
adding a special case for "empty-singleton" strvec's.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

This iteration adds more detail to the message plus a minor change to
remove some unnecessary parentheses.

Junio: My message in the previous iteration was aimed at readers like
Patrick, who is also the author of `strvec_splice()`.  I certainly
assumed too much prior knowledge, which made the review unnecessarily
laborious.

Rereading what I wrote last night, perhaps the problem now is excess.
I hope not. In any case, here it is :-)

Thanks.

 strvec.c              | 10 ++++++----
 t/unit-tests/strvec.c | 10 ++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/strvec.c b/strvec.c
index d1cf4e2496..087c020f5b 100644
--- a/strvec.c
+++ b/strvec.c
@@ -61,16 +61,18 @@ void strvec_splice(struct strvec *array, size_t idx, size_t len,
 {
 	if (idx + len > array->nr)
 		BUG("range outside of array boundary");
-	if (replacement_len > len)
+	if (replacement_len > len) {
+		if (array->v == empty_strvec)
+			array->v = NULL;
 		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
 			   array->alloc);
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

Range-diff against v1:
1:  0b60fcc51a ! 1:  c1991e6f3c strvec: `strvec_splice()` to a statically initialized vector
    @@ Metadata
      ## Commit message ##
         strvec: `strvec_splice()` to a statically initialized vector
     
    -    Let's avoid an invalid pointer error in case a client of
    -    `strvec_splice()` ends up with something similar to:
    +    We use a singleton empty array to initialize a `struct strvec`;
    +    similar to the empty string singleton we use to initialize a `struct
    +    strbuf`.
    +
    +    Note that an empty strvec instance (with zero elements) does not
    +    necessarily need to be an instance initialized with the singleton.
    +    Let's refer to strvec instances initialized with the singleton as
    +    "empty-singleton" instances.
    +
    +        As a side note, this is the current `strvec_pop()`:
    +
    +        void strvec_pop(struct strvec *array)
    +        {
    +            if (!array->nr)
    +                    return;
    +            free((char *)array->v[array->nr - 1]);
    +            array->v[array->nr - 1] = NULL;
    +            array->nr--;
    +        }
    +
    +        So, with `strvec_pop()` an instance can become empty but it does
    +        not going to be the an "empty-singleton".
    +
    +    This "empty-singleton" circumstance requires us to be careful when
    +    adding elements to instances.  Specifically, when adding the first
    +    element:  when we detach the strvec instance from the singleton and
    +    set the internal pointer in the instance to NULL.  After this point we
    +    apply `realloc()` on the pointer.  We do this in
    +    `strvec_push_nodup()`, for example.
    +
    +    The recently introduced `strvec_splice()` API is expected to be
    +    normally used with non-empty strvec's.  However, it can also end up
    +    being used with "empty-singleton" strvec's:
     
                struct strvec arr = STRVEC_INIT;
    +           int a = 0, b = 0;
    +
    +           ... no modification to arr, a or b ...
    +
                const char *rep[] = { "foo" };
    +           strvec_splice(&arr, a, b, rep, ARRAY_SIZE(rep));
    +
    +    So, we'll try to add elements to an "empty-singleton" strvec instance.
     
    -           strvec_splice(&arr, 0, 0, rep, ARRAY_SIZE(rep));
    +    Avoid misapplying `realloc()` to the singleton in `strvec_splice()` by
    +    adding a special case for strvec's initialized with the singleton.
     
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
    @@ strvec.c: void strvec_splice(struct strvec *array, size_t idx, size_t len,
      			(array->nr - idx - len + 1) * sizeof(char *));
     -		array->nr += (replacement_len - len);
     -	}
    -+	array->nr += (replacement_len - len);
    ++	array->nr += replacement_len - len;
      	for (size_t i = 0; i < replacement_len; i++)
      		array->v[idx + i] = xstrdup(replacement[i]);
      }
-- 
2.47.0.281.g7eb946317c
