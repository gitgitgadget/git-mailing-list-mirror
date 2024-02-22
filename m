Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D911474B6
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619971; cv=none; b=XpO+fyKQUoDH2N2PtKfHtASvpODKXQxGAe7otZq5U5z8ESQRN8+FVfsQBtv959aNmwGLpP6maJpxnX3FFdVNTsvSo+ucTSSKm8Pve/3oFRTQruqsZ6RJnkQX/gahhqcyJNVTck5p7YqyShr+aF1aY0xCa1O0poyDjuGwUc78uho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619971; c=relaxed/simple;
	bh=9bdj0IPiohYVJ8ZGWvdnIhW2MGMnbK9GHVFEmClRWSk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mDmfk01p5z+OVezJrHgK14XXrIGJhQCqnJvWzKc3NM8ErdeoHIv0b/2SW1RG1yYUS+MCpQtsUrL53rJWObJX+7f9K3qM/7fD7coe3mWIc3n+oZjcMLFIYSab8ryG/QUH9lG1LLsClYoGhsB78DH0aGmSx50fqm3c8mHTzIfhJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUO/vMXV; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUO/vMXV"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d22fa5c822so68409781fa.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 08:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708619968; x=1709224768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ODvnpZ5wgtZttrd2DvkOY+bEDOdWXSO1vsdAuBTbfzA=;
        b=SUO/vMXVzte6Bhua8Tvi4Q2v3bSWKVQ1bkYDfldort+vYEILLU0buI6NPvaSXEp7SD
         U0LlykwF2aw0fTqrYhLR5j7vYLkKtNC0KE/AxIaAxU43iT7RHp6djIH9UdiI7V2tjzrO
         hXt+s4mYcx8xGa26WTfzD2ZVjSW8SHJwYZ+1B3TcPBYTxkq7E0AoZz96Iiz1oxy9vaRG
         H83SJCutqZxxYmoFCj9UCyrpjLiHpX0IzOQex/yxre8Xj0SwkIEK4fass1Yym9oZQd7P
         ZXaVSHgujv1c9S8EX6Nj2vbnFGsjp0UAkFsdQ8gIFWdk4jTdPFkkEoEnAw+sA5jqk4sH
         hxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619968; x=1709224768;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODvnpZ5wgtZttrd2DvkOY+bEDOdWXSO1vsdAuBTbfzA=;
        b=HVlnujIhWSFLqj0yUSGwn0fG0dFh4+K+mDyfKj26xAhyiUIo5wOWzulBgRo5K/ZIBE
         9dVS0roTLyQfvU2Rqo45dBL9KCu0OWVFvdOT2qQuGy7yJeDzdoD8S47M9DEH1QZiZoeL
         8nRRMV8U3UV7bQOJ1SeiS6EwTP7uNROnhcLh5ucWpJpRBgoRqUj67zsMY9GZpKZ13QNv
         0lzZyu0XYNA7wmuK8XLL+m2niQWVtB7kBEvx7N69kBrCYmm0aG7LFWpJSw/HTcgq2Dw1
         j1h8iV0MBo69HeUVERpo8ao8cg3NBFURDz/FPSUl+hAIR9l3XXvmCgMLv50Zju4Mz7Dl
         paNw==
X-Forwarded-Encrypted: i=1; AJvYcCWcqNckc77nPx9q5NNz9MvAViOb7Dt7v8SyTqhTNMyl/oZaPdc9+9Q03gV2sc2v6PSbAgm4ZZg2qF6IW2x4oFve0Agv
X-Gm-Message-State: AOJu0Yx9azTDot+YcXRTunrv4fdRsBOanZkOQ+Zmr2UseOTsfsKa7AXo
	J73pHbipp90SN1y8Ba3i+5uhoqQc5XOQJXA+Umi+ysnSZjOhl2u0
X-Google-Smtp-Source: AGHT+IE35aJ6jc06bivMy70Q3gSWRcEr248ePySGDsiSjFMrYwDnOuo9DkNPHnpdAvDgtk8CcAt91A==
X-Received: by 2002:a2e:988a:0:b0:2d2:31ef:361f with SMTP id b10-20020a2e988a000000b002d231ef361fmr11200918ljj.27.1708619967561;
        Thu, 22 Feb 2024 08:39:27 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id ay5-20020a5d6f05000000b0033d1ef15821sm21370358wrb.25.2024.02.22.08.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:39:27 -0800 (PST)
Message-ID: <ad547799-07f1-4def-8e20-7e37a662c58f@gmail.com>
Date: Thu, 22 Feb 2024 16:39:26 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/8] cherry-pick: add `--empty`
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240210074859.552497-1-brianmlyles@gmail.com>
In-Reply-To: <20240210074859.552497-1-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 10/02/2024 07:43, Brian Lyles wrote:
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

Thanks for the revised patches - they are looking good and were a 
pleasant read. I've left a few small comments, my main concern is the 
change to `--keep-redundant-commits` in patch 6 which I'm not sure is 
really worth the disruption.

Best Wishes

Phillip

> Brian Lyles (8):
>    docs: address inaccurate `--empty` default with `--exec`
>    docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
>    rebase: update `--empty=ask` to `--empty=drop`
>    sequencer: treat error reading HEAD as unborn branch
>    sequencer: do not require `allow_empty` for redundant commit options
>    cherry-pick: decouple `--allow-empty` and `--keep-redundant-commits`
>    cherry-pick: enforce `--keep-redundant-commits` incompatibility
>    cherry-pick: add `--empty` for more robust redundant commit handling
> 
>   Documentation/git-am.txt                    | 20 ++++---
>   Documentation/git-cherry-pick.txt           | 30 +++++++---
>   Documentation/git-rebase.txt                | 26 ++++++---
>   builtin/rebase.c                            | 16 +++--
>   builtin/revert.c                            | 40 +++++++++++--
>   sequencer.c                                 | 65 +++++++++++----------
>   t/t3424-rebase-empty.sh                     | 55 ++++++++++++++++-
>   t/t3501-revert-cherry-pick.sh               | 11 ++++
>   t/t3505-cherry-pick-empty.sh                | 29 ++++++++-
>   t/t3510-cherry-pick-sequence.sh             | 40 +++++++++++++
>   t/t3515-cherry-pick-incompatible-options.sh | 48 +++++++++++++++
>   11 files changed, 312 insertions(+), 68 deletions(-)
>   create mode 100755 t/t3515-cherry-pick-incompatible-options.sh
> 
