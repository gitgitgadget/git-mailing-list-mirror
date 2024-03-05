Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2612D1FA
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709679156; cv=none; b=LslDXAbyMXR06XpQFRcw+90F1nbaDMNA4y5DwHA8hbl2B38SGXuKyjXpDfy3Ayrm8hni+WZZlhjZ0+iGWE1dHFt/UAItKwAvVjEUCSiV81FzlRSWXgk7uAsRcc+mQ/CKa8oiWV/rt2pu4K8C+2tgY7Q8jV2Ic7WGfV1pD1ZJ/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709679156; c=relaxed/simple;
	bh=x5XSgAwByyZQa2dYotOz6IqdOeMJ/HjuTShSqW4sp1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hy+N8lAUIeD6uGWZtzhbCUhIFSqvDyqH2YpqOotUrFKq0oLUGl1bNYg0zUix482OW9wOHDRzoU0guIKjckUd3t6z1c/s7e1GjYomubdVzb7j9fMySEjC9zXkiMIT5Y/jiTqFCRjppnnFVKHvoHdFiD5xlrwlgFhmLsJZ6rBfmCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8Y6qkHy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8Y6qkHy"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412eeb018ffso8357275e9.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 14:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709679153; x=1710283953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRlqjD4P0ukjUTQRxcSro0liNlxeB7+nKAjiTv4orSo=;
        b=m8Y6qkHySuVjha0Ob/5Zz0yfLnZOhkrm9uPI10g/8VKQbp+mdGJePhDE7/uazrpXJs
         fP6HyMc9aSP+Bf+xpZPEsSmqZBPYeXMFcYzEof4jZGj4vYjLuLjyC+dziyWwHZw9UtmA
         fRMWS9YeNDPKNET1cgnlxCa3KK4tTGyOz2bN6fDerlzMOHHDw9W8SmFzuJtZqr4gl7WH
         RKOBb4Ob6RwRQ20G0UWy/tuacQtgNrFlSg6ln5n501QRZjBHzVqfgEyfkAtvlrpqAOE6
         KFrsbknBj4PzWg4aKfj9XLD2AMvkZqr3hdGcDfOxX300FH+pOqElgzZ6YvXYXwkTjRta
         IoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709679153; x=1710283953;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRlqjD4P0ukjUTQRxcSro0liNlxeB7+nKAjiTv4orSo=;
        b=p7Y0nedW5EldRUIO388oJYApDug43jj9HWLWvLkyHlejdNKcomhw56Yf9pEkPlfSfp
         cWOVozwnVuHRWrxeevMn/+6PQWSRNgERsNDi2ui/WIRS3isEpzd+i9zHcWbZMOrQuXvi
         PiNMfoMgl7q9mS2bA6+21onxgFbLijAmePHj/NOoZw9jtHepiIEEjo7Su4WRZ6F++4Fw
         TdDkN/M/EF390RN8giPRUaSwjKWsYZdYWQ2IPYam19kQuZVbYd3FPrqRtIfHTh1+8qCI
         O5dgDl2mvhIx87juS17KoA+yWBhCC2YRjfk8efffzcUe1qrA+FeTLH823jhczT3gKHff
         I3wA==
X-Forwarded-Encrypted: i=1; AJvYcCXnLNeQpzAmw6hrAikUmVedLZXkoTVfxZuYIYDEuqno+jC2pD/9kfxQaNc0UidoDkwNTemB1CAegohkn15Ea6RZEv7Y
X-Gm-Message-State: AOJu0Yxgv8WWMkFN6f9/2J0GNwWY5b/0qxX6pZ7KjFZfbGiV8QzJfpZc
	SqfHNXiPCKHxw6jpSvzu2b+81Gh1I9W9HSgTvK3iubvLrez+H+f5
X-Google-Smtp-Source: AGHT+IGqNZ1h/XsIPFM2p45qvCkRxnoZ/JDs53LrWEB1Y7hxXObd0lQ6AipfkrA3W4/u0a5KCO8obw==
X-Received: by 2002:adf:e589:0:b0:33d:ae69:715d with SMTP id l9-20020adfe589000000b0033dae69715dmr9258665wrm.27.1709679153340;
        Tue, 05 Mar 2024 14:52:33 -0800 (PST)
Received: from gmail.com (59.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.59])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b00412f0fa5c6asm1143679wmo.23.2024.03.05.14.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 14:52:32 -0800 (PST)
Message-ID: <8b9667e5-0d2f-4624-8f7c-f8400250a21e@gmail.com>
Date: Tue, 5 Mar 2024 23:52:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] t/t9*: avoid redundant uses of cat
Content-Language: en-US
To: Beat Bolli <bb@drbeat.li>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240305212533.12947-15-dev+git@drbeat.li>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240305212533.12947-15-dev+git@drbeat.li>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Mar 05, 2024 at 10:25:13PM +0100, Beat Bolli wrote:
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  t/t9300-fast-import.sh          | 10 +++++-----
>  t/t9350-fast-export.sh          |  2 +-
>  t/t9400-git-cvsserver-server.sh | 35 +++++++++++++++------------------
>  t/t9802-git-p4-filetype.sh      |  2 +-
>  t/t9807-git-p4-submit.sh        |  2 +-
>  t/t9824-git-p4-git-lfs.sh       |  4 ++--
>  6 files changed, 26 insertions(+), 29 deletions(-)
> 
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index dbb5042b0b8f..c03adbdd145f 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -986,7 +986,7 @@ test_expect_success 'L: nested tree copy does not corrupt deltas' '
>  	test_when_finished "git update-ref -d refs/heads/L2" &&
>  	git fast-import <input &&
>  	git ls-tree L2 g/b/ >tmp &&
> -	cat tmp | cut -f 2 >actual &&
> +	cut -f 2 <tmp >actual &&
>  	test_cmp expect actual &&

Nit: Maybe we can avoid tmp.

>  	git fsck $(git rev-parse L2)
>  '
> @@ -2012,7 +2012,7 @@ test_expect_success 'Q: verify first notes tree' '
>  	100644 blob $commit2
>  	100644 blob $commit3
>  	EOF
> -	cat expect.unsorted | sort >expect &&
> +	sort expect.unsorted >expect &&

Nit: I wonder if we can also avoid the cat that just precedes this hunk.

>  '
> @@ -2053,7 +2053,7 @@ test_expect_success 'Q: verify second notes tree' '
>  	100644 blob $commit2
>  	100644 blob $commit3
>  	EOF
> -	cat expect.unsorted | sort >expect &&
> +	sort expect.unsorted >expect &&

Ditto.

>  	git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
>  	test_cmp expect actual
>  '
> @@ -2091,7 +2091,7 @@ test_expect_success 'Q: verify third notes tree' '
>  	cat >expect.unsorted <<-EOF &&
>  	100644 blob $commit1
>  	EOF
> -	cat expect.unsorted | sort >expect &&
> +	sort expect.unsorted >expect &&

Ditto.

>  	git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
>  	test_cmp expect actual
>  '
> @@ -2118,7 +2118,7 @@ test_expect_success 'Q: verify fourth notes tree' '
>  	cat >expect.unsorted <<-EOF &&
>  	100644 blob $commit2
>  	EOF
> -	cat expect.unsorted | sort >expect &&
> +	sort expect.unsorted >expect &&

Ditto.
