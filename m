Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7128626B942
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634141; cv=none; b=LBvHuxQja2Tu7GeJckWmd1cVAZtaz651yncuByFg/ySpr3g7rA6lKChjzfWDebhuZHaLY6xWXduvDihqg+fv6aW1jvvmvR/MZTWGBRB3RAwJnC6tj1eixRUdlDUKQgYrL7XmxMXT2vuD+CM33Ef1XFWMIWNDQgc/C8bWtV5HP8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634141; c=relaxed/simple;
	bh=qjkGNWdsAdWMmALlOA3CuR/GNeB58Y8NOtYeN37VGrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3XnoHc/0vR0zJVS5GfunXHwBxomlCBxZDGuCaUgqXqdg88iL/9MU4XYI7QHifj/fTQ7Gn0mH2jvOCAYzNOBexEj6LpiGgZHEeCJX9FlyfRf/OhuUlcK/JLvcvLlXBenMwTXHGEmpBq0aXGXg8NoxYjPidcbEPZxkSCw6G6lgz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Nqen5bHL; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Nqen5bHL"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d60501806so9298987b3.2
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757634139; x=1758238939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1MPBLoqLLOw8QHVGC4kkGK5bDqEaZX64w9Ov9to0Hw=;
        b=Nqen5bHLHwhm5t+P1ap/4qbnar9gEgmRwtgbL2WK9hvJXUUxQkXxnK3CmWX/3f63Xf
         M7DR8BEEX5rjnhuV7Y8wOtxzXkuUgjep4jG1LYGR4o17iwe8aBooU9Sr6bwYQ+N+tDzj
         egaaVNDigFXLFf+hD5ZdKvQTf8AR7quo6vI9A5bDS3tcfGhGfwwx762OyHHHSF/W0NQY
         PFmTc5KqnmHOR1UegG6VV9jpVF/RWM0uiQUN2QPR76ZNfD8VJfm8NxJg7Fj23dGdJx6Q
         1YX5a9eX619gmKHsRpW/ua3GhgRe2ArP0Wk/7LwbwM8Rlvhgah27BRl5vs9m+U+nhGNJ
         Y8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757634139; x=1758238939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1MPBLoqLLOw8QHVGC4kkGK5bDqEaZX64w9Ov9to0Hw=;
        b=LQphBjUm3qU1NVKVp78HPKR0K68FKdx9QV3LTE4R0N8nIvEhqXs2iHa9YacFkJ+/Oc
         +SEqhsi5Rl+fi/0BSwYDQ0RbvVHMaNTYK9lKb3OBEl+abTzfD1tnAbFgqsuIXcw6bcSA
         UAoZnAz/cwzW7wfcv0tmhwav0SeMasdARxU63AFsoE1xMoWZuE98cjPS0dk/CJF/jP+d
         LIh7ZifBsPj+MqS4ID9CVmo746y3DKKCy+oQ9id2PyJaVjhA2KfzTNFC/xVqtCP3ry3h
         hCdn36B5eholkyxBqXXEZ0xSDYaYss1H5yL/fcPjDOlqU58so8sB0J7g+mnk42EAKAPr
         tbKg==
X-Gm-Message-State: AOJu0YyI8z7x+XUNpmwl1qwZ8W2rCfClx1hNaECIefJu4Ne5xHjfm72k
	ATa9r/BT8tgAaQ3THCUYyqeArO+qFeXBHxjErK4swKDcNjRrzwsoBumsBHwzkgelGJc=
X-Gm-Gg: ASbGnctqZz7m8RV11OhTgD+3/EorEStFsG56MtgQdKfSV5xwGc4DN6uZMtxhtSogdi2
	a7eKC2ozvTuiIVKNAKDw/3cJa/ZGhcq/smdEW2OjxYZIyygep7WXs8Lhyy+Q6r0AiUGS/rfkcqB
	UFvByE3SdvaJ/tezVOutsGUxOZmeJHHgnjIOBEhXWZYJ5rkxHaIKDmy2p+bdVCJl1efsf3U5EsW
	mrGzBwbfE/1tuBiFtLkYV4wmYV3r9SMu7BAlroUjFKJ76Rcow0qabrwjnEXQpbAVRlhcp1aWKB9
	TDdTqurUX/Fi90s3FIPFmgRnFXyI7FTQWeN9CNiXC9BgqP8hFe46TgtJ2SIEKx7qQLc2jije6Mr
	pBsDuSeg2ub3RR88TqMmIxUI+RoA24FAaAAZcUEcbeK3f6v7IWuYLyTphCDCRYJeqoAWxnJUlxo
	LCj6JljWYnT8a+jo2UcL3RvZ8a1A==
X-Google-Smtp-Source: AGHT+IG27ofjSLYKzfBqs7bpMBw013PTKVltyTZG500eEC8v6Vt8UF+mdwxemw6guHxa+MScCQ2xTw==
X-Received: by 2002:a05:690c:7108:b0:724:6d3d:67fc with SMTP id 00721157ae682-73062ca60bbmr8737807b3.8.1757634139392;
        Thu, 11 Sep 2025 16:42:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-72f76830c64sm7064007b3.19.2025.09.11.16.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 16:42:18 -0700 (PDT)
Date: Thu, 11 Sep 2025 19:42:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/15] packfile: carve out a new packfile store
Message-ID: <aMNeWPD6spSMB1yh@nand.local>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
 <aMNd0RkdaW4cWMtw@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMNd0RkdaW4cWMtw@nand.local>

On Thu, Sep 11, 2025 at 07:40:01PM -0400, Taylor Blau wrote:
> On Tue, Sep 09, 2025 at 01:02:59PM +0200, Patrick Steinhardt wrote:
> > Changes in v4:
> >   - Small code style improvement as suggested by Junio.
> >   - Some commit message improvements as suggested by Karthik.
> >   - Link to v3: https://lore.kernel.org/r/20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im
>
> Thanks for these changes. I think that this series is getting closer,
> but I do not think that it is quite ready yet.
>
> The largest outstanding topic is that this round claims that
> get_all_packs() behaves identically to get_packed_git(), but this is not
> the case. I mentioned in a response to the patch that removes the latter
> function, but I think we should:
>
>  - Permit both get_all_packs() and get_packed_git() to coexist for now.
>
>  - In a follow-up series, transition get_packed_git() callers one-by-one
>    to use get_all_packs() instead. Each of these commits should include
>    IMHO a justification that the change is safe as-is, or include fixes
>    to make it safe. I think any "fixes" here are limited to "if
>    (p->multi_pack_index) continue;".
>
>  - Once there are no longer any callers of get_packed_git(), we can
>    remove it.
>
> If you want to pursue that in this series, I am happy to review and
> discuss it, but IMHO there is already enough going on here that I think
> it makes more sense to do that in a separate follow-up.

Oops, hit "send" too early.

The other outstanding topic that I want to raise is that I think
transitioning away from get_all_packs() to the new API in all callers is
premature. I would *much* rather see us do this call-by-call when it is
necessary to do so rather than forcing all callers onto the new API.

If there is a compelling reason that we must force callers to all use
the new API now, I'm happy to discuss that, but as-is I worry that we
are changing things too quickly here.

Thanks,
Taylor
