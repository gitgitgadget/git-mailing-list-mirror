Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E61FAC29
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738507143; cv=none; b=PD0yM6w6rbJJDgtcF1SDbDuJxyqjU95cGDDNmNYJDz8/cGmLjJGYFRWPdLrsssKgz24LolYr1YX3Ao6C7VoubNIQPSOYd9ZULB+VWoqmSWt2ZCsRnyL6Jn5zJ7bItSl9ukwhJhZ6SmvrZACMVP2of5GjLjm+bLSL1nHWxXzw2l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738507143; c=relaxed/simple;
	bh=POwsVOsNDC0a8N321wxnUBblB9joUkOGMwV8T3nfM6k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HP97FaEEUm9nouaXmmG0lRZ/7Di1eBxjlpPXxB8idLDVExgpZ2jG32F2cZ5BaCF/3ZOzGvZlP27YEo94Hwo9zjW3SDEznY52SpD0vdUiK41k7V5nrzhIQJrC/uGxIqWf8wuS9QZdlw2VggPcvdGjDD49d4CDJ9/6DXVHYt6z/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSaCNBhl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSaCNBhl"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43634b570c1so25276045e9.0
        for <git@vger.kernel.org>; Sun, 02 Feb 2025 06:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738507139; x=1739111939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFFl9JF/WNTO0qxMBwtuPwJR3sAB1DqqlgqQZzWIoOA=;
        b=MSaCNBhlWUsCK3tgT2oYrV2D1Or+mDzTqWO3l37MzWRHbW4znCHkXCYEmIJ6oVVMZR
         DjQ7YptZ6NEn3QMiDZLqh9gD/BEkT9bNOGB/RjPPCjb/13YfnPLvsy7p1Po8F86JRHja
         MJLjO6hW+kfcDjv4yfOfEfjHB87xReUngHVUBmASKJxVDE4XOX/W5+0r5H4oVi3Tvd5f
         iPFlwVE2Eo2rz9N4b8NzizF5wjJT1cBZM6P35FjAPGRbyiIehswCO/+9aaXLymgzfaWp
         1vyI9708xojTYs17MAsbCXocnsDFayyFj0fa/VGexaW1/DTn1UDPmW3M9HT6ES5vkMXv
         zGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738507139; x=1739111939;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFFl9JF/WNTO0qxMBwtuPwJR3sAB1DqqlgqQZzWIoOA=;
        b=URnu6aPEVC6pZejzVSvegssgLEAw0Gg55DTkS1XdO+uCxCZyutKDA2TrkExKtrJdPE
         klES5EA6rpj07/RdJaeBitH/oJcocE52li+Vgd+UomEtTjXo5es1umjOYy3HpMYN3vVQ
         3Oy3P+jhT653CJm4caKpSPne6JQXN44nTTTAeAkXUhf1r8SFsLaQaiHHaNTN2uRQQ+nL
         3A536YOKL+Vk3/kFqqLnIXDNmYBRKm16j39GQFTwarf6gCpEMhQWVKb20Zn/1Ja7iKst
         DkJxkyXBWM9acAT0C8tAltHi9VA92ygs0Dcu/vTl4xdHwBCCcb6jc/fxZeJy0EF6lmOj
         ISag==
X-Forwarded-Encrypted: i=1; AJvYcCV50M18rywMq9x2iFG0CnQ5XuXY0TkySg6+RmliQWPrscjzMuZxDAR3cQMp0yEi+A7MWBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfo+hKC1zfmn94Of1ebJWM7POWoSwKu40TGaGe7t1PIqrH2Bca
	rTLnQ3eXaf3EuqCWfYIwQmhohLZrKer9FpuUPWHd5p8rymzGOi67
X-Gm-Gg: ASbGncsqhxsa0/vdihDLqpVc4MuQfNpqmQr4dff8YL79A565lgKA8F5fAoC+aROO6t/
	gCOuNDGYg+PkfpsN5bJuqIPEhTk7qFEPDxqMbQTF6I+R8M5V2bdSYe6bBaAeLn3PXueQdes1Ubo
	7/LEhFpAPfwAcpeq8BgWouSRK+4EyscwRYruVLdFkIuG2MM42m4Z84mMEVqYMGkq5i4htTQsttx
	Kd6LVozn1OGRbIwrHorkMQZ50IRZxF/BYuWpm0OP+eEsVIA8MhIN08oFa8Vtm5PBGDStM1g/ISx
	nLVbc7WxNnJv9AmDKDRhqMSV2GH1+ZBAajs4nhN2lgUFRTshx0XVwdRdnsms7ganUCTu4g==
X-Google-Smtp-Source: AGHT+IFUAR08PzveF6iuwYaQEte3f+6XrhVgyqUINRG5EH+MHbllCEWEr57nufleXsgH05J7h8aOEA==
X-Received: by 2002:a05:600c:3d9b:b0:434:effb:9f8a with SMTP id 5b1f17b1804b1-438dc3c3554mr164856015e9.15.1738507139051;
        Sun, 02 Feb 2025 06:38:59 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c11fe22sm9994483f8f.41.2025.02.02.06.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 06:38:58 -0800 (PST)
Message-ID: <ab05e979-2a5f-4532-bb0c-e8c59665647c@gmail.com>
Date: Sun, 2 Feb 2025 14:38:55 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] t/unit-tests: convert strbuf test to use clar test
 framework
To: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, phillip.wood@dunelm.org.uk
References: <20250130091334.39922-1-kuforiji98@gmail.com>
 <20250131221420.38161-1-kuforiji98@gmail.com>
 <20250131221420.38161-4-kuforiji98@gmail.com>
Content-Language: en-US
In-Reply-To: <20250131221420.38161-4-kuforiji98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Seyi

On 31/01/2025 22:14, Seyi Kuforiji wrote:
> Adapt strbuf test script to clar framework by using clar assertions
> where necessary.

This patch looks correct but it looses the nice messages we get from 
check_char() and check_uint(a, </<=/>/>=, b). I think it would be worth 
adding equivalent assertions to clar to avoid that.

>   /* wrapper that supplies tests with an empty, initialized strbuf */
> @@ -9,8 +9,8 @@ static void setup(void (*f)(struct strbuf*, const void*),
>   
>   	f(&buf, data);
>   	strbuf_release(&buf);
> -	check_uint(buf.len, ==, 0);
> -	check_uint(buf.alloc, ==, 0);
> +	cl_assert_equal_i(buf.len, 0);
> +	cl_assert_equal_i(buf.alloc, 0);

It is a shame that we do not have an assertion for checking two unsigned 
integers are equal. In this case it probably does not matter but large 
unsigned values will be printed as negative numbers which could be 
rather confusing for someone trying to debug a test failure.

> -static int assert_sane_strbuf(struct strbuf *buf)
> +static void assert_sane_strbuf(struct strbuf *buf)
>   {
>   	/* Initialized strbufs should always have a non-NULL buffer */
> -	if (!check(!!buf->buf))
> -		return 0;
> +	cl_assert(buf->buf != NULL);
>   	/* Buffers should always be NUL-terminated */
> -	if (!check_char(buf->buf[buf->len], ==, '\0'))
> -		return 0;
> +	cl_assert(buf->buf[buf->len] == '\0');

It is unfortunate that this looses the helpful diagnostic message that 
shows the values of the two chars being compared that is printed by 
check_char() when the check fails. I think it would be worth porting 
check_char() arcoss to clar. When we decided to move to the new test 
framework we planned to add new assertions to clar to match our existing 
framework.

>   	/*
> -	 * Freshly-initialized strbufs may not have a dynamically allocated
> -	 * buffer
> -	 */
> -	if (buf->len == 0 && buf->alloc == 0)
> -		return 1;
> -	/* alloc must be at least one byte larger than len */
> -	return check_uint(buf->len, <, buf->alloc);
> +         * In case the buffer contains anything, `alloc` must alloc must
> +         * be at least one byte larger than `len`.
> +         */
> +	if (buf->len)
> +            cl_assert(buf->len < buf->alloc);

This is another case where we loose a helpful diagnostic message because 
clar lacks cl_assert_lt_u(a, b) to check that unsigned integer a is less 
than unsigned integer b. I think it would be worth adding the assertions 
that are missing show that we have the equivalent of

	check_int(a, <, b)
	check_int(a, <=, b)
	check_int(a, >, b)
	check_int(a, >=, b)

and their unsigned companions so we do not regress the diagnostic output 
when a test fails.

Looking at the comment that is deleted above I wonder if we should add

	else
		cl_assert_equal_i(buf->alloc, 0);

To check that alloc is zero when len is zero.

Best Wishes

Phillip

>   }
>   
> -static void t_static_init(void)
> +void test_strbuf__static_init(void)
>   {
>   	struct strbuf buf = STRBUF_INIT;
>   
> -	check_uint(buf.len, ==, 0);
> -	check_uint(buf.alloc, ==, 0);
> -	check_char(buf.buf[0], ==, '\0');
> +	cl_assert_equal_i(buf.len, 0);
> +	cl_assert_equal_i(buf.alloc, 0);
> +	cl_assert(buf.buf[0] == '\0');
>   }
>   
> -static void t_dynamic_init(void)
> +void test_strbuf__dynamic_init(void)
>   {
>   	struct strbuf buf;
>   
>   	strbuf_init(&buf, 1024);
> -	check(assert_sane_strbuf(&buf));
> -	check_uint(buf.len, ==, 0);
> -	check_uint(buf.alloc, >=, 1024);
> -	check_char(buf.buf[0], ==, '\0');
> +	assert_sane_strbuf(&buf);
> +	cl_assert_equal_i(buf.len, 0);
> +	cl_assert(buf.alloc >= 1024);
> +	cl_assert(buf.buf[0] == '\0');
>   	strbuf_release(&buf);
>   }
>   
> @@ -73,16 +69,12 @@ static void t_addch(struct strbuf *buf, const void *data)
>   	size_t orig_alloc = buf->alloc;
>   	size_t orig_len = buf->len;
>   
> -	if (!check(assert_sane_strbuf(buf)))
> -		return;
> +	assert_sane_strbuf(buf);
>   	strbuf_addch(buf, ch);
> -	if (!check(assert_sane_strbuf(buf)))
> -		return;
> -	if (!(check_uint(buf->len, ==, orig_len + 1) &&
> -	      check_uint(buf->alloc, >=, orig_alloc)))
> -		return; /* avoid de-referencing buf->buf */
> -	check_char(buf->buf[buf->len - 1], ==, ch);
> -	check_char(buf->buf[buf->len], ==, '\0');
> +	assert_sane_strbuf(buf);
> +	cl_assert_equal_i(buf->len, orig_len + 1);
> +	cl_assert(buf->alloc >= orig_alloc);
> +	cl_assert(buf->buf[buf->len] == '\0');
>   }
>   
>   static void t_addstr(struct strbuf *buf, const void *data)
> @@ -92,31 +84,36 @@ static void t_addstr(struct strbuf *buf, const void *data)
>   	size_t orig_alloc = buf->alloc;
>   	size_t orig_len = buf->len;
>   
> -	if (!check(assert_sane_strbuf(buf)))
> -		return;
> +	assert_sane_strbuf(buf);
>   	strbuf_addstr(buf, text);
> -	if (!check(assert_sane_strbuf(buf)))
> -		return;
> -	if (!(check_uint(buf->len, ==, orig_len + len) &&
> -	      check_uint(buf->alloc, >=, orig_alloc) &&
> -	      check_uint(buf->alloc, >, orig_len + len) &&
> -	      check_char(buf->buf[orig_len + len], ==, '\0')))
> -	    return;
> -	check_str(buf->buf + orig_len, text);
> +	assert_sane_strbuf(buf);
> +	cl_assert_equal_i(buf->len, orig_len + len);
> +	cl_assert(buf->alloc >= orig_alloc);
> +	cl_assert(buf->buf[buf->len] == '\0');
> +	cl_assert_equal_s(buf->buf + orig_len, text);
>   }
>   
> -int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +void test_strbuf__add_single_char(void)
>   {
> -	if (!TEST(t_static_init(), "static initialization works"))
> -		test_skip_all("STRBUF_INIT is broken");
> -	TEST(t_dynamic_init(), "dynamic initialization works");
> -	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
> -	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
> -	TEST(setup_populated(t_addch, "initial value", "a"),
> -	     "strbuf_addch appends to initial value");
> -	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
> -	TEST(setup_populated(t_addstr, "initial value", "hello there"),
> -	     "strbuf_addstr appends string to initial value");
> -
> -	return test_done();
> +	setup(t_addch, "a");
> +}
> +
> +void test_strbuf__add_empty_char(void)
> +{
> +	setup(t_addch, "");
> +}
> +
> +void test_strbuf__add_append_char(void)
> +{
> +	setup_populated(t_addch, "initial value", "a");
> +}
> +
> +void test_strbuf__add_single_str(void)
> +{
> +	setup(t_addstr, "hello there");
> +}
> +
> +void test_strbuf__add_append_str(void)
> +{
> +	setup_populated(t_addstr, "initial value", "hello there");
>   }

