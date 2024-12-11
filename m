Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68502201258
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940045; cv=none; b=ZYLNbSKybIuYIyfhf5ley6ymlGeLoeFbizi5g1+GMTpMqhEQbGoqXl/gcgSb/3gQX8r4z7eIzUgo6g8jNTiBigc/LTXB0+z5G8dKTMpmmHKlHgFYI6qFKMrNI5nTYF44DtSMDuE4qwZpVzt6paNFX4kF1WZQDXK19h71dV5aWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940045; c=relaxed/simple;
	bh=qP5wJC40AIpF8tVOMbUBas1+TURt9IccK5r9Yfegx2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZaf3CaSmFBt/lyUY3WeTZC5cvW50Gmd0GcXnR7+Ue7QTBacf8lJ5Fkce+yMVuLI7BqVByv4s/zRNYyoln5fSBr7OX92tgJ/GvDHwHl0v5IsuX1ysZdm1FDASmupTgLMOyWjDokHTA6DislbkKtJNyCOF/t8lH39Wq78a0ROllY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT4b5eQ7; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT4b5eQ7"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862a921123so4194690f8f.3
        for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733940041; x=1734544841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uG3sD5jMSOu87RamLuU7rZ5BcpQTp3VEj8VP4O29de4=;
        b=TT4b5eQ76ZqspA/FI+ZCEJr2atzz/5M5bvDlML1m4ObTpqJMdAzu0Lp/o6SjF0LkMz
         m+l2sEGw2N7FJgZY/R93QMldt+8++FFIpvgHX2M4+UtCv4YIgzECkbRDqz34U2N4FHZe
         sgqTZMRjOvi2ERlQOilA9BWqQuPEY7pA8nCnc7JZgI262AtZyjkJoKo1F+9brE9MShFC
         02oO4dN850HHudW01r+1WhaS57LdvgSDl/moRn6YpoDjIgY2Nm+ZMnf8LCyO6Wtd25zm
         Rk9MKa6GetSz7Hva/022j1u3SHk4UToKQYFPASnye8210AZnJKFOXG7puv55V4ojZSPU
         nPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733940041; x=1734544841;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uG3sD5jMSOu87RamLuU7rZ5BcpQTp3VEj8VP4O29de4=;
        b=U2g+Zvllnt9T2zJRFF2roxGnDKmqfpDDEsyTaSvyrGA1mIYyP+s2yMQW6ma14grYYV
         F9PJFTGAtVLP/oFu9Js6e5l+aZJKLNkDoOYNggOm5KFv7FxR2QzvXPMBmGVGrgzpa0X/
         4SBc/Im2rUbCpOa2IgTYcuVi8hNS4YJyA4fagYjEFkfaQcW4/YFF03oxSxfoy3Ji51bR
         moM98GlvVKBRfZBtozIr4+Rhr7zG23+QeXaULuGPKEPI9ehVUvfyi1zG0fcpuvfU7kp2
         luAO9gvutIFRId464/L+LEx0ZqISh+eS7Q4YVs9LLs/Gf2AZa6OTtgLFDfRj8/XcP9cl
         C47w==
X-Forwarded-Encrypted: i=1; AJvYcCXZZMPipnzki5VamPRcSDmAOiY/s3Dff/+JP9s82OJI8xSOWZRHijomzKxgS8/f1s8FPis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl9IIxG1dd4EObryljkBuT8qgcQu47z5owUV/uqfqHccOSOM4y
	yMeXXWrzHVE/++u9w+G0SXu0Zr3asE14grVteuIu2lAIJNSFrqX/
X-Gm-Gg: ASbGncuIOH94TMwPFLPBzTs6Ktnbdcks3aHOGLNn58K2G2xa5pHe3bJ2tbSzXvllYOw
	WKB4gMTVCrfOSp9sVbnk7u0u9XnLC5FLsmBe6E7uTIDHUQdmeaHes1obDm50tx+oPnLfHbo+d+h
	Lwv8DIDhaDzzII8fX2HK/jn1plf3Y3Bc6eEqzhLL+AWM+sy90oUOcjv1Vv3tGthK45s+JRUATPl
	XQSA13nh5rOZbzv3VL3ppQ/J27PSR8ds2Fpxm58IxfycZZG63SYOgn8O2iMH6EVjQJIStpmEW9t
	e9l8lcDwMVUJ
X-Google-Smtp-Source: AGHT+IEg01N2LjZMCZJsRwKtM0PYyy53uyRT7ZO9AEkGhfmQsOZFjSLOCc+/kj6NhssNAQ7liXUI9w==
X-Received: by 2002:adf:e193:0:b0:385:f638:c68a with SMTP id ffacd0b85a97d-38787697684mr475483f8f.30.1733940041147;
        Wed, 11 Dec 2024 10:00:41 -0800 (PST)
Received: from gmail.com (120.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514da2sm1757715f8f.66.2024.12.11.10.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 10:00:40 -0800 (PST)
Message-ID: <484a5e81-63fc-4bad-a385-252329287031@gmail.com>
Date: Wed, 11 Dec 2024 19:00:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] advice: suggest using subcommand "git config set"
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Heba Waly <heba.waly@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <Z1FkrsQ5tkz1pFUz@pks.im>
 <20241205122225.1184215-1-bence@ferdinandy.com>
 <0e139151-7162-42b3-afae-248c28bf4c4b@gmail.com>
 <D674P6875UXA.LXGHCJ9EFE0N@ferdinandy.com>
 <D6791Z2QPSUW.1LP269FO886XF@ferdinandy.com>
 <be4ee78e-12d4-44c2-9f82-4f0db7706fea@gmail.com>
 <D68QSB8Y9UTD.1IO0EU3X8ZX39@ferdinandy.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <D68QSB8Y9UTD.1IO0EU3X8ZX39@ferdinandy.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/11/24 9:52 AM, Bence Ferdinandy wrote:
> 
> On Mon Dec 09, 2024 at 21:35, Rubén Justo <rjusto@gmail.com> wrote:
> [snip]
>>
>> I don't have a strong opinion on this.  Since my message, Junio has
>> marked this series to be merged to "next".  I can be perfectly happy
>> with the patch as is.
>>
>> On the other hand, perhaps I could send my patches about
>> `advise_if_enabled()`, later, rebuilt on this series once the dust has
>> settled.
> 
> I think that would be rather worthwhile, since having different mechanism for
> displaying advice isn't the best for sure.

Indeed.

> And it seems the patch has indeed
> made it to "next" recently, so I think it would be safe to rebuild on it now.

Yes.  I'll wait a few days, and then I'll send it.

Thanks.
