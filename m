Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907619067C
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042553; cv=none; b=iZJ47m4dm08SaGm2/+bi16+dtkdSOz3liIgVdK6eFCneYyj+c2IFTSeVw60zg39XwIouBOSbc8uHT3IJrKXXEothjMmoOaW3fpVu6DKHs3Gn55C1OEgHzvxrCShe/xufcELsESil1A/+G+C24hVAZZLbPixGNjBCM/1AczPYr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042553; c=relaxed/simple;
	bh=o7kwYuT2lYwyfS1xWkvZn6ECmAmpFmqEMwH+vNTCrdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uH60YKcH2+QdGEA1cv8xWsmCj4EiFPHO1uWTqjSqH9l5bP8Y2g6w0BrK7zQ1TB1SziFUaVv6L6qCR6RBPn2NyJxr1IccVMEnO54cK+EASWC8Wy1QKOMBh+3SgVAfuHCM1nuOb7U1lsEPRwblAYQVwpiyAzMCpgQXMOECgFTzoTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY30SKKX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY30SKKX"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4256742f67fso42565715e9.3
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720042550; x=1720647350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOQCkXz58oaScC0EVJLKDtAV2YzmXihlCLqDyr01Xvc=;
        b=hY30SKKXep2RBsRKQ+VYGATmgb/6terc3GRsNBdnb2Zeswivl52lKXUENo8KuyMK9d
         M3Pg3G0GGdK8EYOpFpBkDHgEiPkvPNReYMO1+k3c1S69KNbGo+NttWNFRCv5w7nFD7HY
         T4OMw+wbdN1VqKAaHdw46kOLIDxGmX7v55MlkQlM1/P4qzxa6m0xY4RXfSea8bORU6/O
         2ZVDF4RS1UmGae3LkT0DhtSjXR3z4L+pAs4VTyxBPuVI/44q1CqkqwvDkbk+O75Y1yLD
         E3/wzDdmbJLbU44HiwfqxRzzqL6bEjK/yhst+byhHbQQFunzRWsV+lJP8RNH+aM2BFiH
         7EUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042550; x=1720647350;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOQCkXz58oaScC0EVJLKDtAV2YzmXihlCLqDyr01Xvc=;
        b=L+VhCN9EV/qYF8eR0olP7XySYIZ26QSbcY8c0TGGmTBOVOiqDF1xTqJP4SLKJdA+f7
         oyv2I7QIlUp49rqT/0mHiZGVqQR9yGwBd55S8yuwj2gfdZH53fzL83+LRvDaXsy3Qdbc
         FDxWt1l3NtAup0I6pnQuwX7kPHU09ZXFI+Gk0svTAI/+1kPbJu56qm3sswqmlEATB4XS
         g5UCA1Btcc3MktEf39/pP/4doonkqvLXRImj+TA8N2hefrv8EQH1k5gcl58phr0Sg68K
         wIq4p2qzY8TvmAkyGCa0vNX9mMqlNJWVTxwOEBdwmSG9r9cLYISmNcH/MdIVp1XKwJ7G
         tlSg==
X-Gm-Message-State: AOJu0YxbhTLwJFb1r2KHp5wWw0ybEOgEWDvyHIvEybyrOYX8qQre/mhD
	h2ymwQhDzhPoNsx/EbIr2ii2teh4SNZQ5UuIBUlyLI0Wzvimbqyc
X-Google-Smtp-Source: AGHT+IHIkFIM//mR2hnhEGFujEXTy6nYH0pTm1rqMXt76MFEhUOd4hfHExpnp8c9+JJ/GUt1WGuxeg==
X-Received: by 2002:a05:600c:5486:b0:425:5f86:41bf with SMTP id 5b1f17b1804b1-4257a02118bmr76068175e9.30.1720042550203;
        Wed, 03 Jul 2024 14:35:50 -0700 (PDT)
Received: from gmail.com (110.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a32asm255083625e9.31.2024.07.03.14.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 14:35:49 -0700 (PDT)
Message-ID: <bda01080-1231-476a-9770-88b62a75ffe2@gmail.com>
Date: Wed, 3 Jul 2024 23:35:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <f4ae6e2a-218a-419c-b6c4-59a08be247a0@gmail.com>
 <xmqqv81ovp9l.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqv81ovp9l.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jul 01, 2024 at 01:19:34PM -0700, Junio C Hamano wrote:

> Your patch from September 2023 [*] did mention it upfront:
> 
>     GIT_TEST_SANITIZE_LEAK_LOG=true with a test that leaks, will
>     make the test return zero unintentionally.
> 
> With that inserted in front of the proposed log message, the
> resulting explanation looks reasonable to me.

I see that you have already added this paragraph to what is already in
"seen". OK.

> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 79d3e0e7d9..7ed6d3fc47 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -1269,9 +1269,12 @@ check_test_results_san_file_ () {
> >  	then
> >  		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check" &&
> >  		invert_exit_code=t
> > -	else
> > +	elif test "$test_failure" = 0
> > +	then
> >  		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!" &&
> >  		invert_exit_code=t
> > +	else
> > +		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak..."
> >  	fi
> >  }
> 
> This is outside the scope of this patch simply because it is
> inherited from the original, but does ", exit non-zero!"  part of
> the message really add any value?

Explicitly indicating that the error is being forced due to
"GIT_TEST_SANITIZE_LEAK_LOG=true", for a test that doesn't fail when run
normally or even when run with just
"GIT_TEST_PASSING_SANITIZE_LEAK=yes", could save us some confusion.

So, I dunno.

Anyway, I agree that this can be addressed later.

Thanks.
