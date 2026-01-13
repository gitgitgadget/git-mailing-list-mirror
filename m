Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E99195811
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768344422; cv=none; b=GtBsDWfhtbmXwzYCnmfdzyXvks8VeXlmUjMTuZDFcxa909IUMVWi/VlOP+N+1mjTtIK0NpM6DNSyNqRd+SXLQeyvejxyUAaMUcElbtDDiqnkXioUYjRZXYDORJ/zt2iDap7f7wdbIA9E2whUknSOo9U+E5tZRGtX61JRm7jVRDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768344422; c=relaxed/simple;
	bh=v1G7pOVIov3Dy87Ip26nUP1DMndkD0XNfTJVVfbxUXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImLxC7LQPm5TntyKm9uKYKm11tu7fmr6PFefDys2i/Xl27aS1PhdTnSGWvJwljLmclnCFFbqCbUHsDM7in/akevd/wQcwdqlwmJvwebAoS2Zan83u067mwGIG8p34ysqNXxMk8y9y17BBTJhB4T3dLgOQn1L3Wwecgbns9EYafo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=lQD+NspV; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="lQD+NspV"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78fb7704cb4so78053657b3.3
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 14:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768344420; x=1768949220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v1G7pOVIov3Dy87Ip26nUP1DMndkD0XNfTJVVfbxUXE=;
        b=lQD+NspVUd4LXV8yF8zDXrIFPBjiFOmUWYWN9JekoddPNQqXBsZYE/ELW7sLtheETO
         8B9k9i0lz7Fn6rIc2cqNzUlAXlJy/18kYSQkiyBcMk7kWp5Cfbv+WDpV+v8u946N7hrG
         P7Tjt0hk5wz+vZ4Q57xAB4+YK1Nw1tBBafCvF81KSHFfoU5mGD65RLnuoZ7z2Vq7y491
         CPwE6qdjLrfZgbTGUZG7sLVGCXWULVqsOK6X++8bopDSHcDB/yFD1DvGdJtf9fGVyumU
         UxC9Crpd+hDFbPb/ufR5nvHfz/n/4+raefiQ4yb0OZbAqVh4WYaalkg4rIjnVLlFI5fS
         EBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768344420; x=1768949220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1G7pOVIov3Dy87Ip26nUP1DMndkD0XNfTJVVfbxUXE=;
        b=IHJMbg5x6jmxOLoK8y0YpNewh5HX3Fx1HSUVio178MGb5HIZWm/AfPBZUKycH0DyOu
         ObcuM/EJ57+UAADT6OlyCfwKIXAzyMXHr0JP+k3snsavKoblUsP4RzuypFB474QDzys9
         kMaeMyVM/GZ2wiTrB59qyenCFa2EJhkQAJelbsJ00ZXMKFCsOPXBkWXChNyqvMnoHo8n
         B6ZMiAq1H3RaNxWmwJjfPJLHnTEmH93QLeinJxdkQiWggkfId+ZfTMsJR/HVcltRtH23
         Wz/myFxc8R1lyRIAj/Do2foPdWhkMfmuwLt9+bMtTdJ1rDYde65Lg2P8WzfyBa8ctrv3
         eTVQ==
X-Gm-Message-State: AOJu0YwQRCS9xraw33X4vTMYR5grlfIScKSE84ZGa9OhlXBskEQu5ZFc
	UN9uUZe4V7+GuKvEy4dvxi/qmAbUldh3O/LPSbNZEFIBZbCRBzrC7xlq2g5oR3WknIQ=
X-Gm-Gg: AY/fxX6Ermd7gztE9xkDwrgIr55bARAFqBHPAigRu5qhfRLYfGIqfeZd2suETe8Dmas
	c/sQkdc6/rv9qJbLgIEbMpWS5JHJIsMFvXowhTAYLQoN5PsM5kAYGpo52XloMw89bjmW2FSCntm
	p0ewlunK4wJox+ppKHnnHEhbeG/eK5OySvDnZfc+dC9TWBNf81nYru2OypnF5cJNOOAX9OilvVa
	dM6rg7rR4Wr/8pSjvN1Z9tRPkZhRUs1k1oaG8sxLM+tNigfUxg/Pz5JU+Gn2Dad9/BIDTvk5RKi
	NZcwqVykcqICZwkp8+X8IHAh9WGZ4Gu9vWeWeDc6WNYCb9mXWb+fZ36NtyT3GtN3KfJT29A9KPI
	Vvl1zZBAkf/ixYKpbEY7KwbU8RbyX3G/7DCIb7/5NYK0xDOif3tPOWSqciHPa73DEHUCxZvpBay
	tYhT8JpHFTl988pzSLBQ3TO6G/0UevNOmB9i0XE5VClxFzNJUh3WP6I1N67cKUDbCCABwTRUIvD
	EvWqahPbjgFh70yHA==
X-Received: by 2002:a05:690c:88c:b0:786:58c4:7a21 with SMTP id 00721157ae682-793a1dafe96mr4720737b3.69.1768344420257;
        Tue, 13 Jan 2026 14:47:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa576e55sm84117977b3.18.2026.01.13.14.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 14:46:59 -0800 (PST)
Date: Tue, 13 Jan 2026 17:46:56 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/17] midx: split `get_midx_checksum()` by adding
 `get_midx_hash()`
Message-ID: <aWbLYCvzqKNziLfZ@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <d583a169f08eea9d750622c6e3cf79774a2a68e7.1765053054.git.me@ttaylorr.com>
 <aTcYAdJ6lNCST7PT@pks.im>
 <aTd+fxpflcLuJXDn@nand.local>
 <aTeAUKrB89RM9p+i@nand.local>
 <aTfBZVo6Hq8Nf7uW@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTfBZVo6Hq8Nf7uW@pks.im>

On Tue, Dec 09, 2025 at 07:27:49AM +0100, Patrick Steinhardt wrote:
> It's only four more characters to type the `_hex()` variant, and it is
> in line with the interfaces we've got in "hex.h". So personally I'd
> still prefer to go with `_hex()`.

I think that's a fair point. I am not sure that I go along with the
"it's only four more characters" argument, but I would like to be
consistent with existing APIs above all else. I think the choice we made
in "hex.h" is a good one, so let's stick with that.

Thanks,
Taylor
