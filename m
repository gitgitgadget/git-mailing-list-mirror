Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758B2517AA
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547030; cv=none; b=cQwkd4+IKqBEqIV0shCoWMWCd677Oh9zQIRZDEtDqu6ra/OsPOsanfc0wEc6BuSwqXHt0oq6yqFSzrhPqABYgzyrAJBR/6uvlvqxGk1NU1hpwCL8s98H64/cU4mOt5OTF6PAGkIWkDGlDcBdOADH5S0GZa3u44EIPvCa7nxKHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547030; c=relaxed/simple;
	bh=pHuuUxozgbcUUKU0Cs3q2aacNQOr4NIJ/1A0Cn7r0UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xwocp3NxOCXKNHhZsdARMq84xcd1YQRRoruFRiFHIeFFDWUSFif1k02FVxQIJQUtqYRk1XNTdxJceDDABQow3Qw35/5Vo7C+zgTv8pRz8CSUkicYhKJnMpxryL13pcd2VLpkTQ3xWj2m0hv6IhKNOc1gIRVnJpOBZwRlXlbU+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cq+X2TbO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZNa+aJA4; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cq+X2TbO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZNa+aJA4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D42557A00EB;
	Fri, 16 Jan 2026 02:03:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 16 Jan 2026 02:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768547028; x=1768633428; bh=ESHyP9BYaU
	0iCr0En2jlXlIcEFU/w87sCKTCNovDJTw=; b=Cq+X2TbOtTi6awFDFdyUcDglXn
	qcuLxqMOvbR7FOeQAD6qqeDKdZLPy9RqpfH6UkGxI3vTTKwAYZOlWxg/sGuXVmrq
	qKOjA97pnmecIIb9emb0Bf4MwHsacJCEEHOHtbaOqXTZMB2RUFezAGFDJ66Lk+PY
	T9OzhEO9sGa3/nk8/XnyYUUZsTZ/DbUw9++Ga4/LX4hns0doHQItFGudzdl+kdC9
	sznHtQl+WpMMVfsmDaRWBYizDkRTNBaCu6zSq4Rxk7xGxEAT2CYz1Hgh4dn94JQG
	LhvCoVZEeYXp1mmTmGtokQdUlXex0Jr4jE5hI+7AfjByNdlRkIas4FUdEZQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768547028; x=1768633428; bh=ESHyP9BYaU0iCr0En2jlXlIcEFU/w87sCKT
	CNovDJTw=; b=ZNa+aJA4MgAHhbAAFk27puKW9L2luXr99f6TEXxmjpRNqsS5OwF
	t3XUN9ComINUzmDesM5h3egwfQbAKBN1NeB1y6x56TLtHsMm/sfmE7scVK10Lh1R
	P6gk2flczc/Jqph0y+zQkTEESFdRg+BSkDvL1LHAvbIaMEvzj2LTJnPa35ewFXmc
	5Bc4+X+CrUMCPvuttCcJRlmjlCA4kUOfSdJ19rBI+4IzDsx5B2yqXNoEmcuTlE5l
	OXHuLx7k+XCG/oTfsJY/w8hC+Hhp1gyuzrhAEQ8PsWjDWgfESGpOuoAK+Ubi5QJl
	YzjQ+Uylp6EwRy9TpOGt5ULqJjiz9rL3FZQ==
X-ME-Sender: <xms:1OJpaYh7P_i2XgKxRaPJ-FqE9Z16fID2W-oLuN0H4cJEAjpYSjrpxw>
    <xme:1OJpaXBo92UWtQpW0a3gqxNQCAO70XUJBulveYXYZd0lxBdk8WmNCzl_TtZDVzu2J
    BUUwH1BxHsnYegDy3R5XhQJTJm5BNALAfuXm0v4812-X14mWlnb-kE>
X-ME-Received: <xmr:1OJpadsNtU3cQE97Xusry5TLvbdDPRE27U0CwWh9acgqKutBK4jLyjY-TuhptArtuB4c0Eq5btVLXI8YGKxqxblzdI3fMTMi_OZpCjLUXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:1OJpaUbxR5iSqm5CgX6pAgJNHpmRVqkSaVhSNubJvloXWtOgFePThA>
    <xmx:1OJpaYUctYMcQQ5JRjRZxAQqJ-UtZY5nnYgOoKhHUiIOgyUQITIj9Q>
    <xmx:1OJpaQ6O8AkY8B8fD4_JoL9c3VVk-T-879DkB8NMds3_Do23wwXPXQ>
    <xmx:1OJpabjCiU9VL2dC9ApzvQ9RGUyz-E3jSWyy6kjK9gQl3PwVxwcwMA>
    <xmx:1OJpaQTvBPrSG26da6gjmCoLkWJ7IA6eU-unTij-QgKl0dE1q9e2X1-5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 02:03:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08c94c9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Jan 2026 07:03:47 +0000 (UTC)
Date: Fri, 16 Jan 2026 08:03:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/14] treewide: drop uses of
 `for_each_{loose,packed}_object()`
Message-ID: <aWniz5_-Q6o0tJXQ@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-10-5418a91d5d99@pks.im>
 <aWlemFAu9HwKgpOe@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWlemFAu9HwKgpOe@denethor>

On Thu, Jan 15, 2026 at 03:44:50PM -0600, Justin Tobler wrote:
> On 26/01/15 12:04PM, Patrick Steinhardt wrote:
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 6964a5a52c..7d16fbc1b8 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -861,8 +871,14 @@ static void batch_each_object(struct batch_options *opt,
> >  						&payload, flags);
> >  		}
> >  	} else {
> > -		for_each_packed_object(the_repository, batch_one_object_packed,
> > -				       &payload, flags);
> > +		struct object_info oi = { 0 };
> > +
> > +		for (source = the_repository->objects->sources; source; source = source->next) {
> > +			int ret = packfile_store_for_each_object(source->packfiles, &oi,
> > +								 batch_one_object_oi, &payload, flags);
> > +			if (ret)
> > +				break;
> > +		}
> 
> Huh, I was a bit surprised to see that we are still handling object
> iteration in a backend specific banner here. I would assume ideally we
> would want to transparently iterate across objects wherever possible. I
> assume the reason here has something to do with how iteration is handled
> with bitmaps?

Exactly. I was pondering a bit over whether or not I should invest a bit
more time to also make this part here generic. But I felt like the patch
series was already long enough, so I decided to not pursue this for now.

It's certainly something to iterate on in the future though.

Patrick
