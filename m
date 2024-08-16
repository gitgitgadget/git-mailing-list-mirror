Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B7719FA91
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815515; cv=none; b=un3gfjwIZUPRSGwfgJ3dBllE43dqqkzmeMjZuuEVPPR7VpYqO1+ipVasEHjySgPusMxf6EVYAP2sFRf7bXU8S9ydW/9cn2RniCA8kY2m6AXqjpp6jDMmpP2lAnApVOlaXYpW+yUIshmP56AME5RkFOUTIQYELeiXMM3CVKBvmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815515; c=relaxed/simple;
	bh=HeUHMyFeVZ+4mhlA/7YuRmFeiv+Oc1yZp4pprTbSzuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9ran/qfswgsgBOrqMeyDux1QHGuQOksJrX2X29Z3bBHZtE8jmFwahmP+ZbGxR1wZfnvxZWD0PTgfwDlxVCRycP0uDYT8mAIywG+MdxI65YiaHGaP/70JY4XUGIybCBhhY65Fblsfdj39zTY4/JuWxZ+6BG5piRT53ZDMIYPbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSv80ikG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSv80ikG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e3129851so14676465e9.3
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723815512; x=1724420312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NAxG8ZM0gbGY9wZuHHxusym+2nogGeHD0Oo6mnJD3Lg=;
        b=bSv80ikGWJvhA5l9fsi+SLc/sysjvNQ7CEao8iTikh59oRsLps2DrbgLcoaq0vnq7W
         jBUV+g3PSwZc1D4IVVqwWCzTMtFZ1r0MKyPrKxB9xZogbwskxb0GZ6ESPF71ckxPHAJP
         yUOnpS5vPfvyV8Y8u+P9bsEbFRL9eR/jQZ378kSbQnbykqIm/szLnH47nY0JtwlhaCPG
         9SU26Z9rVlDPHpWtag2+0/wa8v4BkAe5E745xQ/KrEqKcVs1PWmxHGhcq+cq2H4Ds/bs
         GiV3pgrxTZAGOhtVnVfxxMBbh5rXd9+GdjgntFOa/xWZGOC2cWE6yKzsh/XRBG83f2qn
         cr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815512; x=1724420312;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAxG8ZM0gbGY9wZuHHxusym+2nogGeHD0Oo6mnJD3Lg=;
        b=TMOrigTOCNJrMVoORyTkqHh1IjoBZAd6qLgDDKYYQwagA0Oy88rNYh2DDUTpTlhuvp
         1K/e33Re6OcqoOLRczgXxagygoJ6+MO9Uj8xuYV/zbLUa7WEhi6kxuAHcB2COIhp1SeF
         TLmlrzp41SdcNcPMqbXildFhOG8NsIkw9QQjz6cux3U/spNPt0r8Q8C+DQxKbU7ynFWi
         YrYrRaqt+BaujgUPYikW3YQwH+JDiHZnj0IsaiRGzZVezO4f4//KKSb1tdTsMMtAnBw0
         dHa+rQVVcQgE30sZse1WDE3oHagEWoFgZbqrKoHYgd71CUI88v7Cz2yNMBuwzgdXaHmg
         CuVw==
X-Forwarded-Encrypted: i=1; AJvYcCXezzUPe4f5hthStboxAvOBF0yWVcf2Oj7UgPifAt7kskHBCNF6N69G8fzAgXB4mlbmpQzdXpReYPJR8JsiOY0Qor4n
X-Gm-Message-State: AOJu0Yz5mJjkti8qn1Jay6Ep1Rdwykje7xmOvrap2V6DHLqJ8hUzKxL2
	hjuVQCnfqPPJbZ3VWFvIg6YgeLZ2QBLYy4XmBQ2p3ghdUmqv7RIW/uNWWQ==
X-Google-Smtp-Source: AGHT+IH2PQFH39LId3Z4AF+ZXj7c7fP0VUVUoCtVilCc17KexilYBNrzljWdTchY16xUoO9srLulVA==
X-Received: by 2002:a05:600c:138f:b0:428:2502:75b5 with SMTP id 5b1f17b1804b1-429ed7ba9c0mr18896755e9.11.1723815511306;
        Fri, 16 Aug 2024 06:38:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650735sm23005115e9.12.2024.08.16.06.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 06:38:31 -0700 (PDT)
Message-ID: <4aa6f557-1dfc-4aaa-b6db-e47013568ecc@gmail.com>
Date: Fri, 16 Aug 2024 14:38:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 9/9] t/unit-tests: convert ctype tests to use clar
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>
References: <cover.1722415748.git.ps@pks.im> <cover.1723791831.git.ps@pks.im>
 <ca09d19fd51cd4b3072b339f483b6b6d6e467b56.1723791831.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ca09d19fd51cd4b3072b339f483b6b6d6e467b56.1723791831.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 16/08/2024 08:05, Patrick Steinhardt wrote:
>   #define TEST_CHAR_CLASS(class, string) do { \
>   	size_t len = ARRAY_SIZE(string) - 1 + \
>   		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
>   		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) == sizeof(char)); \
> -	int skip = test__run_begin(); \
> -	if (!skip) { \
> -		for (int i = 0; i < 256; i++) { \
> -			if (!check_int(class(i), ==, !!memchr(string, i, len)))\
> -				test_msg("      i: 0x%02x", i); \
> -		} \
> -		check(!class(EOF)); \
> -	} \
> -	test__run_end(!skip, TEST_LOCATION(), #class " works"); \
> +	for (int i = 0; i < 256; i++) \
> +		cl_assert_equal_i(class(i), !!memchr(string, i, len)); \

If this fails how are we supposed to know which character it was checking?

Thanks

Phillip

> +	cl_assert(!class(EOF)); \
>   } while (0)
>   
>   #define DIGIT "0123456789"
> @@ -33,21 +27,72 @@
>   	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
>   	"\x7f"
>   
> -int cmd_main(int argc, const char **argv) {
> +void test_ctype__isspace(void)
> +{
>   	TEST_CHAR_CLASS(isspace, " \n\r\t");
> +}
> +
> +void test_ctype__isdigit(void)
> +{
>   	TEST_CHAR_CLASS(isdigit, DIGIT);
> +}
> +
> +void test_ctype__isalpha(void)
> +{
>   	TEST_CHAR_CLASS(isalpha, LOWER UPPER);
> +}
> +
> +void test_ctype__isalnum(void)
> +{
>   	TEST_CHAR_CLASS(isalnum, LOWER UPPER DIGIT);
> +}
> +
> +void test_ctype__is_glob_special(void)
> +{
>   	TEST_CHAR_CLASS(is_glob_special, "*?[\\");
> +}
> +
> +void test_ctype__is_regex_special(void)
> +{
>   	TEST_CHAR_CLASS(is_regex_special, "$()*+.?[\\^{|");
> +}
> +
> +void test_ctype__is_pathspec_magic(void)
> +{
>   	TEST_CHAR_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=>@_`~");
> +}
> +
> +void test_ctype__isascii(void)
> +{
>   	TEST_CHAR_CLASS(isascii, ASCII);
> +}
> +
> +void test_ctype__islower(void)
> +{
>   	TEST_CHAR_CLASS(islower, LOWER);
> +}
> +
> +void test_ctype__isupper(void)
> +{
>   	TEST_CHAR_CLASS(isupper, UPPER);
> +}
> +
> +void test_ctype__iscntrl(void)
> +{
>   	TEST_CHAR_CLASS(iscntrl, CNTRL);
> +}
> +
> +void test_ctype__ispunct(void)
> +{
>   	TEST_CHAR_CLASS(ispunct, PUNCT);
> +}
> +
> +void test_ctype__isxdigit(void)
> +{
>   	TEST_CHAR_CLASS(isxdigit, DIGIT "abcdefABCDEF");
> -	TEST_CHAR_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");
> +}
>   
> -	return test_done();
> +void test_ctype__isprint(void)
> +{
> +	TEST_CHAR_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");
>   }
