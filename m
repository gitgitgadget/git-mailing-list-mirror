Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A48935F8AB
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527015; cv=none; b=rUB+Y2B3AVDeO1lEZpPH2YRzgcIPsPTAaMhqhAaNxgmCJSyYS3ayvuck70dwoYLqW4TlHd4Bgs1ZZlwPtFlzAdeqISO9350oFRYRzePfnYvyCMCwGIL3QcbbGufNAhkamViVnjh5m6gP4dOM8jAqXhrMnrKQ7D19bG4n9vbMxrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527015; c=relaxed/simple;
	bh=cvSA9Kzvq4XFJKAozMhx3r4GGVYDK9wxm+ZY8kQhsbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAFalwsG0ZFmybv1/WRQ4oBo8NTuUlRz2XSXjYlipdDsnNPYYt9owxJAOaP010wLzE2JmOsy5KxomfKLXHQVcZz8Oqu4rrEZomCOQOIuOOrrFBCuZePLkcMWh6Vi5KukIJgDjrVDvhV73HowQ2mJVh+tCtg5g/9gy73dZIIH6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O6rr0nPj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHm4WALj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O6rr0nPj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHm4WALj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2FF8140004E;
	Mon, 15 Jun 2026 08:36:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 15 Jun 2026 08:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781527011; x=1781613411; bh=cnXEBNdins
	yU3ClyNPCBjreVgAVUwD1CkqNudHGaXOo=; b=O6rr0nPjQ7lgD9Cwlk9rNqzzzC
	c1G8gkiJAhxtBwMX6t1tKt+Omdw+Q1ZTV0U1DKMSMrFPORrt6QovDuWxFOmJkBbb
	x+dqTEMWeqa0tm9moMHWOKS/MC0F/UlWAre4gQzV4siqNVJoFrnWxXkD7ILPuOOk
	N2UYk1Lsf1S1RuGX+Rvr9N0JPWvHKfkjCDphwD0dYLHpny9ss/xdVVHXZoQtuYzv
	J4DOUUrfo4222iJJGwvEn3zmSsfFScHXQEvGrXs+LFSJ0KuQxIfyJM5GvfzSmgGR
	r0rCv7r1VYwinVg8V8hzfRD/4smzBwGiHRmG7ckyp/de0CklJTy1jqjJTYug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781527011; x=1781613411; bh=cnXEBNdinsyU3ClyNPCBjreVgAVUwD1CkqN
	udHGaXOo=; b=CHm4WALjWQ08yeW5scnpasVlt7/A0rB8fPFJNSvLMqj+Yn0eQjj
	hT/svREmovWyEOp2I4XBzwyp0Wls2isXVZGC7uMgLGpAwc5NfDM/HRO0xHCfY3v6
	Q1iNW3gdGAY6o1e24xngK+2tA9x5lKnLlYaH7R5hiVlhuxkUE3Y+V7iZ+cWU9YK5
	s1jWUoOq1PEGjw+QTkTNjz7M/xPW0WhEZjTWVhokOxUTtf6MbXtPL9sk879psJJS
	7bsPUxI/QwNdbi5PyNeYJeECZVjis6cSH1kfNr5LwkPIspojlKk6oy/mswcm16Uz
	dJGb9mYII5tQjluN0m96+8+huTKZ8xEFnJw==
X-ME-Sender: <xms:4_Evap1-QkixBau7JN92VXQ2U9Syc1fvcUa8okbCvOraMu3KQPEb7Q>
    <xme:4_EvamGWYDmvySvu0MnkLvl_vzbE6AHSlcPtboR-mK_Cg2bZy0fItwY7h8Iujg6--
    AUhyGmkdR6crVc-Ze1OX82yKI6uxle8tkam7R3YZ2J9Gr-o9Zi7>
X-ME-Received: <xmr:4_Evangj8CgJf-AqjPwrY7gA4iZ2wmRjOcfq12kLCmO9Rr-iPsY0_xrwswtPlMA01R9Fa1jy-PMIkjfwqu1sOfmYAYkYT4xsWBPZNJL7cw>
X-ME-Proxy-Cause: dmFkZTFFznFP1fsS4E/kA+UGuqjc+ZXvzPSjdiHv+Fv/v/cyANUMsh0xLoa7wkbgPyRw16
    cComL070O0RDgpStA5qIrr4oD3uG/pwT2aF/KI5YNlJdCbynZKIaFjLL1ROJT8F+YpS5Id
    nl3HNST+pi8UnUaYkHobNprqO1LhftmPeoGIZfF+ytJ81ettvacL8jZeA7YNPNzDHmcKEV
    3H1sGpO/I8TuyDR0RZxsnMoUCClh9CUvXG2O5YczBWsolps9tU/HTY+QvvS0I5U+FJUZ4y
    ioIv4zZyC6EOstoVmGfzPupW+xaEa0QlEKO0rCB+nddpzP8je6F0d7RkyPp+OKjdHLbsFT
    Wa+HquK8sg3OHTfgsNZu1Vpbq30xuR7Qz7cKJcb3sxpKSe/7lkPgjMgEw0vIWHEZm6B75T
    8GhjWNVbwVOx1PMpiTpQjN7o9N+DFiWxTp8wFkmgB0GNUnE2SeWaqwqqkK1XJuAzp9STVw
    raZBTLyqoK4ftjVCxHG/h2SwLJsXGepRvq+2pJDe4xQMR1SevSahDeLMohMGMDIkKaABDv
    h9buh93GLPIHXrVvwAgqqcBXzqm1lyE0DnqQZhs4AcKE4ETGNE8RgLagTdAZWpoC2LWpZO
    /9b6tZnj7auVxMYIZ5l09Jqg0QwYjbvO9KwaWmJprhoERaQvXVrMo0OqSogg
X-ME-Proxy: <xmx:4_Evah8zlxioXqhhCMjK4_CWicDwLNPduFCaK75Kf9eLeuAmtUosvg>
    <xmx:4_EvauobqTzfrs8WfHB_SPdAc0PUsUskPWdHu2ZeqfykTDxX4TRg8g>
    <xmx:4_Evag8KZQh9xcze2_ZcWr7p3iHCKXqZxMFO8XXJ6BZu6DsPIBfmaw>
    <xmx:4_EvaiV1d31mmTt4kCpUHndh_dR7DG824K1dDp-GukMTnZbkkb0-jQ>
    <xmx:4_Evamlbb7Zm9tlBdr2wJkIIg9IE3WD7X1KO4cY6QOF3ceFCfHu-e9F2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 08:36:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26ce43c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 12:36:50 +0000 (UTC)
Date: Mon, 15 Jun 2026 14:36:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 9/9] refs: always use absolute paths for reference stores
Message-ID: <ai_x3wHDHXAGbIVX@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
 <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-9-56c864b01c43@pks.im>
 <CAOLa=ZR60bhH4z9ZoKTCn97QzautcihxPbTZ=_e0raMTjzajZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR60bhH4z9ZoKTCn97QzautcihxPbTZ=_e0raMTjzajZQ@mail.gmail.com>

On Fri, Jun 12, 2026 at 02:58:19AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Both the "files" and "reftable" backends use
> > `refs_compute_filesystem_location()` to figure out the location of both
> > the git and common directories. Depending on how the function is called
> > we may or may not return an absolute path.
> >
> > There isn't really a good reason to use relative paths though. Quite on
> > the contrary, because we sometimes use relative paths we are forced to
> > register for chdir(3p) notifications via `chdir_notify_reparent()`.
> >
> 
> With the previous changes added, we register via
> `chdir_notify_register()`
> 
> > Adapt the function to always return absolute paths. This results in a
> > user-visible change in behaviour where we now unconditionally print
> > absolute paths in error messages. But arguably, that change in behaviour
> > is acceptable and may even be good in cases where a Git command may end
> > up accessing references across multiple different repositories.
> >
> > Furthermore, drop the calls to `chdir_notify_reparent()`, which aren't
> > required anymore now that the paths are always absolute.
> >
> 
> Same here, should be `chdir_notify_register()`

Yes, will fix.

Patrick
