Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48244208C1
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920011; cv=none; b=FCDLA7NBXrPvTt3NEodPvQeyI2rEukB4juh3TpyIOUiS17E68BzGDi3sPJbXuLSF1hXfRJXULHkMOuFjyk5cwWshhoIbl3bFZi2mUYbzkM+gqp6LiWdeqgoyebqgtNmuqWm9tiyHW/3q4Z8Owjtn+HbE5q7XG2SSdmPKLryDqyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920011; c=relaxed/simple;
	bh=kTbT88KsL9IzNrYA7uwarC41ON0sy5VJNemR3esYHmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QD1YMFQ8RT/loQgs/OWrzgxIFJcR6xpwztX6XYtDluy7qNpgHtAxe8KCW9Y0+ceAu/UJS2K10dbGKlFiZfQ/NI3p7mCK2GMJwp44zd3Ok2XCTclDX2Z5NKZSTSKTRYX2fgbDIh9PzzAz6d98naGxsQd8nP13nvU30aK3DSyFPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIfC65/G; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIfC65/G"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40eb033c192so2188825e9.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 02:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705920008; x=1706524808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gi4rA0DcCUu+iA+MDVW/RNs97mYfkdWIlCKZji0hvhM=;
        b=cIfC65/GDN5pwtGUtPNROhrjYqJzbt9VRZeywLzLm2aHkdyts0FE6759Q8XPuxlAH6
         6XelHIA+lf7wyor72PvjwTOqV1HbzhGaYS+5ax0w5IDCs0MMu4zWR7wsjFOv04rtSpRG
         3NTIVEYcS4Ti0Vp1u4Z/0eVODTdOYpduuXD2XG0VlH0HWJf+oAogDMihjTVaUeI+VfWS
         rubqn7+sF+/rE3agqt/27EVFJwogOPOXWF9ySabVwIwGwqNkblMHLyys5zhZeEKPW2S9
         lae6JSelop8p5VqoGhQMnd67WUxIZpxoW4TxKOGnIg5YYqenhm/MqdcWDf91WOyv6SDR
         CuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705920008; x=1706524808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gi4rA0DcCUu+iA+MDVW/RNs97mYfkdWIlCKZji0hvhM=;
        b=cqqzsVyKfF0c3UnhGBtc+fy096StgcTo6N2x6uujGU6FCiCwrwqpSYREXBoW8uiCex
         fGPVCDccW8PB+ctGnFY36ght3lIT0rjW59VOwt0azlcmOFN2fk62uTPavI4faf/D7/Od
         MYD0E3sWvg70X/vJTh2a5vsLSWSNrcVWRb7eZ0ousPd4JAo1dUH0VjBXWi/Jq2CRDmLg
         eipYNQ89VQB3PInSWUWC1NT0SwPylfLLk50KC+FrwfNdN5+T7iD5rIKJEyKWePOIJsyV
         Vv3fh7LWXmCmD3ovdrKx7ZzzoolCHNnJJwuacP8Td/DPFBHd8DFzNwmkUkLAGpuwUxFx
         TdNg==
X-Gm-Message-State: AOJu0YwhJxQxXv+AHvZri8aKLrHZ5I1sSelgiUmXWKkBRggEI2jv9YDy
	ar9jdm2ny7mvh3Ij/hX9/Dtdz51hibRbn5aOx0T5GoT3stahK0XG927eEqqb
X-Google-Smtp-Source: AGHT+IHKPHa1sffWudHP3MiHgpHXDV/jDI0514T4dUS7kiStBFsw1/f92nx1Xuv+RlyzfaJJyE4G0g==
X-Received: by 2002:a05:600c:1f8c:b0:40e:44df:4398 with SMTP id je12-20020a05600c1f8c00b0040e44df4398mr1798842wmb.44.1705920008257;
        Mon, 22 Jan 2024 02:40:08 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id q9-20020adfcb89000000b0033931b609ddsm3369900wrh.43.2024.01.22.02.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 02:40:07 -0800 (PST)
Message-ID: <d0d6626c-7181-44ce-ae50-f9cb57381ebd@gmail.com>
Date: Mon, 22 Jan 2024 10:40:07 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] cherry-pick: Add `--empty` for more robust redundant
 commit handling
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>,
 git@vger.kernel.org
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-5-brianmlyles@gmail.com>
 <06eb93d7-7113-4583-9860-28a6a6d528a2@app.fastmail.com>
 <CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 21/01/2024 18:28, Brian Lyles wrote:
> Is the sample pre-commit hook the ideal way to prevent this in the
> future? Or is there some config I could set globally to enforce this
> across repositories? I was having a little trouble finding a good way to
> accomplish this globally.

If you want to run the same hooks in all your repositories then you can 
run 'git config --global core.hooksPath <my-hooks-path>' and git will 
look for hooks in 'my-hooks-path' instead of '.git/hooks'. It makes it 
tricky to run different linters in different projects though.

I'll try and take a proper look at these patches in the next couple of days.

Best Wishes

Phillip
