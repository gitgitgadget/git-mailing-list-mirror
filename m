Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1274740DFA7
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148468; cv=none; b=L1QKktmprAsbwVpHuSf0GthNrfUsqsZiYw5lOcb9bPRtY/2Wwyf1H6/SjqQW8/SDYSPpCorkozduzTm96JzNQYqb5Z7MgxZY2fgfgDwGNNBTyfw2nHXL+iqC7Hg2yjkpCUVnhePXII17pozRLBo4AAlJBjvcaD5w7ib9hY449mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148468; c=relaxed/simple;
	bh=ztXWHU7hd7gZN5Fyu7QGMV2aocyBX7iaMReMwETHoZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k+YG/n17VGl8lqsjc8t69Z9cb/X4CsVeX/Wqg2PjQFNOTc8wHghAxPAdeSn+M2Ko8VrL2EYnz3KANtqMEQCm9bQsHVlkRiTzR/y9oaJqnJ00J5uBrsdgYcZLxHGcGPd+S+mXLnk6/wISRFBKj0hs65zcakrKOmro6sYg9iUmx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IEjxUoSv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t42ptEth; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IEjxUoSv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t42ptEth"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D98014000E9;
	Tue, 10 Mar 2026 09:14:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 09:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773148466; x=1773234866; bh=4NcC4lIS9C
	VsK9FVcJ/e2ERWx5J+fD/HwabbRYOuA8E=; b=IEjxUoSvGBVJvH02r1jpZxHar0
	5zqikj7gF/CDFHAR9nvsyfgv9NvQoq/F7UCt//cPSXlaV76fpGirV5D081TZIwK+
	jP3blSDPh8N6c9SWpCf02Wxd+Kls1qTQU8p7jFbxZBf5QalahheosbH+SvRHWxXL
	d4+jgRoSgMqM27mEizk4KFTncCK0OXvU4+93wqzG343ud3cYuVZ/LgzdZvvfCiaR
	irn+VU54fKpGkoamoKDP+py2Khb9+Zo1ItK7/s6JsGCHCnPQ1l3unF1NOUov9khl
	FMxthtXYW2R0p4OaLsCi6qBEFeJe5xhHv3UIf0e4ES3GA1lQWJe90YeQ9MCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773148466; x=1773234866; bh=4NcC4lIS9CVsK9FVcJ/e2ERWx5J+fD/Hwab
	bRYOuA8E=; b=t42ptEth3P0mRU/UH9CRrCqJPGI/NT/0L3I/viVDRDharJPNOvU
	F49nE7aomjJSRvTcGNwE0RdotLHlMGA1uDk+6BHUc55P/yKG4DHl17zozf+I8/IU
	PdQR56W2BImXqjnKEA5d2M1vAD/ms0eIc3/PSDVlLkYoI93l15JcydG9UUFzpWfJ
	Hr7AmE0VtPNovuZrpHq1voZxTV8L+xkRSPH1urDv6BOMSc0WHkEoDRQNK68G9LSZ
	GQcmIshMc0OUtpLnkmSzsd9THWZAnz/FJudKqZU+fCujarVkj6wkagPMjjBqxTXU
	KuE25Vpq2olr+bQZVlAYpaCnIWe8KzEG0Gw==
X-ME-Sender: <xms:MhmwaUIejUO1EMxugBgCynFlkDqkKRu0JmRqC7uZXqERysKogxr41Q>
    <xme:MhmwabAUSsgXsUxq21tVJJhxPiCz-kO4-nd41h0VrjyT-Al4WnfbXbMF8wgC74cpB
    EnCK2hCMrkBHmPFgHk-jnrJ_f9TcTFsP3ffLgBmd70mm_sNxzSmgg>
X-ME-Received: <xmr:MhmwadCBcysK7GXm7MHysvYOoSt6Via30jBv84TPHcKjaG5pvoLWOnPkbjyvjRQxOsuXB5qVTs_lVpzRnb__WprYbrIRfuBOvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmh
    igrdguvgdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MhmwadBPMNgL-LaZa9PH81b5BFJmJ4bz0UV7jDVPlpeO-CYOC-7uag>
    <xmx:MhmwaYqYHJ2tG-xyLK1cGzPZIyL-OVwSbMujjjuHZKnJLNYHZ9iv-A>
    <xmx:MhmwaXlIbeXFquA5gjid-BO278zhP5I3oKEJPK_j3djS2Ly2_WosYQ>
    <xmx:MhmwaYzZafL-a9c8VCngCrlIJbCT7oXHXsQD8A7PcSJftXXjyTtFGw>
    <xmx:Mhmwaa27Ea8v8tKNnTO6o-ojaLxFJuepoNHc2dAy-603cQvKX4XX7LwX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:14:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org,  ben.knoble@gmail.com
Subject: Re: [PATCH v2] diff: document -U without <n> as using default context
In-Reply-To: <aa_hTifKYZ5KYREv@ugly.lan> (Oswald Buddenhagen's message of
	"Tue, 10 Mar 2026 10:15:58 +0100")
References: <20260309172719.125419-1-cat@malon.dev>
	<20260310053032.129327-1-cat@malon.dev> <aa_hTifKYZ5KYREv@ugly.lan>
Date: Tue, 10 Mar 2026 06:14:24 -0700
Message-ID: <xmqqfr67yggf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

>>Since we are retaining this fallback behavior for backward compatibility,
>>update the documentation to explicitly state that '<n>' can be omitted
>>for the short option '-U'.
>>
> i'd replace that with:
>
> Hence we retain this fallback behavior for backward compatibility, but 
> document it as such.
>
>>+	(`-U` without `<n>` is accepted as a silent synonym for `-p` due
>>+	to a historical accident).
>> 
> "silently accepted as a synonym" would be much more natural.

An excellent suggestion.  Thanks.
