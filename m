Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B747D927
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555586; cv=none; b=gR2SWVk9k84m7yRJyZM7H88j61+qjbNlDQNPtpj62rk8xYM0CNIWO7HFu17n0D7GwLYcWE809OZdOgSbPefZR2iTptOuPlvsxOOkuJPWKuSn0IjcSXtUTzb6QxoQIVwkWfmmx2Oc07eRpjxVpTlmWq9Ie92NnkymaPPSDzlwliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555586; c=relaxed/simple;
	bh=egU98ImFXfzGHtJu0v7UAktzhxcKyvbXA5QqiDP0KLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLgxcF0HjQcnggZyp1JtzOSc8P17vevkKcKQurLoqpPaiBBm5Qtl/f1dFYG1NP0aEkTNdzLSAvMrg2WfVAO+Bt4zozzbubgKbOKFDMInyE25PsWYAXVKSCuIHWoYsyd1Vl4DW9oVBn/VjBDhcWBRQluEWtpXhUfnOVmW37iGDOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDuzAdPF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDuzAdPF"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so11191355e9.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786555583; x=1787160383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=egU98ImFXfzGHtJu0v7UAktzhxcKyvbXA5QqiDP0KLA=;
        b=qDuzAdPFqPcVemyQlRkAADeOrTGkep5dOHbuw52CNKgntLPB5P/nfghsBD/lDu33e1
         2xilD/mmTpsFAJ+dgpUShXaJqf4Cls1gUl2uA+uBpGRTawj80O4jHNFItBF1phrf/AhK
         NUl3XThESGINA729z/FvkVK3IH4fubHWp6Q/VRRzBOOW4MciGxdgNaBZPuA92hs4qjHa
         M3LEWdGq6n8ULoyhMtlD72ysJgAg+2rpxxTL4IN1N6nRc/xw0E5gJ6rMCortJEJskSx7
         66swEA/XD33Z/8ppk8+QYGY0rgQBRXs0ynjaP3d3sa9xOv6PxGGVUL2Fr029ZKB9s+Eg
         cjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786555583; x=1787160383;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=egU98ImFXfzGHtJu0v7UAktzhxcKyvbXA5QqiDP0KLA=;
        b=mCKCO0xQ/kIWxcxXrZdwI7LhkeA+XNzSPiJcJR2uq2+40wX8INhXgcyDdDCXO7nqsT
         xjnXCWB1XJuDxBi907bWue/dRjqtn5OKFE/jIXjmvAoj9E8DY42QmylqkjyPa7EZZxoz
         Zby5Or4gY3MJ5GbatdD6ee7ka4TybHJ66823K2nYhf9j5s4Hs3uwnfIj3uIZR78qu9it
         22uuKP9Rlzq1cJemG6X9i3ccgk5aak7nGYXAbGIZX96c1gpr7mSP389fLJBHCEd5kR7q
         QaVUba5UYgm7ubwczDOaFf9tmdJ58Mn1/Df167LZhJ4cMV2pdr3AiKTNPiTTqWS/5d2c
         fEwg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2Ro5CzLsl3SG2pmlUnLJQgst14ebTUPJc8IC+lSEjkNGwxYTPlLFHampLy8/DXrQXuyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR73wnxWlgtZXeSks7w8Kvu5V2/1dmvSSUWzXhXgeVkcgJry4E
	4OQcYFQicivTEWeN/8SX0AtGIHk5x+z5mnk720Ushs/ljK7SB3iJPi1+
X-Gm-Gg: AR+sD11KbAdCO2PnkTrNeM2xr0AsGDnzmeudDWMNqziOc5GU5pTohOhsrSVj9fgj/66
	EFQhbjG7f881YMnjyk9HuGclpa4mHjxE2XdeKe/vc76MFHYoUmO557fWVi9ZzFXIjInImokKNVp
	qlizpEt4h8YAnKcYDtLsQGDzolE3nxWLslyo+hBTR/4hbVZpc6RA5TnluhPyKjbvNzfwaQN7PqM
	6B/bgHi3pOjSwn190pidueWN8M9AbqE8yAMCsMdZIdcngYyR2THE+GRDpmziHStsAJt1LZKJlRf
	P5ww7c0ortEjce2q3maERxKZVUZn0FedZBaYfuZj7fFWyZ6zpLeGy2HHIvCuLsTyoH1f3Yq42El
	ZBriest4cnaPwb6m8UbKJzGzoCKDTg13V5/Ot8MYdHTa/5AKYvAQzQdN9vPnVi9Zo9msy93bBwt
	QcAQi18WOlkQMxsqBBsZNRe+wn+UuNYoDC5rDHwULJI1UXtJAkIcjaaxvF7LXuruGRzKbH+sdhv
	MW0mKUOds7G9RM=
X-Received: by 2002:a05:600c:4443:b0:499:7a19:408b with SMTP id 5b1f17b1804b1-4997c13870emr68318065e9.11.1786555582764;
        Wed, 12 Aug 2026 10:26:22 -0700 (PDT)
Received: from [10.0.1.15] (85-71-82-202.rce.o2.cz. [85.71.82.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c93b362sm25659765e9.3.2026.08.12.10.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 10:26:22 -0700 (PDT)
Message-ID: <ab3a0ca8-82e9-4387-b363-2f851760a946@gmail.com>
Date: Wed, 12 Aug 2026 19:26:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bugreport
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
References: <a7899757-9c3d-4735-b7ab-469808707e61@gmail.com>
 <8fe70f89-89a8-426f-bab9-21284722c58d@app.fastmail.com>
 <f4e39b04-b6dd-4b83-9103-8a1c98019dce@gmail.com> <xmqqik5fxobr.fsf@gitster.g>
From: =?UTF-8?Q?Marcel_Svitalsk=C3=BD?= <marcel.svitalsky@gmail.com>
Content-Language: en-US, cs, en-GB
In-Reply-To: <xmqqik5fxobr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/08/2026 19:04, Junio C Hamano wrote:
> Marcel Svitalský <marcel.svitalsky@gmail.com> writes:
>
>> I see, thank you. Is this a new feature? I've been using this command
>> for years
>> and today is the first time I am seeing this. Also, is there another
>> flag instead of
>> `--all` that would just include the actual commits only?
> --branches
> --tags
> --remotes
>

Thank you, I actually want stashes included in the log so I chose the
`--exclude='refs/notes/*' --all` solution suggested by D. Ben Knoble.

MS
