Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B310C39FCE
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178831; cv=none; b=q/ZOxJ7swCfOID5PZADYEkfJsmx+dkdoajb4WzFeBID29XCJQWY1NT9jgSrU0K2te8ZO/cweH3FfADqO9eEignR0I2g4Ad3yUFFHACIei6hTtFvSQADOeNx5fnxhwLGr8i7KaxHzgJFsgRublF90P3Fj7wNjQ5DtcQ2KZGJJ1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178831; c=relaxed/simple;
	bh=SUiWgICWR2FHVt0190MGgY8SzbwbPEcfbVngg3hBmXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LTv2+DT2cEeME4sPcc8lOGdoxlXZ8HfEblSkhOP54gkVC3eY7cjmdw5EAOwJjDHSH67upbYKaeRSlADr60KzGQWXvAmkJZbKMD8kJ1xqp/EUvlvFavZHCF+gs+hxvyfI5Ewp9PlAJ18K73L40pBcJhLwmerFzyh0vEdt9ZetXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K9hfNLig; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IhKmOaRo; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K9hfNLig";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IhKmOaRo"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE84825400A3;
	Mon,  6 Jan 2025 10:53:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 06 Jan 2025 10:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736178828; x=1736265228; bh=UZrRj7CGmQ
	Aa+adigCmiH5FBZV9X9FIbZVCgGcgq/rw=; b=K9hfNLigXbrBZCm6xl3UC/I/Ze
	PFeX6cLaVJhupBS54cYYa+VG9Rpouo6zZ1Dynny/8SDx/3HuxQ3rPYJ8w/gBlh/a
	Iqm7wn6HMIeC90qK8CWgT3GV0W0JGlMG4oBcHtJmfryVXnwvhc+VAbBq3wOhwunD
	7/m5AD02e3k/92b2cXE/uaxxOKiHPFm0HZbW0DBXbNTyjnd8HE5vRjTvhZUVm8Uw
	r7j8XHYAE3hP+6cFESd3o/+GxxCatSTDoSC54NNDXakKj4Kdry4DC2YQNbBdOuhc
	SiRrzH39Mh9MDWJSWzyXA0hU8IdAVghEiTjqoND1fAaWrWzF05DpiXUrai5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736178828; x=1736265228; bh=UZrRj7CGmQAa+adigCmiH5FBZV9X9FIbZVC
	gGcgq/rw=; b=IhKmOaRoW61AOFnW97NyNgdJ8tViSrW8d1bsjMsuDnDAbgggda/
	eEn8S/G0DKV2DKnjnPF0c/6KtGHkKhJ6y7f8BDoaPDAI/23TgxldjAsF/jRFe9KY
	dusrACnkKoa4Cn3zgUPx5ANc9z2jExmLmYKnaVdjj9aPV52J2Elw3F+IoKCZVPfk
	3R6BJmeXM+synhnFfMKJCMybVuwlb03EMOfxMrrg1EpcZd9X+OBvkKkLcfy34Ow6
	3NO8Y/5qGnwT2lj+FoQckQLb9w6zijWXSr+3xEiVZ+R1MnOCjcAkrisQEG3dbyQk
	mh5yYtms3F9ZP2MB4t6tI+lrfsmESvo9+Xg==
X-ME-Sender: <xms:jPx7Z6HOlYH2tgwrzuX8j3pAvwwVBrTuP9qkFheoTgYaqP6nSht4Tw>
    <xme:jPx7Z7W8zybOuSOZjYzxtllNxWdCP5qPcJFaC4ByFNYfikFMoKIQCx3dsq_O1jPw2
    nZEUtzRgh1ubXi9jw>
X-ME-Received: <xmr:jPx7Z0JPOg5JcM_iAOltW-ZiHrZdrSDm5s3vEAJYMyEeJEuSNEk6ACaubgq7QlpVta5x6NfF0VEnv2kfuwGIsVo6Rwjd2tDPVGiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnh
    drtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:jPx7Z0F3xAOfcnTitR2ioTObaEevA8icy14IwARScSz5isnvfIasWg>
    <xmx:jPx7ZwXx-qcqElpKzXQjHE-Sd97QYXgtXWIrvXskiOsOPgs3amIzOQ>
    <xmx:jPx7Z3O55QHtl9J2R_PQtg-l0_hIUpQoV0wR1d9mXP2cTPAdRGSdIw>
    <xmx:jPx7Z33ZDlaaLXT3uzME3mCxm3mcuv_YUs-Rl294HO6obal9eq5A6A>
    <xmx:jPx7Z6cUT6Et8iKO5-BFldnvRBldHP2-6lC6RxCdo1zulpbTNXstBoAh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 10:53:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 5/5] remote: announce removal of "branches/" and
 "remotes/"
In-Reply-To: <CAP8UFD0Lzazxyq9nnT-vwN=MijKAsYySFC2dvDEj33cS7VB0kA@mail.gmail.com>
	(Christian Couder's message of "Mon, 6 Jan 2025 14:24:30 +0100")
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
	<20250106-pks-remote-branches-deprecation-v2-5-2ce87c053536@pks.im>
	<CAP8UFD0Lzazxyq9nnT-vwN=MijKAsYySFC2dvDEj33cS7VB0kA@mail.gmail.com>
Date: Mon, 06 Jan 2025 07:53:46 -0800
Message-ID: <xmqq34hw0whh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> What I like about the removal of git-pack-redundant(1) in the previous
> patch is that we started to emit a user-visible warning in 2020 and
> now users even have to pass an `--i-still-use-this` option to be able
> to use the command. This really makes sure users cannot ignore the
> fact that the command is deprecated.
>
> Accordingly I think it would be nice if we started to emit warnings
> (that could possibly be disabled) when we find a repo still uses stuff
> in "branches/" and "remotes/". These would be much more difficult to
> miss or ignore than doc changes.

That's an excellent suggestion.  Even though this topic is about
introducing breaking changes, saying "we waited for long enough",
making sure we have prepared the user base for such changes to
lesson the impact of "breaking" changes is a very prudent thing to
do.

I guess everything is contained within remote.c these days?
Patches welcome ;-)

Thanks.
