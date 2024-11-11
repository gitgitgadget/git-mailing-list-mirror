Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176E21474B9
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322443; cv=none; b=eI/hkIu2H0+hZLG8Zds2uWeclKih5ylP2ccBpqrkuxWNP1N2f2spdZd5iWl7LCiXIPPZ4E3OMwtap3uNNJIkrM2bpiVmGi65ieX3Nj1cmg0lCKH5TIsGES+U/r8gBc1LVVTYuQB3ycfDQhj7/l2qYZfpUz0zPQOCToZ8Jp2zy94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322443; c=relaxed/simple;
	bh=gPLTT3Equn+BvsBkv9R8/D5wypburkwdepFLuS1cL38=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=niYEqMQ5Zz3Dc+Y7bk5U5qrojhIYF90bfj7ckt9Vyoabvz7HcTfTtGi2iXtA6Q6/+QBt8Z1bw3oQUH/utR/fPBRa9xcWEzxLWA5m1qSDySUMffBToYvoD8I1z9wk+B11yAxzOCsmPxuwwInQYw0p/RpNdBfaEyDxoblWyhVEWik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RB+7vSgZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB+7vSgZ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d8901cb98so3079300f8f.0
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 02:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731322440; x=1731927240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnZN2fUQf360D7m9VMxXlBRoYOrA63LwhMNeaL5HRcE=;
        b=RB+7vSgZQTYVqCOVRrO3H4bMHaNV+r5R7oPDQVW+Z1umCRmG8FDAKz6j5ksy20nJOI
         Jk4sGp0N8zUt45a2uf2NWl/vhPe3IYYYKMQ7lD3/eCHhKgZJb2stuu5FWTGiN0wwdF4r
         A6+5ve/YZS+8pJLuUJr+MjfiPkA2y4M7PLbDCzrONPrBpup9HscYdrkJi49dleEd3gpl
         NeTAj59jZwp652VcrzOlvKin+dLLcak08XrMqvULuK4iC4ukOaoQFD9v2MlDRSEscsCv
         kKtcDNCF5qph1125Z/I+5X4/zx6Lc6YtYwb9C+MFJBYJmUopwjW3hogvHT9AVenfEhNU
         ayBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322440; x=1731927240;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnZN2fUQf360D7m9VMxXlBRoYOrA63LwhMNeaL5HRcE=;
        b=CDjpJoN8msc62ZNjCMrz53391+2mKHnZyg17FIXh2JFABpK1jT+b0PUfvti7Or3Ntu
         Gtf9ErkVrx+P5b/twxXkqddtm8cutPQsqyTsarlVgETgjt9MQbyzAYoDakDfh+jTCxtq
         wTRTdyuLunDr26xIo5pmE9U3GImVmM1+5T5QWoGYWILqLHxB7L6gbY/chUuiIFS+AoOR
         Xjn/2+gcCZwiL9GhU7CdkBH7DkvlFK8Fp6uHuCF1RHCqTbphFnEGXyW1YLkUIpEoDubu
         mBR9UEJbN2fBOx1LMjSkO5iDBZQRo4HzvJDPU6dBkAhCXfow8Fe1uGkdysUEbzrvwNqK
         Eo8w==
X-Forwarded-Encrypted: i=1; AJvYcCXFdNbWPyP3u7R2N7uWGfytRgKx+SCa548431nNfk4O3uL1/FLd6PPgrMK7+N/ubI0Dh/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/4f/alwxSZEivZxkJv/64fkq93JkiN3eEAjnjJhg2I3pPth4
	Vx65w0psFik59zADEiamHphHxw45qP9opCq2tOLYg+eIFhynAG6+
X-Google-Smtp-Source: AGHT+IFjHE76SidAko1HL8Y0EpfcAhXmWc7xFQD9jtmVNNRsVat0Uwz8i0baI+AUNXb/pXrLpq/SBA==
X-Received: by 2002:a05:6000:18ac:b0:37d:34e7:6d24 with SMTP id ffacd0b85a97d-381f0f7eedemr10429293f8f.18.1731322440173;
        Mon, 11 Nov 2024 02:54:00 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6b0:6601:912:e3ec:c1c0:993e? ([2a0a:ef40:6b0:6601:912:e3ec:c1c0:993e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa709f3fsm212975135e9.32.2024.11.11.02.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 02:53:59 -0800 (PST)
Message-ID: <6a608200-2dd5-4505-9e1d-1e161ae2896c@gmail.com>
Date: Mon, 11 Nov 2024 10:53:58 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [RFC PATCH v4 05/19] Makefile: use "generate-perl.sh" to massage
 Perl library
Reply-To: phillip.wood@dunelm.org.uk
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <eddafe1cf8935fd25d107645168ace3f65e1064c.1729771605.git.ps@pks.im>
Content-Language: en-US
In-Reply-To: <eddafe1cf8935fd25d107645168ace3f65e1064c.1729771605.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 24/10/2024 13:39, Patrick Steinhardt wrote:
> diff --git a/generate-perl.sh b/generate-perl.sh
> index 12e116b76e5..cb1629857c6 100755
> --- a/generate-perl.sh
> +++ b/generate-perl.sh
> @@ -17,10 +17,20 @@ OUTPUT="$5"
>   . "$GIT_BUILD_OPTIONS"

I need to add

case "$OUTPUT" in
*.pm)
	dir="$(dirname $OUTPUT)"
	if ! test -d "$dir"
	then
		mkdir -p "$dir"
	fi
     ;;
esac

to create the output directories when building out of tree using CMake 
on Linux. I'm not sure why it works on Windows without this, or why we 
don't need to create the leading directories when generating 
clar-decls.h or clar.suite as CMake seems to do it for us when it 
initializes the build directory.

>   sed -e '1{' \
> +    -e "	/^#!.*perl/!b" \
>       -e "	s|#!.*perl|#!$PERL_PATH|" \
>       -e "	r $PERL_HEADER" \
>       -e '	G' \
>       -e '}' \
> -    -e "s/@GIT_VERSION@/$GIT_VERSION/g" \
> +    -e "s|@GIT_VERSION@|$GIT_VERSION|g" \
> +    -e "s|@LOCALEDIR@|$PERL_LOCALEDIR|g" \
> +    -e "s|@NO_GETTEXT@|$NO_GETTEXT|g" \
> +    -e "s|@NO_PERL_CPAN_FALLBACKS@|$NO_PERL_CPAN_FALLBACKS|g" \
>       "$INPUT" >"$OUTPUT"
> -chmod a+x "$OUTPUT"
> +
> +case "$(basename "$INPUT")" in

Nit: there's no need to call "basename" here as "*" will match directory 
separators in a case statement.

Best Wishes

Phillip

> +*.perl)
> +	chmod a+x "$OUTPUT";;
> +*)
> +	;;
> +esac

