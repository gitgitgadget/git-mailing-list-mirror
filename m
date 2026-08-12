Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716FD45A2AE
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786578075; cv=none; b=HpudgRKBWatlAenD1mlNNyvLwuuf0etLAjyJwmM3OdD/CBRHbOu6pW+jjONfTs3DnMBd7h8++Z8E8xTjWRU8ySLRuCfLdvcv6hBbXSpRz+beWaz1bfH0/CgQxGgheVSGankVPZMlCeb7Fy8SnaVZtja+Xny1ozvG3v7pmiSIP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786578075; c=relaxed/simple;
	bh=6fKmG3NdA4fguTJD4hdG9xbvHQ5xh31678Tqv3yITCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ni1DTgJ1+fuhVSJrHk3+ZqWXAm4azTqxJoGLgVZyUCvH2rdXldHzPzhtlTXZsDu4Fo5rkNnHthJeXIL7lmvebCigT7c+nLqwaBkWAuu496oRjZY0UxvSWqM9eeCH0J6Ww34+BdV1ZpvE3woHxB03ZwQbgTrT9C2UwNKF78+FYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=fICOC7HR; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="fICOC7HR"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-667bae10ba3so1592017d50.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 16:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1786578073; x=1787182873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6fKmG3NdA4fguTJD4hdG9xbvHQ5xh31678Tqv3yITCU=;
        b=fICOC7HR5fFIbLc9UdeWtxngJoNy70JgFBdlKrysgPgBIj3uARJcPeXbrpGmeyIYLi
         l5BB8/S3c3Wj0H2NGzCOMQBbX/pqqgI7/v0dEafjpTR6KXXIf8cKyrmpXhlQaxoOlgaW
         4zllXdDwdLOtmiS3+kdjyqyh8FZgIIexiaMnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786578073; x=1787182873;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6fKmG3NdA4fguTJD4hdG9xbvHQ5xh31678Tqv3yITCU=;
        b=Peyq+Pj/T7eWe/RZYgLH+Y6Ce5v5kITFW3RPTucrvEBpHXbxwuparx3hRrMiZCKpnQ
         RjnoR/oftqPmLQUYKcZX9CsEHUD9etzbWv6GF66BIrJycxpnpyx1tuone/Xl6SvNIfSz
         XrI3PwEfrSidL99WMo84ffGfgaVqPjBU3zf7vZdNbb5HrzPAtFSvYdAs5RJ/ZnVH0yxo
         //GxjbYkDc4gby4PJ10nGGkm5SwUqttwCNCH7bbFlaXIxlqyV3+LT/LiwU72K5sBbTtF
         bvdxpR1HO1jjLrWl8dzZLxnvv6gDef1goQykSkh0i7rxhc+M/76DNhftN553pkXFZrYs
         X1Gw==
X-Forwarded-Encrypted: i=1; AHgh+RoFU4byF7E9E82vOeYu4IThO2K+2ZK0U1HA73Vv0cl4Dn6Fp7203wXcmFhLaRAKKTil64w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAtsyR+6s2frTUsT+g1h0yXu2sXs4avF7GsPeJt6FND45o7AC9
	2Be7/Di8O9HJQb9cdCrkLjhFID3E5caskLer8GJpwr6UutAnHIxPoddNAWIe90sZwqGChIMJXMA
	eC14y+0k=
X-Gm-Gg: AR+sD11dfRcGN9YpfnLDQRbIW/h5ZmIeZmq0/WKWTH7FuwjgBUoDYEEXI4k3Ih/2vhm
	1MXH3q+BRm/2EaVCbOABS3PQxuZOYs4qfcbWqZzLPFBRaOauPpM80kxFP/ZPbOC+frumr0Urpsq
	/9Ns98RsM+kFfxuCIBHp4iWKnUaphNqyn2n/fkCKVHNERAUzh+LHKrdVE8MMJUjyt9AZj0uezDM
	Ln3+7XXxyfBPB54Xtea+lSui044fxw1ToZrfIrN5I8hEjvUuq+lHM0SZ8r11ZC9ezXL8nwDI9Ny
	Km/d46aRTRBzMa26eDvdfWv9URcUkjGl32yigAS22sOoAVLFThfuUCtNOCBip4fdl8fzphy0pSj
	qYOQ33cUlWwoaX6QcRF0bRt97KXb8W4vZFdbSnyrQ2DqL8jbP/jT7WwRLCFu6DGqj6OgfD3JEJ3
	O9hpkXu7wc/TfTpJgA2/2yrKS7dglRxRLc1zFeowVYZLLYt6qSZNQWcts3n2C3yRz3ZUJHo9eqW
	bn1jnClDDxk8UKstIKLDTKnrBdGql9BBPx4bpFw/dwFIA==
X-Received: by 2002:a05:690e:1598:20b0:668:8dfd:8c88 with SMTP id 956f58d0204a3-66c516375dfmr680814d50.32.1786578073099;
        Wed, 12 Aug 2026 16:41:13 -0700 (PDT)
Received: from com-79390 ([20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c56e22894sm108767d50.1.2026.08.12.16.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:41:12 -0700 (PDT)
Date: Wed, 12 Aug 2026 18:41:04 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] odb: make packfile generation pluggable
Message-ID: <an0EkMZGEbg6LERc@com-79390>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
 <xmqq33wpej49.fsf@gitster.g>
 <anlg2rThlBLavyU8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anlg2rThlBLavyU8@pks.im>

On Mon, Aug 10, 2026 at 07:25:46AM +0200, Patrick Steinhardt wrote:
> > With "--no-ref-delta" thing in flight, this will not play well with
> > what is in 'seen', though.
>
> Ah, dang, you're right. I'm not quite sure about the status of that
> series -- there's been a discussion around whether it is the right fix
> in the first case with Peff, and there wasn't an answer since Peff's
> last mail.
>
> Taylor, could you maybe share what your plans are? If you want to pursue
> it further I'm happy to add it as a dependency and/or wait a bit.

Still something that we're working on, though I think that it's fine to
kick this out of 'seen' for the time being.

Thanks,
Taylor
