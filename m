Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392711E9080
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510510; cv=none; b=MCnlHsOfTSsT4VW4URu9v8apcyNob+NlTZVU7BzjWsMCXU4/WC8TfeQZeJrEazNCsxEShNVuP+6mWZEs5Gfb4yVW6uDWSvN4gLkh9b2FNP60Bsynh8Ea+Y9zAEAWO4kZSs60BQYCug/ZXhO7hOFUdPWAOQOx2Lxw1rKeTddZMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510510; c=relaxed/simple;
	bh=qGAhIGiBYr5dygvai73EflJJhdmlU44yYEx7zwS3BaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzP8hiANiEbbC6ZqAOGB8hJHjV5C7LPrPdiVcRf/4x+5P7kPigyVLcU5v1HT+A5w/e+MYHpDVUZ0NNaYBpbyLdy4C7Hs8nSB/1AHWyuY3Af7xHtLLyCa0/3uXHon3pBWl5LbkmExzQEBCOfiOumKDdZRwU8kydpPhsmdf4AFGiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eqrgABYp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EwxT7dPk; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eqrgABYp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EwxT7dPk"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A3F51380696;
	Mon, 21 Oct 2024 07:35:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 21 Oct 2024 07:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729510507;
	 x=1729596907; bh=TGjVgylQPQ/PRK4HtttaZdCOQpeqJ9KwFBNxk587AlA=; b=
	eqrgABYp7ThUUSIKcRSVYvLOM24cwNb2x7clqPxbCwlEWe0m9/N6SL3Jp13UaHoX
	BPJIRFbIh/8cODJAjdZyJks59BNrXLL2qDjlXEr8wOx9PqiO2gETE403ArU8uDdd
	hI/Sk4AT/AMvOKq/iOtaeRIEZaksiOZA5uF4zpBC5+AAX+MxmS/81zcGmFRplFFw
	iqyArSPjTaqM9QGHgO1oav6wnZHQz1TbQ5toWdxT18YSWFvq1jvfMyGFO9GTIznk
	Xg1rkhtyslK30zTCJsnWuo6Z/Xm1SyA5/gfwHM6oRlKsOLBcK+injl6cPTWdY6on
	nMq3UV2IVIxRiQRVznqY0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729510507; x=
	1729596907; bh=TGjVgylQPQ/PRK4HtttaZdCOQpeqJ9KwFBNxk587AlA=; b=E
	wxT7dPkAMXoEIfpg7Jnjsz73oRGqjEYRIO1CSSTW/jNNJ2M9r9IPiPV/JQLOjSnv
	TBgmynpo/5yEa/125enB1XoZgUefkEgH4PThtk17WY80UH88iRtpZ+sgFjYa2JBP
	e7QejuMcT052MCZNNINI6yqS1bftcynl7byeJll+meJiKl0/yJOgwmw6mX1wuqKF
	y8dNoX6GOdf3uxEkaw9BnFjb7S5AtzHWfaXUr0Kmlgoq3Jx1zzu+9MXvRRmL39En
	eiTVawIBE5HIqDMtnaCjLZBRHdT157verKCetrW0adLcBAlG4hzrS8UeR7LjGor2
	B+GDwMW+lallQUUq7C98Q==
X-ME-Sender: <xms:ajwWZ0eUW2lCp-oif9oCdnAdedn-TiuPfeCKHn5OiGYEddTfreo_vg>
    <xme:ajwWZ2MIoK4Bv9daZ19X2V74F8TvB9JZ34-JO60z7cPQmqXojKfUzNYNdKenN8cVA
    bQEGraa2DaqXkAWBA>
X-ME-Received: <xmr:ajwWZ1jcUK63VxThIknXbYcxKt3Q1Nh69Hy1xGezk537TEdjZukSwxgjD_EUPLNCgrzKrHmRW5a_5Rxx_TZ2hwI9kK_UHepTQYezDxdPyH-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeetheffvddtleettdetueeukedugeettedutdegueeu
    keetheefueevvdeitddtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopegrshgvuggvnhhosehmihhtrdgvughupdhrtghpth
    htohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepvggurhgvvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhooh
    hnsehiohhttghlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggv
    lhhinhesghhmgidruggvpdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepsghonhgvthesghhrvghnohgslhgvrdgtnhhrshdrfhhr
X-ME-Proxy: <xmx:ajwWZ59NaJSxaNyuzYax_Mz-R7pC9scIL4utVn-Ib6kpwPZbLGMQ3A>
    <xmx:ajwWZwur_ZKop59sl1GI-YC7r_v_swsi6Nt8ILlpxnO72DYcVJPerQ>
    <xmx:ajwWZwFSuDam4UkZBGj4TDfPojjQBq5h6OdMP_0mlwJcrnLwVFNRCg>
    <xmx:ajwWZ_Nhsc-iDfkf4MigKCdA2g5uvdgjO_Mh_jP7NUdYozC-bDH14w>
    <xmx:azwWZwHnehwROTENhyZKf8r-KqClzC0-3XKHle6ZayrBLjvlX_YJhiZy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 07:35:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f1e0e76d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 11:33:37 +0000 (UTC)
Date: Mon, 21 Oct 2024 13:35:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>,
	Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Edgar Bonet <bonet@grenoble.cnrs.fr>, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/5] Makefile: adjust sed command for generating
 "clar-decls.h"
Message-ID: <ZxY8YL-dSlVVBT0K@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1729506329.git.ps@pks.im>
 <17d77f36d41fb2928565a4922eab3a67426d2da6.1729506329.git.ps@pks.im>
 <e3bf73c3-2f4a-4b49-9016-a455163616ca@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3bf73c3-2f4a-4b49-9016-a455163616ca@app.fastmail.com>

On Mon, Oct 21, 2024 at 01:07:17PM +0200, Kristoffer Haugsbakk wrote:
> On Mon, Oct 21, 2024, at 12:56, Patrick Steinhardt wrote:
> > From: Alejandro R. Sedeño <asedeno@mit.edu>
> >
> > This moves the end-of-line marker out of the captured group, matching
> > the start-of-line marker and for some reason fixing generation of
> > "clar-decls.h" on some older, more esoteric platforms.
> >
> > Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> 
> Alejandro used two signoffs in his original:[1]
> 
>     Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
>     Signed-off-by: Alejandro R. Sedeño <asedeno@google.com>
> 
> I don’t know if this matters?
> 
> See also https://lore.kernel.org/git/xmqqilc571hf.fsf@gitster.g/
> 
> 🔗 1: https://lore.kernel.org/git/20241012144027.2573690-1-asedeno@mit.edu/

It felt more like an accident than intent, but true, I should've asked.
Alejandro, please let me know whether I should restore the second SOB.

Thanks for reading this carefully!

Patrick
