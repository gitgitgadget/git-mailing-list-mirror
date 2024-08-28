Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618FA42AB3
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851017; cv=none; b=OwHZ3+HWRrmaQH9TaKV43YGv3zCzBueg+Nv7rLO8S9ZcAHf0llmOCTLN0okbwd1d7xjoOoj6I40zOPnj+JgROocRgPnFdEqHTNtCnWkiN3PJIZ7GWezRvL6X3yafEqY94Br0B7SCeEV5ijBzsMNx3k7b5ReGNtvzuhbwNH8HJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851017; c=relaxed/simple;
	bh=lyP+qBMiQH4l4PO3LXtKDYJvlP4RMYO72u3N2EpE530=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btI48jHi/xMif9hooNnKOoQs9+rzrkJ3p13meHqKGQ58AKhBCEbHavRfb2gf0dD/Iinv6RkYOe1KyNseeS9oK7tC3aVqJ+4dio3kGr3srPcAyqN5w7Bk9g4AgaxFk1r/H0K24b6tuY7A0dXVbDbSNgOY8YmAbP/KoLaOu97+1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oc4ynQdo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oc4ynQdo"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a843bef98so647592166b.2
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724851014; x=1725455814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0oEe63sf/epIfB8+qwQX/8zld0kxbO+M0hkPj9TmaiY=;
        b=Oc4ynQdowFBcFz/rRXSnDTczZ6IKpkxO1SmcSGGVPui9MCsL8f8Ic0X7DFbvXJDdn+
         hG3N69njePKomKf/BU6AwkPN3SnCjUD/Nvfj0vSUW2iST9vhsyJzJWi+TsKwuv/dCRxA
         cxnssjohDD6aaTliWdC06L/XmMopG7GNM0P1IozrSdiXFSbiC7TusFZV/7/2y0AmPoPT
         jhTJ9YKH1uPQlkOFqsTQuxCxwVBovN3A8MX7COaXlrvcbhMhHZ981ImHrbZj0ENbSmg6
         cowuon6AW6NRbFWLVNys0jdad8Y7IhgNADmEqjQNss2dmTWQq7kwYN2yqPFn3ToxkaA1
         rRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724851014; x=1725455814;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oEe63sf/epIfB8+qwQX/8zld0kxbO+M0hkPj9TmaiY=;
        b=TQLYXdhH8JNf6QXvOH1maC0KeGxKdM6dDqdyzFpP6UkF1bKZby0hXsChKlBEQt3mPp
         VpjIWiygcjUIdPDNzozaxoa9nTlsK7SgCx2ldSbX00A2RH2THYs7pH/cBCi1xdf4skO+
         2O1TC2Xt3FQ3z1WdxtJFXsC4mvM4Ru3wKzrh7xA9YFSZoh7Z1j6+ok+iLOzx33u7IG0G
         yU826s0ocaDXEKrkn0MbkqZXQbFv1ZSFJ2c3wSeGf4e3/udaHROU7dnRedOCkuEuqn6J
         0wL8gljou/XoKN819RtLAXybNinVDWS8lBRIYF0NiAxUnMpR7lcSeDoKepcEv5/LVeKI
         +dyA==
X-Forwarded-Encrypted: i=1; AJvYcCUUHTcPeetqxa+GX6adbkwq5H3ZBEJae4eMOA6Qfq/uEoi2P1eayug+CwBFuGQSOIvGZZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsGBXAVNL+jXsMlNEaz2/VBFWm8Ifev+BApSEAh7d4uf/caqQ7
	ue7s232MqZHPH85Mo7EWvVf0SCn2/B7Rl4EanMCA9IsDBQjj7g8h
X-Google-Smtp-Source: AGHT+IHVUg0sB6UamDkvio6xk0xC0zi8XDoeaMpZ0B8kWCd7SvBPtHaVPNENTVyZvwvp2dAIyRM6aA==
X-Received: by 2002:a17:907:96ab:b0:a86:83c7:e885 with SMTP id a640c23a62f3a-a86a54f1d92mr1166221766b.63.1724851013185;
        Wed, 28 Aug 2024 06:16:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582d4fdsm243239866b.133.2024.08.28.06.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 06:16:52 -0700 (PDT)
Message-ID: <435e3840-ee46-4ca3-a525-747848da9930@gmail.com>
Date: Wed, 28 Aug 2024 14:16:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 02/13] t: import the clar unit testing framework
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1722415748.git.ps@pks.im> <cover.1724159966.git.ps@pks.im>
 <1710e9f9ff75cee76be6d5c1311344c6564e3801.1724159966.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <1710e9f9ff75cee76be6d5c1311344c6564e3801.1724159966.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 20/08/2024 15:02, Patrick Steinhardt wrote:
> Import the clar unit testing framework at commit 1516124 (Merge pull
> request #97 from pks-t/pks-whitespace-fixes, 2024-08-15). The framework
> will be wired up in subsequent commits.

I would be good to explain why we're doing this so we have a record in 
the project history. A summary of the advantages and disadvantages of 
using clar vs our current unit test framework would be helpful as well.

 > diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
 > [...]
 > +static void
 > +clar_parse_args(int argc, char **argv)
 > +{
 > [...]
> +		case 'q':
> +			_clar.report_errors_only = 1;
> +			break;

I think this option is incompatible with TAP output as when TAP output 
is selected the first error is printed as part of clar_print_ontest() 
and clar_print_errors() is a no-op. We should error out if it is given 
with '-t'
  > +void clar__fail(
> +	const char *file,
> +	const char *function,
> +	size_t line,
> +	const char *error_msg,
> +	const char *description,
> +	int should_abort)
> +{
> +	struct clar_error *error = calloc(1, sizeof(struct clar_error));

clar seems to take an inconsistent approach to memory allocation errors. 
Here "error" is de-referenced without checking if it is NULL and yet in 
other places there are checks for NULL after calling calloc() or strdup().

> +void clar__assert_equal(
> +	const char *file,
> +	const char *function,
> +	size_t line,
> +	const char *err,
> +	int should_abort,
> +	const char *fmt,
> +	...)
> +{
> +	va_list args;
> +	char buf[4096];
> +	int is_equal = 1;
> +
> +	va_start(args, fmt);
> +
> +	if (!strcmp("%s", fmt)) {
> +		const char *s1 = va_arg(args, const char *);
> +		const char *s2 = va_arg(args, const char *);
> +		is_equal = (!s1 || !s2) ? (s1 == s2) : !strcmp(s1, s2);
> +
> +		if (!is_equal) {
> +			if (s1 && s2) {
> +				int pos;
> +				for (pos = 0; s1[pos] == s2[pos] && s1[pos] && s2[pos]; ++pos)
> +					/* find differing byte offset */;
> +				p_snprintf(buf, sizeof(buf), "'%s' != '%s' (at byte %d)",
> +					s1, s2, pos);

s1 and s2 are passed to snprintf without checking if they are NULL. As 
'snprintf(buf, sizeof(buf), "%s", NULL)' is undefined we should check 
for NULL here. The use of variadic arguments means there is no type 
checking so if one is checking the contents of an strbuf and writes

     cl_assert_equal_s(buf, "expect");

instead of

     cl_assert_equal_s(buf->buf, "expect");

the compiler does not warn you. This is a regression compared to 
check_str(). We can address this by having cl_assert_equal_s() wrap a 
function that takes two strings. Another regression is that if the 
string contains control characters they are printed verbatim.

> diff --git a/t/unit-tests/clar/clar.h b/t/unit-tests/clar/clar.h
 > [...]
> +#define cl_assert_equal_i(i1,i2) clar__assert_equal(__FILE__,__func__,__LINE__,#i1 " != " #i2, 1, "%d", (int)(i1), (int)(i2))

The (int) casts here mean that we'll silently truncate longer arguments 
and suppress any compiler warnings about comparing incompatible types.

 > diff --git a/t/unit-tests/clar/clar/print.h 
b/t/unit-tests/clar/clar/print.h
 > [...]
> +static void clar_print_tap_ontest(const char *suite_name, const char *test_name, int test_number, enum cl_test_status status)
> +{
> +	const struct clar_error *error = _clar.last_report->errors;
> +
> +	(void)test_name;
> +	(void)test_number;
> +
> +	switch(status) {
> +	case CL_TEST_OK:
> +		printf("ok %d - %s::%s\n", test_number, suite_name, test_name);
> +		break;
> +	case CL_TEST_FAILURE:
> +		printf("not ok %d - %s::%s\n", test_number, suite_name, test_name);
> +
> +		printf("    ---\n");
> +		printf("    reason: |\n");
> +		printf("      %s\n", error->error_msg);
> +
> +		if (error->description)
> +			printf("      %s\n", error->description);
> +
> +		printf("    at:\n");
> +		printf("      file: '"); print_escaped(error->file); printf("'\n");
> +		printf("      line: %" PRIuZ "\n", error->line_number);
> +		printf("      function: '%s'\n", error->function);
> +		printf("    ---\n");

If a test calls cl_warning() only the message from the first call to 
that function is printed and any message from later calls to 
cl_warning() or clar__fail() is suppressed when TAP output is selected.

Best Wishes

Phillip
