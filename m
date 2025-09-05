Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC11AC43A
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078060; cv=none; b=mbsN/A6eDFNhUcKt0QZnrLeCN7RRwUwwv4cDuZQKtQ7Q+v1Enz+sxQoyqp2mqub/QqytWwfVPyVJgn+YdrwIfnbTjIQQ1sNrK76cmI3b6I4yeWuhrXWfVySEUvQVz2dLaP/0WcfBSmYruPuI11GT13eZdDrsfVZEIfUsL6oNgAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078060; c=relaxed/simple;
	bh=uBWNu48iLh0vW0fUHLFme12s5BAeQt87er0XezfoRkk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L7ZeBvobqPwuhxWbmmwNKJz0y26hO46TVYxuuIni/nE1n2kT+Ys3TAl7L50AfFmRzN6mZKgtvYMDQjSqN3x/lDgSv8l0d6QaK/iYMMZoteFhXzqxsfdsebM/gqFWn6l4c7HtW8IcybLNLFTLIAXW7gVjogWGjB3yRGWbFuLJFFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjHS9tPG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjHS9tPG"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso1900741f8f.3
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757078055; x=1757682855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:cc:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywidkSMrYFIeTC0TXwvPzpVj0xIzWmbtK3VZyHFGLgQ=;
        b=mjHS9tPGY8Rkg7SC5/9yglVi5o9UPFs04LZk8xgv5BFEjgpZ3LpL25u3FB2AljFOkD
         ybaLiFbmcpgSiEY4APFKdrLTMMO76pSN6BzOwYnNA8pVUJEUOuDgAs3SLpJAmMCx3bOC
         XFAJWKusiwqvhDAnu9MzWdpYAqe6UJlQLHP3geMu4SB6Xsp8rtWsbnbGmbvpHSlKIsVr
         ldpQW9FKKQOUTWdVY/zVRzHneQ/LEoiKzr88kArE1cSekk/HWj/nPDpLyL9kTUccgmxL
         oB1tWZkPmDzasoWG40+xT2Vn6u+g2afy6sgq9KncQc5gehQ1DS9q1wqRuUPVWiNUHYi+
         JS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078055; x=1757682855;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywidkSMrYFIeTC0TXwvPzpVj0xIzWmbtK3VZyHFGLgQ=;
        b=GsR+jAJehmaVFO5/EMCg+lgV3zRdjqw5x8aSGOQsGf6Cff5LIbbqZTrnZ9MYZPJ4HY
         VhWepqLu2qOwjHvT2FDaf4Khxd+G5y0VY3a0H2Q/ht3q+K6lgHRw3jidkQv+RjbbfWyR
         7wgpJyIa5kMdnFYDPX4aaDLjFL3K4fMwwA7+TV6Mug8xLUNzp8FcB0Rgs3eAHIl2Uvlj
         rBs7SEfITjefPilLvFOwQJr+6olT+ncYpMyyeiGoF55LGQXw40m+KNowolRmddJAZG0x
         pDSo27legnH0+hopHMUmmUS6vFeN+T2/j5QmZOgA78c/Bp4TZx/NmLaquzwtVlSOIyjw
         h7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1t6kj4JPs8JkT5ENVaWRl6NOxp3fDGTVqZIDhglcuXl8OLmmtsF0mic9ns4rdZvIQjHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLZEVpvAYRvZ930qKEt+TvkH+xYqiI0EbUUge7lyx/AwI3xep
	BW9cCqPDhIcD7WtC+ys7i7KH3yB4rNjYQsYCGmoUpIqH8O8nQJ9/J/e8
X-Gm-Gg: ASbGncu64KAff8kKbSML8AbuemelqScR2VnbpbIkqD0tqjbYUW0bZcwtgjpH5rBcamh
	E23JfrHhHNN3E2atomnUR0F8c7mPKWhCWBpjPEyeYh5VtD99NYP9xWs0Y7qnytLZDyUp17Yd8Bc
	bvZL1LJTIEYnQ7aYCTyeRyPCAbqnxIk/tNR3cUpciFY/2vk6JfIbRkMv8svHQMbxkHl5yqnUB+C
	DXEFobpAoKx5/bseQ0Ld6p8Q8uKZzgvptFwvMBidYzMBUFpPJVOgrThOyV25+r9d9FVU38liQHi
	altLIun/qf5+HylnQZeOT/cxK7VrUfhftAS3/nkEKCF8gwKbvqLNrhQX8obLPD1A4fbVj8/h54e
	pf1U/yJd/+Z3cNbp9ex+wUiz8DpD4ItggS9ZyOPuk7LctUU9/Oh1FiNJfP6Od3l5Lg75+sANfGs
	am3HykCe3uzzVw7W93Ykz2
X-Google-Smtp-Source: AGHT+IFisLRRtx+GEfScQISHw/wmRR0KJhjNcfPt7ZqKZjc/SxDnShWXIBS4H+UBhe0wfy+WQfMGkw==
X-Received: by 2002:a05:6000:200c:b0:3e5:9ce:623a with SMTP id ffacd0b85a97d-3e509ce63c2mr347658f8f.52.1757078055284;
        Fri, 05 Sep 2025 06:14:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:b1f9:bb5b:f811:92fc? ([2a0a:ef40:1751:3d01:b1f9:bb5b:f811:92fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e4455ecaf1sm1950245f8f.40.2025.09.05.06.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 06:14:14 -0700 (PDT)
Message-ID: <ba386547-10e0-45e2-95ad-c47e84919abf@gmail.com>
Date: Fri, 5 Sep 2025 14:14:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
From: Phillip Wood <phillip.wood123@gmail.com>
To: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 rsbecker@nexbridge.com,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Christian Brabandt <cb@256bit.org>, Eli Schwartz <eschwartz@gentoo.org>,
 "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
 Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>,
 Mike Hommey <mh@glandium.org>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>, Josh Steadmon
 <steadmon@google.com>, Calvin Wan <calvinwan@google.com>
Reply-To: phillip.wood@dunelm.org.uk
References: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aK5mJI1NfVQDmDXN@nand.local> <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im>
 <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net> <aLfU5sEa-RE3X4G2@pks.im>
 <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net> <aLl6iFXeAvL_hvqR@pks.im>
 <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
 <ada227ec-94aa-4563-800e-05c116a361a8@gmail.com>
Content-Language: en-US
In-Reply-To: <ada227ec-94aa-4563-800e-05c116a361a8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/09/2025 11:31, Phillip Wood wrote:
> 
> I would like us to adopt rust but I am concerned about the implications 
> for platforms without rust and think we should give some notice in the 
> form a clear announcement in the release notes once we have a concrete 
> plan. That plan should include a decision on what commitment we can 
> realistically offer with regard to security updates for platforms 
> without a rust compiler so maintainers on those platforms have a clear 
> idea of how long they will be supported.

Here's what such an announcement might look like

     This release introduces an optional dependency on rust that is
     enabled by default. Platforms without a rust compiler can continue
     to build git by passing NO_RUST=1. In six months time we plan to
     make rust mandatory for building git. From that point git 2.x.y (the
     last version that can be built without rust) will continue to
     receive security updates for three years.

To me the important elements are:

1) There is a short period where rust is optional. This allows
    (i) Distributors on platforms without a rust compiler time to notify
        their users that in the future they will only be able to offer
        security updates.
   (ii) Distributors on platforms with a rust compiler time to adjust
        their build procedures to include rust.
  (iii) The git project time to gain experience of using rust and writing
        the necessary bindings while building with it is optional.

2) Rust is enabled by default so platforms without a rust compiler are
    made aware of the problem but have an easy way to continue to build
    git while rust is optional.

3) There is a period of a small number of years where we continue to
    provide security updates for a version of git that can be built
    without rust. This is intended to  allow a realistic time for
    distributors on platforms without a rust compiler to port one or make
    other arrangements for providing future security updates without
    placing an undue burden on the project to provide security updates
    for niche platforms indefinitely.

Thanks

Phillip
