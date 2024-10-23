Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183A1AB50D
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685086; cv=none; b=UdztTNz/hsOthiKO1LHDE3Cjs47m1K5p0FRmnzGppuffxOeEnjfd6Ljpkc+oSNd+/2A6WemWlDWGnr2uwwnTq7X8oB6lLE9Vttn68Zc8WcvHlvUu/RPm/iOR4UgfcQbtIQ1rmoSSss4JtysSqtJuOgVLvF6105jBo/1GXCHYK90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685086; c=relaxed/simple;
	bh=WqIEnudf8Iy6o6VhrB9115zYmAxbvnlPwKhw5sEDhWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hImdIr2bCi3VhIpALmn2KFyRqkiDAT/cooTA10gZ5VJe9OuyDAX5PKULKAOcAF4p4xn71XM3TnTlq0b6Wb3vrE2co5DX3egunnY4yxE4l/ND44h59oMOe/4VG4lT3sxiBYHHMbMUD+9KPofdyiYqKQCJyvMF7psWuRximVVqJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O+B7hiuE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ppsuq6xm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O+B7hiuE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ppsuq6xm"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C59A01380775;
	Wed, 23 Oct 2024 08:04:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 23 Oct 2024 08:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729685083;
	 x=1729771483; bh=n1cHfLs7unERsb4ACInykbucYs6TcfsaKOeCaURUL6E=; b=
	O+B7hiuEKBv7rEr3jGlamrw+mmk3I6zLPSN2ZmRMrALGVMxtjXszJ8ZJUIhtkKDd
	Nfx+3Cs1cdxVSZByc5uBn9baeF+ewsmgw88wKVcqYsIt/si/pmWendux/0/tcjCS
	O5cHJLp290YTP+l+ERrRCXT0smd2R0EI1gF6b1U0FIRby8eciuDbCS1NoAxWBh2Z
	pOtaltkZot5Qp14E7B0mM4Sj9ZnhCYz19B63080ADvy+0WHdm3HislwUiMfXgSx1
	lpCp2HfXjtTrYyPQuc3aesOJ2lEZQMTQZe5WTmkK/JRMkGGGpFSkpVdDDT9VaR6q
	jEkKTNg85miYg2OqAvLNkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729685083; x=
	1729771483; bh=n1cHfLs7unERsb4ACInykbucYs6TcfsaKOeCaURUL6E=; b=P
	psuq6xmdlBAMFWC1EN9kggTpNw9OhiWZwG4jj1QLN7jXBbqmxiu8z6dCjTLmcPfF
	lBndBfkCGa16Uf5vyZHFGVc03iW7ixcHLA3Onr0/MCb1mOQRYXLd+QY5I4pZfh60
	bzCUSjwrqSU7F9KRA5NHqhcyZQLIQnI8P/I7HIObiK7RJ9z5n1aaGbHz7exhdCrn
	WSb9Yua3hSoiUae/wavJcluf0Hb4KaYt6qRzeesiYIXGWEl91l5ssqy0ErlTzavg
	mnDhjbSsHY1TB3dHhwXH3800Bqi4+aOh06CjTzYzwWkkB3NxGvTkNRJBcAM4OP2h
	CsTPiTB8FxyheHTf5GXBw==
X-ME-Sender: <xms:W-YYZy3xGm39mTrN-pOOtly0xVYdDLbxOYUe0QoiofvLse8nFkHhfg>
    <xme:W-YYZ1E6mUw1S6sj1YjeU05VekCALsunpjFD6sjEHc-3kLkYO9VzOecohu36p9GRg
    WFfrWrWwy819lhfrg>
X-ME-Received: <xmr:W-YYZ67yrj-KU--xBs9AvKDo5x7mthsJNBv4BP8NIDyedkn19TGN5mdv_NLix6LztCnNbx4JkhsjMfV3EEpNh1iPxLcr2aUyfa4aVwOT0SUH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtii
    esghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:W-YYZz0U0SzuHYjGXTiNQZVnpzxxxEbhpNMY9ujsXDZFmOAYzuWCiA>
    <xmx:W-YYZ1EwtLdWycb-UslPGLZEnjOZRVNUJQxKXckepJ82NO0skc-YCg>
    <xmx:W-YYZ8_0s2RS7diUwjAC12o8kE5DHyT9GKiiZagXqCcB2AOxxQN0Ug>
    <xmx:W-YYZ6nHAjKVjVrnvHoTM90tnYkOLSYtQxBwFiA9WHa3QCgljGCD-w>
    <xmx:W-YYZ677ir2B5Vr-5UvghhpCdSxq5OK0pBLQ0tX7yghszp8LIXpAjSep>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 08:04:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b4b19b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 12:03:10 +0000 (UTC)
Date: Wed, 23 Oct 2024 14:04:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v3 01/15] Makefile: use common template for
 GIT-BUILD-OPTIONS
Message-ID: <ZxjmWMJ5u5pHZh9L@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
 <800fb080f45f48e248e1ed9c7b3e40cdfc526115.1729254070.git.ps@pks.im>
 <CAPig+cR2QXmgFEpaQrvsAF1jV8nZavFjYQkMXp5zaYVER2CiSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cR2QXmgFEpaQrvsAF1jV8nZavFjYQkMXp5zaYVER2CiSg@mail.gmail.com>

On Sat, Oct 19, 2024 at 01:00:46AM -0400, Eric Sunshine wrote:
> On Fri, Oct 18, 2024 at 8:23 AM Patrick Steinhardt <ps@pks.im> wrote:
> > Introduce a new "GIT-BUILD-OPTIONS.in" template to address this issue.
> > This has multiple advantages:
> > [...]
> >   - Some build systems complain when not all variables could be
> >     substituted, alerting us of mismatches. Others don't, but if we
> >     forgot to substitute such variables we now have a bogus string that
> >     will likely cause our tests to fail, if they have any meaning in the
> >     first place.
> 
> Regarding the above...
> 
> > +       @sed \
> > +               -e "s|@SHELL_PATH@|\'$(SHELL_PATH_SQ)\'|" \
> > +               -e "s|@TEST_SHELL_PATH@|\'$(TEST_SHELL_PATH_SQ)\'|" \
> > +               [...]
> > +               GIT-BUILD-OPTIONS.in >$@+
> >         @if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
> >         @if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
> 
> ... can't we `grep` whether any unsubstituted variables remain in $@+
> and complain if they do?

You mean with the new `GIT-BUILD-OPTIONS.in` template? Yes, we can.
Meson generates such warnings automatically, but that of course does not
help our Makefile.

I'll add that.

Patrick
