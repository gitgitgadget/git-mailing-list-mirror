Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB2353EEB
	for <git@vger.kernel.org>; Mon,  4 May 2026 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777897831; cv=none; b=C2e+ZoUfzKIQgWNZxhFX92a2Qr8Fs69vb8rdczVhrpR10sJwANNSrDsSuRCyM1vS3KXdO7KZtJo9nkdcz6nFBnCH+/p8sDekCaMW7a28skpd9DJuzJ+QkwNoe8gQbgyZXPhePTqODu4zV2Esq/oeErFZbyIS/i6K03igxSy1g90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777897831; c=relaxed/simple;
	bh=yB4ADApCNmVTnoUK7AXeeXVAL1XtmE7xOpyTZPnrhAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWw7pDaIF9qJPRBMP7R/v6YYu0iOyhXS9TzkuQYkwt/Z9Q/35FgiPMAIArUYLxDdfn5PzXxxFY/c/a1gHKygMWNtdSTJmxzqZOhcN8p1UVOzsnQCqgLhFyHCqcm4DFbEQ/MK2vDSTw82ce63Ve2ZfUaJqGl+LY8Qd2HczRwvrA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfirgGYt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfirgGYt"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ba922426c5cso700247966b.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 05:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777897828; x=1778502628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yB4ADApCNmVTnoUK7AXeeXVAL1XtmE7xOpyTZPnrhAE=;
        b=sfirgGYtqOtpgl8p0Ppe5fWfWngPBepAGhaCAPYeFWUU51D9SBoUl64rXUVtcTzPpU
         rL+vjnCZzI5ue9uAtw+QUsobQJEO3ONTBrZnpppDma9vFBDyP7cxHLFYtdIsIL+Y8ewf
         giNz8N32gm/MJ4TbHNN4u9mTBr9vw9SJx6taBtMMMwcU3xpL7yaUdWbjJEYlvAWrCtV3
         oGsWI8u8u9VUTbMobZ5spH9xQd4ZCX5MlRhh1vpb3/tm6frMlPqFRxfC9whupSuGTMkY
         k4mRDOme8A3KaaUge0QW/gBnQZDBKTW7upC0gDllabxOJICKPNi9bPAra8kjasA5ai9U
         Ar7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777897828; x=1778502628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yB4ADApCNmVTnoUK7AXeeXVAL1XtmE7xOpyTZPnrhAE=;
        b=s3czYmYnCGxUwGo+q9Wx8z6SLndtAL4V1XFtDdR0r19R5wSZuJJl7zD95SJzolhy9e
         AtkuLrGULsQastbnhGfncNX5lnvXumS4QHE9z4kx6q+XvCkdfNbfoUBg9ioYpUjMQUbV
         pPbOrzf86/e3ahvdj9OB0NpRRggRex5nXLagXEbcpwdqqVaIb0zPScxpskUXHXVUZa4N
         KIYCMMPVHbAaWhuIP4Zp4d9BvyxkXuTKy5FRNbCuVbUjYk5YC/QeULTU7po1iN0V0z9j
         RhcCTE2hrlEKZINq8c7G/gWEevSxcLlxEWXbiCwkr2YJYevF50DVSkim+2BeRre8L9PZ
         SDeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fPZIsvXE4WAwNniuf/B3rjKxXjOhAKH2XbgsI/tvuccXPa4dv228pOcJIKrzz6n13Lxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDDr9tL2G6wsUuw9znyQ9XOeurReob+wx3R+rduxvG+e7Zm+Q6
	AhwZ7DNJ43VP49mZq7DtD2FcvrUaWDGumO4wZgpcwDEWKyedFpqasNsK
X-Gm-Gg: AeBDievTDf8Dnkgj3cGfaVQd+rxEiV4W9vsxMMMI1UrAaARlCYyQ2FB9YFRQqn43P2R
	G32hPsZ10jMIRrkE87KjCWXr3UVgr2SuNUAPmvYWxBMtpxKCV93VDUu/FOlNSVhU56G6Cc1AhkQ
	BWm2HqpxpASkZ1hM/BjlIczG5h+zU6c/B9JAzGPAf179dSCK2kfZfJNocFx0LymTeZZrqPba8BU
	txycRQfQ71JzP7AzkwIxvNMU9CqadON9KTQ1/KMYJKaZsCdE72+yt32drlVmeKsHMIdmiTbxC/v
	fgEcllyD1wdOCX1ImJ+CqkhjKPVNaHIwRO+P8uR2c+obtJaXo8wI+dsSfb+eY4Gp1aNsP1NIF0c
	20KOPO0iqT4+DJQslTHb1uAEh6ZSeO1or00W9xuhkvLBO8A10IUZvaBzYHk7MIXwQtbAHImjzTF
	aADPiAJ0z3JdO/eTxI5ISKcrfgfdC2KFgryIOEqSECmIuNK660r1nzUVm0OVGi6v/qXd1xiDjap
	2ZazKmJamsyZfGjj44=
X-Received: by 2002:a17:907:a2c8:b0:bb9:1a36:f811 with SMTP id a640c23a62f3a-bbffaa2e45fmr502195266b.9.1777897827627;
        Mon, 04 May 2026 05:30:27 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe6aa4d524sm399844166b.26.2026.05.04.05.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 05:30:26 -0700 (PDT)
Message-ID: <bfb6d757-7b13-4267-9fd5-8739c7395378@gmail.com>
Date: Mon, 4 May 2026 08:30:23 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/7] path-walk: support `tree:0` filter
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>
References: <cover.1777853408.git.me@ttaylorr.com>
 <e1b7fd3cb2a2bba5f6404ac5f8ac3487a46d51b5.1777853408.git.me@ttaylorr.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <e1b7fd3cb2a2bba5f6404ac5f8ac3487a46d51b5.1777853408.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/2026 8:11 PM, Taylor Blau wrote:
> The `tree:0` object filter omits all trees and blobs from the result,
> keeping only commits and tags. Consequently, this filter type should
> has a fairly straightforward integration with path-walk, as the decision
> to include an object depends only on its type and does not depend on any
> path-sensitive state.

I agree that the implementation here is straight-forward. It's something
where I could easily see wanting to disable the path-walk API because it
is no longer contributing much value, but perhaps the caller wants a
consistent callback that provides all commits and tags in different
chunks.
> Non-zero tree-depth filters are not supported. Those depend on the depth
> at which a tree is visited, which is a path-walk concept the filter
> machinery doesn't currently share with the path-walk API. Reject them in
> `prepare_filters()` with a helpful error and let pack-objects fall back
> to the regular traversal, the same way it already does for unsupported
> filters.

I think that this could be remedied with some tweaks to the internal
methods and data within the path-walk API to track a depth. This could
be handled later, if there was enough demand for nonzero tree-depth.

The diff itself looks good.

Thanks,
-Stolee

