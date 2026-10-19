Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83734534B7
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392974; cv=none; b=M8T4Pg1643Gppfn6Pz2lTwFhNe3CfrJGBKiXPypFte6er6E9yh+aU2JZk3ZCkycpjsRGPjSrAhWNe8AYhwiv1pl8TjVqgzBnf872Yenp4GQS6m3DX2pxiTUZ1Zch0vG5eH89n2qZOIGvyyQAqsFwLhuUzMJhhAQah8Am9ISsIic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392974; c=relaxed/simple;
	bh=z3bpz5+SglA4d7i//s4EvLyzgK7GSjsfYan6EHLzgvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMX9IdWYK5RtszTWMzFFOCFQw7t7sg8LtCH2hsfF+YUcN7thlbh4pa8wd0mvxQkndPfgfEMOewdfKfz7XzHvravsvn9vex5uR9MVDD3GApXmYbLooEAEdpM11q7GFKtq9UmwJFmH0ojj7vHcqUtcDbtOdnyTu73R4Suwo07/Hck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YBs4NzVz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HqQgCoRM; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YBs4NzVz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HqQgCoRM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 058007A0137
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 02:56:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 02:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792392971; x=1792479371; bh=B7NRPcN5kJ
	BCsZ6S55o/TDDjdfYTjU9suYCSMsxD4Gc=; b=YBs4NzVz+nqEqNDlXRHmRlN9BO
	srZusTi/i9NwPdx6B29LhwLt22fFPP/8VuiuglNasXWA2HmwYGn8C6xWHCn6W/DR
	VlLTozgCqwwvD6Ee6wAV90e+X3zvl3a9A4zNzeTT4g2XYjfY8tgc8XwVSw50sar/
	ZgxWywMwF5wLqkUKuUlbXmHNQQHHl8oVlVWjie++DTDZUm5lEV/0sQVe4mM9EUDa
	huxYaXF2LpoDs3GY3R/GoxaykS3ysNoI86R1UxTQEs7oezfoII1u84XdLWkI/4Uf
	AfUA8kOod17ayYcFhSgaAcj+k5UD6+HZrT8QTTFUJdwslpvIZNv/mRvcmGlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792392971; x=1792479371; bh=B7NRPcN5kJBCsZ6S55o/TDDjdfYTjU9suYC
	SMsxD4Gc=; b=HqQgCoRMm/7QpkrNFBvd4NMP1B0iGC5CBX7tqVk+kP210IVMHPJ
	6ntTgZBnnPyNspSwCqWcYPlRmV4f8I6hbBDSjHfFxHUayzd+wKULE5m0YSiqNoVJ
	92bqV03zwZ8FWOX/BKnbaVyYDSsZJ1yTwtNwItoCcGNhGZIRSZxOoCBaKHXXGEJB
	9D2IRQVcec2oc8gFTjBoNJFSW3ZJENIdCC1DVtW9gue8v4Is+tg02s7dbddRgONj
	uB54/RetVSxuSMusNUeWtEn/gZTCOxGC8RjR+mw8QwMyHTjg/vMzXAknrYUENnkX
	TZfuX0iITBffhMq6ce0qCCSDEGAg/8qKtuA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792392971; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UaiRUqxkEfGqHBwbtwb8bhB9g8GC0WicNg08hVwB5EZt+ZV
	zLRDLbzsLoCMgwhwX6ofoCIfjDcq8ncXF6fafj5Ues/A7/OQvkMQY6bGwrXngOnG
	3bhNW8ALyLdBwXwEMisbyhbgM0o9eYoVmt+kM0Ku3P7iYO6T9bzGoHityrzmRtaM
	17a/H8Lru5jjAz9Aj71ofKpNYhZL7pSMvwO6yesunFQMcYdgvmjLfRAMcw3y3chs
	lBSlbbP9UPbWK532vnRDu4CP7eMLCU+ySbgy3nI+EYh4mnGijKh0v/BshnUWIKpA
	2e8gue5p/ZKAVbr5ChqV7wiL+HjyN+lZK2P0wmQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZMiKDEp2+k4f+HP1ag7A+LUIiwBrmdFGwRKBqK4d4is=:z3bpz5+SglA4d7i//s4EvLyzgK7GSjsfYan6EHLzgvA=;
X-ME-Sender: <xms:C7_VatYeRDuagWyiNsugF5ULiDBMaOuyV5brZ_ziBHBArdbh08Y7Ng>
    <xme:C7_Var1czyIu6FCRC2tp6KB8Sp9PPToq3wn_0xJTWpgloAOBr2qid0CfPU-ZtyG3e
    ZSE3iCJC9IJpDXKHsyJuYrlTxoGiLCUbarY3l0g6CAqGOX53sgaGA>
X-ME-Received: <xmr:C7_VatVSVrhb3lVQlqXFUxG7nu2lG0AEdTzA0OQniYscvaOqsJF-hA>
X-ME-Proxy-Cause: dmFkZTE6xWSXN9BtWbHrVOOmrXo4W7hstCLt48FvaUFwvfnqmoK3Zo8Ltjtpqditc9aDpj
    pfsOYhX8hp7EZY3WJ9avmOPsFwhxeZ6nmsiJcJA7GaM8htVVQponXKW35PPf4UuSgkf4Fz
    uScjI4zkyKhzNh4jHKKnJy7g1ifC0cQfAbd2uQN0ADxzGXa7br8bHEaqJ7nUmoSDp5gnEi
    LXkVWuZbZPZTVifQAfXTsLhWVmvLT4ETRlI3hnv6KmwGb/KTwGSFJhoiR1930afYqGRtiu
    uOG1NOJnOkbv6X2MewvrVF6RS3hau42z2aGBjdnG7aVrljBSsFj753TzOhVQ+rX3IeDzKo
    8oo6G3aYbn6gNWBgrgz4diw6J/Fi6qo03vJF282dY9Pm0zMc1y7Ph31DwOyu2NL7EqoHwt
    9RsIAnkIYUGxNGyzOAIa9Hb0BcZsN9KCpPL8MiwnaqlRvt+A68It9XvGAYYXNZwb+Z+z5b
    ok9ij4NancU8Rz0sLczNHFLomw0Av/V2HlEKKBWFNIB9ERjZP1MJ+T/X4w4Zs+T5jnw+nz
    P08EssLajSKBAA6bOou1IHtP2RWAxcutKaoWEMLTm8qKP0GBmfRgLbhpWgUlZLKlGo6Uzv
    X5gRDkXu3DgAKOhr2m0kE6hxv9lIg9IAdXSLJ0JyX66wf+fL67zomORTGsag
X-ME-Proxy: <xmx:C7_ValUmUwZHZzDSdYyTBv4EkFbtfp3gP-HzKWjvC6-M5AEcNRkhEg>
    <xmx:C7_VascrldxLIgC_2dWvzoiO-S4Zt6_8qkRTR64T-jyfhhJ3PmLWOA>
    <xmx:C7_VauXu3eh3_rStWB53pDIgVQ-Db8uArgAb6P5c27lGDC5b4p7o-Q>
    <xmx:C7_Vald_D8ocZE5FtZw2UmX-Z2p0SIXc03KjNQhMn8-lmSdLPTGuCA>
    <xmx:C7_Vaj11LCIopSZasQIK7Sr11N0KXj0CwkRv-W602jqf_spotm1bhsKU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 02:56:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 219384ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 06:56:09 +0000 (UTC)
Date: Mon, 19 Oct 2026 08:56:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] gitlab-ci: fix "check" jobs with large merge requests
Message-ID: <atW_BmTQhxFRLc0a@pks.im>
References: <20261016-pks-ci-optional-whitespace-job-v1-1-f5693fbae1a5@pks.im>
 <xmqqtsmlftwy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtsmlftwy.fsf@gitster.g>

On Fri, Oct 16, 2026 at 10:15:57AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The "check-whitespace" and "check-style" jobs verify that the changes
> > proposed by a merge request don't introduce whitespace errors or style
> > violations. To do so, both of them compare against the base commit of
> > the merge request.
> >
> > But both GitHub and GitLab use shallow clones to set up the repository
> > in CI jobs by default. So if the base commit to compare against is
> > beyond the shallow boundary then these checks will fail. To avoid that
> > error we thus configure GitHub CI to disable shallow clones via
> > `fetch-depth: 0`. But we don't do the equivalent for GitLab, so we see
> > such errors whenever we have a merge request with more than 50 commits,
> > which is the configured shallowness for gitlab-org/git.
> >
> > Fix these issues by setting GIT_DEPTH to 0 for both jobs so that we
> > always fetch the full history.
> 
> Hmph, that is annoying.  In theory, you only need to fetch from the
> base that the patch series is designed to apply, but I guess that is
> not a choice offered.

No, unfortunately it's not.

> How much help are we really getting from these two jobs, by the way?
> If we disabled them, would we suddenly start seeing uncontrollable
> amount of crap patches full of whitespace breakages and style
> violations?

I tend to ignore those myself:

  - "check-style" is not all that useful as we don't fully submit us to
    clang-format's style, so whatever it generates is not authoritative
    anyway.

  - "check-whitespace" was quite useless to me because it breaks rather
    frequently.

I still think that "check-style" _could_ be useful, but only if we fully
commit to clang-format. It would remove a whole class of nitpicks
and thus reduce the burden on both newcomers and reviewers. But that's a
discussion I don't really want to lead :)

Patrick
