Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F057482
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246565; cv=none; b=p7UFGYS6aNWyVfkyBIRJGlKmL3gxAC0DvLkXimaRBSe94iurWgEG6M5uw7QwahV1GsT4wBm0fsbQ7pJe5f0gAD9tgmxPPWQ4VDjRyh+Q5+hBBVD9ux8un+8z46wsWqJ4s5eJPfJDcodkRZ2blPnldiJMS8crx/FcibcvjoKYiSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246565; c=relaxed/simple;
	bh=AOBvyOMTmCa3Eo/wWGSlDHi9dQISpSTJI/tkj6XGM7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AeFjQf5SxmMQPVTQQUpEbN3q6YFXGUZ36tB/32zzikau5B6eOyY3A31ScE9WAzl2MXhVTsc4woAAmHBRU/3XAZVfKbJ5RGxxA58+EIO3TxfQUvsQJLZlprc9tP8TIXTiYt62FCndX13n1p1xaneFrf+mL2MRDgFHBk7J2AsmIcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUuNofJc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUuNofJc"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-453398e90e9so17389955e9.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 08:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752246562; x=1752851362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KYzUW1hMdWhCWwrJupq7Ji8Inkk1xukPI3jgGXBxSKA=;
        b=aUuNofJcXtl1WP7oV8xjo332UXiSgfLJl4VMnJvJFE3LBd7D3D5/sZpc/eONpeoC1c
         HHXRp1uAVkwNPoKLUtrOFvz1GCqXjnEugCuXoDSFmWw2Umh5JMA+oYy/c6q8ounqk8ue
         k4A+518bGdkNAnHvvd6LO1pr2Ro8kZT/Jk4KJRbCI7R/L/bZlnT2KAU4gmVeVbCN/UW0
         Hoh03ITC00jdBazCGcMyUL6RrGJPBCec/xv+RS75EMwbmyAQXS0grDynXWpBgATCKqjs
         otsf4PVq2ZFV7S00Y7RsADTCnPCslngqeCMtKXeUT5FELQJ0h9DbnDlV4JnDKmjYPrC+
         duxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752246562; x=1752851362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYzUW1hMdWhCWwrJupq7Ji8Inkk1xukPI3jgGXBxSKA=;
        b=WaUv67jXoXoY4LfwYClLmOS8uafJ+9zqKrZSLVWS6PIMbdU/VTKfoyw+jofORJ5WJw
         1eMt4OP4Acdg78vJCmTJi9HA2Rpe6Q16i4eFXtaaPnPKrVcLjdqKWJt6cc+doeUdwb2W
         E5vDtpaMMbVsQuprFKfd/rf/zw4knwrmrpM3ABQJFLRHl61+ptMOYIVyonjMmuzZnnLy
         DPBjAnfiM1AOt6xc+JzMK9ywVd4C81Thffn1ePCTUT7o/0F3G423TlSGLSwaxBXK08c2
         rveUc8lSEGC1liSOxvftbmx0tyyxgfBLhdS5JXUmSA2iavBAB4hyoJK2ltJvlFA9oe9+
         4UGA==
X-Gm-Message-State: AOJu0YyI4bYKJ6kvot5RFsF4GeR0mFsYChziCUdRH96Rso9Ea26NSW8X
	UvcUaruhx8ECVa/EFTJ3GMjBzj2WLwA19+wZuddbrAVSuSuHINpVZT92
X-Gm-Gg: ASbGncvl6ate8T8V/WHFB70tEu3SIAwbq+1Y294p4s6IMOdBSP3/o3GHgoIAVhqEZU1
	f3mtFFUMdCPiSvirE3YjuBzNzIlIqLpJyYfaiMpuqH56gwtNDuQNlNW+F2fYM+/YEWvyrEJSWgI
	nLsf1NREdRn4qThSph5ZffjmqHN+baTkub0/FsSy4DswFomckzs/O2SQbQXiNlfslAQSsi9UOBF
	bKKqpQCyUlO25nVancTW7T649P9MP26nZoKLwoIXTsKEUBNi/vVjdxWWsFbJm541quCwU2lYGkg
	yaxO643zWjhcB84xbXTa3MxookG12NGwW072M+Q/NDM6ZTBOSyIFYulnCORtNV5iPUlsfELXD7s
	WyEJCoFudvmtSHpibMqBzEezfC1TB4w3Ito0rwDo2jy/+XE4JTqA1mW/k8M6rDwUTEWK94cisg1
	5L
X-Google-Smtp-Source: AGHT+IEt68wBKlop+UmP10Z96AqNfYLANqWW0j08kz8U6g5raGxkLprccAfdzDzvUnS0SlD87noWBA==
X-Received: by 2002:a05:600c:8010:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-454ec16a08amr39556625e9.14.1752246560932;
        Fri, 11 Jul 2025 08:09:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:750:6901:92bb:fbdb:4a2f:315b? ([2a0a:ef40:750:6901:92bb:fbdb:4a2f:315b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-455f13ec67asm10428975e9.4.2025.07.11.08.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 08:09:20 -0700 (PDT)
Message-ID: <b811a0dc-fb49-4f66-a9ae-89a45d7ff104@gmail.com>
Date: Fri, 11 Jul 2025 16:09:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] breaking-changes: deprecate support for
 core.commentChar=auto
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, Taylor Blau
 <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
 <xmqqjz4iv7mt.fsf@gitster.g> <f679151a-c843-44d4-9e28-27112d26f30c@gmail.com>
 <xmqqfrf5nxnq.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqfrf5nxnq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2025 17:20, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> With hindsight I should have been clearer here that the advice given
>> is based on the user's config settings.
> 
> Ahh, OK.  If the "hint" advice message gets generated with custom
> sequence of commands, that explains why the sample looked so uneven.
> Disregard what I said about clearing every variant from every scope.
> 
>> The advice will recommend a command that updates commentChar in the
>> scope where it is currently set so if it is set globally it will not
>> prompt you to set it locally in each repository and if it is set
>> locally it will prompt you to update it there.
> 
> Again, I misunderstood the set-up that would lead to the sample
> output.  If the user has "auto" in ~/.gitconfig, replacing it at the
> same place may make sense.
> 
> If the "auto" comes from /etc/gitconfig then we'd recommend
> changing it there, instead of overriding it per-user in ~/.gitconfig?

Yes, though I'm on the fence about that. I wonder if we should recommend 
~/.gitconfig instead if the user account that git is running under does 
not have write access to /etc/gitconfig. That also raises the question 
of what advice we should give about clearing settings in the system 
config file if the user does not have write access to it. It is possible 
the human user has write access to the system config even if the user 
account that git is running under does not but we have no way of finding 
that out.

>>> It would be necessary to special case "auto" after 3.0 boundary
>>> anyway, whether we (1) die when we notice the value is set to
>>> "auto", and refuse to work until the user chooses a comment char, or
>>> (2) use "#" or something hardcoded.  Either would be better than
>>> using literal string "auto" as comment char.

I'm leaning towards dying to avoid any nasty surprises when the commit 
message contains lines beginning with '#'.

I'll try and re-roll next week

Thanks

Phillip

