Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D917217663
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742603; cv=none; b=aKk9zM52gKxhmVFXc3qCqEwtkrZySNDn+OmBkQftxiRl+ttATTsq48B2TYvJxQuMthHycqjLV3/MeNmQ+VfYDd2B8RL9lxnCI2VL8KavqtUxvqP59SySoS8MR6cPUZf9xG/kjJ0V/wNkrDEcKHbX31ExDXO1lCWEyH7jHW3R8Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742603; c=relaxed/simple;
	bh=Gy8wgOxKi3NzIPUIrqEiVmBhdftCiI7FFIqL7xAqrfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGkX5as0cD81ei2afuKiNCxAjHooOG/aexkJT0tqVXTvTsUOTOfadSyUdWeaQxh3WT6qJSxLdLlbDw8noO4L1gVNxc/7vgyU6jrCggkYRlzOahPFhm80rhRBQ+QukWr6YdrQGWOEsCuYcNB9mLZ2Mo6RA9CjsZM6iDygUF0QBOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ALs2n3b2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TlCwJq0p; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ALs2n3b2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TlCwJq0p"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 571D7138011A;
	Wed,  5 Feb 2025 03:03:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 05 Feb 2025 03:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738742600; x=1738829000; bh=qxqTGjZF2o
	dMJoKOl04vVDJol5549qwBYr7Efxwa0kc=; b=ALs2n3b2YlLOuBZmhEBuJVl1yL
	0SsaxSw9OVLsUVkTzaFAluqv5SV/9VXo4yYpVRRIkzeR0ebfimHoc9PFKFtoe6/W
	Veeste5Qg51smfETnWS4c6JeDrfyaeIrbyV52at17qdKk1FAPtLXiHdsHQi/9qsT
	BsODUTqdBrsUmayApDaiKADJlbINb50CL7rrihot+qLsXu/w5lgVAflJMCElkVWP
	eRTWsqkrqfOJ4S0EyTB3vcqEcFc0TNKVMGlrI94G+f779qQ74OoyQJwDAgUlKfns
	Ojhc5x+LhzWtT9FDeOx4r8RRaAnOlLx7GjB+bbhlj/vV9nZER1TaW5Oqoa+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738742600; x=1738829000; bh=qxqTGjZF2odMJoKOl04vVDJol5549qwBYr7
	Efxwa0kc=; b=TlCwJq0pWwp9j7p/WLzARrFHd3FGEGrrEEIegw/0XMsM9qh1ouK
	nx+EpH3oEFOiwfsnjKdV9utYY86vPfkSqAZFTT8sooJGO+bULfcs2i85QewrmGvU
	qkSiuPIF/texF3JwFqMU2xCqQ+DvQO5SyfxtKPQrqLOSkIb7/3qIXrHMZoh9X9kt
	PUYnXLwzwMXCAPNE1wDOrsoo5m5IUrGGGCCokTSOo+pVxrFzoVqK1ncem8Z1DB1A
	8qLa9hQWqAmgd21jqXEybpgh3goMCMZzuUrGD9yeHxC5kHJlP8jTITaeymlCo7Uv
	176GXS6BnAHReTk/rOKj1v0xr5j4xBpIKxQ==
X-ME-Sender: <xms:RxujZ3dhJcFlfj-_7_VE-8E-gPvrSxtdVF5Z8vuw77_vrzdsHa0scQ>
    <xme:RxujZ9OFJSYmXKsSJn4CN4lvfg-PPuKTw6tvmeDyldgS77SaJiU4Hwdl4_Nx_MKnt
    lp1QewpHW6E8LjuWQ>
X-ME-Received: <xmr:RxujZwjlGURKY9izsPUuN1JOluAABHOxxxZt1PjktmZsOELi9jX-DT9GwHrzNu_FBDPPGkW5on_A7bmSzb9kWgVaNK0z9Bpxvl-72wTK-R9vdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejvedugefgffffieegtefhgfeikeevfeefheevvdeg
    ieetgeeujeeliefhiedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhhsuhgthhgrnhgvkhesshhushgvrdguvgdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:RxujZ48gD5v-GOGILwZwA06wGGUbSF0TPTcoyiiUSzt09v2hyw7acw>
    <xmx:RxujZzsbyd7LBxiuRbrI7a4gTiXAMuyAI3TiFRvG2e5cAHeVChq54A>
    <xmx:RxujZ3E2Yk9tDWC7Yp52JWkCyvE8LkyrUBred9qJV6VpIHT3epCt1A>
    <xmx:RxujZ6NFhKqe5nzEfq3wbpz9sYR0PccOWIolkmKO_0KlSMe5FD8nZg>
    <xmx:SBujZ3gSmsqqusUIZR7e2lZ8k1OwIS50e8ildfHqnOCaV5K4p81lsw0m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 03:03:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d960b9de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Feb 2025 08:03:16 +0000 (UTC)
Date: Wed, 5 Feb 2025 09:03:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/7] Enable doing a shallow clone of a specific git
 revision
Message-ID: <Z6MbPzpGdojU2g2f@pks.im>
References: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
 <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>

On Tue, Feb 04, 2025 at 10:33:59PM +0100, Toon Claes wrote:
> Changes in v5:
> - Add separate commit to introduce die_for_incompatible_opt2()
> - Small tweaks in documentation about `--[no-]tags` and `--revision`.
> - Better explain the refactoring of wanted_peer_refs() in the commit
>   message.
> - Change type from `int` to `size_t` in wanted_peer_refs().
> - Use lookup_commit_or_die() instead lookup_commit_reference() to avoid
>   checking the result ourself.
> - Add a few code comments to explain some things.
> - Stylish cleanups like removal of unneeded empty lines, commented out
>   test-code and remarks.
> - Link to v4: https://lore.kernel.org/r/20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com

I've got a couple more nits, but this version looks mostly good to me.
Thanks!

Patrick
