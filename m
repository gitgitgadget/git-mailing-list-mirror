Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB3535DC
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738494935; cv=none; b=bhHSaeP3nkG+bdCjjknKLOS2tJqHUgMbMTTLAhphKoRioQPtosUrwNsarvj/Gdxt8sw1uXFsp2W476XQtfmlAHX5ccblUezHhH/zkSMlbQUu1Ug9XcRLWQRoxU8FRKO/UxRsC0OAr9UMfLnaAV/NaGGhxw9L/eNlPeR50PfL/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738494935; c=relaxed/simple;
	bh=uAfMsCG7AjYGNI+ktf8de2fmrgBTvq+pZ0U9D8UNra0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OakCpj34yNe8mD/THM9CTU8PP8fUu9Qj0xIIRD54Bs1wRQjVy8cG4j8b3O4+2eXVwilF9TFY+/pQVthgrnqEQN8tFt3iREM0iKJIq/JytrmvimXW5a58qkqYXuAnFFDWu/GoH3UsRnLDca5SElBMRfV4cW3xdI79N29RaTOZxsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D9YDORvO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ykyNYR1l; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D9YDORvO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ykyNYR1l"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D6BB211400CC;
	Sun,  2 Feb 2025 06:15:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 02 Feb 2025 06:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738494930; x=1738581330; bh=IVgzyE7A7X
	dYOhdgdiAmWcON2z+g8d+Q00ZkvYZ727Y=; b=D9YDORvOOe3TAlrrUlnqIhMq/T
	HdWhR2KC0mR+a2YeVHodwOOTKnflVr1Wcvm2ohNr4BuOq7lMrlaatVrpoxbm4eZl
	nc5lM0W/qUsjpxjLU503XIW4Y8CCzIjnmVF6EPjSDdMYlPty4foPo6BhcEfsJcty
	Im6Btsn7LYgiV5uesqkTLNuaq39OhoyT8+zMBYb+8OQMbDYZKj8E/7DimDn4aT1G
	9g2VWXcH8i59/KFSu6WKeW2kj+Pu9vhF9h9LK3pSEvLdngksyN1gDnb+0fGRUNoA
	Vhkd78094zk8VEblnQ/sfMV9Kz0Ac2mOvWnyithdLJiFSa91a/XjzGWGyDFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738494930; x=1738581330; bh=IVgzyE7A7XdYOhdgdiAmWcON2z+g8d+Q00Z
	kvYZ727Y=; b=ykyNYR1lFhigClnR8bsZ18bSJWymQ4fjGo7wqhMo6SrDxBQ+s+q
	+swMvU5o1TBqPNDPP42L4bdvqa6rjEjtuTTZLA72EyXVrpkrVW07OMKgZPTX9jm7
	hWWEznWbkE5SxSnbgVK+82eEAyLCG76ZmRAj18O8ylDF58baYj5Dm2PyX0S6AByY
	tAL3XyAuQyipNq2CHjI7SblHvS/WTCdSjpNWRQj0YLM5WTliUcPXHWBQc4IbuyJj
	m7y8BQg+s6JVeARpgYWqPbN8moAwIDbFtGE1bLGxXnGvO/N0NoVQ4dHWKDhno4Ek
	ghmihTQqCmyXWKQ9CtVeChif14WFd+4L9Aw==
X-ME-Sender: <xms:0VOfZ3PsyWeax5ZJ0h3I-QadidK5y0RZuzbq-PMqWmPgITSw-V3gkQ>
    <xme:0VOfZx8bY5cjcxdAOUn5W8g03ZxezfR2FGni-ihjORvrIgsnSkRUd6DSN-fklVGLw
    GVYNxSfrjDX9eqgxQ>
X-ME-Received: <xmr:0VOfZ2S-hFkmFYj4SozO2IWveVolHlG-1DBiyqDewYCxNHDW9M50KR2Qaj4p70ICF2AR6JTeGmmfwdZ1fMHO1qaMGgPc0I5qHav8jOnQQWUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhope
    hmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhovghkkhhlvgesfhhrvg
    gvnhgvthdruggv
X-ME-Proxy: <xmx:0VOfZ7tUpuEf1c7BqFrx1j52mUrXlifpHrHRKptVFwfmRoSvYaQuxQ>
    <xmx:0VOfZ_fZmQbL4_0QusZoeNZWuRNkpmq1CNbr4FZGyhyzetG9heDaIw>
    <xmx:0VOfZ31U8KsVdMrUQBGDovRZayXeRnEG9XZRR7a-MAmmJwXeKAaYRQ>
    <xmx:0VOfZ7_YFd3hWpm6kVsEu35FA1Uwg_fEnq2MIr5FmxfKgRMeKM6wBg>
    <xmx:0lOfZ24g_Fruqs0qhSsdI0bIHDTt1D0bFVnsIEg8LJIucICDyynyhRbP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 06:15:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a2549cbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 2 Feb 2025 11:15:25 +0000 (UTC)
Date: Sun, 2 Feb 2025 12:15:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Sixt <j6t@kdbg.org>
Cc: M Hickford <mirth.hickford@gmail.com>, soekkle@freenet.de,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: "meson test" very slow on Windows
Message-ID: <Z59TzBKLHQJwXUBJ@pks.im>
References: <CAGJzqsmmq1R9_q=p_AsuFMFr3UzyQ4H186CpfWTnCoAnHu_OXA@mail.gmail.com>
 <89612095-6b10-44a1-a29c-b143d67ce7da@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89612095-6b10-44a1-a29c-b143d67ce7da@kdbg.org>

On Sun, Feb 02, 2025 at 08:46:46AM +0100, Johannes Sixt wrote:
> Am 01.02.25 um 23:56 schrieb M Hickford:
> > Hi. Has anyone else found that "meson test" is very slow on Windows? I
> > built Git using "meson compile" with compiler MSVC and backend ninja.
> 
> The tests are very slow on Windows in general.

Yeah, it's an unfortunate reality that tests are slow on Windows. It was
also mentioned that the first ~20 tests are fast. This is expected,
because the unit tests execute first, and these are way faster compared
to the integration tests.

> Please clarify: when you say "very slow on Windows with meson", do you
> then mean "slower than with a Makefile build"?

Judging from my own tests there is no significant difference between the
two build systems. But in case there is I'd be happy to learn about it.

Patrick
