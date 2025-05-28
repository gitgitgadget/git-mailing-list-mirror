Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D0E17BA6
	for <git@vger.kernel.org>; Wed, 28 May 2025 02:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748398521; cv=none; b=bLLliGaYR5xv7G++/Ax3aT1A6bA2ZKfZhJraUJ1iN6jUseUQFyFSC1+IrmOlj26TZ0hee6ZbTIBPhkfkl7mtJJ6lmqUvSd6uiImbGRvsN7iq6eNiXWnrzHhif1TwzSw2Kkh2i9xW7Xm6JfgQTJOvcRySELNNsGevpYpu3V6j5d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748398521; c=relaxed/simple;
	bh=LwZfv7roLZ3cc+WEEXOr+ZzNxBi9awqMvbnatZ2I+Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKsZQrnRtjuN7SW4Tz8wBa4GZ+4le/P1YMp9nqu4XNMxdlJjKDRCUPBLpBF70JNf6vKYmlBloniLZvkm1C4R1tWcDkYdjhcDmRIuA+77UcpGwgbAIhZ3u9nBoNphnAzR/DCFzXhFT5JvyY1J3i7AokZZW5MC+MhJShZXBWwhvxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xizNcxaA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xizNcxaA"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c922734cc2so48926885a.1
        for <git@vger.kernel.org>; Tue, 27 May 2025 19:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748398518; x=1749003318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LjKkeN/ZoubK33SjHDvDRblMYzi4AjrECzkBvz/P6Ck=;
        b=xizNcxaAAdnfkQwDTWCJp9LfJGvWtP6hixSITtchfbeCl/2nHbBBoRbhuo5zBa9DP/
         Gbr+27Vk7+E1nR9wvdG7IAyLD7JRicjBw0pKHjdt0qFcTvtYu6s/sIoDinQjRbO1VwP/
         aEPx9ZV7IdxNUYa0flbtCukNVB1RXlVPUjHrWWLYSLKjlb88O+OrSwkqszwDZ4K1+Q6o
         TyEYg83rC+KoGmVnBO8geH4sL5HF3Lmggfu6tAH6nV7z3xc1hqb/ux5Zh87DzsVrqw+O
         3rlLykr4xXNOtlMyUnFvKl68roNsf7CslCkL5E6Rd78nxbyoC1ZbMLwq923IEV7hmuEq
         i1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748398518; x=1749003318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjKkeN/ZoubK33SjHDvDRblMYzi4AjrECzkBvz/P6Ck=;
        b=OpDWZ2IDiMWlL6500svWrLWa+SGIyDGnBVrlOYEq7nna8l9jCMM/cvj5Cr6hTuuHaB
         9KVTImk7n1gMk3l7IFCviNkU8TGKjRQu4Pw4Wo0TcimjKa5daaF2DtgfbxWpXq0MoY6z
         L7yxGagcW1hMU4lWjlrnlIftfFS2TYr30glzgGyIrWXoaDiuj/RtabzlPbErqj81A0d/
         tshT4qg9JKYCndP6NvXz4MXRZLxxBKV9GbjJcSLvfcLcX2pLMj4Kvsk6B30LjaPhZKqD
         SBhTgh/Lvp+20Ftd0Z05tqN9H13EBhQjUDTHJ6LrR3P/eB02eQJ6ycZosA5CTmkVLyeD
         RGEg==
X-Gm-Message-State: AOJu0YyMWE7zYSbEPfsx6+EmOwd/N+AlibI526tChiwCjhsczPw/uASz
	qHCSLTzR5hLi/CFdYj96gfPC8ul1Krm3pkkuwE8i9nyWzUUt5Q01ENzetp9QKPk2mnE=
X-Gm-Gg: ASbGnct9u4rVdwPQIHNedJKG6+WWnc0NVyKHjEAK2VUT52gsKme6X7o99yhH10BiV7Q
	xzBCJ3hvt1DsgK45xVGmm6NU7DurbCKzsEEOaPhgDBScbgUzf7Uxe0BxwByFksq1IgVtQoz+vCx
	UsB6gtaOVaqw4GBU7iXQriD1NoOVOiZcygcCnQVugtewbpFdNxCqbqhjQu1/7nJ2WGOUJRGBMpA
	xkyj+E+tsr5Z5M994TB8PKmnuvqyOkqpVhKhXW7tLGYWyR4+RKeZKpRqZrI3AVBXwtfQgwSfVYE
	gAUg1G+MQAAuVGsgeczhyS6mJhqEIRB76pYlhYg3mdGTZQ42ytkip1HY9Rm6eVuObEEcIWV1V+A
	kDVdxnSCbwYLLTwdDA6LHnGg=
X-Google-Smtp-Source: AGHT+IHCbZCQmN/yB5wxJQGACNLsYFy4kx4nUslBHvRLZONBgRmAxGqs0hE0H8griCnIJw2+DhCV4g==
X-Received: by 2002:a05:620a:6842:b0:7ce:eb5c:1416 with SMTP id af79cd13be357-7cf06dadba3mr469656585a.25.1748398518169;
        Tue, 27 May 2025 19:15:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cfc5d3a3b0sm15757985a.73.2025.05.27.19.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 19:15:17 -0700 (PDT)
Date: Tue, 27 May 2025 22:15:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] midx-write.c: simplify fill_packs_from_midx()
Message-ID: <aDZxtK+I0sWNCUVl@nand.local>
References: <aDC0bK+NOuuVvQtb@nand.local>
 <cover.1748198489.git.me@ttaylorr.com>
 <5d97b706e17117217bf6e90e5cbca9e6e408c5b4.1748198489.git.me@ttaylorr.com>
 <aDQXD8EHD163Mijo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDQXD8EHD163Mijo@pks.im>

On Mon, May 26, 2025 at 09:23:59AM +0200, Patrick Steinhardt wrote:
> On Sun, May 25, 2025 at 02:41:57PM -0400, Taylor Blau wrote:
> > diff --git a/midx-write.c b/midx-write.c
> > index e4a3830d45..7802a4b694 100644
> > --- a/midx-write.c
> > +++ b/midx-write.c
> > @@ -943,6 +943,19 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
> >  {
> >  	struct multi_pack_index *m;
> >
> > +	if (preferred_pack_name) {
> > +		/*
> > +		 * If a preferred pack is specified, need to have
> > +		 * packed_git's loaded to ensure the chosen preferred
> > +		 * pack has a non-zero object count.
> > +		 *
> > +		 * Trick ourselves into thinking that we're writing a
> > +		 * reverse index in this case in order to open up the
> > +		 * pack index file.
> > +		 */
> > +		flags |= MIDX_WRITE_REV_INDEX;
> > +	}
>
> This change feels a bit weird to me. Sure, it does allow us to pull out
> the loop in the subsequent patch. But honestly, that makes this
> workaround even weirder in that we now set unrelated flags in some
> function and expect a different function to only honor it in order to
> open the packfile.
>
> Shouldn't we instead have a separate flag for the new function that
> tells it whether or not it is supposed to prepare the pack?

Yeah, I like that much better, thanks!

Thanks,
Taylor
