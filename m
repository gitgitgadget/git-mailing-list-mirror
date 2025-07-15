Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00578231853
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580744; cv=none; b=c2QNbTyhdyl4NqcHYFpIJybnEBqKvemLrKYKw97GARMUZh0g2vFS5Q2Kb5badcruM4rn1SjOrwazFGwjK//wPr3q3OShGCJQyA485d2emLwvCIldSJDbR4ehf/+s6P9z9rlvkwjblXbdqPtkM6uQSUPzexTg73fO2Gwael8ICKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580744; c=relaxed/simple;
	bh=EELItxI/5piA6c+36E0nseuGNj2dmaiVT6QeySz3gsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtANsqnJ/2U5c342ttNoZH/H6KmHsYh1K7nPjFDYr8N0mueeosdLIxntX0zxwke1LYuX4WmKq7qYB4emRH1Q/oU+R65ikP1UaYqkTVF8vuktvkbOpzbaMtSXTnSwBswHJyeNz5N/Vmb3s5oTnlOkKmX44FKcPdSJhO9zNwE+GDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qL1/sN8G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ddKt27g/; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qL1/sN8G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ddKt27g/"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1385714002D2;
	Tue, 15 Jul 2025 07:59:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 15 Jul 2025 07:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752580742; x=1752667142; bh=kavTupo2D0
	cMiEFNJyTc6zG2YcAVEW1/TEf77LwqHgQ=; b=qL1/sN8GGrtm3bDSGpJYnbTIPA
	cvrTEwA+CL85sKfHJ9MTp6uNuhSygE/sj4YmoChayhe8pdqAgak87PvQWxQdbbZ9
	qHvNRzqoo9hh3msWMpYOAuZCEF1DHeps2TJ4Zx9jji8MADMa1a85Ha3sw/uIJhxY
	7kYLymJ894oslGWhR44fe8qZ0x/macIjHUNMuoNu3UzvssoNQ9fTKGRoiroh6wyZ
	bPb8lbvdILOLE4mcCpucpEdz2Fswyj9xO4HQSkOL4Hw23Uz32UdxJwLdyKueCXom
	5cv3J22XAqvmqCo6PxacL2EbNO17CM8xFsZfo4Y2xbmEwyfOuPyihPL3O2tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752580742; x=1752667142; bh=kavTupo2D0cMiEFNJyTc6zG2YcAVEW1/TEf
	77LwqHgQ=; b=ddKt27g/Upx8Q8AB72CQR7xJSGGN4+KxLskShCA7mDDvSr86XYV
	JBo+kcxTCO84i3kRDJ2fOdL51gX6dhF0z7JxxI6WxiprKC+ye5++SXhMzqUslnWI
	NeIIiZjmZGXqdTvHzJfwMTl/CATwyA40ltshNOLVU7FGYONLkFqRTj4hwGkZyMKr
	OyrZN0/nYLLH8BM6/XvEYOcz+5RHclEyevIi/ne8S7spqE3MAObIZVrFc1jAT5sx
	zV1IQYIC3YxYluuidigg1j/PJM18BCtoZNvu/3liy9rdPIMK4lbNlxA8VK4UtZWF
	fVqs4dMfzImMN593rOJ+KkOwrd9S34Ycydw==
X-ME-Sender: <xms:hUJ2aJ3IVC0gGHnqWi-IKLt6U_Hs-IrVcRhrBPhUo0U_SKDS48OESA>
    <xme:hUJ2aFQHUbgwmOmJ_taJOMFyfuGru6d9NdptOnwJkKCv_UjBs9aEulsF8sPp0PnLF
    u02Ud8VSEd8e0TClQ>
X-ME-Received: <xmr:hUJ2aKyUPcHji-x1z87C7NBiQV-mx5GqF4_aqkc46vmfOQDo2zgwiv82J_rfWrpmGJaLmU_GHkKtNpAvezom39plzqFuizQNvlBOs2JiWCDnag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhope
    hluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhsfigrlhgu
    rdgsuhguuggvnhhhrghgvghnsehgmhigrdguvg
X-ME-Proxy: <xmx:hUJ2aNAlHlRybMgZlbgjbZSKkGSMjaF99g2Pauhu2NJijwPggzWhVw>
    <xmx:hUJ2aOHZQlXgisSmCmpWiS5MmDuxv-HpUz5PcIZLCBAvGs6BodpOPA>
    <xmx:hUJ2aMO_wN21yISTZG1kVjDJCryL01nlTJHFPNNE7tab_eaBBSBjcQ>
    <xmx:hUJ2aH6Nq4ZLT0f8tJNAfW-c0f7-TmfJKfG4YXIKjxwc74bcNOIMiw>
    <xmx:hkJ2aPtUqQjxGl9tZLkotCpmYn28ZZo2J50K9_8uTnvYBn_l-lfCYiOD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 07:59:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d82dbbdb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 11:58:58 +0000 (UTC)
Date: Tue, 15 Jul 2025 13:58:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com,
	phillip.wood@dunelm.org.uk, jltobler@gmail.com
Subject: Re: [GSoC RFC PATCH v4 0/4] repo: add new command for retrieving
 repository info
Message-ID: <aHZCfynoeMDRdN4X@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <aHYuwlWlbkc600Ps@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHYuwlWlbkc600Ps@ugly>

On Tue, Jul 15, 2025 at 12:34:42PM +0200, Oswald Buddenhagen wrote:
> On Mon, Jul 14, 2025 at 08:52:27PM -0300, Lucas Seiki Oshiro wrote:
> > - Renames the command to `repo` instead of `repo-info`. All the
> > functionality
> >  of `repo-info` will now be under `repo info`. The functionality of `survey`
> >  will be moved to another subcommand of `git repo`.
> > 
> this strikes me as a bad idea, given how established the `repo` tool is.

The `repo` tool wouldn't be executed as `git repo` though, would it? So
I'm not sure whether that really is relevant at all. On the other hand
though I do see that it might be confusing when you interact with the
`repo` tool on a daily basis.

> without much thinking and reading prior conversations, i'd go with "query",
> because it's a database-like metadata ... query.
> the obvious followup idea would then be "meta", but that suggests that it
> isn't only a read-only command, which i think it is supposed to remain?

"Query" is way too generic from my point of view, as it doesn't say
_what_ you query. "Meta" might be a bit better even though it still
loses the information that you act on the repository level, which is a
bit of a shame.

We could of course adapt and call it git-repository(1) to avoid any
confusion with git-repo(1) and repo(1). It's not like this is a tool
that users would typically have to run daily outside of scripts, so I
don't think it hurts much to have a longer command name.

Patrick
