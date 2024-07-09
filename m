Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3941313AD07
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563132; cv=none; b=niq9F7mYqqu1iAadMMdgAUKV05yeTWsZl3f3IqzQEoWM3wxEB+Uk+vk5xDE6YGBhEJ3Qqu+HQt81EkpFD/gwiDBUnenrCEVMrt+zCNYPXVZovp67ekpDr8FHPwnaYz7QnKO2ib9wE687pwP6ypH/bYttXkqH4dEfsmHq5DJC8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563132; c=relaxed/simple;
	bh=NW1FTozicJuww0s9bWzlPjIy7pMkHYQtmS80EkfpOH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOzMxEh0HW8+j0Hdw/TOi4+fmfGuCRbWBTQWfNDrGaajh3HObsSDciUFRyJU32iPk4YIU1T8mO4ltECwI6IhLtzuuzefAA/v0KzZjjcOMSxLnku/MdQPFi46cWuqtQNBBDrg3Cc1p2BazJPRxd633kSr9r0yGHtPoGZgQygjMhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmIlSFE1; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmIlSFE1"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d96365dc34so463284b6e.2
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720563128; x=1721167928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPXZGokTtch3TkbC08DxtfPFcYiF+L8MHBoZPfOLs6Y=;
        b=QmIlSFE11L1FbZrVjzSyVf6Pfw3ZmuOqsgne26tiKSMRqdchtDvKtfcER4bebEFWpy
         /5PCYXMLF+vLiSLnr1+UAe4/JUV1sHPg7vDT9NYB2HQ5NURV2GrlsQvKPGIZSJ0mh3QR
         a/4JHOKTdn8OrHFovqOA4OA4GuCdbARgi/0zeNeBjxsFb9LCGEz54Ov6jcZmB2LTQ2wl
         9HBbG6rbIaG2cvwoTMMkilOQgWxMy/IGz0ObJ5kbd6Jh7mUEpaeAPIN+ZdPo7FgUulEP
         Izd2WauEXize3wDfpCENNHk+JXQ17T5sLr7QPLenGet0jtjE1+xNsdKchm0fVA7360S4
         HVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720563128; x=1721167928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPXZGokTtch3TkbC08DxtfPFcYiF+L8MHBoZPfOLs6Y=;
        b=NqRRpPcCfr0R4SdR2E5l0yUj6R9491uYqvzsoGuv1oEBQDAuERA27uXSrILE7Qq0ja
         romRuG5Cfk4krLR4GcAojTRGQWXkGsyq+0bshe3PXPJSGEvFrIpfaGpv9S8X38JkuwBI
         de0FAIs09O8JgAPHIIoxTlB1A7P+9CYQ8jL2xHyhINqEvYDNYrynmHV8G32mNsXXTpDU
         M+FIeOEbQr75tc/0mDcnWCCaumFVUBXQiRrGiLPuHSl9yfuV6bvfrOqW9Wu8K68R8joL
         8TXBJ8OtBfejBW74IPlEF60axOjNRtLNKSX94pKvI4vH/TT1NpFD4DJOE8vhV/9mGqPF
         XFYg==
X-Gm-Message-State: AOJu0Yx/pwhKibOLzI8Y49DFyI9QzfcwnMHdA5L/GxUVukr+KDlm1BJK
	SZStHaz9ypXekJ9uTOx6AIjQUtXy6NMib4clRu98nJdBhZ6+A8B8
X-Google-Smtp-Source: AGHT+IEt3PnwUkmiuof6na+/MQX6HYV2dRuFybhThXytW4K3pw4W/mJYPG5XZtJn6O6rsm4A7fkF1g==
X-Received: by 2002:a05:6808:2f19:b0:3d9:2a06:295f with SMTP id 5614622812f47-3d93bedde7dmr4575671b6e.8.1720563126853;
        Tue, 09 Jul 2024 15:12:06 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93ad2b3e5sm565111b6e.29.2024.07.09.15.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:12:06 -0700 (PDT)
Date: Tue, 9 Jul 2024 17:11:36 -0500
From: Justin Tobler <jltobler@gmail.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v9 4/9] refs: set up ref consistency check
 infrastructure
Message-ID: <b7apetyejg5ycvvqkc5motpx45mbval5sixvlgwfrh4q5lzc5d@b32kkwo4qeer>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
 <Zo0umVPABD1wkxQG@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo0umVPABD1wkxQG@ArchLinux>

On 24/07/09 08:35PM, shejialuo wrote:
> The interfaces defined in the `ref_storage_be` are carefully structured
> in semantic. It's organized as the five parts:
> 
> 1. The name and the initialization interfaces.
> 2. The ref transaction interfaces.
> 3. The ref internal interfaces (pack, rename and copy).
> 4. The ref filesystem interfaces.
> 5. The reflog related interfaces.
> 
> To keep consistent with the git-fsck(1), add a new interface named
> "fsck_refs_fn" to the end of "ref_storage_be". This semantic cannot be
> grouped into any above five categories. Explicitly add blank line to
> make it different from others.

In this patch we are not only adding the `fsck` infrastructure to
`ref_storage_be`, but also wiring what are essentially no-op functions 
to the various implementations. It might be good to mention this in the
commit message so it is better understood that future patches will 
actually provide proper function implementations.

-Justin
