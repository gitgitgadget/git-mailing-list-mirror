Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E314A098
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522494; cv=none; b=AKAs6Gz7Vnf858gOHYLW1XRPlqo9Q7QL9LFI77Jtu27ibRvuzJcSLQXIBjefIDFuyIEg2V0lmg7AGVFYJNLzY4scvaEuSJNPNJ4BLroQhsh2OtFkm9aDmsjNVhavgyjWFMG04ST1OqlLI1hHWL/YtqUHRzPGMnJFUZ0bdqi1L18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522494; c=relaxed/simple;
	bh=1YcWSS2F3wVpz5RDXBDUsNkwGGdZlF4bWyr62RjCLSs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZCApWHjvSOVS3qD03B0C45gmAykoM6t2ieZKU8T+3M4Ve+cW4mS8VaVN72VY/khVIGLl62gC8doFYaqg3qT5/FPV/prYbMrnVbLxRFDtmr4mssUTN5/VTiKuExU3IRwngj3EG3TxE++PPKVQ6eveKA5shFEWiDxmU/hera5WhhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=AFSFJR6H; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="AFSFJR6H"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717522482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3PujMZ3ISC/JE0QBzIlYSybS1pSKOutX5hY5hmaUHwo=;
	b=AFSFJR6Hu7p7xKoXLSUWVi53kg64XSMEA7GMfBJsIR/IutXR8gVP8DAu0vn5UH4nVUmwsi
	Z2yEYl0tNA3dXu+gd7MUhAqND3o7/W7ehovhbqTnyRl/JeR63z1svrxSKhc3Uw3YXfIzQN
	0lYpZa77BU68Ly2RMNfPC9b9cgddAvuDfuTtZ1PoeaO1YHgrtmh66wcOgUxL+9/2inccjX
	6QmcDRiecn39d7ReK2naqLOIRcfohZrqI29OTCPbh/OApLIp2C5Guniuv5tFB0j57ZDNjd
	3gGG+QLnLPRE/c2wzAaVMaxVW7leKCxMRD+74iNNhelE+URSMH1o+8dpFoBDPg==
Date: Tue, 04 Jun 2024 19:34:42 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, Git List
 <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <xmqqsexu6o60.fsf@gitster.g>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <xmqqwmn79u98.fsf@gitster.g> <ec2ca25486b84615e30dbeb83ec47310@manjaro.org>
 <xmqq34pu8kkg.fsf@gitster.g> <fb2a9e98f0b2c3a009b0ad800c05522c@manjaro.org>
 <xmqqsexu6o60.fsf@gitster.g>
Message-ID: <8bbb3503cee92a66092073d990a9606a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-03 17:28, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>> I'd probably just say $GIT_PAGER instead of its expansion if we were
>>> go that route.
>> 
>> Makes sense to me.  More precisely, the environment should be checked
>> to see is it "$GIT_PAGER" or "$PAGER" that needs to be printed 
>> literally
>> as part of the help message.
> 
> I was sure somebody will split a hair like that.  At that point we
> are better off mentioning 'git var' X-<.  Or just 'Your Pager'.

I agree that it can be seen as splitting hairs, but the general approach
of Git is accuracy, so using "$GIT_PAGER" regardless of it being used or
not would be simply against the general approach.

Though, I agree that using "pager" or maybe even "your pager" would be
simpler, yet a very good option.
