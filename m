Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC5F63E
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713505009; cv=none; b=Ch9J117UZc2STRbMIsXBTv6bW8XWeb8gIxC/v38/gkCc+wf7vL+FSodSf7vIF+lzDYlOmC5z0tze9GzXxCqLcTZPUw6PHD7VIzyt1oCBz0wR7BimKPSpvodWGSy91pNH4BvleBGC6bEnVZKCKFQKnqnFwQzf3TYg/AAZTkRNgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713505009; c=relaxed/simple;
	bh=G+T1uRQPOdodD9KIIkisOI7QvFmLNDJxNihNpF+ObO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sVbKXv76Tjtn4IVjM7+H8fBCBQh5B9TpKX1HZRqa+RETXRJf+oKsT0ihsBJJ9TF506Ut6O58Zl/dpy7yi1DK2DSpMqRsuy3HKnYRWPjbep6wxW/TIozAY6nZWvddJ1z+eMB9eRF85CBUxod4MGwot/vu3xlo6dDdKdiaersuLZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0QcKjWz5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0QcKjWz5"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ee09c3404bso2497750b3a.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 22:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713505007; x=1714109807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJGh7xDTbRFHFi7JZSo+1Z4Rcn4EHGmxvkd5pmXEN1g=;
        b=0QcKjWz5+mOb9sv591EiHSr/4IUwyUWSyJvEkJak8w7L03/7J/JtN4+OTeOMxYeHqD
         IijHun/Ku4pahfY0dRG9uD4yPGTQbgPEInY4l4Jf5gBc13m0s10fcEdiCF4zLHKj6hFC
         FANKfwJ351Sa3cAGIMdi3luqR/ZIxj+sBxjbLBkJDYb45RecIrI640Bjk2amd/pF9WEP
         5yl43CG4T95FjwcDM/ouitXnTVNVboH/m99OZCQ5hotEAcz8m/Pm1OcRvgHUgZiGfT/C
         8Dn/ed9yxogCIwBs3gKSVX0KJQLsDwSRTZDXvZdOdQX5uDhNOrtgXzInMyV4pDfsKZ1T
         i6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713505007; x=1714109807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJGh7xDTbRFHFi7JZSo+1Z4Rcn4EHGmxvkd5pmXEN1g=;
        b=nrzMLx2j1Bdqei/ZCE4cIie7Z6FTMsNamh7NlD7WkZ6iOd9tuPxvMpG9cuJblUbqh/
         p5pPpyKnGJL2pQtP54rPceAiK7tPuexTAZMu/T9VYs2K6Y22+nNQkIOp3Ds93C5ARDxv
         HeuJJLIEvKHU4OyVYPHudtpwoG90+/QOeKtBMPa4T4EBJeDoW7wm5LP555lSOH2YL/aT
         8r1UJ9eCJyMK8IAcp1DcTZHNfw3y8GIFONldsYJBW9qaEOPj932hhlf1mp/EHQ5UU58W
         c4Z7ynIfdNms0zD1UeOFE1tCn6pN3BHkADCO1Q/mq6ptxw2MQ/8IdsbgaxU4nuZ2+aQp
         Jhjg==
X-Gm-Message-State: AOJu0YyD4J6Zc9Gi7SpjskuSzGkQphMy9DwtVm+3EVDtoUaYqiHKxh6w
	LkpkDr1pmTLJE81/3BJvviN4b4IXm9ABp3D8eORljgl9PChshOOULzIkVHiGtuMqFiUwHsEPPN4
	6AA==
X-Google-Smtp-Source: AGHT+IGW3vgQJ+UweHocyqqwUP8oI07tqq8gLwWQTp19sySBqxPpC2sf+BYeKApoqC+ItuYisJfDP4swdyA=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:4f87:b0:6ea:e2d9:f2af with SMTP id
 ld7-20020a056a004f8700b006eae2d9f2afmr139454pfb.0.1713505007077; Thu, 18 Apr
 2024 22:36:47 -0700 (PDT)
Date: Thu, 18 Apr 2024 22:36:45 -0700
In-Reply-To: <xmqqjzlo7ixe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com> <xmqqjzlo7ixe.fsf@gitster.g>
Message-ID: <owly5xwdoqvm.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 0/6] Make trailer_info struct private (plus sequencer cleanup)
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> NOTE: This series is based on the la/format-trailer-info topic branch (see
>> its discussion at [1]).
>
> This unfortunately depends on another series, which has seen no
> reviews after 10 days X-<.  It did not help that this was sent
> almost immediately after that unreviewed series that it depends on.
>
> Any takers?  There must be some folks who know the trailer code very
> well, no?
>

I've added some unit test cases in v2 Patch 02 to make this series a bit
more appealing for reviewers. Cheers.
