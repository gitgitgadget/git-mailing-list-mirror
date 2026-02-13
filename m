Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E63431E2
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993708; cv=none; b=FnuOKXRd4IRG40trXb1ZkMJ9NXqscktJZU+PtPEcpLvwDE0ZkRJl9HhDh4VcoydJQQ3Cb5NCw1cLP0gZqxMuFgcE50KkJOcDLU7UMZ+Li8lUf4fW+JdSjEDqFpubedflx90sQO3Xtp5SAcFluZmycPVGiA+P/yosCDCVdDp0vaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993708; c=relaxed/simple;
	bh=VKMXUZHzCtgEzlv6KqOz+9l/r/uXmHwzGaB7vyyiuzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCmsr+2DZdgsIar6Bng5IuBPSbDoEDoAWchUZ5s0PwxTc6U/hy8zcPF4c+b+uYi2t8K0UEsf+HhVQkSH+KFNQQ+qpUo61zQFCjccYexkOmWhfLNGS1pJG5zgqW6sHhIb5+i++Z6RjphBnvqZj+rtUYHa283S9////cv1GJGLLBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Stg+vZWl; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Stg+vZWl"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so11723095e9.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 06:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770993705; x=1771598505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V9n+7Aj9Nxe2HsoRo1V6rFz09fx+0qNOQ86tK+lgPvM=;
        b=Stg+vZWl9NEmSwMfYZpucwPXsF1UM68WBpbujnRP7H+OW3xcAK271fVV1f5b13MMf6
         XArDeK9cRgpp9mdjkKeFu+WfaUsL7LdQfxyCgh6TN1gUxSgmaJ1ZCBtXLEecM7wt90FA
         r2mzNgsh+0wS/2kbE/aWtILWD260qgWyRVXdcm5gEL3Ocnk9BwFbCnmHWNjwNPs4RVFP
         TN6sO2d78+2HZYx4sp5oUXz0liganTn26ov53Zw2AsyB6y4UykzAmtUswMQ/C0ivmGLU
         cPq8uWEoy8z2jWCXGV03AUv4PuyNy+G/vNWmC9874p6CYU1vwDaDuqPodqpE/MjDJGpS
         2LRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770993705; x=1771598505;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9n+7Aj9Nxe2HsoRo1V6rFz09fx+0qNOQ86tK+lgPvM=;
        b=R7Mml54tbmNnpyPF5WhtgApQ8SS/MGGAMVxcnvVYHxpl3ULtxnsu6m2urHS2vyBZVi
         PXwDC/x6p6ItIauHG39k5JhdLdkTsPedHHSWbXK0GWdx4HvRU/GUV4FIT5xgOA8QMLgu
         KPB4sJ5wE7bESkVwOQ7ZlCZgxqmqoILGctXhVNT06HGl2/Vyq2cy+AF9QhpipOZHUYc6
         nc1QV5bFQnkqEIZE3sEXEQrh85zHlgtWl6scbkFrUccFEX3IQi4TtGtdgfukwYTemi5Z
         AkukfHGVZICzJ38thEYiV+XY4gAf4lU082KjXkJWn1q8j2BZR+sLnYbIDMTRl8tm2P/r
         Jhsw==
X-Gm-Message-State: AOJu0YyS+er7T8ryuUsjKXPR/kixXOS6bfkJbiJivdRMGRwBFLQvxaXx
	78igYPzveCY4eD8u4CPhdYuvHA/LjGAFbdLMSGcfoFwT84GBxaoA7TGC
X-Gm-Gg: AZuq6aL4B1J2V5BQIUl1V1QKBsuw8bHV+bvxf4S3PMV0rfjDb6qxy1xoj2spOJW0UDU
	CwjqqHtqd9kpp7uR9vLp5RpN+SdmsbX1YTv37sXeGW0m86EZXsI4TorgWkULVLyyeSJSHBgyGYK
	7rxz+hulyInImtJ3UKNK4wAJDG6Tf5AMjwE+oQU5SX/ddOD2dlJZk/1/K9K7V3OHfsrKdvyjoJT
	DCBdWMC+Uy0nV1XfdCFBV49PR9S9YuocdG7K4MY/8HtOA8ZO1/iKtK0+rYXWCttVk9owoKGlPG+
	zRBMlegtZ7PkVhJSroOHMX1VKXw/5lSwGz2pUz+3Zv+kqVEakl68eCERrYQbYPnCNWKu9TPBr6S
	nVI9HSP++CF92ZYRfHUJ60uJ8YrQcuCyw+xEW3Y3fEWtC3X5rmgtqh+TyAcVkwQKdylHf10Cqm8
	MZ52+2/0vAeNFghxkbrzE99Jd4lJ8IT61T2JZ4n9cFLCOmrvMmZcpM7ubCtsQSm3CDsEutyax5J
	8tl2Q==
X-Received: by 2002:a05:600c:6808:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-48373a3e755mr34206885e9.18.1770993705299;
        Fri, 13 Feb 2026 06:41:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4c4sm458934725e9.10.2026.02.13.06.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 06:41:44 -0800 (PST)
Message-ID: <0484697e-4c1a-4f23-9cd9-079d92dc8bfd@gmail.com>
Date: Fri, 13 Feb 2026 14:41:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] doc: add caveat about round-tripping format-patch
To: Junio C Hamano <gitster@pobox.com>, kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Matthias Beyer <mail@beyermatthias.de>,
 Christoph Anton Mitterer <calestyo@scientia.org>,
 Matheus Tavares <matheus.tavb@gmail.com>,
 Chris Packham <judge.packham@gmail.com>, Jakob Haufe <sur5r@sur5r.net>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <V2_format-patch_caveats.34b@msgid.xyz>
 <V3_format-patch_caveats.354@msgid.xyz> <xmqqtsvllfdc.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqtsvllfdc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2026 23:19, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
> 
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>> ...
>> All of this is covered already, technically. However, we should spell
>> out the implications.
> 
> I've read the new text (without formatting, I have to admit) again,
> and did not see anything questionable.  Nicely written.
> 
> Shall we mark this for 'next'?

I'm happy with this version - thanks for working on it Kristoffer

Phillip

