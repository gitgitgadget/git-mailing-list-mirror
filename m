Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6361B7E4
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706392212; cv=none; b=BUoOv7dQqLB50IOpQhH2jBMJnykCyMgfAgiP35hPuQRf5M5melKbji4qVYRaPy5vQ1LHWP/Mc0Tto5DWiM1PC3NY3yHGS0HkujaeI3eu+xk3QgvwCr40B+26ehVph/Txi0G+Vzz1mkEA77EavN0BYsWap2z0v5MXHRKdzYacwm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706392212; c=relaxed/simple;
	bh=Ofmm+27VCk67lsXsbWkZd8iRg0l2HhbREOWawrpldZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHj/BGXflAfg57ZJlDv4QT5ENt82gVNE389bGmih5oxgx1vHV8EqoK9St7/Bkpd35LNYYDTYam6Zy079R5fTEyKbsBQtEUNfaG+syX+lLt2gXZXmgbaoBJebYuWvgR+UlcGSNkICv+GD9o86e1ADGHFZLyv2WIAT2MisLA/N8h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGkVVEde; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGkVVEde"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf591d22dfso3842341fa.0
        for <git@vger.kernel.org>; Sat, 27 Jan 2024 13:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706392209; x=1706997009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ofmm+27VCk67lsXsbWkZd8iRg0l2HhbREOWawrpldZw=;
        b=TGkVVEdeMR9hkNjjai09+s65wcn0BVUxTjSDqgyC47b8XxrB2ORjXWND80n4Nikg6+
         rI0Jhvb4U7rzN1qul8jOgR8WZmFN6thod7R3f9ujmZmQUtHuTKtt1BSY9KksXy2sw4rQ
         aueWtu0NV4/Up+sxPlpAZkQ2H1k2mjldBiN63cajjh988org6/z2LXYhIsGkC3viWXfx
         rE9RyTAYiEBhPJPSVjA2YZEFBgAumMf37ppUZ4Q+7J9ZL/1TGufo2C7uii1aSlprrsYU
         WEej3JABDbCkzO9WcDoa/YbmeusiknN7sGMquqQ0ZUGj1wHwsB/F7+j8psuQjdlSrjAt
         3mAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706392209; x=1706997009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ofmm+27VCk67lsXsbWkZd8iRg0l2HhbREOWawrpldZw=;
        b=ukWzNOV4Pd8uI3QUbUCgdcBhYgF/qwKiAv07YGU7IOAeesNKkttAzBLxM3DFTWiUom
         VPeJj41SUaRLh7bqP64hLOc63PMborJzoyOGM5tPJmC12yq4oTzIJoFzZ2H16AQEuo2K
         KhCJ1r/182kxUvtS++8/PDNdCyUAMzL3kttcJqDs9Ktl5YL5dNx2JVR+PnYCLoKlttuF
         oVsA4iG+UQ1X4iSCt/xD4NF+YsCgunv2nh4PcyQNsZwgMJFPtFGUpwNlrTWSiigpFwf4
         vIB8xzv2oBB9efogz1U+hPn81pDVXF7RUnXGyShrkIdwtzewf+E2ACzmsWPyl9dyejoZ
         ECkQ==
X-Gm-Message-State: AOJu0YwOYnuSBnOzXU3ohCZ7+ymFV9F0F7W35Vkc7SO88XRSOfohOTY/
	jBiADV5KC0YKks7Ww3A72e+6Y5ZJuBO2OaduLZHkwc+HRO/ZwrnORNNFfgaTTr1vn4KD64eWwSj
	sMf5mdEYERxNfwjJ1enOsOYDGlKozjrA8Tu4=
X-Google-Smtp-Source: AGHT+IF7MkP5azp0ya5hwhW3eejvcv20uDtplUfNgDiHbJAqhCklIJEXouAUwVU+Nw/evZRsXkOuR1ukfVBw06fkDpY=
X-Received: by 2002:a05:651c:cb:b0:2cf:33a0:15ec with SMTP id
 11-20020a05651c00cb00b002cf33a015ecmr1405752ljr.26.1706392209019; Sat, 27 Jan
 2024 13:50:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-4-brianmlyles@gmail.com> <7032ae96-602f-499d-8430-a5dc3864d1bb@gmail.com>
In-Reply-To: <7032ae96-602f-499d-8430-a5dc3864d1bb@gmail.com>
From: Brian Lyles <brianmlyles@gmail.com>
Date: Sat, 27 Jan 2024 15:49:32 -0600
Message-ID: <CAHPHrSefHb7KddWNS4NS2bAFG9DFfKZ=Ue499+EqDT3myS_tEA@mail.gmail.com>
Subject: Re: [PATCH 3/4] rebase: Update `--empty=ask` to `--empty=drop`
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip

On Tue, Jan 23, 2024 at 8:24=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> On 19/01/2024 05:59, brianmlyles@gmail.com wrote:
> > From: Brian Lyles <brianmlyles@gmail.com>
> >
> > When `git-am` got its own `--empty` option in 7c096b8d61 (am: support
> > --empty=3D<option> to handle empty patches, 2021-12-09), `stop` was use=
d
> > instead of `ask`. `stop` is a more accurate term for describing what
> > really happens,
>
> I can see your reasoning but I think of stopping as git's way of asking
> what to do so I'm not sure if "stop" is better than "ask". I don't know
> how we ended up with two different terms - the prior art is "ask" so
> maybe we should change "am --empty" instead. Lets see what others think.

The suggestion to use 'stop' instead of 'ask' for rebase was initially
Elijah's[1], which I agreed with. I am certainly open to others'
opinions here though, and am content with whatever is decided. I am
mostly aiming for consistency between git-rebase(1), git-am(1), and
ultimately git-cherry-pick(1).

[1]: https://lore.kernel.org/git/CABPp-BGJfvBhO_zEX8nLoa8WNsjmwvtZ2qOjmYm9i=
PoZg4SwPw@mail.gmail.com/

> It would be helpful to mention the tests in the commit message - we end
> up with a mixture of "--empty=3Dask" and "--empty=3Dstop" I assume that i=
s
> by design

You are correct -- the intent being to ensure that `--ask` continues
working for as long as it is supported. I'll add this to the message in
v2.

> > and consistency is good. This commit updates
> > `git-rebase` to also use `stop`, while keeping `ask` as a deprecated
> > synonym.
>
> If we're deprecating "ask" do we want to print a warning recommending
> "stop" instead?

That makes sense -- I will include a warning for this in v2.

Thanks,
Brian Lyles
