Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF53189BB6
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928761; cv=none; b=bn1r8XU0mJrt3Ixv2GyKlI48U+uD4SBb+9gM2ydW5LINQ7DetIS8FT3jhbpdUqhJzTId02d5cfiWvmkAj3HWd2V5trKPZVN2XcbdiVpqEfFkHcZLkMMcBFsaxWiTNzhT1kLxdro3cs4imWImDqUUt/r6o+XCfaqUZ8/Lv+KB3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928761; c=relaxed/simple;
	bh=4qKXFKb6gQS+1GXd9vhbTybwyijirCfM7tYowmU/Ejg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1R5zoTfoj5VtSbJO7XdVLVG9w5bSNieG3gwc/B9VY6NeqQuNzb0hcqOX3s2bb7+9+cVGnejd1OMMSUm11pVpKal4LAC58lY+LvKXjq+uTygbjdXvVyzvGQPbLLFQVD96s1VHsOg0heSlEztY8xHJQm/+7FHBv4q0PGjXawaios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q3EuxBAH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EuVWc/8H; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q3EuxBAH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EuVWc/8H"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AEE4714000EE;
	Mon, 15 Sep 2025 05:32:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 05:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757928758; x=1758015158; bh=orCLj+Pv/A
	GyYSzZP6k+vQHMpNYJ1xJKL6cOSBkn5G8=; b=q3EuxBAHv/dx9vGlGIem6KOoPs
	r6yfy3h9/ZvRCzmcbhWSOH6BxxYpBDjJyAMRdcBrspBFwxi6zYXpoWOBj0et5Tlr
	DSPzAlnTatda6dTCuOcs4duPC/XL1x7jyI2DDjRfVvgg/TIitNZd03s2SkQLT9vn
	6mQjUZNQbgoea6oQHm21/ywCVPxdgiEasluYHHmL7cafGU2i7ln1IrMYpqg0OrsN
	PKISgCujzWTRiXvDz1CN4nZznJ0A8Foq+HOMgr/X0sxl5U+EJ7sJn6lmJaZv7hjK
	U+yjAQwql0CSSBFU9ZtxUGAxLo/xqglN8P7eHt0lkmR85sxecQUX21JcOrDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757928758; x=1758015158; bh=orCLj+Pv/AGyYSzZP6k+vQHMpNYJ1xJKL6c
	OSBkn5G8=; b=EuVWc/8Hy5yGZn1/M2gRaUyGU84YPXY1obpHSrhCGwkKsfvhdvL
	CZwWRrBEUpSoIBa97qhXxjf3sc7kMdsBnIAuAboTNJlOf8KOCCevSzchnGGYeUDh
	jYozeQmqpxdMxIs9q8YI3mC5frtk51thgBJAv0p07GUEaT3lMUDMEi4tW1oIDU8G
	d6KHP96dHDCeFG1l668e9IBsPpeY+3gV/xc3DhN6mLf6P9Qp/TmUPFl+UeHdahOp
	JzwhvLWZtj9sYPYAOR7fBb+itv5GsmRb8p3z6XJyAi+yxLy1D/lrUb76wHHH7TO+
	GF8Bw2ssb/iUxS2x/T3M4FHCImEqJVjpDgQ==
X-ME-Sender: <xms:Nt3HaPF0VaWnKWhWPsPSyBs6VgiF8KVuwbEF6le2V2MVVJlYGcxP_Q>
    <xme:Nt3HaBjf3SBf7G6k0w97pS-CkMVh7tUxk0zEK0E9QVL9pvX3AmlK8Oi8sjzUPhKWu
    P7FsN6NYkFtGadIZg>
X-ME-Received: <xmr:Nt3HaCCLv69M5SFFF8T3WNBTVteVBKlxiOmEw3SX9PTXvKgVrw_FsroH_X0FQSKT3KNrSOkSwenqm74DWUVFBrZnTqk4H_f6qhWAEr5QJf6-fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Nt3HaDRN0G-dX31QJit1BzAxsJYquxQCEW9qP4Dc1yBA6TFA2UOOjQ>
    <xmx:Nt3HaHV3sTdYG98WvyDJDr0vFRqrVpyZTx5V-4xUwOxw-YJGNUkkFg>
    <xmx:Nt3HaMfP3EQqT05XLMULu65XbbJUFl5Blm6rKD5XdaXzz_744r-tFg>
    <xmx:Nt3HaDL3sd8voU-iJVeT4WiVMpTWD63FUreoBf5OUXte_1tee9Dagw>
    <xmx:Nt3HaMosxXUrKtwvl_vz7edq-_WcOovANkR9ZoJc01m039VST1eVjSwp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 05:32:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2a5ee1f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 09:32:36 +0000 (UTC)
Date: Mon, 15 Sep 2025 11:32:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v3 18/18] builtin/history: implement "reword"
 subcommand
Message-ID: <aMfdMe72WB3DR4gW@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <20250904-b4-pks-history-builtin-v3-18-509053514755@pks.im>
 <10696a16-3f2b-4844-9f9c-9815976b3e1e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10696a16-3f2b-4844-9f9c-9815976b3e1e@gmail.com>

On Wed, Sep 10, 2025 at 03:05:04PM +0100, Phillip Wood wrote:
> On 04/09/2025 15:27, Patrick Steinhardt wrote:
> > Implement a new "reword" subcommand for git-history(1). This subcommand
> > is essentially the same as if a user performed an interactive rebase
> > with a single commit changed to use the "reword" verb.
> 
> The sequencer already knows how to reword a commit, it would be much simpler
> to reuse that code.

I'll drop the second half of this patch series for now to reduce the
scope of this series a bit. But once I send the second half I'll have a
look at whether this can be simplified.

Patrick
