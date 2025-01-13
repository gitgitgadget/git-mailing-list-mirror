Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D63324024E
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786559; cv=none; b=qCoDdyGfR69g2R8oDhh/EA7zNd9YQBNh3aIP4BkhkO6JnqRDob4coKx8k3n3UR7/shlk2BvQmywLzsq2m6W9vtVA7kfTlrpQVJyIv1SCol16GAML4owBSh2rmpSL9TbKiYtzICz63LiyIKTQM0/xA+Qsz7Qo2GR4XLhncMDSkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786559; c=relaxed/simple;
	bh=DSsWzpit5L9c/EUThbbDuyArkKLpIeIpAgo3SRS2qls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nXIf+9BHR6TnrxkJJ/dy8hOxBs3C4eNv9dx9Aqwc37yQXjjeM5LIuzJVQEg3GUqo2UeCgPjI1//3Lcd79xDpCwKMjV92US2yvgz79QfOHu3OQtn75AZE7q8KDQfcxr0eF+9OWNPoutB8AkkTxQkvKRUCuDILWDaAAAd0983z+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=31ZHrnga; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Za355Zxy; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="31ZHrnga";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Za355Zxy"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 933D911400D1;
	Mon, 13 Jan 2025 11:42:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jan 2025 11:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736786556; x=1736872956; bh=sE4zEm05U6
	ZSkp5KZjhl31RfMNyaEP8BrYWZyvD6WUU=; b=31ZHrngaKh6t+SuNJzadVj21tB
	3c2LuaX4Ub5Jf3wuu5rkomCoGnm5tjx3+PiWcCLq5w3HQFicn7xogPpvLsgQuuYO
	vIH4WPig0KZX2RAe5V1Tp6590IIVfSWC/dr6TVoV7l0db+QSESVCyNy9uvsLrHp/
	DC6hDpwrWihNZGeKSZcMEfcBWO/uQMezo/iMIxroiX/dsBDhXv9jrdDNi/H7jYfW
	ECYEPoBdF0g/vlR+4kdeLXr9XIEypElt9sZW0VqAJ0SdRQLPgJSleZUSCTA1XAEG
	bQq7+BURJptCvhxteDimux6MRZEY3V71IH7PinkQAH2nmsulWpoL6A+uX6ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736786556; x=1736872956; bh=sE4zEm05U6ZSkp5KZjhl31RfMNyaEP8BrYW
	ZyvD6WUU=; b=Za355ZxyabHpHtUzKdDd4bQjMwebHfIWdohIVBsR7H2tmCenzK/
	zABvW6hws0FcCAnndskBc/cZYAUy0yIvfc+f7E40G37XORLpjFGWyQsG5wWpYhS/
	alp6ylGMSk3hd/DYKVUWrEl6k/1F2CS/EO0Rt+Eyw+JQYyB02VFHynGDv8hZvSXG
	TCFu03LZj1MQ2rNryZaKs2HBynA/78+6qakXotFJwiUbbXsGSSPAR5RV2mWMc4Xu
	cFVpOakgqjl4mGkI2QULVtMiSUIXRTa2tQ8LRz2ZVnyaWopZRxRcZQpmXgv/iG7G
	ZdRhnR6IubZ7PDQWIXD+PXSdAHKGv/EG4bA==
X-ME-Sender: <xms:fEKFZzBCC-1sAqovtS8IgCodIYI1BnayCY2R2NfCcN6NAr12nowGTw>
    <xme:fEKFZ5hqePffcapMLQE8hV-CjwqhOiecFiOFn8uW0HhzeqW3T2B6prPASGNdPLpRd
    OgMdCXZQzWyA-KAWg>
X-ME-Received: <xmr:fEKFZ-lKipktC51codSW4LjV744J4Qe2OWMxis_sQdjGNbALPnQz1NDB91R6xzX9KOK41s1FTsBLDZ2VC5X1GL6ZMqpUAUETa3BH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitg
    hkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fEKFZ1yn3gBcJy9n7JZtdZUjU1tjMUUsEqCnJX1cN3L3MyX-_9mYdA>
    <xmx:fEKFZ4SuPbYopOf8y8pg89iH4St7PYf4YDZmAZdwmzOLfpzTYeZsTg>
    <xmx:fEKFZ4aCpN1cEVJkIg2XUExWxvSCU6yhOXgotgwEzLb8x2hrAXTllg>
    <xmx:fEKFZ5SIdSY-aRpBvuUAS1RTsQwYSYFZQxHRqsWjM5T7Qs7WTkh7eg>
    <xmx:fEKFZ7G_9ZnzBgMtbW8D9uQS3n25J4dt2H6FdfCnkZimDd-cAU6tVknj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 11:42:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: M Hickford <mirth.hickford@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net,  stolee@gmail.com,
  avarab@gmail.com,  Johannes.Schindelin@gmx.de,  peff@peff.net
Subject: Re: Changing transfer.credentialsInUrl to default to "warn"
In-Reply-To: <20250111071500.710169-1-mirth.hickford@gmail.com> (M. Hickford's
	message of "Sat, 11 Jan 2025 07:15:00 +0000")
References: <20250111071500.710169-1-mirth.hickford@gmail.com>
Date: Mon, 13 Jan 2025 08:42:34 -0800
Message-ID: <xmqq1px6br7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

M Hickford <mirth.hickford@gmail.com> writes:

> In order to nudge users towards more secure practices (namely,
> using a credential helper), would anyone else be in favour of
> changing transfer.credentialsInUrl to default to "warn"?

I personally do not have a problem with the proposal, but it is
curious that it is documented as inspecting only .URL and .pushURL
is not checked.  So, in addition to "once we start warning by
default, we'd need an advice message to tell the users how to turn
it off" Derrick says in the commit log message, we would probably
want to see if we should/can cover .pushURL and need necessary updates
before it happens.

Thanks.


