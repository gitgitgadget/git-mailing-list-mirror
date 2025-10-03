Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC766BA3D
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498902; cv=none; b=mFD1FUQHszfPo+PKZM3VOLTRm3HuZtFsSOI2lYg8lc3VsY4XRy5k/t3Tnh7//+ibTgtECqY1dbF73ThublCC6IBKfgBob1r7c6wuTIZN2CHTLNNbXacEZiPtyjHJMoSbR52UUWNXRXVAWreaInPmM6t4HGdL53MrczoJEb+Eu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498902; c=relaxed/simple;
	bh=ZzIKy3xUUf4EaaQ7aa/CyMsCmq8oD5UWGr4jhBD/wFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwD1ErMd9htay2rmop4aK4HLq7MdkrgdKrtVhDBz8SoVKXxGwvvDiKdTVc00TOqmK/jfu0rBLRw0lhutOEaPqnYa+JIzAy0x2olQhGY99ykEs8/2wiOCnRbs1r+ehMgaZlRZ6o1pXraq1nF6j1MsnwksuVNrgGdJ0gJpSVShCdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3HOFxRl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3HOFxRl"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so13856655e9.1
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 06:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759498899; x=1760103699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yVGAL19XK4DIzUgp1OR+6noBzObtN9CulhoTEn8G0rU=;
        b=I3HOFxRlg5vE4S1H0sd2LJ+sxot8rJwsvoSUtBeyJwwmEaCwMvvo/cBY5CWftLwP02
         RiqxCJPAxggGVk8QSUaqLEFASL7FyunH0B9KpmW/yaRNOt+JTzUitKHec0OHiFGdng0q
         sFLIEDcd8Q5qYirJETv8+3Ovbo36lXdQlqKyYTrEfiaU0Io8ThKR5TiWs8Pei7nvfbSj
         nIubcHrrJy+ZrgwDnLN5nKQYFa4fBTC/bAeAyoVZhUiVp3EvavNVs4VdpZjGlxMZrG+D
         /rmtXvzfDWruV0vMM4wBuH2lp1MG3UmZGIIsrjaKx5E68NnVIdQXSbj0CyWiMW1GUY5N
         GdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498899; x=1760103699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVGAL19XK4DIzUgp1OR+6noBzObtN9CulhoTEn8G0rU=;
        b=Eb7PI71qanQSTo8csuCun81Jx28U47oK8jpR35+NH1VC3hVErvv3RLtHeluHclAKLz
         IgEKxymWHJ6u0RBKiNGHNYsbCSwfe/va1gVwKTAvxPZXCsQzOcHwfclT0hnMHy4R6P09
         K8rVNJgExba+pES7diX7MSgYdGiNMPIuj5yiwYed27YwTozatC7QWvS8y70o1o980KoK
         x+OD6fqNMQJjBEIV7imR0+9OR4TpTsIiwQXnWEk2uUtbXAeYdBiM0ZR4LTx2NseJXS7q
         UUpYmk/LeovPpNB/2tguPsCe8ksI/09TQ5d+E7SjPwYpjWxxw953I4hPp3IohIfkt9Zu
         RWDw==
X-Forwarded-Encrypted: i=1; AJvYcCWhroOYfeZ3iDlTylT2BGdQRTun2wlhYGjt86KQk6YscDQQaC3IbpEbfDcpG9G3fgdsBvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysWjoIdCVOf4p6zi6wFpAGXmqB+7tuKsfbUJ203NN+j4FsIShf
	z5fwrnCt7Ft/zbUhfODMxJ0VXAplNACyt71eFV2CPEG9xCoLymI995Id
X-Gm-Gg: ASbGncsI+gpu45zdUgJiAvwUjvkvuCcO3xpLFrkpoOxvPzvfSdeMFv9HT8fOeI8fd1G
	eb3lkUTpHY/BqKGua1AR2bIl8QqNCwZLvNYn3TpNd6bU5GqjO9R3g8YEwQ86zt36JM5USLu8vTH
	E7x16UlO/wn5GNRbwuH3Ztk9gILfaNXub/CtSRivRMmn6K8JRSigkNkE+26cz+MEivx0+vCC7x8
	8cLEl0RniCH9RoMixRgbQnrxlFG0OJiQToJgodnSVmmUH0nLYhTF+fPl6M66QYDAh84bgAV/+QK
	gn4Er4Rmj79EBT/Fxub5OTZCeAKncGuPLzaJd/F0QjAphIm+3H9wo/udGETZqWiIfZHpXj/J0tx
	aqxhs5PDj6Rder9j0DrYx5wLrSyKS045KCK3Q9/X5K+WJu9yMz8SbPnGbPBQdbjzCIpoGDD7wrY
	YtMfIhaunx5vSAl8qoy9+BFaKUEEzT2FOE/Q==
X-Google-Smtp-Source: AGHT+IHK0anNL0HWa+e512GvEUsZZ6+GEdOAalcNCbvg6ctrwmANvefG/srks1nqSwjvy5zDx2ITvg==
X-Received: by 2002:a05:600c:154a:b0:46e:45d3:82fa with SMTP id 5b1f17b1804b1-46e7226ec1amr19812955e9.10.1759498898790;
        Fri, 03 Oct 2025 06:41:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f027csm7961652f8f.40.2025.10.03.06.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 06:41:38 -0700 (PDT)
Message-ID: <8fdfb03a-6bbc-46a0-a8fe-9ad75aba555a@gmail.com>
Date: Fri, 3 Oct 2025 14:41:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add-patch: roll over to next undecided hunk
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Windl, Ulrich" <u.windl@ukr.de>, "git@vger.kernel.org" <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <76665b6f-cb92-4694-bc89-5eb21197df34@web.de>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <76665b6f-cb92-4694-bc89-5eb21197df34@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 03/10/2025 13:16, René Scharfe wrote:
> git add --patch presents diff hunks one after the other, asking whether
> to add them.  If we mark some as undecided, e.g. with J, then it will
> start over after reaching the last hunk.  It always starts over at the
> very first hunk, though, even if we already decided on it.  Skip
> decided hunks when rolling over instead.

Nice

> @@ -1436,8 +1436,15 @@ static int patch_update_file(struct add_p_state *s,
>   	render_diff_header(s, file_diff, colored, &s->buf);
>   	fputs(s->buf.buf, stdout);
>   	for (;;) {
> -		if (hunk_index >= file_diff->hunk_nr)
> +		if (hunk_index >= file_diff->hunk_nr) {
>   			hunk_index = 0;
> +			for (i = 0; i < file_diff->hunk_nr; i++) {
> +				if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
> +					hunk_index = i;
> +					break;
> +				}
> +			}
> +		}
>   		hunk = file_diff->hunk_nr
>   				? file_diff->hunk + hunk_index

If there were no undecided hunks then this will be out of bounds because 
hunk_index >= file_diff->hunk_nr. Are we absolutely certain that we 
cannot reach this point without at least one hunk being undecided?

> +test_expect_success 'roll over to next undecided (1)' '
> +	test_write_lines a b c d e f g h i j k l m n o p q >file &&
> +	git add file &&
> +	test_write_lines X b c d e f g h X j k l m n o p X >file &&
> +	test_write_lines J y y q | git add -p >actual &&
> +	test_write_lines 1 2 3 1 >expect &&
> +	sed -ne "s-/.*--" -e "s-^(--p" <actual >hunks &&
> +	test_cmp expect hunks
> +'

I'm not sure what this first test adds, the one below checks that we 
find the first undecided hunk which seems to be the important thing to 
check.

Thanks

Phillip

> +test_expect_success 'roll over to next undecided (2)' '
> +	test_write_lines a b c d e f g h i j k l m n o p q >file &&
> +	git add file &&
> +	test_write_lines X b c d e f g h X j k l m n o p X >file &&
> +	test_write_lines y J y q | git add -p >actual &&
> +	test_write_lines 1 2 3 2 >expect &&
> +	sed -ne "s-/.*--" -e "s-^(--p" <actual >hunks &&
> +	test_cmp expect hunks
> +'
> +
>   test_expect_success 'set up base for -p color tests' '
>   	echo commit >file &&
>   	git commit -am "commit state" &&

