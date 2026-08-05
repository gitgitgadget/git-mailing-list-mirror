Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A41B6D08
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890635; cv=none; b=eDEx33rcC4Wu9g6pVuFr3EF8xBS/TLt+lPTW/ei81CTscuACaFFc5tFkIPYD0Pi0FxmorH2pz4zG9W6bl6pzzBbhIMfrNxeobJ6GoYqB1AV10lf4bZgyWRy84CmjGOaeu5cHVcnUbs2+5htHniQoOS+laYZRZh4gfHGcOjXi72Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890635; c=relaxed/simple;
	bh=dbaUMzcP2Fsgc/ppLUBNKKY9tFclenlzSx6nflWF+2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8TX6qtZtVL28ZkQRRlBdxyibTBFc4Yx/saMdHyxDlusBcb32vSPcx5DolwUJwOJl00LGG1lDs8S7tEE7h7+b5vAAcj4bknruer+WgSsPofKabVCLI5JpA6M0roI50qTRmisvTG6MpRFWyUpFiEXwhH2hNIpDPWsejzEpeKq52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=AYYjnZTh; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="AYYjnZTh"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-930f72317a6so27890285a.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 17:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785890633; x=1786495433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tkd5gCqoqVta9SswoYmm1ezGGFaqldUDH052ihlIL7E=;
        b=AYYjnZThGn6mVdi0WdUNDGtOGV2cB/VMpRO3hCifWC5P3b7eEmN91yYqnwCVnACuaq
         oY2GhFBYHS2YFvL/YHLAugQhjLJ12xR94k5/dkOdgxaT4Irh5sS+Cd3pEW4Op4h3RsPR
         MmMQVcksVxXoqHykeaZ5KIxDvs5ElHtB8aBfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785890633; x=1786495433;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tkd5gCqoqVta9SswoYmm1ezGGFaqldUDH052ihlIL7E=;
        b=oj1OHnBmPUP3rkuZ0Y5nJvba40+vHg63q2ULSSNNsqeo9Af4H9qv8t8ZkmXz02sM9d
         wb7LN/2ILmn7wVqM+1WKFtFEdSgc4g/nBXowHMJ98fWO2Gu8+tRGdIo1FOQ/n97qsQqq
         fezoIS9pd64HHZ4CruF4jcR7KJL0b5CMKL4c+NpwZzLhtMeMWzyaiazjz9ATWCS7AnRa
         wDY6R87m+4U4/j1I4q7+ezKQ8jhPjbqi7suTRF0FK4hcexFigGm9FrKSnlyROqQBfZUz
         s60YTT8wr1qflQdj1dkFTCXDHFbbBTS0yuyuR2+Ueka4BsiDMvk/uwG6+Sk2OuhCJAzx
         qlxg==
X-Forwarded-Encrypted: i=1; AHgh+Rq09JniasyMhUTcFFKGo3nnrhbzxZv7E+MMOEllJHEDDelfuwj1ztPBZyYQ5qB3FwXzdJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJQHs287xwS0nfs+E5L3tC/lWrROn9QBSOZev6Zt9/9R5Dq1Vg
	DxJ9eIFrXDikotiLwYn+iNuFbgQJWFLog1z3BJAzo74gKCwRufwFDWoA635VEvF9yWE=
X-Gm-Gg: AR+sD13/yy60kBKdWeNM6/1Yf6RpJwnjjz5HnXUR78vyCAws8LwKTfYYSmmfIw4b5tN
	wDgArQct9BDBPmZ5PbZg0pw8yLZCFVZJOS6ua80RduajPFJ3nYjNlOQfd8LF45QrY3QceNY40RB
	YTRIHRnHX2mpODgiRcJkrEUtq9oc9VfKOxWvkgPDmhIw5CzQWUFJSro9aCHR4UnPn/VoN21lADg
	+2oEQa4P8ujSuEiaqm9qXuMsGjlNhGIN0COH8uTmhOEx5Ash1gtosBUnc+0hn3ygxy7D/VLrbwx
	fqG+bRePqoZ00FAfH08kXwRK1jm/6SXtFUlSKp6ckEaeItOB9Vg62R/GVHrS0hjpBfk4z9/mdrF
	JX2jDhbOVZAcBFzdTXaSaWGpX48I+jEn8FpU8ol3iYFazq2kE0+V1UsuoIO2AH1MpI0Bah7fPGI
	Fb8/5UWuB4XyA1u5MBqbPqqiJV4ONQhjC8SINq4MYEKz4hUu3kD/JEIRm0xWtPPt6j1xN1FeQo6
	ALY5SvPwgh+8Xv4pwVT+y5rMwXCOHF/u8AaYSsSg283/Ur4jiffNIo=
X-Received: by 2002:a05:620a:4387:b0:92e:e299:dfdc with SMTP id af79cd13be357-93649181774mr265740885a.21.1785890632632;
        Tue, 04 Aug 2026 17:43:52 -0700 (PDT)
Received: from com-79390 ([199.47.143.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a3fc84esm50825185a.9.2026.08.04.17.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 17:43:52 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:43:43 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Gusted <gusted@codeberg.org>
Subject: Re: [PATCH 4/4] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
Message-ID: <anKHP7G1uE78e2x0@com-79390>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
 <20260717-toon-speed-up-last-modified-v1-4-410418f18614@iotcl.com>
 <87a4rp1l65.fsf@emacs.iotcl.com>
 <20260718081407.GC22588@coredump.intra.peff.net>
 <xmqqzez1sf3m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzez1sf3m.fsf@gitster.g>

On Tue, Aug 04, 2026 at 03:19:57PM -0700, Junio C Hamano wrote:
> So what happened to this discussion?  Are we happy with the set of
> patches in v1 after all, or are we still thinking it over?

I don't have a strong sense of this particular discussion, since this
sub-thread involves only Peff and Toon. But in general, I think that my
comment[1] here needs to be resolved before we start merging this down.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/alq1Q55ezuN9ZI9j@com-79390/
