Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B1F22331E
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293441; cv=none; b=sJauhxDx5qc+awphKhLnRTYK34uqEJlG4cYKXhjaj1NzRgJxCQ7yNu5dlS3HLggK+wkE17TcI2X+nsBGbq5QRDck6gXF5sn1pwk0pzGktyXKbYt9dWAawSlbwVSDRCGyYCkyaJ5/agne2Zv1Frl9QhlnfzJUitUD+IvUavAaemc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293441; c=relaxed/simple;
	bh=ndNWZi+SaPHrdDhgbO28Yd6wTwQVsFTUXct0CpXyTbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t07+12erxyx4mOhp89/dNAw5ccSn6cQGY7OyFmbhvY4WoHw0JFk9hze6H6PqgBY3wKkhEaw0d8pIkdECAvxjB4N3n0rPr/LEl8mmW8XsV/G/Fzk3I99IaZwQlxoUmpbXxumCg1klyOtSxao8fGyTnd7O2Nb0EjfP7CBDH4b3qHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZM0z2ha6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM0z2ha6"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dd93a6f0aso2159345f8f.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 09:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739293438; x=1739898238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9tgOXfFK16M7iWSbC2I/IvN9gQudjt9jZKQRkNudNG8=;
        b=ZM0z2ha6X32VZ1vI2kHzbzO977l+EmfkxU3MmXGzYmLqHBaOLkiC43s4fCFzHQWXAm
         ijChni9M4Q+77LUkuhrx4PipUlNbszw3aANonAko383HwDC47Jhl1lf3HaFtJjTR1Jlf
         M2ijgdRPOKKhoyC6cqNHptSTYc1Pd1piKnd3vE6/+8SZiKvkjYBAAjtWetqrafgVT0lQ
         neQfn663u5OVNCFd+9DYqC00VJ+RtaKVyUbWj4LI3WTL/sDI/MUDYyo0T8wPcRilYRaq
         oJQ/+UdRiWR1oSK4kYjpjUTXXwEOonCvLGMtXIUmZtl7DnR78nk2IkqBdthsyKdaUgif
         Z5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739293438; x=1739898238;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tgOXfFK16M7iWSbC2I/IvN9gQudjt9jZKQRkNudNG8=;
        b=L8qfFIR7FKU2HBTLyxcKlKmPsxK6oMu4HXvFXYyK8KYOcLUMMicINEAf218MnOL0Rq
         Ya4dw1mo0fhqnSF64/2U2pHNqXEyLXH8XOJoN0c0DLv+owayAOQrCgYFKTV1CZUAK8og
         8BJlkzbXcyyRynZu2rrcS3K0P2xDoMGHfKbzGH5zVrILO7c0JaHDMv9c/Z/n/mbHKkSI
         iUZcVOCWHHFkIlXz8OXMgZ3AUiPKEniJkxG0Azw3C/Eo77cVE4o+MyoQRavqko+gJfpu
         7pNuSJg9JqAddBsuJ7GiKY5qUt2Fio/ZvKP4mIYEinGYwik9hldfqiS/aOAQUQ8k1NIr
         v2nA==
X-Forwarded-Encrypted: i=1; AJvYcCWEE8Bq325a4mMHXxsmkTatCw9+wRSEhgLgydojAsCMbIJF78oypiEqzOjf75ZCwswz6Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YzteluCN/4urWcM3mJktYxMRh7AqR3CvMYaT4i3ynMs9PJMFbeY
	Qd4IO5d8hopgGUnH9gAAL6mETtgkGHAdAwii8Vmcr/vzd6UFNcm13y8Tbw==
X-Gm-Gg: ASbGnctBqvzY075CgUMiDNh9+ms3mimQWAzvZpe0t9a4SXmiAk44jIfOVQv6cHaEJn6
	GivcqvvfieTFLHqOHTbnk6+hInvvma+sn857xxKvFj1e9V8hPpO20effZYkaUKOQEhGBuEduzZP
	ERUnF52BbZC0eyWIk10QYYPCA4t3WD/jc/h/Vqxwpr6uCc0fOdV8fZAykaHAkUJXX4QYVq6Zj7E
	mzbmJ6bLnVt+Hqrk2JzYbwOj/rp0MJHLkXK7zoANf3YcyMuZVBYqK5uCsfxbDHPTa7DKtNjgopD
	iFtJXpnWdhiTgSMsK0GpDkQRVa8XBR9q7BRXymR0WOtesNSVJAGISOszX6dGFzUM5Vhs6Q==
X-Google-Smtp-Source: AGHT+IFUJe0YhSP+R6O5DlbBpI++JTytugD+BQcfHj6vD6sT1q2/yigOmrkAvonhn2lvfOoejcGMUg==
X-Received: by 2002:a05:6000:4029:b0:38d:de92:adad with SMTP id ffacd0b85a97d-38dde92ae6cmr8488478f8f.22.1739293437453;
        Tue, 11 Feb 2025 09:03:57 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43941ddc8e9sm76313355e9.26.2025.02.11.09.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 09:03:57 -0800 (PST)
Message-ID: <4beb0359-763d-425d-b416-ac40bda59e2e@gmail.com>
Date: Tue, 11 Feb 2025 17:03:56 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/6] refs: introduce support for partial reference
 transactions
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 07/02/2025 07:34, Karthik Nayak wrote:
> Git's reference updates are traditionally atomic

I'm nitpicking but the updates aren't actually atomic, if a transaction 
updates two refs then it is possible for another process to see the one 
ref pointing to the new value and the other pointing to the old value.

> - when updating
> multiple references in a transaction, either all updates succeed or none
> do. While this behavior is generally desirable,

Isn't that the whole point of transactions?

> it can be limiting in> certain scenarios, particularly with the reftable backend where batching
> multiple reference updates is more efficient than performing them
> sequentially.
>  
> This series introduces support for partial reference transactions,
> allowing individual reference updates to fail while letting others
> proceed.

This sounds like it's abusing ref transactions to implement a 
performance optimization. I wonder if it would be better to provide that 
via a different interface than shares the same underling implementation 
as transactions. That would make it clear to someone reading the code 
that individual ref updates can fail without affecting the rest. Burying 
that detail in a flag makes it rather easy to miss.

Best Wishes

Phillip

> This capability is exposed through git-update-ref's
> `--allow-partial` flag, which can be used in `--stdin` mode to batch
> updates and handle failures gracefully.
> The changes are structured to carefully build up this functionality:
> 
> First, we clean up and consolidate the reference update checking logic.
> This includes removing duplicate checks in the files backend and moving
> refname tracking to the generic layer, which simplifies the codebase and
> prepares it for the new feature.
> 
> We then restructure the reftable backend's transaction preparation code,
> extracting the update validation logic into a dedicated function. This
> not only improves code organization but sets the stage for implementing
> partial transaction support.
> 
> With this groundwork in place, we implement the core partial transaction
> support in the refs subsystem. This adds the necessary infrastructure to
> track and report rejected updates while allowing transactions to proceed.
> All reference backends are modified to support this behavior when enabled.
> 
> Finally, we expose this functionality to users through
> git-update-ref(1)'s `--allow-partial` flag, complete with test coverage
> and documentation. The flag is specifically limited to `--stdin` mode
> where batching multiple updates is most relevant.
> 
> This enhancement improves Git's flexibility in handling reference
> updates while maintaining the safety of atomic transactions by default.
> It's particularly valuable for tools and workflows that need to handle
> reference update failures gracefully without abandoning the entire batch
> of updates.
> 
> This series is based on top of bc204b7427 (The seventh batch, 2025-02-03).
> There were no conflicts noticed with topics in 'seen' or 'next'.
> 
> ---
> Karthik Nayak (6):
>        refs/files: remove duplicate check in `split_symref_update()`
>        refs: move duplicate refname update check to generic layer
>        refs/files: remove duplicate duplicates check
>        refs/reftable: extract code from the transaction preparation
>        refs: implement partial reference transaction support
>        update-ref: add --allow-partial flag for stdin mode
> 
>   Documentation/git-update-ref.txt |  12 +-
>   builtin/update-ref.c             |  53 ++++-
>   refs.c                           |  58 ++++-
>   refs.h                           |  22 ++
>   refs/files-backend.c             |  97 ++------
>   refs/packed-backend.c            |  49 ++--
>   refs/refs-internal.h             |  19 +-
>   refs/reftable-backend.c          | 494 +++++++++++++++++++--------------------
>   t/t1400-update-ref.sh            | 191 +++++++++++++++
>   9 files changed, 633 insertions(+), 362 deletions(-)
> ---
> 
> 
> 
> ---
> 
> base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
> change-id: 20241206-245-partially-atomic-ref-updates-9fe8b080345c
> 
> Thanks
> - Karthik
> 
> 

