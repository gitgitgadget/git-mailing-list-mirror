Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ECA18EA2
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908265; cv=none; b=EenR/9JG7xb+orrfpheoSKVeVoQZRsCCTqIDs8+vNKf69pFA3kp0eEFnNBUoJeT1MRXNEPzl+QOv3pibHhfDtoBghSH0oH7qrh2Jq5r4xN1fjXNIXzebtoxUYS4ebo3aLLlHrMwIFuRBjE+FwlLkcq8Qi2a8BV9xRKeQDDMPRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908265; c=relaxed/simple;
	bh=/7PqvRHiSnNFKTLMeR1xQ3NW/kqRSFm13NyAxVZnsnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdbWRO/WH3hwHICPOs1sSIcxZr7uQH43WHlL1tHHePMR1zkKIv0JOHgaaI1p/KCrRavOfOp55G0oqBbEatKyEHUYaLBehcFKCKmQW325sUAvWbc75OPTGAc5OPvkgBzQCB81eF6wPqYNGTMfw/fRTAc0gGkj0eW8cmUAPXwzMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJC+bz3x; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJC+bz3x"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-411d253098eso8459275e9.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707908259; x=1708513059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ6VEAXZ0oYNzZTQZGoPSM34Q+Oh1aDmgu2dUI9a6Ms=;
        b=AJC+bz3x5hmXIbsiUpRQLb9vTfIZ5Anh4EJ3Lc4CtNSP1nvQHnto2m8Br2a4Gi99+s
         H+8Msf8aB89JI0g0A48pv0dcNkc0V/PhFTBGbizH1xWzGfBvROaV/NvKlI1TdZvzTEEi
         SpNAQVPTeDbgqVIZDHsl8t+3Zv6Eyf9uRR5neJPi+uGcion4Eq+5+M3+cv/SxPtQvo8m
         ZRDoJJom3ZHrMtdRnZCZKZ5vq6Nu569YWv3NId/m7CJwhZNybj3975FrqckjkprgnEYa
         9tHoFH+bJaD+puaPQvzqUX5yg9fih+E7qCiIRqS2tnEuKu5srJVAE4vHdFjN2NCs/WKo
         VGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707908259; x=1708513059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJ6VEAXZ0oYNzZTQZGoPSM34Q+Oh1aDmgu2dUI9a6Ms=;
        b=Es6KBw3wScWJlbTqRPAMCnkEognznLYmSfOHaGPZ0zEPWVzfO00dWsB4dPNAK5WtQo
         qCupm5zsk5knBNwisyoCJKwGLDSCxak/iZBLkpI1XrkugG/nHePNHfWsUP0JcZg/ciiT
         IjbyiLh4psJ8X011EkZuruWzJBEH190Fo/+pI0K0aQSrYmYkpyOnTZJWURsTH7dghpSm
         rXxvCrLSBfK6WZvnsVsXsFp3inkRu+JkFiedNeiZfFKW7NwuCN3gtaA0SdLxDS3vbMJv
         DO7fw41saAo61NnIkwseSihZ/aSqpEDrLH/OtEhTQE3cr9IH9dttny/bOnH1r9hj3yYA
         RO1g==
X-Forwarded-Encrypted: i=1; AJvYcCXq7HMH/mEbnLDbxw9s9UNZ3xmfLZVUYvQivgEnDlmdIi8CRnLgiP4HCx48cyvoe8bxl/vE4Xos242mpTC53CUU+Nms
X-Gm-Message-State: AOJu0YwlDyk+vJdiB3INxp/pi5ElwA0kZQ3yOZT7GyD0KFFUkJXC7e7K
	lMk0i4Owi12gOxzjOzeLkFCwG2266CaqRww476yKT4sgJX2Ywh9e
X-Google-Smtp-Source: AGHT+IGoAZxkUL3lY/u64j4Yp0s2rWO0lX/pcpItzo4a2vO1b4Ir8F9eltIlsFRcRb5D0mNY6Wwyuw==
X-Received: by 2002:a05:600c:138b:b0:410:c804:e891 with SMTP id u11-20020a05600c138b00b00410c804e891mr1959329wmf.16.1707908258643;
        Wed, 14 Feb 2024 02:57:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgDSwmU0PQKxH4MyRrzadrw+xoFxOfZVGbypx7v9xObaSeADaJIhIi13mOhZkK0EFND5gNCt/hMhjpi+KYXz7LdHECGcUohQ+QsI9MMWq/9pIzRnhWBpzUiomUCuvfWcnMlfyGv3KnKXkdKuhqAqSWY4cqmpEEv7wt/RyThIZOfQ==
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id h14-20020a05600c314e00b00411ee1dd5afsm1196183wmo.16.2024.02.14.02.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 02:57:38 -0800 (PST)
Message-ID: <bc0bf723-ccde-469d-853e-4a94531ea60b@gmail.com>
Date: Wed, 14 Feb 2024 10:57:38 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug report: Incorrect GIT_FLUSH behavior in 2.43.1 (regression
 and breaking)
To: Junio C Hamano <gitster@pobox.com>
Cc: Xiaoguang WANG <wxiaoguang@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
References: <CABn0oJvg3M_kBW-u=j3QhKnO=6QOzk-YFTgonYw_UvFS1NTX4g@mail.gmail.com>
 <xmqq8r3p7glr.fsf@gitster.g> <c243c260-b346-4b53-b8a2-685389ad344e@gmail.com>
 <xmqqle7o6zs8.fsf@gitster.g> <xmqqbk8k5eo0.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqbk8k5eo0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 13/02/2024 19:48, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Unfortunately the minimum fix is already in 'next', so let me turn
>> what you wrote into an update relative to that.  I'll assume your
>> patch in the discussion is signed-off already?
> 
> Nah, my mistake.  The topic still is outside 'next', so I'll replace
> it with the attached while queuing.
 >
> Thanks.
> 
> ------- >8 ------------- >8 ------------- >8 -------
> Subject: [PATCH] write-or-die: fix the polarity of GIT_FLUSH environment variable
> 
> When GIT_FLUSH is set to 1, true, on, yes, then we should disable
> skip_stdout_flush, but the conversion somehow did the opposite.
> 
> With the understanding of the original motivation behind "skip" in
> 06f59e9f (Don't fflush(stdout) when it's not helpful, 2007-06-29),
> we can sympathize with the current naming (we wanted to avoid
> useless flushing of stdout by default, with an escape hatch to
> always flush), but it is still not a good excuse.
> 
> Retire the "skip_stdout_flush" variable and replace it with "flush_stdout"
> that tells if we do or do not want to run fflush().

I think the patch looks good and the commit message nicely explains why 
we want to change the name of the variable.

Best Wishes

Phillip

> Reported-by: Xiaoguang WANG <wxiaoguang@gmail.com>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   write-or-die.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/write-or-die.c b/write-or-die.c
> index 3942152865..01a9a51fa2 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -18,20 +18,20 @@
>    */
>   void maybe_flush_or_die(FILE *f, const char *desc)
>   {
> -	static int skip_stdout_flush = -1;
> -
>   	if (f == stdout) {
> -		if (skip_stdout_flush < 0) {
> -			skip_stdout_flush = git_env_bool("GIT_FLUSH", -1);
> -			if (skip_stdout_flush < 0) {
> +		static int force_flush_stdout = -1;
> +
> +		if (force_flush_stdout < 0) {
> +			force_flush_stdout = git_env_bool("GIT_FLUSH", -1);
> +			if (force_flush_stdout < 0) {
>   				struct stat st;
>   				if (fstat(fileno(stdout), &st))
> -					skip_stdout_flush = 0;
> +					force_flush_stdout = 1;
>   				else
> -					skip_stdout_flush = S_ISREG(st.st_mode);
> +					force_flush_stdout = !S_ISREG(st.st_mode);
>   			}
>   		}
> -		if (skip_stdout_flush && !ferror(f))
> +		if (!force_flush_stdout && !ferror(f))
>   			return;
>   	}
>   	if (fflush(f)) {

