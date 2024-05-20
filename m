Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCEF139D12
	for <git@vger.kernel.org>; Mon, 20 May 2024 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716247665; cv=none; b=YXs2hby2lKwEoQkVTw5oMQ0MXa/bH4MsEhswOawKzXtaMHGUEx/RuUCrdtI2E0wo3zY6AjacgginZHuOQfEMI6w6wcOp9vnGMM/kJaQjRl4kitLNALXpKiHAIvV8TpG7KFlwPtHE0nl/mi9JuR8gffN4qcJleat8rGYKCHm/Rng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716247665; c=relaxed/simple;
	bh=oXJFfs7YdOnahcwNA806zWSlzGgXZFeYPy1p0DNxu/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfZaNpBeg9XlUx9uHSrVnBlUF0hjxE+m1soiJgp3qmaYFbhoFFAEhKGRehcZsx68TTF5G1etQYkWK9krN0/PFQisFZkpt+5NrVpR8XfJ0qqO4pwCEkNFT4zQJx40dYRy3iEp0d5MAP69YGHduyhv04t7mHftRxOBSgORBWv4AbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4p/vdhb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4p/vdhb"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41fd5dc04f0so19240675e9.0
        for <git@vger.kernel.org>; Mon, 20 May 2024 16:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716247662; x=1716852462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HAvsANLXwI+R0CQsvbNj0XOJ6Ixpmt2zcVkMeFtVoag=;
        b=D4p/vdhb+wLlbeYYKH//Z7KheuYx5+wUeAjRZSNKKpU1pzI4XZrEVR1fAmTmp9JPlR
         1xbJpQGniPnKU4RYxGVt2jK6/wehmRnPhY59h1K37TRDiryGWvoPXiGWlAsCBwhtcBxF
         3oh5hliGu4m2sO699X+AlOhH/Fp9dN1OvXWMLA85DYRcnbeQo8Yg7SUomL2gdY/FgWO5
         Zdeel3oWrCOJl1jFHbjsktNYSr5XrC+mjPppn++T4yNCuqaLM0dqWTDWY1PS251Rh6bE
         fMx0+8Mac9HPtXh1Y2EWheA3rvAdEn5UGJpmuIh3BtJcHnTTuzEYUQzMU4pH/yADUcKQ
         jlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716247662; x=1716852462;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAvsANLXwI+R0CQsvbNj0XOJ6Ixpmt2zcVkMeFtVoag=;
        b=UFvDSUROl3/PHZ8kWeU8yuRbUFMGMn7Ka6xG/bB4qhmUF+hudn/PVaX86756TS6/EP
         e9XsGWldsqdAFqtXhPQ5kNaEmSX3kzBg6z14iMzudI78+NIBWy4+u949e4EZOdqguG4G
         jRgFQgidEjsjrLHMfy9+UA2HxKkJvchsxEWAX6vPYUhqtBFOkR+HQnCfcXXaPJDL9h68
         d0jTiY7KUAYjwLEZTxNQ9ZUYb5Yeo43risCKgc7H4yFoCaivnCz5JNJeaVgkNHB5NZ8e
         QIGoidwxKZnYc3PF+D5ShLf7c6h//Gmf9qmQd7KU02XdKzcUOL8uC/XRgD9PT6Vk5nbT
         kNOg==
X-Gm-Message-State: AOJu0Yz0opeTy41nYXb9iANQomGwdj9ji/YO7uJ4lRoVCdGgEIFvWKTB
	KgVEHXjA0ZbfyGtPFgkz14w/igCSOMG9DVGQqAH2adtMbDqeOfkJ
X-Google-Smtp-Source: AGHT+IHdDzGeWl7xWNskhstR7O154f3Q9Wu/8m2jcngzrN9bchynWsqp5ooqcxv8eYCBen33ozwtgw==
X-Received: by 2002:a05:600c:2295:b0:420:ec6d:26c8 with SMTP id 5b1f17b1804b1-420ec6d2925mr52031445e9.12.1716247662291;
        Mon, 20 May 2024 16:27:42 -0700 (PDT)
Received: from gmail.com (173.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420152a2a8asm338280175e9.45.2024.05.20.16.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 16:27:42 -0700 (PDT)
Message-ID: <bfa694d4-7ee4-4e13-9fc9-8631a95b1d73@gmail.com>
Date: Tue, 21 May 2024 01:27:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com> <xmqqh6esffh1.fsf@gitster.g>
 <dcc9f9bf-3c0f-435f-ba10-35ff31122b7d@gmail.com> <xmqq5xv8dqd2.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq5xv8dqd2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, May 20, 2024 at 04:18:33PM -0700, Junio C Hamano wrote:

> Besides, comparison with term_columns() is meaningless
> unless your window is square ;-)

XD

> 
> An explicit 'P' might be palatable, though.

OK.  Thanks.
