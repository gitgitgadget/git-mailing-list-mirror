Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8BB8C1F
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334489; cv=none; b=gF/uKwnvcHA8Y5JY7XtX77T6unwfP5oEb2m4lQ4/QyTsRYhBeoiAJHuwaSAzyYvYQtdZWXvnjoxI7rSvX4hpOCDfiWe3yR7XLH1H1oKTL1bM9aofE4nTVYopPFfGU8lExPInQ43ThXjsDglaOT4LJX8I4ISwCpM/jQoxFV1eqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334489; c=relaxed/simple;
	bh=MrptJzReRr+/7+ENpXdaw0pJhPMRVKuAX3VqRMF3SXM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaVwdyFIJwmDrq2TDqLMJte6Rnyc3ETwdcvqMK/2hFrRSHWJk7iRglqA1xh4LXFKePThdf50EvvM2loM66OfhpVOm3Su0PO4dLz83I1Lv0NQ2J1IrK7T29t6LfQyx9NCWVHGsYTzlib5N+Xjq7lUR3owhbk2kvht8a/wefcpFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=cERs8oWn; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="cERs8oWn"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d60504bf8so348377b3.2
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759334487; x=1759939287; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TdmFgkj37vYiAF96pJlg96AWfBIfgW7Z+N6dJJydaQ=;
        b=cERs8oWnCJPXCi8D+QdD81rQ8b9MFbzyZk6uhBWTC4At80vxp9G4VVa2dxF07Ns7qB
         LQEarLcTWIFoGC3Tg63NhASsUTDCQPuw7cHF9haISWMhPmK7KZ7xIN2zuL4o8Fzuxids
         wsZE/c/9nysW9OvBywGDcuqHWP5vpIkDEuouGBSbZNi42Eu9SBESwndU1M52KgKZ55PK
         /1N0Un4TS9J+Ht4RoFl4MeohJoSM+NKBBYbb0fojxTNjloJaefsUMlZkGaYQLNMVCHxP
         IEBimNyv9uApsLfpAWtPx0/S3sPuOho0dRlOAJGYlHFuswTiFDsYcYTdkC3HCvNWAqzv
         2ARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334487; x=1759939287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TdmFgkj37vYiAF96pJlg96AWfBIfgW7Z+N6dJJydaQ=;
        b=iO5ZP85rSDGtChFj/rzc9f6Rh5sclIcAmXc4bTXxut+0SrQjEekCF601m/d4ZN5qmu
         XFb5nHm4kSl/iPfLYDs2CYrdNy/kGJPJSRD1W7yg0CZzm0UeZD7DFiFXadeVcn+fGZkw
         Ocop3MaDBK3iI4gnKbfGdxA87022+X59HRNY0euS5LLVIIWrRLnXi8/EhL/MLQ1ckZ3R
         QycjwrzhunmmVknOq84Zmr7QgVKJd9p7Gj0ETao/PYyRvE86aJscVWO3PQszKQJiU+4R
         IgVlWTNG7np/LmBRVV7GwVglLC/YHyw4QrKRkXnn13El2BJyanLQlwkT1/IMG63q6Ylz
         aaug==
X-Forwarded-Encrypted: i=1; AJvYcCVTMQ9FGspnEhP4qAZJv8p0/3cLvtW/4yiW3bWBnUhFSnSo3SJ+XTmIr9F+jqYzOxWJeH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziXRsU+plTmB+oXGbvbrpJRQj80NRFgorS/jaUvqdXvmtChU3j
	aC3hYL6y8mAuQtZYQc8RqCiMw9vKKmBen/aPK6YjD6uupd+O4UvUVqyHXTK13/HEp+wAdvxPCg3
	WVzuyntuwcw==
X-Gm-Gg: ASbGncskrNH7uP+7c6DOFQ7C5Da3axpxUyIPwVYdB6CUIEpxt7p0YdaVk51shAL6DpQ
	oImYFemXQmlFd1b/GIu3jK0CXkORNPuDmwG5tbLE/bqmJ53jIQWpkLEXALD2AC4zplyg+jjAXHJ
	p4R6URphKHlgzFLeaFoyQ917JW8yDoyUGRIxT0EgeL7rfNJeOftnh/w1QKI4M9jsLlxTZu2fEhX
	J3Syncu8rYVJOxozAgwXgqJWu/IrD17J4z0KLJN9H19x1WMj/SeYQ9CUXPSCSgUQSphp8ODAluz
	ztB39ObSD8txyYKt/syjK/6rKkSveZPkXkxE2CLafLlosL2bQ3So67g2JuEjLcireicKBlzo2lH
	rznZt8AThij55Pb8XWwSWiEKmjkLJ55Qs9SZV3xgJjY/wzS9Z5iTed5moapHsPY5X8Odd8GiJXK
	ThiGgHf8j7QEKJYdHCjL+6MPmwy+nAk/BrxKTreFsfqStRsPEl5w==
X-Google-Smtp-Source: AGHT+IG1XQRBBnwt0B5FuaQMYFnU4xkUuu5Vp1WcNpONMuUhCFEyMu17phoO6Tiwebl5v3iqjpJF2Q==
X-Received: by 2002:a53:be02:0:b0:633:4a1d:f9d6 with SMTP id 956f58d0204a3-63b6ff22237mr4123533d50.25.1759334486502;
        Wed, 01 Oct 2025 09:01:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63b7c1577f0sm415650d50.9.2025.10.01.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 09:01:26 -0700 (PDT)
Date: Wed, 1 Oct 2025 12:01:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aN1QUDzYli0GsGy9@nand.local>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>

On Tue, Sep 30, 2025 at 11:07:42PM +0000, brian m. carlson wrote:
> Almost all of the functionality that we had wanted in Git 3.0 has been
> implemented.  The two major things we may want to consider as blockers
> for Git 3.0 are the following:
>
> * The SHA-256 interoperability work is not done yet.  My estimate of
>   this work is 200–400 patches, of which about 100 are done.  If the
>   original schedule is maintained, this would require writing up to 75
>   patches and sending in 100 patches per cycle, which is unrealistic
>   without additional contributors.

I need to polish up the notes from the Contributor's Summit and share
them with the list, but my general feeling at the end of the discussion
on the SHA-256 interoperability work was that it wasn't clear whether or
not it should be a blocker for Git 3.0.

If post-3.0 repositories are using SHA-256, then either their post-Git
3.0 clients will also use SHA-256, or the pre-3.0 clients (without
interop support) will be unable to interact with them. I don't think
there would be any reason to have a interop-capable client use a SHA-256
repository in SHA-1 mode.

On the other side of the coin, if a repository is still using SHA-1,
then both pre-3.0 and post-3.0 clients will be able to interact with it
without interop support.

But you have thought about the interop work far more than I (or anybody
else) has, so I am very likely missing some obvious use-case here.

> * Some forges and other projects do not yet have full SHA-256 support.
>   It's my understanding that all of the major forges are undertaking or
>   have undertaken this work and are at various levels of completion, but
>   it's not clear that other projects have appropriate support.
>
> We may also wish to stick to a stricter timeframe for this release
> regardless and make four releases from now or the next release a year
> away Git 3.0 regardless of whether those items above are completed.
>
> Discussions at the Contributor Summit did mention the advantage of
> having a hard deadline would be that it would make projects and forges
> spend the time to implement SHA-256 support if they're lacking it.

My feeling on this portion of the discussion was that we should take
into account the readiness of the ecosystem as a whole in deciding when
to release Git 3.0.

I agree that not having a deadline can lead to forges delaying the work
necessary to support SHA-256 repositories, so I agree that we shouldn't
push it off into the future indefinitely.

On the other side of the coin, I don't think we should rush Git 3.0 out
the door before the ecosystem is broadly ready for it. If we do that,
we're creating a worse experience for a significant portion of Git users
that use popular forges who may not have complete SHA-256 support at the
time of the release.

Thanks,
Taylor
