Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3C26158C
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760180284; cv=none; b=hSGhlWPWW7QJV+PCfUWEYhXKYnln35yiPZCHIWff4gwntQ1BKskz4hr6L35fOLC5ruSkfkpRMvSHdl+z0hQ/o18hft5/GbvGnEYZr9l20XS7TwZ9e2eOwcC1xQpYVwvpDN2egeuQ3rhfZea4707ZOyDeTYTui8MBUOlnKaRXggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760180284; c=relaxed/simple;
	bh=Q3fu5uiVKAshijApAvvXXVJyP3ZfcKm+/L/GbMt2u/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ7DknOwcX3Gh2nnRWGdrlPeDCxVV+dusvCmfcRA8F63AU8unP6H8v1y1Y42CYw2sm5pzetDd3PsxuzDz/4GSbjSef7j8fSPhKx4yqjKL3cO8COt1Ir4urhrPR1GRW0GAYGSMG9vlPYQBiWZtt4zrx05J4TdVceBBv4i3JENlHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X5xxruVn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rbAqzE7o; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X5xxruVn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rbAqzE7o"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E2B2DEC0246;
	Sat, 11 Oct 2025 06:57:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 11 Oct 2025 06:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760180275; x=1760266675; bh=Sxu1hTKY5v
	pZyEfTbL92TE4QKYgwwwcGXr/Wdfqs2as=; b=X5xxruVnnu1mQDm1fpX8YzEQOR
	enjAFcQAt2rU+reeUKg+BexPIp/jJ8OPh+q4wrDn14d88hv4s8TTK5o/nXPvjuwK
	1dqDRPeOAMKr5MAeucl4bS3Mq/T49+Gqrlap8vsL9rCgwQoESRkLEhPx82FnTHRK
	vHelMINXXQu0j3CsF2tlrJEK/t0Xh7JKRHu1RFroZb7miGngbW4UCY3/kaVib26F
	0qlmJ5PsH0WsjrbjWXpkTcV/lb52OyJdFdWwA6nQNsWcvM0LUTQL/f69l7KOv9i4
	Idad+2ZVUClfSKRCAiAmwWSmPX/lhZB1zKQn1dZr239zFmAVpXCh9KIZzY5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760180275; x=1760266675; bh=Sxu1hTKY5vpZyEfTbL92TE4QKYgwwwcGXr/
	Wdfqs2as=; b=rbAqzE7o6H1bvigw0zCQFgWvekdbr5mHEK8Cq0eS9qUHiYIghw3
	22dE7LgdBQbNht2o6UJkzK3GPtm+l8FSXOqixm5Ca5YpsggUjCLebJU9FiHy7fIl
	hwhI9NFw7lzRObfXxyIw5nckQpqQeJykxToiQJ9X2xUk64Ike9pZGZuyPswBa9eN
	W7+VMN33q5AEwE8alpHgkj5npDWw1vxPByGGM6xozjQ8DMi0IcD9IV7hfJiwy+/2
	YAkliFEmiWabhmyEQRLm+dw9kbxE9jo9BA0xTGGD/fao4UDHXOwMVEwSaKjEyZxb
	aJNnP3pKBLOigdSEBsxWgVLtFcT7kJdniDg==
X-ME-Sender: <xms:MzjqaONOA6CcLAu9LkSZ73D76jLVeAXK_9FPz6gFzSTwytxP2T_HRg>
    <xme:MzjqaC8oIIZxcrrWUaQYoqU9u8XWxw-vpcmP7n4TefEo-Lc2RHs6_ctauQ_zXAxzQ
    _dhH6-dWqIduLGHRfghCcsLm6t1vcaPXOspu8vo-i3HFXgaJRlCTA>
X-ME-Received: <xmr:MzjqaC5MaAEJhBba3GpdZUKWFfIGBM1cDLrU2tqrztlisrEQX6lvMxpSHmPh_MAEgXLN9icjBqUO1-zJThv-25rqSBuFwqonuXz51UzMZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MzjqaJ0MHJRgLgyJlIR6KKPXP1WrIEpQC89EKYfyDXbELJbMyhWR1w>
    <xmx:MzjqaJDqyPPUJYhFS7lCM93eE1yhKHwghL7sqd-ei6lvOh1WojdNOw>
    <xmx:MzjqaL0qoQkK67C-Ochmp48kUnIyvDFgnl2qxYGTScjm7ttRdudskw>
    <xmx:MzjqaDuz1Q0TCskbVYtPDaMmVekbW0TP0YIG9QYHKHkyud2ApTmyOQ>
    <xmx:MzjqaJmKULDZ14els_LBxIwiEO4tzGGavjIKmv_hhWZ0AILRtJjeCW0C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Oct 2025 06:57:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d6d03645 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sat, 11 Oct 2025 10:57:53 +0000 (UTC)
Date: Sat, 11 Oct 2025 12:57:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: fix broken jobs on Ubuntu 25.10 caused by switch to
 sudo-rs(1)
Message-ID: <aOo4ME3dNApd0xDL@pks.im>
References: <20251010-b4-pks-ci-ubuntu-sudo-rs-v1-1-88cc846d251c@pks.im>
 <xmqqzf9y905f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzf9y905f.fsf@gitster.g>

On Fri, Oct 10, 2025 at 09:44:44AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > @@ -65,6 +65,15 @@ ubuntu-*|i386/ubuntu-*|debian-*)
> >  		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config cargo \
> >  		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
> >  
> > +	# Starting with Ubuntu 25.10, sudo can now be provided via either
> > +	# sudo(1) or sudo-rs(1), with the latter being the default. The problem
> > +	# is that it does not support `--preserve-env` though, which we rely on
> > +	# in our CI. We thus revert back to the C implementation.
> > +	if test -f /etc/alternatives/sudo
> > +	then
> > +		sudo update-alternatives --set sudo /usr/bin/sudo.ws
> > +	fi
> 
> So at least shouldn't we be limiting ourselves to do this only when
> /usr/bin/sudo.ws exists?  Or do it in the nested case "$distro" that
> immediately follows this one to limit the effect only to Ubuntu
> (which may need to make this into a helper function that is called
> for both ubuntu-* and i386/ubuntu-* arms)?

No other distro has this sudo.ws / sudo-rs split at the current point in
time, and because of this they don't have /etc/alternatives/sudo,
either. So for now at least the condition should be sufficient, I think.

If we want to tighten this we could probably make this something like
"if test -f /etc/alternatives/sudo && test -f /usr/bin/sudo.ws". But to
be honest, I feel like all variants are somewhat brittle here and
there's scenarios where all of them will fail with upstream changes. So
I feel like the current version is good enough, but I'm happy to adjust
if you continue to feel otherwise.

Also, we don't have to do this for i386/ubuntu. Ubuntu has dropped 32
bit support, so it won't ever adopt this split. I have a patch series
pending that'll convert this CI job to instead use i386/debian, which
still continues to maintain 32 bit.

Thanks!

Patrick
