Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42F311946
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770675740; cv=none; b=o/eRAoxrgqRT026Si0+xvb30mJC5FefkA2nXx12mLGXdGjgK7M2Koo277MKvts78pTFElKCLcSDjfr+Kugo+6AKtItFSWPRh9JMAULagErbZIfTUZXHbtBZtJy+MReQulCYwRPea/BhCtvScoB0kEH1w8tQ0+2dmoBMuV3wmWRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770675740; c=relaxed/simple;
	bh=w+CPKupKZBzkMxgN9DKntzGkGpkA6GoRDM7XedRWTeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bmJrEcfsQ4Wo9RuDxpFsGNih0kvStWCrI6BHMjKzoqAKmi/2gLUQPYcoBpEAvBRwdUfScI1mr9/pcqNoYm/8JuJp+rataOdrviV+gwXK8g9uv93JQlrphKQtG+vP0rSN3C7zJE+iZL98ui9igE3XpTrN7Z1B9BclKvIALKSO4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UWNv3jE+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OSVtN/MP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UWNv3jE+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OSVtN/MP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CC40EEC0322;
	Mon,  9 Feb 2026 17:22:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 09 Feb 2026 17:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770675737;
	 x=1770762137; bh=7B4+IWt9GKxJKYHxl6VZVJSv1ozo+hrVv73fJMZPvrc=; b=
	UWNv3jE+zqDtKPxXy/UWoesbvUfMk8AALJnSMtg07YwLD3p/lpkp7J4jU4q00gy3
	jIn1C78jtQzwDKG7W9jeUgMVQTMWUPnOZbIoHd3nFzVrZwOU1XaQWXLKF38yZDhe
	+nxP5l7Djd4A3jA089ecpoFrWE28EtAXmVsZ3UEaFD3zQC3yeoDpAc6tZz0POEqa
	3JXJ7EgQ912s3wAjix88Ezuc/ppSRdaOdFzaegBcJkWxRGnn0naLig9tyaqAvSRZ
	/lTTCsKDBlBaWZxLY6mB5MVPVwdgPaCqO+UKOCl88OitIO4L9/eTmDSOHUKJZG5s
	IAkoeKluvLoNOsPQ+CaaVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770675737; x=
	1770762137; bh=7B4+IWt9GKxJKYHxl6VZVJSv1ozo+hrVv73fJMZPvrc=; b=O
	SVtN/MPiYZdfVPZX3fZUyVQXFpFfsIFa07FToDWXv4BxMzdB3mPUFb9jPAZb2JJH
	FTnftrm59H8m97S3d+1hF/+hjzDcIeGDDPccd8rcVp+ZDz6iqA1FsujX3N8HlS79
	laOl02qwH4rfQ/v5l/XT2g6EDdVtohEQ1UVuhvJve8dU7Re8v4CcQvD7lyD42/A8
	ZeQceNiek7XkZXaJKgHxZ4z7DHd8ZObtO4bzaZuRYmR2aQGCgKWcgqb4CiO1r0W/
	cBnIYZQu2YCcAK07G44vOUFGIkWkSYNf8f4i8m6w5qV+bqs4KnWUm8hvMYf7OzCR
	cytrD10/pUKTWz2SZi5SA==
X-ME-Sender: <xms:GV6KabH0gtRev_n_eO4HAAbSaga2LnWrlaf6S0iS7YPq9vo_1HWH9A>
    <xme:GV6KafMb8k_nJyvVE-2SnvU6IQ0ZpHbtUHH0dsyQ9v20T4125dLsw7Pwc0q8y79mH
    iwonhFOi5N2uVqmTzNnKS4pfakKxUKGN78xTRA_BUvCnDudJYnYZg>
X-ME-Received: <xmr:GV6KaVfLSLDhN26H6TmtROmlSzVoJvcQa4F-pI2qKNrRmGUpuHQSNhIOQrX3CyuzGAhWzA86I4laCZwdMTHlV6f8QgmGKvNZZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GV6KaUvog-HxJVIilt_yMdZgYc4d-_xBE8nSxffmn8BhzuWH35Ov0Q>
    <xmx:GV6KaekGF-w5kLv2vxK8lq9-aaLSeVJQ1vlyxerCuC75HHeDgVMZtw>
    <xmx:GV6Kaeygy6azpTNnGeeG32aimvl0WrMUJTr7JIiBkEoc9ZAllUwlig>
    <xmx:GV6KaYPUEE97ElsB7wBt7a9nB6bOGRnew3pjp_iIgzbEPaYChQ4dqg>
    <xmx:GV6KaT92UGSUbL63z3IhEsHMYdObI5n17w20CtCEYIr4ABR9AENMstsu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 17:22:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 0/4] doc: am: improve command linking and add am.messageId
In-Reply-To: <CALnO6CBTWTqfVNerHQb0X4Y4UKXggRdqzgXqYKd_O05shC+jNA@mail.gmail.com>
	(D. Ben Knoble's message of "Mon, 9 Feb 2026 16:57:45 -0500")
References: <doc_am_gitlinks_and_am.messageId.321@msgid.xyz>
	<CALnO6CBTWTqfVNerHQb0X4Y4UKXggRdqzgXqYKd_O05shC+jNA@mail.gmail.com>
Date: Mon, 09 Feb 2026 14:22:16 -0800
Message-ID: <xmqqv7g536cn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Mon, Feb 9, 2026 at 12:35 PM <kristofferhaugsbakk@fastmail.com> wrote:
>>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Topic name: kh/doc-am-messageid
>>
>> Topic summary: I noticed that `am.messageId` was not documented. In the
>> process I thought that the way that git-am(1) refers to commands is a
>> bit off. Replace all things like 'git am'/`git rebase` with
>> `linkgit`. Also fill out hook documentation.
>>
>> Notes to the maintainer: this conflicts with topic
>> kh/doc-am-format-sendmail in `seen` because of an adjacent paragraph.
>>
>> Kristoffer Haugsbakk (4):
>>   doc: am: normalize git(1) command links
>>   doc: am: say that --message-id adds a trailer
>>   doc: am: add missing config am.messageId
>>   doc: am: fill out hook discussion
>>
>>  Documentation/config/am.adoc | 24 +++++++++------
>>  Documentation/git-am.adoc    | 58 ++++++++++++++++++++----------------
>>  2 files changed, 47 insertions(+), 35 deletions(-)
>>
>>
>> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
>> --
>> 2.53.0.26.g2afa8602a26
>
> From a quick glance I don't spot any issues. Thanks!

Yeah, thanks, both.  Queued.
