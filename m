Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B23EEAE5
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790825833; cv=none; b=VA//qcYx5zbts+MOJCK/MHjQ5s4sQ0+MHcSZLiJjikCSlUWLR8Lt6TiQzbGfGXovCSUuFoClzU5OYxTxiK7pKFwvTHAfbKb5evjjogMo0ZTTXh9iwJ7P3kLFAm6bVhXeb4wvobKDj5S9oJtf3wYXAXL36jG2wq+AuY9JqHmb/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790825833; c=relaxed/simple;
	bh=pfX97vluYaWZ7iDgyXmNO2hzYoqaNo3Y9g+nheoQdW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjqvUV4WKg0nyg8vwGK0oL7S5VCPb3wHN5PndhpXU/nPpN1zlo/RdgoHjHad5i5rIqwsOzWWZzdxz4+iF9dkNc4cyWftNQd/WG2DfNctpamQy+LvaDKPTF2Syj1Wvf3L8G3XMfWj8sBF2NM1R2VVa5CyUy2S5q8bJ93VsmmhKug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=dJ1pReLD; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="dJ1pReLD"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b37951827so2244453a34.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790825825; x=1791430625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pfX97vluYaWZ7iDgyXmNO2hzYoqaNo3Y9g+nheoQdW8=;
        b=dJ1pReLDKsqgoQErri07wVik4E0zBTMmJpYrTk1ECOQb30tJyaDbhAlATvSufzhPp3
         qrs7UqaJ06ysRyYnv0SR9uL6gqkaignYK0bEXlSYw5ZvMqe+cgEeeCs8OfLgon5mMMLh
         JPwNWVZhAIKNlYKeUkmZ8p8wGrOyEQktUQKqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790825825; x=1791430625;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfX97vluYaWZ7iDgyXmNO2hzYoqaNo3Y9g+nheoQdW8=;
        b=Wx1mxlwiKjviX9MzJA3ZhbFK5hed3OPtRQA+Uc2yBJqFAf1Zttu62TEsKUkI2kfqkr
         d8INdAC8cJJXcuvX13l3SbVNiQheZA0KJdLKOXNGy3eT7ZiV73V4o6vTDVHsdo7ohk51
         wBnv6nutCx3pM9EUT4ztHlTsYm03L5WxmMVzCt+/TudqXW0iHMQQfu/MlL3p+cS2JsXh
         JRzi+7bx0rvNYjyEup/wpwO0iaXlRu8/fTe7Z1gboVzqN1XPI4s4JLdf1vtHVdK80F0o
         daVDj1SOuiviOFuF4i85YEXxKI6VPz1z/x6vOKCWvXpnBiDi0ZzI2Qn/nSA94WJj8LFb
         iaKA==
X-Gm-Message-State: AFuF++nl1Q6IyCbZq4kLMt0oTDn9JV6peSAGfv8HQykP5/0JMQNqc4jV
	BFNS0A43BFSxmie3qrisweWHZpcHOmBKV5HCUgqRHa9uApIkdA9j7xOZof4CNzjFQjM=
X-Gm-Gg: AYBFou3PJTtd8KxJuFDVICYWQqDXhFzcv/e7jwmm1/D5/nKjjl4b276WMdt5BdmWIvM
	MCcUz3jRkrmh8sByz2wURMt0pYjm8PkWT8TOJLFCgmlnfsYGdsic5aXyXrVwY81J6PEcS2HUtut
	IlZZ2Fo4375TmTIENXvNxklGH/IY3YZjWqK/gLd6fVe3rXUqxjh/GpLX5+pCk1h2XxhGHnbBFOr
	aqj+s8VRIQ2ryRIf5cFNno94dFVy3n32Gd61ozagaCnay2GRmBOb7jOvQF4vN1wdmPpxQU9NO1C
	uQX644xHmAjzeHo2aZdKrJiH13BL88YqB0LPsq3QNpMkLxuKoqZxSacNfeeYRNmsTe3VABz6irV
	YaQYURtu8cfuCVFqGIJUmpO6+2FSRwC/SKd8X/BpIz+81oe7Roia1H/CieFh2wOKBgUq4Pw5Pfk
	sehaOQNCUY//gYmZEmfb7fHqXsVKM6+QhSHL+7TDqgtogMe1koQZt3HnXpzK5ybMdYi8iQ7YK4t
	A8r5YFhSyPhK1UqvNCpmTVnUM21FKboUbKSc+8e5gXqSYxNHdl0UYc9FDt+c766h/GFd5y0IaD2
	3ULeE7onH3M0KQ==
X-Received: by 2002:a05:6830:210a:b0:7f4:d1aa:2f32 with SMTP id 46e09a7af769-8204c620e87mr4384140a34.11.1790825825067;
        Wed, 30 Sep 2026 20:37:05 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212a4138easm1801365a34.5.2026.09.30.20.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:37:04 -0700 (PDT)
Date: Wed, 30 Sep 2026 22:37:01 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH 0/4] repack: various corner cases for cruft-less MIDXs
Message-ID: <ar3VXavSoKS3xaiT@com-79390>
References: <cover.1790731662.git.me@ttaylorr.com>
 <20260930205535.GD747209@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930205535.GD747209@coredump.intra.peff.net>

On Wed, Sep 30, 2026 at 04:55:35PM -0400, Jeff King wrote:
> On Tue, Sep 29, 2026 at 08:28:34PM -0500, Taylor Blau wrote:
>
> > This patch series fixes a few bugs I spotted while investigating the
> > cruft-less MIDX feature.
> >
> > The bugs addressed are found in various corner cases, and, when
> > triggered, may result in a MIDX being written whose objects are not
> > closed under reachability. When this happens while the caller is trying
> > to write reachability bitmaps, bitmap generation may fail if one or more
> > selected commits are descendants of the open portion of the MIDX.
>
> I think all of these are making things strictly better, but I did find a
> few spots where the fixes might be incomplete. I'm not sure if that
> argues for a re-roll or for punting those to future work. ;)

Thanks for the review. Like I wrote in my response to your review,
leaving it half-fixed felt dishonest, so fixes are included in the
subsequent round, though they do make the series a little longer.

There is a separate, pre-existing bug that I would like to fix outside
of this series, but only because it (a) is independent of this series,
and (b) I estimate that the fix is considerably more complex.

> I agree with Stolee that an oidset is perhaps a better data structure
> for storing the extra roots (which are in a kind-of random order anyway,
> since we're pulling them in pack order from various packs). But it also
> probably doesn't make that big a difference in practice (we'll skip
> duplicates during the traversal, and you probably don't have that many
> duplicate objects in a repo in the first place).

Yup.


Thanks,
Taylor
