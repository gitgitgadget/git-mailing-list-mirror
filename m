Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C1569DE4
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708872; cv=none; b=OQ3nh9qDWk4GAhzOj798gRKWPqeAibhUaZukk8IxU3x7NBc2Sfq3MAJLSeM5EVzVR1CG8PvTVLuXzsHPDqeesaz2o910Jev3pBSN7E8vysTBPdfWB18+AEJoh9YlSgpwXt+qiMVaeVg0TZEYew9xQr6+hpUICw07s4bEIxL6JkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708872; c=relaxed/simple;
	bh=0JitEASTejqCZdssRYkBVS+75w7VltV2ZEFVOmWHIPI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=st6Fo7Eck2rezZOGeb1ruzfBnhvDF3n4xNEoXYadZuM7nlQYIkOoGEETO3dJ+sjWXvo/+ZnaI/tvHJiMujnty5qeaPjxPcGLHFK8qpKqkqK7fVBTM3UISqdHMWp99xIP1TVBthn49hV34uq5mESOamJ3rLVZg8YVDeq3ajAtq+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw5okSAM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw5okSAM"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4154bf94fe4so4594795e9.2
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 03:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711708869; x=1712313669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ej/7+Vvvq4imgjeEGznVm/jYd29cdL/kPnGZcawEEWU=;
        b=Hw5okSAM9ttkD3jS24hhIwUt5jUauGTpELb6+/27GKMS6CkZDlrajcxVBt5BzdCvAD
         EkkP0uJe4nov/ABgOU1QtfDUT0JpLcS6d/RbAg2bgh963Wbk3UaqN1aV1S5/8VuCkbyB
         A6kP+ugddbzSUgNwB6tr5bytxv7NrfnwzRO3kh+ZatVZWQDLio31ATs5LIqZ6XSlxyba
         x/3NeKgTSZJ6TU+quhM1ca2mnALZMORJFicaVJOxA2R2WEUeUrup0gi4LET9ns+ZvbqX
         Ohicv2DA/1joX40EKGqUZ+EJ7Bx5EZwB9Csp2ze1A4zWzV+5jlGXPen3Pab+vznu6G1Y
         em1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711708869; x=1712313669;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej/7+Vvvq4imgjeEGznVm/jYd29cdL/kPnGZcawEEWU=;
        b=t1reg2v5Xb+sOVI0DrN8iZso4rkhpbXIajZndXG8vYB6nFHdl+Y9iqPu4lI/ZNrM6m
         r0lOCFCdxD1qTkHKZArxqqFaEiXNFtWjJWbe2YWvceDLmm8avuPI6TVZQomiaGvcjKcn
         NAWaDbVA4f4eSv5F9WKuHHaxYNQTSPRojWxedpV+kP/kKcNPqhbywNNW1Coe3WXsPwq8
         E6IYcOUpyxILYLs2Od/QzLBUon5LqMPrrl415EqhycerEkhB+PmUtTo4k+DH6GtaDbEy
         dfeUPYFzPJhdOEzOul8h6QfaHSWYxUzxubMUSFhsIQh2Ygmbj8Ndz/LsYMtKh5/vSfw1
         LnMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXadzFSq46PBsDtjiKNsFiQJQ7i/MaPgRWdPstcu28vqPN8K0BMvd4fLVsfEav/zOGcUJw9aiYNvSU97foz0MAIcJsV
X-Gm-Message-State: AOJu0YzMJy18QaLhRSBqfioq5sTIhNzI32/YYnRdCbsq4JGCD1DPjrOa
	WX5xjOEZjYzkc5+jaGNuvfd3+aEvykCa5RTvNzf0LjrLKTFLEOYd
X-Google-Smtp-Source: AGHT+IEmm0dtIE/2poOvqFPrHUaqxApQa9IwPUzPH65vXeMkd0zXAw/f0gCABrn7wGWXksM+4VRw6g==
X-Received: by 2002:a05:600c:1c20:b0:413:28ba:1b17 with SMTP id j32-20020a05600c1c2000b0041328ba1b17mr1271205wms.6.1711708868724;
        Fri, 29 Mar 2024 03:41:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c4fcf00b0041488895a37sm8095964wmq.33.2024.03.29.03.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 03:41:08 -0700 (PDT)
Message-ID: <11f4cba9-e12e-4804-ac04-259adee4cfae@gmail.com>
Date: Fri, 29 Mar 2024 10:41:05 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] add-patch: do not print hunks repeatedly
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <60d978d0-f69a-4b65-b4ba-d30dac8f112a@gmail.com>
 <a9c515fe-6664-4b5d-abca-d88fdd32a883@gmail.com>
 <1f737f82-9bc5-43b4-b78b-bf1b4393efc8@gmail.com>
Content-Language: en-US
In-Reply-To: <1f737f82-9bc5-43b4-b78b-bf1b4393efc8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 29/03/2024 03:58, Rubén Justo wrote:

Thanks for re-rolling, this looks pretty good - I've left a couple of 
small comments.

> @@ -1448,10 +1448,15 @@ static int patch_update_file(struct add_p_state *s,
>   
>   		strbuf_reset(&s->buf);
>   		if (file_diff->hunk_nr) {
> -			render_hunk(s, hunk, 0, colored, &s->buf);
> -			fputs(s->buf.buf, stdout);
> +			if (rendered_hunk_index != hunk_index) {
> +				render_hunk(s, hunk, 0, colored, &s->buf);
> +				fputs(s->buf.buf, stdout);
> +
> +				rendered_hunk_index = hunk_index;

This line could be grouped with the rest of this block without the blank 
line if you wanted.

> +			}
>   
>   			strbuf_reset(&s->buf);
> +

I'm not sure what this new blank line is for - previously it was clear 
that the call strbuf_reset() was grouped with the code that then reuses 
the buffer. The rest of the changes look fine

Best Wishes

Phillip

>   			if (undecided_previous >= 0) {
>   				permitted |= ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
>   				strbuf_addstr(&s->buf, ",k");
> @@ -1646,13 +1651,15 @@ static int patch_update_file(struct add_p_state *s,
>   			hunk_index = i;
>   		} else if (s->answer.buf[0] == 's') {
>   			size_t splittable_into = hunk->splittable_into;
> -			if (!(permitted & ALLOW_SPLIT))
> +			if (!(permitted & ALLOW_SPLIT)) {
>   				err(s, _("Sorry, cannot split this hunk"));
> -			else if (!split_hunk(s, file_diff,
> -					     hunk - file_diff->hunk))
> +			} else if (!split_hunk(s, file_diff,
> +					     hunk - file_diff->hunk)) {
>   				color_fprintf_ln(stdout, s->s.header_color,
>   						 _("Split into %d hunks."),
>   						 (int)splittable_into);
> +				rendered_hunk_index = -1;
> +			}
>   		} else if (s->answer.buf[0] == 'e') {
>   			if (!(permitted & ALLOW_EDIT))
>   				err(s, _("Sorry, cannot edit this hunk"));
> @@ -1661,7 +1668,7 @@ static int patch_update_file(struct add_p_state *s,
>   				goto soft_increment;
>   			}
>   		} else if (s->answer.buf[0] == 'p') {
> -			/* nothing special is needed */
> +			rendered_hunk_index = -1;
>   		} else {
>   			const char *p = _(help_patch_remainder), *eol = p;
>   
