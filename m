Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484A335064
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973128; cv=none; b=nxUJXuIzBdkJnE7bJAlFhDkUNQ+WmLwIXjXnv1Qc+/caRnrozFbnx2aRBuRWQ9uVuRfTe2HqUfFW3xOgXQ8EUJevE5VPZZLSCTY/tnfo2+iFACrLsnb7o6MleTspr1DlS2cF/NSoD2xugVl7+gZAtbU9dMsILm4hOON+f38QoZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973128; c=relaxed/simple;
	bh=tB5JW+pPlwBEtGi1tTH7602OPlsEDN4lDcY9WJXy954=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q9BmRNFHtQGplE73ECJ2QpHyEmwCqM804e7kYYY9+mHKs83Qoz/JNBWtqxxMJ3ZWkoBcxuMZJ+4bbPRYwcXlKHv1XUOAtrihhFzC9PvAfigub71WLJnU/qckXdoR65COCm9lOwQtRyNSP6s26VwupA99TG+7E5qEBCtLRnqZuXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W/EW0PWR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DdkujuTH; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W/EW0PWR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DdkujuTH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 236CF1D0008A;
	Tue, 24 Feb 2026 17:45:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 17:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771973125; x=1772059525; bh=GE0PIHDCBE
	zosTHchERTxGCYsc7sbkPIEgfCq9be2EQ=; b=W/EW0PWRDNnEVU+q8mAQllBBP0
	eitUGz/O+4PaZgOE/KQ7vMhdEVRCre0eDxu5CU1pL7C4kEBv8dLRZi2Tpsq1ZFLG
	f4Ib/w8FrEGr3Z1ZpKHfPDgBxPkQ9GNuCcWCrpgsMVGbfTDxTljnxyyY6sWuqKom
	R92M2l/qfuiosG26hm9WSS8zVxbuJayzHjDmwA+RzoRa8NwI8Uh2kfWtu+EvbyJw
	iGs+5no2K4P4TnJpTlnZd8trLPQZYl7uELJ88mmVIu89e1MZ7lW/LuPZCg5lNIoA
	iGp55jsGjYAqJnz/ln+co9BvRU6cCsVx16k77R/6/MfdoHMl88B9zhNv/16w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771973125; x=1772059525; bh=GE0PIHDCBEzosTHchERTxGCYsc7sbkPIEgf
	Cq9be2EQ=; b=DdkujuTHXk3qeQEzIMmZeCzKBpOilB4a6XlW7/St/cWnG4Q6cpA
	QroW4P1ZJZjb+3kzRThVXgHq6WyPqdy4AHYpwJ3x6ZWn2KdT2yK/C5K+xxMHUoSV
	AR8baM3p8vlM1MHip5A0iGefSJBEEjUqtHML2fshd0GM3A0vUtBaVlkwRhSPI/Pg
	zi4sfQY+gioPO5ojeWrgZKqo4RzW+mlCdNipPxkhWmVwUJhs6LMGY3kXPoTPGJkn
	8KPQC4dvHyC3UEf0owPwtXVUhlyE7E+aSzJ785H4dAJLpVkBKZSwYwPvyG+X/4lD
	DrY7KJh01kA3+4o3Z+gq/xKrl2tAtdUV2HA==
X-ME-Sender: <xms:BSqeaZKR1EZyYyKj8cWjEhaVGddjHfrevCOC9fD0kYKO6naoqtXHZQ>
    <xme:BSqeacANEA2CJJpm5VF2KEOTMv7YGd3YqU-qt3g4j530eLQc8qh0qmey1aHuKWIzY
    r5cV768DSv4U-alh-XzHk1vCjAm4xwRK7xNXQRSw12oPckjRkvhBA>
X-ME-Received: <xmr:BSqeaaDtQszPbwcMVI8FE7n51D7bUJPYrzfsAOC8ORPzRmgxj82vNoYwcpY3fJlbxtOnI5Aww1BqJE1jlhI-gYW9ECvVSGnFcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedugedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BSqeaWAXHm80cp8DM9b6Ow7twslUYFL3JqybWuProuamvgKIr71GSQ>
    <xmx:BSqeadrwZVpXv7J_JbT59YlXRpQWsvJ6rQlDp1cUtCSB58MNlp2Baw>
    <xmx:BSqeaYnCvyznAnn0gq8xXkcTvJXxIX_FPUOL3z5xIuLokGNtD05zMQ>
    <xmx:BSqeaVwy8tAZrJtrZmkESER0Jxjc3MLikNKDjpELO8EQ054zgDCoWQ>
    <xmx:BSqeafQ7XvPhJmI7fXVoJXR7LTqWkqtiGmR15mmdInmfBpcqgVNaq4p2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:45:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com
Subject: Re: [PATCH 0/2] fast-import: add mode to re-sign invalid commit
 signatures
In-Reply-To: <aZ4pFUJApZosh9Gc@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Tue, 24 Feb 2026 22:41:25 +0000")
References: <20260223194146.3476768-1-jltobler@gmail.com>
	<aZ4pFUJApZosh9Gc@fruit.crustytoothpaste.net>
Date: Tue, 24 Feb 2026 14:45:24 -0800
Message-ID: <xmqqwm01dam3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If you're _not_ going to implement that in interoperability mode, then
> I'd rather you just die in that case so that the test fails and then I
> or someone else will fix it.  `extensions.compatObjectFormat` is
> presently experimental and the data formats will change, so nobody
> should be relying on it working as it stands right now.  There _will_ be
> more compatibility breakage coming in future series, for instance.

It sounds like a very prudent thing to do to die as unsupported.
Thanks!

> I _would_ recommend regardless that you add a test like in t7004's
> "signed tag with embedded PGP message" if you apply this to tags as well
> as commits.  That requires a special case in our interoperability code
> (since it normally converts things that look like signatures, but when
> we're _generating_ a tag, we don't want to do that since there are no
> signatures yet) and making sure we do the same thing in fast-import will
> avoid corruption in our conversions.
