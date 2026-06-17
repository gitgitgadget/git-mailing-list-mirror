Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9D3BCD19
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681224; cv=none; b=pF80UtAHMlk3KwVSL1NHBnQt2WjxQRGFW4ykysU1w2L9WGmfnA8XMwqtYI1fVeSa0MeR1IpF5fb+5brKZEgpVt1KVaSHhUjs4TYdoIt9Q3DJXaARj+gwmzEjXf0CSFCz0M7YAMXJ6otV3tiTpohq87rQONmKxZIbx5XpF71MMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681224; c=relaxed/simple;
	bh=2FR1R9nFsaVOb8ijZfTcSw+no5Sxye+Hk+m5YMCWFAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEpEPPCsqgH4/HbTAzEQ0ltc6ZRwcGVdcQ+PHKnX27QNTU1x4L8jcCiN8oMI+NNQh3Ow7ABGo9HH+wV6gJPwvSmIy+iKrmuu0gfVn3PJMXASl0RfIhEFgWJrtq1rj853EXLQjbgd+rWoPiovx4cBpDmxwXJKMYkjr7JTCcy2CXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eBJs0Ow7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OAYKi/Hd; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eBJs0Ow7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OAYKi/Hd"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 56F7D7A00A1;
	Wed, 17 Jun 2026 03:27:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 17 Jun 2026 03:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781681221; x=1781767621; bh=B0lIkFWitM
	uH73BzxHohiKn60tfWSeFRI+OMvy9ixm0=; b=eBJs0Ow76eY6zcZrkifk0hFm8Y
	mhdCo1YUNgMzWs83EChtwixU+T/Vt3x3/OWi71OSz3voayAqMduKIsKra1mjDkMU
	om7cVx40I5hNZtkUFTyKB5JQJWlKNbh0U/B1iFsDnrbQY77INzsF8WshpARaeTUP
	Pior+B7fwPlanh22uaVNz4WjXa4lcfLB8vuJvZxdTaw69zpZ6S6ARB1sgdGppGs8
	euz9YfO2vfRIfGxs1zz2nEG0ekpQH9QI3tEamg8RVLFiz+RKRjdhOky+11KtNTz7
	VEzEM3bNeYiWZmAizHbGqbEtCktIef92RZEQekYLb9DiDxUr6dAgrP2B+Jzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781681221; x=1781767621; bh=B0lIkFWitMuH73BzxHohiKn60tfWSeFRI+O
	Mvy9ixm0=; b=OAYKi/Hd36DYiW1/cGMksWpQ3rB/iPpUc1WYM2ahHXiT9LwTmRy
	FOl9R5PLlufEkejol7Rk3ILZwzTChbXbT+8AMEItnrHoSTgBRlOHdj9F/fsssHkM
	xj2aUPAJdfsdwPjoEMvkrEqViQBNcP2iBWWYM+Wxs/lDkN5n43LtEhu03IXxuoRL
	I4Pou2or4jyIJ2ckx5Irs15ZUYXCeun7tHIMfqNzGNJLVPLlN1zYI3Czr6phqm9k
	hKGE2SSSeQrTYeyGGHoywvivR1TQDZ/jU31PAEUwL0shnFE35o8HMhbvnfK0tFev
	7owPke2Va3M/fKo2CmDwM0IDpKOqkL2fumw==
X-ME-Sender: <xms:RUwyagFFsezC53eViS0mG5cLHOW6n-I74C4I6Pq8r5u-LmcoG_5IdQ>
    <xme:RUwyagw_NzjlzZQz-SDjvXi9AxGR3ZGr4oVi-RY8PotzoFnqmFtQttBj2yGRWAzaX
    DZV3ZhJsgnN3lkw7_abAD1FnLKS5tfq_RFdM9rFQmxKEBP67y3O>
X-ME-Received: <xmr:RUwyaniouE0etm_pZM7opXy8WqmuLNpHlxSOVgSM3E2Z3wsPdC-uGaPYuqTgw0UbeO-Fk8O2X29_w-1QCINL5b09E104B848bk0EwzA>
X-ME-Proxy-Cause: dmFkZTFYIWnMod+DFlU8ex1Z5I0POzh4eBWRZhTZoBItZCGYl+fiA3MVDshZZhT3TXAazb
    seTqLjs2SYFf+8hw263nYtLl6UHT0XYrBBDJfruw3+0ishBq+GzcCXkGQXh64ntSDflqMD
    4r8BvNayiosNQgNnxDX2z26AxGXR01migfu+aHTcYeeRIgF9ADlmtUNGB7kM0Q0ejCDwId
    PlYTDEERIsmf4iVVLQcYRg2j1Qg6YKJcSWem8Ctq59P0cvL2XOCct+nzODH/U94K0+QrJo
    G3xS0umr7/BghpHKECPahwzAkRBXZ/QRGdKpTIOWYSOcxx3+99eAybp274howFZdeg01CO
    PF4uBgBsB63CRR6Nsq6kC5JhvK5DxU4BfGJRc9KsXsnXh7Z2jlMEQzzhiNo46PQWjy6Ftu
    ZRC3VEWsL9Zrtf7AUQWGtS4xkAynnrR95Gw8yq1f0tIxjOeYrZyzUGgksXfUsg7DB0jbpo
    IeSCr9xDe9KT7mTiStT6TY3sWlX2KpKpkAHxN1LQJTodqb9/JV5f0AAnOxYh9dA14/mra2
    i0sYYtIUW6l3aCX5bQCgHuvItRqxzTeHykFhyDifI3IjFColKc+oowr573ujsKSFxEW7gP
    Fs7ANT2kTh8OMECHT922/LnilFY1Hlfn7yqW13LNMDKsX8n4aQVLyD9x1C7w
X-ME-Proxy: <xmx:RUwyarwOZkaCwcCoAJBMc0sk5wB_R5nZHZJDwBBokjlHBoXHRCyeow>
    <xmx:RUwyaqKpYrLlavotLskfIcf0KeKkTeQeCYUqFQgWoHHORu0BlYF9MQ>
    <xmx:RUwyaiRHU4DdmUWUl0VKH0Rw1k1nVYuM5rQ5UTz1DWSm323g28tQRw>
    <xmx:RUwyaiqsYrCi6ylo7loSqG7oJ0E8HkbZbkpLwdwL0u-HNI8IgU3HCg>
    <xmx:RUwyahMox54R-NW5aOJeL-2bxzMt2Y75XW2Xu8jhqzrGzyWXl3A-SMvW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 03:27:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d21d8eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 07:27:00 +0000 (UTC)
Date: Wed, 17 Jun 2026 09:26:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 04/17] odb/source-packed: store pointer to "files"
 instead of generic source
Message-ID: <ajJMQfXpPNlxqhNa@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
 <20260609-pks-odb-source-packed-v2-4-839089132c8b@pks.im>
 <ajG69JZHx_u2mt7q@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajG69JZHx_u2mt7q@denethor>

On Tue, Jun 16, 2026 at 04:14:02PM -0500, Justin Tobler wrote:
> On 26/06/09 10:50AM, Patrick Steinhardt wrote:
[snip]
> > Detangling this mess is somewhat intricate though, and is made even more
> > intricate because it's not always clear which kind of source one is
> > holding at a specific point in time -- either the parent "files" source,
> > or the child "packed" source.
> > 
> > Make this relationship more explicit by storing a pointer to the "files"
> > source instead of storing a pointer to a generic `struct odb_source`.
> > This will help make subsequent steps a bit clearer.
> > 
> > Note that this is a temporary step, only. At the end of this series
> > we will have dropped the parent pointer completely.
> 
> Ok, so IIUC the eventual goal is to get rid of the pointer entirely, but
> for now we are just making its concrete type explicit without having to
> downcast. It's not immediately obvious to me how this step gets us
> closer to that goal, but that may become more obvious in the next
> patches. :)

The reason this helps is that during the intermediate steps, it's at
times very hard to see which source you're holding if we have both the
generic `base` and the generic `parent` pointer. That makes it quite
easy to confuse those two. So by turning the latter into the `files`
source, some of the intermediate steps become easier to reason about.

Patrick
