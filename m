Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F41419A6
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042427; cv=none; b=WePQNDOjKVpbhnaovLAHHKj1arEIP4j0S9GXDNkqUZZf3E3RRCeKjwTcAe9TTjChrT0+/qKbZ6M0sqsvK6nZYQrdBOHGcmcGu2WQ5bb7DA4mTtn7W71nHKFhKIGubMb/+4fSuxXEgX1GQmGo/n2dGZxGhJ78Cw7QLou3mbPnkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042427; c=relaxed/simple;
	bh=QZCjF6+NTm4cmpaW5WJpBTEYskwfQMRv6Baavn2F780=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3C3sdUf2RYmYiK3rfoxeFbCRchcYl16yfOPsIIGJKI7OsL+B8QQWmWJyWwPxNTNwMrnXl89UUaZ32H7W0XRduRkQPmOdg+1/k4l3akA0iCE5cyKmQYig0aqi8aO/0Q7PfFUo77H1Dtr9f0oXk4UgnoXaX4eDKhv7ms2Fqm4CUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emczSbm1; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emczSbm1"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d240d8baf6so54025331fa.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 06:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709042424; x=1709647224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nUItxhYbIuS2ugqBRgOcLtHAc/kXBcGvnV3qU9yTOmA=;
        b=emczSbm13ZsUNgsD1IkH676yj1Oixg3NL8eQZKG0zmreXJ1n2e5MuTn789KeSoCvZr
         zYRDAzi99/DJIue1vP9issdxWNcyR+gfttxNShk+5UlEvxKUUw08ezHEp1xRlzZJGKIz
         blP5p8uDs1w1G2t7bo6+iv0UR2xBHHgMGCcg/O9x1VswtFxybUrgYWUlivdAJlh0k75f
         c+0x93TrQtCOhwD4YbQMQe944LV1g/NWvmIFMV9tr15yihX9QwZOZZNCfnl+NsiiO3dU
         IcZcmgvl1oeisT1+sbKPnmKfAKPrA4cgCyCJaKH5yJH/k111XDmc14BUnNoRHe4A7bf9
         mjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709042424; x=1709647224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUItxhYbIuS2ugqBRgOcLtHAc/kXBcGvnV3qU9yTOmA=;
        b=hQXdt+hzcqXZeEMr7ySpBSAtjELZBWW9TSUoTiV5NSGqrP1GwSj1Hol3uVT2jM++0E
         V+6+p2DtJBv3EcQydSQGjsFBHd2y1svCFxhuJ5exp6U61Zo6yA3y8KdI/QwtDBRsYSIY
         y7tHfjKJXbbPiW8yiBXwN9ywrxkH4DkebMWEwZzgfNgqwg7Cs/vy7zJh1h3nH0HT5KhJ
         3FfJhrCxhH2cNtWT9SpIGNhn1FEjHf6oHwMR6htrd2RLN84eprGIbR6gF1up+e0uGwY4
         NNd/4C0TrDELqKoKhx+k61dQVBmrvqhFVniAN4lRzSwKULNPxz387JfTy0FpjKSnAFoE
         yEZA==
X-Forwarded-Encrypted: i=1; AJvYcCX1DOgvrm+Gbwifdy0FdYlsvUjs4J8CcAECsxYUAH1iYsuZbgR8P+4Gi6jCYzYe548ghDtKlOS6wJvFIRtQmtgyoocm
X-Gm-Message-State: AOJu0YyOGnAn86oow7ZwrlDwTDikhowKDIodPTE2GLnFhG7Qn9MPpCXo
	/KNFUl/3Qp+51oZMKK5G9iUEtAVAzO7G1fbX1XGUa5ePKggB/I/O
X-Google-Smtp-Source: AGHT+IG0pU4OE1JWp+8IQW8wzGUcotXVYQfJOVKlUj7zMmNa2t6qjGFM8DYcgTP92heNvQiNVlMh6A==
X-Received: by 2002:a2e:9793:0:b0:2d2:36ea:e2c5 with SMTP id y19-20020a2e9793000000b002d236eae2c5mr5789740lji.13.1709042423716;
        Tue, 27 Feb 2024 06:00:23 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:69d:3501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id w21-20020a05600c015500b004128da16dddsm14855454wmm.15.2024.02.27.06.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 06:00:23 -0800 (PST)
Message-ID: <ff5a3954-4e7a-42b7-988e-f306b45918bf@gmail.com>
Date: Tue, 27 Feb 2024 14:00:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/2] Implement `git log --merge` also for
 rebase/cherry-pick/revert
Content-Language: en-US
To: Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
 Michael Lohmann <mial.lohmann@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>, Michael Lohmann <mi.al.lohmann@gmail.com>
References: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
 <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/02/2024 21:56, Philippe Blain wrote:
> Changes in v5:
> - Marked error messages for translation and tweaked them as suggested by Phillip
> - Reworded the message of 2/2 as suggested by Phillip
> - Removed the change to gitk's doc in 2/2 as pointed out by Johannes
> - Fixed the trailers in 2/2
> - Improved the doc in 2/2 as suggested by Phillip and Jean-Noël

These changes look good, thanks for making them. I agree with the other 
reviewers that it would be nice to improve the wording of the error 
message when we find a symbolic ref. Everything else looks good to me.

Thanks

Phillip

