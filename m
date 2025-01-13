Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D423315A
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757750; cv=none; b=qohCDgYg+w3jViX6e2H2ecHVOKdgTZA/p1ijokXrAdGuhfQ+rng8zONZ9eN7Zwo5iZf6mOu/vuF5H+Op2cF8TbnPbJZbVtySn0jUEqigt1mHKa3fQa5xbq7ft1SxZVGHbW4Q1KBdKH+qcsHDfUtKj6p+gB+F6nc+fSG/zpWn+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757750; c=relaxed/simple;
	bh=MyEp+X4qXI2W2tSm8DDp784vCoqOa6N7BqUSruDYES8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNgk8Ojm19uNG6IOX1MRyFeCXEeoo3SoBmQ6Xf+dekH8jVbO2oIyh+7AzecS6BFKl6gS7E0IGLtYKJJ/Svyl0KlU92crqdObfMuy8M+Hiz4VGsb/8KUfQCD0d+ZHPp1RXWOKgaCJWATt1dHbLqnmZ9CKIqP7+r4Q/MIDCrz3bO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hWsJ5aaA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sVCX8JyX; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hWsJ5aaA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sVCX8JyX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 053D21140091;
	Mon, 13 Jan 2025 03:42:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jan 2025 03:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736757747; x=1736844147; bh=o2T6d0DyP0
	blRel2W+iEKtSNxLQCo6qC9N1JSAbHekg=; b=hWsJ5aaAbFHPAij5NV/Vy73xer
	ebFcP3j9SXBOaNWcMBVmcxHJMu0q6oBhpyktjz0G/XQPETui0gmedd9z9MdFIoN/
	vI/wf6SWK98OHe1fULXmOSonBHUeBDNTGEnbVDbuLZqXwJN0b9M6nEWvVmtJyJea
	zuw2kAtfkeIOd2oa5J/srk/oeBVoLnAtpdTB8PqprBXZk6e27Ae/RN4jKitOczAJ
	7BFa48PmTSYk1g1Zvc7vHFl6lJbKINa+1Ed5zPTNcsSuw8w6ztHwf4GPfokXWIJY
	VA3l3s4fBsoj+sHJdkAqbCJKxi6TLTYRpFslrBvHXNMDQZVCihZ6uDfOvZ0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736757747; x=1736844147; bh=o2T6d0DyP0blRel2W+iEKtSNxLQCo6qC9N1
	JSAbHekg=; b=sVCX8JyX8Cb4KdCPQdWQmRo3vbuikzxxnrmflJ/FSyGzIT/GRhF
	dIirqsDSWvfVcfICrH3VO0B4+EVLPzT9iXx3awxxN/2BEhEGRfgs29rodzGVVelm
	q1Gmo9YsIcyO557gkr9TY1FCiTXeF8vlpHVDBApMG5wdpRWFbILDhvkDMUuVQ5RP
	w2lMy0rx4p6GELRVLm/zsWqtd/P33fRGtRi7FOHsJl/u9Ev7xsTo4OYbwUigFD7/
	ed/s7zTkdsDMTZM1zx9YesNNLX5kwFneuQOcqIX32+aWDa6Ry6hhdx0ftrH/Lscy
	MvG1gVDtr8a1B8exk8grzD6wJTU8WCByV5w==
X-ME-Sender: <xms:89GEZ0CtnWulInNWMNYH9-LHKV9i0KF1H8i9q9TlJmjEyAIw7F-W4g>
    <xme:89GEZ2hgwPrJrixaEkXbcKW__sePQvMO7y-ZS3Xw8b9hM6jkSfkTHvc73z8Q3MQaO
    s65KJupFnpFGYI0jA>
X-ME-Received: <xmr:89GEZ3nUxqE3FPTSV2-JQoxUNSJXo3_J_82dp9OibJ3iR347_Dr8wgN46rvEIB_tZhGo_cEo8ERu0-4JGg-sVNhrPqdGvfy9xXTjQ5WvPn3qofk_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehfedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhm
X-ME-Proxy: <xmx:89GEZ6yZ_JZckKD0kuxEqRs8LplPNhSN7vQAfPWrHbwuQJ5TkxYhUw>
    <xmx:89GEZ5S6cUrgScvti5S6xNj8YOYDa8JwPwtGlPA2FmfQUGcG45D2ZQ>
    <xmx:89GEZ1YFZLlo2vDheU9SA8SFh2KliXYklt23phjA8hx6NHiSOdN2tQ>
    <xmx:89GEZyQbR74hTWCc6pJedwhzeDmA3qAa6lAZfq_Ro4g-iS8xUTkULg>
    <xmx:89GEZ0cGutteWq0Nb-yS21lMugmI8gG4jDBJgChNspVuIFIk6IMd8Oon>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 03:42:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f9ab25e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 08:42:24 +0000 (UTC)
Date: Mon, 13 Jan 2025 09:42:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/8] compat/zlib: allow use of zlib-ng as backend
Message-ID: <Z4TR72Ee6gzhhYwX@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
 <Z4FBtuktzcayrb5T@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4FBtuktzcayrb5T@nand.local>

On Fri, Jan 10, 2025 at 10:50:14AM -0500, Taylor Blau wrote:
> On Fri, Jan 10, 2025 at 01:55:27PM +0100, Patrick Steinhardt wrote:
> > This patch series refactors how we wire up zlib in our project by
> > introducing a new "compat/zlib.h" header function. This header is then
> > later extended to patch over the differences between zlib and zlib-ng,
> > which is mostly just that zlib-ng has a `zng_` prefix for each of its
> > symbols. Like this, we can support both libraries directly, and a new
> > Meson build options allows users to pick whichever backend they like.
> 
> I'm very excited about the possibility of supporting zlib-ng. You
> mention that there are new Meson build options here, but I don't see any
> changes to the Makefile.
> 
> Can we build Git against zlib-ng out of the box with the Makefile? If
> so, that is great, and we should document how to build it with zlib
> versus zlib-ng when using the Makefile. If not, I am somewhat
> uncomfortable about exposing new build options and the features that
> they enable behind the new build system.

No, it doesn't work out of the box.

> I think that we should continue to evolve the two more or less in
> lockstep if/until we are ready to deprecate the Makefile.

Yeah, you're probably right. I was a bit annoyed when trying to figure
out how to name and document things in the Makefile, but that's not
really a good reason to punt on it. Doubly so because it's ultimately
quite easy to wire up.

Patrick
