Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CFA4E1C80
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606021; cv=none; b=qFKzVz5nGM6/vQu8GtKIsesYqYIw52lDCsLyhS3MwJtbuuA6A0UpSTOGS00/gO2DJ9THSKND7MsCoc5yqjzmDMHUK5CcI305Mtt3naWs8zMfdLP2OXbGDEKbbB8RJlKgNcXrI7oHQbfaRdnUODxCLLwN9vEynjfFXi/PQ7Bj3Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606021; c=relaxed/simple;
	bh=TjkYONbP+Kmj6qWl6whbCKnYotkM9RkroWHSbDf9FHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lg5u1p9NZtbTsSbeVPNgv20F+huvAx/conyFjLSWkd5IRU1IFmXIoIqhOU57ukxvHIthMzMiBh8zmCKFeoOoZY/OcD7qflkBcvdFmY3nJpAm0jkP+2jqN4wJK2rl96J/y3uBC/8k+j0H0lhIASC2p0NPoKvFH48K+nx7m1hqBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y2mberqN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mlS2Wx1J; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y2mberqN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mlS2Wx1J"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D49D41400021;
	Mon, 28 Sep 2026 10:33:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 28 Sep 2026 10:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790606011; x=1790692411; bh=ctwwqlFJMa
	spr0HK9j2+VP+zxEDhYSGKRTwCoiDnViQ=; b=Y2mberqNfqdkNCtK8s95/GkXe5
	MXhyDDS4Qgv7ExxKCCyJcdEQXoZnkCq3+ZCz03SLW9yPCDSfZEX+riHwNpWmmcL+
	KrKkrNmLfEVdRoJuAlK+pwlz0mRLjHBFSJVS8CJO5K7On9BwIhlINscOLbZho34W
	NXl1wwNhy4adtKdZYjYHLuphTu54tl9kDc4w0atdejN5s+Ga4BmK1WeKenlgKjeb
	ELiLXgnpfrAI4JtPT/+FaHVrWoN04grFWZL7PmaQE618r/iGSrAlxTARi2DMbl1k
	RDJ8xmhX8XoCeilt2/1gPZRp7KupxfrR/2Nj3RVTzVO7Ldmdl2tXx+xwYqfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790606011; x=1790692411; bh=ctwwqlFJMaspr0HK9j2+VP+zxEDhYSGKRTw
	CoiDnViQ=; b=mlS2Wx1JWpj07jz+pRxgZQeSAPi8Ti4zIdn1VlP0oXrn8wtjLLA
	aww9JJqiKPsWV5yJkJAjXaiVwpQqbCcy8Kj4WAv1O9cxNavR4caFfRENChVHScm1
	xov0P1Z8GAtPpSSRC6vmbxBD9wSx5sEE0B+S7TsBsfemeWbGvTpvon0VV8FAoh7+
	NhHnTdFLpPeKfcKgzXTmRC6DupZGpr/gLwIjMn3QWZn1y6WZ+QYAhbU/pKm3/ZM7
	wt3FkaCbcStMkR1LKVFHxvNYt+CyVyyLfXh/nHdqyt7+tdBoaArxAaDiHfqKqmLF
	Sn6SJTbJz1lHr11OWlk8orIawkxI4M9PjQA==
X-ME-Sender: <xms:u3q6aq27-EVh2sMJ5osZezfzd_VhmgsSYgjOR58jsvthLotUz_dsig>
    <xme:u3q6aj89LmiaGpPvBD0H-YAtcErj7NKVql3wziskeOLQFe7X-LOuRwDQS2S2DcOmZ
    JKJp-qFPchCeB5lDjR17sBGN6a9SThC7Y687k2h5ddmzngUruKUIs0>
X-ME-Received: <xmr:u3q6arNA3aELAIltqDb_ZPKfFe4Mm2_fR0ttIoH8RBASvLOpYUrG02Ug7maZCt9JSeGWI4xWgm9Gb5NFvUSFijp_0vbmcT8Fa94E>
X-ME-Proxy-Cause: dmFkZTGw7gPtDlB7rvF+CFgwr5GtkBixwKDHE47vvHWlWx3GPa4MvnbpJNaH2cfN1KgKyF
    GMUdtACD+CY3SrspFYX67zGuWj91QQOpY4x7pcuQyU2YAKLJMLLE7wkwox5WHbBuC0j5W2
    9PZNZpvHwePJieOeMt6e91O0MLuwqKiHAWERtUOfsJUROgFtRDjAUu6gYo3t9ukbeKM2Bk
    X/btZUUgFa11KQ4UO+0KNZ796za/HsWGE1vw7fQLpgcMa2Gdd2WLoxxjAZF2PMlLwL5FJx
    3aVNu1DkN1MDpNVFuSHnbAoOl4TwRGJiwtneCZPwZ+GuWHB0mwLHHF79LS7pL/78DoJLN+
    ugBMYvwc6TxfxPvvSqATR9fPCaJHXSdWwo3Uf8raJf7HV1hiieluwMWlSUgWT/FcIbqOwh
    lIPGxjyitjuQsXGch91/ypVLbO/lCI7chPhupBgnI5+yyroLqyBoMSW5m5DQWRt7F902Ag
    mYB3kp1cIxnY7I/uzSjiijoIPYgzdiYup3PWNln/LK4spydH+pnVyl68JOMaIFz2KVtpg7
    QM34rdEnCx7DF4i4lj2x9ITpYRwwp/+EWQNczBBsRfU3LSCmzYmN6dX5yIXnN5McxfBJqW
    HZIi/jN+vmGKpNy8fwf2qQHHerfc2DNrJnEizV8pl61SLeSjamy8/UfBcrNQ
X-ME-Proxy: <xmx:u3q6aneI-hehfuV0n6QNPmsiYVwLyApld89Vuf7WhKitmaOBg3ur_g>
    <xmx:u3q6aqXBEIH8pKiD5I9j8T52TH0ldZKXeV9M37tom8sccpZ4jYot_g>
    <xmx:u3q6avgKNaA_BBHwVwgcwxWsp9NAVPQQ5DyE6nbu1LnyjuyW9ToE8g>
    <xmx:u3q6ap_DSWGtxUO8H2pThUinPApofbgJwc_WFUq6BghhW3AL8DFYPQ>
    <xmx:u3q6al1JMQkpM9uWPqqvXsslusmwnKm0uDDG2TvXRmmAAX_cDGcpSm1f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 10:33:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Johannes Schindelin
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 3/4] ci(gitlab,windows): fix Rust setup for GitLab's
 MinGW build
In-Reply-To: <aroOJHlxCs9Rnwv-@pks.im> (Patrick Steinhardt's message of "Mon,
	28 Sep 2026 08:50:12 +0200")
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
	<57a83d15fda4ad3d4297f665d6c35e205e916e7a.1789819933.git.gitgitgadget@gmail.com>
	<arUH2KM2rHQwhmpf@pks.im>
	<1c829af9-1923-a6ff-78a1-b738cc6bf5a6@gmx.de>
	<aroOJHlxCs9Rnwv-@pks.im>
Date: Mon, 28 Sep 2026 07:33:30 -0700
Message-ID: <xmqq8q4lphs5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > Are we sure that PATH cannot ever contain spaces or should we rather
>> > quote here?
>> ...
> Well, TIL :)

Our coding guidelines share some blame.  As some implementations of
shells historically were buggy when assignment is combined with
modifers (e.g., "export var=val") and split the right hand side at
$IFS, we strongly encourage assignment to be written with right hand
side quoted even when you shouldn't have to.  Uniformly applying the
safer rule is easier on mere mortals than knowing and remembering
exactly when we do not have to quote and omitting the quote ;-).


