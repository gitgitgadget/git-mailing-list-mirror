Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928CD27B330
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825029; cv=none; b=Nns3ICEwC+uEWiZAm8xoXqhnAr4vmA0Dycfbo0X9Lz6TRRHTOLck0ASPansixQVhQvGOqLXWeVraOpOemyvPIBGF+r7jkHeLMIkWgNvzNwmEHfVhKDNoWNF52X5pZdgQHpLihTderYXoovTxQRe0ZucC7gXXJ59fVqV6eHHC554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825029; c=relaxed/simple;
	bh=6aIT99cyZWWOwC17U0RlJXOtcJZg21GYX/er/+WKSzU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ooAfdPp4CevYhylTWNmxCPcspUA722ifTIfnUdnrhGn3yfNxsuP12YfBO6ldXs2jawu6rtxZbIJOQnNXg/VGxKB5ui+4t8PI9Z0dQf9RbNg6DCReLMFrHJ0jzZXUgbX5LAKBxoXl+r93VKmZUQ+DA8MLcQLJW1fXBckxmLMZlWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmG2d7dR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmG2d7dR"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ce772ce0dbso3802361f8f.0
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756825026; x=1757429826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6UqpX3CESI+5S81hqlVSLbV3+EMijnN4kOkoKfZh0Rg=;
        b=cmG2d7dRXY7lfGz0LmPODSm3wcBUjdAA1gRaWfo6pfigNIxSk4ycLugVIahLQqUDbt
         Tjx5+rJrML3qXMVgMHAFKiubZXa2lZf9QUI15RNuVQETruNPNdozIaqKGUUEcC71R+X0
         24G/vWpPYNqpSzV6kxgiqJ2KGDFAj9XzmdEVHQyvQvYbXX1VV38DREUQgB3DMRMYkL97
         VlU1hDXn58IFlg0316LXRVa1pIF2F7Q5nZrxplrvtIiVKGC077sDwmG3cjFVy4pFL4V4
         lfLoBR0jrh2ZaHl9zoj+5tKjNd1z3UG45EGfaRCiWi2xUuxhTcZ0zErv/Dv41eADRJ8U
         GaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756825026; x=1757429826;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UqpX3CESI+5S81hqlVSLbV3+EMijnN4kOkoKfZh0Rg=;
        b=rLb5VLl91cPE0szFSC0irUmLW0aBXnUCxKoQGPgYC93jg0VYXoqkEIlvUqlaYUkcGM
         LofgjIsQA48Fam96CpSkOS7mn252J3RJP/3nVyuA4HHClYbS4RZqXJ7xisyKyrGAhq/l
         ZTv83cHSlikdqscy2Z7I06t7Ffno6wCqMAt7jRcFctVr0wYyE8VhOCohAh7MBt32UblZ
         3uO9Tjkor0Z9AbtvV66nTUFljEZB0MkyLezkiQXFLiSx9cu5Z6xuP5hHUh0JHfgeCAQh
         BwLmBMy522jSJxxIF/ovkZi2Y9Zzig85XsKmJyUGBJLaI5GPqecaS//PnNFtqJuGQoX8
         u52A==
X-Forwarded-Encrypted: i=1; AJvYcCVox5HoFzczIe8CQj1GD5d3BkFIYWpme+OL8Gbf8qAN7q9xUvPATiYfqhcol28lP0gxMD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp0GRtTqnBphEdRqzZT4jRmemRLpJhEb6z/LZPCz4kmsKrKE4s
	vGJW81DOm+/zGIcOEn5vRVbRJ+bf+HFTnYXmw0g8XsGl9br22yYIvI/p
X-Gm-Gg: ASbGncsxsoyZ06XbTCNLZ8RBo5WYDSsBjaX1ZF4Y+y1LWLhmc1noWj/Mlap7Otk+gNN
	gqpzdd1YzeECyBjWyp83GNqEnDTe1p1XCcDVBtFCBoS6RcfSu55oA6pikvS8+ZtOa+BE0OOtF6q
	1ekgfPCOfN2WUvnvYIfUJ0UZnBrDrvglwovmiueS/O52chjnsNnTs2OsR3ufBdMMK2Xe3K/vG8Z
	chaI1WIFiVIj0Shwpc1mhdKjiBSgHJ/QKIbhJz1g/3QD2BCIWjCZWnRfbzYJdlZvyVj6rBweSjs
	UYIpGoAEtH42S7nbU6AsIESY0JCHzPsECXDknOAehZAwcluUFHGlv23WhQ2W9/D2PO3urrZtxL/
	IQn2KTCiZESf9wbN8apPveg3hnSmVdn2AUmfDLrTgxMG3qE9zvdVsdEPAqV0s3BvEzdRpTnNcby
	djSPvfTXwzeDtBMTU=
X-Google-Smtp-Source: AGHT+IHPRKATeBvNOMc9MpwQnaJ/vlNBvv+WZS+Ei8YNyCzjzeHLJ3p30VZZga7J+7VVL4N/ngVjYA==
X-Received: by 2002:adf:f70c:0:b0:3d4:1517:d2e9 with SMTP id ffacd0b85a97d-3d41517d9a8mr6734283f8f.25.1756825025696;
        Tue, 02 Sep 2025 07:57:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d729a96912sm8025273f8f.8.2025.09.02.07.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 07:57:05 -0700 (PDT)
Message-ID: <62b50f7e-7ee3-420b-9de3-6d9df611b6b6@gmail.com>
Date: Tue, 2 Sep 2025 15:57:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/subtree: fix split with squashed subtrees
From: Phillip Wood <phillip.wood123@gmail.com>
To: Colin Stagner <ask+git@howdoi.land>, git@vger.kernel.org,
 phillip.wood@dunelm.org.uk
Cc: Zach FettersMoore <zach.fetters@apollographql.com>,
 Christian Couder <chriscool@tuxfamily.org>,
 Patrik Weiskircher <patrik@pspdfkit.com>
References: <20250824191048.1938340-1-ask+git@howdoi.land>
 <00e76b7e-ce4f-44d9-acd9-466c6b14f41b@gmail.com>
 <ee480c22-0dd3-4c45-a2bd-838c238f1d55@howdoi.land>
 <773ed81e-34b4-4116-88de-7e4307b6c679@gmail.com>
Content-Language: en-US
In-Reply-To: <773ed81e-34b4-4116-88de-7e4307b6c679@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/09/2025 14:22, Phillip Wood wrote:
> On 01/09/2025 21:43, Colin Stagner wrote:
>> On 9/1/25 08:54, Phillip Wood wrote:
>> Colin Stagner <ask+git@howdoi.land> writes:
>>
>> The outer loop in git-subtree.sh:983 appears to iterate from the root 
>> commit forwards… and not from the HEAD backwards.
>>
>>      git rev-list --topo-order --reverse --parents $rev $unrevs
>>      #                         ^^^^^^^^^
>>
>> Since the iteration is ancestor-first, I'm having difficulty seeing 
>> why `should_ignore_subtree_split_commit()` would want to do an 
>> ancestor traversal at all. It already sees the commits ancestor-first. 
>> But there could be a reason that I don't know.
> 
> Ah, I was only looking at this patch, not how it was called. That begs 
> the question "what's the point of these checks if we've already visited 
> all the ancestors anyway". I think the answer is that it is pruning the 
> recursion that happens in check_parent() and checking the commits that 
> come from that rev-list command is pointless. The regression test 
> introduced with this function only looks at $extracount which comes from 
> the recursion. I haven't looked too closely but it would be nice if we 
> could move this check so it is only run when check_parents() is recursing.

Sorry that's not quite right. check_parents() recurses into 
process_split_commit() rather than the loop that call 
should_ignore_subtree_split_commit(). I think what this check does do is 
prune some parents which stops check_parents() from recursing into other 
subtrees so the check is in the right place.

Thanks

Phillip

