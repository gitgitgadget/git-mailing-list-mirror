Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908FF192B86
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483867; cv=none; b=dTpXeqFRZP/txk/LZuSySGyKScwM78/VdoVU65vKjhOel0r5yLjnyNQhLXAXYyqBLQCeAsg2HzXP1uvwjtJn1utun3vLM8LEca9c7brKvaxOrOkeD5z/Hqq6QfBgka1Tx9Cx5+KzaPjJX/ZTtChf3jWQLf+9XL57I8ahk2mqlw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483867; c=relaxed/simple;
	bh=Wy6mLhk0uhQfeBEpsuo8/kVliOqQ5W/JiTIrgUfpxVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhlzz2geVHfKsi3dnpd4LIuKeiaJ/84yBV+MYqVyBk5wkWxCOfiK3Cv2eAaLNXX7xmALdZ2iQIRKaeUPhKJpTWOyMPNVIqjSPb8K5akw7y6qigRFeSOIniCsUIFIV5b39bgW6nf4ZqeWgUWNDPkXU1XLVAkcByn0sTcamdQEKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WsHsJhsj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ulllypvn; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WsHsJhsj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ulllypvn"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id AE5B91382719;
	Thu, 20 Mar 2025 11:17:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 11:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742483863; x=1742570263; bh=uwLMhqq4CX
	PT2+8u7y+1JgqDy/pP5CB4j/S3dXc11bA=; b=WsHsJhsjaQlakAzf97uoUE+HtL
	SlhH3aeQWTzJHws9gGIuwnEHC7itDpRYs6pjU/2Gis+a771D+2fr15SECzD55dDJ
	e2el3mgHCsSTNHHQEkQFr9Ut6JEDYNEVkSr06ZtJv9uac8LOUGYqQn9WHXiXyHDZ
	skbxb4oZBnkws8hkFlpbrE19rPfHaVr79+yl04jG0UePWNFE0A/4dVMZJFhSHhKE
	BgpnfG55NQ6RA/KcjUJ3b3vEEmusSr65zMnv0JLxAw7kfUt59bOoR0hRK8rhIojR
	CujUqNq4fSPs5EIU/niKEWH+RzrbgcDEEyuroHg3WMEWNnfEkCvoGPXH5zRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742483863; x=1742570263; bh=uwLMhqq4CXPT2+8u7y+1JgqDy/pP5CB4j/S
	3dXc11bA=; b=UlllypvnDQ3OKQD4cq6Cd5U77Ay7K3A5/NDhLz2jo7GXFNvk+JH
	F14FiB50EQ8Fj9aDKU5tY6XmLDcyBbWSewkkCiydiHQ9H4QPN9X5rDvQDt42RTwm
	Ua2sOSjufbcobKQf2eIiFHZ1DlUAmAis/flwRZYmRVhNPLRXZrGYd3/O7RyfIWis
	Q9t8t2SprbiTGQjPxlQWJkQBBWnljraZuOrkuECU6NHsSySDswsJeuL/tJ3n/mVk
	+Y5ea1sQ7LwEh/UE7Vvf8koXI3XjqaCUz23MrFeoyAzSS5fr34Eg+jnK3tU9Wu3f
	LJdmbhWrYYRyiDGBmspTpN8FR8gEzYUiRbw==
X-ME-Sender: <xms:lzHcZ23GW7KyYWn9pW9hnPkPN8l8A3iJzp_9qmPmPxbr39VU4jVmNA>
    <xme:lzHcZ5GGyx_AQBK-7uimisUjNmA4CTEKxrXK-VzJh65e6aG8x7WOupgIedO_HQwEU
    9ozRbSnHHuVIngPhA>
X-ME-Received: <xmr:lzHcZ-7pmie6uCDT976qPn5Si4Jo_8Q8mmYxgWcTimmkGLQ-91BSQhV-VFlEt0uKN449QbK8CqZk7eY9YW2jkgcv1fYZlGlws9WmuNU8zhekAaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepiedvheelheeuhfelveegvdekgedtueefhffgheev
    lefghfduueegudfhgfehhfeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidr
    uggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehiohht
    tghlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepvghthhhomhhsohhnsegv
    ugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:lzHcZ33abFsFRph1wZ1VF4lj8i2nEX_t-usvsDSHEgJOQHOnUk36EA>
    <xmx:lzHcZ5EZJccsTIhHrR9DhFSwXVhwRQZU5tn7Y2QFVVk_uXacKNBc1g>
    <xmx:lzHcZw_FVvCWblq0r9ulnO0Mm39QJCOvKqsjfvHXw2R6Wq1oSk_Gvw>
    <xmx:lzHcZ-nybmiylMiNnZKjSkWej4rNHh6vmYAua8fLQ8YM0FH2WKAVyA>
    <xmx:lzHcZw3X1_V3_mZ-O5DFDr6UzCZ0QyTsiKbqdWfyxvFjWNzKV0AbCORW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 11:17:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 58017bc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 15:17:38 +0000 (UTC)
Date: Thu, 20 Mar 2025 16:17:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	Justin Tobler <jltobler@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v6 00/18] reftable: stop using "git-compat-util.h"
Message-ID: <Z9wxki6ES7ZRN7Z9@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
 <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
 <xmqqjz9nkrqt.fsf@gitster.g>
 <xmqqa59r2lk8.fsf@gitster.g>
 <Z9Eu_fZbI8ndkzHw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9Eu_fZbI8ndkzHw@pks.im>

On Wed, Mar 12, 2025 at 07:51:41AM +0100, Patrick Steinhardt wrote:
> On Tue, Mar 11, 2025 at 04:29:27PM -0700, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > Patrick Steinhardt <ps@pks.im> writes:
> > >
> > >> Changes in v6:
> > >>   - I have rebased the patch series on top of "master" at 03944513488
> > >>     (The eleventh batch, 2025-02-14). On the one hand this gets rid of
> > >>     the conflict with the zlib-ng changes, which have meanwhile been
> > >>     merged to that branch. And on the other hand it pulls in the new CI
> > >>     build for MSVC+Meson, which allows me to have better test coverage
> > >>     on Windows to better detect breakage there.
> > >>   - Stop moving around Win32 files so that we do the minimum viable
> > >>     change in this context. Hopefully, this makes it easier for Dscho to
> > >>     integrate into Git for Windows. If it doesn't I don't really have
> > >>     any other good ideas for how to do it, so the only alternative would
> > >>     be to just ignore Windows altogether.
> > >>   - Link to v5: https://lore.kernel.org/r/20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im
> > >
> > > Thanks.  I think the "unlink" thing on Windows I have was queued
> > > depended on the previous iteration of this series so let me make
> > > sure that I'd unentangle it while replacing the topic with this
> > > round.
> > >
> > > Will queue.  Thanks.
> > 
> > So, sorry I lost track.  I think I saw you ask Dscho about the
> > Windows specific bits once in a thread on What's cooking report,
> > but I do not recall the outcome.  Is this topic (and the unlink fix
> > that depends on this series) now OK, or would we see further updates
> > once 2.49 is tagged?
> 
> There was a class of test failures caused by mismatching allocators in
> Git for Windows for which I've sent a proposed fix for downstream [1].
> I've been talking to Johannes on Monday and he mentioned that he'll
> likely end up taking that patch as the pragmatic fix. Which to the best
> of my knowledge would mean that this series here is unblocked and can
> start to move forward again. Johannes, please correct me in case I'm
> misstating anything here.
> 
> So based on that I don't plan to reroll and hope that we can move
> forward with the series once Git v2.49.0 is out.

Quick status update: Johannes mentioned in [1] that he is fine with
moving forward with this topic now. Thanks!

Patrick

[1]: https://github.com/gitgitgadget/git/pull/1874#issuecomment-2740342672
