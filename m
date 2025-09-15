Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19132189BB6
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928836; cv=none; b=MynYVd/qTyA0lozC8XEsUMuVn0lSZUdb07EnCHYMA2TD2UyBMDM0/ehlCrPlEp9gPvy1FdBdEpi/QnzzT1SJQQKAIEmVb8T6Ni0b96mNkBaZi6RRTD1L0ZIGNTh0RGVWTTTq7LIOkNcB0k+jefMYdJOYbu3LqA/0e1RRlXjQdyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928836; c=relaxed/simple;
	bh=BBOPrqenLgMRt/F2MQ0mXpXLmn6Q3D2ff08B5751aU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTTZJCJ+hFEXRLPk0AvMDiZFiaNq9RNJ+BveT6bbOBsklKDKGjl657/GXItufqLAC0CpnUsdl1qmPJ/3keymBJsxqmOtDxNSfeTlNTCWDRpEbn+o1BLJtRhFPEVB393qe3tl5Ijm+qNRFwIqb78fmXJVB2xXUTakwofw2j6kFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KDVBqs98; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aaHkkFlH; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KDVBqs98";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aaHkkFlH"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 7DBD0EC0047;
	Mon, 15 Sep 2025 05:32:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 15 Sep 2025 05:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757928746; x=1758015146; bh=Wm0ixF5FU1
	KEUDzlTUeLTLwjxvmhnwuGGqLGA6sOO0o=; b=KDVBqs985xRjY6bGBcowTHbmxy
	OnDHj7StQnqxTG7OdtHNqOrrYrWyJsNkF0Eb6ipvnq4n//L+m98PfOH+v+LMZObs
	Yhwmb/cRmZqtE3p9T/M5DBBZ7jZIwvsFxqDVcdE4WzYHG6CK6uGRePbOZDBbs7WJ
	wiunpmnKSa9FMdYdNg+2VYKuiSKcCofEv4gS+4hPR6Wdo9k5ZbGEW3VQDaiWrDRC
	e2POFrcghKQdTnA/S0POvGrJDbYdR08JFBEBOsvslSjHKtcmLp2YenXD8SP/SLVM
	bLDeo7Vbx7rFkgB5F6KPhFDAVywD9o1c0PmbMWF2QlJdpa4jjGQaCl7WQ0MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757928746; x=1758015146; bh=Wm0ixF5FU1KEUDzlTUeLTLwjxvmhnwuGGqL
	GA6sOO0o=; b=aaHkkFlH7qfENC65fYHYO7OaaU1Su655eTOUuk1dBEVhCPiDUtN
	L+zSSHUvmX1+I+B59NNcznJjgYaqiyGOdcrNFcYUWUCLvQ4fpyLJsADvMLHRgfNf
	P6MXsXohbPunOL5Xpm+2D0qDSrM9Aftiu/1gS/WlSjBH36j7exKaE6VHZrTue8hk
	/YqmrDS6xhGRhJuaweMpHByt6xF4YaaiiF7XjopTC3oF2bglvr5IRb+VCCrGuNIG
	kOWO7+0lur5wZs5MRL6d5iyTHHybJSv3TUIkXNsfWprIDwshYeROXGct0IOEugvl
	6gubH5/UBGLMVavDleG83Sni1O5wHYWfiHg==
X-ME-Sender: <xms:Kd3HaKAM84LYIvNTGX3XxA6s6Tvh32SVXAV4MYuBm-AJfAHrB8Rzhw>
    <xme:Kd3HaJuukqq_RtQzphEDq1j81oFx4gL5ooY0p6Acah5c4M3GFwcj8wOgNnGNUkx7z
    T552gM6B8h_D93gwg>
X-ME-Received: <xmr:Kd3HaOeX76qLujc6MXaL3t_yeatNAl1wlJi6rXjR9rIF4iV9KfLzgtm-v_K1JJDhS-4wLIpRgEvLYU2FUbX7REyjN9A5m-Fa27LhzSjHRz5VrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggv
    nhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepshhorhhgrghnohhvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtg
    hpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Kd3HaO-HNOgf7bewZkI9UtVK4Zd3Wz_x_tEReWsJrFiPlwYT1GzPdQ>
    <xmx:Kt3HaBR7htXWssYPl4oyHrvcS2oMTa-wAF7ZJVqG0FSu3F6sobS8LA>
    <xmx:Kt3HaHo0ZBJLaNfjy0q6vgUqvoifbO5yNK1Vh9EQdVYh2HyXI5me0Q>
    <xmx:Kt3HaGmp1BV0J5CzyKsb16MBc3sP_u3dycArLbno6xsUpzZfF-n0ZQ>
    <xmx:Kt3HaPN20FaBgKk8ArdIqJ1rOYKWpitoGDlNmr6XkbvnLXv0gZW1iQr4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 05:32:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5ec5e3d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 09:32:24 +0000 (UTC)
Date: Mon, 15 Sep 2025 11:32:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v3 01/18] sequencer: optionally skip printing commit
 summary
Message-ID: <aMfdJZgERk9Hbjlq@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <20250904-b4-pks-history-builtin-v3-1-509053514755@pks.im>
 <fcb3355d-c9df-408a-9e28-421a7a18e1fd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcb3355d-c9df-408a-9e28-421a7a18e1fd@gmail.com>

On Wed, Sep 10, 2025 at 03:01:54PM +0100, Phillip Wood wrote:
> On 04/09/2025 15:27, Patrick Steinhardt wrote:
> > diff --git a/sequencer.c b/sequencer.c
> > index aaf2e4df64..7066cdc939 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -1742,7 +1742,7 @@ static int do_commit(struct repository *r,
> >   			refs_delete_ref(get_main_ref_store(r), "",
> >   					"CHERRY_PICK_HEAD", NULL, REF_NO_DEREF);
> >   			unlink(git_path_merge_msg(r));
> > -			if (!is_rebase_i(opts))
> > +			if (!is_rebase_i(opts) && !opts->skip_commit_summary)
> 
> I think it would be cleaner to make rebase set the new option and remove
> !is_rebase_i(opts) here.

Good suggestion, will do.

Patrick
