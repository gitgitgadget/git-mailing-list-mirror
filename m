Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E81C5D51
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741517570; cv=none; b=afath9lJiHd8wxw8yxjlJZU1FOAXzJp+Mz2omw34VXoyoUHhYkXIVQYjUaZX4XdzGx/dP6abeVWdZUdkk9vWVwj0NLhZ5UDOF79Jc7xM8dfB9vSWLeJykGGcyIxkhJ64AQkHdYWVWPIjergPQZFFms+krKvJMuxxZFUP0AfAk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741517570; c=relaxed/simple;
	bh=TbTd+rBuizt+iUpmxUigP9WC4kEsxJcIeoRUZN+kGHI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X0It7mDchyctoaIzlVHEy48jbyOTjkR49SUk5fzW3WpPLUD8xSINHe8SSnRdS5cGvJJdOIUaLxlRewqFwa6d0diyG+SSrTxDVxQH4kkX/dhDgC1myM6naxoGnjuysKJWROvPBeKhMIPv+PEB2DARrCnutCvip+52WYOdMcEInOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDcx/FdN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDcx/FdN"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39129fc51f8so2762205f8f.0
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741517567; x=1742122367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t0buRGMUc/sH9/U2gFuJqULPnHjpHxyN7vt5QaEfUSg=;
        b=jDcx/FdNgxShWCPKa7yMbHyVsUf+iwUqcxnHloBosZ6+IDSf6VzPl9pqp7Qu196x6O
         GmQ7Cz5R7dvQ9P0R+Zafvj1pz5Oe0jAyIwaYd+FnDxZch+rnuE12x2k8xNl9TpnmeSva
         jEUR6wwRL8tjmD660UjASbPVff+pMvZQ/wMEmhBPiFSaNKtmV8ZnbsU72EdBU4J6+kLx
         UiMLFAwdaP88rFhhjJqgwUDsfYwSJDRSkguxZdbwdU4TkOLrJcAxta78hzLAPABg0TQ5
         rcuvJ8SPLetQ5TtbsRitSozt0zJKKdYtS4iXQGsPqW0M8vmPRcX21OHM1RDB7cifaNWE
         EZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741517567; x=1742122367;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0buRGMUc/sH9/U2gFuJqULPnHjpHxyN7vt5QaEfUSg=;
        b=Ru+mG2N2T9CIC5bI9Wp5BuHFUNjw9JigB0N5XP+llE7IoaILI0H6Ppa2540ZjDU4V7
         PL61CGAitqn1k1uJn55G65BQ4YFjkm0Zc7Yve4aRoDxppLkQ6AYzJMDSaaAuW0TDnwGW
         uOPQ6DQPMR6pozc9yhfDCgcWtYZWv4PbIPp5tnT2y8cyK+OyyCOWya0SDVJSLO1/S1g/
         PUTMOtm/7gJs4u/k8MSLwlDK9kXoWY47AO7dKMXrNshqQjvQAiv2WPAUWCf4L2I2NpKt
         gY7f5O4i0yNuMNx8Fs3dkZnTxmixr+WbgDoLMwUvLOGGaFhTNwLW4/d9JRWg7u6cIVoE
         HcrA==
X-Forwarded-Encrypted: i=1; AJvYcCUjzUeOl/lNfx0frHomlPURasGwJBOQrLFxaiGDOJLwMbYUm53Tw1wAexAsn8OLybZasSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXw9cyy43/pMV1pBofXNo9TD/YwE2VkRCSC1yhlpbk1noMGuyf
	jmYVaI/5g9mzX+3JOlK9a5HnhbM4hxe3DVQ/Bv6f5tUUyoId8Ge/
X-Gm-Gg: ASbGnctqZTJ0FJbvUz180Fl4ZaItzRiGdpyGYOA8rpMWhEEXoFuSxHk4hTC1RpBYXnU
	w9sct+IH/jytm8uz4KV+lgYkP1mGvOmUTz/TqQPBJJvHwzEzA4bDny1wN5F4C+Vw9WZ+SFKFpnp
	USLEQwHadNwsGHK4JBZVzks0Qw5qiDL/zh3ZFp9CWIqnmjqwmMynfx7LNl6sZ53hE6Evr++Ni5d
	0j+IEGHPQH4ujnGqmN76OobaH2VLFb+8PoLg+vX3u8QYTED7snSW32ViAR9t1rwUDYotSXPjmpi
	PHQJKtZEs8Jo+RUl2T30hebYkv/4f/UCyI21xa5tVIzwxCRW4U9o6LkElr1vTFwsLHUuciIX7Jl
	EvnH/vnNyi7JhWl8z4ful
X-Google-Smtp-Source: AGHT+IFmiPq+E5I7T0b+iBawGb7Cz694N7CkperxIia9SBvEpL1pF+WApcHMZ8DZ7zLEKxNWL8m2Zw==
X-Received: by 2002:a05:6000:188c:b0:38f:2413:2622 with SMTP id ffacd0b85a97d-39132db9064mr5556391f8f.47.1741517566881;
        Sun, 09 Mar 2025 03:52:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103035sm11358990f8f.88.2025.03.09.03.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 03:52:45 -0700 (PDT)
Message-ID: <b5fb3292-216a-4456-b456-e9ed38affc22@gmail.com>
Date: Sun, 9 Mar 2025 10:52:44 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] docs: fix check-docs with WITH_BREAKING_CHANGES
From: Phillip Wood <phillip.wood123@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
 <pull.1871.v2.git.1741171357627.gitgitgadget@gmail.com>
 <xmqqzfhzlbie.fsf_-_@gitster.g>
 <082af6a3-a7ba-440d-af84-6c59827a2929@gmail.com>
 <56cf842a-7c1f-4354-b191-35bcc1e139bd@gmail.com>
Content-Language: en-US
In-Reply-To: <56cf842a-7c1f-4354-b191-35bcc1e139bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/03/2025 15:07, Phillip Wood wrote:
> On 07/03/2025 10:32, Phillip Wood wrote:
> 
> The diff below stops us from building pack-redundant with
> -Dbreaking_changes=true but still builds the documentation. I don't intend
> spending any more time one this
> 
> [...]
 >
>   if get_option('breaking_changes')
>     build_options_config.set('WITH_BREAKING_CHANGES', 'YesPlease')
> +  add_project_arguments('-DWITH_BREAKING_CHANGES=YesPlease', language : 
> 'c')

Looking again at this I think it should probably be

     libgit_c_args += '-DWITH_BREAKING_CHANGES=YesPlease'

to match the rest of our meson.build. As a newcomer to meson I find it 
confusing that the CFLAGS for the build targets are set implicitly by 
their libgit dependency.

Best Wishes

Phillip

