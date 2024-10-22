Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480C1BC9F6
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615303; cv=none; b=nJDb/VeKQEQvzlF1yUev7q7XFxIyG1RLHWmDxjZbmHU2Cqe1l29SC36klDHWrhKuKO/DptiqDSR0Q5yx6gZXgKnQFM4RNr3uMOnsuRsxgeOOrz7pLmgy9Ue35zUOeZXRDw1OEvZvEpaSO/9MdWT+cyfGBjUwrT/72AF4aA2A0qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615303; c=relaxed/simple;
	bh=h1D/QBU54HKDNTXFjLVuUF+MAuyRgsIIuV6G9ssw22I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLzGAN76m5Lt9JVZbse3sqmZ7TcLhH4TobZeKCO3S9nQg5olh+N08/IaXrf8ZXJh8VAcMzQF57rJWuD+9/JXeFR6+iDw6TAouKFnxcc7zygv8x58KI0v9ZXH24Fgb+uByk/RY06PSfpXX4f8VIWgrxvjieh/topV17HSfHmIznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hits+sPV; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hits+sPV"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e290200a560so5524969276.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729615300; x=1730220100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1D/QBU54HKDNTXFjLVuUF+MAuyRgsIIuV6G9ssw22I=;
        b=hits+sPVzm4AQDORC6r/58QPSh1To0Z1S7Fgf/sNl1XA/h1/bOfgwRJoR9AjtHtg29
         YIZxO87Y+OkGo4FzNK65wtT9n3BvlgMIFgeIsp7iF63WxBkBaOdsRn4dC5HLFb9rBtcs
         lddFsc1xj68OdE8Y7+ThBNCmvz89ermBTHAEhhvxGUL5ZquzKD2TeReacAQKZQbVuLoW
         MPWlShAFsVSliwoIPSIgTy22CgJlD+oMfxe5zSZwhIScCvSR4eaphvFiW2TJvjytjKpq
         aVozy+cQLJciPDz3hO0zWCXnXh6HetccpQp0N/3fylxa7sy68J6SASUaH/kxsFHeaRQK
         7ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729615300; x=1730220100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1D/QBU54HKDNTXFjLVuUF+MAuyRgsIIuV6G9ssw22I=;
        b=XOTUisLDwPYB0RKbXATCpn6ONyqGul5yPaxY28hTK+FrBiaZG6A81FLKeq9WTZ6THc
         pPvyZ8y0Bda0yrJFmRwCyzBjxbZjaaQ0fX0cvuH/wmUiFd7sa3Ng1Ncnv2CVLKj7GUJu
         ZyDXZDgY0WGYrO8/cEJjkEAdCHkuwhnRjjQFNkxmEjn3CGmCV4Kn3f97GtTpd/w77ysU
         UPQHMmNI/dF+5qy32EfKv+K5R2TKLpB3HwBza0THcT7F5fo54IW55LGU9/vH6SGtilWk
         Gaw7XW5B98DJINsEwvSTJrxA5EEGlI9/2gGCkigxqRZ5IOb2uVYdK9YxwaSD2KiF8Vkx
         dEnA==
X-Forwarded-Encrypted: i=1; AJvYcCUZSnLcGaT4UPdy4LCM04B1KaMMLDOe2PiQlkBh9MXNwEhdPTweVSulJHi6ZnSE7TMe98A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwXtQ+7BLOcYEK3eJD4BOBi+MOWk85dOeEVM6NTjAldWzhW6W3
	iiLfx83gzMDc/cG63WcNB2m1Tm+1SXnbpMzwLKspjgE2W6ByrnYgpCQhsBH6aZ4=
X-Google-Smtp-Source: AGHT+IGBQqenJGdg1tCP4V1Sa1x2fO4fguj6R6fRXdGsuSofHL49xPA39ncw4havX1Hvb8zF3BaE4Q==
X-Received: by 2002:a05:690c:620a:b0:6e7:e3b1:8cc7 with SMTP id 00721157ae682-6e7ef16c647mr869997b3.22.1729615299017;
        Tue, 22 Oct 2024 09:41:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb560sm11359567b3.94.2024.10.22.09.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:41:38 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:41:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: discourage arbitrary suffixes in
 function names
Message-ID: <ZxfVwQxMlcJbGt5D@nand.local>
References: <20241021124145.636561-1-karthik.188@gmail.com>
 <ZxZP01C-9RngukZy@pks.im>
 <ZxazVG65+W0qKLXh@nand.local>
 <CAOLa=ZSPmkdngn3=cksBM-syO94-zYANLk8FWBsQYpTR8XT9FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSPmkdngn3=cksBM-syO94-zYANLk8FWBsQYpTR8XT9FA@mail.gmail.com>

On Tue, Oct 22, 2024 at 03:45:38AM -0500, karthik nayak wrote:
> >> So, that being said, I agree that we shouldn't use arbitrary suffixes,
> >> as these are quite hard to understand indeed and typically don't really
> >> provide any context. So as long as we interpret this rule leniently I'm
> >> happy with it.
> >
> > I am not sure here... I think that using a "_1()" suffix means that the
> > function is processing one of a number of elements that all need to be
> > handled similarly, but where both the processing of an individual
> > element, and the handling of a group of elements are both complicated
> > enough to be placed in their own function.
>
> The crux here is that this meaning is internalized by people who know
> the code through in and out. But for anyone new to the project, this is
> not evident from the naming.

Right. I think that with that in mind, a good goal might be to document
that convention to make sure that newcomers to the project can easily
interpret what foo() and foo_1() mean. Another approach is the one you
pursue here, which is to change the existing convention in the name of
making the code more approachable for newcomers.

Both approaches meet the same end, but the former does not involve
changing existing conventions, but instead documenting them. That seems
like a more reasonable path to me.

> > It's also a helpful convention when you have a recursive function that
> > does some setup during its initial call, but subsequent layers of
> > recursion don't need or want to repeat that setup.
> >
>
> I get the usecase of having such functions. I totally see the need, it's
> mostly the naming that I'm trying to change.
>
> Let's consider two of such functions:
>
> 1. mark_remote_island_1: This function is called to do _some_ work on a
> single remote island when iterating over a list.
> 2. find_longest_prefixes_1: This is a recursive function which is used
> to find the longest prefix.
>
> If you notice, both use the "_1" suffix and do different things (operate
> on a single instance from a list vs provide recursive behavior). So the
> user has to read the code to understand, which makes the "_1" a bit
> confusing.
>
> Second, this could have instead been named:
> 1. mark_single_remote_island: Which reads better, giving the idea that
> we are really working on a single remote island. Whereas having a "_1"
> doesn't easily imply the same.
> 2. find_longest_prefixes_recursively: Which also reads better, and gives
> a hint on how the function operates and why it is split out from the
> base function.

I don't disagree that writing "single" or "recursively" can be
considered clearer. I think that the convention to suffix such functions
with "_1()" is more terse, but saves characters and can avoid awkward
line wrapping.

Thanks,
Taylor
