Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10547BA45
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 21:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782770178; cv=none; b=krvtwF6TTMv++4n07kuRXKox1YlHvDoqRQLyIWbKrBwSaL7fX1P46ioElPVRZJQkwsXJ84EXTGI0auBi5zNZ0OvVg6lO0wEBeXBVpLCXKbyrdmpHemTmTaFgiDh1vfyj11yZIYKK64gD2VT5xCifRLLRyXvS3847HqpkrGexXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782770178; c=relaxed/simple;
	bh=Sf7UZRAYsIHsaPWrdjKrSDwMQxBiOReB3tejdoNUwVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BvMp5pRsZU77VFv54WAv2UTStxJ9hy/kpJy+8qw0tk4Bs1yYibTnHnj4qDyvoepBzN+2qBO4io6H5QBF5OlWyIkkAjnjLg7640nBmKZJk0lrkC7FxhUqDm5hwJGwSynGCumZl+PYSc1XuP4c7qYK4Sf0d6hvjdRnLv9/I0qgc2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EVMbJEZZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RGzp2EQn; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EVMbJEZZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RGzp2EQn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 280587A007C;
	Mon, 29 Jun 2026 17:56:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 29 Jun 2026 17:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782770176; x=1782856576; bh=cPTVJ6/8CV
	WCBCUHy8akHPMeGy8CktEgo93jiihj2w4=; b=EVMbJEZZrIJs/B8CvDRboHYUkZ
	LWup5wBBE2rKPpX04MMKOY2IvzVxan7uHZmWUKeVRKFfNmuwGEmJ5OBE9izI/DAw
	amXwLQwD72q7omCs1GQDqDE9kU4mOXVpg/z8W5bF2uH8it11y0Ikz5FJoKtdIJ5a
	P8NdFrd7+0paVkFq8gz4yK5b5meBUi3QmXIIk5m7B6BtzUfntBcpdTh5aZAcWcHb
	TqRvf5xD0bEXdMUGLsyx2npkU/GmZr6UYGfxXOujmLupv6dslEIjRghYNI0/KeS8
	ObZ5kqneAqzdd9yHN0sqxLgmnwRoEkI0wTyCtRZhu7BeqsJyRXkrfZ6bvuBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782770176; x=1782856576; bh=cPTVJ6/8CVWCBCUHy8akHPMeGy8CktEgo93
	jiihj2w4=; b=RGzp2EQn7HoUWrhuK3gPgFd2JvpNsRrHBHHlz51sZXsV1mvxSGU
	TnqCRdaILRVNEpwsbxH0r6YzV891JKcCYoMv6DgctgTg+acKKhzthqUE9V7d82u+
	5N3nQ+8U0OcRJdu0HC2UtWrjpmu1KWVyQ1FdxNy21dvySlIV/TXaVYqk/E9LXatY
	tgtyEtml9pXswYvoVeLbnxnJRRpQxdEKII9b2ZOaS9lAGW60nGlAC+URlBwGzHwL
	uvAxLWTHhX4fudVRH1VkRJkc4Aae/yfGGPsJIYG9U4jUqoxmfgr8aEHoDZpzEAxa
	5Zs3ZN7PlZDyynQld8GGXnq+fNH4Ko7sDrw==
X-ME-Sender: <xms:_-lCan7hoH5Y0rtEeKmvLdBOfPqLiLdp22xoV7D7ZdGi2Vb5wX8PXQ>
    <xme:_-lCajbWrP7T4RTRhOFnpOqtCqCEmbiKvXLkAz7mSTZ8e9w3t_BDI-oiqe09VUIgE
    LVjRQo0nNZ3hQaDdb9hSfXwZA0xCNmDtOhW1u5jAlFGcAasS5_MXYA>
X-ME-Received: <xmr:_-lCasfDvZ6QW-2z_qzp-8H7ITi63XadcJjiWAnQyq6qBaOmsc-7SE1tHECBVVW4YJE3_dotZJubJcNqUlofDmX2ioKkJ7C76xKFjfI>
X-ME-Proxy-Cause: dmFkZTFoNrvC3gEieqYCiXLGf4CV56342KfO5ozTWZ8Cw+/mUZ/tgakJ33QyXV6YjTcZJl
    5xSsBLIG5fHMazrlsqv2lyAGR3q95U9BuNN6KqJG0digcTtGmzfAoALTgJ+WK6NOI79RXa
    WvilSNJF4/qa1biw8uqTyODvN1RXpjHKxYjuDlj5ElryarmRJ0COcAaOcIyx2zr5CRYzsV
    4a15px6TV/pfKl79AILUz/CWbDyHz7OfiDcswwSlJmAcXQ0yalCVsieAI7YcV3EWYSxo0p
    NY6MVBWPf8G5v5yRQtwWoELaAO0ltWA29zdjCuvckWOVvWfL5X12CWfBIK2AR6XxM1lDmt
    H70A/nu2A1WCjt3dsdDQhp1duSMi+M3+MKgSIthgapDseN7AO8U8sx3TXigUBaDl1V84vT
    iHTvUS+5X7jN6ySKlW7BZoyXyZHC+7oxUNSYunac+A0NdubXhY9E26QF6VCNThQO4P+jSn
    s0631ieuvcXeQYd2vGHXGwVTReOw4L+23Ot923Jn1IMoAz3K6DSHhHvW+uOu3uDiOjvZfD
    qfbuv1Crb24O+iqsgIER4LDIepexcIV3s/jBh/k27MemCsWkVj34Ob7C6kT5ycVGBpxaVg
    tK7hdqhfZ4pCQhkaymJAATZ8v5k0vaZEj6dri4o7xJ9Q+wvOamic87Zn42uA
X-ME-Proxy: <xmx:_-lCaq5xzy8LlgbwGpo_VuHs-1z8Yln3fy5LkLE6xKA2FnFOmMWzmg>
    <xmx:_-lCahaey-WiTSds6KKz_z1f3QPrpG9xcXTyi8lgUkSszPmAsixitA>
    <xmx:_-lCasEGyDUl6Gp27cxZ4qx2dbfGXqB3csGchXEtUYYYqukbyIjWLw>
    <xmx:_-lCasmTn_tpZbx2Yw5vxpvQqIpKUrl_oThgdpnDow79SWxfJPHtvw>
    <xmx:AOpCanLp6ti36inyQnvNRnqnN5KJqt84imIjFlm2YMR4b3yyw_SWh_VH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 17:56:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,  git@vger.kernel.org,
  ayu.chandekar@gmail.com,  chandrapratap3519@gmail.com,
  christian.couder@gmail.com,  jltobler@gmail.com,  karthik.188@gmail.com,
  peff@peff.net,  phillip.wood@dunelm.org.uk,
  siddharthasthana31@gmail.com,  Kristofer Karlsson <stoansen@gmail.com>
Subject: Re: [PATCH v6 2/3] revision: add peek functions for lookahead
In-Reply-To: <CAL71e4OQ_kGb+UwHgikHG236-8BVtc7P9OdpV4i4UzYRCoPczw@mail.gmail.com>
	(Kristofer Karlsson's message of "Mon, 22 Jun 2026 10:28:11 +0200")
References: <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
	<20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
	<20260620-ps-pre-commit-indent-v6-2-cdc6d8fd5fbc@gmail.com>
	<CAL71e4OQ_kGb+UwHgikHG236-8BVtc7P9OdpV4i4UzYRCoPczw@mail.gmail.com>
Date: Mon, 29 Jun 2026 14:56:14 -0700
Message-ID: <xmqqechpt3i9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> The solution is to skip peeking entirely and instead call
> get_revision_internal() to populate a small lookahead buffer -
> it only needs two slots.
>
>     struct git_graph {
>         // ...
>         struct commit *lookahead[2];
>         int lookahead_nr;
>     }
>
>     while (revs->graph->lookahead_nr < 2) {
>         struct commit *next = get_revision_internal(revs);
>         if (!next)
>             break;
>         graph_push_lookahead(revs->graph, next);
>     }
>
> After prototyping this locally, the three test_expect_failure
> cases in t4218 went away (though I had to do some minor tweaks
> to ensure it become fully deterministic by ticking the commit
> timestamps.
>
> One subtlety worth mentioning: get_revision_internal() sets
> SHOWN on commits, so lookahead commits are marked SHOWN before
> graph_update() processes them. This makes graph_is_interesting()
> think they are already displayed. The fix is a small check in
> graph_is_interesting() that recognizes commits in the lookahead
> buffer as interesting regardless of their SHOWN flag.
>
>     for (i = 0; i < graph->lookahead_nr; i++)
>         if (graph->lookahead[i] == commit)
>             return 1;
>     // other checks after this ...
>
> This approach ultimately removes the need for
> revision_peek_next_commit() and revision_has_commits_after()
> entirely - the graph code no longer needs to peek
> at rev_info internals.

Sorry I lost track, but I think the message I am responding to is
one of the latest messages in the thread.  Whose court is the
ball in right now?

Thanks.

