Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A512144D34
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172685; cv=none; b=j36YHN5e8XQYgBwqqA3rQWAICqVaXL+Q+CQS6CkXzRWVV3wDXoMuZKiI6p3/Rw8wwHJT9K5PkBRfF2uS1in5kx6pCrZ+0Choq+Udt/8uLReKlV+pr2l8qxBNnqWcQHR/uiQX1PN9SkbcsmpscSVVdvTosFleJ7oRL0QoSuwu53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172685; c=relaxed/simple;
	bh=VvOooZog/zUINlmmcO/nPbWWVWahkolM/vPt8b4LoY0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=t/HC2E+Jk56Ab4TCdtUbeOxFYF/VeZn26d1jKdHQwfBG/t7KToa9M2dL103AdKL10xNGGa04DnJjPO1Zxrw68DHBd53ucXhiwphfmp5RVy45RBnSeitTnP6jB54m/LMBrfa1o+yaG1KrjckN+geTEIKi2WSgiLoPl1o8qAe3dMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fl0o052u; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl0o052u"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367a081d1cdso784239f8f.1
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 02:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720172682; x=1720777482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jg7/yYfoA5iZaW8Z5F6wmp2p9gf0TYTntVQ8HZ/+mKY=;
        b=fl0o052uj5wNRQaTcfK9n14dGDOZUa4XkFOFwlUe/quNTUI095BFO9K39t/ErZwVxz
         n0fBrzh3iM3ErR8mhHf5yC/bxrxBp5JvfRTDAiOfWsx0cBeZ+8Argwd8v1r/ujz9uCUC
         7+ZDlUhpmVXFflU4eTVCTAspnqb/3TN1iVF++hGYorTq8n5fw4PThDKWlwc5oz5gUUWB
         sJeLESM28y4LebhJf8Jd3NPvUGipvRi/8EV6z/DewRH1tHIXTx+dwyb9m7OUImKmIiRY
         HxCbSuk00UYBQGwu0D3Y2dkqdT5GOY5JCUM0HJKbztba0SCwn5ZSkvjn1lnBzdIVQvMR
         +Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172682; x=1720777482;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jg7/yYfoA5iZaW8Z5F6wmp2p9gf0TYTntVQ8HZ/+mKY=;
        b=PuaJsWisu/ihqPrVIakcdFBTg7U6BThC6ANtJfWjrd/kDbDv9iPPcF3tnG8LrmA87C
         tI41vHK4GUclnbU+RzhH78f16SzFnUaJe0q/XzMcF00LBEs9mkxRrhn0AT9xZKkhw3cP
         YfHB2jx8B86uNXiN9s1nx0iJKHl1k/CZ3v0/FnVMzxFh0S3lhzi0kmm8OKElxYj2bXlS
         AFeUtED/WK6C2vu3p9c2jr/0OIq403Y81ZIs0yluimHClp1ANaF5QcNQOS+ntGAMI4oo
         OAAmRi+3445cuzKsnIs5GeG+iQEG8cgU1MXz17cgZuT9vkDin6gO1+IYHAHuob4mmPSF
         gVvg==
X-Forwarded-Encrypted: i=1; AJvYcCUUKO74/neGyvVoCTmwWPsDV1hGJPYGLzsEJOH15+Z3WD/O+4XMq2UiiZoabTbcYIwYr9TYc/9R7vXRghga3wcubonu
X-Gm-Message-State: AOJu0YwZjJHfFCEsIM8pYmPh5Vo9/MHMqONd7UUJ+lT4QIrRhS1L7AsQ
	RG/hev5wrQT8Y7qwVrNu7q1MruH2vKV8ZR4yL4/VFJroda6C+k16nlFSgw==
X-Google-Smtp-Source: AGHT+IF5nNHdqfbWUKRsZwhapLALxoIEJ5zEnXU4TPPVAHrb6jZyBnLQ1MOcRsnx+8Wbd4XkrwEN/Q==
X-Received: by 2002:adf:f2d2:0:b0:367:9792:8bd4 with SMTP id ffacd0b85a97d-3679dd65208mr2749001f8f.43.1720172681379;
        Fri, 05 Jul 2024 02:44:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61c:a601:7f88:feb2:513a:4c20? ([2a0a:ef40:61c:a601:7f88:feb2:513a:4c20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36799a54215sm4084966f8f.68.2024.07.05.02.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 02:44:41 -0700 (PDT)
Message-ID: <3add9624-4f3a-4f70-bc15-2357920dbc9f@gmail.com>
Date: Fri, 5 Jul 2024 10:44:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t-strvec: use test_msg()
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
Content-Language: en-US
In-Reply-To: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

Thanks for working on this, this looks good modulo Eric's suggestions

Best Wishes

Phillip

On 04/07/2024 19:04, René Scharfe wrote:
> check_strvec_loc() checks each the strvec item by looping through them
> and comparing them with expected values.  If a check fails then we'd
> like to know which item is affected.  It reports that information by
> building a strbuf and delivering its contents using a failing assertion.
> 
> Here's an example in which there are less items in the strvec than
> expected; the index of the missing item is reported in the last line:
> 
>     # check "vec->nr > nr" failed at t/unit-tests/t-strvec.c:19
>     #    left: 1
>     #   right: 1
>     # check "strvec index 1" failed at t/unit-tests/t-strvec.c:71
> 
> Note that it is also reported in the third line, i.e. the variable
> "nr" contains that index.
> 
> Stop printing the index explicitly for checks that already report it.
> The message for the same condition as above becomes:
> 
>     # check "vec->nr > nr" failed at t/unit-tests/t-strvec.c:19
>     #    left: 1
>     #   right: 1
> 
> For the string comparison, whose error message doesn't include the
> index, report it using the simpler and more appropriate test_msg()
> instead.  Report the index using its actual name and format the line
> like the preceding ones.  The message for an unexpected string value
> becomes:
> 
>     # check "!strcmp(vec->v[nr], str)" failed at t/unit-tests/t-strvec.c:24
>     #    left: "foo"
>     #   right: "bar"
>     #      nr: 0
> 
> Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>   t/unit-tests/t-strvec.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
> index d4615ab06d..236203af61 100644
> --- a/t/unit-tests/t-strvec.c
> +++ b/t/unit-tests/t-strvec.c
> @@ -17,12 +17,12 @@ static void check_strvec_loc(const char *loc, struct strvec *vec, ...)
>   			break;
> 
>   		if (!check_uint(vec->nr, >, nr) ||
> -		    !check_uint(vec->alloc, >, nr) ||
> -		    !check_str(vec->v[nr], str)) {
> -			struct strbuf msg = STRBUF_INIT;
> -			strbuf_addf(&msg, "strvec index %"PRIuMAX, (uintmax_t) nr);
> -			test_assert(loc, msg.buf, 0);
> -			strbuf_release(&msg);
> +		    !check_uint(vec->alloc, >, nr)) {
> +			va_end(ap);
> +			return;
> +		}
> +		if (!check_str(vec->v[nr], str)) {
> +			test_msg("     nr: %"PRIuMAX, (uintmax_t)nr);
>   			va_end(ap);
>   			return;
>   		}
> --
> 2.45.2
