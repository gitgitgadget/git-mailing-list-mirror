Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C972A142E7B
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718046849; cv=none; b=rC4mPmNp+9qhyRfrT8LeDVM4QTuJCb/1JwddfttxggPYzR9+X2eFKVdeHAIBBqJYo9enZFg9GcxeE2xDqs9Nyfo3nAPJHYcOAKSYSLit7p8H2NRXr3o7SkdzzVsF4gCEvpVg4srDyFf7BQLPceIVvwS25edfiP/yzlg0/LlvT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718046849; c=relaxed/simple;
	bh=hGdGA/5aTuCoA+7LOzy+MVMe7OhkLdmC7O0li8+m4dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m79q46oZT4c7/OOeFoRGy452CF2vFgY/NFZgIojk4RpD2pdi2eXYL1D07MrLndfShAqlyy1nike+DJ4cf/9IHnXUdtNInRPjfQX39XZtcTHRpN9Ta8FbeMIGdn5dIbVJnCNH8EBktFxT/6MVqS09aDjh4qqrQGERw02RAEloHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXcQ1PZ2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXcQ1PZ2"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4217926991fso23364025e9.3
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718046846; x=1718651646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGdGA/5aTuCoA+7LOzy+MVMe7OhkLdmC7O0li8+m4dU=;
        b=bXcQ1PZ2KbqtF3SvwhlIfPfuYWSRRmFqLvxJ5QoLawRauk07EfL6rOTG5VRqnnkIjY
         nhmRkmWWYpdzQbSjbzg9lc23V/cwrdgpzDnqvzVSX/gWmMYdgqyiRJuXvh09eR1/7ell
         PzW9s1uNep6ChmGmmeix5/1K4Xcp5HPFSRab2qyKQkpV6sCpLJmQqRzC4aWcm6FoaOLC
         edsZ6MeA0JkFz+0OFPJcLtmrXdUvmkWuCBbXZZk9eKkxHm5cBNDk30K01Wi2Jb2ZyH7E
         o8zdTy30f35oxc7zRHzPNhzPokXj5nu8lRQ0LmPBL2vaYywXR7hheMxrEHEJDyk0dX9p
         /3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718046846; x=1718651646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGdGA/5aTuCoA+7LOzy+MVMe7OhkLdmC7O0li8+m4dU=;
        b=toO21vAAvvlB5Ac7kxVqtV25vn/yJ2F091pn8GafiWXbIHP1A/nULQKq3kuRsdZv7o
         lXPThxU/CqGTajOxwBUMrPOFvX0by3BA0u6bY6Jiu0OPln8BHuAKaNbKqjACRDuLmLQH
         L0nQZVv4i3vcFifrDjl5+C1Mcfv9gzls46m8H9uX8ejFGo+myFuTC6+AI/HA7pU97UMA
         6yZDsw0hlkyPSocMJFv+M9+fnDEkRVXNxzSTjIptcR3wzYl/JGCXBgCIaGjqL4QYEzXQ
         nQ1iqzvrsLNvvEddpSE2ErwLDw7RuW83zxCCMqCI6gKTH5YYJ4aqSzPV2uRiySq4wa/m
         nqdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpUd+zhSvsmR0LW23Kxd2F1fkhJLjDFaHrQU2DZeClMqi7A7WdvC/FubEzTd5FQe3HWV7jyQOR8UzdXVKJakV24S10
X-Gm-Message-State: AOJu0YxNnIybpLfst2zmuwp2no4CVOHu3ZVLZJ6gdzSfaFZIbbuQYbr3
	RCD+/ptsmf9pUReEnv9KtDZgHl30SknCWG4mlsRd/FMLp5I79Ilj
X-Google-Smtp-Source: AGHT+IG08ULNivX21X0dQ1ZTG/Fr0H1f4UgXNyLw+BFAc2RT2iI/s0BBFDQRH5stIJOZ6INmet6WKw==
X-Received: by 2002:a05:600c:138e:b0:421:2df2:2850 with SMTP id 5b1f17b1804b1-42164a21d60mr105650855e9.31.1718046845750;
        Mon, 10 Jun 2024 12:14:05 -0700 (PDT)
Received: from gmail.com (62.red-88-14-48.dynamicip.rima-tde.net. [88.14.48.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421f053bf89sm33197865e9.26.2024.06.10.12.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 12:14:05 -0700 (PDT)
Message-ID: <1f7b27b1-9bb2-49af-854a-762d0e75d508@gmail.com>
Date: Mon, 10 Jun 2024 21:14:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
Content-Language: en-US
To: phillip.wood@dunelm.org.uk, Dragan Simic <dsimic@manjaro.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
 <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
 <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
 <219a195c-74d0-4c21-bf54-0752bb5b01df@gmail.com>
 <9f1884ae-0f9f-4d9f-a262-b6929b81d7d8@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <9f1884ae-0f9f-4d9f-a262-b6929b81d7d8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jun 10, 2024 at 03:09:48PM +0100, Phillip Wood wrote:

> I'm still not really convinced that the escape sequences are a problem.

A concern about the escape sequences was mentioned in this message:
https://lore.kernel.org/git/b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com/

It arose when exploring the possibility of using the new command "|"
with tools that do not support escape sequences, e.g.: "| vim -", or
"| clip.exe" to send the hunk to the clipboard, on Windows.
