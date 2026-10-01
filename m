Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE633B6F4
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 03:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790825744; cv=none; b=L6daXVbu6reHb3nnAzQrq+bVdoJ2m+Rey4xDu+m1SMANEWnON8uxXNFw8AmZobFpJtqeGK82idDpKbIdv5ThUyeesrj1VLPyo5e/jQkEVc2x3oM7G4isIBsMF0DTW1nQ2rLSKCHmHot+j0HgIgnyjrPJF0VkLU4tVUaF6TtKvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790825744; c=relaxed/simple;
	bh=oHWKcuLbh7xXhmZWprn6lpqFiI5+6JWMLJUwVZpwWXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aI/cJw8ISsiK4yopYl0bYHgY6IgLvt/R9WnROL8gqjizdGmtc3/JbqsgS4xSGfExkLvXeMi3Pr8m1pArJS6103utyO/uwj9/JipEMJ3LGfLcI3BFYhqYJduxqq8tTAH6Ud5q51gFqgZ76e1ouI9BnB01T5QXpvwDY2VQd8PcCmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=QdWyyGNJ; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="QdWyyGNJ"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4e4a4d77e5bso245637b6e.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790825739; x=1791430539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xe22zidW9aXjBITtqmZAXg0OWP41dhDo/GCtWRaUPNE=;
        b=QdWyyGNJZbG//P5Y8XKgw0vXz4hZ9JONdmHVdTzmPuI7u7P10ayQEfpEr8s4r5EJ4S
         +KHfkM0sRsDP9PuV7MKa7fitjDEa+L1S5Uu1hwmr2QCeKvdF7fZ/MlIf/7alr8qrKr7x
         LjZCXl4EILdol/aMxcjJDX+16NaSfF3Pj15Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790825739; x=1791430539;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xe22zidW9aXjBITtqmZAXg0OWP41dhDo/GCtWRaUPNE=;
        b=E7O4SqcMWHIlAlFPe4adoiOwjEsL3nhoxTs60EFi8fALh/6IMUUYGQUz9YNZzd3/cZ
         V+SJU1aGvStV53Zho0lbiCjee7OLf0ltE/N2MXZxQENgj6LxXFpPoyKEzmQNBrp7MJyL
         kMu7voft3BTFMg/1GwUlODIZgGbVgf3kXQlbHzx21aDUbHN09O1JNFxbtA8uYpTqGuZA
         dB0VanmNUZQy/X4uUWxUmJvpDDRXY2ttvWQg5v0z7zCf2l8+XOmxQktXdR3Vmzv3PFVH
         BVFjQC2UgMwFMg3Efs4T6g3ivs86smNbOdBF9whnkRaXJ8bCyQMv5psWbamEmFMEbcVo
         6HWg==
X-Gm-Message-State: AFuF++kTpkuhEYhufLMpxSN7/erMlezav8Os24Z4qkR8y2nkI7UbMCMT
	GdQOIiK3XcC1ffGPgU2GijgeGDXGyO/x6TbO0bhDUo100V6RR4JZvYJCDAvubi+K59E=
X-Gm-Gg: AYBFou2n2YcLeWPLBj7ImIoCfD6Mp8Jtllf4uRc1setdFIHa+c6hnPvBgnEDneKhdgU
	xmskNOBYGyUzf9W+cZK/b4YFznBJ0DaDwlb9YPTkDDSzjhDNeAjVNeADNK3DXvcIKeF5ezGXmLV
	gwBkvptU0/iBXdGXNFMmsd7QkQ4XmTh5ft2UJeKKGc7krJAAE/Dofv3R1MoHaOshjg0MEiIgk3M
	0+zQa+7iqmWQfb6hKeMPwS6JSJyuB+uONXcStMY00m6RSFxojfJ7QGIwqhlkLNbT223CVPkp3Pk
	EyQmbrEAHfmgp2GiDsVoEnYhJn8GZKTiicV8lr/byKMt4DERHKfszRbFMNuuV/7bUvH/oG3H5WJ
	+CNmTflYOD8NHWrGHp5OwMB4h1Xrj7W0y05dI0L0nt2fKmwL7m9jDR4vXoea1Gph8r7h/KYMohI
	BHyAdZ8x1hgxrkpN1iwFDR/xYmc0msWR1gYUanwRJMocPegzeJvKw26zF6Xc2BDAn7kvKXnUDoK
	dVYD9gB969/qCo5dWjsKAV89mmKmc4M8btqKuQv/5xEAKHgime7KJcVc5bSHKfHiDgx+bi7ZfFn
	Y61VAV71cGMIIw==
X-Received: by 2002:a05:6808:448c:b0:4b2:8e26:bdd2 with SMTP id 5614622812f47-4f3080f4b4amr1870911b6e.16.1790825739231;
        Wed, 30 Sep 2026 20:35:39 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f34ab03804sm1459803b6e.7.2026.09.30.20.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:35:38 -0700 (PDT)
Date: Wed, 30 Sep 2026 22:35:35 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH 4/4] repack: retain cruft packs in MIDXs containing kept
 packs
Message-ID: <ar3VB-bYA2kbVWyR@com-79390>
References: <cover.1790731662.git.me@ttaylorr.com>
 <e942c256334e4de31ec0a1cb2d5f8c7465d8696f.1790731662.git.me@ttaylorr.com>
 <20260930205311.GC747209@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930205311.GC747209@coredump.intra.peff.net>

On Wed, Sep 30, 2026 at 04:53:11PM -0400, Jeff King wrote:
> OK. This makes sense to me, but two questions:
>
>   1. Is this going to kick in racily because of the .keep that we
>      temporarily install during pushes? That could cause unexpected
>      performance changes in a big repo when the midx sometimes has to
>      randomly include cruft packs.

Excellent point. If we happen to race between repacking and receiving an
incoming push, it is certainly not the case that we should have to then
thrust the cruft pack onto the MIDX, and defeat the whole point of this
series ;-).

>   2. I'd have thought that the solution would be to treat .keep packs
>      like other included follow-packs: traverse them in the usual way.
>      But maybe there are good reasons we didn't do that in the first
>      place.

Yeah, I think that's right. The following round passes excluded kept
packs into the geometric repack's traversal using '!' for packs outside
the existing MIDX and '^' for those already covered by it. That lets us
copy their ancestors out of cruft without copying the kept objects
themselves. Non-geometric repacks still conservatively retain cruft,
since kept objects may remain untraversed.

There is, however, a pre-existing corner case with --pack-kept-objects
and a cruft pack that is also kept. Such a pack can enter the MIDX
without being traversed. This change doesn't address that case. Handling
it cleanly looks more involved, so I'd leave it for a separate
follow-up.

Thanks,
Taylor
