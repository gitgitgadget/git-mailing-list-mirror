Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68A1C8630
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771557; cv=none; b=qQgoMC86/ynMrK73x+ckYq8TqRksWHrfFA2KMugsp4lvUOGRssO/xXf64d92EVT6GbubNgfYIRvFHOri/tadBhPU5uaBh188HTPDrreweYexf6qdEeYiiX0vTuuTfP1NDSJTAY7yhj9GUeH0dA4/+ZFMAwyMg2urGe4vNMtrJPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771557; c=relaxed/simple;
	bh=FtjLKukzSuiP8TENebnIIYXgcBD0Tr8OfQxqBuXdamM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaXCSkQokjap4KO21XJ4/rDIb1fv4EbiJVC50eHKuV/etk279V6+o3U+bQIqevduY0ujj/BVJTCvRPvJeN/yrGbVLCkE+InjnJWZtT7Z6xkf534jvXdXdA7/00Xm2TzB5arumyyg5DKtWqbFrEu1pTF2s26eaf9yeQDFO4uoFx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clsbHHjd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clsbHHjd"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee0fd0c5c4so374810f8f.3
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 10:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759771554; x=1760376354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/qohYcb0QSDfHcwjBnkuVlSrVJJhnBfHtvdp3e9jgXA=;
        b=clsbHHjdaRX4Cy0Vj0pDTs2H3b35W006oitQfcRobm5M5kbA2x6kTBx69hxCEllY/t
         rFfodOeqw3itVl6OKUWCowiDJFxR6YHInFKQiY/ilpP4VnErUl/5Ge5ybGAyfNBfr51d
         a+FQO6J2hNhGTW5LaRrkJyrBt0tw0C0xsZsOca6Ii5b/UMBf7ej17IfJJ9i9/e/J9Rm9
         V7mhYGL69CAWUINsGhpj6xNvkuFM9rJr3aZav2TKPpj8zNw4/s+T36jaMzqhUMZjWxef
         XTFLqQnbjNoSjufI+g11A/RCmQT/c/qf1JUnpLbpCd/2SgjKj6s4/IZKujDgw6GCPuqM
         fnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759771554; x=1760376354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qohYcb0QSDfHcwjBnkuVlSrVJJhnBfHtvdp3e9jgXA=;
        b=aLdrlY+cVkGpL9HscvqRsx+c/GBfjVhNz16ooezGfT4Gin/mCnmq3eGhxpvofE9Opb
         8sCwUr797JTGRfdxeXAgIAbatcOpm/F7ZshikmIdRP0sxLrG9Qnibl6nUkh26DYJ4cl/
         pZ+3NHNLqs3ge6dIk5Sa1nGr3u2z0RqD7vSWbHFhAKq09mAcC17+/LJBT+qYyI8uwJN6
         sGhdDKljfYwDXcVPzyCNw9jlYEjY5/Sm62n/pggcbkUPBGtu/u+MnDzLEudXJDRr7OIO
         GJLhPDP1f36KIHyKhMKEqR98odhKf7P5xB4OitGyPBdqGy6CBDRo2qghMkYmJ9GrYwcD
         H8iA==
X-Gm-Message-State: AOJu0YzSXayn7IvONiCQWmMwiCC/JhAfe41rfVnkemMtY7tKn1QYOcQx
	XLtCF6awUrnrmDsd/ZoDV/Ken/Jcdx6aUFSxvVGLCcoE6par+5BxGfZ/KoGnmGpchOc=
X-Gm-Gg: ASbGncuL8I8Y7LRZ2Gy1A9aR8spaZTYpkUQxioDn6wq5k+LF6D2XZfF4bgyf6Jsdctx
	EtGxcTMRHdSvOrY/0B5/dYIRNf67JWEnrrfNti6fq/netAhEWT32rgA0+W6E9oH4NZmXo5SuRQz
	q129zzZjHwNDMWrW8u4vDktaN0MZc1uYgxdk6cdUsvVnW1W+yyqO0B2aXrmp3i0MCsDdBUWWZlm
	+OIPrTjQNzYmu3jKlLmAMY/rryeiKbj0s7fl7QftTlhf7RpbN5OEKfXparH7qqYhmzm9yMCSOnO
	/zTf3b22wwMfMcw/77/KeCckTR4mvvd9dRdpAvJKFNC3ngX9arNqNdqUw0XKrCLUg0jFY6v9iUu
	iRHOJK6bGGBlMHyO6q/i6NvbJ+jeg2s0JsviSGmseY+xhdFL+i1g=
X-Google-Smtp-Source: AGHT+IH7XToT3YG+eLunHWSajMWOPkfAWFNWK/e8EOakWmXB8L/mOHynM2DoVms9HRtWQDkPRNIkPQ==
X-Received: by 2002:a05:6000:2906:b0:3ec:db87:e8d7 with SMTP id ffacd0b85a97d-42566e05cffmr4288875f8f.0.1759771553702;
        Mon, 06 Oct 2025 10:25:53 -0700 (PDT)
Received: from desktop ([178.255.149.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8abf0bsm21535257f8f.17.2025.10.06.10.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:25:53 -0700 (PDT)
Date: Mon, 6 Oct 2025 18:25:51 +0100
From: Matthew Hughes <matthewhughes934@gmail.com>
To: Devste Devste <devstemail@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Untracked files cache not used when --untracked-files is used
Message-ID: <l62blkvi5ouzhkbfmimumhzdkv6tmszsxuxhlfkmu2lkspyihy@75466fqmo6ez>
References: <CANM0SV3+4k5tsgRw0g8-HoVSFGb1AwZr+2hCUXLriFGSd33WQQ@mail.gmail.com>
 <lrahpvp3nj4rtewf3zbf67qsvwhc4mg6irbmrhklbizxbhqwom@cc25oeqex4il>
 <CANM0SV38YcQ+THbAyTR5cnaX3iDfb92qG8gyAzUaJ5jMK7FfYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANM0SV38YcQ+THbAyTR5cnaX3iDfb92qG8gyAzUaJ5jMK7FfYQ@mail.gmail.com>

> One of --no-optional-locks --porcelain --ignore-submodules=dirty
> --no-ahead-behind causes it to not update the cache it seems.
> Unfortunately, I cannot tell which exactly, because now, even when
> unsetting status.showUntrackedFiles it uses the cache for
> --untracked-files=all
> This means, that if the untracked cache was created with
> status.showUntrackedFiles all, it will always use the untracked-files
> cache for --untracked-files

You can disable the untracked cache with `git update-index
--no-untracked-cache`. Experimenting with that, on my machine the culprit looks
to be `--no-optional-locks`:

    time GIT_CONFIG_GLOBAL=/dev/null git \
        --no-optional-locks \
        -c 'diff.mnemonicprefix=false' \
        -c 'core.quotepath=false' \
        -c 'core.untrackedCache=true' \
        -c 'status.showUntrackedFiles=all' \
        status \
        --porcelain \
        --ignore-submodules=dirty \
        --no-ahead-behind \
        --untracked-files=all  >/dev/null

Will consistently, on repeated runs, take >1s. After removing
`--no-optional-locks` one more run is still slow, but after that it drops to
~300ms.

Glancing at the code: the likely cause is the `repo_update_index_if_able` call
in `cmd_status` is only called when `use_optional_locks` returns a truthy
value.
