Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B35C2DCBE6
	for <git@vger.kernel.org>; Sat, 24 May 2025 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748046191; cv=none; b=npeu3nCP5t6PPiBzZHHpRjN0sfHXclevWQvqySqbJ8Ot1iD+oNJVk6ZDXLsS+WY7f4p9Eoka13lgDc1vbnl3cBiHwz6hkdVt1XT5pSMnhwoOO5u9ZQ8nBruz2NT+E4t/Ax5m9opEyD+sfk+dosoy7O2SxfaVnB4uEjOS+Y7jMC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748046191; c=relaxed/simple;
	bh=ENPkcSNzmfvjrW4FTPzXdJHyKk3uePgmPTJuYz/aoIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sTwSs7fczXwoVSMsKElkiXVyhhE17mgO54s819IKMDR4Zr/9EWIQoKHpCvu8t1aMwzBHdDaJ83w/YXHQ50Ym2bnpQLjB24mzX9X6yHw8jlJ6Kk4wxXrkH0dvKtqjLwRmlHRC3BY1autsPyZOoMDbgLjftTXSk1ZAZRSFT/8RYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ciXo1141; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=alevSn8J; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ciXo1141";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="alevSn8J"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 544B811400DA;
	Fri, 23 May 2025 20:23:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 23 May 2025 20:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748046188; x=1748132588; bh=h9dAAdZDa3
	crgd+xrWEWTdFtP8ie2Ljzi3Tf9uO3/eU=; b=ciXo1141XXVAlPbUX1Pa1ad4iF
	E081iGMQ39vDnVx4ggYxUjApqimLKJnfkj3gcN3u51rwXDK2Mdn46x5bMGPWox0L
	naG9vj1wI7iJJuUukuJEygaNYnTrGWdNouU/+o+5H6XcrCz26ttKYiLSrMok02YI
	WnOBEOK6yuUaj9q3hqwDAkSriiWIjZzZ8CcNeSyNywsxcN8IQmUIk0F/GZqXPrs2
	SDBRoe0xZPWDxrL0YaoLVb6T6i+rojnJYwXQx7IDEL2Zs2gbQ0tVmmq9FduVClRg
	SnhaM9DftacG6gxryxl8maDBIx5q7kERITtbtPv7aMkVOnF35qv965lDmUaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748046188; x=1748132588; bh=h9dAAdZDa3crgd+xrWEWTdFtP8ie2Ljzi3T
	f9uO3/eU=; b=alevSn8JkMFcBODjLhBYKHQ7h5NlmoCZ6BMQDjwd4tz/k9bmHza
	CZ0UB8TVOlQck9h5hlC6qv9EKIcVdU7drSR82gYmQXHaPqWnc2REoaifsSmrgccN
	suqiGnbHKYcNVsbFRsRvD9iuX5xuYK4qdJnBgs95TrGP5k1RchbZ7sUPT7T+2mjz
	V7HJzbocP07THqhP9Nt/G5vcWKvh2Pxn42I2jphUgyfNXKxic1FtnsbeE/58QrjW
	PT3DdJEn25p9gx8DgEKb3DOgnN4JjKlxbftcip8UdxqmpxvljxgDryedEP4KddSJ
	Z/0PyYt/iEA30sKzSxgceHndnpFMak98Xgg==
X-ME-Sender: <xms:axExaDB1D5dcR5nCsHX0CoRo-t6ibHgru2Fp8BV8GKo3osrpMBct5g>
    <xme:axExaJghFCWksd1Mjam9lN_8tBwUY35WpcltEfcXRIhj_h6xKFoj3DXduNUSZtrCZ
    02G9NBgQR2LcNZXyw>
X-ME-Received: <xmr:axExaOk1QZ8-NhyFHRYgw34TAyBhwJZwdXVIMkIrL1Cllo7e23jOP4Cy6p6qPzknS2mJGL38cknVyqzQXMI57_GGh4pj6suE09Xj-z4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddutddvkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:axExaFy24mqO7oCwEqouGAKaGeSZfK1e6gIGpT2pCEC0JrLMPJvzvw>
    <xmx:axExaIQRclNZ0OmPYAS1BrSu-LUe0l9lY1Ho8kCg-22cm2nQEIWT8w>
    <xmx:axExaIap5CF2MjjtpF2e5b5BDEKYtnyM7CtrNUo2FF0gyv3ISXsbgg>
    <xmx:axExaJQj0Myq9_gI4JTMPFzhvlOkM0tEoG_svpAdmGl38TfWGPogAg>
    <xmx:bBExaDniWJRL3dCRzFQFvm9ykFaxhpqr5mpBs0cN3PGaZd6aFH4YF1q->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 20:23:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 3/5] builtin/stash: factor out revision parsing into
 a function
In-Reply-To: <aDED4MrweIc0N51h@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 23 May 2025 23:25:20 +0000")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-5-sandals@crustytoothpaste.net>
	<xmqq1psg5qrb.fsf@gitster.g>
	<aDED4MrweIc0N51h@tapette.crustytoothpaste.net>
Date: Fri, 23 May 2025 17:23:06 -0700
Message-ID: <xmqqzff2uaad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> A typo for "pwood", which is my alias for Phillip Wood, who I intended
> to CC.  A typo which I unfortunately didn't catch before sending out
> patches (mostly because I was sitting in an airport lounge when I sent
> them out instead of using my giant screens at home).

Should git-send-email be able to (optionally) catch a typo like
this?  E.g., we have an address without @ in it, and if we feed it
to alias expansion, it comes back without a change.  It could be a
local address but is more likely a typo if you are sending the
message also to an external recipients with @ in their addresses.

