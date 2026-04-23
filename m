Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9790289E13
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951719; cv=none; b=EZO3kXRYiZU2nHixgXY82FqU2AmdfDiFkw0ZSRu37aiHxpeUxzbAUomS+zA7ikgSRaDJ6fmH33G94FjZctKo/4pxJfM5x5ioZEW8EZzcR0xUnrBnHpyXOdH9RkoOfRzYyQeiZfcIiP2B4hswvk9F5l2yrokWmDHO2CET/aInDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951719; c=relaxed/simple;
	bh=E4AQekrsgvoI9aNOk7njxOluBKllzusVgihKBTtS67k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TJJQ78PtKfvSL7mABJh1/ujc8gjBuJZiXshk+hMdPwJwwSrM0h0HQ5K87U+feruVkqdtQbm0RzAGGfhjB9KaIKmYm+nl+wQpyKm5f1PN+3Qc93H9Bk+5Z0rcBIMLulnTjoXpah5oWTUePVaSZDxLHd4Db1pOP11u28mYKVOK06o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8VjATv3; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8VjATv3"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb38e86cf2so620007985a.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 06:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776951717; x=1777556517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sieCsO2Pew3NpijzPRI4bVrz7UQtlcPMvteCAnetnrc=;
        b=E8VjATv3BHfawTsvwDk83Nm+e+DaBhrlyohIlQxjojAWfmnHwl50fDoRp1Nk2ENkQE
         t/lNWnqt3pSRWdnhDKEhjkHI52PpeynI7Dnyo+Ca0sh0khOxBTXT5YhlDuCbn4U4vXJW
         L7hsQ0GyButHt3g+n7zKy988WYk3vdNNRpkrr8sFO24Z3b6e/Hi6AKl1T/0MxbcTbz4t
         yn9shnfsgh3V4aImq1Viz1iw+nIA6m6f9CdtfelsTsj5oJSGVJpu1Dw2glB4HS4CESNH
         C+72ZAGNagLwvbZYt0NB8s+HZoET+BOGYuS9jllJFC5CjDLyoJlbgQkzJD6S8Kv7ADsj
         lEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951717; x=1777556517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sieCsO2Pew3NpijzPRI4bVrz7UQtlcPMvteCAnetnrc=;
        b=XxXHbmSERPqEog02JRoogh85JUjDeXFcivgN4XQ/Sw09p5HH0y4iHDzSMAdGPdLZAD
         r1BjNvZ12gkndded/Y5P1FQte5FPWs63gnvLpM28edbmK7C75yDdaj5Vgg5SNKcq67Mh
         6+czyNZ/s4bSEMkQt2BfBDtQnnnsFRVDj6o/zjRjVe3biC924lSOyOOwCcxQ77YcCYFC
         O12m6xIrLjZoQmcHCaYKYYVN65YekHBFHZijn298G1Qkasp2fR11PkBvL9Rh9uCjriUk
         FO551TJ49E+lOCWy/Wcqt7r5TjVp9pXOz1Hrw8H3p1Q79ub+ENfvUuAyFfP3KPOiVLL/
         r8/A==
X-Forwarded-Encrypted: i=1; AFNElJ/SY4hrTEFGYSg+JMseqpfTfn7eP5rgTX7A9dRurs3GGxcXmP0u65qeZof8hqtnhJn2zZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiKd2HpogVGPi5gRS62kPU5hUy9xfc3QPesu2dWEE0aHawjZFG
	q/x0HMZHM/Sw/UTCX6/f8eTJBDYNFjCrvD+q01+Bwfi/TL3NErtooUvk
X-Gm-Gg: AeBDieurUfZt7z0wnM9QGrTpzknJqFHuRNaVIx/zTZC1RcN+oj/0DppYDGU7LRCtyQQ
	ZklC6Z0HW62YR9dw5oBwtciZgAxdNNfV8pkayZVQ0MZAIIIMbOqxuzpirnHp1NLWj/NL+oVT4FZ
	Gb9E1KnLdftpMZvXtpS1//YQ+5W1OoxVFD2PEjo0dz90GmYXyj6E7vtaXl39GWyZJmDlpDyA81g
	bXj11jSMQV1BuHpfOPgytuTC7dvtpaHZbviW3TKTKDkTmUW5blZxQ8KS68uZUPhl/F3VYIJ+AJQ
	+KlLfLcj111UUvlpDY7MvlKbDJmJ8FgVuAgUNCVCBETzXTDQdnVdzsfUaaGLIqvJs73PS2YpCr2
	ftMzRySLmHMgEL/Sy3xuM6YvBnz9JZ4UzOcnjUCe+HiRiHJThHmwm1z0C9QBonP+b0TjcmOTyiX
	TS+JtLh+MZcwgtXcln8HiluB1Bn0Xyt7GlcCca6AsKx7rzh+S3CNUQJK8WArRx+fb+KL9i3Rxc+
	IRLUIls
X-Received: by 2002:a05:620a:1789:b0:8cd:d91f:b61 with SMTP id af79cd13be357-8e791c8dfc9mr3683423385a.51.1776951716572;
        Thu, 23 Apr 2026 06:41:56 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe90afsm1880500185a.3.2026.04.23.06.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 06:41:55 -0700 (PDT)
Message-ID: <6e95b82a-19e3-460e-86f7-f899c2df261d@gmail.com>
Date: Thu, 23 Apr 2026 09:41:54 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: en/backfill-fixes-and-edges (was Re: What's cooking in git.git (Apr
 2026, #08))
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Elijah Newren <newren@gmail.com>
References: <xmqqv7dix8pi.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqv7dix8pi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/2026 6:38 AM, Junio C Hamano wrote:

> * en/backfill-fixes-and-edges (2026-04-15) 3 commits
>  - backfill: default to grabbing edge blobs too
>  - backfill: document acceptance of revision-range in more standard manner
>  - backfill: reject rev-list arguments that do not make sense
> 
>  The 'git backfill' command now rejects revision-limiting options that
>  are incompatible with its operation, uses standard documentation for
>  revision ranges, and includes blobs from boundary commits by default
>  to improve performance of subsequent operations.
> 
>  Needs review.
>  source: <pull.2088.git.1776297482.gitgitgadget@gmail.com>
I carefully reviewed these patches and think they look good
to go in version 1. Maybe you need a second opinion?

Thanks,
-Stolee

