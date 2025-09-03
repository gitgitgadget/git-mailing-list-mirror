Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64973009F1
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900109; cv=none; b=UF3jKKR138ac1EgQ2UOznurfNfBLRKCZyjzlbeU1Hv2QKfjCZyUOsiJZxxbo/XgTdIbKR3GaF7mZ75DhKsb3Txtj4SfzhBggE6wv9CURBx5hN1KqhGhAFBkXHlEvptHnbYQdU0+/HUP+hOeibAkg7Z5AmY5cD9O7mRtV8wmr0N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900109; c=relaxed/simple;
	bh=2uYC7SPyAgkzh1GkWrJxHFADzehTvC7XsFnqMHfpwcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3Wk+pretj85Ed3UqvWr/9cRfnv4ry341VzmXwJrOmczfY/JwZ175np2UF7Bafp1EZDT280kXZzDEA13DUnTFHQAm7c7Z0H2J7OF3AEtBYhWglIh9lDa2Ap/ypZqBKJ16MCkXOjATRTay4aHfTQv71vmgaL57PRh2oUZYvO3IuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UneuwjL3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j5gWa+7S; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UneuwjL3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j5gWa+7S"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 042081400388;
	Wed,  3 Sep 2025 07:48:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 03 Sep 2025 07:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756900104; x=1756986504; bh=eDerO0bXH/
	9Yme14tb4wt8Umkvycy0jskx9I9XbeyYw=; b=UneuwjL3gF9EZQu+u35XiOHrXb
	V7jnKjmjuFk02D2n9LdQEh23yTxbbhIXFgbSdREW6tCUfLBS82foqUn/DaYbjCJd
	x2DQCJI/8e6andeEnBzbTlyziXLRY6wc/vld4wdGP8VkRFbkJcz6Xr7LB6sqm1ut
	MpiJCwJFV65bXo6JgX5XJVhvrF5f+5aLzJmkRed7A6EkvDUIxs9ZsxKMzWjuS/fF
	KrL3slUWURXqdr02OtL8EwP0IIidJVDSjH6DAQ7Qyd2BxMiChHwFQ9uG9jIypyYe
	G3TD1XFzfGb0NfvVQxk5XUgGCcTy274tX47ah5s3Jbmx/4lGxA9dBmU6BpwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756900104; x=1756986504; bh=eDerO0bXH/9Yme14tb4wt8Umkvycy0jskx9
	I9XbeyYw=; b=j5gWa+7SZ2YCPwMy1bI7lN6DJvU7SOIvXi13O+v4QmTAffl+YRI
	ahUl1+dXprdq74VPS1mK7igxqFYq4GRyTAj6iwGubXldeRjXUOhM+13Y1PALIDk8
	ozpLQhbObGr1ywZiyRENUzZzySqpN6aaro0Wq/EaTXQWLGhZ5nMwZAIWq60B2BV8
	YpbdHP3rItiX3b2g3kRYwVI/Pky2UHNWMmhWAy0r7My9hkac89U0l1EBso6tSBkD
	QtfgqfSWmasvY8ofSgvNRT+7QP/0ysz5jEuUguP00kV+Fzg3+bLXVSd9T6fRyIOy
	DcW7JHm5Dn79vImL+FopUjmPv3POKMziPIg==
X-ME-Sender: <xms:CCu4aAEhwnucoLQP6uHXkRGnt0MoeVgw7Zt_H6hQ97pL9TRi6iD09g>
    <xme:CCu4aE2GTQnXbYLMNwn5nIkZv3efiEt89e3fuVP-d7AgkNbnDT1x0g92a02va244c
    1iPY6cplUByfymXvQ>
X-ME-Received: <xmr:CCu4aAmHSLfwZiKBYYW0upwQ-WN7piHLR3VEKz2ZMpGkfu9pbGm7rPoysH_FHJNJ7V6rsQlh3D0aRgpnOL9vXzK9mmkbnXLfHGuvedI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeftdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjohgvrdgurhgvfiesihhnuggvgigvgigthhgrnhhgvgdrtghomhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:CCu4aM9RlbKtQOFttGDwXRqpV_LR64LygRgkwya2_z407F20YJ0zpQ>
    <xmx:CCu4aNoo5CE4lqa3oQQhGu0cJ_wTBZTScgf7h1vcDZUs6jo5943qzg>
    <xmx:CCu4aNmICnY6Q3MBZ7QDJAA31V3xQye7B4eQ_tNEWfUM6tqWGwzaew>
    <xmx:CCu4aMh77AbiehQzY13udZNYARTf7SaNNQ93oz6w21A18ssbPtoZLA>
    <xmx:CCu4aOp9LRbL5g6-0EUX0tr5pLwabrnjtFTy-FLfCdZDxosmuQH_JVvZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 07:48:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e1f5d73a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 11:48:22 +0000 (UTC)
Date: Wed, 3 Sep 2025 13:48:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net,
	gitster@pobox.com
Subject: Re: [PATCH 1/2] refs/files: use correct error type when locking fails
Message-ID: <aLgrAs1J2k47uH6v@pks.im>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-1-35e69bbb507d@gmail.com>
 <aLfw8xiys53A-azC@pks.im>
 <CAOLa=ZTxZXWuFxaTWXmVpfoFjao_F0Mcu469aKQRu5fNNB0KEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTxZXWuFxaTWXmVpfoFjao_F0Mcu469aKQRu5fNNB0KEA@mail.gmail.com>

On Wed, Sep 03, 2025 at 03:38:04AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Tue, Sep 02, 2025 at 10:34:25AM +0200, Karthik Nayak wrote:
> >> diff --git a/builtin/fetch.c b/builtin/fetch.c
> >> index 24645c4653..9563abbe12 100644
> >> --- a/builtin/fetch.c
> >> +++ b/builtin/fetch.c
> >> @@ -1657,11 +1658,25 @@ static void ref_transaction_rejection_handler(const char *refname,
> >>  {
> >>  	struct ref_rejection_data *data = cb_data;
> >>
> >> -	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
> >> +	if (err == REF_TRANSACTION_ERROR_CREATE_EXISTS && ignore_case &&
> >> +	    !data->case_sensitive_msg_shown) {
> >> +		error(_("You're on a case-insensitive filesystem, and the remote you are\n"
> >> +			"trying to fetch from has references that only differ in casing. It\n"
> >> +			"is impossible to store such references with the 'files' backend. You\n"
> >> +			"can either accept this as-is, in which case you won't be able to\n"
> >> +			"store all remote references on disk. Or you can alternatively\n"
> >> +			"migrate your repository to use the 'reftable' backend with the\n"
> >> +			"following command:\n\n    git refs migrate --ref-format=reftable\n\n"
> >> +			"Please keep in mind that not all implementations of Git support this\n"
> >> +			"new format yet. So if you use tools other than Git to access this\n"
> >> +			"repository it may not be an option to migrate to reftables.\n"));
> >
> > This reads familiar :)
> >
> 
> Which I failed to attribute to you, sorry for missing that, will add in
> a 'Helped-by'.

No worries, I didn't mind it at all.

Patrick
