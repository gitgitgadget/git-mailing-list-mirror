Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EB0A41
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284748; cv=none; b=SiA3ZqvY4AqDhzR+R12/G6r3VmfpIlC1RmMMA7WiBdk2iIvUKqTi/EN6nbe9S4SJLmwj4ysM2il3SLTvyDW9kYBXg6gfjS5ScqwyK44XQoeJDM3EXLbah2soXit+NBh4TPr22mdlVXQ2l1Fb/QyCIGhCWGdEc5qmNSQSHJqKAfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284748; c=relaxed/simple;
	bh=n+vSqa6YPPElkfC9hhFymoZbYr8W4e98boPyzBI1y28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIVXedx4Iu4XbWHGrjfa6tEUH5Y4p+wfsuOQx/dNo2w1wN+dSNGFlzATz7Hz7v14IdtzxTRu8s0wbYG1LNnO3w3dVWyISb4kGewsPvZurveaIkzLvo0bJhXhQqw21lckSDjSS3YYigzqHqDrPG7m9TBxB4iWRvkYBgAush61aYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KY+uCc37; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lYa2nRF1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KY+uCc37";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lYa2nRF1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CB2FEC01A5;
	Tue, 13 Jan 2026 01:12:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Jan 2026 01:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768284746; x=1768371146; bh=cKD56v/nQo
	NZgnqZCuV1ZSPCq84Nfklz8MQ5b0l9G90=; b=KY+uCc37T3RjnIN01kq+hj3Ahf
	TO/tKMLSfp+hCXk9LQWZORhWop7RXsOr37X3hbRuR9vCEG/i9reqOKSacLcCLtqD
	frSE+VqqgQNnQgavLkiaiqj2B2XaaUzTh70LvU+ezk63IJOiiKwtim62aOWQOhg2
	euf3iF23LKJzUhJDK+OIPpsQGJ/+/w0GrEHsm2FLT3Ic/l6w4OaO1qp3Fh/1Kzaq
	swd388Eo5P7EBxreAV59RIk/CJi1dvAcd350GVGG5Qvn7Z/GgQdreasQ8oarirjS
	1d8I1mHyfK/VmobZy+CukJW2TDsJPAP/VtVZu5EVvGsjxYWWeD5Gh+yxoatQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768284746; x=1768371146; bh=cKD56v/nQoNZgnqZCuV1ZSPCq84Nfklz8MQ
	5b0l9G90=; b=lYa2nRF1U7N58jCA7mwByXu4MGtKKNj2c0cRtKSUOh5pZRPvzzR
	G776pRoM0pQcATVyOq7GRkWPVoUYTYoeG/R06pUoZzP9iikVkrot9KGx/s5Qxa+P
	Pvlc6Ei9MEvbp9DvWvCA4phQvOl/eT2Jbo06cmqrNNh0Tw6PGqiKw90fB7lBuVoA
	Z21hJOvwf3PQ7Xl32WsUuwLQmBv19/bZtgkbMIqcvj66wTsFKMDjye1m1k8wA1Oq
	Si+gA0SSaL9l+3paGhSVYbATLjl7s9vR6mlF3ODytwLqvcDadC4gWkzTzGnwOeY8
	cFavKUSiOdfrpp9apfKqAn03tX3mY42hQtQ==
X-ME-Sender: <xms:SeJlaZHCRTUrr-s-UQeYExg6JGPxM1dRwbX8gInJuG8JrSKzVsutpQ>
    <xme:SeJlaWguoDlCGVF2sL68MWGD_GgqctLnZS6_gp7l2UGt5zHvbOdTdy6F5TAgfNvnt
    Ni-N2NxSAp2SXpJTWLm08A3NYv7OCCyzpcOhFJhg60f98JbuTs86A>
X-ME-Received: <xmr:SeJlaWv0P_S5ZpUwOtmGvqJ-Nz9ZLdU_Q1a97L-w8-3MTbcSK3Jnkws6geG2oqivMUzkBRioOhd8OI42ScxUg038ee_oMqZMZj37tZnK2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudelheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtoh
    hmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgurghmrgiiih
    hosehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:SeJlaZu57_Ohas9Wm4avzqwM-9J7LVjx2VISTf6qfYaZj885Hr73Yw>
    <xmx:SeJlabGMBbr4qq6TbcyIKSKXF2kWeefs5J8fhe_zHB4SjhxgQU8DuQ>
    <xmx:SeJlaUPA1Fh9NDKs4VyGyqRTYRaujvkiGlS3vM7Y9R1UeKRtBDdmVQ>
    <xmx:SeJlaaIp4R4ZCTOOJ_tcRWlt1gZ8wPgY_NATMv31ccAfKNoCetIBJQ>
    <xmx:SuJlaUkysghECPjvXvtwtY7GhAbSYCLShbQsQtD8q9d5a18ck5-I3p9g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 01:12:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e698a98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 06:12:21 +0000 (UTC)
Date: Tue, 13 Jan 2026 07:12:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v9 00/11] Add submodulePathConfig extension and gitdir
 encoding
Message-ID: <aWXh9hQYxFhWYC6a@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260112184632.1334495-1-adrian.ratiu@collabora.com>
 <xmqq7btmmvqn.fsf@gitster.g>
 <87344ad06s.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87344ad06s.fsf@gentoo.mail-host-address-is-not-set>

On Mon, Jan 12, 2026 at 10:51:23PM +0200, Adrian Ratiu wrote:
> On Mon, 12 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> > Adrian Ratiu <adrian.ratiu@collabora.com> writes:
> >
> >> Changes in v9:
> >> * Replaced git config --global with test_config_global (Patrick)
> >> * Split die() messages to multiple lines (Patrick)
> >> * Moved some of the whitespace fixes added in v8 to the commit
> >>   which actually introduced the whitespace problem (Adrian)
> >
> > Thanks.  It appears that we are getting to the point of diminishing
> > returns, perhaps, in which case we should declare victory and plan
> > to merge it down soonish.
> >
> > Again, a report like Josh did previously about this not breaking the
> > users you care about would be very much appreciated.
> 
> Agreed. The logic is basically unchanged since v7, so I think we could
> go ahead and merge based on Josh's report on v8.

Likewise, I'm happy with the state of this version now. Thanks!

Patrick
