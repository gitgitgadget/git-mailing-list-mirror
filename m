Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED537266D
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202816; cv=none; b=d/5YhOeqDREXnHnautuG7yVP/DX6KFTXT5HWv3A1m6vXdrlAJQjaA+TT/ZeFyb47s1O1FRqjSRG/MLYi4kK4j3B72uDDdKxXIt/4vo3GgQVP9eMl+b1/ZP6tOmtteIlCxfR1yf9vew1LVzkPvm9QR6lTIyYMlnDPyDumkyYXYn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202816; c=relaxed/simple;
	bh=v1x/AVSAWzSjbEOs0H0Kj7zCMSJgBzGknVozlRiXuig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrXljAWL7n7pIZZPxpm+49/v82ebizy4GQsyfgvpCasTj+n7/FQr1gBmhb7lrepntvHfkTpoafIVRQazsLQ85hfZjnCsAyZZ9oFBEK+crBBlJcxyp3xragwlajcxiaKEYbeFQ+6XMntktQfdil3RoFz/T9FvvqAbk3xmaC1OUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ljDyI1NA; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ljDyI1NA"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a2ee65171so77356037b3.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776202814; x=1776807614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KBHN8gTbB/gxDTxvvWe01kTjwt2kE1HNzRf3SJQ8LLU=;
        b=ljDyI1NACGJiqQjVTk0EI3QfhfwCaUTxSrCXXVCjVTVyG62BD9Y6SGVmQsZgWdOOee
         zdyQarL/pNUbxMMAc1hXDFG+evxJrdeJLoKeGXvFUnfJKFfAryYDfJ7bXfhOnroU1/c6
         xgl6IGpTJjXXQSABy6MlYK/yL/Q1s7MQFN9tCma/ABopbuq6ArO4BcOA3jZ8S8UlzXsB
         VTHLT1yXgX4PSUygEUuy+1/gxIA+vvGi0+LZ9x5Zh38yo0oyCgPfmOD4Ym8xELRILLhO
         zsk0BwBUcjeGWIsZMow6fTZ2PjYNwgi2fxbyVOPlqWNDJWLpdYL6jJPkeavmAI/ImL3a
         D4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776202814; x=1776807614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBHN8gTbB/gxDTxvvWe01kTjwt2kE1HNzRf3SJQ8LLU=;
        b=Ph4i0z2xPbBsEPjglp4Vky3TbDyIE3SxlZTg5agdnboobNqzTDp0bBWjMyZFDBrFBg
         i6hwGb9OuHg1b6LkN90TkXR1wDDIXnDNQI/KPo4pr9Yv1tx6EpVPdvoYMwFaYXg5Yjgx
         CIUMarvK0Ed3k5PpHRUMwCgEepvIcVPwnZUGiGMoKtQDglj21lEx0CyMic1oGX2MAUx/
         Ebm4q5nqXDtaTTToCnlCFxvZ+Zj1IE9Ro0sURFgdkbAVPTAi1ZoLBj9b/UFsVCOUV83Z
         qsMuZAQ8u4y9jsd24yJlgPOs8hT4PywFXy2ut7PE205eta11kzEJRHRASLXaaQoPJNTe
         Qb6g==
X-Gm-Message-State: AOJu0YxseE67Qj4o3bmJIr+Z7Fn5nhzKu10rh5bHucv4nOt4xZn0Ex/3
	+f8Q4nX70Iw+u7dmBwCYPnff+HpgWQWKDkBVCIFGf/Yv58ck9jHvOfrkRUVUICUM+Mo=
X-Gm-Gg: AeBDieu/AEomhoIg8i9Tv4JXd81q0k6PmPf81lz50O3ol+PbE/KOWLo3/u862wY2tkS
	sdAmHq2ZIbReMl5jJHBMJ/oTqJLAlJQLy/6VF+K9czOalisSZxNOo5M6+TlJf37JDlIkv6fc+FM
	oI3gC0SVxx6PbEkIVV5WCMVjKdJxZn4GY9T6eznbVEQmgc3AKtwc2HOujhvV9h8jCRqMaQrIaRx
	DHdcPcIaFDVEJa6vOwu4Q+dRDVhyQJaYDoJ2akQsASWvAfaZ+VJOua6vupP/iKilnhwICNOfhEn
	H25kXm1f1uzdpPrrPgecluXYHJa7vCbaDzO6/OrFfkWYOEg2zyNApR1xv8zApkBtrrQF+74Pg31
	J8lwXonqOEtdyQBipk8k/88yjr7OJzmpkjT1NQOBNlVP8n9rrCpC5npgGV/oNp34xcyrHiPECkG
	+SbUQRiy8Y4RhUu2BTrZg6shBVepwwbIBfUWz/UMmV+rYptZwqxI+1VabLO/1cdsjkldf6Tpecx
	M5UbeMW4YbGU02NuQIEVRIfCgFb1T6II19T1wPmxf0k0SZXwK+vcdnSXjKI/AQcIWMXzGZmACCA
	nS5nT7Q/LrqLeaXebNs8H2jqiJU=
X-Received: by 2002:a05:690c:8d05:b0:79b:e1e1:9e4d with SMTP id 00721157ae682-7af71e4e8c4mr171318267b3.40.1776202813935;
        Tue, 14 Apr 2026 14:40:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b2514abf11sm39354847b3.41.2026.04.14.14.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 14:40:13 -0700 (PDT)
Date: Tue, 14 Apr 2026 17:40:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/8] t/helper: add 'test-tool bitmap write' subcommand
Message-ID: <ad60PJ/pM/wG3krQ@nand.local>
References: <cover.1776124588.git.me@ttaylorr.com>
 <d5ef6b959fd7c05c73bd33aa2b394558320aceac.1776124588.git.me@ttaylorr.com>
 <xmqqeckh9uew.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeckh9uew.fsf@gitster.g>

On Tue, Apr 14, 2026 at 01:08:39PM -0700, Junio C Hamano wrote:
> What happens when a repeated call to this function to add many
> objects (those contained within the pack we are iterating over)
> caused the packlist_alloc() to realloc data->packed->objects[] array
> eventually?  Wouldn't it invalidate the address of &entry->idx we
> are taking from before the realloc() happens?
>
> I must be missing something?

Good catch, I'm the one that is missing something here, not you. This is
definitely a use-after-realloc(), though in practice it won't bite us
because we are likely extending into an over-sized heap allocation
without actually moving the data.

I don't know why I thought we allocated the packlist with a fixed size
equal to p->num_objects ahead of time, but we don't, and this is clearly
a bug.

Will fix, and thanks again for spotting.

Thanks,
Taylor
