Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305F113CA95
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731913144; cv=none; b=T4RUrrrj+I3uJW3pEEOWvbyZq4LtPFzjcY2iMQ3Zcjk/YiUWzNssrDwy1C1CZmn0d8TfFKPAkGV7JetRSQE4EhvUqFDuq0eei2QsK2SJR/eHetUJfYF7k9GHJIQTe2tMY7Di9SrVyDWffWOa3sJDagSAXWXhbhGMGy+fxdQY6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731913144; c=relaxed/simple;
	bh=k/U1aOaiaWzLWiPCROHDzhOxaooXrSH6J5931VGt8zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGFYqlMK2CEsldxs3p22OSjwxZsdXwlfAMCuThtBbHm9qWfyaEsS9A7qjzXgIqFO1Xg8oBmcNjztyjAKwJJwQGZ3GXDAVQThnkyzt9Ik/TEe3oaQwolfmfTNHTBdczaj4bF/0MFUxh8jN0V42uqOnVufIVrW2fS3xrSvxWh+ycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sFQ5gy1i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N/91YLRt; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sFQ5gy1i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N/91YLRt"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 1525F114011A;
	Mon, 18 Nov 2024 01:59:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 18 Nov 2024 01:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731913140;
	 x=1731999540; bh=jrepZy0E3TyRSpC8SYSnv6FZUlARD9vFieju1pyK5VA=; b=
	sFQ5gy1iTyDi3aAWHTLpK5u3GkbYnQCkvSdHyS3oe4I/Ma/DR4fgCz3WMTOb2z29
	n6U9xbNQEak5F/QRnvRRlu1K9+a+TNn249E6fp5ir/aAF20Ha3QLjaWYg5saxbX5
	sFH0jc7/5VrCYPjb2GVnYtewfImBF4Pp5OiD7qm3XNZCE5GvYiqbeTZdaS2k/7ud
	pz8N8TDicz7+WqfUlvbbPePQWmojTZxIYwVVjzNKZw2hMFsnVujcEbpn75biLz5K
	rG9mAzRSTJrP5C0+AfAv2cz2weB++ApA8X63TS8HLQeF5mi3XKgl0aopU2/eVRkk
	HFoesbZqbBz6dD6lJnX7Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731913140; x=
	1731999540; bh=jrepZy0E3TyRSpC8SYSnv6FZUlARD9vFieju1pyK5VA=; b=N
	/91YLRtWceon7dFMi2tUa8wQNGObXDNR3la2o+O3IbpLy9ar+YCU3xQ3hgu63Oga
	AmhsBaZoMQGg4csnd4xp//2O/crxKD9Xh7v1nKN9dKdjl0fSrxNPpgOhdixtWAdE
	BcVk6caiNXO3zCI5HRtqbPt/18dk4OUztqzdsq3R5VNMCRAyBADk+uK8DmKaFgpq
	/PGcJRK5GXKoKymu/YtCgDtXqKZuvSu/ra2X+BH67hwnxN6Qh+otmV6ycNynmmp9
	3LlSbtkfXVR+sNwH2h5UzgO9LBosbHyCfb639H3wsdLV/zlUR9RNSj0u0agQYG9Y
	cLkxfHhKJIMXOFvi5zIew==
X-ME-Sender: <xms:tOU6Z0rauX9etN-hiwPG6zxOmS5X1gJ5hXO8cHVfdEA9yE3I5NNL0g>
    <xme:tOU6Z6qJbgzYo80yDkqq5rjPjZvwY8lCwTeAjPqRNodq2dKsOdHWXAn-sgEzB4wK0
    OTRMxZxqSgbHNW6Ng>
X-ME-Received: <xmr:tOU6Z5Ox1-ZljKCjfPz4SyS8eL4W4EUtpp7zYlUeZjFdzWc1AIzuNdt_VKTkVkUhAe0kj5Gms_Nu-fuNH2KH_o8SOF4IHHmeUO6et-8lVaccCEt_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepvghmrhgrshhssehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:tOU6Z74ZyIX_TlBqnqLlSApxBEzN04RnzkhjWxYVRj0y5mHWAcgyBg>
    <xmx:tOU6Zz5uv3hzMCTamw-44oWoTcYxWls3dak9O59rwkmW7afIkd7vuA>
    <xmx:tOU6Z7hAnEydbsrX1BY6RH0G0RW13bQfiHyxs_AP0vUIK_OrSAAGOQ>
    <xmx:tOU6Z95v6qyw9Fk05vkzRyk8qQ1FgXKMDsmSdlMR8Q4MRe2He9uM5Q>
    <xmx:tOU6Zwtm2jah3ioWCoRyfopEGPnNgitgya52JjVr5TgQHUsmoT3UXm3v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 01:58:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ee500e80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 06:58:10 +0000 (UTC)
Date: Mon, 18 Nov 2024 07:58:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org, emrass@google.com, me@ttaylorr.com,
	stolee@gmail.com, Josh Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 1/1] maintenance: separate parallelism safe and
 unsafe tasks
Message-ID: <Zzrlou9WbylWD1R9@pks.im>
References: <20241108173112.1240584-1-calvinwan@google.com>
 <20241108173112.1240584-2-calvinwan@google.com>
 <ZzGtD4Jz9Wj6n0zH@pks.im>
 <CAFySSZCzxfqpMWH5ORv8fYb7f5WU3Fc2N99fW33wD9JOcYVrVA@mail.gmail.com>
 <ZzL1jy3plVeld_3m@pks.im>
 <CAFySSZBioOrfk5O7oni3LRLWasFo6DsuyW7icDDVkiUxq4fNOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFySSZBioOrfk5O7oni3LRLWasFo6DsuyW7icDDVkiUxq4fNOQ@mail.gmail.com>

On Fri, Nov 15, 2024 at 12:13:24PM -0800, Calvin Wan wrote:
> On Mon, Nov 11, 2024 at 10:29 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Mon, Nov 11, 2024 at 10:06:10AM -0800, Calvin Wan wrote:
> > > On Sun, Nov 10, 2024 at 11:07 PM Patrick Steinhardt <ps@pks.im> wrote:
> > > >
> > > > Hm. I wonder whether we really want to expose additional tasks to
> > > > address the issue, which feels like we're leaking implementation details
> > > > to our users. Would it maybe be preferable to instead introduce a new
> > > > optional callback function for every task that handles the pre-detach
> > > > logic?
> > >
> > > This does sound like a good idea. However, would there be any issue
> > > with running all pre-detach logic before running post-detach logic?
> > > I'm thinking if pre-detach logic from a different function could
> > > affect post-detach logic from another. If not, I do agree this would
> > > be the best solution going forward.
> >
> > Sure, in theory these can interact with each other. But is that any
> > different when you represent this with tasks instead? The conflict would
> > still exist there. It's also not any different to how things work right
> > now: the "gc" task will impact the "repack" task, so configuring them
> > both at the same time does not really make much sense.
> 
> No you are correct that this is no different than how these tasks are
> currently run. However, I have just received some numbers that the
> repack, when gc'ing in Android, is the longest operation so even if we
> were able to run repack first in the foreground, ultimately it
> wouldn't save a significant amount of time compared to running gc
> entirely in the foreground. I think for now it makes sense to hold off
> on rerolling this series (at least in the form of auto
> backgrounding/foregrounding tasks) since the purported benefits
> currently aren't worth the churn. Thanks again for the comments on
> this series

Wait, I think I'm missing something. Why should the repack run in the
foreground? Based on your report the only thing that'd have to run in
the foreground are tasks that lock refs, so `git pack-refs` and `git
reflog expire`.

Patrick
