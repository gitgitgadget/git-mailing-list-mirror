Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75DF199EAF
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493099; cv=none; b=SrBtzPNsC3jNmfhF0L53v+4Ued7u5jjL08Ng18lW/5PXtySe5hNeh3uMfm4ybhHU6WE8F8berw1Ib3rn/eQW4ZDLdwoP7ndsYfVYO1NBMCdhR4LNC94GEaqtq2uBIgvVkJoY0I7ICcqDu3RD5gqL09aFXwgrejPbmBfOWU5dHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493099; c=relaxed/simple;
	bh=ujIBoNAln2MKH49e5HPuJfqMfJ4BdWAZFr6mPwRTmuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toIsHNp/c7OKH+Mw9skkI9h23zgV3mW1fAUmV3PjJMq0mCnzeHD3DPzz0h4taAnL7a4Suv0jpnuiboDALMZvdVu2wXygoKg8AG16oAchR66GyK4NXOIK65Y4KpzpCQ7tlMHUUwRc67YPVDYxBG25U20x+mAmzHsDJ7cPjekNw5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fs9nQsPp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ePz/RfrR; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fs9nQsPp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ePz/RfrR"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CA4991140101;
	Mon, 21 Oct 2024 02:44:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 21 Oct 2024 02:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729493096; x=1729579496; bh=cL4h4g7YQN
	RJkAo/SGe3fXMYPNg5eFSF2gCasI3k0sY=; b=Fs9nQsPpqm5EvbhYGEWG6htY/p
	nqs3XJQT21z0fQLyFUfP7Dm/est+YiG58PRuAl+B9pfvPuXH3ARg5ci6cnAMfiTt
	72qw7K7Pae8/YBrJHcgsKAtCpz6YzlJWEcRpTjJgIvH9EL3fPicy4wHOSY4/hn8N
	o/03je+/Ot7+sYIpW4VvU2gJVeyoJ1DbuHyU7iILPRCW4n9bNgNa+JIemaYiKKMw
	YLUoG4DuKyl/Xo2H8umZk/mNcJ2KPfGjoP5uJLn5JkZvIjhqF3KrK+0sS/7lwjtf
	Ygexa0bHl3wLxM1HQF9rhydZUt+aoP7kkGC1JCd6IuqFsIbZG2vHRNpXOTEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729493096; x=1729579496; bh=cL4h4g7YQNRJkAo/SGe3fXMYPNg5
	eFSF2gCasI3k0sY=; b=ePz/RfrRggxAocHuHmBeWndG50247wmm25DXwwAfrrj/
	ZDnwN6kmIR0okmTgS1lSap1o4zsO04/uq2cwTNszCkSDA1tCn6kwZhFGKWhi2KgZ
	LPp34yTd6ibp1pxKBj5/LHQy4QfIEkvqpt+yc2D9glEjEQ7cebUhKmL7jto/iarC
	uEqOZKYI6TkD8IJLqRr+hV3pUeRCsITWyBnwsk0XLYcH0RhQpkTbthY/CSlpbhxx
	Bl5BdC0Dr8y0jQvYVwrak8b+AMQObqUBP8cVipXoBIJcvj/NrQScFF+Ncf+YsU0z
	IkT/oM/kzdVF/2rrm/RC1Mq549A4fux+I1GHrM7vHQ==
X-ME-Sender: <xms:aPgVZ38WtL57THNGOEIoxLfmk-78WJBoy5w5bjk27i8Mc_jbniQiPw>
    <xme:aPgVZzvK7SVa1GrV5XLEj0EkvwA956iEYd8gYbx6OUyF_fTjVZGyYzHEyCa6TmxFK
    1md8tip9wtF1XZP6Q>
X-ME-Received: <xmr:aPgVZ1B1tFkK2gAJC1jkwf4FEmWr2JblB7ipZrUq_7l5XhQ8mXmngtBzyZwlLdAA2mEEt2Txyeo6apVOuh5R0kDkNMbPkN66KVkgmCAB0l0j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeuteffudfg
    heetgfevlefhueeuveeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepsghonhgvthesghhrvghnohgslhgvrdgtnhhrsh
    drfhhrpdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:aPgVZzc_3x0AjxrhyvF_oN8yHus3-x_BuGd-AAI16UI_uqiDFo4Iaw>
    <xmx:aPgVZ8MY0X85ajkt0aBYukOmmuTbH5up63hZuLPu_L6M8YP3EbmR_A>
    <xmx:aPgVZ1lZ8bYdKCKli859QbS0-AVaIAIM3CP4FA1gUhn9Motfryd0ew>
    <xmx:aPgVZ2uSsrk6-PNI_n5ROhnkyp4_qKvtOraojRfacWyCKJZrjRcKQQ>
    <xmx:aPgVZ5rjXcwdyzM2BXVbG95Sr8gEM-9lOL2WcfGOt26Wg4Vw9v7YU8gb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 02:44:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5e41e071 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 06:43:28 +0000 (UTC)
Date: Mon, 21 Oct 2024 08:44:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Edgar Bonet <bonet@grenoble.cnrs.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <ZxX4YtZ5lW0axToT@pks.im>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
 <ZxJnfYtuxnAEBc1E@archie.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJnfYtuxnAEBc1E@archie.me>

On Fri, Oct 18, 2024 at 08:49:49PM +0700, Bagas Sanjaya wrote:
> On Thu, Oct 17, 2024 at 03:54:28PM +0200, Patrick Steinhardt wrote:
[snip]
> On Buildroot site, Edgar Bonet (Cc:'ed) suggests to improve your patch by
> wrapping strcmps [1]:

Thanks. So with the proposed patch things work?

One thing I still don't understand: why don't you get an error from
includeng <wchar.h>? As shown above, it should contain the following
snippet:

> >     #ifndef __UCLIBC_HAS_WCHAR__
> >     #error Attempted to include wchar.h when uClibc built without wide char support.
> >     #endif

So I'd expect that to trigger and cause the build to abort. Am I missing
anything here? Let me have another look at uclibc...

Oh, yes! There's also a "wchar-stub.h" file that replaces "wchar.h" when
compiled without UCLIBC_HAS_WCHAR=Yes. And that file indeed does not
cause us to error out, but is a stub. It also explains why the logs do
not complain about the missing `wchar_t` type, as that type does get
defined by the stub header. Weird, but so be it.

I've picked this up upstream via [1].

[1]: https://github.com/clar-test/clar/pull/108

Patrick
