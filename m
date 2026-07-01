Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD50D3009F6
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894416; cv=none; b=Wnnj1V7PHXMEeHpKcwC7+cZfGQlCiRVcikw/VsEgosQmck2IeZ0JcQU86B6ynkpsYu/Y+3mdweBfmuuGQEo3AbY3WdinEDdULPKOrYiOcG6vlaxjmvgtn7BFyXTVa3bOtUOCiwcjfddEb7gw/reRrTUlymENSzCZ1jghXSvLqBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894416; c=relaxed/simple;
	bh=e8QPBWYhaMlz6zGFAAtP53HlT0a2MefiKFBK/o3kNzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNseOqbPJebdp6+qg5KTx2HRnM7XYLIddjikHkq4Uk08OZAJUNLhs9J5IU2IPBTE1d4SibX9An+pwlTM4ZpNWDmcu6p9+bOFIeZrhQmExawb3aXZANSq/YBmF/P84OukIYAz9efIKByFbGO6rBasme0Rai97DlGsFmlt4nZdupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EZ4GEWWe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g1Fc4clD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EZ4GEWWe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g1Fc4clD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F82C1400149;
	Wed,  1 Jul 2026 04:26:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 01 Jul 2026 04:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782894414; x=1782980814; bh=e8QPBWYhaM
	lz6zGFAAtP53HlT0a2MefiKFBK/o3kNzk=; b=EZ4GEWWe+WQsFVBZScDOqXFETV
	EQhrV7LODSi1Swg8wIsZ/JnNy+3MwTjgQ8B6rLRsgSa//l9kz3mAkq86rtwULVKb
	uPlu7tp2DfQNqKRP3cNPYIZEfaq5jvm4p9cVQziWnN7SizC2jBcU9Ep0hFHKyg2L
	lUMCUFsD8wtmU/UegkhJ4WlPabsOAeq6vLziZfk1+brOdo2UqFeslhOyLl2IQe8I
	dUZkaUohaa3b5CnlbRhN1vkXdZf/mDVctH9W0bl3zxdaklxjgf08tPDipmluPckC
	jDnrCpUHFs/h2TyTu7A+OW3/i6srKlaQCJiUHN27q/pEwfU/i3Wms+AShwZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782894414; x=1782980814; bh=e8QPBWYhaMlz6zGFAAtP53HlT0a2MefiKFB
	K/o3kNzk=; b=g1Fc4clD0AhkY0oAmBZbwpKWZ7gHrECkrryjEz8hVfaO3ZrMg2J
	hdtSIx0XpsAA5Bbdk7jdt0IngJnNzAt2YiEfhYcWWr00ajIx5RYq45cx6tIGEzS1
	vsXULrNITQw4pUvEiyzxHwEBa58RD0FnBV3B7TEKldNlR5VStUWRTr7du6/ySPA1
	K0DNAnpYqN3YaHdXYC0xchVcxVsMgGwmurlHRAQxXf3++j/joQaxgDdgB8gL1/Pw
	YKiXWXcEvn5PB2rqxOy9bKSiRBe9/qGqQhHvXiwt3CFiZKnoxs+++yloKs2VDUhz
	hnXgffU4kOq936BMre8Jv6mHAWiB09yfB4A==
X-ME-Sender: <xms:Ts9EamlodjLyCAKdQa2KAng_OPq2awpu6oBtZNS8i4Ipb2Y0UrTOAA>
    <xme:Ts9Eaj1qmAXAqtIg-9a2JvnPHhNeBukIBH7rDrfiG7yW4zt0KH-1VRVb-CO_osN9l
    khkYcKzx9RVZ3DKkHmYPeiV5MKXGilQi7PJXDgwCL1P3e19zZ0VKQ>
X-ME-Received: <xmr:Ts9EaiQA3VvJoS61ZuGGY_SdRLmTM84Y37vCtuFuR70TB8GMudyeMAA3wqEekgNXJMax-eVxGGEfo787dQwng1E9GDR5vO06wCOMGyp49NQ>
X-ME-Proxy-Cause: dmFkZTGdZBTIgAmDmploz9XtNydoPEpmSXQS1hBVk03r8rZW0E0aeYtx+0BmLAvXOQkhH6
    A60jCIPUu3f9lR74ugVRk2txxCzEspg4WL4F2EPgulzXF5rA9avKqI7UyKRZxf3nfmzXbP
    gUNjg6cpgfOkpaUjRyoizPkCqUm/LlY9AyBM361ag8QmSzWXizxQweI0y6/UftGK0mXi4T
    Ft/em9xEgPkLBdgobXwLxJX1GCo4BvFz5tOSek345RdEDjHD2PEn2GMxkjHNgnkbFqqgJX
    ygzZxWwnBQZEq9tbumK3e30EZBM0udQ8biYJJYmwIXhuJeL8f9601glNP+iKQrpw8S23f2
    yN6k2l8UukCiUAdEQzgm/u3sncMs5as80hTPOuVHV+JU9KU+8i2+XR55Y3hHybB7APlZwC
    5dDGXTC8SABqjkrPOow/ddDnDCDv7UISTCLtbdzFEI6XPFF/QUeCi+kw/orEg+mAxx++A7
    6NMkjkO7RJAt2L4P4bLufMDdq8eParveclb5hb+97mC6OdkNwG+43DfDg+I4W6R+Pa0HOa
    xvi4lyChHvMKWzv97jitAO9jedQIfUkd2G6bbo8XNk9YeWbReBJOejmN5CQ+pgAl3+iA+k
    mwmGX8904zeHJlwHsLU0/DZnmYr3fgJdjhWhuQFnvGVNgJD0CyFZOeNGzbFQ
X-ME-Proxy: <xmx:Ts9EaluwQyz8qEwWJ13gtwBFBoRONwlWqwS3OgJVjx09UQodS1sKCw>
    <xmx:Ts9EanZW7hACNcFh3snd05JxOci8rpce4q5Kv7PjnnkQJVCjEVgjEw>
    <xmx:Ts9Eaqu_iP0Cs4ddeB_pISRS1C6v-R6rykkq-4NU2-AlDw2A2MJ6fQ>
    <xmx:Ts9EapHwpab9CW8HUDhRHYjzVwm5vmMISJV6_F2rLRN0GYK3Pzx7EQ>
    <xmx:Ts9EauFcaLyuqZsbk-bsGff30-d68AerHbfnGEHrTppwP-wQfEtSvZLs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 04:26:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5dca82aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 08:26:51 +0000 (UTC)
Date: Wed, 1 Jul 2026 10:26:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] revision: avoid leaking bloom keyvecs with multiple
 traversals
Message-ID: <akTPQ1IVqWy8WTk8@pks.im>
References: <20260701063538.GA2579765@coredump.intra.peff.net>
 <20260701064052.GB2580331@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701064052.GB2580331@coredump.intra.peff.net>

On Wed, Jul 01, 2026 at 02:40:52AM -0400, Jeff King wrote:
[snip]
> There's an alternative fix, which is that prepare_to_use_bloom_filter()
> could notice that we already have keyvec entries and just reuse them.
> But this is less safe; the keyvec depends on the pruning pathspec, and
> we don't know if that has changed.

Right. We could of course start to record the pruning pathspec so that
we're able to tell these cases apart, and if so we could reuse the bloom
keyvec entries safely. But as you mention...

> I think it would _probably_ work in practice, since any caller using a
> rev_info for multiple traversals is probably doing so with the same
> pathspec. But it would also create a very subtle bug if that assumption
> is violated. So we'll do the safer thing here, and generate fresh keyvec
> entries for each traversal. The efficiency difference is probably not
> noticeable, and this is what was happening already (we just weren't
> bothering to free the old ones!).

... we haven't been doing that beforehand, either, so it's fine to not
care about that for now and just plug the memory leak.

Patrick
