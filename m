Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793CDBA21
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771694274; cv=none; b=O2z4TYTMpFnc291Oak5kokqMKRFP1VTiMokoDe0jjo9ThO3tzH1zKMJ7qOWA7NAXC4a+x2kFoDUWxP3mg0795RlBoNpQsISO0Y3USnooAyA8M/WQjpBjeWnORSWYi24ZYTi+9VfRg77zc7q78Wch7/a1LdbBVNoPJDscpN3AZg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771694274; c=relaxed/simple;
	bh=nzxoPlCOkofiLmQ20GyTDLb+LR51tIgA6e3kt3lCVe8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C5n9EWTHUJ1Qikstl7G3DsfFW1W3QCT4aB3/u37t2f23spgUS86y4HiauuYbZhD7/m/n+MdJ3D4V+n4g9fAEQIG7SJhelx/MSOgMBjNEWNS24y9jevj6v4YV8KUMQPYroFC6l9PYL6uS/E1sCm0eSvtJc6j2JugE0ng0pbcqVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P11owOgZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7K9X5TA; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P11owOgZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7K9X5TA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 884F77A012C;
	Sat, 21 Feb 2026 12:17:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 21 Feb 2026 12:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771694272;
	 x=1771780672; bh=nzxoPlCOkofiLmQ20GyTDLb+LR51tIgA6e3kt3lCVe8=; b=
	P11owOgZzU6NMvEE1DIHXqDfyRH8PJecqSFHjmod0l+ubl6BffbhtBmxWZzoPAny
	rNzAMCbIhhQQ1IuQgW4XJQZpi/hpUrfpBLxuuzeiA3pZL0zrnJGQpc2LDWD4VPq6
	M1UBrIXMMBTUDgq/saRNBMqWJKWPtBWoGVB5wc0HnMJE55RTPDBV4SQGXLNItDPt
	Q91gGF5zBWOIxmW8LEilWLj/cJ+RBFb9NalxMB2wpvlDfcoPXld3dHDdlN1u6NsE
	NtqTST3ftlFIcmASZPL/tVuf9Ka9WLM3ujvRf7hoTHiwFOWE1tUlkvGQRttjXt1O
	GbJ8xN80Ss1Emoi3c/uQhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771694272; x=
	1771780672; bh=nzxoPlCOkofiLmQ20GyTDLb+LR51tIgA6e3kt3lCVe8=; b=Z
	7K9X5TAtnHODtUBWzmR4Eh+HvIn/E8iQynoonjueNtNYyd97GKMvZhqxEBNmIeWP
	EljRle6loirz1ndLuVwDPegIS9maaz0KAmHtmGqJqhkaKylok3xlA9GyL9ni21p2
	yY8l7Hoxz7vkiX87d4mvoZ+FymRS7mh4m+oYtrdY1C4kGaVad55UtqOjOG3p/Gxr
	1vjKEERfxq8qONGNQYj5YJW1uvTlEWR4saRov3cGoWsYqoeRW10SmuJhLt50eol9
	WozkIi8YCFP/tHgZzEr6qRn+RMbl8kWnkatBksdSh8eLVwyQ0m6j05bckkaqS8Sg
	dn9scXpxjvkZoTxnuAhUA==
X-ME-Sender: <xms:wOiZafcs2BFoZJuQhQ4hVkW149wcALwHfFQzjc5OXLVYx81h-CwgHg>
    <xme:wOiZacH1UZLyHV1b7M8kPy0DlHXc0W-rdO1rfUz7eVz3wHnXPuMdtML33nknd2CCv
    5bp5zLpPKiqZLvtAdIRFVXoymdQVwrEN1sgGYI1GRWGJx6b64sMzA>
X-ME-Received: <xmr:wOiZaQ2cr37juI1iecbPSaU3fIlg2WqXUecFq1s8_tQ32odAp8TjPsc3Fg8xgKbYS1U18bMmyNr0fVVEoGN9Ri2G70xK6sdeQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeduleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:wOiZaclJll4E1ZPRnAWV_6iIeDNeyl_JX9Ex2vX3e95GatEgpvDbOQ>
    <xmx:wOiZaY-9qdT3umBSq_rSRHZJdMFmpY6N1LEU69C35lP-DeRocWyfcg>
    <xmx:wOiZaZqJZNIi714W_HL7e_w8n0AECKo8mzTw9dxKEwJtbh1q4AnjUA>
    <xmx:wOiZaZk6oKTbjW2AJ_tZLLQ1K5AguhhVhilnMqkMc9iUn8vP5_AzVg>
    <xmx:wOiZaTGxO5y-Ts1idASHoiVDQQUfalVww9401ftHr_pzYJoz_ka6Js_I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 12:17:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: gitgitgadget@gmail.com,  git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v28 2/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <20260221080201.7847-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Sat, 21 Feb 2026 09:02:01 +0100")
References: <067978dd0946732e00e4805d62ea51348fbf336e.1769112471.git.gitgitgadget@gmail.com>
	<20260221080201.7847-1-haraldnordgren@gmail.com>
Date: Sat, 21 Feb 2026 09:17:50 -0800
Message-ID: <xmqqwm06rp6p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Hi Junio and Jeff!
>
> I see that this topic has now been marked as "Stale". Isn't it time to
> merge this now?
>
> We went to several rounds of reviews and edits to reach something that I
> think everyone agrees with 🤗

The entry has been asking "What's the status of this topic?" in the
past handful of issues of "What's cooking" report and we heard
nothing from anybody (until you responded ;-)), so I moved it
together with others to the [Stalled] section.

The topic has been paged out of my consciousness for quite a while,
so it may take some time for me to answer this question myself, but
list participants, do you imagine yourselves using this feature in
your daily life?

Thanks.
