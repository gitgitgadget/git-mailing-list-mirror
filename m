Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D552D15382C
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515314; cv=none; b=VT7dAFFkpXLt2Vp5qH05/HBJw9zjYapcdG+juRorcZBBQutgsJ6QApsEjNzfk99VXHA/JodyY1dVAeDX6f+gHLEu92FcSWxAUpyKGdQko1UsLO+qEJtTRm0N1uFKrEHPE3WCoYiFu1aXrCus13PK022KUV/NKd2hT5ndH7CmNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515314; c=relaxed/simple;
	bh=JqNMUEe4zEWBEwlrGLsgYOk2QQRHOgyGR0fiuo6GdRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5j/PniQbouU32qlLsn5AKAoeSjyxaiUOCa/awjXNYlyTiPljGmZGd98jkMTkXtiSbXucFz1TsmY9H2KNYCUK+oWEi4+tXJt5/wEhL3sZzvHqyTAUFkbXLyHQ4up1vNHnhbm+4zLeZjUxY1ngnSbZd4z2UuEtpabHp2iNP1xe0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbyeqscA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbyeqscA"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so41585675e9.2
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 01:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720515311; x=1721120111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o7YEjhRj80/20Chu5fWsPDhz4TmYJ5B5GEjRNIb7x2I=;
        b=bbyeqscAAQ5T2BhZD9BYnkrVb4zeq2C6NeMoi54Ywf+d2w1bZZepcldcqJ+j9jXPDP
         FboQgUhZNQCVZlprGwJVN4hd2ZAv+QwV1ySlfyveDXVO2BgF5RZjllVJaV0RNXmFKww7
         MnHKkmPPfzm5GKXY/XFmcfmj2ydMWG0Bwgu/peDB9SAiiHwkNAyFZddTlsSTFhvpMaUo
         rwsQSGu2f25InppExPLaWbkmNdX6QZS78sNaBAxqwcKfjmpSy7QLDPftmAAJL83y0pEq
         iOOoXbNgvLO7tFI9EjcSnRW9ggkiIOdYEmhjArnx+TQBZFXdG7bArq2RLkDvURHm1FnP
         zHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720515311; x=1721120111;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7YEjhRj80/20Chu5fWsPDhz4TmYJ5B5GEjRNIb7x2I=;
        b=Mwx3WeCId9xdYyAckIvJa09zLzJEBW5FRCWNRWbn4tq6gK2ZSmbi1L9h21xn4WdfQf
         3EdfdwpH82yBUe3dPZh6pZOFIqvc6boruo0dDyOatOjV/y+aQr0uOXr12PRSvpudGDms
         sHUfRmX1zCDTDQTuhk7mEQvjAiKRSb0Zsx6PtUF36kmEZpJpvXV149q5WIxDxZCY7drV
         qLpx3iGTdwKvct2tM101FKcp6OfDufB4NomBggoTzvo1HEN9UJleta1ubVfx4PB0VsmT
         2WUy3LIaublXlHHm628D2kLMR/jj5LNQqRXajH8yOy1t6RUjLBWJslIOdZDf6DK2i6tq
         mADA==
X-Forwarded-Encrypted: i=1; AJvYcCVVgnbfxlQWfS7dF45o/F3iXaSdAyPTyE0vo0ZSS/Lb3DZeN+TpYCba6vbJyDha9hMWv4vFCjJlz2SixV6VQEW4WFp1
X-Gm-Message-State: AOJu0YzYAinM/fq6fKV1vkqXPgoISGe4pDB5ifUsU+NskSVgwPnN3yRN
	LISaM+QralFjn7Ku4oKnk1G/RYMvEMH5jkPZEEBAVmpxrDr/F8JO
X-Google-Smtp-Source: AGHT+IHSW2hi74oaZuVnEYEXgGXQ6bw7Gs2/74IEigz2goh3bU6uIns0NfLvvVjVcwPO0sfeIJ/gSw==
X-Received: by 2002:a05:6000:929:b0:366:ddb6:a067 with SMTP id ffacd0b85a97d-367cea6c084mr1626726f8f.20.1720515310925;
        Tue, 09 Jul 2024 01:55:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde84912sm1934914f8f.40.2024.07.09.01.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 01:55:10 -0700 (PDT)
Message-ID: <8612a47b-18c4-4071-8827-56b4f3bd0d80@gmail.com>
Date: Tue, 9 Jul 2024 09:55:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] var(win32): do report the GIT_SHELL_PATH that is actually
 used
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 08/07/2024 14:02, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks for putting a patch together so quickly

>   static char *shell_path(int ident_flag UNUSED)
>   {
> +#ifdef WIN32
> +	char *p = locate_in_PATH("sh");

If I'm reading is_busybox_applet() (which only exists in 
git-for-windows) correctly then this will return "busybox.exe" under 
mingit-busybox rather than ash.exe, so the calling program would have to 
know to set argv[0] (which is likely not possible unless the calling 
program is written in C) or pass "sh" as the first argument. As the code 
to support busybox does not exist upstream I guess that's best handled 
downstream.

Best Wishes

Phillip

> +	convert_slashes(p);
> +	return p;
> +#else
>   	return xstrdup(SHELL_PATH);
> +#endif
>   }
>   
>   static char *git_attr_val_system(int ident_flag UNUSED)
> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> index ff4fd9348cc..9fc58823873 100755
> --- a/t/t0007-git-var.sh
> +++ b/t/t0007-git-var.sh
> @@ -157,7 +157,7 @@ test_expect_success POSIXPERM 'GIT_SHELL_PATH points to a valid executable' '
>   test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' '
>   	shellpath=$(git var GIT_SHELL_PATH) &&
>   	case "$shellpath" in
> -	*sh) ;;
> +	[A-Z]:/*/sh.exe) test -f "$shellpath";;
>   	*) return 1;;
>   	esac
>   '
> 
> base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
