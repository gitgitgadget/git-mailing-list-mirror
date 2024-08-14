Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C041B14E0
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641647; cv=none; b=MfbvzfOFdJT30BaMIMPYsHjymaIrlmB2NSm1u7K0GCf0/ITgJ44fV186aVoHL8r+xRCGhj94M0PMON2jXbgiqRtpOXP2Hh/MNrFlTjwokn0UToZdMqjTx4F2umbzwl78CSL5TnAU7m2OBGtGqhnhlbUSEAmu/aTx5VFraN04w3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641647; c=relaxed/simple;
	bh=YpqKaaXS0TpENVQ/qgFWREbLmflbntArO8RZ8m2J7EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyKv8/2uJXAQRavFnKFiWAfoIPQQeEmf8xCE2Ed8zjnOcFpTUbiXJY/3hEniS5Q3xSIDQHbX9SnSsGoBWn7DxNMGzCvcUWX60BXJRQ7AoPLEfUmivdMkf72OMpFkyxt7AQu/KDhW1r43AyqZqfISM+zIhbDRhn++QKrfpeRLaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOu29KP7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOu29KP7"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a9e25008aso241217266b.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723641644; x=1724246444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp7XpFSN1ZMbPQ3EVcikeYhsHjGbOh/68YXKhSMdlKA=;
        b=KOu29KP7/EnPf0mnrXFz9h2TP88VL3ONKd8+KoJfyC33b3m10ckWU4i+DU8EszDwbr
         gmTGyy19Mrh/qCaSqukF+7NKyd+Zbo50ybQR2vWV/5RlUfGwvfYeZWEZWAA3x1Q1U8hs
         LBupmWf2ZbNRcbt8irxKZIGtkJx5rU3PFWZppUBUPKcZ4cOsQ+CA5b+QkGsSPRUCaMsi
         h2qz6hKk20F9dCYuf3mOtcQ4Qn7X7AbK1bDrY8CI1/FmEmucWJ/3yOY/Z5hjUYEETcgo
         ajjTgnD7jgP3GCuFBCuae2CC6eUIZuD8OBK+31i2wu3chZ/MWgsEu34aZAcGnF3SRU32
         USDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723641644; x=1724246444;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lp7XpFSN1ZMbPQ3EVcikeYhsHjGbOh/68YXKhSMdlKA=;
        b=Ija6gTdBbD+MlbRfbJJtsCWoA7k8Ve2gXGo/40oFLkJtt8pBFW0aXaFgm5hhyEbECP
         J9dAi54/+eE5NQzFOXH383L1/UKAQIZsbfIq7q6pKJlurtlwVV5DaCWbIJq50yOUePTl
         bW0Em9XhTbcAp5DUv1N6MQzoW5429d/U/UZEuhEPZ07Gu2DDMCzvIij3HNQynjusdoic
         QO4miH/fhkzCK+wtghVOUUAbs8Wz1t6Y9AgOdPLzc4oyHJBnn5BFy3//iV5xFb2wb8X0
         iTIci1/EK+w/dING0M94lPd/GgIsHdEQfMsYCWsVZiSSEDoRiiTZW6sspoFzcoTlYLDt
         68bA==
X-Gm-Message-State: AOJu0Yz2WR2jVjnmw+gq7KYaKYNBkCPlsbyhTzh49O/mq38JWwDcH02g
	fIBrKXbUOd3tP2dbhYiJEh+RflARbDOL/nr9Y+9YHPWR0IhUgs0E7AW4bg==
X-Google-Smtp-Source: AGHT+IEuAq1cQy0nFQ/UlR9ydZbCIADWjPtq9W5uIoKqvT1dfEW4z7aBymVf2J1iyl1+Nqm7fsDyRQ==
X-Received: by 2002:a17:907:efca:b0:a7a:9144:e242 with SMTP id a640c23a62f3a-a8366d38efdmr196953466b.27.1723641643920;
        Wed, 14 Aug 2024 06:20:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414e31bsm170380966b.152.2024.08.14.06.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 06:20:43 -0700 (PDT)
Message-ID: <5e4906be-2cbe-44b5-b490-593ee5a42b95@gmail.com>
Date: Wed, 14 Aug 2024 14:20:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] safe.directory: normalize the configured path
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20240720220915.2933266-1-gitster@pobox.com>
 <20240723021900.388020-1-gitster@pobox.com>
 <20240723021900.388020-3-gitster@pobox.com>
 <5332f244-7476-492a-a797-2ef7ba73f490@gmail.com> <xmqqbk2ljvty.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqbk2ljvty.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 25/07/2024 17:11, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I think this is sensible if the key is an absolute path, if the key is
>> a relative path I think we should ignore it as it is not clear which
>> directory the user meant.
> 
> The only thing that worries me in that proposal is that doing so
> would break a configuration that used to work.  I'd rather leave
> the tightening of it to future work with its own justification.

As far as I know the only caller that tried to match a relative 
directory was enter_repo(), all of the other code paths pass an absolute 
path from getcwd(). Before this series git daemon required the relative 
directory "." to be specified in addition to the absolute path so that 
will not be broken by removing support for relative directories. Are 
there other users of enter_repo() that still rely on being able to match 
relative paths?

Best Wishes

Phillip

> Thanks.
> 
> 
