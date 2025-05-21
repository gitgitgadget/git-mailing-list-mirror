Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B52AF1E
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840843; cv=none; b=Ebq3sy/DrQACMJQ4Cn1ED0wK9YstP+LqBZZ8wnBzHNeC8ylFiQrB2oBvMuXfKpaWxWoRu03Pu4mlLEHcXxAVNJ3ycT/yfHMIaI372NhIb2BwWYEXmwfJC8J3ivRP826gQ03rz4PH3m8cuSvkDgJ4jemG8O2Vc81c43u262FCyPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840843; c=relaxed/simple;
	bh=o7+fUpFXK+I8PohKE6uM9P0qcvow27E4X9IIBIz7+aM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gAhV3cWuiyAKdCDMXGExc32vXAoggVP66dIu0PWEMm3VXPPPM5ez+7dElQ7Suc1gIOj2P7sDUWylWGO7dqvDapSSa9QaQnH3yqSY5w0zXlmrW88SyrI94ceqjus/KN7cDyF1eYGU7C5Liaw97EazG0hKZEpkpEtfnNZl4wCU438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LFoFP5sB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uNU4CZqj; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LFoFP5sB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uNU4CZqj"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8EC73114017D;
	Wed, 21 May 2025 11:20:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 21 May 2025 11:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747840838; x=1747927238; bh=phgggw6cJ1
	U2NkNB2F2oyf3EuifzxkTpQBWX5hfh8HI=; b=LFoFP5sBLRtUC/FwjF4OFhGBFe
	kJCquVuC6pFNOT781UP2iK/M3uMV/DnVit2g7iAl/+D5scUWTqt7Jt7xZl27bPqz
	hr0JXfPMZxI4YPLV1Tl//PLcKXRartq8pSM3CYPhG+yJnrflLg3Rzg4sO7QG89Yw
	px+xqQPSjunY6sVTAa4/EVI/kHI9BRCzULp9p0fxvOvYgOyCh1eYc0G8zVinaHa1
	X2MVXyy5lhXSsBPzlShYyDP6zoXW2MMQJ3Txx2MYqZN54u1raPG0BvtXlBYCOEzX
	2KvYnpdLKlZpu19dC55jPgQrata75NRPgMQPicJcYMJvUGFpcIPyTpecgk5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747840838; x=1747927238; bh=phgggw6cJ1U2NkNB2F2oyf3EuifzxkTpQBW
	X5hfh8HI=; b=uNU4CZqjGTZkMScPvfjV8n75WcoDxTLAGAAwH9u9k4sSoD+Mo3O
	zws5G8V6QgXY0rYxcWWd8L5m3PHMMH4rpZGpouyb+udEHCGSIoqPqDa6Umj24Msc
	OBhcQnrOhXxSHKk6wJNk3Q5PCqk6scrRKhgOfL/dzjW3C6hpu6X5BW7LknQst/61
	Me1XXAlv9HpvCWIYY0HCwakj5FJgLUasinTJJyqYXGz8tHxS1B7J5he3hbCa518N
	wnFEM6uZYr62gjE52naYmRQPG6QY/NZKRw8f/AbXAeray9i9AgQYXstkqCxIBqIO
	v45hrre4TbieFFuvP2KqifCb3LXWAZumMhQ==
X-ME-Sender: <xms:Re8taPoN2_In6KXs8sDPvY77IEv06wNYesfgR2yrSHyyUvSKWKWZ-g>
    <xme:Re8taJqrQSzFwDNGaKdfDS2Y9Dj-RvjdX6yLHUaq98E-9IX4sPGcYj0pdrfy-tO61
    wHyKW4sCop7AflENw>
X-ME-Received: <xmr:Re8taMPEeo0rciJVLZW7xYwvDycoU_QwD-tKR7LUfyHWSt4pw4y9Ca7EQJC_SrT7LqebgicohjcZCabJ0v2V6jv0iGo4Bvq30WP15Oc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefgedvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhig
    rdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Re8taC5ltExgd4J3vNcLPzx1ixQBf8axlzePzyTjEXUutRTzH6GRQQ>
    <xmx:Re8taO4sYiLO9yw1ovwJv4V08kAm1yOg-cwiKgaZcZEzkgx6WPKABg>
    <xmx:Re8taKiReSiJLwRDhfAuzVhFJC8qYDu8pxzIougjfdf5dPKugg7wDg>
    <xmx:Re8taA6GHd7kAYDNWWgHRURFFEURnX3h8lkfZzGPU2uJYX-dJF7fHg>
    <xmx:Ru8taMwikHJ2qhBVuDq90GjkBDAfEXzzxqzChcaD7BDnl9IkVgSUfgDi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 11:20:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Johannes
 Schindelin <johannes.schindelin@gmx.de>,  Jeff King <peff@peff.net>,
  Elijah Newren <newren@gmail.com>,  Calvin Wan <calvinwan@google.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/4] editor: use standard strvec API to receive
 environment for external editors
In-Reply-To: <CALnO6CDGGiw2HJTjfhvnmLQpQYDJqQux7UdO1tv0c9-LqNXMxg@mail.gmail.com>
	(D. Ben Knoble's message of "Wed, 21 May 2025 09:26:50 -0400")
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
	<20250520193506.95199-3-ben.knoble+github@gmail.com>
	<aC2HF1VEosDMY_A2@pks.im>
	<CALnO6CDGGiw2HJTjfhvnmLQpQYDJqQux7UdO1tv0c9-LqNXMxg@mail.gmail.com>
Date: Wed, 21 May 2025 08:20:36 -0700
Message-ID: <xmqq1psic7nf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> Thanks; I didn't know that! (Aside: rebase --signoff seems to add SOB
> even when it's already present. Is that a bug in rebase --signoff or a
> misuse of the trailer on my end? Setting "trailer.ifExists =
> addIfDifferent" didn't seem to affect it.)

Why do "rebase --signoff" in the first place?  Unless you forgot to,
that is.  "I do not remember if I did, so I blindly add it" is
something we do not want to see, as we want to keep signing-off a
concious act.

Anyway, as the intent of the trailer is to record what happened
until the patch was finalized and sent out with your sign-off
chronologically, if the order of events were

 - You wrote the patch, gave it to somebody else with your sign-off,
   to show that it is shared under DCO (a).

 - Somebody else may make modification, share it with their
   sign-off under DCO (b).

 - You find that their version is a good one, and with or without
   further change of yours, you sign-off to show that you are
   sharing this final version under DCO, either (b) or (c).

it is perfectly fine for your sign-off to appear twice.

The only case Git's built-in sign-off logic omits adding a sign-off
is when the same sign-off is sitting at the end.  After the above
event, if you took that "final" version and then gave it to somebody
else, with or without further changes, that is still covered by the
last sign-off you made, so there is no point adding a duplicate.
