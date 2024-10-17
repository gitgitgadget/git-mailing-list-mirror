Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E696B259C
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 05:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729141408; cv=none; b=EmTW48DoKj+jqJgTlBIMPSrKepy8K0iXrN6LEebcWf+uwJJa3JiF2RMFlNUXjMEs+3ekaECmvqg6c29V07GfElIFTd2VIMYBBqGgry6vLIv/xsGdyqrLNVQpNaLSkx2IIn7gM0YEdo6fkltAGIr/1yXmwNu0Yu5hW46r9pKG8T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729141408; c=relaxed/simple;
	bh=OBGLOB/enp2SYWG5oBGZJUq+/d01yFJtqtnfTpa4s2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj3wpInRPqvPUhJYnumyGfj0T1nddzANcrk712EEn8LYfFPmiQk8IkDLW8MZejPnzNpJs+2ssll6AgLN2B4K3wluYgvw3DLOggAenEUfbTPOkk18KxRXGynykTn/BowunUhpRbLgPxsuZ6BeafenWSTyupYGF/ZYVsJSbilebxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ey5zdrVN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OnfiOfd6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ey5zdrVN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OnfiOfd6"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB49D1140159;
	Thu, 17 Oct 2024 01:03:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 17 Oct 2024 01:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729141404; x=1729227804; bh=zipHggQWBE
	RQCyYrGjgURILEpAJy99O8E3stzIWYIBw=; b=ey5zdrVNUm7eob2/1JUo1SO7TV
	WB0qgHk8KtHn+3JXpIcSKlrv/tlko+ZHJo/Z9VFkU72va79ZZ43QZwrHxILT5aBz
	JubZ8aks7W5gvE0yf37OEraCPvkY9v7CrVV/tzz5swuOKQNirolWJ6kRtiwWjXwB
	U2HHcrwIym+fQ+D1jbbGOQGaiSWWCei1mQGUc8/uvIoIX1+fIJCjhnrvKp/qrY6z
	jJkvAJfafTN5mvJlBWwaIQy/6DySPYA6g3VjIcJXsmqT2uOpp9TIK2xc9JerY4Jt
	dk+7DgVV+wHSU/aDEKP/0yzVYZPDSWMIdl76PjUCTfYXysV09cxV/zLuSulw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729141404; x=1729227804; bh=zipHggQWBERQCyYrGjgURILEpAJy
	99O8E3stzIWYIBw=; b=OnfiOfd6ADD+UvxjfyvtMbnBEjPk5ssAE5+S2g3vsNU0
	l2v5BkZZy3eamgZoL76MSco93zIYEJDu5OFFIFj+Q5D1f3XaORQqk2FnKWmFeiR8
	upC6aqktmOBDVxeMQ+jB3EJ5XnLIZqBR9P2jqaAVYEchyps7JclQFZmM7PW0qYy8
	GAv6JRHVbokVF9pmHqraK0xMKONOaB6SUIw2BSlqpIL5DvTD/r/x7/62O0jXYlq8
	1r8+e2dz27yaDj8WpdU2nRa5LqWrdH9EDOayAc2LhecVja9eQHTdfXCX7xE/fOwB
	RMDGwGRhEulR0sNj2gQIyGIqzDpaIZg6RhbmfPps2Q==
X-ME-Sender: <xms:nJoQZ5V01WECKvnXoVpohhoVu6T32q1J51_-N0uAcK5dJtfAAmj1bg>
    <xme:nJoQZ5md8mVTnqb-ti4Z_kYer-laSGLUjG2Krong-2z82ENQrI-p06yG_04SkjUpi
    XIQt6vdzjzccNLO8g>
X-ME-Received: <xmr:nJoQZ1boUFBaV3lUssGjyIcuYoKESCSiezOndkpK6fPXHspfrYwomU2rOTXVKLW9pgbvKrJSvEBtIjSZYDMJJS1sr_2UUQBi7MLB6GDTbP1ezw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffke
    dujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehfihhvvgdvfedutddtfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:nJoQZ8WcW-vQaSDNxUfFu5wSb8g5efizk5QzZ9ZyG3rv8H8adA4Dgw>
    <xmx:nJoQZzmCuhwFj08hzm7D8k2LK_3is1sKp7vlblKRsif0taujZmfbIg>
    <xmx:nJoQZ5dE28e2fAFuZPfLBQfXJTxi2gDN5nrRyhO-oLb1e-3dAcq91g>
    <xmx:nJoQZ9FvzbejM95xwHpFqiqofJepUm4aj5vmWHf9naRkuqeTXcJrnQ>
    <xmx:nJoQZxgGWYtasv0BPq_-4k3cGdgWZob3YdkectCQ5gBGD8NyTQfTuWEo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 01:03:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f7395fea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 05:02:03 +0000 (UTC)
Date: Thu, 17 Oct 2024 07:03:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] repository: move git_*_encoding configs to repo scope
Message-ID: <ZxCakURyWqXPyacj@pks.im>
References: <20241015144935.4059-1-five231003@gmail.com>
 <20241015144935.4059-2-five231003@gmail.com>
 <Zw6SsUyZ0oA0XqMK@ArchLinux>
 <Zw9Z_xcHKcjKVUB4@pks.im>
 <Zw/22XHvtOw6IEHe@five231003>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw/22XHvtOw6IEHe@five231003>

On Wed, Oct 16, 2024 at 10:54:41PM +0530, Kousik Sanagavarapu wrote:
> On Wed, Oct 16, 2024 at 08:15:37AM +0200, Patrick Steinhardt wrote:
> > I guess it would be nice to have a set of convenice functions in our
> > config code that know to handle the case where the passed-in repository
> > is `NULL`. If so, they'd only parse the global- and system-level config.
> > If it is set, it would parse all three of them.
> > 
> > I also kind of agree that it should likely not be put into the `struct
> > repository` in that case. I think where exactly to put things will
> > always depend on the current usecase. I bet that in most cases, we
> > should be able to get away with not storing the value anywhere global at
> > all, which would be the best solution in my opinion:
> > 
> >   - It can either be stored on the stack if we don't have to pass it
> >     around everywhere.
> > 
> >   - It can be passed around in a specific structure if we pass the value
> >     within in a certain subsystem, only.
> > 
> >   - Or we can parse it on an as-needed basis if it happens deep down in
> >     the calling stack when it's used essentially everwhere.
> > 
> > Now there will be situations where we used to store things globally as a
> > caching mechanism, and not caching it may have performance impacts. But
> > I guess that most cases do not fall into this category.
> 
> I like the idea of dynamically fetching the value of the config and not
> caching it somewhere - although in this particular case, ie the
> *_encoding configs I'm guessing it would be better that we cache these
> configs.
> 
> Now the important question is where.  In point 2, you mention about
> having a separate structure - do you mean for all those configs which
> would not be a part of "struct repository"?  Of course in their
> respective subsystems.

I was mostly referring to configs that apply to a specific subsystem. So
if it is used in that subsystem only, then it likely is a good idea to
put the cached value into a structure that gets passed around. Many
subsystems already do have such a structure, so it's only a matter of
reading the value once at the entry point into the subsystem.

> Coming to point 3, won't we still have to store it somewhere when we do
> need it deep down the calling stack where it is used everywhere, since
> we need to pass it around?

I was mostly referring to the case where it's only used by a single
function deep down in the calling stack. So here it could just be parsed
ad-hoc.

In the end we'll probably have to decide on a case by case basis what's
best.

Patrick
