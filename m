Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC3D2FFFA6
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770514754; cv=none; b=l0ijqxhhiSz3ofWKJZXUZlAO0dcWUQKDnYsxNsGYi6lLsxr5U6xoqP+7mI1r/uwIKsTkoB+0TNoDNjwU3LSalvpXA0rDbijrvV7hRSexdz1FRv3vq75tKmOrMKtjHFR9y5EnAIr3jhtsCdUj3u+QFC7atwUuofM7Khp4CfPvPSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770514754; c=relaxed/simple;
	bh=vuB8vfcX6tWTzfJx05PxGeqkttkmDEMvDynqTkXsnuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O85yegC601xWfK6AutSWK39jW6Tjm870tCJtlItMsBS3ZZKCIgyD97mwmzC3r0tWq5LIsOKgOv16ZHmFgJa6tFdaIKbj1U7ZbeoJQHySaaGonfW6Ve6mRRc4CqaNcuw5ZlaZjwY5iGchvOY6OGtG8uad9iY0+A0qnfPuLuJ5yxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lt8EhrWi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wLXnHxT+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lt8EhrWi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wLXnHxT+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 975811400190;
	Sat,  7 Feb 2026 20:39:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 07 Feb 2026 20:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770514753;
	 x=1770601153; bh=bgmC1Evusa4ivPcsLiVHkGpv9KlyCTX3yb6FmWCGirU=; b=
	lt8EhrWiujDN76QdM3toDXIa0cnAKtt5gTK5VZXzmbD550Dm5sTAYBw8HpVQZlUP
	XdVsyhU+ITPy2oFd4t3mWQDLdlywVwsvknJuil7tObWjlh9q539UVSkJdm6yMymD
	j8kg02Oevvq9xJgN3daegvdb09G+HXUIMo5vbvb/K24vfAZrC2Z7IEdFVUtmsGUd
	I6pr3y/u9py1uDRtR3/mauZYEtqRHJz9HXYvbrM8VCMZ5zUx/TLsf027LeS7a5b2
	c8Vd/IZVutDkN6VMlAkbuu2GsKx2NniXzguCSgNqvuv4hz8nVxanfV4f9CWbQ5GC
	hj/u4T7J4/Y0G162lTfesA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770514753; x=
	1770601153; bh=bgmC1Evusa4ivPcsLiVHkGpv9KlyCTX3yb6FmWCGirU=; b=w
	LXnHxT+RGRJkSiJxM6hZhp25suI3vJoLV6i5uYcK7SFNQWKptEs5ZFZvmf6qbQgB
	LA335gcBDKayBynoN8X1xNcWA723Teaq4BElg3M2JoXYf01Y1hUSRw6jsxxuScjK
	yr3ikGnn3W2WjDD/SbWOieJtPYcksfPz35Q+uF8w250n5X9Cr7Qv4erQoQ8/XX+c
	8lBLsPSQSwXsVkUiUtwzcK6EU2vw2brwP/zBESv/EQMddXZaLWxTJ5Cow6vxUozl
	9g3Th88L587Bf+0euBFm+oiI0ZnxSPXtRnKD9rNa0Hi2PAZGdyv3SNV40NPP05PM
	tmTMU5SQIeDCNKIjzKOhg==
X-ME-Sender: <xms:QemHaQRCe40JFNA-TeK8zfW7hw94F6JeEcs5A9PRzmkOB6PzUQV90w>
    <xme:QemHaQWULoFmIvvhK4l6OnqadfMNJS5d10TPhKFGd3OFxvwxJKch16Y4FAwDfhH7y
    nwD0GKy5e6oX5GjEKp3ctiFRnjV5sAmIh5eNT3CQGHeFN0MsnEr2w>
X-ME-Received: <xmr:QemHaRdZiyt9I4GFIuTGITqZIV1dR6sH0chDh0wUOgQoZmyXSzfIstFFGaF0Dc2epvEoiS4dyC2wBO8BxTJArChkUomvsN7OHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledvieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeifefgiedviedugfeiudejtdejgfdvueetveefueffffeiffeltdfgfffg
    gedukeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohep
    mhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopegtrghlvghsth
    ihohesshgtihgvnhhtihgrrdhorhhgpdhrtghpthhtohepmhgrthhhvghushdrthgrvhgs
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhuughgvgdrphgrtghkhhgrmhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsuhhrhehrsehsuhhrhehrrdhnvghtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QemHaUJOIN3k-oVuaH_3yDvR5iHsEbuXQ6HalYD2Wy3rnPG5_ZXaOA>
    <xmx:QemHaezNaA-FuZSU8dkQBGEMvJzI3QkFGY3uAzGz67wN8avYTvDdfA>
    <xmx:QemHaatr00e7TiBPCrdXJZqpDcZX88I3khPaH-DmPZn_AxsH_Hp-8g>
    <xmx:QemHaRB2a9xtG0SnriQ1-faNjANj77efgO-RdNJ_L3e3b-OEv_iGbA>
    <xmx:QemHab18dD6NmSunBC5K251pX7d1I96M-1ZZXCiBi_nbWXqG7EmrF_2p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 20:39:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Matthias Beyer <mail@beyermatthias.de>,  Christoph Anton Mitterer
 <calestyo@scientia.org>,  Matheus Tavares <matheus.tavb@gmail.com>,  Chris
 Packham <judge.packham@gmail.com>,  Jakob Haufe <sur5r@sur5r.net>
Subject: Re: [PATCH] doc: add caveat about roundtripping format-patch
In-Reply-To: <format-patch_caveats.281@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Sun, 8 Feb 2026
	01:11:17 +0100")
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
	<format-patch_caveats.281@msgid.xyz>
Date: Sat, 07 Feb 2026 17:39:11 -0800
Message-ID: <xmqqjywo9fpc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> git-format-patch(1), git-send-email(1), and git-am(1) deal with
> formatting commits as patches, sending them (perhaps directly), and
> applying them, respectively. Naturally they use a few delimiters to mark
> where the commit message ends. This can lead to surprising behavior when
> these delimiters are used in the commit message itself.
>
> git-format-patch(1) and git-send-email(1) will accept any commit message
> and not warn or error about these delimiters being used.[1]
>
> Moreover, the presence of unindented diffs in the commit message will
> cause git-am(1) to apply both the diffs from the commit message as well
> as the patch section.[2]
>
> It is unclear whether any commands in this chain will learn to warn
> about this. One concern could be that users have learned to rely on
> the three-dash line rule to conveniently add extra-commit message
> information in the commit message, knowing that git-am(1) will
> ignore it.[4]
>
> All of this is covered already, technically, However, we should spell
> out the implications.
>
> † 1: There is also git-commit(1) to consider. However, making that
>      command warn or error out over such delimiters would be disruptive
>      to all Git users who never use email in their workflow.
> [2]: Recently patch(1) caused this issue for a project, but it was noted
>      that git-am(1) has the same behavior[3]
> [3]: https://github.com/i3/i3/pull/6564#issuecomment-3858381425
> [4]: https://lore.kernel.org/git/xmqqldh4b5y2.fsf@gitster.g/
>
> Reported-by: Matthias Beyer <mail@beyermatthias.de>
> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
> Reported-by: Matheus Tavares <matheus.tavb@gmail.com>
> Reported-by: Chris Packham <judge.packham@gmail.com>
> Helped-by: Jakob Haufe <sur5r@sur5r.net>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     There might be other things to do here. Mention it in gitfaq(5)?
>     
>     § Trailers
>     
>     • Reported-by: Matthias Beyer <mail@beyermatthias.de>
>       • From this thread
>     Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
>       • From https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org/T/#u
>     Reported-by: Matheus Tavares <matheus.bernardino@usp.br>
>       • From https://lore.kernel.org/git/d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br/#t
>     Reported-by: Chris Packham <judge.packham@gmail.com>
>       • From https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJDxAs9u=FGpHQTkjE-guhwkya0DRVA6g@mail.gmail.com/
>     
>     (These were all linked in https://lore.kernel.org/git/20260206090358.GA2761602@coredump.intra.peff.net/ )
>     
>     Helped-by: Jakob Haufe <sur5r@sur5r.net>
>       • For the part about patch(1): https://lore.kernel.org/git/f6e4cdb4-ff82-4853-aca5-0c152f287286@app.fastmail.com/T/#mc389dbd2ae02a007cbe57cd16ca4790ecc5a84f7

The space after three-dash line is to give additional information to
help readers, but the above does not qualify as one.

> +Furthermore, the presence of an unindented diff in the commit message
> +will not only cut the message short but cause that very diff to be
> +applied, along with the patch in the patch section.

A line that matches "^diff " is taken as the end of the log message,
and everything that follows is passed to the patch application
machinery, and the above description is a consequence of that.  If
you have more than one such diff, they may be either applied, or
some of them may not match the patch target and the whole thing may
be rejected.  Neither is a happy outcome.

Queued.  Thanks.
