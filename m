Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5DD42BEA6
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558259; cv=none; b=TCbyAUg4rdotLuQWKoihsudJPYeJlwsXEGCM4T+xDgopopC2UpMeRJCL3vqM+KGFBbCXbMCTS8jHS5d9QDHLQxpOvE+H/RLNNzpLussuuySjzhDHv8hjnD7IMMStIFrMJLLgVg/2+P+kqIjPyEudeb36rKPzIFJGdHDtUn7/RPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558259; c=relaxed/simple;
	bh=rqvKVAAOmIomfJe4Iq5SBJDTq1tWksu82QJRB82NP7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7P1wilaHC7H4ejHGgeCpG7iWgpXGRpBm7TScWZsStgLm6XeXZeYKUaKessxkYNyUxMAtVfE/FE3ixF0VhUXtx8EAaZaQ8sMbt/vOmxgwqXYq5yt2aiFaRJvlQfH4qfXnGl1BtABhpoS5RF3XSEqDciF3RiduerEIgvlkmhj2eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=A8AMBaLs; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="A8AMBaLs"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81e86df8987so43312337b3.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784558257; x=1785163057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U+02Z3+HZw83bev5chNg3D6o7MMv7nAcpCkJT1jkBaY=;
        b=A8AMBaLsOdTquzjjd6ldrfWiKTRWslmAkoO3Qio+NDTBirvZiYdRpjgxEVGerTMmdl
         ucTENQqHryNpyCXg6nf4GiujLf02EaFBS1+exOVGwrnhnveYnQSJRwE5UeQB/47CIu/V
         calPX6gOENpOqJ5TOWgTlZ7xmf5esYlCrrw2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784558257; x=1785163057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U+02Z3+HZw83bev5chNg3D6o7MMv7nAcpCkJT1jkBaY=;
        b=pqVaTFxD2pttibJbouNjCvMxpuc52oHNz64j5LAUCq+DPPiQaORJtwvRe7fWc4oFZZ
         eVrxs8JfMYotWSu034M85yEiVKYdPYaDYu0RG4zzgrUxiqfoGu46QLwjwJ8vt6WS5RGy
         7h8D00YShV/ZSOX6iOgp5d7U5Ypa/5pX82JY6JntmgdXuH/xqha00wgnxaYFAZ30zwHB
         7v21e/7UvJqoEfvG59E58KNp8sBaxKlTtfIsi+Jun3Ank1KlaHGlWUazH8kzeeVLZ2Al
         B3oxbOK6qU0GiAXolAltK12kezTU1GIEkjuh6EBLvXmKTADY8344Hy7CQpCdISplqEhr
         x2hQ==
X-Forwarded-Encrypted: i=1; AHgh+Rob91grYVz+W4Rsts/BRBwBcPUvGTLS1apCPTyI9lSfPbDzJG9kgN4j1vEBHPuH+HnUuWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2KUnB56jW1YeIlZiWOvefJ0UnRipA/8OAFKmspEJN+K6FqRKP
	O6lo1fq98bcRmIfwaMX3oIOyRkRlxAFy/TITZmTRd1R9CCbrv2lqH7nVAlz6nJoAHbM=
X-Gm-Gg: AR+sD13zZe80LEezrWByjfSzuhwzerOb3tOwgQvIAh3J6KVU0OD2UGOghZ44L6mKgJ+
	OuBHHEh+SHw0NRsCMPTCk2pOXUZ5OD1FSz2e+SyCip3biuAUv5kIkzrQNgpFCAKzA+KiNscbCnh
	Tvnp225rbmHbctfR64EPaDGD4yoBJeu5jRMIv05AaKkwJnK0Fa5+b3258R2qvYomZSIQbgDQzUW
	BKUHkEglh1W/8gON3gVpoubPxnNp9Fn7AUvyvdCgXeIKnyQd0JIRyJVE2yTdLJeMHBFAQlwiYCe
	PvIEe8B6nlaYaA2vkxIxiNTPKY+7EqHqSZEuYKgiu612a3eiSCfEDuhsp1mK0KMku7NaGXUU6RD
	SvpTff9BsVdxsC52+gq1XzIJg9zPl4YAHMMZzw1vTh0yNMBu5HJwFcVo5vcpPpKGAXhNyDFNZ1M
	RBlFrrA0/ERRQwLSY+u+mVVmjarI1MGvUPS+Tzibt+nBnI/flVtaeB8u5d1E/2xDKov9TlIQ==
X-Received: by 2002:a05:690c:6a0c:b0:81c:b0ff:d664 with SMTP id 00721157ae682-81ef2760c0bmr48714397b3.18.1784558257287;
        Mon, 20 Jul 2026 07:37:37 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef4275090sm51078237b3.29.2026.07.20.07.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:37:36 -0700 (PDT)
Date: Mon, 20 Jul 2026 09:37:33 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] trace2: tolerate failed timestamp formatting
Message-ID: <al4yrXXoZiHLwSvE@com-79390>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <alpXW5U6sndZtgqV@com-79390>
 <c8d443a5-3cfb-4752-8716-cf0d8fadd9d3@gmail.com>
 <xmqqzezlhgyo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzezlhgyo.fsf@gitster.g>

On Mon, Jul 20, 2026 at 07:29:51AM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
> >> Would it make more sense to fix the xsnprintf()/libintl boundary and
> >> treat Trace2 reentrancy separately? I still can't explain why the
> >> allocation failed, so there may be another GfW-specific piece I’m
> >> missing.
> >
> > I think that your suggested change has merits and should be pursued.
> > I'll explore it a bit to confirm.
>
> That band-aid may be a good idea, but I would prefer not to see the
> conditional in a common source file like 'wrapper.c'.  Somewhere
> MinGW-specific would be more appropriate, would it not?

Yeah, to be clear, I do not think that putting the '#define' here in
'wrapper.c' is appropriate, and included it in my original email only to
demonstrate the shape of the proposed solution.

Thanks,
Taylor
