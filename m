Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F56FC08
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733274510; cv=none; b=sb19nTcbp5wtugp2r0ETIbOomXxuYAaRCUck0x5cEyEFlC7xCRSb6k9NIsrW1QRIjdea9evHa1z1BDh5KO8X56FLXFvlmHOI79w62yz8Wr40pewHmR5n64FxKj7QwvGXDKvtjtkjTe9SOp9OpLV4FayxwP248UA2uB9YU+wLThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733274510; c=relaxed/simple;
	bh=8z4HzdPmXHZ2+EL4f58yaRSSTGu7RGHSXdenb6h4W0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDCfUKPbCRSj/+xBFNYnzmSYn5oW/PaEc/jBkDLACEuVzcntPbc8U/2nvYQN8l6irez/1GsIdYg2jJhYq9iCHmeIJ/1Tp17bFtwauzp55UXEgvwf/yvoaTj3CzKo0LkjxtSY8nbe4YphSDqKvLOVPXp4mPnneZh8aCrPgHxhM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+lP/X5S; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+lP/X5S"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a8640763so51689905e9.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 17:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733274507; x=1733879307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYLe02Tv/Er9QQnqqlZ5MnoxIYeJX54FTPG7hj6jedE=;
        b=G+lP/X5ShGJeZ7gEDduTSYgQR4Wjvg+gNQ9mVwb6WW2NFyk/apJQg+BpT0Xi6yUbca
         7cgDkWBnfmsA/683hHl3UokTRNQT11WFDNWegDEjRmW9oUK1x/rJupQQMqS44IbLdMUE
         eS+Qu3/l3cnTjyiJz5rhyy0ndCtorJconivV1g9G79pXlI53WuqrFVWpMkAla4XAnEtF
         UhBsmahnPcgINnS+GJ0PiDIqg23i2xNuBAAw2Igm8abqEtsU7ogeFnirzugwwNTKhRlz
         FaVNYjREThx9JdW5a1TnJWrcUQ7Cj+5RthbN+89H6UbQAbLI7N635N0RNJA2GuJO0XB8
         2/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733274507; x=1733879307;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYLe02Tv/Er9QQnqqlZ5MnoxIYeJX54FTPG7hj6jedE=;
        b=PDti7/ugVtgzNHvqGSU0CQNF2eSspKzUYJ3tc/ytNcWKACP/QPRgFuyiGWSPQwiMRT
         3IKcPlSCz1YC1S2biGThm78ASrBcejPVvewjG1dVKWRzBlmUGjKRwCXaS/Q/MYrdZ3/F
         aT4qcD0/8S+Wkkn/lIfjY9HI9r7pYBBbxplbsY1FjLsdtZDavrgxaiUH8/7cV2T8daQR
         /AwjilXOsSLjyEznGwLsaZcZKsSCO/4b6clU1l/uKHDmTzlALFtRnT9H8zZ6AssXAtTC
         UIXcX8faGnZtQ57BdvbGNm5CiqFXRYeqIU1QlWkomvRwIdbykXmAQats0edpEQkroxPo
         O63w==
X-Gm-Message-State: AOJu0YwpatSNQranXuBAZzFGDjVTpBCdC2Xj7aH7sGrKi0qU3GJmoqxS
	jgHtmJHu3pce+V9FXRJ05pSHWX+vf9U8HUcSwqFKEE+hNDZOeWk9
X-Gm-Gg: ASbGnctMvIJLC2QjuKh6p0TzGIIF91W93j6XvlJaN6MfMnAznAmathA/ZPOd2DOGV07
	HY++844o+1FaH0zhLBcd7WC/JYVYzExp4bfCeh5JJ4PS4PubZUL2H0cYRY4XvuUILM03XERhj6A
	xURbfI0FlYXSR11eClhtxFo5fXql2ZpxIrWQVi1FnkL9hOZ4Wu5v/plla5KRTaOWyvIKC46x76q
	2jB08Xwk+rxNH3jRTE7nO1FuixjaaEWZxwuyS8PsU+upxIGYGwRqcz4kjcIM+YzMhqsuFMjCTVr
	j28JKw==
X-Google-Smtp-Source: AGHT+IEqk8H3zobEXBh/yFTowBsLE2unpIV9q+yfvBTuwi2YsVVfAF2IY7vlLHZ+zXDXaQxZeP7YtA==
X-Received: by 2002:a05:6000:1866:b0:385:f984:2cca with SMTP id ffacd0b85a97d-385fd3e87bamr4470438f8f.25.1733274506710;
        Tue, 03 Dec 2024 17:08:26 -0800 (PST)
Received: from gmail.com (87.red-88-14-55.dynamicip.rima-tde.net. [88.14.55.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a71bsm16750950f8f.55.2024.12.03.17.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 17:08:25 -0800 (PST)
Message-ID: <d669e92a-5499-4a33-9abc-525542615677@gmail.com>
Date: Wed, 4 Dec 2024 02:08:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] strvec: `strvec_splice()` to a statically initialized
 vector
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
 <5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com> <xmqqplm871hb.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqplm871hb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Dec 04, 2024 at 09:09:36AM +0900, Junio C Hamano wrote:

> > The recently introduced `strvec_splice()` API is expected to be
> > normally used with non-empty strvec's.
> 
> It is perfectly sensible to expect that you can splice your stuff
> into an empty strvec, so all this sentence is saying is that a
> strvec is more often non-empty than empty.

I also wanted to introduce a reason why we might have overlooked
making `strvec_splice()` aware of the singleton object, without using
a verb like "forget".

> Notice that I didn't have to invent a new
> term "empty-singleton" at all ;-).

:-D

In my defense, I wrote the message late last night and was already
tired.  And when I read it today, it didn't seem so bad to me, in the
context of the message.

Thanks.
