Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D65C2D613
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832830; cv=none; b=RacI4CMFh+nt4I0kQQvFdDCMnYTFfo0KFS3v1GZKTw1Mdai8c+gDWxhtPFE9iD2MS1giLpa7pTNkD7muGnLoYB+sGWWL4rLfEd8E9TQjbNI6XsF+z9mb4x0pLDXYZcbM8/+WGRzcAeI5U9zvih2tnW+10NNc83ZDv1Xsn7Ovdyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832830; c=relaxed/simple;
	bh=LdALiIsDRqQLINv3FYnZ0HvjU0/9cewj5TOM0hR2roU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G9UBTxXJJnvf0O2iixW2G7kR+WnzHhFJ7C2gj9tvY2qspIrOMr/y76NM9QXBMIcF4D1kFbD892Wwp8RPQyhwdPyXFSdkk8dixWOX2svk9suxsjXwQZrnsfLDR0+TY7oJjG8L0yjf0MAr2/6akGmjF2SuD2OuuW6T3hl6S8yyuQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGUxnnfq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGUxnnfq"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-441ab63a415so74227425e9.3
        for <git@vger.kernel.org>; Wed, 21 May 2025 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747832827; x=1748437627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uy2CW16tvMcbszu4OnSOq7chOR1Td0EZswEdUc3QMNc=;
        b=RGUxnnfqET/SaXgFoUexcsf/04RoPOf4613pHMjbCcSQn57Y/I021jwKzqT+hwNbQC
         Z8KRIyRhgiIotV1HMsqK9JJe1LDHVQurLvddJinzujoBpjThFLZpd31fiWa9bR5ywaxo
         MilxMYp/arXlyj/XfI5OO0LD9hXOotWtJJRKS6uG3wM2wI4n1nvRnaZCwz5t8D0jV9pP
         6WByg5+G/UGq9WtEZQSpFzHEx8cQgfkyfPKjwUnKjKjvK7WD4OLbCY5YA4/D4LodabZz
         1BOnzytNmlYA5H/Lw5cgS9szmHBa4JIGprDMeCu7Eo342RasCUCz8+c0R4G/kx3yf+Uo
         Tuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747832827; x=1748437627;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uy2CW16tvMcbszu4OnSOq7chOR1Td0EZswEdUc3QMNc=;
        b=BmQqKtYboGSe1G86NQzjXLCjwc/qO6revQM38W3v0FK1MuuxXTpcR3Sy/y4N3orQFw
         D3Ke5BESM5HcJRrjnahuKdzR3r9PRNSd5D7lazkyc39s8pMzr7HRtYNBmXzb4eXT+bjo
         S4O0dQsUlHnDd9d+fXC+I95wK6rtTRNPWkvRRJIB8jptXhrJsHyo72JqW5aJuIJrI/Hs
         pcDfkHvdJ5FJQiq0qmBXML9JpvA02COtlUNn9zYrcf2pqX0jum8Qdhz53TgOcYfslp/y
         9IGsEztZE5l8KjuR8PPcJolbGYUDl+jLeDhMElFonWSvMJK5TPIiLKUx4MtQfUoUcKij
         f5rA==
X-Gm-Message-State: AOJu0YyRKk9cKU3fCmUIgEztdFUoQAq28KOdwyZmcTc3GmJNbG4jBafe
	mSVYIVAaZtiVSO59n6fDRd4etlW6nGqVO7biDXa89+S5/pW8DQVZdphSUewndw==
X-Gm-Gg: ASbGncst7b2c5LvLjCPhXCxZF/GnY5krP+CzqbgjOnQoZJCaXg5ZzMrFZSHfpTLCyB4
	W3F7SoqLFiCsnVryMrfRlu37jkZiXU1rQEfRDSFZX41+Nq/kFbF8d2W+uOuiflY8vxRish4lgXx
	TPUktcADwMP0IcaT7oHLjM5Yh9+NGI4nv8roz946P7oNTGU0895WmDKOHjV1p0a8s5GAj2VMLuX
	nkmVogUlbH6DK5nohPnWSVdXs4DUO9QF9JE53QKs3JbVhvVlwI1OQgg7dmXV4V1NGBctwx0XH2r
	kq6yywJxR7lK68NciEOs8R0GZLkcl34DAQRN44mtDuRC1SxKZti1zeer41dqfxloPHHFrrz69cF
	FrSU0axqc4EoRBv1JTG7dMNRB5Yo=
X-Google-Smtp-Source: AGHT+IFzL6ZaFu7vOT1GMH74Bw/z8Mg3B01WsCi/TbRRNiQyyKoUjZzxwHksbx7T+g59R7ErwCAPqA==
X-Received: by 2002:a05:6000:18ad:b0:3a3:7465:7e71 with SMTP id ffacd0b85a97d-3a37474c21dmr9066398f8f.37.1747832826285;
        Wed, 21 May 2025 06:07:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:efb:6e00:24f3:2d85? ([2a0a:ef40:700:a501:efb:6e00:24f3:2d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca208besm19622211f8f.0.2025.05.21.06.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 06:07:05 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phil@crinan.ddns.net>
Message-ID: <e5efc450-dfe1-48fa-9dcd-7e0634957e1f@crinan.ddns.net>
Date: Wed, 21 May 2025 14:07:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] run-command: prep_childenv on all platforms
To: Patrick Steinhardt <ps@pks.im>,
 "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Ian Wienand <iwienand@redhat.com>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-4-ben.knoble+github@gmail.com>
 <aC2HJxvrorJdMkL9@pks.im>
Content-Language: en-US
In-Reply-To: <aC2HJxvrorJdMkL9@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/05/2025 08:56, Patrick Steinhardt wrote:
> On Tue, May 20, 2025 at 03:34:57PM -0400, D. Ben Knoble wrote:
>> We only prepare the child environment on non-Windows platforms, but
>> prep_childenv is the natural interposition point for our subprocess
>> system to adjust the environment as needed. Use it for Windows
>> platforms, also. In subsequent commits we'll use this interposition
>> point to modify the environment on all platforms.
> 
> What is the consequence though of calling `prep_childenv()` on Windows
> now? Why didn't we call it before this change? Details like this should
> definitely go into the commit message to explain why it's safe to add
> the call now.

The environment prep for windows is currently implemented in 
compat/mingw.c:make_environment_block(). That function is careful to 
handle unicode characters correctly, it is hard to see how that is 
compatible this change.

Best Wishes

Phillip
