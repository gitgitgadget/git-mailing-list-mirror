Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13336124
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496728; cv=none; b=QQWz4SqKAI46ibNo59ZT/AYrpv/3+18xLetkhIyTU5blQlMwnc6C4Dzd68PqyBj5N3ISBLT91jmcdM5yanWVtNZy2KJMmjioqSAu/KkOgrVUmIOg7QyMLpTu+H/JvMJT13wO9JbWoiudEUhs5OlkQSA5Yo9Mhyo0wVcMUQfm63I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496728; c=relaxed/simple;
	bh=9Ioszi+Cptc5pI3eLv2l834Kk9stAuANoBxzFXIGqK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxTpSLeua6QGmrpQxIqD/8/Aw/fAfgNImbVwTUgvGhEWOMlD3zCtQJuESLZVSuwWBU+wBOl+h783zeXOqO5WU1zPT3h+WHF/YqqPrH1XwjPRW1otdjhG0O2X1Zleo3MYs+XoNOtfsRmaS2aInJ6Ro/jv8qXw6OQkaXV2eRV0dlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU57pbjG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU57pbjG"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e3aafe06a7so3266671f8f.0
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 02:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757496725; x=1758101525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6P0q2ohIHyVo5Y7qD/UR/TaPwvcjDjmkEztM1irAUMw=;
        b=jU57pbjGPJ2GsYnzqV3WJBU1Q04i+lyU7nN5zOZJXA+soOCg+gAYhhiq+mOy07pSm9
         BuoYtt9Ma7Vr4hGBOWU1zUrKxaDyLA8brpm8ZDh3Q/EhkaxHiZO1pyZ7Jzb9xYesf5a/
         +xfa93CdazpxMNt36CUktuE8NmVy2eRqstNM+y5WWqB3gcI79wUrgU2xqLwSRJQ65J7r
         KAFq+lTY0vncuf6z+RCuZ+SWY5WU9mekI3XG/FqR6azy8hxLZLYmMKevu4Po0yrH0E80
         JvoiJRaY00ZA0cQLMzL6BPxZmEGnl8q2UpH0qIMGM+FOh/5bIKd+r/65X5QRz837N9cE
         jC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757496725; x=1758101525;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6P0q2ohIHyVo5Y7qD/UR/TaPwvcjDjmkEztM1irAUMw=;
        b=HaiLVs2VBnU3gHgm/du1rcqY4WUxMFVvr0EDhSHkmqBFHWW7LjRe2soMjA4c2DtKw3
         hYF7NkF+GPsTnNYKc+zaFSRwaNdTLckeS1hHE0a4J6LwPpYTQ9a6j2bkd4MiNqemEFBd
         va3hG0UUhvG1WAL5fe5WkrJYXQB2O5yr9TqseFyhROQVEQwRTWy+ILc0dGAdK/odetVH
         cZR5YPqcOxUiaRtCjE8M0LsS+PuloitjWsATOgryJCtf+vmbdjKESoTKyuP61I7vGC7V
         HobtB/6mtm4fZ1x37BiVpNwnnNSmigNFnX9ceNEhnrvas+5/If6bfLoWbTeb9HUdg09k
         01+w==
X-Gm-Message-State: AOJu0YxeAJfmnCvHkrH9Kznbpme50akeMc5C/dyARErBZlm614H0EQu9
	ah0Zx/P2oWc5PtcKALr4hCqecpUx4EscIjrft0SS6mhjFyaW0//ay3jll7evUw==
X-Gm-Gg: ASbGncs9MVIvYfc9Gr9p7mFo4VbHqhCeea+EEvHiJxVHo/rltfbUBPoa7hCYSHJExMY
	sgcMsVWawzjekOMSPIuWt/BdNRAvolVWy29LfOS65CVb/RgFsEdr572ka6Tt5Krwt/HxES5wbLM
	Ea9rcA/l4TAOBZqNnHUWHwQxGR5n3Zq/QNkR7nF+3xd9NsQANwl9f928V6/IrYCWEwXVcthCbE/
	g3wa2uOtGsUeU0oeNcI+PUNwoI4Wzu+pWw+sSveo2QiNnxJrFlNg3yrY1iSZa2Z3tUSLL6x3teF
	Pjz12C9ABKpTyHh6MIj76cAqfin6PwBkySd+WtZLZRniHvROvg0ZV5w6K7j42gVcdv35eRdTWyi
	Q7ySx8NcvTpd8rOy7oo6mJR0cGRz7XPepYI5TFxIomgp39ytE9muHrjLGT47DHUpYddNIZqTZKH
	dsWa0Gui1Etw==
X-Google-Smtp-Source: AGHT+IG+rebHaOkMHo8T6R+CTSV2zlFWcCaLnDzk9efPZWe9dVdX5X+yCsjfg8WDxoAi349QxRwkWA==
X-Received: by 2002:a5d:64c6:0:b0:3e2:bbd1:e90a with SMTP id ffacd0b85a97d-3e64392d53bmr9415744f8f.37.1757496724673;
        Wed, 10 Sep 2025 02:32:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bff6esm6006699f8f.13.2025.09.10.02.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:32:04 -0700 (PDT)
Message-ID: <740cf3c1-2d82-4675-ab22-80d1f362395e@gmail.com>
Date: Wed, 10 Sep 2025 10:32:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v2 0/7] Introduce Rust and announce that it will
 become mandatorty
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>,
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <8a5394eb-bad4-42e0-82a8-fa73123e205a@gmail.com> <aLrzqR2Z9jz5CuJu@pks.im>
 <7c25d5a6-1b34-485e-93f9-25bbe37d5bd4@gmail.com> <aME1Bfv-IPq0zRG5@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <aME1Bfv-IPq0zRG5@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2025 09:21, Patrick Steinhardt wrote:
> On Tue, Sep 09, 2025 at 10:12:39AM +0100, Phillip Wood wrote:
>> On 05/09/2025 15:28, Patrick Steinhardt wrote:
>>> 
>>> I have a plan layed out in the BreakingChanges document that mentions
>>> how I'm proposing to do the transition:
>>>
>>>     1. We introduce it with auto-detection for Meson and default-disabled
>>>        for our Makefile in Git 2.52.
>>
>> I'm not sure how much this helps us. You've said elsewhere that you don't
>> want to be inundated with bug reports which is fair enough, but I'm fairly
>> skeptical that we're going to get enough people enabling this get a useful
>> amount of early feedback. So I wonder if it would be better just to bite the
>> bullet and enable it by default from the start. I think I saw Elijah making
>> a similar argument elsewhere in this thread.
> 
> The patch series may not be ready for all platforms yet though. Windows
> support is still untested and probably not working, so I first need to
> get that done. This is basically the reason why I'm proposing to have it
> auto-detected at first: I want to be able to iterate without breaking
> any platforms yet.
> 
> How about we do a compromise: we initially introduce it
> default-disabled, but default-enable it in the next release already
> instead of first tying it to `-Dbreaking_changes=true`? That would
> accelerate the proposed timeline a bit.

If we really can't get the windows support working before the next 
release then making it disabled by default on that platform makes sense 
and in that case it is probably simpler to make the default the same 
across all platforms. It would be nice to get the windows side working, 
I had assumed that would be fairly easy because the patches exist in 
Ezekiel's series but maybe I'm missing something. I'm also hopeless at 
keeping track of when the next release is so maybe there isn't much time.

Thanks

Phillip

