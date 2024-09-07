Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF212E5B
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725700660; cv=none; b=gk9yHhDtJYuisOJPktmhBN+G3X/WKClg7UI7JPk54aqZefBRMZUlICwFNz4W2MHK1Am9Xl+mIUvx+p3R247G3PYqrlxC1g0cmzufW3jI9gvD+pv4M2Psq501gBzw0h2mPKrvetmSwGFao5ROzyh2pYl708qfz8WZaKHhEdTUMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725700660; c=relaxed/simple;
	bh=ZyYD1Sj4lpa2fI0/ihnLUuA2iuPMPI6jW7fHGFA9/EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=bX9xAOdMD2K7p9hFuUG9HC8YJS5nmFkS43e+VLdqg+Mqsy/ggbmjdZFV6da8CfkobcY2giF688Y/4hwKHyr1BnMItq8buAHKyC2z+ukHGUwoC2MmTu8oNw1mH+M0G7c4bL2MrAhFp8fDZQQMDtsv/+P+dh9dZPkO6tsQUF4nQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4XGUO2b; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4XGUO2b"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so5012121fa.3
        for <git@vger.kernel.org>; Sat, 07 Sep 2024 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725700657; x=1726305457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OJuSaPtzPNASgvI7box4VFrsJ2PyW0lgoYjzjAtwd+0=;
        b=H4XGUO2bEGlsItTKD9RPgd8uzmkAHa3NBEIPgZRIMHivaM4Frjja6CNgvAgrr6EtBR
         YTQDxNUkqj1URckKPwpk5TXonJFD3TxiOeuPVib47ZLB4rjx+xgvfHgrMVwaGMkOTeWr
         IeK0YunBCraACjVtQOoVnRbfPQNrOQds0a+JuXRUPYIwlC+LMzkCzmaAEgMHWhNChTKP
         HqotdQMe3uraN7+K1oKT+HYyaI5C/WD8Y02we7qYJaerVzhJ/3vbaN/yhFGRB6m6496G
         E7oziSk4IlPL1tZCZYSZZpjCbvQntwu5cl1vMm90RODgtu+NDyxMswAw6RWQyj/e1Y5z
         ecIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725700657; x=1726305457;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJuSaPtzPNASgvI7box4VFrsJ2PyW0lgoYjzjAtwd+0=;
        b=kDONn8JTeafQ+dteec+iPN/Bak3ntEhv2Teda0dnd1sk9SH/xX96QgFYtq1ou5AIt2
         Es1GTewwfPLTgtru9vti8FRuJDcmwGtpIS5PeiABju4595Db/vUFpOtVkDQqfn9vdrix
         yQA9wLC2WsIzNkkdgCWsv27XmNDS2Hs2RoBDywX/UHu62PSvktxtsnOUAmH6Q9nn56Un
         qrWTzdLbRaRL6gvA1MzNJoNbP0lR7DkpBFHZO3pVwcVQ1HwrZ26OMZp8YjHZW9aJTDTg
         6YgRGMkKuONRGQ46gSsn1FqLz+FaMeavUdhp/VzWnp0bmvNctJwj/XTekotiRkUHhmk1
         atcg==
X-Forwarded-Encrypted: i=1; AJvYcCUMJuk0dAd1hfHs28TbABSBYMEZFXrfCNcaz3nVSkFts6HyWnEPoGXLagmLWudt2bJ4wrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHOdkCQDUGlpd0laAbVXdR6vM81Mzjqzw1I+xbdLyvzdgZadtP
	oxuZkv8UltOHjQVJ0zFyAaBXZastqe257rUNp7vBC2nA30oaNn4E
X-Google-Smtp-Source: AGHT+IHxt2pyn8pMDijK3lTjQxmmopmkrTJtbF8rolUQ916ezC2+T78BV3Pzw6uvhqVtifkluOHpLg==
X-Received: by 2002:a2e:602:0:b0:2f5:1fa7:ac3a with SMTP id 38308e7fff4ca-2f751f671fcmr25340931fa.28.1725700656105;
        Sat, 07 Sep 2024 02:17:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebce3448sm477461a12.0.2024.09.07.02.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2024 02:17:35 -0700 (PDT)
Message-ID: <899eb2c2-bb18-4666-98d8-9255dedfac53@gmail.com>
Date: Sat, 7 Sep 2024 10:17:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking draft as of 2024-09-06 late night
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq7cboyq9s.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>,
 Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq7cboyq9s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio and Shubham

On 07/09/2024 06:41, Junio C Hamano wrote:
> Will merge to 'next'?
>   - sk/enable-prefetch-per-remote                                09-05          #1
>     <pull.1779.v4.git.1725565398681.gitgitgadget@gmail.com>

I've just taken a look at this and I'm left wondering why one would want 
to skip prefetching from a remote but still fetch from it with "git 
fetch --all". I set remote.<remote>.skipFetchAll for the remotes I don't 
want to prefetch. We also have remote.<remote>.skipDefaultUpdate I don't 
know offhand if that prevents a remote from being prefetched as well.
I think being able to specify which refs are prefectched would be 
useful. Overloading remote.<remote>.prefetch to be a boolean or a 
refspec would complicate the implementation so maybe we'd be better just 
supporting refspecs and update the maintenance documentation to point 
users to the existing config for skipping prefetches.

Best Wishes

Phillip
