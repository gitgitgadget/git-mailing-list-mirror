Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832339EB7C
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936496; cv=none; b=CdZDGzPZDqQ06Liy1xO5p779o/mgD3d84aY6gDvpcE1cCdYrFTQ2ZqsJuVODPSbAOADF/goJkIu7uODlJHTe0vbc1hqN9t7f38S7EfaUPeplDmIjGt9UGK3O6Cq7hqIVNSsi0XWmVwkgayNcI+AOiuutaL+2/pWYo+f8BDU+0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936496; c=relaxed/simple;
	bh=juIMkfdpGP2/h3vMKUFq5PgvkwuqQTswDNTT4/RUpYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfJ1ngFBcyJmt7IOBx8AySau+WUZN5N892LKpszuvm2WJoeMLZ0MvvOnvffFFeNFkLppDAk6dKabSPwOvINcFMrWmF2pd7x6PXix6sOAI4pBbFs/eHTSyhox6nbpPPqiuB9jO3h0W2MmKGlqiClB9BlpFUdloH4recc+E324de8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JJOQWi3O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EuGcpCrq; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JJOQWi3O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EuGcpCrq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40C7F7A0088;
	Mon, 13 Jul 2026 05:54:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 05:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783936489; x=1784022889; bh=XJPE8Jouc2
	ef3ekLrf2UBPBOEJCzNvyUFa6G4n5xRcM=; b=JJOQWi3Ob4zZSK+X4P03+UvOsm
	geupD/712lxEK7y7/JFzYUt5NDEOk9yT4jzE6XqVcxIFAxi9LcAAg1fU7qAZNAd1
	oDhwXjPyRQdZDm92vDtaKVETPJiYF4oWLctwCEFG2L62ZHg7PrT2E2x7x4O65Qs0
	1hS4o8ik9pq6b3XMXV3KUMNJxPds8Xkb9hJoxTE+JmZf/Bn42zDvQhjZMxxt3J9V
	W1wLhqgYCD6/WZXCs2xQc4qHh812MEwKkFNucLSSMUxIi3yh+BCqXAKG0obe9THc
	964QoMxOzfwKp9HAKhVD6u2WAOeh9aC3TFZIhSLjRtTuRdEJzVwHNs/Avu4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783936489; x=1784022889; bh=XJPE8Jouc2ef3ekLrf2UBPBOEJCzNvyUFa6
	G4n5xRcM=; b=EuGcpCrqvLxcC8Ab15cAjKiNl7s/qLaqU+Fog9iVCPxCulZdm2g
	M+kScEnlaiMsIOPHRRB0TFXJKoaffxYemW1k0kw1qInzLW3azxH09LnaITK2N9dT
	iUxM3nlO1+g2l9gwtEyDN1RA24L6g/v09Ls+PigZJEz2aQBN4qqHm5VDFqQ7AlLV
	ntV8vZOE5V8n1xwlLAZAMYrtCrK2M1Cg0NuBI+1WIfLLHcPVUjqh+JP467L9I4go
	r14f2kU7vNYxuc8gkGAx9SnCtrAuVnTYsRMuekr3dUJb7kItwVpDWkp8pn2Zl32/
	BeTiDbP2jJo5lnnTyaIgXm24A1MiohUetfg==
X-ME-Sender: <xms:6bVUatM5DaaiKUl6fabG_zu6-s5IJjmtf3MqE8YuHtl3olKF_UhvmA>
    <xme:6bVUam_xR0Hfu1mMBLfIdWDGJK3-4n2AkDl6uLVWdQAxJEMnXuUNv0BAoMkWISpHw
    zQzhqmT6NCyhP8auA_0MsXr5Rh0K5bhJZKr7REc-fQAJnyYFnvldFQ>
X-ME-Received: <xmr:6bVUahSUybCq9tHYT2BnLooLqFo_5fBwbIyRGIuV6zSNqC_uLmv0JpdDgqUbw4DmLW4Cgn8CxD6MEkYAs1QSdB0h-OBUNX5t2DCdge1A>
X-ME-Proxy-Cause: dmFkZTFpIvDtKCle0paMOTLD0Kj8Oq9aX8qs2vJ3RujWphZpwLxj5eUN5W65KNRjPmNmlr
    IvyN/7a5XWWGK1Rzvj7XPar25XEHOBoqZeHXY/2d3NA8gKNzfRhrI3b+MFnPsVnzWrBaY2
    vWRKWYQTjUvo8p44ONKNwjAQOHBa2U3gm8/Xp9oMIDu3cl1XV8ya353vI3HtgkAcKVTYSl
    rmrr4EAI7vzh5FYlQ7EyKyO6SWKyJQsQh0YgR5n0iuX7XgKj0Y0v03LXQREDXZBxrAD9bF
    yW/WxykMLpRFl/z8Q0WnlSwyce+dLeXxDVmdy9m5bzxB3n+60+RXDJPQ7wuOqj1Akq1eIX
    MhN+FnbLD81xRlSnmqwHTAYrfFGwzq/xJt6ED6TWY2nr08Nb477+pwazML7XHLCMB+dJp+
    Fo4Dpt13l0TBeboA3jhA3dB1LMLrOFdrHzq4ra6tCvClwKn7JOo7IVs0/PPtJopF8yUS79
    QohYP1gbOZEJkWVBrgngfyAY5aLFsemfGf+UTDoA6qURPqqIZd/r2gkEkcFlt2lxbzHunT
    em4YT4UKydX1B8WfR6yQ2bPxm3CZpzi0BkzYe9AcAwXikackt57Ii7M/w7exTX3iyIepq9
    H98IwwghoXnYtx+XdjGIWjSGLuUDcBZZIBRyu6q2K8Tbm1re3qgb76Qjmypw
X-ME-Proxy: <xmx:6bVUaokSbhROpHiBsu2ILiExylaCmvWuWyzriSp9dvN5NljLICjUZA>
    <xmx:6bVUahQwEilwsRlvl4UDJ0Ug9p5mcVsiEKkAg-mcWYIt6CxaoaLLkA>
    <xmx:6bVUamO-9syFelW9_5t2wn_O-4APTkp8NbS37WcMVP6U2uSmut8XdQ>
    <xmx:6bVUaqUVS9kTEtG5eojVx_8-JtLvjbs_Vvy-mjtCxt9oiWWdo7bStg>
    <xmx:6bVUarz-X7HW4FxPdevNkqwoEVk0_UVhBhTt5fra6naxRZPr4dneBo2g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 05:54:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe344d88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 09:54:46 +0000 (UTC)
Date: Mon, 13 Jul 2026 11:54:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] odb/source-packed: improve lookup when
 enumerating objects
Message-ID: <alS1440iifvTvGKP@pks.im>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
 <20260710-pks-odb-for-each-object-filter-v2-1-3710a9cc165a@pks.im>
 <alFxRvkfNgJRCQTB@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alFxRvkfNgJRCQTB@com-79390>

On Fri, Jul 10, 2026 at 03:25:10PM -0700, Taylor Blau wrote:
> On Fri, Jul 10, 2026 at 10:48:53AM +0200, Patrick Steinhardt wrote:
> > Fix the issue by using `packed_object_info()` directly.
> 
> What you wrote here makes sense to me insofar as I understand the
> pluggable ODB code.
> 
> However, I am confused by the way this function is written in general.
> We use `bsearch_one_midx()` to locate the first possible MIDX position
> in which an object matching the given prefix may exist, which is
> sensible. However, we go from that position up to "num", where "num" is
> the total number of objects in the MIDX!
> 
> Functionally this is not incorrect as we will happily discard objects
> that do not match the prefix. But it causes us to waste CPU cycles
> repeatedly calling `match_hash()` (at least for the first byte of the
> prefix) for objects that we know will match.

That's not quite true though, as we abort iteration as soon as
`match_hash()` tells us that the prefix doesn't match anymore.

Or do you mean that `num` should only be `m->num_objects` instead of
also iterating through `num_objects_in_base`? I have to admit that I'm
alwas struggling with the chained MIDX. It's never quite clear to me
whether a given function cares about the complete chain or whether it
really only cares about a single MIDX.

In any case, this code ultimately derives from 3f5f1cff92 (midx:
introduce `bsearch_one_midx()`, 2024-08-06). If one squints a bit you
can see that it's still roughly in the same shape.

> How often do we call this function with a prefix longer than a
> single byte? I have no idea, but I would suspect that it makes up the
> majority of calls. If we read the OID fanout chunk, we could narrow the
> range that we enumerate through, and only compare the second byte
> onwards of the given prefix, if one exists. In the single-byte prefix
> case, this means that we shouldn't have to do any memory comparisons at
> all.

The function is currently used to find unique prefixes and to
disambiguate object names. So whenever we either want to abbreviate a
object ID or in case we cant to figure out whether a given object ID
prefix is unique we'll end up calling it.

If this logic is currently wrong (or at least wasteful) though I'd
propose to fix this in a separate series, as it's been this way for
quite a while.

Thanks!

Patrick
