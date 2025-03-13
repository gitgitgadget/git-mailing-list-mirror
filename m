Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E4265618
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883296; cv=none; b=OYzET2kPLgVXQ76YOfxvdHg6RAL4N3p5Axi/q5/U3Cyjxe/1Nu8E9bIgVoldGsZiskRH1W3ysZS+jk+8eLqhwAjnGWL416Of0W/ejelFnnhRPzCQyME+PQ/OIHqnLtXD2541a7MTXNdXmJofqcEPuzvl/C11RP+X3X20autPPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883296; c=relaxed/simple;
	bh=beU1a95O/5NxGz2B/xXx+jLZfuPfbBeBTmQrKupocBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jotxvT7nuuOQdJX4/Qfdgl7O/fEA23X6VNNb6Z+HBn0Va3WCQv1IJMsgeOydV+wg/OEkvV3Tw6T4bNziA07yXel3c2NtGYeTbZnCsevZWDdtSDilR7i1OuKz9HR/zjf5TtYPX2IoS02roMX+t3EiD3P8EZlXlUF1pyP3gyF8tiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NPv2tNRH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=54XVA0kd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NPv2tNRH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="54XVA0kd"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E1EF11401BD;
	Thu, 13 Mar 2025 12:28:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 13 Mar 2025 12:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741883292; x=1741969692; bh=17amVfnrCv
	etq6NiiLitfpF6u4c22qhCw6K0RMoVZSQ=; b=NPv2tNRHeWcuGbwsj7PtflvYAg
	Bj0qUKzmSb97Pu0/cUpzngOvG69lVZd1BZNxpYJKNMlWsbAFf6iXnQP7tqFHksrL
	bQwVl/IopQk7nOGuPRKFMz1I60TtndmfHhasJUby//bf1wjsu8Kb+vwEOKEWjjLn
	Akq3Rs/HWJegpBdS6tYwKt1Z4rvnO0/O0v/MU72bXYUD5Ly5BigolLSF/YNHSBcr
	orhKZ+JcOe3bsqrUjOOoP06kVJLhfbvfdtDxzUAaptYDnc6RFWeaKot2mKODFrf6
	NpxdEz7VwaMTzwslLDrqhqy67o1X6roA/HN5LMbiWucXgzN5SdVf6fZhzMWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741883292; x=1741969692; bh=17amVfnrCvetq6NiiLitfpF6u4c22qhCw6K
	0RMoVZSQ=; b=54XVA0kd5evTDLC7WLIGwNy8hD1yIjXqDmyJQd7IWmQTQQxoj1b
	jfXqjdaFw/h2DkmsOCr3lNosjK0mlZTX9ETHh//J076dw7OgxLMEPlEZ18KMGYiS
	lti4n8T+Vcw61F8jiH5ggo8OO9A/AP8qCy21vmPNRhd+AX7PnhZUNBiwGAEPETCc
	ax+Ix5PKs3so78RhPwkGBph1cH3gh90xRyVVahVvs5LFbfhNova/oHO1J2m5KN2f
	9/RKQoV+YBI2OZR0lAPGqGwZFHqKP3fZtHE/F8bNjv7MTQk6h3NuzJ+Du92EXaen
	LWfa74azVhOdailbiWwdgEoMH5336gLo/sQ==
X-ME-Sender: <xms:mwfTZycSp7wN0gX6uz-q5RTk49N9FsXzlrX4VaMwqLe6WZDopCp4Ug>
    <xme:mwfTZ8PgW0N_voXveX6ZINvmtRBAwjORWA2PGS2AY_Lgf0rFE1WQvVVQGUycbdDd9
    HKX3_xzk2bQdg2xYA>
X-ME-Received: <xmr:mwfTZzg9Mn8Xfd1mRArP-Kmh7Y6nHfszy2lIX-Xpv0jYck9TZUcijRSTGakzdRRBSJ3iP8VmTQQoO413gjssnFQYMtWQyAGxxfnAA2Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:mwfTZ__M54-4fFLwuy09T7mgwXqqb6ZoiRE54CBKBbWGwPJFokmCIw>
    <xmx:mwfTZ-smN-HqTa1A_qmLhmThiFEmDRHSULt8s_CGd5En03xJ-_EvWA>
    <xmx:mwfTZ2FQ_ZyzyUU31r8HgRDJwWAI2cpfnaWL2oiI-Kewr3a-dbR7ew>
    <xmx:mwfTZ9PwGxgEB03JoEH8JaO2-fY5wnDS1_5SMiuFVYi6k74BkcKs4Q>
    <xmx:nAfTZ_HLQT1fPIyBnhY85RLLdblWbMNJtLJi5MduLgKHpgH8YjQxZOZS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 12:28:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4] promisor-remote: fix segfault when remote URL is
 missing
In-Reply-To: <20250313103859.817127-1-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 13 Mar 2025 11:38:59 +0100")
References: <20250312114628.2744747-1-christian.couder@gmail.com>
	<20250313103859.817127-1-christian.couder@gmail.com>
Date: Thu, 13 Mar 2025 09:28:09 -0700
Message-ID: <xmqqv7scq4iu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> While at it, let's warn and reject the remote, in the 'KnownUrl' case,
> when no URL or an empty URL is advertised by the server, or when an
> empty URL is configured on the client for a remote name advertised by
> the server and configured on the client. This is on par with a warning
> already emitted when URLs are different in the same case.

That explanation makes it unclear why we need a new one.  If the
configured and davertised are both empty and the same, according to
that "warning already emitted", that is not a warning-worthy event,
is it?

> Let's also warn if the remote is rejected because name and url are the
> same, as it could mean the url has not been configured.

Are we rejecting a remote _because_ r->name is used?  I thought the
code did something quite different.  We reject because the url does
not match, and then after that give an extra warning if remote nick
was used as a fallback URL.  Even if URL is configured as 'orogin'
for a remote with nick 'origin', the code would have rejected the
remote with the same logic in the same code path, wouldn't it?  It
is a bit confusiong to call such a situation "rejected because name
and URL are the same".

In any case, why do we want to keep these unconfigured remotes in
the list of candidate lop-remotes in the first place, and why do we
want to treat empty URLs as being so special, more special than say
a randomly misspelt URL?  I think I asked these questions on the
previous round and I do not think I saw them addressed at all in
this round.

Thanks.
