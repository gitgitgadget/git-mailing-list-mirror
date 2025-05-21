Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3D4CB5B
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833862; cv=none; b=i8mUPoUt62saFcaCu44RhpOMIP5KSQo3a9HcxaKrFHPGS1UrMAK3Jy+IcFfF8hZ36k+rCefedv5IAxuZBW1flCDWjq7umWTFkDZJrtER0Tj6SzWVkMfp0oHVt6H0WDuexudCTunE7xXjF8Uvh34o/HLpDt7V1FVWtvR5gX3XZi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833862; c=relaxed/simple;
	bh=RnPLq/WvxaKzIJZn5pXOEfISzl1P2Mg3LYsLjxNC3nw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qyotgswZNEP5EJoprhd5srs8Tg475QIRQFvDV/8ikPFjmgIwgn89jgEjPuiFRO+kop2xLogPhMxh/CzvQ6msLNpn4jACQ++NHUQaRPbMicdyzFezBKftwiMA8VTLd3HlsaWOOx1iWDs/0Uwr9SdI0woxP5gUg4xWIiiOZo874UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z1yZ8Ipy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d26hQECx; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z1yZ8Ipy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d26hQECx"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1D96D1140184;
	Wed, 21 May 2025 09:24:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 21 May 2025 09:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747833859; x=1747920259; bh=Tvw3fH3HZc
	Cp9W4xpFXyjm+g3e3LJhS93RVpVBxa2Uk=; b=Z1yZ8IpyFKCF3pWuEQifB6fw6l
	ZXlzcqH4S9oBwT2HKS09GL0xadsnKzQPs26hdipXM50Y3iEVIwUjJN0xEClQZTmr
	aKXkNIRxwPmtHutx7VrA7RXs1kpdh5q6jq7n/E6ZPOrLK48rPAlvt2dUEIpbAL1z
	MhlizJeTgniCqjoV474LBxeEWndMYt8uOF4Np6mDMEwO+kDKnJBdNcCtparv8gwd
	KQs9DLd991IHfR5fvsW5d0tlJVYpn9F0LpaoC9F6+ouzdELVAwnPEgI/JmTOp4DT
	VJqlBLOgPTygxrhJCMxlfVoH6pAj2VszUFVC+KVXk1cxxl0CKDj8WpYuJOBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747833859; x=1747920259; bh=Tvw3fH3HZcCp9W4xpFXyjm+g3e3LJhS93RV
	pVBxa2Uk=; b=d26hQECxJhlMEO9uvgaU2IYAVVGLS5jqhj+Sv5zZJlelA2ucJQ4
	KeqaAgLqwmar68uzNNPsdJzImud95T/PZVogJftsRIUJOv7qB6KO9LWUymnNcqw1
	0AU4quKybIFZE9dPXqkmE3YcbfyPtXTKormPcveFoitN/yABOWw3BSEANDG9vg4x
	jYZIJEan22+IFbgQyoyztKDK/4axzGG9wMh0qhmeEdoB7UUrZ64OVHG40SesKQpS
	/9UpMILOVYmYKunSTjBQRjszFhbNZkf18uvE2FbCfHFjLo5zuO/Zu62+IfsoUjdu
	LNidJ014rE1voDENwn9SBrN35emA1kTK3Tg==
X-ME-Sender: <xms:A9QtaM7o0MBQQOrSWSqOtNMb0HxnpM_Hv0AqSunFkyGqFbLnaiqFDQ>
    <xme:A9QtaN5P-lP8J5ANQkkZCTVes3fRqUlGkGhZq8xhtmpWsfIidNGCBbWI88fzGAI2p
    FqhP2QYCDst5sDOww>
X-ME-Received: <xmr:A9QtaLfNXcFdXYgZ-LXKMM08YbS3aJ7l7iERLUlAYmM_rVVa22z1z5W7mfUl9hic8DSaB6oyM3P4naClOFTvBFZptalQ12Cb7zFTOEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefudelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeu
    ieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    ehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:A9QtaBJtWjfcCge0n7EpBWmdktSbuwbgFIDvoVvemU3vGjLCuwgaoQ>
    <xmx:A9QtaAJhWjRBfuReu2kBLRWu5eMesXwXIIC2N-LCmyDqTsfN7RE_wQ>
    <xmx:A9QtaCy2YSi5L1l4LzyS39wvHiuh2bLJWHIb3NMe90teFA9ABrMkhQ>
    <xmx:A9QtaEKqc4Y7fSw3vKsIMBqKO03r3Kp5NcNidkPdkmuSO81CvBrR3Q>
    <xmx:A9QtaFokgz1K8fO7B-9mwk54yDf3fKkA0w2RUqngm22VOX0SsNIEt1gt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 09:24:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2 0/2] packfile: avoid access(3p) calls for missing packs
In-Reply-To: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
	(Patrick Steinhardt's message of "Tue, 20 May 2025 11:53:08 +0200")
References: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
	<20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
Date: Wed, 21 May 2025 06:24:17 -0700
Message-ID: <xmqqh61edrlq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v2:
>   - Drop the patch that reorders syscalls and add a comment explaining
>     why the order is important.

Much nicer.

>   - Add a negative lookup cache for indexed packfiles.

Looking very good.

Thanks, queued.


>   - Link to v1: https://lore.kernel.org/r/20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im
>
> Thanks!
>
> Patrick
>
> ---
> Patrick Steinhardt (2):
>       packfile: explain ordering of how we look up auxiliary pack files
>       midx: stop repeatedly looking up nonexistent packfiles
>
>  midx.c     | 10 ++++++++--
>  packfile.c | 11 +++++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> Range-diff versus v1:
>
> 1:  31ffb3712ca < -:  ----------- packfile: avoid access(3p) calls for missing packs
> -:  ----------- > 1:  6125b84389d packfile: explain ordering of how we look up auxiliary pack files
> -:  ----------- > 2:  8cb82a771c0 midx: stop repeatedly looking up nonexistent packfiles
>
> ---
> base-commit: 1a8a4971cc6c179c4dd711f4a7f5d7178f4b3ab7
> change-id: 20250516-pks-pack-avoid-stats-on-missing-8e3b75755cf0
