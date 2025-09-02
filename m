Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CA82F5485
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810537; cv=none; b=CBJT63/zpFwt1otuJJVi+ijyzxQaSTMlCdg48t4Q6DfTBpVTs/J2lT0ArKMBuoatv8JhN6wNZzIjCFQ95sGUoC0iAQFgrWoCLkKqmg47jCD8svAmGKISTHWRbNc8t7AUoNn/a2B/mT21GqcmE5TkUPOez+tDGFe9GPknjrboRPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810537; c=relaxed/simple;
	bh=KXQnAipLaQol2QyUcc4C8uNKiBAApk165mFjMq5gjvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwteC2gFjuAW2U9lltKQ3fzcK5ktRmMmcpM65xK+v1GGPgEN3eeRZwQdtff9yI240NzuiI6tWgNS7isI4pRoDX4Pk2ug37DxMjw4knD1MnvQZOtOvarnqbB3bw4T6V3W7XPtMkVqpoGdYouBLGnWq4JNlbGKBQQWDDhNUBFYfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K7UTRkve; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hRIEsUY8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K7UTRkve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hRIEsUY8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AF4A2EC04AD;
	Tue,  2 Sep 2025 06:55:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 02 Sep 2025 06:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756810535; x=1756896935; bh=FLbIXwD1ax
	4veM011rlLtHAwrXZBDP+3aIndW9xcZ/g=; b=K7UTRkveo7Fa/yx/PG0sllKtzE
	8nMgoTfqrbOB/0WUcGyN2NrjWuEiytZqbIJslg9TMrZoca/Y9Kmq9myzpTHOqevT
	XSHPM2cpevLnChDMXZpGgsxmFOcZT2CQlU11TkW/gbObNHGIBCCTUJTMtFG1do9O
	dBbiovcWBVpd8JWg2Gm51KTNQROTJtL7GP74hPeo9lnU9jmIDiwObb33Vh4IqlCq
	zucZ5gmGoPnUJN/IBygLFpweGU89ojITHHO1ujrADifdhlG6488ZdhqX8mlfD2Sm
	ozQ7bGDCDWP+SDqpnDHn0ZYlQaY1JfVhaAW/zZMaK+2gBMTUauON1oR5ueew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756810535; x=1756896935; bh=FLbIXwD1ax4veM011rlLtHAwrXZBDP+3aIn
	dW9xcZ/g=; b=hRIEsUY8nLYpAJT1UfFZb429uTx/rs6X4oNmO9106lE72We4VPn
	iVTAfSDg7ovBKm19jnvnqjWmf0cLONQ0WRQo38FuNbVO9eGrYSQKa3vU1iFORNY8
	fdR7DARRKtuOz702vcsFL7yFiO+fDeHAgHywz8Cj3XDPf+swGX3HNCm90nFExWIu
	0+u714PzzPZne3zMfWnFeaeUKYn+B9wfttvmimPEcDNdaK3I1fK4xnOVYoGbxRjg
	JogVldqzR/cy6ax6BwyMHnfX4PkL/fdQxUEfQxRIEalpI4q9XjT2PnZBH2TT94Cm
	hJ62TOyV/mO0DINZK7sh29qa4jeMi2fBD3Q==
X-ME-Sender: <xms:J822aI58wLoEQat8BTfmRTMFG_v9aqTRfw63nWFN1K8fB0IFxXWJGw>
    <xme:J822aEeqrtgj5vc0TrqlpPo0TiVAkrUyiBseSdKvluGKsAsNT4x9MvgeUnuI5TfGW
    hU3Ppsg1CIuKZkoTw>
X-ME-Received: <xmr:J822aEBY7pMs1v_mRIq_fC3fyxXjeAoP7wTdt8T4DVH9tx0Z8cWsdQlVBIZZESMjtcQ4JLVRYid1Yn8ZKH9ZWCTJzzfYteyuioEN_ls-sKKx0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejve
    dugefgffffieegtefhgfeikeevfeefheevvdegieetgeeujeeliefhiedtueenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepuggrvhgv
    rdgvvhgrnhhsheehsehgohhoghhlvghmrghilhdrtghomhdprhgtphhtthhopehjohgvrd
    gurhgvfiesihhnuggvgigvgigthhgrnhhgvgdrtghomh
X-ME-Proxy: <xmx:J822aP9IBqgTUMnZI4oKlpI5bjkRLgGyuhIwCz9ezkDCXhxCNJLnKA>
    <xmx:J822aHJ87Ov0ZYkjPQCIToCMlh9N4zJrV62NVIo6zX1oxpkeCr_TIw>
    <xmx:J822aAh8ggi-dlmCVt7qLuZFQrH0L5P63gE3o68Yc0L9zKKqMGb51Q>
    <xmx:J822aP7lij1jHJLL6Wlgoq45mfhWPeag47JLmkqIi7qfhmpFIol5eA>
    <xmx:J822aIJkCMPmQsFb3PDo7EAdnoTAEeJ1sBMCDyent0MqPr3CB_b7_pYF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:55:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71123001 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:55:32 +0000 (UTC)
Date: Tue, 2 Sep 2025 12:55:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Joe Drew <joe.drew@indexexchange.com>,
	Dave Evans <dave.evans55@googlemail.com>
Subject: Re: "lock file exists" when fetching in bare clone of repository
Message-ID: <aLbNIRRn_Mm1IKp9@pks.im>
References: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
 <20250820213323.GA1667633@coredump.intra.peff.net>
 <20250826111952.GA1926324@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826111952.GA1926324@coredump.intra.peff.net>

On Tue, Aug 26, 2025 at 07:19:52AM -0400, Jeff King wrote:
> On Wed, Aug 20, 2025 at 05:33:23PM -0400, Jeff King wrote:
> > I'm sorry but I do not have an email client I could use to post to the
> > git mailing list.
> > Please could you post my thoughts on this to the list.
> >
> > https://lore.kernel.org/git/20250820213323.GA1667633@coredump.intra.peff.net/
> >
> > I use git 2.51.0 built using Macports on a very old version of macOS
> >
> > There are a couple of repos on github that were showing this problem:
> > vectorgraphics/asymptote
> > ghc/ghc
> >
> > Both of them were bare clones.
> >
> > I applied  --ref-format=reftable to the vectorgraphics/asymptote repo
> > and a fetch
> > went through to the end successfully
> >
> > The only snag I can see is that cgit no longer works. It says :
> > Failed to open github/vectorgraphics/asymptote: No such file or directory
> >
> > The version of cgit is about 5 years old
> 
> I think that's all expected. Unlike most systems which call Git commands
> like for-each-ref, etc, to access the ref store, cgit is linked directly
> against Git's C code (something we don't support, but the cgit authors
> accepted as a risk). So an old version of cgit will link against an old
> version of Git, and won't know about reftable at all.
> 
> It _might_ not even be able to detect the directory as a git repo,
> though I thought the reftable format was designed to let even old
> versions of Git see the repo (e.g., the dummy value in HEAD).

Yeah, in theory old versions of Git should still be able to discover the
Git repository. They should bail out due to the "refstorage" extension,
but other than that all files that need to exist for Git to discover the
repository still exist with the reftable backend.

If that's not the case this is a bug we'd have to fix.

Patrick
