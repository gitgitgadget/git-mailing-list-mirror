Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8807023D7C3
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304045; cv=none; b=aZ2yhUKOqpxSg5ry00AtDnOeeTL7o5SykRq4gJOBzb7nROG5/sw0ie9hu+a7yJy/YD3rKJqffBSNWHMHcKN5oGvRun1HvggNuZEYmyjzweyRWHO4lwME5NgIff0OseUX16/O1A3lyrvlPFx1fb+cZdUuR5vTNHtyLndF2MSQpQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304045; c=relaxed/simple;
	bh=kzgFi7ukRB0hOZ8+cu0UjVT7/AIE6IvCjhyqyB+neLY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fe550iPg2blBAkDBsNm2MCTxHMDcVx/dcoEHqdTdcU8tDOBn24+s7nWE0qzPiEDeM9c3nrxqxyYiG7uh19yut82ivKhDV3/fcf6PPGbmPubl8zEUnh4rnIOzuiqhkh2knddGtu46xkqWbGFJ7hVavFQkian5+jYrknEY5MOvU98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j2LKoNwc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rua9fQ5F; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j2LKoNwc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rua9fQ5F"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C3A17A00B0;
	Tue,  4 Nov 2025 19:54:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 04 Nov 2025 19:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762304042; x=1762390442; bh=kzgFi7ukRB
	0hOZ8+cu0UjVT7/AIE6IvCjhyqyB+neLY=; b=j2LKoNwcxy7twXGCf2eIacGkKz
	wM7muz3vb/NXeWFQRFYp/TGyinPqi6xfUQvdr1G8tVh/jIfkXKw0J5TD6qCuNr4k
	61U1FfBiyhq61snZKrI3Nx8XlxKJO1HM12L++klFD5E1fPfNP9mLP9fTKBF+XAL0
	UabPI4YLbxFxP8f7jfsw1HU+iaWK2VbmZdovAnvNWPZpxj56jtGyti+8AsCvgd20
	TTvc4WYFzC+cv/dAGYPsOY4+rTHnhHw+Izgq3sa/dS5ek7Pk0Zv3Rnouc2FuZbUV
	TFL2W7bvvI0A4GoHvfrk6Eli1UY1R3bmZkznFNCdcQcRFsom49vqM+FoqW2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762304042; x=1762390442; bh=kzgFi7ukRB0hOZ8+cu0UjVT7/AIE6IvCjhy
	qyB+neLY=; b=Rua9fQ5FlV4ZebbBV5M4566Ol6Za6rusriYu5UsIE9VaCrSYOT/
	5FIqKqHKEpMJyazBjeSrsgGsmEFuNNYqlJCAw1PEe2DBrMQ6x09/AQThgTD7tlqa
	7aTxIweLgXnT9okxzqeY/4N5a5ynMRxm3D9pkAhVI1r+2VUXMOiLYmgglXh0eS2M
	+BVX0F8TMMzsMcNce+bhIk3dX14wEU7B1VcIqrStlCE7agHURlljLcwxoJubzqLO
	LyINSY4PcwMFloatJU2URTwvBHfrQYgkCMBuHmQg7YSXIVt+DHrex1ProcHWBbpO
	3183lq3ZPrBKPnnwih89+Pbtzi0Mcm6oWlA==
X-ME-Sender: <xms:KqAKaTWX0CdSR1m7NlTNdpPiBb_lbA1enpmE-YwyPfp3mgOtobSGIQ>
    <xme:KqAKaRmfGY8obRTCl0eSq-QEwJSAN2f-rBwcGi6LbQ8pBgnPpxKnhQJuc55Dd_9NI
    BXtBbEVx8wkMhCiZAZbIe2i4x6GSDD5OslCfs0dEqVV5mdXGvCHxMk>
X-ME-Received: <xmr:KqAKadApLoC3YRSSL3w_PTxdD_gJpIkGThUg1A_Xfu396-fj0zLsAfjaydPZQ_PLjSZD9s92nMyT2viR3lWHk32wI9sBSKqS3fnq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepkefhueduteekgfdtueegvdfgueeiue
    dvlefggfefkedvffduvddvkeeuhfeifeejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:KqAKaZf20iAoDj71eB_s6wjmw98AT8Sn8wH8t3Vwr4Hicyak4UZqmg>
    <xmx:KqAKaQImWbIxX12BnhWshKykBOaRdSri36gPwoc2bD8046ifKAcyXg>
    <xmx:KqAKaUfmimsVoUKauFWA_JJVOxjyPWE2H5Y1_o6TbOG9ZbFQoqKECA>
    <xmx:KqAKaf2IEEyZT81ETx_g7v3fij6bCokmTqX5Efjt97tXRO2yYsr7Bw>
    <xmx:KqAKaetjUtD69-C_KM0grEwySFgU1qYccfJ5T1gAHHh-GvUrpQFyyHXs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 19:54:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-add ignores exclude markers for ignored files
In-Reply-To: <xmqqtsz9o3cn.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	04 Nov 2025 14:11:20 -0800")
References: <MN0PR01MB761143093D1A4D226E8883A380C4A@MN0PR01MB7611.prod.exchangelabs.com>
	<xmqqtsz9o3cn.fsf@gitster.g>
Date: Tue, 04 Nov 2025 16:54:00 -0800
Message-ID: <xmqq4ir9nvtj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> This may be an ancient regression when e1b8c7bd (dir: remove struct
> path_simplify, 2017-01-04) was rewritten exclude_matches_pathspec()
> function, which was written in 29209cbe (dir: fix COLLECT_IGNORED on
> excluded prefixes, 2010-03-11), back in the days before ":(exclude)"
> and other pathspec magic was even invented.
>
> Perhaps try this patch?
>
> I have no idea what the ramifications of the change is, though.
> There may be unintended fallouts in some distant corner, even though
> it does not seem to break any existing tests.

One thing that I am extremely uncomfortable about this change is
that I do not quite see why we use this function to begin with.
Given a <path, pathlen>, it seems if the pathspec matches, but why
aren't we using dir.c:match_pathspec() for and have our own separate
and much simple-minded variant instead?
