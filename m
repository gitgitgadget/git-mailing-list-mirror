Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D228346774
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555777; cv=none; b=rG536P9Vz59rA/q7frsQEWF2fGjvpCLJrG/stm71atLSD2xk6dHSaNO41pTLuPOxtJBEJ4Zhu1+HaRgDZfKMeKLqlKhkhJCp3Jt1sVwvl+ywfZMZyMjq/qf014zdVNCuD6f8+1gd2JjqVfJA9UGSRd0XnbFa5n6qEs9P6tocy+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555777; c=relaxed/simple;
	bh=SHurWVsJc/AJqrD2ewEMDIgRthRpwPn+8EvIT/trHOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WXGPB00TY5FFnXN1QhGNQOGVSoPYU8BFPaxOz4z34BWt8UWoiKyjpxGa50XCLqIoKODqDmAvf+HCs5WoDaCBeTN+trmUwPyyFoi3XxQby+Qjhu8H5bcp9+PYfGtXaQVj1cNzPvxuxl3BtSXF8AG/5ILVemjT3KEJ/FatTW35JOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HTG79RSm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HFQuDbEA; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HTG79RSm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HFQuDbEA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B2FA14000B7;
	Wed, 12 Aug 2026 13:29:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 13:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786555775; x=1786642175; bh=HMKsgbCuQx
	BznGkyhutWFyV1NT4/aqKO0GZkv62jg1E=; b=HTG79RSmwP1qeV4gUwTCco4iby
	TktIPXFDYlcF+szdLIIiYvqN3b+2LYKkwLUaqDUDXUCKUco6cxCP1noERfOtNMX5
	dfKMV04nF2g4FSvzKbu7UGCpgMhXsicebK/46ZfxhBSlBMHhcx7UxekC+W09OuJJ
	9dyXInwCZ+TyeYP/EEUJec1HMQbTNHmEDKVywPqgcUSa3Rxc2Dw3WLVEZU9vm+35
	6V3FTcUJSGpYKDMPuJJJJMfqJXYMxGEIowbbZdEHoFHqao7aje52nN7iWquDk2NJ
	lzYA6pYk1T2afsRwy5hp9IjZlYrV8M4lOQk28+akkCXXvDH+saTXsmqFUMzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786555775; x=1786642175; bh=HMKsgbCuQxBznGkyhutWFyV1NT4/aqKO0GZ
	kv62jg1E=; b=HFQuDbEAz2PoccWjSTz4LWFDmnM0pygUMN/W846WnfLcvN+mzwu
	dAPWHIPRUSdcxaiBGW2c1yPRj6OMHBAnliK67pJxvH5gZZLd51/58ENuHLs8IpuC
	Cq2l4mzachkSSrc31BFeOJlMwl07KsKYerSc0qS3oBpTCMnjO6PxZ3jv3oUjH8Gt
	0SoZvjISWOj0cZUIISUxadrpg1Xzio5Qr5u7NecSQq6JrJjleVSJo6C9JR1ssHR6
	3rE4R/uDUXvYo/r7rBbq3GnWvh1QO3mDVVHy1FmUmKx6rFFGQyBEhGdE0bSVUYRn
	DTn/5DvyB6f/NoWxKwaxZDLu+y0JSfGSezQ==
X-ME-Sender: <xms:f618ah9hJWwcKIEoQE_onHErks8uXpnM4qVJ5HtXjrkaX3U9esg6ZQ>
    <xme:f618apZ1MQP7jL5UEV2tMiw8bjbFn3AWa2QdSTnzGR5euLP9nK-vUY89VPUTPaPiW
    tm8rNgJnaQ0Cpb69z6BIGvHYCVkZi4R75fN5haeUkBChBJ3hrsqGg>
X-ME-Received: <xmr:f618ao0vv47BdMjqMvN6NuDif0DKkg2jw2u5zCu9XAh7lKf1aWwZH95YaCUctdVIyTqdqGC0-Q_Op1zVhcRV4TlZBibo25R-fw>
X-ME-Proxy-Cause: dmFkZTG3VRmfTkGe4YEbw6ujyj9QNpTN7qcrpg7jrq5vJrQFLEO1m7JiwPmrhVlPfM87pK
    cle12LXxk57rNYe0bACJmW61y5exTGeeA3XfGU1gfECxcAB+ElIZg4YYzcCTFz9sPDs3Eq
    hE7tVEBAKsL/BFl15TST2iYc0Fb0vSaqEz+VxH41P55RzPzcWJz77Uyaw8o99vnWQNSIoJ
    KYm3Q/uNiqDIHwzHBsgBTMAXaf0eVNTmwxRVegYDaNwjP+B+IVRrNCCoAQgV1Pfbjuk6/E
    bJ0uZYHSpa878TwDA+GKg0lvBbTKrLOc8Qro2gyWH18kXrF8SoG01kzpmsn6OTA00ZxzAc
    uedbXst3btdRVmOgC6HD4mSD3PKNpnrJoae9nhTs5epJmEN6USx6YaMRwAqSIkdMFpbrpg
    2Cdn9U81DKbfe8JhgBdzqCivex25vj7PAxYoq7/kSh0XGu8BmVv9O2zOjVZMSgNDZrd2mV
    U0zWzmI7skvfYtEgqWc1s3oGITkWGW23TFKE28pcgU4H5RFirkhwMAQjw/byKAtAx4vRDW
    l0esbSHy/CFPTwOASiT/A3I1HD2lFaLkd6fuDQF4vOuhn7d6j8UVO8gIeQ9TwlgzolXoBP
    A38CZoUtgTL8w3nsq8b5d1oT6/eH22yeepKYOCZHjEws4yroAc/0EMK3KQOQ
X-ME-Proxy: <xmx:f618asZcCYycW_eMCyOsbTGRQ40E_ZPM7uNPrY830TNMaBCWSnj6cw>
    <xmx:f618aoIzVKr_5il-WGvwus0XfRk3WHSCogaPlwi_htbvyH5rIElvbA>
    <xmx:f618ajHZKPPGuUoLBwXeF-dq9UUBm5CGrwJm6_tacaKs2j6yMq5thQ>
    <xmx:f618anv2ugDbIPkHhSecHixTqd0vRrB1NBAI3atKOxbS9sZA-xIg_w>
    <xmx:f618avHq2uqsOdVVj7EdHEB_2GmVLx1vzLCCJC3o2JtCsmlGOlJdFS8u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 13:29:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 00/12] coverity: fix unchecked returns
In-Reply-To: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Wed, 12 Aug 2026 08:03:08
	+0000")
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 10:29:33 -0700
Message-ID: <xmqq5x1fxn5u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This is the next batch of fixes in response to issues reported by Coverity.
>
> Changes since v2:
>
>  * Added a new commit to handle block-writer initialization errors (instead
>    of ignoring them).
>  * The bw->zstream attribute is now also deinitialized in the error case, as
>    suggested by Junio.
>  * The commit message of "reftable/block: check deflateInit() return value"
>    was rephrased to stop suggesting that silent corruption by zlib would be
>    possible before that patch: This turned out to be provably incorrect.
>  * When aborting the bisect because dup2() failed, a left-over saved_stdout
>    is now also cleaned up.

Everything looks sensible.  I am fine with declaring victory, but
does anyone want to second it?
