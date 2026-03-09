Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C84219F8
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093843; cv=none; b=HsfIHDUiD3Pyf7LMkAYKXxpAtlPw4dATNbfZQ7RoGtn0gX2S63QQPP5Y2mk6QaVW+w8lPmif+quBqsMtxBuuTH2JdYMoAVbjAh1BfxOwvxMIPvg0mDFIgG985aIiMT+lnE8pjUKsH9VyFPEBbe9bZXqIYU664kkTBh2u53aTsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093843; c=relaxed/simple;
	bh=+iLdN8jt77e1hIGE3F9YNFD9F1LGwEnCT+vMxIchUwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FMY3Tl1HPjVjowXKfy6REIOzJvhL1fU++ND9L21gbC7QjjDa1oyWV+ZcH/jePd//LPQsfv59JS690Zsk9zdLlW3uY/w9tEGs1g9o/P67DADHtmaqpxj2hrs71tgvRHzN0YAE+iskG9Fzftg8ujWfj5bUhOB1wlNeXQHh0yekwH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mhx0TxdN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ld6/fHhU; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mhx0TxdN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ld6/fHhU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9ACC9EC05FD;
	Mon,  9 Mar 2026 18:03:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 09 Mar 2026 18:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773093835; x=1773180235; bh=J/m32oFz3H
	H1JzZ9OGHKPJlizCg6PWO4/AHOJBYmsCw=; b=Mhx0TxdN4hE+ecS6Ks1pcfKrJ2
	Zkrlke2RY2ztifOcZ0M/0yyZKgFSe5wc3sYAcQ3U2aOgRjjTEsyzZnpFdPF6Gr+0
	N1ScZffLFoVQ6SbcsfgQHeCZYLFbbJ991taGw7dnolHNeRu1Uar9kjk+Jw2OkiGF
	W9qr7hRNkcXft3b2qkPIu6S/HPrzoHyvqUX8kzTDUN7VyNCNrgRNkLHpsyPNkTD8
	/xRZMGBEOtTQJ0R8EOX+4WWzsN5cAB54N+9eyCSdFhS19fDFdkdWyb6QlHK6j7L8
	tpO9O4oJ18WEn9sxbEky3Ia2oY2FYomr+uLBt+4Quj/o3t9qgY89Li3LdaDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773093835; x=1773180235; bh=J/m32oFz3HH1JzZ9OGHKPJlizCg6PWO4/AH
	OJBYmsCw=; b=ld6/fHhU4gq6ZlAwd7dJwzqE6ZvmyeW9f3RnMVOdiJxe3KtGX9u
	YxWPZMDve0EZWvhmGjJpGpCr2ZsuZpgFk40wDQerBZ8n3TBB8f+m9Nw7lEbadhav
	RxfR/8m2XR39BZYNBaHu/dfiFEK5iKQkIV5GtdjoGHOc5kH7w98Je2Q3mKHDFvXo
	UYk9JnR1S0xrBezwk0adbsO8/7otanehiwq1kCop7e5FO/1B8Wq9MxsUggYKF9mu
	6jXPXjVzGBcg7yC1DPxt4RIcUXvr7uYWL/Kz3DfNUA1JPMDLrcsupj32NikEp2Uu
	geBesFFtcBqhcfpYaB9xa1MG3QyhGf7s7qQ==
X-ME-Sender: <xms:y0OvaeS85IUxpZXmUq5Yg_6s2kqhs1yRsAz2dcln9-8EOmMAUA3EXA>
    <xme:y0OvaeVSM8ylqSUb5626YbmGokVf3-feJpl1UGyPAnTuRb4UtkD8MxyUCXtc1XY9C
    Ui59DwqN_4JrmFBT_UAR0TGwS5s4i3Ts0F6F9FaRu2N_9oTkjVyRo4>
X-ME-Received: <xmr:y0OvaYYXkOiJ5ekw0d2gKyAdHyfYPndrm-z2ldfOa9qAnSwawNmEsxr6iUbuMMuNs5AUxYWDkc5zTuwLmueH0qxRNC1JwEyNJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrg
    htsehmrghlohhnrdguvghvpdhrtghpthhtohepughrohhnrghrrghjghihrgifrghlihes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:y0Ovac2dRQsuloAxwT5fJWevkml_19QrDiACQFiihob-uEeqIfIZGg>
    <xmx:y0OvaSis_OV33nwMMxrOf9poQMBl0Xvqq9HGFyLAcOl9PP29ETYGOA>
    <xmx:y0OvaYZQDNwTqHmzuF_O7L1zUmg3WrIDpmHaDzJpW922n8BdbdUaZw>
    <xmx:y0OvaaSTS0zGtzVvFC8UfEVQluWLTFcTCIMknH6zWUZguXUVFWEJMw>
    <xmx:y0OvaRgRDysc0KnKccyn_3JoKlEsHfFMee1jNI6HOkFiJUADBrbboOFY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 18:03:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: Dronaraj Gyawali <dronarajgyawali@gmail.com>,  Git <git@vger.kernel.org>
Subject: Re: [PATCH v2] Make 'trust_executable_bit' repository-scoped
In-Reply-To: <615caf83-71be-43a6-bcb0-3a0c5e14d699@malon.dev> (Tian Yuchen's
	message of "Tue, 10 Mar 2026 00:23:17 +0800")
References: <20260301190017.53539-1-dronarajgyawali@gmail.com>
	<20260308183756.31860-1-dronarajgyawali@gmail.com>
	<f03d40072ab106d1a0a7852718d42f56@purelymail.com>
	<6e3d373f2f41232ca9015c39ae0ea67d@purelymail.com>
	<CAJtK1FMzbX7dO9y7hM_6_DbLpwbeYHnrg7WLjAghGX6UDVDmJw@mail.gmail.com>
	<615caf83-71be-43a6-bcb0-3a0c5e14d699@malon.dev>
Date: Mon, 09 Mar 2026 15:03:54 -0700
Message-ID: <xmqqo6kw3bjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Hi drona,
>
> Junio C Hamano <gitster@pobox.com> writes:
>
>  > There were discussions on pros and cons moving global recipients of
>  > configuration values into a dynamically allocated strucrure...
>  > and excellent pieces of advice have been given by Phillip Wood.
>  > If anything, a change like this should ask for input from him.
>
> That makes sense. I think you should CC him whenever you've thoroughly 
> polished the patch or when you encounter unresolved issues.
>
>  > This "v2" applies to a mythical codebase where trust_executable_bit
>  > is somehow a member in the settings structure, which I do not think
>  > we have.
>
> Given Junio's observation, it seems this iteration is targeting an 
> incorrect or non-existent codebase structure.
>
> I'll hold off on further reviews of the specific implementation details
> until the base codebase issue is sorted out and the structural design
> (incorporating Phillip's previous advice) is settled.

I think what the author called v2 was actually [2/N] where the
previous version was treated as [1/N] of the same series.  The line
I noticed was strange in my response is probably correcting what the
previous one did, which is not what we want to see.  It probably is
similar to https://lore.kernel.org/git/xmqqh5qxzzzn.fsf@gitster.g/

We prefer the patch authors to pretend to be a perfect developer who
never made any mistakes while writing their series.

This unfortunately is a recurring theme among new developers.

https://lore.kernel.org/git/xmqqk29bsz2o.fsf@gitster.mtv.corp.google.com/
https://lore.kernel.org/git/xmqqd0ds5ysq.fsf@gitster-ct.c.googlers.com/
https://lore.kernel.org/git/xmqqr173faez.fsf@gitster.g/
