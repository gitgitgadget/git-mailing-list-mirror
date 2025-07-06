Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C54822AE7A
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751808442; cv=none; b=hp8ReeXM4PCJlT6uZankULC+pWy0blQ72f9O35g+oH3TppbgeVjHx0cRyVKU0Tah5akOI0N4XDgkGIod5jr2PIZf+V24TbGG+mRX98qKBgarqz8Y4SBulz6FA1nGyOGb46pvXwWDzGMUweTNwR5si0bQuAdsURI5DCA2Mzjh0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751808442; c=relaxed/simple;
	bh=k1MQxchTZKciwxdKTaaQu3XY4wnFg04HXQc1aEkoolo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mtiZ+INfFae7K0BRPPLID5n5LXNCJ5ouZOJlOp4GWDiEItxPTgm0wTqSQV/G6TnQt95tJQGTFZcLaFJ2WvrLwWRb0UDSyYr5BX1eDv7AgWEXw61u/PwioFPD9z5jGj1fbk2WgelIuhytAfAqz209HMA3/qA+8vQ2/4yYWsac3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPITmBZo; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPITmBZo"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so2093905f8f.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751808439; x=1752413239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NADfqBMs3iKW8RdylZuJHNnk1+/r4MTDySmr1SwGiGM=;
        b=NPITmBZoKNZF1fFfsBFCo0ljuckKjiogi1o90yWNAw8QNOKeMFPjyK0vG9jFifXup9
         1XprdhN7LzJfH2UT0f+7zNvP4V/dI3rI351Bh6Zob6KyoTPWui0eipNSMZclB2o3kd84
         wOKM/HpzI/lkZ8edpBWak6lcZvRB7jt0fNtqiGi8Dig7nunBVjwxWLGHj25NW/q+oN4n
         hGJwRPKQxN25mXNXiDWiMS0ypVIwe+xMBYkpQ+Jn4f/J/38pswXyiC2TAiA81DnblY7j
         CzOGx+CeA1da9F3+02YDt8ETo2V0UMteKcrlgc02ffD5Y/bRyB6mG6FddPQwL0TVShBS
         M/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751808439; x=1752413239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NADfqBMs3iKW8RdylZuJHNnk1+/r4MTDySmr1SwGiGM=;
        b=cEu7NrXRZBbKsdTHw9XoNh3D4TDdthBb57r0Tkf3q1h8nzqFhC1w2Wbrqt0vgloE1u
         mzNX7cK6rwW7uU0LfpoHkZeMzorlWzFt8CdSPRnR5mW6WQg4lOVSCcy8vWmwKwTmIWRM
         +EdHQ41PKlxQi9rW3Naqyydn9E3ZmlyBs5kIAf/4mFo55p02saaqa9XrVJZNMwOtD+T0
         +aPdPRSvmP7FIw0P0umbaWCGf1c4mAfx8Ipa4nLb3DgIASYc1l/klk7WjTdcmJWOCgtA
         9jj/NvaFBuHlcMyGKqDPLSARTukXo3e0TYiwz5zgsny8Zj+SrdbJTmLpeCm+FHPLW5qf
         6LYA==
X-Forwarded-Encrypted: i=1; AJvYcCVCDlcDh6DnL5YtdjhvgaufCnYBITvH+r96AuDwJnrg9DIVWxsaYGiXFIpAtcdXDzqdL8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrgenELfl82/87kuHhvNHpmweNv+FrozUzWKv4ACIl3D+Dzb6S
	r1AyjvsEw9jx4q+LPy8jMjkWDlKDbgN5YdIhZNG7GQCuRPeo93zDBKhe
X-Gm-Gg: ASbGncsB8RBiLq9YxTAJvTT6xC71iahMVC1kzBY8Cu//WJvVJjbIiHKZwMQQqdR6nfa
	8MEg3QBqUDIPW98NRlQeUF2e/WabgVpZIGTwF4Hrj+Hc+bX+NvG5LCH36DsCJxzXe13UYsamMY9
	VjEpj54nNY28OE9E0wIxB1kde+MZtAwNG5B+SGjf9YKVwPRDjaYpeJUFpvY5EB3VDVStf485/nA
	gU9HhACbwnj/Y6tUGZqFT9Hg19yz30TeZwjxE8p/p0hFnirhlB6mJba12c6C1ykzZe+WoiRQoNb
	9FM4FmQWpdLGCvCTpkwgYp8/fPP2B7aRH8ahq4Js/qJD2h1NbWI/5zHLaqxwnogpY2nFVsbK65t
	BxMX70CxNr4RKCOSV0bWXMwwL5VpEj0BqwnYyXQ==
X-Google-Smtp-Source: AGHT+IEc5Q4n/gTjZI7GZr/vU4EDQatpQWZj2G3KNeZo8RzwWRXMm0VGsoGSirgarUQg+lN+Fwq17A==
X-Received: by 2002:a05:6000:2913:b0:3a5:2b1e:c49b with SMTP id ffacd0b85a97d-3b4955971d5mr7277910f8f.29.1751808439293;
        Sun, 06 Jul 2025 06:27:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1696ca8sm83775745e9.28.2025.07.06.06.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jul 2025 06:27:18 -0700 (PDT)
Message-ID: <83b8fd7c-622a-4041-a825-89fe743b6c97@gmail.com>
Date: Sun, 6 Jul 2025 14:27:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: =?UTF-8?Q?Re=3A_How_to_restrict_command_=E2=80=9Cgit_grep=E2=80=9D_?=
 =?UTF-8?Q?to_the_first_search_result_per_file=3F?=
To: Markus Elfring <Markus.Elfring@web.de>, git@vger.kernel.org
References: <fb74577d-f7b8-4fde-ab5a-5283e70b8258@web.de>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <fb74577d-f7b8-4fde-ab5a-5283e70b8258@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Markus

On 06/07/2025 12:28, Markus Elfring wrote:
> File contents can be searched also by the means of the program call “git grep”.
> Would you become interested to find specified items only once in each file
> (instead of multiple times)?

Looking at the man page for git grep there is a --max-count option which 
will limit the number of matches per file.

Thanks

Phillip
