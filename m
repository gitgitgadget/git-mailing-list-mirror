Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC48426431
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225936; cv=none; b=ZIvORU9njpaXV4E4a0hfBE+mnZ09zunz9vFHyt+2g4UVr8tHPWnGaq48v6SxyKEwsxOEr11TcIFKtvgp6SgcI4VuDUZSR/qydfTCMGpDdyP/wret1OGa8Y8mJq3KazpbYd44iqsEEDmAV0yNEprhvqcHA3/bQrc9QCsrgjHWLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225936; c=relaxed/simple;
	bh=onLbNAewXwBFTnKXykKj+8DD8SZw4MgmtkDih/OsF7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGtPRqlqPEMesiQdxQfG1aiO54UKMBY5TF679pJ38Nd7UCFsZikPv8jL7TdupfkzM01a7qtYUxr+GV7hbibJgWL22hcDmfM990/iC+SjBi9dM/WE1UE5KPpcy3iROiRgqwzC2aXrcORt4hOlur2SOoLddA9l0VNvwxlxQkX5YbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HYnboI1t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FWl8KBy7; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HYnboI1t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FWl8KBy7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 01AE2EC01AE;
	Thu, 20 Aug 2026 07:38:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 20 Aug 2026 07:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787225933; x=1787312333; bh=P/VNLrGIyQ
	nwQDf05/2oiNFEdhdXr+OedCTLc9zSyiE=; b=HYnboI1tQLIBZvp6C44fFbGKlw
	+ovaj08M3rADMay5zbYR+WkphHwf77nkMTdlGtIdmd0l0GCg8NCp7wNVvRQoK9k7
	YwZMG2ZSTL6UUqOibTNn+9kq9DRhSbiQomPK4jhFvi/X4rI56BHEDcqc1iz/jtj1
	j5L8rUxPVy1nWBVo+keQbrq5/ivAweEIJL+HfQ+S0c3aFvMXlRumAWBnGp+8fae/
	DnJQ5o8LNgfkTqBTU+MELiX5c0K+q2Y11i92pTKJd7Oii4UcXOExR0xOOYmlTHf7
	17+hx6gTXZz0a1U51OKl2gi/e6x1/bQQDfxnpoIc4z7AHRalKVMtxIeSOmUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787225933; x=1787312333; bh=P/VNLrGIyQnwQDf05/2oiNFEdhdXr+OedCT
	Lc9zSyiE=; b=FWl8KBy7/3kdrvuSCKlgRnxRbP7r6KDHNBHygFOiMDaoeaCsbGx
	PSDCXeAODiKcM5JcYWYR4jGYqS9FNXRxPRlsCGYvZhPPGozT5hFVA3QPfFz/Atz9
	I23Z2/M22QUFl+lmeGuH1D/4MazPkDtZAjBYUvxI8erhtDWfg4kCQb6GnYmLoGEi
	hioZ+DF6F+JsXyFQP+48VaantV8/LIwnNyfVqR02ZXJv13GLFk01W+NmvBJjn0ui
	UpG/jGA/d+P4u4NJcirIIxiNBFPET8X5XXOAKwWkF0D2vqfcIp97CIXJhQiXGWLc
	XU8LjPl2JItuOV7bXUFdsA+HYLewvoeqaig==
X-ME-Sender: <xms:TeeGanqhCATXyHnvAd3TQ78M_rZGjjMf68pcO4nRTl7h258SMexT8g>
    <xme:TeeGaohDZTyJ32vz47EOKM6NQ83Wbg3nt9ij9rTm3ynATmPMySrZnqaWDsVbQegB1
    izkjN5zig3EXn2w2Pl8gt0TI-myjKhO3KJFooXqzrpTVbyQtKVTcg>
X-ME-Received: <xmr:TeeGasiDPIZt63000jd9DiM9DaiOBSY6cs5KwKLVXH86Gi3nnJQE46W3ltjarTYhineWZYWTG7pKoRtPizuv5lLYWI8J9k8wZC76kFXgIQ>
X-ME-Proxy-Cause: dmFkZTFWHYkG1q0B5NUv6TZlhvAu+qqcNdNseQgRnEnTTgnZ3q9NeEGnWEebmf1xPm9LtB
    bi6Gx7Yc/aTnLjrmxv842RgcFqW9Vwoos/btylBz/PhAaFC/dEScnGJGcbs2MlewFphw4z
    dndoapGdRDyWmT8IKPH41oF7NpuGN4lH3zTafnBEUKQQY4nn81Hx3r5TJGbUkfF0v0mMQm
    HW9wnsReSC0RbnKXF1VqtuapHGm43wosDuHnl/Be6xIzT4qwVaXpds3+Dc+YdNxVV43iBU
    UQqIVzgwz5YTE0qoaaeeRsv2tA1sFpefei32BFpY4VcPYR06am/aWRC9fJu7pdXK/ZNvHa
    cZSIDvIoehKOD0UU0K/bkYdm3HrxwFfyfreeNj7I7tjD1Q5hQXusGvFBbz2JGk1TUL/E+U
    LDZXKzs/GaWY5rF4qaDdPnw690wjhjygvInNyQQlEnFDW/4Yu8Nq1lqzumqyOwHdi+7AnF
    yy/MNegxBmL3cdRiEPX/GvHhUcrJt0ywXt1whaLq5oZE7M7O7Wo/PPTt7UCP3R+L+O3Qcp
    kXaLHvFwsV3IYrjsYbX5LTQiH67O5gxocglo6hF6+VCp6tN5WzDQiDHfrr1hBtZHqQ7sCx
    drVI7z2rRetneiKPwtqtfRxaTNrtbGH+B27g8cnTR9XWP5Xg287emdSLf+7w
X-ME-Proxy: <xmx:TeeGamj2KvjH3-6wIWyw4YIcNOLrH8mUA5Rgv7s18Ykj3nU4CO4Zpw>
    <xmx:TeeGakIXotCa0VKEN2XbpzfRYxrm1T8TvpB1d17Xf0yc16ElXq9YUw>
    <xmx:TeeGatGMvSaYjaiEp9Fi6RgtW96qethItu_eZejEWzGROXXEffBNRw>
    <xmx:TeeGagQDHjC8U0w73RAwo2QHrtUcdVi9e3w4Erdf19mpUvpVgY2yXA>
    <xmx:TeeGapxqzrLMubcqYqODR0iLO8W6cP6Z6LnO7MMb4wfVm4b_UvN9xQ9d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 07:38:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0570a936 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 11:38:52 +0000 (UTC)
Date: Thu, 20 Aug 2026 13:38:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 1/6] odb: introduce interface to generate packfiles
Message-ID: <aobnSsQVOCSoR4kE@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
 <20260820-b4-pks-odb-generate-pack-v3-1-bc42252f6169@pks.im>
 <CAOLa=ZSYyfOCs8Dr0Xdhv-=Q=j0z7vtfYqopDb07XuAm2PU84g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSYyfOCs8Dr0Xdhv-=Q=j0z7vtfYqopDb07XuAm2PU84g@mail.gmail.com>

On Thu, Aug 20, 2026 at 03:16:37AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb/source.h b/odb/source.h
> > index d69f8e2d1c..e2129766fc 100644
> > --- a/odb/source.h
> > +++ b/odb/source.h
> > @@ -278,6 +278,23 @@ struct odb_source {
> >  	 */
> >  	bool (*optimize_required)(struct odb_source *source,
> >  				  const struct odb_optimize_options *opts);
> > +
> > +	/*
> > +	 * This callback is expected to start generating a packfile with the
> > +	 * given options. The pack shall be generated asynchronously so that
> > +	 * the caller can consume the pack data and progress output while the
> > +	 * pack is being generated.
> > +	 *
> > +	 * This callback is optional. Sources that cannot generate packfiles
> > +	 * shall leave it unset.
> > +	 *
> > +	 * The callback is expected to return 0 on success and populate the
> > +	 * `out` pointer with the pack generator, a negative error code
> > +	 * otherwise.
> > +	 */
> > +	int (*generate_pack)(struct odb_source *source,
> > +			     struct odb_pack_generator **out,
> > +			     const struct odb_generate_pack_options *opts);
> >  };
> >
> 
> Nit: I see that `source` is unused anyways, do we need to pass it in? Or
> is just for consistency?

Our specific implementation does not use it, but others might want. So
it's mostly for consistency to give the callback enough context.

Patrick
