Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04B3AE71E
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173363; cv=none; b=Cf+TBXzO2N94jxQ4XcUB/HOHdaDbmvoLP4b9CBBWzZ3ccIiTOiRbpVgk+NCGFEXPMFdS/yQVS4do1oxospwHIrRr6fIfgFedZ3QMPzy0X5Pxy7leIup5Ka6hzh7fm3WWm7Ljzttt2XtazWLsBgyZcQAkVPnArEuC58FQAEqLcGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173363; c=relaxed/simple;
	bh=BzCZQzJEuzA2ayFOQx1M0HjY98NLBXyNqHQgObKpFgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DwUZ11F/ymh0XKaxxYERc5YWzeX4WGMxN5lQwgS6HUwzxVFgSxH0oyLzhT7CcIe1UY68IhsMhM2suymIIBKS3g9hSbP4Q/8rM+qTZRZH43LXXhy5dOmPunL1nCbCaYf8E3uNcMkgrLsRfw9Z5RlGbT9LPYnBw6/TjKY09NtjoSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K3k/fIn1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ve1A2MhJ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K3k/fIn1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ve1A2MhJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C2087A0294;
	Tue, 14 Apr 2026 09:29:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 14 Apr 2026 09:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776173360; x=1776259760; bh=IO9zoKvXTI
	TiQMHWBFZIDtZlwL1b4y3FF5djGvRW3SU=; b=K3k/fIn1UpCkHWRsTTqZRYqP9x
	0atVyy6/wkKYImjgO/NfFdLW8u4XGIFTnOtuTjHpWhnB2iRZ8Gri0foGqFnq8j5z
	TDSJPM6DZPe3Vo+32F39eVQJb4hSaAbzEVs7+wK11lVmSQ8RA83sW189w77O4IkZ
	mXA+XCWqQrR9wgD92gNqttpj17wlbS1w1uYfVSciaBWBxwJdQ1jIRLFEc0a7uZKL
	FEVvqHHJV3wJzpX+XuXKMD6x8gPBz/ympgng+qM2stnfds3w89r3HAnm08V+ukPV
	YuZ0j6ImI4auUV9gP3FN8q6IqCXs6FtbJ4he3M5iz56aHmTsy8bXl2TJgSnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776173360; x=1776259760; bh=IO9zoKvXTITiQMHWBFZIDtZlwL1b4y3FF5d
	jGvRW3SU=; b=ve1A2MhJC8XOZXCPiDaeh0IVj8eOfSK9RhqgH82K89a967bU229
	hVSZz5ZQerz/HQ0d7fgNnGGjlv3AE5+Hn43fprM3EE7Nu8aEJA6z+bdl7d+moDMl
	Ag0IvTQk/xWGltoG9onrXgZHOf5uCWgg3Ko177CND0R7b8s90wdr4ujrDzKdzUqn
	6Zpr41264NsdW4tEQGSV2fiEzvJMDadqU21m+8krw0KXD4a/4q+wyfSR1I2CbbYJ
	jHUKgl0uE4BF0cFaXYrJsdjegX2+4jGCVXaBZja2sMHrRCiZt/4GsqIopRj1Atcy
	O30ffcEVDyHRFxfwyLzRsFJCRsE5uJLNU7A==
X-ME-Sender: <xms:MEHeaRPa_oBcwQk_7CaY8mGgP1iCqCG9qe9FQ__YE95eOwUIFYa40w>
    <xme:MEHeaWPwwWYpRjOzHf2gs2P8GEqAs8yOk1PDAgdo86BDvUMI0xWP-TQbdi3DfOfs-
    nt0qnDC9F0Tmrjoh79OGxX7M7lnbrb0947x-Ns1skk71jhhGNXI-w>
X-ME-Received: <xmr:MEHeaSgoFF_cFVZLMQR8O8nTcZ_NKRHIhR0l1OqGJp1MWlcdeJL1dtKGgejy_jbdGN6XTJvdJGgVkkBUSGFovm2Up7qmEpQZ4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MEHeaTt3ONv0ftaBW6mbC0bBqrSmS6N7JRzqhVBmpJ1yRAUNi9LZGw>
    <xmx:MEHeaYSaQm6rQrNU0hDIfmnkGG3LT0h9lofNUiqMJfEpQAGcY-ch8w>
    <xmx:MEHeaf3BKwXpC5z7ooqOiCspPaGrhG2Tu_yoUfmpBIbZ1pByHzR0xw>
    <xmx:MEHeaVtCATMxdbiVdpCM1rKTHIUzt775WA5vGAfG9WTR4sP6CjgWRg>
    <xmx:MEHeaVQtOrU3xX5PEvwsrw01HEf5-XPfAJZ4q66yGJjJb_M6TiSuToIS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 09:29:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: chris.torek@gmail.com,  git@vger.kernel.org,  gitgitgadget@gmail.com,
  peff@peff.net,  phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
In-Reply-To: <20260414072950.61240-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Tue, 14 Apr 2026 09:29:50 +0200")
References: <xmqqa4v6fpj6.fsf@gitster.g>
	<20260414072950.61240-1-haraldnordgren@gmail.com>
Date: Tue, 14 Apr 2026 06:29:18 -0700
Message-ID: <xmqqmrz5eklt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Sounds reasonable, but wouldn't it make more sense to call it "autostash
> from master". We should still be able to abort the merge and merge it to
> some other branch. I feel like the source is more relevant than the
> destination, no?

The new comment is for reminder, so "I made this while switching
from 'master' to this new 'topic'" theoretically has more reminding
value than "I made this while switching to this new 'topic'".  As I
outlined my workflow, I usually am on 'master' or 'next' when I end
up needing "co -m" option, so "I was on 'master' when I stashed
this" has a much weaker reminding value.  Just like a series of
"autostash" without any context comment irritated me, I'll see many
"autostash on master" that I cannot quite distinguish.

But that may be just me.
