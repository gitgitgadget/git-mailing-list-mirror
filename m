Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B0D1EB3D
	for <git@vger.kernel.org>; Sat, 24 May 2025 04:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748061565; cv=none; b=atr1DscMdTyZ/Id0kjKpSyg2ku83vFBoe7weQVFSn+DzRI92Oc6vcXhPBkHeoA6ZOwoHsenfNrtwmQEnPiSlvbxp0FP/epscmO92X0KTqmqSvdIPrTtSsWtpdBMv5uhMWJmUJ53Ycbxutkir8blB4AqUC+yQKeraQewOpp17uVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748061565; c=relaxed/simple;
	bh=L9Wt7IcsecnRfeS2+4IREY4d2JZo2BcuQgUDf4HKckk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WHaL1VLse6PSPa1ZgVFBILUpFBlAM9ZG4Eks+NCVQFGXfpC1bRv/DkARIx+HK6JsfmiVHXhJZAxGba2412fKQ+fybaNwQSPbF1KJMKKJuJMIDgxCJJVAM/sKTRP3TU6NVRRXRG1SgfAxoKxMz2ww0O4fpHc7qG7sdVa1MecHseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cnzdYKt4; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cnzdYKt4"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5a88b34a6so46010485a.3
        for <git@vger.kernel.org>; Fri, 23 May 2025 21:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748061562; x=1748666362; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zUqbQoITHCuWrEwLmhFwRkxKF5DANM/Yw3/a+AsOj4=;
        b=cnzdYKt4Q1ZJg24jPlwDgH7q++gXbrIjBwc4iw9gaW3F+Dchb4KSOBED4Ph5CYjHjn
         TZCzNLT74LZpOASBJJkuUAUPhNbjn5EFogKxZIDutH6cafpxrTvZIHIdl5V/LX92rbH6
         LD3h/mOAX3wNoUGRwE4W9nrSQucwOqM6Htae0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748061562; x=1748666362;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zUqbQoITHCuWrEwLmhFwRkxKF5DANM/Yw3/a+AsOj4=;
        b=pfICG2cdnxkBNZ5i1I5DAn2uQjx1cL3FCovtjxw1W/WEVbOvgm8MpcgqwgMj5e9tdf
         7l7gu0l+xxvuhvkcL+ltY26a+z3jQn0t+2QSFEtx5TuzEuz5HFRWIMmcgs+t2bHvLAoA
         6eEkl4nxp8CEOPGsoDcddNZu8WEdBF5jukd39AApikpPMafLvrffi1DI7A3gwpePjE7K
         3rcqkriiRNHlhXPS2DxpkiaJqvDTzyG0ZRcL0RN5bo3mQP6Eefd5T6YZRbrvtR9KIbmI
         +qPNL+BJSJBKFQfOMSs1OJWBkETLbFAicxWXzKu+N30qhAvTOosIiuG7vWq60DOFR6Qg
         9jWw==
X-Forwarded-Encrypted: i=1; AJvYcCU2IftoFPTXma9S515RT7PaiuwKrn3dOzavcPTMDgixYVcfDeWBeXMsGxle1uC+Xo92NzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjWVvjmuWhh+fqos3AYEY7rHt0G7YU2D3nYakhOhT+U9qHshlF
	FXRb5MB5cdGxA2BcrBXNCoDgn1Uz+IPta7EV1ilFcoED/bNlphSZ4b1W1ERPg6XKLijyHGV7CXS
	4IpRuPg==
X-Gm-Gg: ASbGncsv3zJqzJ3EkfKybibW2IFG6GGqv8XWc83ZDauOtfW4xVchG/m2JQgYAflWCjm
	WbtrTjmL2loWFA7mLDKdydxFfq2UhsCpVNfVh1Fc6XnXe6aAhwZ2pAh1hwIV5TEVsjhXjVowuyo
	73bgxjLyXfmU+/nS8EQqUTjZwFOQWIR1VNCD7pIwbkf44UO2qkLAnRRFwaNMkG0hNJ3UnYT+B/i
	Gb6TsFvpdNCh27Hg5NHRQmeAunOrwI37UGaWZb2XlTGAhk64uDA0eQVn+g/uPdRsN3GhA+ZzISj
	plNBXwRT7btKmOHwKjOvUD0D03h7Rqr7gBKRncxDB2P1FHWBktneJU2geWlXqzmiOXqSDdTyaGB
	RPkXvuFU53OaNS6+CQHBR0Lnehxv/HT/BInvTxSsHM3UVzapQpA==
X-Google-Smtp-Source: AGHT+IFon96MrYEbV7pqj3tdSNtSGXRXUR1y8Zt9H30Og+TTQXBVfZcfZLpRddtZ80CXe+GL4yu+Cg==
X-Received: by 2002:a05:622a:1f8e:b0:476:8eb5:1669 with SMTP id d75a77b69052e-49f4781ed76mr27337101cf.32.1748061562231;
        Fri, 23 May 2025 21:39:22 -0700 (PDT)
Received: from [2600:4040:9ce0:6400:e585:dc50:f5e1:64e7] ([2600:4040:9ce0:6400:e585:dc50:f5e1:64e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae526398sm123944351cf.65.2025.05.23.21.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 21:39:21 -0700 (PDT)
Date: Sat, 24 May 2025 00:39:20 -0400 (EDT)
From: Mark Mentovai <mark@chromium.org>
To: Junio C Hamano <gitster@pobox.com>
cc: Eric Sunshine <sunshine@sunshineco.com>, 
    Git Development <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] t7900: use pwd -P in macOS maintenance test
In-Reply-To: <xmqq7c27vvv3.fsf@gitster.g>
Message-ID: <9e9ed1ce-76dc-536d-56a6-e85e1dfe58c6@chromium.org>
References: <20250523193722.68344-1-mark@chromium.org> <CAPig+cRpS=t-wNLxdV_WoKF0Wzy-S1oLUEyS18S9r-4OBQ87VQ@mail.gmail.com> <xmqqsekvvz1t.fsf@gitster.g> <CAPig+cQLG+zveZg73E=TiC5uShhhRXKmK5Z_M8zN3fpGNEN1ng@mail.gmail.com> <xmqq7c27vvv3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Junio C Hamano wrote:
> Would doing something like this (without any other changes we
> discussed so far) help?
>
> t/test-lib.sh | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git c/t/test-lib.sh w/t/test-lib.sh
> index af722d383d..92d0db13d7 100644
> --- c/t/test-lib.sh
> +++ w/t/test-lib.sh
> @@ -1577,6 +1577,8 @@ fi
> # Use -P to resolve symlinks in our working directory so that the cwd
> # in subprocesses like git equals our $PWD (for pathname comparisons).
> cd -P "$TRASH_DIRECTORY" || BAIL_OUT "cannot cd -P to \"$TRASH_DIRECTORY\""
> +TRASH_DIRECTORY=$(pwd)
> +HOME="$TRASH_DIRECTORY"
>
>  start_test_output "$0"
>

That does work as an alternate way to fix the bug that I described.

Forcing the entire test suite to run from a realpath-canonicalized path 
seems like a blunt instrument, though. It would tend to mask bugs that 
only occur when git runs with a non-canonical path as its working 
directory. It could even mask bugs in git's own pathname canonicalization 
code.
