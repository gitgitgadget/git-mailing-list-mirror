Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBD113C68E
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478807; cv=none; b=dWUsSi8PYD+Sx7SJQhC0ft+fg5ZpX6KKbjusefKbPxDLdWeDSH9DKX9MUiJVjEGqdnOD+K/+W22aS2eKmuVlG0+IcBB0ctX7u74uCiON8eCwcSJcJMbXttWjZRcsakv8HL2ipmZ9oAVxgH884HHScJrY1K8QNTh37vtZXYeDeJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478807; c=relaxed/simple;
	bh=es94w6JzDUHiuOfjf0vQttffzGvZbYify+d5/TmlbkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l69XV0KZyDtAQXpPyCssIqxRVnfGWHKwXHK00EpqRsWDj/RC9adgLzxPjEYi60Il4O0EyM+sYcJzJnC81OimAoiFiXzI2Hk5oHxj3zydkvPIwaZp+1bUBqmo2re/BhpIsIbIh6Hpio6gutM45N1oIlAaQEaq51PoZhbT9HYrzeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3+5U/7J; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3+5U/7J"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33fd8a2a407so3979572f8f.2
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478804; x=1712083604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rb6JrXp6RfIJkNJErGAIru47JVhiwSNFbV2B5KDpiho=;
        b=d3+5U/7Jpw+R3bCTucBNaim4meDqsRIEq22il+d+ey1mKdu0jSUPmo7BlrHBlEB4v2
         P5/r0qPA+yiYMjQdeN6wMu+0Qsf1okbXqtFP17C/0BEAluIlm/upPiUzVOReZP0D+P5x
         u2Zt5XV1aOIqbrYKsa5wPgKP/ncWvb5mTJZ7rKQQplFFu7RMURUNy49yQ+EBHKvMVVef
         StheN9E+0cDxslIycgm62Fkp2VT/9w6SK2gtwWAIkQ//F7spfIM8iCpFzpmylFxNmQiV
         C4TblSJ6+DvgvMyFJWrU1jkVv8N/BsXw+Tmf1pksAP5b/Jc7172k+IegppgHBwX76hQ+
         jr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478804; x=1712083604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb6JrXp6RfIJkNJErGAIru47JVhiwSNFbV2B5KDpiho=;
        b=YEDx7EEzum8X9ATd6LmFMn8qe6ZdTFmpBRQvwLOpIAccifEECR1xEeM7j7H/YM3jcx
         W+Sr+qCaaEqovG8yZ2Yeie7y59zIdqSoO/oI9GAYq6uq3TBisimExmHKD5n/siRVx7dB
         kopi+IFcfQaO37aef8X/0fu0aanjX6dr10vfTDtWQfvog8OzgesRfrjZZMrJqPWacfIi
         XioJ0tjOiaJZsNQH3uRcPrCQ/0tDpn/R8pFLQc2jahQp1x/mSfm0t+VjDFPX3ZRjvHcZ
         gZIfjkQCcWvrBGMlvGWS12MQ2FNnpQ/zZy24IBJfmQzEufsIJy0Kv9B2CDbgf/fxBa2j
         1Pkw==
X-Forwarded-Encrypted: i=1; AJvYcCV+2vnLhrFEgkxoDi/pAIRMzT4byhV8dUMau39IPTcwrh0XhH4CaWrzOJiVwfIBdDCD8vTuQ/4eZCHr1MUU6XrwoYlh
X-Gm-Message-State: AOJu0YyJTb7AAndygKfCspFL2wopdzQu6v0SEVM8XcwO8sV4sZTXMKmE
	dv16CP0RtkWmWjdAghtYUnt3HMDPGL07u4JUQxqzNTH5nZN6fSYj
X-Google-Smtp-Source: AGHT+IGwa6Z14YI4oyGL26mJzUjK7Wk1ELUuE0ChSCTPDgxnpMZGg+grYC/lPjmRQL5NlfrSJeW29A==
X-Received: by 2002:a5d:6da3:0:b0:33d:754c:70fc with SMTP id u3-20020a5d6da3000000b0033d754c70fcmr1914760wrs.14.1711478804271;
        Tue, 26 Mar 2024 11:46:44 -0700 (PDT)
Received: from gmail.com (156.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.156])
        by smtp.gmail.com with ESMTPSA id f6-20020a056000036600b0033ea499c645sm12954060wrf.4.2024.03.26.11.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 11:46:43 -0700 (PDT)
Message-ID: <960be5ef-905a-44b2-9ff1-97d03ec09c1e@gmail.com>
Date: Tue, 26 Mar 2024 19:46:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] improve interactive-patch
Content-Language: en-US
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Mar 26, 2024 at 02:37:50PM +0000, Phillip Wood wrote:
> Hi Rubén
> 
> On 26/03/2024 00:15, Rubén Justo wrote:
> > Let's reduce the verbosity in the interactive-patch process, in order to
> > make it less confusing.
> 
> I think this is a good idea, I've left a few comments on the patches.

I'm glad you think so.  Thank you for reviewing it.
