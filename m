Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A80337D114
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655029; cv=none; b=bC4xoyMCuw+BW4pHAkjBOTHsoWDomfC+pBBIl6C5Rw6b2GamWDAma1eju0K4fMF+3Owjo5YrpbV++BFRNHG49xoMVmxEAE0yX7HK9gnmuR2DwNtsln7iwB3vrfWZH1zO94ggjkW64FniBL4c2LxIkNrMdeKSzYSCg6GQM1vK1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655029; c=relaxed/simple;
	bh=Gyfqwiq1NGJZzaX62NTtDhyvRNJtXvdgEs0SGHF/0H8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VexM04A5FFxKjzUeQQ0lXk9qiVamAbWzi4j3T8IVCD/0970Y8Z6aYBlYxxHKesC9utZhpyjKsVqucu53AUXgYBTnD4bBW5z1yQmA0+wsJ8WC9NuRt0MNkCleEUFHz1pA3JiIKszgniEtOhpgc29wuVi9+3NNst4IdOMVTOXAG+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uJ2Piloh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TpKf2qai; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uJ2Piloh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TpKf2qai"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D4FE7A003E;
	Mon,  9 Feb 2026 11:37:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 09 Feb 2026 11:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770655027; x=1770741427; bh=cxpxwoMlkk
	191YBZI22L6uZRMIQD8btJFHhLfdsdj94=; b=uJ2PilohB99meC6rXEarHG0mvI
	mJhUpL77IJAFH39cMO+a8ntQhFsuXe6WPdrKZZVLh6IbE70uO/+/1QLbPvDsUgND
	ngUYSM33sCh3BAr2adHXUKVoSeT3ldGBPZSlDTxMUS5r73HcVhgpl1OFdCVmHnzB
	0If+wbMGBNjICYvCS5hBCt8HCzxqSJnTSQkaMJdx6TpZDmef1YAcN2hqndPVxuOp
	amBGCxZQzvIe2H+Wq/iyNzdOdR+/9lrRAApiqUN6nbaXTK1tOroUtS3OOH9YFmcN
	4lMeX6kxSqzEf9kPnhlXsd9gUg+mKUt6ZTT3YtcvA7+RTbv523rnNLlfetdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770655027; x=1770741427; bh=cxpxwoMlkk191YBZI22L6uZRMIQD8btJFHh
	Lfdsdj94=; b=TpKf2qaiuo5MhzmnkZXDmv4SNW6QZ7VQIUcTnJwM2gLBjocNSNR
	RENzyyER8/8LSKtPyiqoYOoBtQnXzUe3ZSu4K4se64qIwwpFTJcTfvi/yovZh1M2
	VO2FTHT3q1Nf6yi8hFLv2toLMfFA2dhAxbpUkDjEhVRzW2HIlVk1EB42HmP0jQs2
	nke0NQe73yzgGVxtjhweLMx9KdyFdMH0mt1OjYrM22G8MogHnGhOcd8xu5rrh1sa
	ZgoX0kuCi6aBP/BFjavYYgPUsrtT8ftUbwURjE3nfa0vVsowGhBjDN1ZWbkisP4O
	EZwdSGB6+UJuizZVI5Xee/Uf6c0PoTW/G+A==
X-ME-Sender: <xms:Mw2KaYShq-Ui7w0YEzZH-F8VweLZeMoo_WNfPTwGNATjDrMmd-oX1w>
    <xme:Mw2KadNUsgzKI1uQKferFns2g2ZQ2LNkAPhmdrB9mWsb5F4qPZnk7MZOxZRvDYwZc
    Pn9PLIUOXnxiIJIugmdnXux-rKW5ZXf1JGOpdBNez1tEmZdhCuMMg>
X-ME-Received: <xmr:Mw2KaTO4JQEAPWhElVhd1kxEkjuXUzkCWYQlNINYmvSszcEjBpVAreYKM4T4JMTQati0sPFK85QsjizLp2uEt0Q-JUmFqVtVCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepjefghfehtdduveekfeejffeiveekudehgfdvfedtheetudeukeekueeuhedu
    fefhnecuffhomhgrihhnpehlihhkvgifihhsvgdrphhspdhuphgurghtvggurdhpshenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:Mw2KaVvDW1IxBd85DpbMJ4UwQj7Z8QbDibq1l6DMVPInGcOL5Gd5jQ>
    <xmx:Mw2KaVVr2-7d7nYBAxMtyIySN4RP543PCUItNwzoVe23dRIAxnGoyQ>
    <xmx:Mw2KaVuSyIikgmPCSxiMtKfIY9j4QRdRdYGQJ_c3Ix0kfZy4BVsWDg>
    <xmx:Mw2KaZUcm7RoSXxX0LGkURx2eM_G47M7sHgOgriw_gKaTD-fdzHOGw>
    <xmx:Mw2KaayYgUpoIxbH_ia_LrJ4GNwa9MPrBDcjLpZLUdwGqKugxP9T77HR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 11:37:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2026, #03)
In-Reply-To: <aYmleK3kGqzLXyJe@pks.im> (Patrick Steinhardt's message of "Mon,
	9 Feb 2026 10:14:32 +0100")
References: <xmqq7bsob0wo.fsf@gitster.g> <aYmleK3kGqzLXyJe@pks.im>
Date: Mon, 09 Feb 2026 08:37:06 -0800
Message-ID: <xmqqv7g56fgt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> * yt/merge-file-outside-a-repository (2026-02-05) 1 commit
> This patch looks good to me.

Likewise.

>> * ps/meson-gitk-git-gui (2026-02-04) 1 commit
> Probably makes more sense to say that this is waiting on a pull request
> of gitk, as the patch series itself doesn't need to change.

Thanks for a reminder.  Updated.

>> * jc/checkout-switch-restore (2026-01-29) 2 commits
> I think this is a good change, and I'm happy with the current layout. I
> had the tiniest nit on the first patch, but really don't think the
> series needs a reroll because of it.

Thanks again.  Updated.

>> * ps/for-each-ref-in-fixes (2026-02-05) 4 commits
> I expect it's ready, but I'd like to wait for Taylor to have a final
> look before we merge it down.

Noted.

Thanks.
