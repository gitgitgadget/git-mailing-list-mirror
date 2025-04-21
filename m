Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F71D516F
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745278442; cv=none; b=YDs42rbtFOxYmx5MzbYH+sIYU6JSra34dMlicNSKFVZuynrFiBXpx+0nII6trYxLKQLOGaHS5/iX1MeLjmFmR/O/gsoD9W3B/ydgulhOHOWxKQaT1xlSz3dzP7SslH/vT+poTqfbsJBg+bBlRy3yiEdytCCJZZ/NPkR+ZUVGt0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745278442; c=relaxed/simple;
	bh=wwrROWXcnXHK9143LjjCSi1e0lwGcVNvuuZTlcoxp60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZmVCTLJloIcAcxeNt16O1jq3POtuBcO418pNtxQfMFCFbXftNkJyHdgKYrogNNg7mCCCtm2qfGIfl95PGKvQJDRbFTjax1CCzTHYZoONZ3IILV/1+sG0j4OK/fJIg6MSFyyQThX1s7NUWGhuSHDmad080HZs85xKHrQHVOkBmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Uw+Ip84M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h2c89cLZ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uw+Ip84M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h2c89cLZ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 46ADA11401A4;
	Mon, 21 Apr 2025 19:33:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 21 Apr 2025 19:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745278438; x=1745364838; bh=kWVwriV1lx
	2loYwI32BFiyM4FPi9QTT/22fzQcz2pEs=; b=Uw+Ip84MRn5mosTG6ZI9esdsBK
	4Ai0tR9rL8W/z1+fYfX+oaB5wT/td3ccEnZtO3JMgN2eyB3Vgt3hBXLqaTBKxo1Q
	yBI+Ho+VOyglHy7BGwubs03RW2m32gyJy4lzuizjzidDbuMqNreo5WInA3o2il5S
	4AxQiVdH1+UoiqU5yQVIVWRfpTpCn2n8kE5pxlmoKO9MvrL4QQ9kC+vzf7OaZuv4
	jCAbjBzk9F1MBxAQUstEWG/I5Ia9Ghm/rWfeYtVBoR6nw0CF04NT2k5AgKapUyQj
	JCa02FVOP37wCg9MQqm0FbHh9j4nUAJDnvtflKFObhkrUO4OTzfo1n3u5jpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745278438; x=1745364838; bh=kWVwriV1lx2loYwI32BFiyM4FPi9QTT/22f
	zQcz2pEs=; b=h2c89cLZtKppc5FGUjxaGGZqET35eRHHhDb5e/y03nhAX06NtkY
	yCITBJEee2N6+WxCmZWOG4FLdVI6onJsv+gEAfsGJIxd4whAnE7PyYHJpIU+LUPn
	GD5ERj84DZVA84Xrlhgx3lV3I7EHDeCxOfJGON6mC3qWq6FvF54iOKbTHCv71PAM
	RxJGTA3gRSM4Dnxkomj8lRU80EaZeNuZfvlaNCeFP7J9Ik5FRBiStuKHO0DEpa+c
	wsPw/BTlEq+12ci7PRyz17FzGy1fPOjOQyi+nzTJT9dpBSnJvleizyVL+bgj4hA1
	BXI19Lg8a4sZ/DXa6Mn/V7TNQPizEpN7Mgg==
X-ME-Sender: <xms:5dUGaFpMpwZEZeBqVRtP1hXlcTeFkaf7fdxEMt5y9ku0Tw_yyizjiw>
    <xme:5dUGaHp6wtovShU7EPqoxaOf6Vfc-6FN-aMgIDrf5MIc20pR8CaG2Io6LwTX6WjYw
    dKkRoaKjhPXilJQ_Q>
X-ME-Received: <xmr:5dUGaCMasIo8iEABuhbyq8pFesQU_eJ8wzdjlNkhAiL55ldbr5lvJVgf-fsKUyoQ1q5YUC0HWMovHx_VO0YEow2xixodZ0feRg68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedvudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5dUGaA7_nfvA54t691nl3QM4Gj0I7-vH4E7twJN8zJt4ROBanSDeDQ>
    <xmx:5dUGaE7xl5YJcTc2VCcUzA431xiD_-l-d_BC2NeoKXB6A1jTaER8ug>
    <xmx:5dUGaIhuTDqw1VL-HWfRBIeCblnK0tag3Ros5iEjUzl1l4H5U9qQZQ>
    <xmx:5dUGaG7R1sVoNw-efkKFAnJ3nAirIkdfx8QpVYVPV5fgtxPf0K2Luw>
    <xmx:5tUGaHfNvqxHt1yvOeMyug4lfdyZsT7PWH_fdN6t_hv6r9meVWtswKD6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 19:33:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,
  toon@iotcl.com,  ps@pks.im
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
In-Reply-To: <CAOLa=ZSa-qQzi3iWPF+M5a4EsvGiQFX=2Ca=vzuqwSLWWXSw+g@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 21 Apr 2025 16:08:46 -0400")
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
	<20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
	<xmqqh62i6jli.fsf@gitster.g>
	<8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
	<xmqq8qnt7c9w.fsf@gitster.g>
	<CAOLa=ZSa-qQzi3iWPF+M5a4EsvGiQFX=2Ca=vzuqwSLWWXSw+g@mail.gmail.com>
Date: Mon, 21 Apr 2025 16:33:55 -0700
Message-ID: <xmqqldrt5bto.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Step #1, clones the repository, since the `git` executable isn't present
> at this step, it uses GitHub's REST API to obtain a tar of the
> repository.
>
> Step #2, installs all dependencies, which includes the `git` executable.
>
> Step #3, sets up the build, which includes setting up meson in the meson
> job. At this point the `git` executable is present, so within meson
> `git.found()` would be true. As such we run 'git ls-files' as part of my
> patch series, but since the repository doesn't contain the `.git`
> folder, the command fails.
>
> So like Phillip mentioned, we need to ensure that the `git` executable
> is present before step #1.
>
> I hope that makes sense.

Please roll that into the appropriate commit log message for the fix
you'd send out, so the next person who wonders why this topic broke
the CI does not have to ask the same question.

Would it make sense to just swap the order, then?  Our sources are
meant to be buildable from either release tarballs (which is created
by "make dist") or a repository (with .git), but from the analysis
of Phillip and you, it sounds like the CI environment has been
building and testing from a "git archive HEAD" output extracted as a
tarball, which is *not* something any real users build from.  Making
sure that building from release tarballs works is a good thing to
ensure in CI, because all our developers are testing in their own
repository (with .git) so we wouldn't easily notice ourselves if we
broke the build procedure in such a way that it would somehow
require say "git describe" or "git ls-files" to work.

Thanks.


