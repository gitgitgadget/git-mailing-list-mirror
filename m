Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562D152797
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488430; cv=none; b=V3zKb9EPxu6QmRTyDO005N0+/1IgmzUUX36rkxfnNT3li0oG+rXqAGsNCeqzZXSCZuNkuhZO2CHB62GI0FCQ3HZ3rjP7lH+GbG00vcmaZy8XVT8QTSL26TMcVqO9WNEriBTk0uYqBgbY0q94dxona+6d9/CBApU8sunrT/O8Gwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488430; c=relaxed/simple;
	bh=B9JUTJ7hUNh+3atcWaSFYtTDL2jmW0Mn/U5Su2xGtTE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XL4Hj2CK+7X8UR/USL8YhcAS6XMVv3fGLHCzQul957XnLj79RQOtPbVTHimGmo7BmDDckRNKd86FKbwbkjNUNDO8Hm5B29jIZI5FrEz1XCM9tp7VKpp0F5ytZjjukGyB75T/V12ReWOAm7k1wMz0Ao7E+XoFxWruuMp8dgK3zdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJUkRsoB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJUkRsoB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41b79451128so33604665e9.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714488427; x=1715093227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mu1+zCp+ndOiWIVCTenLyAjAvQVhxw07+5s477LKFp4=;
        b=JJUkRsoB8DCsKaexiumgqYD4Bn1ed/M5VBOpPCp+90dEg/tPGl9xU4bcWmK2c1k01/
         ruPfJjEOUCYHa/AiZC4+y678D4MHOXGK2fE7pFusFVw4526at+a8rAFAr5UG8J1FNsx5
         ebY37DHabofbTxUqLUCGhFZYFwv+a0ltqnwlsnnlmDg7EJtUoiaTQWPEeLDSf1diS5ky
         DVUCNfh9N+hR2BuQG6HBL2qr1bKKNQcOb8cuht1rnp5lqcTR/OZSp+xFo+JsOx055RMh
         DeTaInOXlyXsFWTsyUTgmKzWO2W1zvi3RQF6PxDg9ApujjRNcrVlFJVsAicGio3CmuhA
         RrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714488427; x=1715093227;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu1+zCp+ndOiWIVCTenLyAjAvQVhxw07+5s477LKFp4=;
        b=H4x8Udmck1TKL8XA+U43UpB7a29fq1eAsp2/JwA84qdPpAXBfhiLNjBYtJbwmgfyyY
         Jx1u4SuhoE3Av+KJPqIMByvVQdH7UVA8qd74GaVO2VhunL97+/zF9CKYis4Jgj2vcHIv
         7k5Pk3WMV3VaqL+XzliKIqcH8plgZrvZn3Tr6ColWR15aFOga818h8g6DzFZuzch8+wM
         I+AMJpSJyrRpW8fJvl//jfrM6rMwZXCDRJCIrliOVSUP2pp4IhTMw5poqD23QvOVWQ+q
         nSeKO/bAUvXuPBU2WqAWZUIvznh3h7z4wbVrufovttDwbUHuEyUjw5dhq3cOpMLIORkB
         FL9g==
X-Forwarded-Encrypted: i=1; AJvYcCWgXa5ij308piQoi/5/BjVtZ6B9Y5UTPvRYylcuC8Feq9+6hcVyDXZ+QyWDVplJOTNP0qLSsR2cfMB2r9S+dr4w9TWU
X-Gm-Message-State: AOJu0Yy0ATc8wfzrVf0GuhvhYEOKqRJjdX9D53dPjUyEy0IOHFDVm4ec
	duJ+v0EDJ1vKEhIWVYwqktd0UNzP7ODpJEWQ20rz9jvErNQfn6UGuxbi5g==
X-Google-Smtp-Source: AGHT+IFCQ/mW1MsdK8Fha3Lc5VJ1F8Q5dBcoOGsQbanmLhOlGiANYTvB3x1XWcHrg37U2caUnO/sZg==
X-Received: by 2002:a05:600c:4f83:b0:41b:f359:2b53 with SMTP id n3-20020a05600c4f8300b0041bf3592b53mr7625204wmq.37.1714488426777;
        Tue, 30 Apr 2024 07:47:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8e01:7cd2:1ad2:b4af:7cb4? ([2a0a:ef40:64f:8e01:7cd2:1ad2:b4af:7cb4])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600c450b00b0041befc2652csm11887109wmo.31.2024.04.30.07.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 07:47:06 -0700 (PDT)
Message-ID: <27fbb12a-f2d2-459c-a27b-519f69242105@gmail.com>
Date: Tue, 30 Apr 2024 15:47:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 1/2] add-patch: do not show UI messages on stderr
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
 <10905ab3-bb3c-4669-9177-84c8e6759616@gmail.com>
Content-Language: en-US
In-Reply-To: <10905ab3-bb3c-4669-9177-84c8e6759616@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 29/04/2024 19:37, Rubén Justo wrote:
> There is no need to show some UI messages on stderr, and yet doing so
> may produce some undesirable results, such as messages appearing in an
> unexpected order.
> 
> Let's use stdout for all UI messages, and adjusts the tests accordingly.

The test changes in "warn add.interactive.useBultin" show that we still 
print a warning to stderr, I don't think that particular case is worth 
worrying about though.

> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>   add-patch.c                | 13 ++++++-------
>   t/t3701-add-interactive.sh | 12 ++++++------
>   2 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 0997d4af73..fc0eed4fd4 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -293,10 +293,9 @@ static void err(struct add_p_state *s, const char *fmt, ...)
>   	va_list args;
>   
>   	va_start(args, fmt);
> -	fputs(s->s.error_color, stderr);
> -	vfprintf(stderr, fmt, args);
> -	fputs(s->s.reset_color, stderr);
> -	fputc('\n', stderr);
> +	fputs(s->s.error_color, stdout);
> +	vprintf(fmt, args);
> +	puts(s->s.reset_color);
>   	va_end(args);
>   }

This looks like a good change

> @@ -1326,7 +1325,7 @@ static int apply_for_checkout(struct add_p_state *s, struct strbuf *diff,
>   		err(s, _("Nothing was applied.\n"));
>   	} else
>   		/* As a last resort, show the diff to the user */
> -		fwrite(diff->buf, diff->len, 1, stderr);
> +		fwrite(diff->buf, diff->len, 1, stdout);

This seems reasonable as we'd print the "Nothing was applied" error 
message above to stdout now. Anything "git apply" writes to stderr 
should be flushed when it exits before we print these messages.

>   
>   	return 0;
>   }
> @@ -1778,9 +1777,9 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>   			break;
>   
>   	if (s.file_diff_nr == 0)
> -		fprintf(stderr, _("No changes.\n"));
> +		err(&s, _("No changes."));
>   	else if (binary_count == s.file_diff_nr)
> -		fprintf(stderr, _("Only binary files changed.\n"));
> +		err(&s, _("Only binary files changed."));

These two mean we'll now color these messages which we didn't do before. 
I think if we hit this code we don't print anything else (apart from the 
warning about add.interactive.useBuiltin being removed) so it probably 
does not matter whether we use stdout or stderr here and I don't have a 
strong opinion either way.

Best Wishes

Phillip

>   	add_p_state_clear(&s);
>   	return 0;
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 04d8333373..c5531520cb 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -45,13 +45,13 @@ test_expect_success 'warn about add.interactive.useBuiltin' '
>   	cat >expect <<-\EOF &&
>   	warning: the add.interactive.useBuiltin setting has been removed!
>   	See its entry in '\''git help config'\'' for details.
> -	No changes.
>   	EOF
> +	echo "No changes." >expect.out &&
>   
>   	for v in = =true =false
>   	do
>   		git -c "add.interactive.useBuiltin$v" add -p >out 2>actual &&
> -		test_must_be_empty out &&
> +		test_cmp expect.out out &&
>   		test_cmp expect actual || return 1
>   	done
>   '
> @@ -335,13 +335,13 @@ test_expect_success 'different prompts for mode change/deleted' '
>   
>   test_expect_success 'correct message when there is nothing to do' '
>   	git reset --hard &&
> -	git add -p 2>err &&
> -	test_grep "No changes" err &&
> +	git add -p >out &&
> +	test_grep "No changes" out &&
>   	printf "\\0123" >binary &&
>   	git add binary &&
>   	printf "\\0abc" >binary &&
> -	git add -p 2>err &&
> -	test_grep "Only binary files changed" err
> +	git add -p >out &&
> +	test_grep "Only binary files changed" out
>   '
>   
>   test_expect_success 'setup again' '
