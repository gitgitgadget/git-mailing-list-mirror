Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119C51C5A
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738215610; cv=none; b=Gl46EAafcgs56xHfJ7+hdFsKtfgnuGrRUmckmQSqZhPXObUSqeSrPbyUchjODj32ZtsZV1QoxyibQ5mjMg86uFS3kcv0jPyvue734LiWAhNGarE8dodQawb9gVuQqWA/7+7wSGmW2+6muVeuZcpmcwXtOtb4cBz2oSF4IIo9qgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738215610; c=relaxed/simple;
	bh=XHfMT/kZprloX/N2EAYq+r56M66IC0bCSzOJRJvNWW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCaWn5VBksV9KKN6Gv9EyIo8XmqV0fk2okdCzRegHRdYi31Q6rreTUTTlhg3c3diGBLckEpewRJYofVmT/9FyFH5oDIFMH6uY/tawwi4BE7xZKIAv+OXKiUdB5fUdSHlRh2RHqjKZVeZEDGgw3syE4k3Iwhf2dXyvQ7BW1uwFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLbzr0B8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLbzr0B8"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so603181a91.2
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 21:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738215608; x=1738820408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZgA8qzTwGQkq6LlxkKW0dJMADGeQwHq5mOlG6iMt5E=;
        b=SLbzr0B81PAGRjXCHk12uy1PX33Nd8MFSMPo6YvixcNPkr8PgauiX7I3WYpq9R81PU
         AYHPUf0eHC4WdaacoqIoQRb+EYvctuoFgSgaqdSnO6DXWsuXuXW5bFOqRgPbLzDtuoga
         fv02jCKk0aTzA6QCibFjNs5/SdB1lLVNcp5KiDt/hKJG8eTu+KMrqpKrUXstYj5xDxKU
         heUcRm9gEG1skbfIT40G43xacVGo2x8YD65WgXuIOyVhQt8hp+nEeBDpcAA5mFH3vB5Y
         24YHDVzlVsuGBfhyWyJtGXF9myBY/J4CSXuUlPonL/6IFJolY3YNjDH08IBiz1OQK9VS
         oR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738215608; x=1738820408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZgA8qzTwGQkq6LlxkKW0dJMADGeQwHq5mOlG6iMt5E=;
        b=CsFiEV1yeaILUmSjftNmNZITd6MezuM1qcnco11FuToA0NiNNXQCp9lSeXFeaIPvED
         Gdvyit/h5XtMEVBslxUKmNxvTcqczZMnAmyp62ZkPoJFYvj1wZmbCywuHXNW1kNbyect
         ieBiAEoIWZkWap9Zsy4bF62z5GMyQ996p0adva9V7CF3O6NAoB3ld3vBe9zwwLvYP1r8
         UPlC7XANUjewrRNjXpFJf13/GkPuNF5OrkQxB7iyEutOxT15/ZG3kUWzmk6veoVbt1GF
         3orWBrrrblOkwP6LcDWVzxs7kPGQ253kqIk7ajnWsMakJYWpYeP1IntuuewgZ+nSpnaS
         /MDw==
X-Gm-Message-State: AOJu0YziFfZiFqhwgesw3RtfWeED5gY5d4NBwyLcvWYAnT50M8JA40g3
	4OGTBcA8EWLSbXeTmW+U6MXmVmlHxufskXoIFrkyMB/b+voSrGuuu6hNFg==
X-Gm-Gg: ASbGncsOZd/fxkpm3q8SS/KCTYkiXTvfrzJaVgCh/Kton2hnz042AJwfmj9vGLq83HW
	Dp3AOYQPYQkz5GRI4Rtygm6CCkqaujQg4DGlavK/ApX0XdYtZt1pO4JWSC+FqZsZowMAhAIj5QR
	MIQpfpWoD0y/LiLIsPKcGYrg/KlOogIiaflF8VO1B0PMV6aWJVx2v2nEPrcTvFI8iqNewrfAU69
	uxRV2v9dQNp3YRiLR64scxvHz3YhdwEkcbAm6+7D2K2b606oqdUzl4Vc2paFpkOpmvh0Pcpkjl8
	B2MOF4uIxg0RNvQ1KGLaVZqJ
X-Google-Smtp-Source: AGHT+IEjV6uIcB4B5SFOwA9lNNN/Ky7T6syqXRoZxDWIAAvDmAtkdRWfSj1MXk8zGdHWcXGPHqzW7A==
X-Received: by 2002:a05:6a00:4acc:b0:72a:8cc8:34aa with SMTP id d2e1a72fcca58-72fd097948emr9728709b3a.0.1738215608281;
        Wed, 29 Jan 2025 21:40:08 -0800 (PST)
Received: from [192.168.0.7] ([106.51.24.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cdfecsm507504b3a.133.2025.01.29.21.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 21:40:07 -0800 (PST)
Message-ID: <398978b6-6033-428c-993d-feba69334f8a@gmail.com>
Date: Thu, 30 Jan 2025 11:09:47 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2025
To: Christian Couder <christian.couder@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Junio C Hamano
 <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 20/01/25 13:49, Christian Couder wrote:
> 
> It might be nice if we could refresh our microproject idea list too.
> Maybe we could add ideas related to removing the_repository or
> compiling with -Wsign-compare?
>

Thank you for your suggestion! I've incorporated the `-Wsign-compare`
idea in the new microprojects page that I've created here:

 
https://github.com/git/git.github.io/blob/2025-microprojects/SoC-2025-Microprojects.md#ideas-for-microprojects

Kindly check it and let me know your thoughts. Would it be possible for
you to add the 'the_repository' idea to the same? I could do that if you
could elaborate a bit on what we expect out of the microproject.

--
Sivaraam
