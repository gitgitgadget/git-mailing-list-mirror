Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2AA419315
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755084; cv=none; b=b6XXpF9oe6VgR1wFxqopxOuvcOpKenOKDKT1nXWY4ruBfsqzAh/1YwJhDx0mBSmEpwULaXfRrXYjCxOOJ32Wak9tyM7qeNeQEb9NM4gyUufOrE43QQaQ5LV8NoGkIQjn+9cae0x/oPq4hpedbaOKtQmCYLCTXBR8tmqsG26ctmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755084; c=relaxed/simple;
	bh=QmvPG/QMeTLP2+UF8prr6QQH+7WSF+Nz0tDjA8H3aAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ocx9XIqoc9ZmKL8H4ZLtQ69945OhfFEIXqeNczzHZMjRuKozjS3RGAjAZl/FkJoUCsXh2H4d4r1CalcjeR+GDkO/WuQqlzGpEiCVZyTCRb7jjEhGeFgqG+RG5KxnBsLLAc1R45evUASqMzyb8VCPvtZKPe147VW+Xzp20E3fBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tZpzwRyV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YKY2LGuD; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tZpzwRyV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YKY2LGuD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F1D37A009D;
	Wed, 26 Aug 2026 10:38:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 26 Aug 2026 10:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787755082; x=1787841482; bh=md8cZc6PbD
	x5iC7HvttkFt9m/+WFnz9TFhef3AM+VWM=; b=tZpzwRyVztsu1z6k7G2GDZv8ax
	igkB37sJpfrwrMxOGxoP2KM/M/atLjpRqf9GR6kYjV4E3FFalClF6J/kMhBSK339
	tXYhf8KTKh4LWsd2bWVZqQE9U8ZSv/GgxQCe3dYSfa9BlBHtIfLVkTfnWybZoyrN
	0yrsMqqebK6yEVJdSAKOIN2UcuuNbPVOrCQi/7ENYBikeVz+5m+TS2bS94A7tXpG
	n40OQnTiUJJ1MVlAl6eRiiTaFWUy7wP/oJR0XlWI1Ox8WRYoZej7aiVmERtOg/gc
	Sv3ga4xHqU+si4UqIyd0Lh/jbZU98edYqpgYgj8bRjd85eSotYDoVSeIMjzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787755082; x=1787841482; bh=md8cZc6PbDx5iC7HvttkFt9m/+WFnz9TFhe
	f3AM+VWM=; b=YKY2LGuDPnfeQVGDszYHaPOKK0JLHdDsUfzAQ1VWnBD5x8mBZAb
	au8VM2EqbL3/UV8f6sJ7InvnXss2DzZMtRoWu4fJvTABn24WmzKv3vmJPRNLn2qJ
	2h+59Jx+2gUX8aGmf7LWUodZEM0YfKtqZX1gXuADcKf/gn0EJTLw/FXJLCfxknaS
	mFoQD0ZkmeQ9VU2NdIaluGB3nv/uQiknyR1Ds3owt2+PBNKmhEXZi/dxZVjsXs/4
	nnBL+aujuu/fo83aPU3yyZ2p27Ynd0kFrDhtgLQ2Sm8hYzRQ2KyA8O+Fi72mgbD+
	3a+q7M2a4/Xqpmz8TX0THiram/40zQI8EWw==
X-ME-Sender: <xms:SfqOai-uhXUWZzxA2igsvYNu4T8Weq1sVJCHyKTeLf5sChssgSjV7w>
    <xme:SfqOapsk7Nw-5G4Gk_tg-vGr8lJXAiRurx98YzrKvlg2I9Vaj6pIO-Kr_J7SUhw8p
    g14s0zc1TywUSX77zBFsKumMNXEiQ4qfnR8Ldwt-ElIWdzQ-uKMNg>
X-ME-Received: <xmr:SfqOatDlPNA4vhqiLMriVeJoYTU5Hq2Jmu_xjU4TrWqtjpH4hvikrrR5HbtrQ15H6sH-mJWZ6qLvO45dPHj0XiEfXeJ8opuMwA>
X-ME-Proxy-Cause: dmFkZTE+iizJonCO5ZW4h9pc/m1bR1tqBIE3uF8cqYL4/gBgdJOr84rNec+avnDuSr8D4x
    BtdJYWn54c76QfcMLX2zw0jBIRVmzFTz2trPKVKCKE+n5iR2XY+G6hswV8NIQsLRCZa+gn
    tTbo7/Genn36BPy4k/aErecvQeEq/4ct+97GXSVz/6GM03DGl+SbHm8JIKMlo27Dl7NxoR
    VWLKCJpNsD2wVk190BfH+HXiTWutaE0NNFYfbdTcZOXW357cH1Xidm2vn4E7r6dvRUnPvp
    xchL6eUNMB/b69/fX4ZRJb7xUw70Y9LsteAe76ltZkv7JeVC0qEnwWX/SmtfN8zFkGCBg2
    mmr7r7WLcDwhPmkuqzVt86No8xL0+9c5IhREiuhFFk2rwkQPUeCqRu7GruaXH+tMbhvnC1
    LN5Wtk7MO8IBzkZsyounnVjmMZUlWsZSjHfxUimi1/ojFVndI05hKwKR7tY5EZYyN8LQND
    dYgGFQhM6fl/ICEoAmzbg+YlXrEniIBbqG3MUfWfANAVqq7Rbu4vOOkFRM14r0dS+Uyt1t
    hRVbc0ijCgPL0Na2cqPjuWgujO8woj4Tv3cM/Qsr+0r38ct2fFLiNPU5ywwYHSx1zckcji
    7F3r3U0JhNtjdS2B9Tni//knvkSiqkx/Fklo+0VRzThYD01GbHxjhC/6fEqw
X-ME-Proxy: <xmx:SfqOapXHRnWckuWsLgNEGdKLHv2ZOf0CSb3odPA-lSJfFz2CBbGshg>
    <xmx:SfqOajAOEGfS1vz79_EyYLDKeHUGErS5d29Wu7-QTcTbcsFEYdSfXw>
    <xmx:SfqOak94a1Ehxgr8CKBBjjJ_MSO5rk_-sE3ucGSSK4x7fTKk3huzPg>
    <xmx:SfqOaiFHmCv3qkZu4ELBg5v_GFAkRwZmMR3P26UDP4yKA7OwUkb8kQ>
    <xmx:SvqOaghw-9lS8v7kwFPUBF8qUYDxqeg_1APyIi1aS9PnxxRap_7OaHie>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 10:38:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 2/2] branch: protect local upstreams from -d
In-Reply-To: <CAHwyqnXjO6Cv50BVjJjW939A06-bQtcA2uf0Cwk+xuoc2Gh_LA@mail.gmail.com>
	(Harald Nordgren's message of "Wed, 26 Aug 2026 08:56:51 +0200")
References: <pull.2365.git.git.1787693117.gitgitgadget@gmail.com>
	<d3d7a06e3d6f0c7adf9739ca496ed4012e261ac1.1787693117.git.gitgitgadget@gmail.com>
	<xmqq33w1lv4j.fsf@gitster.g>
	<CAHwyqnXjO6Cv50BVjJjW939A06-bQtcA2uf0Cwk+xuoc2Gh_LA@mail.gmail.com>
Date: Wed, 26 Aug 2026 07:37:59 -0700
Message-ID: <xmqqfr01j6bc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Hmm, it makes sense what you are saying, but I could have sworn that
> you asked for this (likely some very different version from this) when
> I was working on delete-merged, i.e. to extend branch protections to
> '-d' as well. Phillip brought it up recently as well. Maybe I
> misunderstood.

It is more likely that I misstated.  I do appreciate that we now
have a machinery that allows us to offer an "improved" protection
feature that may be "better" than 'branch -d' to users.  It is a
different matter in what shape we offer the feature while balancing
the need to avoid breaking established end-user workflow.

Thanks for working on this topic.

