Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89636139579
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625995; cv=none; b=rsFBwdUJAj9Ll6oq3l+MD9jGgygUlMI+xLJWNWR+xi50HjCgICorR6biKpG3nF1Ht751ZKTT4ZZWeDMziTwWDsI3VL198QaRMk1IG5eYDsTIJs4/J2/aTtUZTG1Ywuw9Uc112uaLsKKvBjmNw5HKkLpyDJjGoflb/nbPn1YMmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625995; c=relaxed/simple;
	bh=MtIU4AoBLRYqCSd7+bFdoHjR253Rd61MAmp8ywq4g24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLpsjIYPlUt6giY55Hpwr6oZIaf8L5lqZsUkBTsLC+94BColSwOTJlz/Z8ujMWLbY+1OAUeFpa884nlfFfC8JFS8xljaYZTBwz7M7Xk+8QS14y8FQ9+E+KNJIXhqoMlxSgLNCEW6M3iMOutu1z/z5+46Br2FaLCJC1V8pCbeuk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i1o/6Qc9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FCSzAqJh; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i1o/6Qc9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FCSzAqJh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3228C7A00B5;
	Mon,  5 Jan 2026 10:13:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 05 Jan 2026 10:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767625990; x=1767712390; bh=zcmgxXvQp6
	8jipT2wNcXs3THLM3hKaMouAzFz0Ivpnk=; b=i1o/6Qc9hbTGZf7QMuCBtrzbaN
	mwM+wckYK3tIw4aUa/1mhCxPMNC43fL8CUb+9lhfupxW1q8uyN4Q/GoqxXuB1FqN
	dL643N/wx4dKxCnem0OWAZorLprV3jlb1zYh7FIj/SbCL7LvTXB/5TyPC41qiicI
	xCO6MnaVrZr3i2rbIIg3Pdbjf3NJclfkVDoVZvblXYZW9IAtTSUGsR7PSNPsRSTh
	0XdTnBmZ+QzUyIWF6pJZPwqwtKkygTho8zOyXBUqZ1UDR0pFIyTcM/mOwXC/Yvx/
	OkOWNJHfciCr1Mr564fiUIWNA0dj44hPju3acF7CA+iUkfU1JzWKUUQqYUjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767625990; x=1767712390; bh=zcmgxXvQp68jipT2wNcXs3THLM3hKaMouAz
	Fz0Ivpnk=; b=FCSzAqJhlLHulaJZCK8y4Qp+n87TdBru2OmQaNlColHSf86PZrQ
	wF/jYlemjwk7FCrpLmW2iAOmDX9HmvhKOrVnqG7+AiSe2xEsqrR/TXrJzw3sAwmP
	pGnox55YYENhymVOtYOQxrs3GDS/hRgq3hNmUwblcYVrpR6tgprxAbf5jhivAa8R
	DQknzcdcjVBdZM4IJLjJTy1SPaUwZBXw0mW6xya/9A1bYtKvwVuD1ypic7h+0uuw
	fr3DKAb/0NoZ3xTKhXZVV7tAYYg1nUbP06AXq/MmhpitaNwTy25AwFPNLx74ArYU
	EoIsKejAodIfhWhDGNgEdUAQCzP5m7Q0RYA==
X-ME-Sender: <xms:BdVbafW-xcpj9AjYZzYfmyGN_GSKoMPeiSaiK-aqneVNUhRMFdFW8A>
    <xme:BdVbaZ1wbH6NdXI_DAruKB74_zFIDUjfs_n1kA7z2JqxObjqXiJfiYYX3I7uyXe5d
    M-wiUr-D_tBd7gtoRjOGAsuMkilClgpBew6WYJ6cV66HICeDtxl4A>
X-ME-Received: <xmr:BdVbadrcWCOVtYs_cJ7vTXKc9ieRIIQWF6Gt5p4UjmO2Ys9yUQb3sYxDidSaThMz0O3KoZm5_cxkoa2H8u0t0foXhLvmOXdRxYEpF-JN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    etjeejtdetvefghfeliefhjeegheethfejjefgueejtdeggeeuhfeffefgjeffgfenucff
    ohhmrghinhepmhhsghhiugdrlhhinhhkpdhgihhtlhgrsgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnsh
    hhihhnvggtohdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:BdVbaQVT6RYMHxaQmCm2DqsY1QZTMg6TCw-AW0qh5PizfehAHI_2aA>
    <xmx:BdVbaYarP4jJo59i0kcmzbIM6f7FYLRonD9NUAo4ASm2XK-V3qD2lQ>
    <xmx:BdVbadfLC93DXGiZIOIPUnx8La1weseb0AJERfA7lNYHVqYfucYsww>
    <xmx:BdVbaS1QN4e-yB2Glgk3lDcoO3R21GNqrc8rFIlBhjUHi2Jq62tilQ>
    <xmx:BtVbaVCfaIetwviPvW0jXat17UrzjwgHbRX7UVhBFu_S5Vx2zLdu618R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 10:13:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fcea1c6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 15:13:07 +0000 (UTC)
Date: Mon, 5 Jan 2026 16:13:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, gitster@pobox.com,
	toon@iotcl.com, sunshine@sunshineco.com,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v3 0/2] refs: allow setting the reference directory
Message-ID: <aVvVAH1eRxGa60Fp@pks.im>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com>

On Mon, Dec 01, 2025 at 12:24:57PM +0100, Karthik Nayak wrote:
> Changes in v3:
> - Cleanup some stale code which wasn't removed.
> - Localize strings which will be output to the user.
> - Remove additional defensive checks which are not needed.
> - Link to v2: https://patch.msgid.link/20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com

FYI: I did an internal review of this at [1] and mentioned a couple of
things that I think still need to be iterated on. Most importantly, I
think that we also need to handle worktrees:

    I think we need to do something about worktree ref stores in the
    context of this series, as we're now thinking a bit broader than
    before. It would be somewhat weird if you can change the main
    reference store, but it doesn't have any influence on the worktree
    ref stores. If I say e.g. that the ref store is located in
    `/tmp/dir`, then I'd expect that the main ref store would be in
    `/tmp/dir/refs` and that worktree refs are in
    `/tmp/dir/worktrees/$name/refs`.

    The reason I think this needs to be handled as part of this MR is
    that we are extending semantics of the extension now. This is only
    possible because the extensions are quite strict now, and thus we
    can strictly extend them. But once we have extended them we cannot
    just alter their semantics to also cover worktree refs.

So you can expect another iteration of this patch series once folks
settle into their usual post-holiday rhythms again :)

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/451
