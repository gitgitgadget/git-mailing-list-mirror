Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D73F4DC0
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484273; cv=none; b=ahVCMkvDvNAv2+T+nMLra3Agw9G7h2WHq6lHFPh4OyhMboiQdlkLu31jR8/ofz28daS7m6UpKmE43ya/IwY6HtphqzaIT6afuXLc0hjLdhYMR7Cs70Xt4xesd0XUYjSFjkAigDZZ1NxLoBo4Ss10wAwGRG+g4FjPOV5VH6xblUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484273; c=relaxed/simple;
	bh=6wJ9PiORBR5H1bVkdJuN7s/WCXnyeQsOAPjg3/6CDzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1Dhh82SN0r2wdD+K0mWCgff06N8iDQ4xmCtuZi/pjCERh65nrFlZ2GI0fBZS2RkzM63ZXhYCTkcSOSO+IdneY4IwnP4NPx4o90iI1SqQKbSgSuKxxEhKMTZXdIO0tp6CKdyXyavXp4d6eVR1KjhPviXQUNUYB3RMeL+9JNfYFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHr6C6pJ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHr6C6pJ"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8e066990ff9so11067146d6.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782484271; x=1783089071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JniGvmaIB0MHFf47TpgA6KqIyeq/N1HRdzEvAtOLJak=;
        b=jHr6C6pJDIudBZmIaczkBO1UDghHfRaekEUXVsxTJTaSEWYBQ2lvwhj6BB6QKbc5el
         UnA88Qt+slt6mhqwK9Fi2VZJUVP+d9vIiftfvzQb8y5CcDo42tHoqXAa6MHE8jkZlm0P
         QhOTTajf11z5oJj3X4lxo/moK6zPpb2Eia8idFPmX5GCJFRRI9c+9cfqry46P1k2nu/d
         OjPr7mx52M0P7WN49SdtOgI7+p37RKJ4KNPNDlOFoZvuKlHjuXzvd7KDGo5ujCklcX3t
         W54X/2rDwpewlS5eUp9hDYvcWbLjD6Hj6h4z7pi+hqkNCVpyzPzkBtIUTFcE/3IaEgGM
         Q0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782484271; x=1783089071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JniGvmaIB0MHFf47TpgA6KqIyeq/N1HRdzEvAtOLJak=;
        b=tLB+1wgbZK+Gok3UfMpE+FA/mombJQb7MBdnxbrBxov9malQnuyyesqTGD0umSrWhC
         lECRw28NOUCz1g3BpW0HUuKwG9AnvK6JMgGrPdPf/szU/91iHq4tWOnXAO3R/2D7QogA
         lS4K8FMfjDnh/M8lABEEtPh1MivewCHQtofPmWnxGNLXtQWPYafEo4ks3UUaolZXdHQ5
         lhm186qj747NS6PnzOiIpnkmIq9jhklSUmZEN5mhVUCkrIH6gLh6J8jA9/B2y/Fwzi7z
         WvO8aTUHlL0htMUFoOzIOk/Kklg98xB+jjHPdvKCicjJ54NMcik4bjG8aK0UF14XjQa4
         thQw==
X-Forwarded-Encrypted: i=1; AHgh+RqkJO9uvXf1v+rcgQzbyaeJjUH8lLRxsppo3LVeRFvycOSYUn0HSAT/UZ/v3ykJKfvIWCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQVsFx46tp8bNk9luUGaVCQhs1U7lBDohhR37S9gqbbzrRjzf
	fOVIeMf0ZxxsA1Z5+ZfrQKMFHR33Dknf62cJeauvwytnxISw4meWoFT7
X-Gm-Gg: AfdE7cmtgj3Gx+26IXtvVdxcEhY8l4QvEMe6QEF6UzSkhdW+1EVJFVsTEbGuytKWHc+
	njWTwIHzoodw6hUn8x76WnCYXvfEnY/SyI/VB6ehEq5Un+3ArqequE3E7ajqB3ffPunimxOwGey
	6vMRAR1IkTqTu21y3n+R4ds1Fd9hLlkM5HTe9jxuEX4H96XkQBAVBrKY4eOKaUePnwpISBdRul3
	cBAtJ/CJ6KexB3lfqAqSF9ujvnTLNgfLFwEccubhb8fcRD9XkbNhdrwWWdtT/fSjM9KNFuHOWuu
	ChcF/ikuNT0B7AHfJebCEwlws6C2ffT7se8mafb0Orl8D/pU7YZkagwJ2UmndhD8xqsdpe4hl+r
	7KlmUT7AbB3P6r5xYRbHhYu3eVjPA83LsbvoBlEWaYItZyi1N5efRdIu4oznl/5Vgcm/2YOe5x4
	S7SHq05T03Fx2rwoZ23TJtwJ5sol91qx5y0NTwwdNQhZus34HjdLnMc9Y5qA==
X-Received: by 2002:a05:6214:f29:b0:8df:2612:186b with SMTP id 6a1803df08f44-8e6deb07b3fmr65590976d6.18.1782484271088;
        Fri, 26 Jun 2026 07:31:11 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f018011sm220728036d6.5.2026.06.26.07.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 07:31:10 -0700 (PDT)
Message-ID: <a74d3114-7d7f-469a-b181-60853bb82864@gmail.com>
Date: Fri, 26 Jun 2026 10:31:09 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] commit-reach: add trace2 instrumentation to
 paint_down_to_common()
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
 <2592264cda543c96c4479bb4ba6368c0121e4207.1782479286.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <2592264cda543c96c4479bb4ba6368c0121e4207.1782479286.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/2026 9:08 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>

>  run_all_modes () {
> -	test_when_finished rm -rf .git/objects/info/commit-graph &&
> -	"$@" <input >actual &&
> -	test_cmp expect actual &&
> -	cp commit-graph-full .git/objects/info/commit-graph &&
> -	"$@" <input >actual &&
> -	test_cmp expect actual &&
> -	cp commit-graph-half .git/objects/info/commit-graph &&
> -	"$@" <input >actual &&
> -	test_cmp expect actual &&
> -	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
> -	"$@" <input >actual &&
> -	test_cmp expect actual
> +	graph=.git/objects/info/commit-graph &&
> +	test_when_finished rm -rf "$graph" "${graph}s" &&
> +	rm -f trace-mode-*.txt &&
> +
> +	for mode in none full half no-gdat
> +	do
> +		rm -rf "$graph" "${graph}s" &&
> +		cp "commit-graph-${mode}" "$graph" 2>/dev/null ||
> +		true &&
> +		GIT_TRACE2_EVENT="$(pwd)/trace-mode-${mode}.txt" \
> +			"$@" <input >actual &&
> +		test_cmp expect actual || return 1
> +	done
>  }

Thank you for putting these traces into this helper AND for
making it cleaner at the same time!

> +test_paint_down_steps () {
> +	for mode in none full half no-gdat
> +	do
> +		test_trace2_data paint_down_to_common steps "$1" \
> +			<"trace-mode-${mode}.txt" || return 1
> +		shift
> +	done
> +}
> +
>  test_expect_success 'ref_newer:miss' '
>  	cat >input <<-\EOF &&
>  	A:commit-5-7
> @@ -209,7 +219,8 @@ test_expect_success 'in_merge_bases_many:self' '
>  	X:commit-6-8
>  	EOF
>  	echo "in_merge_bases_many(A,X):1" >expect &&
> -	test_all_modes in_merge_bases_many
> +	test_all_modes in_merge_bases_many &&
> +	test_paint_down_steps 45 2 25 3
>  '

oooh that's clean. Thanks!

Way to over-achieve here. Thanks for going the extra mile with
this patch.

Thanks,
-Stolee

