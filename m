Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86630185B5F
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135519; cv=none; b=bA52dSqsKH9OmS+6QcJdrMeh5MtPuV2eJCmDk+5Mob/OQD+Js/dveHVZqPRKlGC5N5iWZsDvvNkHFrxCmCB/mwg2tDoux2Iq/bG2UUhIFxx94j1B+Y/XAjbtwM/kGJFR3VxIIS/j2KgkWH/zDsDVrAQlGwNeLuOq9qEiE12XSoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135519; c=relaxed/simple;
	bh=BcPShMHb3RiCnTuJW/qvGxYlaYHKK+LfUNZ8keX31Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxhCxFvDyVXbcZ3pt5/PLT5xs4TqF7YWbEYUM4YDhAblQyoWVvdaiZd4gwKLZ/IGjFbr5RUWfRLPbrvzhoYdGmF50TAkShcYyCh1z88JnOFftTeyD0m/nw0UehtDMNgyWrP/b3MqJU53ZwOB9+CNqqb2Jh21M6do6tlVNDBp5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mKy4v577; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u5w12qWm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mKy4v577";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u5w12qWm"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B935114010B;
	Wed, 29 Jan 2025 02:25:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 29 Jan 2025 02:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738135516; x=1738221916; bh=UpS7bbmNK7
	QDQ6CdlAoFeU2qDr7OQJxBz66cYnUISpM=; b=mKy4v577cwtScLjZCNHSiFh71S
	EtF/65uRal3hbaPfKRwSLfG9qG6LZli9eaUIPWLQYSFHqc/0uog/jDZ+ooo5R6uS
	rXpolRt4eMviNzwlHXAUnJakDh7mk72f6qC4+pNGz/5k+iUCerJt25ORcGIOkI40
	jS6+YxpcEWwBcz3RT7otKIKOR94nkRLSOyP5yJIHwFyIE9hcxJy43MGzD3PodbZG
	AZridGdlH3chf14d+l9HROSq8lCk2hFMjWq+MmxUfsCQrxvx64b86l7dFF4KT7/N
	zarDAsDzTn4UwpguZYA74B2wD+DoQ03r4PkN7VGzrvmG6vFuM7OS1Ici5cng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738135516; x=1738221916; bh=UpS7bbmNK7QDQ6CdlAoFeU2qDr7OQJxBz66
	cYnUISpM=; b=u5w12qWmusi7uYnAjF0zRihJgae8nFu20vj1I3ag7GDqEfTYIgN
	wCEphWH3gcvbSF5/yvqmcOBjcwCnAPjWRmwmzS4CwKz2BgHwy9Ekr61tpgYcphue
	vMvqFFLBfHJIh+y8YkCj9p+in7so77zn+oP9JexSs3kF73iuengC4IGgxUP71Pbb
	Au6OQa6SrlB1rnh76aQ2AKb4mHZws2rlRQrgrUBYHlm7fUkjufcz59vf6Xf2r+Is
	uvYt58xzryWnjCKpwgrXPFXum7g5aFlnUV4dJNfdwbQIEy5CVZQZBsncMYqmrVDk
	rr1Ets4eUeYu6MkGG8M/V51zeYw1gl7CKkA==
X-ME-Sender: <xms:3NeZZzEbEx_W2Gqpagu6svw3WR7Myhfj-y6-4arGlPgT8g8mlqbzJg>
    <xme:3NeZZwW2sjyizpLqlVw2gfjTyFtO9xzcoKCGQLQIDARmNlxsrtFDMDoTD2MlNd_pH
    96781MYMC7KYSQIQw>
X-ME-Received: <xmr:3NeZZ1JWnIE7XplwlKAIi0lQGRhkTmDU19ywwB53aTtKuOyfi-RIOcycdu4_8NNWVjOuhT3BLtXhu_IYA3_191xTFbfbghqbV511hzbQ2cuPkiWbLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrg
    hrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:3NeZZxHZmZmAiAILyCSYS11h5OFmsbfGiNC7jJquJ-_Xty1WePA03w>
    <xmx:3NeZZ5V2drU2XyFqfC5SiWK8BcpPCB2LgxX2tFpnNWKRRrgPdCqLpQ>
    <xmx:3NeZZ8P3PLqGRTKftdPcsk7AiyVKVTI49PytZklO56j-O7AS7AUVRQ>
    <xmx:3NeZZ41B8AagWNl4noKY7nagXUe78Q27xe9B4Bjh4WTjqBWQQK3ELg>
    <xmx:3NeZZ_yUAX9z2mfE4LqnpCZtmb0RkUss0i_Q_sUBYpk8qBuLa5NhH6Wg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 02:25:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f1f889b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 Jan 2025 07:25:13 +0000 (UTC)
Date: Wed, 29 Jan 2025 08:25:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/20] reftable: stop using "git-compat-util.h"
Message-ID: <Z5nX2BEoF0YxYKTg@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
 <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
 <xmqq5xlymu5x.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xlymu5x.fsf@gitster.g>

On Tue, Jan 28, 2025 at 02:48:42PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Changes in v2:
> >   - The splitup of Windows headers has broken compilation because some
> >     of the headers couldn't be found anymore. I've fixed this more
> >     generally by converting includes in "compat/" to always be relative
> >     to the project source directory, dropping the platform-specific
> >     `-Icompat/` include.
> 
> Nice.
> 
> Use of -Icompat/plat/ would make more sense if our sources include
> a header file using the standard name of a file that usually appear
> in /usr/include/ on a platform that either lacks /usr/include/foo.h
> or whose /usr/include/foo.h is inadequate by giving a replacement
> definition in compat/plat/foo.h we ship.  But that is not how we use
> them, so I very much like this change.

We still do that for drop-in replacements like "compat/regex" or
"compat/poll", but for everything else we stop doing it.

Patrick
