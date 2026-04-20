Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3205215746F
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667294; cv=none; b=r1udz6aSOxWsKc/j4NgwcE4HBd9j8UqPafj8BBXEnX7uq47iAlg4C8C8y8q1yuZ21fXV1HSYOL4LcMXaWAZMooXabTL8q0MbZ/HiN/TgjfajqNezL5OID1+K4LDNJ01NbZfsxDgtRHGHMlhr5mjQz/i0zOvPk4IDFsLTZdfb+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667294; c=relaxed/simple;
	bh=r5Rs+7GO2IHFwPwiecDZ3+OTPqa+uzj07OIDX0C9LGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laH8Twb2r1Ny8NgkSQhEtMq5GVtvuO6fPYhCMabcmpijRSC7lgmJXNRj/ABEKG0wYq/58VIy90cLfsuL/yW5ftdShmVec+/j4DNhFyWMVC+hCRR6UXyOmwEKCDJYBF6+t66YL/rSkDIEMVt0rPdlqSNQJ2ONkaVuklxiLCb0X9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zJ9LQllF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r3Kt66zy; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zJ9LQllF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r3Kt66zy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6EE41EC0012;
	Mon, 20 Apr 2026 02:41:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 20 Apr 2026 02:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776667292; x=1776753692; bh=Lfcv7MQE+V
	0DmH4RoqTzWImAohsiYJmxn6YpdWCfqj4=; b=zJ9LQllF1P2NJqzxjMYjMLOddJ
	8Iezgy7JjjCKdRBB3CO1+TX9kd5cEQA/5dKSV9J+AfQnb/ixZzCBvI6AO4LhXNl3
	BT0yh+r1XMO1MhA5fz0ztv5SGjz1JcLgJ3/NH/HAyrkOH8tJKiIbcY2d9kAy7APn
	jCZYduyNrqHJDEA4OJEwfpFiclpbDQ5AhRBf49oq13sqTtEp1AOUk7sPEQoAjOn6
	RIfwVTs+dRRPqwn20cJrJukC2T44zySY7bEE2JoW7MiRn4ca99XRg2pQrXFT8VgG
	JkEIhVBgFY5Vt17g9enAmDzQd5eMJwslIxgklQHRZac9cgsn4gFFX2duGCow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776667292; x=1776753692; bh=Lfcv7MQE+V0DmH4RoqTzWImAohsiYJmxn6Y
	pdWCfqj4=; b=r3Kt66zy4QBiiZRGdr2oSi7vXoFvjt7C6w0/uAonKy1L19JVWc2
	izvHQL+RJKjvIDNmFWEo/IQvCvm2iq0opTmYfL2GPrivpHA1M7CgSzcM9fLk3I7T
	50bmw974X1AUBG+cBP/1/bnC8NRm2KceqwziNFd/vhSmlqTr4p5gWGPY0xby42Fp
	JvEUQEr84r8E5V4CMT9nDmtODdS87BX0rYmjm46qleVupj9SIYkDE2a0iytlaA+/
	gRKhkF8ZBYqXbqZ8GQGf1y18ykmZEIDnEgAUiqQe4QowTHg4qi2rjYOnF87IA5og
	pXeG16FNeL2cphJ++Yk9QsZcNjwxsU6QMLw==
X-ME-Sender: <xms:nMrlaaU-ial1Ja6UcimrZomat60FWhsn0yrKTOzpwwY0qqXVlXS5dA>
    <xme:nMrlaUgzrnulbB2sVKfRUBY-V19EOSNrXTjzDhWwoy_L1DP_sWD9S_MfMTGwih2Ga
    djyUgC23mIHuDLq9NxcJV6p_olFg3wwzCB57YvRNitWp_f5zylLjg>
X-ME-Received: <xmr:nMrlaV8DZcuSrKO3xr4bmAfrQxZAQPv4naDQn71CDcjS-Ap8Y8XO1A0370XDVf4zua4mMCZ60841Xg9VKlWyP2d2ovJ0KGFZp7iOSNJBnJL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:nMrlaeC0NXY-7xem7zcIaJI8FO27ZMk5pF-5BBcmHYW643Rhl7vybw>
    <xmx:nMrlaSL2c2-JabFqUujrwc3e1RYwKip3BIqPg0ug5fKwm66dT9KbOw>
    <xmx:nMrlaRlQrLj5yXoSdYh0HWAxtjGLp1dkklzVdqoQ5tdXPeIGv2k2rQ>
    <xmx:nMrlaQGZ3ipxE4oOnXtZV1Y5jlZSznhMztCF8jwSXRbXxOkRooAndw>
    <xmx:nMrlaWaKY8_4GDOhfW9LTOApInNyVw8kkNVlD8vIg047T19tbPFHZqxp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 02:41:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1083de44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 06:41:30 +0000 (UTC)
Date: Mon, 20 Apr 2026 08:41:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <aeXKl0tUDvlkoHhA@pks.im>
References: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
 <ef096525-d2d8-47d4-be8f-75236ceeb3c6@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef096525-d2d8-47d4-be8f-75236ceeb3c6@gmail.com>

On Sun, Apr 19, 2026 at 03:11:54PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 16/04/2026 14:24, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this small patch series follows up on a discussion we had two years ago
> > during the Git Contributor's Summit in Berlin.
> > 
> > I'm fully aware that this will likely result in some discussion, which
> > is why I have labelled this as RFC. I'd be fine with a result of "let's
> > not do it" if we cannot agree on this step, but I think that the current
> > layout hurts discoverability quite a bit. Not only for newcomers, but
> > I'm also struggling with it quite frequently.
> 
> I think it makes sense to have all the sources for libgit.a in their own
> directory as it is easier to say things like "please try to avoid new uses
> of 'the_repository' and prefer 'error()' over 'die()' in library code" if
> all the library code is in the same directory. I'm not really convinced it
> helps with discovery though as there are just as many files and now there
> are more subdirectories to trawl through to find what you're looking for. I
> think the anwser to that problem is "use 'git grep' or 'ctags' etc."

Agreed, it doesn't help with discoverability in "lib/" itself, as
there's still going to be a bunch of files in there. My main intent here
is to help with discoverability in the top-level directory, which is the
main entry point for everyone.

Patrick
