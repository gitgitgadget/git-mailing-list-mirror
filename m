Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BED193078
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619763; cv=none; b=G1iXDIW7qKBIqXLIdfUePQ9Rk6AAQzY2MFSZM8DsZBkcYPSaw9MvTAlq9BqF6upqwCIVnf1pPEkXAIqpDbcTYgWpz+STGRviFb5mIOMABtRye28HI+n68G0db7uiimz6VCzqaU7DhxJni/Vu3ccBvxhQ0HQTDGhW/2QM1taqOXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619763; c=relaxed/simple;
	bh=Vu9LiJqw2Sj8E+COvnQ11zLEBbrWcwGjbujFDvM9Iro=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=qlbDMfScmZojVy4TIjgLFFPo4YYFqUpfwRTY4lRY3FnCnh6M6YVZy8tTk64Y4dwjKLmDv8GVn2Yx6ucE3r/DJYDw0hUpRsiThowNqPIzcY9NWK3BsjNsSq0fyS9fk7RJqouud6lCuXPWRoe1KNcoCT6/6yw91m9gqt1IobcdOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9RqAq7U; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9RqAq7U"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266fd39527so16400695e9.1
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720619760; x=1721224560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WWEB4pehH4l1Y4FVFpVUTJxteC4vgDSmmatJUvQNJ9M=;
        b=l9RqAq7Ub0Z51FAfJsdcR2jqQCUrZVrM3z+jZdd3K16tfD1LSEUm1coiAtHS79va4X
         FnwNUG+c2nHSCmpL2s3a54WE1S5NoM3pqTwwWCust/BNNpZ6TtSdSDHhdAmPAbdjz4D3
         hGHGXS3NUlXwv07sI6A4M6H+jVXuz0tRlzZSa7m7JQtJaO0kr/qRIyNQEfQzGb+2s30S
         8Z/R4gM0XkJtbaw7FIY1zN06Qpze/FZwOjp/wJD1ce0wRgyJOnQq7Y0GVNvjAWyiCh9G
         J2VXHYCYCOq08r+y+mSXbhVvQkurtfqkp/2FgiSioQPLqByJCPKBYerd/lqQ0ayx6j6t
         F4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619760; x=1721224560;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWEB4pehH4l1Y4FVFpVUTJxteC4vgDSmmatJUvQNJ9M=;
        b=mInyFH72OrCgUuNOVzQLsOfEBQHQ7MG5f1NB+hP5sXm4pb+XrjqDO7rwHGkvwmyZIw
         2CctHXh8I6VQxJzeGeHAwNwIaasxuY3eyiglC5CMKBLP9m6nE2789B6CjpzAhdQtyEpr
         NPq1gnWOLXx0IhuflR5ftbCx6cWWX9Ir787K+gsXXUoomzcCt4+/IkUvJUHqDETsTlwk
         xcJs98u5g/mzxArtcUs/gjP1SDQ0ExZl4UZYpCBCkPOjXh3Dv3MeirpNSJ1XMtxCDt0w
         T4tNoM3+gzEK8LjkZJCXY5P5gt4wXLgkgFuqOodSA8t/KxHPWr1x5g4P5h68ngSTiv+U
         vSHA==
X-Forwarded-Encrypted: i=1; AJvYcCWIDHwSlA3EvXjuYRMFZczekYUtpvECpmFTYF5kQMzQ2N3z00n+XRPjipynjpOPZQk3d1moaybSSWGpAJzeEqpv262k
X-Gm-Message-State: AOJu0YwE5alP11ILNoPg3vdo85b7tYmoGrHRxWkewue8a/Et9hTlWTrJ
	j6/pLscVXlN/UjJ93jKqFKSKnfYE9obGwavnuARuLhQVJtgj2SvT
X-Google-Smtp-Source: AGHT+IE5la/5lD0Pj6Jfod01Y88mZLHb9sFkGGeFGPXZzaVR81wIyBZDkCD9jrM0nUKHBYrZkA0q1w==
X-Received: by 2002:adf:e412:0:b0:367:9bc8:8c0a with SMTP id ffacd0b85a97d-367cead844bmr3493899f8f.64.1720619759588;
        Wed, 10 Jul 2024 06:55:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42797ba4acesm2641065e9.19.2024.07.10.06.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 06:55:59 -0700 (PDT)
Message-ID: <35f828d3-6d3d-4b86-b6bb-a35753d91b9b@gmail.com>
Date: Wed, 10 Jul 2024 14:55:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/6] t-strbuf: use TEST_RUN
From: Phillip Wood <phillip.wood123@gmail.com>
To: Josh Steadmon <steadmon@google.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Git List <git@vger.kernel.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>
 <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
 <d768f700-654a-4030-bd45-e8e3dea351b5@gmail.com>
Content-Language: en-US
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
In-Reply-To: <d768f700-654a-4030-bd45-e8e3dea351b5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/07/2024 16:14, phillip.wood123@gmail.com wrote:
> Getting rid of the untyped test arguments is 
> definitely a benefit of this approach.

That got me thinking how we might make type-safe setup()
functions. The diff below shows how we could define a macro to
generate the functions. DEFINE_SETUP_FN(char, ch) defines setup_ch()
that takes a test function and a char that is passed to the test with
the initialized strbuf. I'm not sure that's the way we want to go for
this test file but I thought I'd post it in case it is useful for
future tests.

Best Wishes

Phillip

---- >8 ----
diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
index 6027dafef70..8fc9a8b38df 100644
--- a/t/unit-tests/t-strbuf.c
+++ b/t/unit-tests/t-strbuf.c
@@ -1,27 +1,60 @@
  #include "test-lib.h"
  #include "strbuf.h"
  
-/* wrapper that supplies tests with an empty, initialized strbuf */
-static void setup(void (*f)(struct strbuf*, const void*),
-		  const void *data)
-{
-	struct strbuf buf = STRBUF_INIT;
-
-	f(&buf, data);
-	strbuf_release(&buf);
-	check_uint(buf.len, ==, 0);
-	check_uint(buf.alloc, ==, 0);
-}
-
-/* wrapper that supplies tests with a populated, initialized strbuf */
-static void setup_populated(void (*f)(struct strbuf*, const void*),
-			    const char *init_str, const void *data)
-{
-	struct strbuf buf = STRBUF_INIT;
-
-	strbuf_addstr(&buf, init_str);
-	check_uint(buf.len, ==, strlen(init_str));
-	f(&buf, data);
+/*
+ * Define a type safe wrapper function that supplies test functions
+ * with an initialized strbuf populated with an optional string and
+ * some data and then frees the strbuf when the test function
+ * returns. For example given the test function
+ *
+ *      t_foo(struct strbuf *buf, struct foo *data)
+ *
+ * the type safe wrapper function
+ *
+ *     setup_foo(void(*)(struct strbuf*, const struct foo*),
+ *     		 const char *init_str, const struct foo*)
+ *
+ * can be defined with
+ *
+ *     DEFINE_SETUP_FN(const struct foo*, foo)
+ *
+ * and used to run t_foo() with
+ *
+ *     TEST(setup_foo(t_foo, "initial string", &my_foo), "test foo");
+ */
+#define DEFINE_SETUP_FN(type, suffix) \
+	static void marshal_##suffix(void(*test_fn)(void),		     \
+				      struct strbuf *buf, const void *ctx)   \
+	{								     \
+		type data = *(type *)ctx;				     \
+		((void(*)(struct strbuf*, type)) test_fn)(buf, data);	     \
+	}								     \
+									     \
+	static void setup_##suffix(void(*test_fn)(struct strbuf*, type),     \
+				   const char *init_str, type data)	     \
+	{								     \
+		void *ctx = &data;					     \
+		do_setup(init_str, (void(*)(void)) test_fn, ctx,	     \
+			 marshal_##suffix);				     \
+	}
+
+/*
+ * Helper function for DEFINE_SETUP_FN() that initializes the strbuf,
+ * calls the test function and releases the strbuf
+ */
+static void do_setup(const char* init_str, void(*f)(void), const void *ctx,
+		     void(*marshal)(void(*)(void), struct strbuf*, const void*))
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (init_str) {
+		strbuf_addstr(&buf, init_str);
+		if (!check_uint(buf.len, ==, strlen(init_str))) {
+			strbuf_release(&buf);
+			return;
+		}
+	}
+	marshal(f, &buf, ctx);
  	strbuf_release(&buf);
  	check_uint(buf.len, ==, 0);
  	check_uint(buf.alloc, ==, 0);
@@ -66,10 +99,9 @@ static void t_dynamic_init(void)
  	strbuf_release(&buf);
  }
  
-static void t_addch(struct strbuf *buf, const void *data)
+DEFINE_SETUP_FN(char, ch)
+static void t_addch(struct strbuf *buf, char ch)
  {
-	const char *p_ch = data;
-	const char ch = *p_ch;
  	size_t orig_alloc = buf->alloc;
  	size_t orig_len = buf->len;
  
@@ -85,9 +117,9 @@ static void t_addch(struct strbuf *buf, const void *data)
  	check_char(buf->buf[buf->len], ==, '\0');
  }
  
-static void t_addstr(struct strbuf *buf, const void *data)
+DEFINE_SETUP_FN(const char*, str)
+static void t_addstr(struct strbuf *buf, const char *text)
  {
-	const char *text = data;
  	size_t len = strlen(text);
  	size_t orig_alloc = buf->alloc;
  	size_t orig_len = buf->len;
@@ -110,12 +142,12 @@ int cmd_main(int argc, const char **argv)
  	if (!TEST(t_static_init(), "static initialization works"))
  		test_skip_all("STRBUF_INIT is broken");
  	TEST(t_dynamic_init(), "dynamic initialization works");
-	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
-	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
-	TEST(setup_populated(t_addch, "initial value", "a"),
+	TEST(setup_ch(t_addch, NULL, 'a'), "strbuf_addch adds char");
+	TEST(setup_ch(t_addch, NULL, '\0'), "strbuf_addch adds NUL char");
+	TEST(setup_ch(t_addch, "initial value", 'a'),
  	     "strbuf_addch appends to initial value");
-	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
-	TEST(setup_populated(t_addstr, "initial value", "hello there"),
+	TEST(setup_str(t_addstr, NULL, "hello there"), "strbuf_addstr adds string");
+	TEST(setup_str(t_addstr, "initial value", "hello there"),
  	     "strbuf_addstr appends string to initial value");
  
  	return test_done();

