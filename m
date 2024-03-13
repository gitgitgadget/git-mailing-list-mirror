Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804FC127
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346347; cv=none; b=pFltC+6x7XDuSPVQwq5xX/b+u/+HYkUipzOkpY5hoObA1GdB+OLe3j3LqJGMeNQRYwXxWOO31eR8dVfRamyy5sTE9QwvxkgBiePAeUOCrebnCYqDD0NWulAX6ISTtan1ac0lk3Yyboq2JvXwEfcyhxh2MUK3dFP0oicsKgzIfJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346347; c=relaxed/simple;
	bh=1eY6ZG0XDEKWZLOy7MWCGe3fzXh1xh/swnPiqCBTU6A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JaiC8st5Gtri8azBMTAcyYsDHdx4jQYVDXKpwOa+ojtiwK39HyH/Dt9WLwyTr6gTr0ow45ZX647XulB8H874n6U6O98R2Rz3v1FCSzdM8wh2MCqKmA2N6yPIYseNGK6V45eL71wh+sgiGNDhoY8ZqoFlDi7kHF8iE6+SfX7xdho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQoV2hC3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQoV2hC3"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4132a5b38fbso245475e9.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710346342; x=1710951142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HTHpyQR559X42MNa5Cu8ZNao9x1tFP7rsowofHEn85M=;
        b=KQoV2hC3pPbEAA2ERdCM4kg+kh0VCa03aH1pMYPyYQWw6BRTGaE2XjA50BA3IyRpwk
         4z9n0OS2G4PTbbCO2/lkMW8M3ubdeQjRK8PVQU2wU50O1PNUdK05r9QrO+5nBZK7RIrW
         QSkqAO8tr0nK/c6xE/0Kp+csMp9cUigqwPkVe8IKBzIVvPfkZ+WTmhWncUmR4VUglsxV
         qLPX/svm/FhMdg6TOKc4NC78BfWMFIERCm/XuC994FJnc98E7AirsTTzpljp6uYh7M5t
         5cJnWWkS1eupW3RJyop9XwcxCS9mtxg1VM3QeftN7fC7gti06UTv1jRiRxC80CqguGOi
         +tdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710346342; x=1710951142;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTHpyQR559X42MNa5Cu8ZNao9x1tFP7rsowofHEn85M=;
        b=XPw0UNPQI/5brnlAO3gAHMyHdLhZPvmhiPibu3fEAR0q9MAme8EUOUNMNK/WHnzkDa
         P+8xY0YORxFI9OWLSQPbq1rMvCIiJtTiBkZbMff8hQnToQeBcjjnf8ozW4y70GbHrb18
         RSnCvYs9LeAs5Toy/dtSj+k8HO7XuEWjKv1ceQN9DCOXArgIQ+UE0rfBGVCbz+yZ/Kyh
         d7g8avehEJ8Afwr5viiPMTizcjxDlWUX0fqRIPJwn44YZIPMdHBd2YgsrOCCQ2HKZJ7p
         Bjtvf4YK0ufuOGaf4b15gm5Rkabpn2iBhkWjQvWJRqBUVVlcui6Rfk62KIqgtev+YBHo
         6ZWg==
X-Forwarded-Encrypted: i=1; AJvYcCVdNEs+6aL99lnVjz5V1PyMLi0XcxGSsqUWePzG5y4cXxFVaOjGhmQ6j3IQjASvp5AcO0Jqe6RYAQ3VmUgX0WvIXa+E
X-Gm-Message-State: AOJu0YwCi757D4LV8W042Le+xQhiydKaBr5vxangVjJy3coyxcLvqh3D
	+UCjfWbpv+ATAOfJ/8P9oL4/h/ynKXLs1K0evVgRSezlfGS40dbk
X-Google-Smtp-Source: AGHT+IEDLBKitJBI3WVH4mkXhUMsZK8tRB7VNaA0vktXT012y2Zxgk4euiEb+hKqXQ+Yte8tVCm3Sg==
X-Received: by 2002:a05:600c:4e90:b0:412:dcab:85e with SMTP id f16-20020a05600c4e9000b00412dcab085emr313693wmq.39.1710346341808;
        Wed, 13 Mar 2024 09:12:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id jg28-20020a05600ca01c00b004131ae36ac4sm2695470wmb.20.2024.03.13.09.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 09:12:21 -0700 (PDT)
Message-ID: <d2a57122-0957-437e-8b97-a79e72db5e4f@gmail.com>
Date: Wed, 13 Mar 2024 16:12:21 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/7] cherry-pick: add `--empty` for more robust
 redundant commit handling
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240310184602.539656-1-brianmlyles@gmail.com>
In-Reply-To: <20240310184602.539656-1-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 10/03/2024 18:41, Brian Lyles wrote:
> The ultimate goal of this series is to allow git-cherry-pick(1) to
> automatically drop redundant commits. The mechanism chosen is an
> `--empty` option that provides the same flexibility as the `--empty`
> options for git-rebase(1) and git-am(1).
> 
> Some secondary goals are to improve the consistency in the values and
> documentation for this option across the three commands.
> 
> See "Does extending `--empty` to git-cherry-pick make sense?" [1] for
> some context for why this option is desired in git-cherry-pick(1).
> 
> [1]: https://lore.kernel.org/git/CAHPHrSevBdQF0BisR8VK=jM=wj1dTUYEVrv31gLerAzL9=Cd8Q@mail.gmail.com
> 
> Along the way, I (with some help from Elijah and Phillip) found a few
> other things in the docs and related sequencer code to clean up.
> 
> The primary difference from v2 of this patch is that I no longer make
> any attempt to change the behavior of `--keep-redundant-commits`
> implying `--allow-empty`, and the new `--empty=keep` will likewise also
> imply `--allow-empty`. See "Re: [PATCH v2 8/8] cherry-pick: add
> `--empty` for more robust redundant commit handling" [2] and the
> previous messages in that thread for more context. Patch 6/8 from v2 is
> dropped entirely, with some adjustments to the ultimate patch in this
> series as well.

This is looking good, I've left a couple of comments but there is 
nothing major.

Thanks for working on it

Phillip

> [2]: https://lore.kernel.org/git/xmqqttltu7zs.fsf@gitster.g/
> 
> Brian Lyles (7):
>    docs: address inaccurate `--empty` default with `--exec`
>    docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
>    rebase: update `--empty=ask` to `--empty=stop`
>    sequencer: treat error reading HEAD as unborn branch
>    sequencer: do not require `allow_empty` for redundant commit options
>    cherry-pick: enforce `--keep-redundant-commits` incompatibility
>    cherry-pick: add `--empty` for more robust redundant commit handling
> 
>   Documentation/git-am.txt          | 20 ++++++----
>   Documentation/git-cherry-pick.txt | 30 +++++++++++----
>   Documentation/git-rebase.txt      | 26 ++++++++-----
>   builtin/rebase.c                  | 16 +++++---
>   builtin/revert.c                  | 38 +++++++++++++++++-
>   sequencer.c                       | 64 ++++++++++++++++---------------
>   t/t3424-rebase-empty.sh           | 55 ++++++++++++++++++++++++--
>   t/t3501-revert-cherry-pick.sh     | 14 +++++--
>   t/t3505-cherry-pick-empty.sh      | 51 +++++++++++++++++++++++-
>   t/t3510-cherry-pick-sequence.sh   | 32 ++++++++++++++++
>   10 files changed, 279 insertions(+), 67 deletions(-)
> 
