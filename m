Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275C329E79
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377389; cv=none; b=kmjFo0OI1y3jplbm32vciV/evuJPn7yHEcWd2bDVTPWXr3pAfSvZS4IskHYOIi4IdvqSg6CcDonYTiDGQanbfk8PhJnV9GQBLCfdtZ5DkQDZIQc8LvoBYSsQPm63IG2jnRKfDFCZDYsfG/fDvXJVXJHVKTeHZFlHw0OSB8GeuSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377389; c=relaxed/simple;
	bh=69QQZCBq5QG1OooM6RauGNbSxEFXJjehvgBqR0tC3kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCf9DLJq9vPVp3igDS2ytJTndgMB5PTAz2eXqH1ko6nNoukCUY+CBuA78DOFOkuI8zkYKTQ5V7Bx4RMIEOhapvmOmYSi09AOdOcFc0WzOzNmmZzFT/oXMe0/PZmnGXADkdzcmk7so2Az/OR0DVmSg3+5QrEfMID/RfJ/DbiSFCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=dFgVO5oW; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="dFgVO5oW"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81e69a2db34so33741787b3.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1786377387; x=1786982187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=69QQZCBq5QG1OooM6RauGNbSxEFXJjehvgBqR0tC3kE=;
        b=dFgVO5oWTIW1HHXS1fpMecgclI7Z+oITtnvCLT1/b2adxqKgDCK85HMVwYa53m/erD
         jEj/1AaWNz+X2GBUxbY04JRGV6PHm6RzpJAFYEDvr+Y3oZTHXU2beZ1T1vMEaXDZu1FQ
         wOneLjn/Ug77B+M/GyDqYNxzWEqZY6X4UNX4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786377387; x=1786982187;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=69QQZCBq5QG1OooM6RauGNbSxEFXJjehvgBqR0tC3kE=;
        b=nNTNEsarvAmRFSCKy5eG3+gFG2OmutDiLCYEoXauaT5aiNjmGBU/3f6wgDQQPgv8xh
         l5P5ss4+p7SgJFlGmPRNSqP2KKspdNF+kOo0GIhAE91l2eHp0+KiWrM/ER2iIrDuUoji
         cEqVdVI8rlKU/NQ6rs9Hhm3i3QlAFVaqxHerv3eMRV6egdZhlOct5TvtuIrZgA44l8yS
         lqA1iZtSebNoecSxIOQN6kVKfwrDoIG8HxVKt6n/Lz7C0bqF0hjo30SEvlI74m5OC75j
         iSvFY92+ybpjI/WBDItJQd56u0Ceaf5dTWw7SNrGicPYj2kfTTi1rTgm2B73i9kG8ae8
         rYew==
X-Gm-Message-State: AOJu0YywZ4mYh0vnQ93tpimax0vMfC8t6FjJmk8tjEaThumUUa1Be9zz
	7DUdMFYLP5cSDd6gTHq2O8D9fLQ3ymo4QmtcactDqANEpjEgPOOkbJlJrIP3EcgOE+Q=
X-Gm-Gg: AR+sD127IZWBpMOSLTGaJio+6uqRECmNHDHLn+ZiYhx92RZqx+KWvKmT6qEKedh2EZX
	8hHmS0cyFkoBVfrbE/NPp68nlJF1LYJuhw7cy0Px0ppW4u/21iU9xZiTeJcIRQM0vhxA6hDa+ie
	LG1xvQWFfWx3dIE1b27/HwSUoBWL2AMuKl4FCV0kzs8DfPDObFqQT6Sn1IMPaWA1wWTcrTqrWQH
	taVg2/dvWad/gnGxMJLhmEq2+X6Xtbbxo+91dEycjOPrAUbxA1Qezawti3P21W2DDgu2L02ILMI
	Kgkp9NL6TrV8/ZhdLxkVnRvggHwXDXpZMgophNBDxQXVtIlIwEo6dHsE8qi+x02GSa4mbc9I2gl
	tdvxISBVVIDR9R96GW1JH2brWVDr0aNRYgl41iUExI99dOfirnJsmFaoXyRqru4YcjX7FurB3bC
	aYssUgmqIlHohDVQCDf5SQBrGyi3nCUupwb13W7VdahS2kw86fwoT7rVTljnik7JSw5NAdkofR+
	ue34ZJb/XyNXlCRDF4GIMGDHdfedJJz6Xt25maUKKX7golY7BDz/BFDrQJCv1leuM5k
X-Received: by 2002:a05:690c:9986:b0:81e:9b09:7210 with SMTP id 00721157ae682-82573f2f23bmr141596287b3.16.1786377386679;
        Mon, 10 Aug 2026 08:56:26 -0700 (PDT)
Received: from com-79390 ([20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f623ae94sm57482547b3.35.2026.08.10.08.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:56:26 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:56:14 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Ted Nyman <tnyman@openai.com>
Subject: Re: [PATCH 1/2] maintenance: account for promisor pack geometry
Message-ID: <ann0nnSGfSJ7y7YK@com-79390>
References: <cover.1785902237.git.ttaylorr@openai.com>
 <a9de123b43efb58c53c99c71eb7e34f29e075071.1785902237.git.ttaylorr@openai.com>
 <annqJGFJPviEyfEC@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <annqJGFJPviEyfEC@pks.im>

On Mon, Aug 10, 2026 at 05:11:32PM +0200, Patrick Steinhardt wrote:
> > Check both progressions before choosing the repack mode. If either
> > leaves a pack above its split, geometric repack still avoids rewriting
> > that pack, whereas the all-into-one fallback would rewrite it. Use the
> > fallback only when neither progression leaves a pack behind. That
> > preserves the reason for the fallback: let the all-into-one repack
> > handle unreachable objects when it is not rewriting more packs than the
> > geometric repack.
>
> Okay. The consequence of the status quo could be that we perform an
> all-into-one repack more frequent than really desired because the set of
> non-promised packs is small, and thus even writing a small set of new
> objects could cause a full repack.

Right. I stumbled on this after a few colleagues had reported that their
geometric maintenance task didn't seem to be doing anything. When
looking into it, I found that they had many promisor packs, but the
non-promisor packs were already in a geometric progression, and thus we
did an all-into-one repack.

> This might create the reverse situation though, where we don't perform
> the all-into-one repack at all anymore. We could come up with a clever
> solution here, like for example considering both sequences together and
> repacking when we cross a certain combined threshold. But I'm not sure
> it's worth it for now, and we can still evolve the strategy as needed.

The change in this patch means that we will perform a geometric repack
when doing so would result in a new geometrically-repacked series of
promisor packs, in addition to non-promisor ones.

Is your concern that the non-promisor packs might be in a state where we
should compact them into a single pack, but that the sequence of
promisor packs would prevent us from doing so? In that case, we will
perform a geometric repack on both sets of packs independently. If the
non-promisor packs should be rolled up into a single pack (i.e.,
"geometry.split == geometry.pack_nr"), then the geometric repack *will*
produce a single pack, as if we had performed an all-into-one repack on
the set of non-promisor packs.

So I am not sure that I understand your concern here, but please let me
know if I am missing some aspect of it.

Thanks,
Taylor
