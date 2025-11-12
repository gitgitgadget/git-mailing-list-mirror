Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9692459E7
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959033; cv=none; b=d7LqZFiZdPkQhJHU/m/rw2fDOrrRnF9MYV87CYg7LvPmpjsfgFbYUZ3gZ4u8+hFhDvQKMoD282Vvvjhzvs/0l3QuBUuG6fIexksDYzyXXkX/aodjN58gp5TBd97hshiCk2fXD1uba7UmfQ4lCivgqH7mH3nqTDalwouj/at7hoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959033; c=relaxed/simple;
	bh=7AeDumk6fI0j2HbdsUxI2KGYIfMm+seQO/oRzqnBSbY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=aR+vBWHhd6nGPBaS1FReF3U8Pmb+CC07oSShLBxo6Z0eRIPiUrpU7HPUzhMPI4AW18WWnHzQRte1N0TPzjSG5RK8oeH7WfEbH6uK9zzX97t7iYO1Ake5lT8O77+A16cfaHBbG5EOxHvfkqNYf9USqVZu4o2bljsa0GR6o82DLAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+dvrTXr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+dvrTXr"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so559759f8f.2
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 06:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762959029; x=1763563829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVDnSm6LPMORcfrJjgnPpTLgrBOVuorZ3sNWUiAKuhE=;
        b=m+dvrTXrgUwCZMBbU3CQPYHZwBAbQddU1faH/zWoDTA5bH8ACu0MGz3DFIc6ad1GOc
         kAsaTZnSluMqt0ma/ElZfb/+mriSsilW9RCXvFgayNlIgCVa9R+3UeZfkollrAEGY53t
         MMd9FpCVf1QFyTqLtR5f1uIwK2CEFFzPr4Va3f+nZvm/xKuLfkT4w8B6yKQwDbzST9je
         FNA9/T6SrgyXishvtYJImCZXRIjoNox/HdFTKSFJrgsv5WpY9fOCdMkGQS/hLWrgCX0N
         NBEZxSZoB1GDSXh2oSua/kZ1lZFmKrJvmsCwm2o8jPpBTSY/bg3/Fyc1BA8r2q/KTFZr
         mM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959029; x=1763563829;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVDnSm6LPMORcfrJjgnPpTLgrBOVuorZ3sNWUiAKuhE=;
        b=moOc5Xs29oiCbEKOBXgYQnB3NjZ2FgGV04RdtshrNP6P35sEzzsYkd8O5pp038PzOj
         9eY+QbUsAODZlzuLcqqlmJV9H+Xmyz+L0pDy7YtRStSuvF3UktOf+yOkLey8JPZR0QUK
         XEsS6rk2sexW7WsUbkGBAATbbE00ZY/UA6BZyWqoxE4zCMPjSesLc5h9+uGz1A7IW38X
         2SGFOlFwZc9pAE1GzvVAkuCVvbPMs7zW2hy9gcw+KvenYLF5pihAumG+h+t1zuHfNpkn
         WDb4NigEEU7Ojny+BCc1biYgSeCd5/wTXVv1tmqNBCfDpoF2OXEifV7UTeYwHZkGW7Rj
         nANw==
X-Forwarded-Encrypted: i=1; AJvYcCWFE+dvliQBohfZbcZpnq+OHFlb3vgjvw0zXZ7qoKzrILn+A+01oHLVrQ02fnpMcgUM3yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyGlAIxgNEYUjN17MzFXtARwt2FqodU8ZN8jbILz5r9r4QyN0m
	xVl4r2Y480g2eYkI2prqV3bHNQqGIU74P9NRwbN5XiFv46es/zMD0eeV
X-Gm-Gg: ASbGncsCtrCWbiDr3XdXTvKroROUZBBQQbjV9gNUgSAtxwHDixPOjnIPul36KDda6MO
	538MoMnGS0WMADq3oPKI3vdOPv7+Tpqig4J3KjSMkmZk3BqB9RBcIGRl7LsgRPuAkdMOK24cARw
	CvYID7pyzSLsZm9ifxKIppMAhP7kVs7Z5g8NyDlf8c3kUWUr0pwnswiXwOEtvnlZp3i6Xcj7Y1V
	U5iHbxsXk6SIcBMXIxMHCvN0E3yVmN+pTc2Wva0DaU3A9KKiu4WUUyMh20KTlbOt/V48QaOcEMs
	+gEXoTbo4qeLye0nwYKfQLAQM81j/lBUGGxzdkRVLl9mYUEBL/nVNCU6xYbEofmCKJbHksXsMOk
	4B0WAK7gu0Sl6ORQhCshm1/R63Vk/oHHA72BxxBLPRCHqH6FI/IAtmQbtnKH9vlcszHzigjD4FI
	vb6S9BTfcwc/55+S+XZ9ytDRae+cNu2RaCQJ7M0hzJkazRtxb/3z+b
X-Google-Smtp-Source: AGHT+IEcmOLrjCAACvOgmBeQLsPBjSJr0bbwCC35KnSpqRWH4W6hllkDwRYI+N9SjoZ7LwnDIkgHtw==
X-Received: by 2002:a05:6000:40db:b0:426:d54d:224d with SMTP id ffacd0b85a97d-42b4bba5662mr3133330f8f.27.1762959029400;
        Wed, 12 Nov 2025 06:50:29 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b321a80c0sm23790727f8f.1.2025.11.12.06.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 06:50:28 -0800 (PST)
Message-ID: <bfa6c82d-f0b9-4248-88be-8a95bc22ebc1@gmail.com>
Date: Wed, 12 Nov 2025 14:50:27 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 0/4] rebase: support --trailer
To: Li Chen <me@linux.beauty>, phillipwood <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20251105142944.73061-1-me@linux.beauty>
Content-Language: en-US
In-Reply-To: <20251105142944.73061-1-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Li

On 05/11/2025 14:29, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> This series routes all trailer insertion through an in-process path, removing
> the fork/exec to builtin/interpret-trailers and tempfile juggling. The first
> three commits centralize logic to reduce overhead and simplify error handling.
> The final commit adds git rebase --trailer, currently supported with the merge
> backend only (rejecting apply-only scenarios and validating input early).

I've left quite a few comments but overall this is looking much better 
now, it needs a bit of cleaning up but I didn't spot any major issues.

Thanks for working on it

Phillip

> all t/*.sh testcases have run successfully.
> 
> v6: squash all fix commits and split refactor step from the original patch based on Phillip's suggestion and codes [4].
> v5: fix all Kristoffer's review comments form v4[3] in place and without new patches.
> v4: fix all reviewer comments in v3. [2], and add patch 1~8 & 10~29 to fix review comments.
> v3: merges the remaining trailer paths into one in-process helper, dropping the
> duplicate code, as pointed by Junio and Phillip [1]
> v2: fix issues pointed by Phillip
> RFC link: https://lore.kernel.org/git/196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty/
> 
> Comments very very welcome!
> 
> [1]: https://lore.kernel.org/git/xmqq8qlzkukw.fsf@gitster.g/
> [2]: https://lore.kernel.org/git/20250803150059.402017-1-me@linux.beauty/
> [3]: https://lore.kernel.org/git/20251014122452.1851103-1-me@linux.beauty/
> [4]: https://lore.kernel.org/git/7d12b046-365f-441c-af8e-8a39d61efbbd@gmail.com/
> 
> Li Chen (4):
>    interpret-trailers: factor out buffer-based processing to
>      process_trailers()
>    trailer: move process_trailers to trailer.h
>    trailer: append trailers in-process and drop the fork to
>      `interpret-trailers`
>    rebase: support --trailer
> 
>   Documentation/git-rebase.adoc |   9 ++-
>   builtin/commit.c              |   2 +-
>   builtin/interpret-trailers.c  |  81 ++------------------
>   builtin/rebase.c              |  50 +++++++++++++
>   builtin/tag.c                 |   3 +-
>   sequencer.c                   |  34 +++++++++
>   sequencer.h                   |   4 +-
>   t/meson.build                 |   1 +
>   t/t3440-rebase-trailer.sh     | 134 ++++++++++++++++++++++++++++++++++
>   trailer.c                     | 129 +++++++++++++++++++++++++++++---
>   trailer.h                     |  13 +++-
>   wrapper.c                     |  16 ++++
>   wrapper.h                     |   6 ++
>   13 files changed, 392 insertions(+), 90 deletions(-)
>   create mode 100755 t/t3440-rebase-trailer.sh
> 

