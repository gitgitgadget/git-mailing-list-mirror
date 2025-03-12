Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A321BD01F
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804017; cv=none; b=GUCrGAVRJXyowh0/3zBS2SX7OykhABilMt2IQpTmjz70f1e5DrP2A2hwVgymKAPBEteiyVoY1I6Oj+uiphlIDXUD0aX2CPSarmZa1u+LWzGXzLJ90C/7ABqILcpCcPsVrCrQ5GaqhzfoRJ/AntTPl+UHZpI64q9MCGxbP+SaOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804017; c=relaxed/simple;
	bh=CosJPWIlyhFUzrAt9alGnoqrpY0OyL7MDQGb8wchdV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=irH6hSz0+4i6UZ9OIsL+gd4pV6Ca7QK7GWZKb/IhkiJBVEvAf4lbcG/Q99Dl2hX4Hc04MVCipApvZ/9EoK6nR5SiL3J0Mi/mmEIkOt6225G1IpR21ZXgMV1GNTQxCcy+YwM+9XOJiHRatYkpndOb0SH56VCVZyysIjHnmwC2HCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F2qYE1QZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ps8nMa3D; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F2qYE1QZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ps8nMa3D"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E07351140198;
	Wed, 12 Mar 2025 14:26:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 12 Mar 2025 14:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741804014; x=1741890414; bh=ibTQqNelWG
	a1sNjy2WJEfuYIlFFFuTh+6my98NTvcQQ=; b=F2qYE1QZJkzfDNSNL0Uo+E/bjC
	2RdreasvmpkaUi8cl9TFfdKG6WfBb2mQeWuSxfaEEQZdgk8huSPT6VYBjK2CNe5J
	HcVsfk1NdntS2WIAuhPENrER9AZ5w7OH0Gf6mLaspqjjreW+EWImi+SrQYkzcyTz
	BCv1yQA1pdmulV7s5VwB/uexUkv5WP/HeyXaRe1H28ebdehS7vYpqqbfEVq57vk6
	KqEUHmCwFtk0neumtVidaM2v/sE4YtGoK4EVZbGfrx/BC/nxrxjuN1rC0lkTHosO
	aalHb16yRVo7HeHuBEiwU29PCSQTpPVV6sPqEewRPraMuqqHYgdQ/ajFHIhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741804014; x=1741890414; bh=ibTQqNelWGa1sNjy2WJEfuYIlFFFuTh+6my
	98NTvcQQ=; b=ps8nMa3DIRfdlZH/1IanM6maxKGxjJEulumEQPySsQMlm4max05
	rxPVx1VrGkHvNHWuQGq7po7lc4v/Eu6tFuDvHbzj518RRs1DCU6mjVZBRb0DSNk/
	+jLDQi1+U8mEzn0wvobgKOOvmXaENX1hmz1SOwfSifD/YYzSNglTDd1henaHAd6g
	iYhwW9R0yiQLm+HrrlA20v3DSvr5gY/An3m3dPs4Bf8SrwBfJRBZOA0gzcBJW9G3
	TcyCyS363tgdPsuyAwZ3wqLHVEtBH/n6P3uls+9rRmncC7/iCkkaLMRoz8vTEi0i
	LUxQ5HhMM4VDhC4h4c9XEsw4RqABCZC4hzQ==
X-ME-Sender: <xms:7tHRZ5y5ocEf1L6O-UDlun3p7QgMRJZ6g7vGNHyzI5rDY7RBLpiD9Q>
    <xme:7tHRZ5RLZGp7agQHXGJG_gDYh_0LUr_eWqrgKcrmLBleMWrbSrpm_ppSQt5KvoP7p
    7stRWb8Hy4_G0VjRQ>
X-ME-Received: <xmr:7tHRZzV-a2RQ3gnbR7Hs6yhlGyb_cwgEeIX9VXSkmfksXQYfEirnxnRtO5ajpvrSdpUzCIW2mjmgN_JEtwk4gn1m0xSyzBdEko3T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7tHRZ7jG5-jP9ZVtFoSI16JfJO8jDCSTw58WbtmJzKtlhscozASORw>
    <xmx:7tHRZ7CwHGX_2qY1EtpmHaiLHh2IuxKoqosY-QWaGP9rME3bzg8m8w>
    <xmx:7tHRZ0L3G9ejzNw_znYw6TqsnPnfSz2xDLtq7MY03n9mCG9-7cW7Ow>
    <xmx:7tHRZ6Akg1ZfhBoArsxbswEatKJbtzMUpuPWtjnlrvpTXoWHYLnEeg>
    <xmx:7tHRZ929oLOiS-Yi82v0zGJMKL-2qjVpNlFlW0Ti3S3nYXtLQdHRQppv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 14:26:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 4/6] pack-objects: generate cruft packs at most one
 object over threshold
In-Reply-To: <Z9Gmo2P3Fnt3JeOs@nand.local> (Taylor Blau's message of "Wed, 12
	Mar 2025 11:22:11 -0400")
References: <cover.1740680964.git.me@ttaylorr.com>
	<cover.1741648467.git.me@ttaylorr.com>
	<f2ca92245ada74825806b50f786aab312275fd85.1741648467.git.me@ttaylorr.com>
	<xmqqikof2pqp.fsf@gitster.g> <Z9Gmo2P3Fnt3JeOs@nand.local>
Date: Wed, 12 Mar 2025 11:26:53 -0700
Message-ID: <xmqqjz8uxfyq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

>> So would it be feasible to remember how 199MB cruft pack is lying in
>> the object store (i.e. earlier we packed as much as possible), and
>> add a logic that says "if there is nothing to expire out of this
>> one, do not attempt to repack---this is fine as-is"?
> .... So
> the majority of packs in this case should all be removed, and the small
> amount of cruft data remaining can be repacked into a small number of
> packs relatively quickly.

Given the above ...

> Suppose you have a 100MB cruft limit, and there are two cruft packs in
> the repository: one that is 99MB and another that is 1MB in size. Let's
> suppose further that if you combine these two packs, the resulting pack
> would be exactly 100MB in size.
>
> Today, repack will say, "I have two packs that sum together to be the
> value of --max-cruft-size", and mark them both to be removed (and
> replaced with the combined pack generated by pack-objects).

... yes, this logic to reach the above decision is exactly what I
said is broken.  Is there no way to fix that?

> But if the
> combined pack is exactly 100MB, then pack-objects will break the pack
> into two just before the 100MB limit, and we'll end up with the same two
> packs we started with.

If "the majority of packs should all be removed and remainder combined"
you stated earlier is true, then this case falls in a tiny minority
that we do not have to worry about, doesn't it?

> Ideally we would combine those packs into one that is at most one
> object's size larger than the threshold, and the steady state would be
> to avoid repacking it further.

I do not see why you can call that "Ideally".  Ideally, we would
combine those packs to create a pack (or two) without busting the
threshold, *and* avoid needress repacking.  Busting the given limit
should not be part of the definition of "ideal" solution.

> But in current Git we will keep repacking
> the two together, only to generate the same two packs we started with
> forever.

Yes.  That is because the logic that decides these packs need to be
broken and recombined is flawed.  Maybe it does not have sufficient
information to decide that it is no use to attempt combining them,
in which case leaving some more info to help the later invocation of
repack to tell that it would be useless to attempt combining these
packs when you do the initial repack would help, which was what I
suggested.  You've thought about the issue much longer than I did,
and would be able to come up with better ideas.
