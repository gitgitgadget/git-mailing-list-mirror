Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81F233927
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695694; cv=none; b=KmQ+YkPzmSC8vSI6GUgYs4HXeDKp+Kumj11GfPw1MmpFXswymeYHpW8mH0Tku8T0wpL2axKxQwLGGJD7HZNg5cB6+mCAGNJ+edCBaRNGXgUDNJBU3oG6O58FokbIetvTsH+17bfBo6I3P/9QCOF3flA4k7b1PBbiczXDFOIV6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695694; c=relaxed/simple;
	bh=iqYB11rEkZ7pptoRwRHkgQn1CoaROntPkUG0Pb4OcFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q3YWG8PLQuSrteJLkeQP7VNeqFk1dcXPQ2oXAjrV+mRw3TlE37v25G6GDAGaf7Ip6r3kmJF6yU4M91eDOE+HIdyt6kJxgT0yaMfKLu4QV+POQZy8lFjIaX1cI7GdmCHclzu9Q+0Y1QHpMaauoQoyXVZoXLmeOlfVeoiJBzrDwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pR8mP447; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fzR4lhdJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pR8mP447";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fzR4lhdJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A5624EC016F;
	Fri, 10 Jul 2026 11:01:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 10 Jul 2026 11:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783695691; x=1783782091; bh=FbcnCRPfHC
	wIwmaBTCLsePTp3IqL8R8QNgfXQDFa3i4=; b=pR8mP447ae02EGDQlensahLutQ
	rYzn2a9h4YHMNSVNp18XNDJfxQMO2TBoDIrlojcHvCYMKAS5gUNT9j7EGrcSzkvD
	mTNypcpK8WYHAacaAaAu86hFyfV0HpK+xsJzVAl072uIXaz8+djeMj1LSXRyN0V2
	P51rOlicH95E4Q415nm8GHDkgIiUcRUj9RFA1w5GUdV20BuecWOES63uQslWFkCd
	ZdIvkzjIHymVPgYl73x8XnkPKT6m38los0/OSwvqK1r/uxhCkovO51cQ7ktOQ+Vq
	ikPHizk+D++owKn3UOP2J4CZ62+ApV0+e5zN0+dPelU6fN8CI6KgXmbtDUkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783695691; x=1783782091; bh=FbcnCRPfHCwIwmaBTCLsePTp3IqL8R8QNgf
	XQDFa3i4=; b=fzR4lhdJZQbqMNmMFTVswX14EETxiARHnj55Vas5exxgYnaklrN
	OJCmQb8Ji/4w1e+rkT9bToPHvYOk/VAu20Q5Ie7/iipdWpcWsHaAWGD0NDODUYHE
	kdXTvxmYqChFDN0WXaMmirNVKJDYx+8yZ8URLUbMKF0M68VKCgYq87vTmPRc9e/t
	xQ5vEvBjDrJa903Fqb9WjsdyroQxERjdo5yq4Vb2CcBF5+FKtrhNszVuttnSHfYS
	Ycump/DRcgIyIAlRkGcASudo1LZJCgFDHIkoB0I6+ka7x1peVml5usC8QIe4Y+xP
	GvWuoikp8Z56kYMeRF9P69QDJe7r/cLpztQ==
X-ME-Sender: <xms:SwlRauHMjLBrjQwK4EXIP3IjhPCjQSkQXq1jZI7OKuNpZslKQDfMAg>
    <xme:SwlRahlmP6imZG-nrfJB-5GWYCd0GI-D3BamiR69FynUQ5XiqCKLzajasF-3SQZEr
    kg0-nblbUaYkWxznk8IGEO6hacb2s0aFIqRIVIlmldGcT7uhiC_Mj4>
X-ME-Received: <xmr:SwlRaqbKCFEGPd0sFMnuG87rp56M8VTTTajbflsb93weP5tAW2loOv3wOo0Ow7I4v5I9IajyvTJqAkxBq1xBAC64o5nVsD43SOTLFv8>
X-ME-Proxy-Cause: dmFkZTG2/NnIWw32Bm2AaYKbtqk1W4OwR+A6oEe2ZvQ7/JhgIZouq7xtu4WNm6lF4gYN6y
    7PU4ZMirPCehKfQXArNPdO58oEeBVln8EENbKsSh9y+xXEQyn8CI/vcvL+AKmfBHCgLRpg
    g6gHk9BjV2RJnSpVOYkTfoDBhO6diWNfWLx5HzOclzzr7di7taH3wmhtlWJ09AuuPto+IQ
    sQCEafYuX5dEM7SONOrm2MXXhCy95n7f/g+GiPLFgcROIcwc87jizuUSjJSsBsMOf4JSAl
    lBHW/ukCTxFLhFrh6nf/YBqqTqIwaKDMBLD6lPpnyWSx37FM2DGVj99f0Zd4aIdswqhmF1
    JnYEL8qO4UYakO/l70fes1tIFknraPB6nkb9q+LeO0Mx4vWcFuRvr6Px2VaaVplGuYDCDA
    35vi3gwlzf65E1XZYJNK6LRlgEwhG+foZiy8hdInumut7g8lkcQy5d+ClSdcA4YfhZBiQI
    0MTjpNyH+4nCXiuxr+CNgj8piv7uWQjjmsmlSgBNcW+AwjqF/L0G8TSMMBIq3xrZdMtWQM
    sz8NjiyMS7PdZru6+0tB6cuG4/hO+DisNXc2Y+XBKKs9DuLhhgPOovX4saogv+LOeMkrSz
    KgRDw9SZUBkhVnGwUlzG8w7q3xZP3AqCE6XFXwpX1+eEwAsT4PE7AYwqpbYw
X-ME-Proxy: <xmx:SwlRauHahrrjeVpPS39JjftBCZLpVK6ZhqXqiolrP-ZOVtvab-Mtnw>
    <xmx:SwlRajIsMsEVmLDOeW6HOVJ2vLB-_UDrzkhBHovKDcL1u33LP6qlbg>
    <xmx:SwlRahMdd8JXJYDB1UJ9jR8XKtps_eQ3HgEfBNsaJKI3W9h8IChLLw>
    <xmx:SwlRarnONIyEdKK_NPG2wOT5PS16JN8PwVFhoHmtJlmp5Unw8gt6Ug>
    <xmx:SwlRaiXqmC0Bb-xvA1k-ZDsHeyT53m_5Pv3j76IqluBVxmGHQf3XaFIL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 11:01:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org,  ps@pks.im,
  phillip.wood123@gmail.com,  stolee@gmail.com
Subject: Re: [PATCH v3 0/2] environment: move ignore_case into
 repo_config_values
In-Reply-To: <9ade3ca2-fdd9-c5da-3d87-a754a0643d6f@gmx.de> (Johannes
	Schindelin's message of "Fri, 10 Jul 2026 12:29:47 +0200 (CEST)")
References: <20260618114207.605211-1-cat@malon.dev>
	<20260619155152.642760-1-cat@malon.dev>
	<9ade3ca2-fdd9-c5da-3d87-a754a0643d6f@gmx.de>
Date: Fri, 10 Jul 2026 08:01:30 -0700
Message-ID: <xmqqechaga7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Yuchen,
>
> On Fri, 10 Jul 2026, Tian Yuchen wrote:
>
>> compat/win32/path-utils.c --- Is it appropriate to include the
>> repository.h header file?
>
> Since path-utils.c implements logic that is repository-dependent (as your
> patch points out), including that header is appropriate.

Thanks, both.  Let's merge the topic down to 'next' then.
