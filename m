Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42D261B9A
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480302; cv=none; b=VzEGFpy25o0c4cX94EezLvKU6FbN1BX+f85MD5xTpIb5FztrBtpFaBQ8jPO3Mh0Q/lXl5RC0zwnGUVvFa/9iU54bcV7M8bQc9fdS0hRmcJbpWg5lUJM7RR9bQYkIiH+g1Fwg0Vr8ycWsz3JuhFt80UEvfoKP8kFQgXptER0BpcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480302; c=relaxed/simple;
	bh=XEtJ4rHQecQPFc1JRoA5cPo2/La6XkjY8gM1upHm808=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z1Pmc5xW+5pAO4tgk/lUDjWwC2Jj4j6/uBZpz51T8Kylqy2l6McmL6cVy4ZXRLYDa9RtEHiSIdevAgJW5r3tTY/F6lw7wdixstM21JYiMM6v69xbkv0qKdC0EKjYucYgjeaVnY3dIQfo5VSxcmDKtUCsMOW5tl0KVZhEU29jxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MKUkSqDo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QS/gyLsI; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MKUkSqDo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QS/gyLsI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E51897A0101;
	Fri, 29 Aug 2025 11:11:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 29 Aug 2025 11:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756480298; x=1756566698; bh=//+TEorUQm
	v8RI/dNIUEhLCtuA7zRLfBLdiZPniuLi4=; b=MKUkSqDojXThmULdSv5wf5ubuZ
	rTWxohx9LkYsTlZXA2S8r7y3c1bfDwWowrapn9ecj6d51p3kFnQ6FlVm2b/G3efH
	wSGUi4wg2Wu4e+sQ9r6x1JwRETl+SUvQAB2xSgi7VMWz9M2zZq9xIZynWbgqOIcN
	vyifIhTRvaR53TLaAar/56HUS0zZKJH4YbqmIf1Wp0glWyAjPTg3Yu5oazj5InvG
	GsCqthxC80UOwtIVuwrvd6j9rxLjAXoO31Ep6yl1OmM/gAfUZKkmHcAyNZmBtsP9
	f7ksEOnwGUJEOBhuAqPfknZfUrE14JyIGbWaxFf56Ny/q7VrNYq9yIEh3HTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756480298; x=1756566698; bh=//+TEorUQmv8RI/dNIUEhLCtuA7zRLfBLdi
	ZPniuLi4=; b=QS/gyLsIThkVWdlNn5nJ25vPe1r1/RRNdTofVxx3NSA0CtoB+J9
	5s9soF81VjWvE6JnQvwkph6M0nxewfZ0ZsO8VXCT1dnjg9QWVlvvYHnR6fBq+xlf
	x7D7xcXBdpev4UIvtiHtm47o8N3D4UmUuZD0OC+pMpQS5W6PClGNotxZ1doEQBdw
	Zbe+fUGGv1O0NTahOkHSw55SoLNTguiVWwLLtznf9qSbNHL7I0d6tdEM5a7QjDeR
	cs+8sXopUOjT9rtUXMxMwEbwpNRIdQL8rcEpa8Xg1g2WKELa+MSnCbMyVdyewJhT
	1eB7ER3EEsU3p4tQBouvqYJbybwwHzHhG9Q==
X-ME-Sender: <xms:KsOxaNZ3pBcjZY_COH2dBS85zsF69ubAo_r4O2VLDNVosFJHxvxZrg>
    <xme:KsOxaHpSdxapq2_UAVaU1HBOtnTArannt_kJyzgteZYX8C2Q-cVQ7kxm78yRtHA0Z
    Cj8Zz8GOk5HdjtIww>
X-ME-Received: <xmr:KsOxaJY9KoL3b0pkZE3GKroKHx3JJl-mNlFTJO0Y2ZJyR-93N5_9XKH3yHZiZqKzQgJperC5VFSD6uElgYN-xtH2Ka22KgguWlKCq5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrmhihsehf
    rhhiphhpvghrhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KsOxaHR4-qPsq2I2kNd5FeQKUBdDyPulROzVfLARDb-zUF0HcbNeGA>
    <xmx:KsOxaI4CX4ceB4NndPnF6osW4p7B69T5OFWd6f2Fz5G7_eCnqyPr_g>
    <xmx:KsOxaEy0euz8okUxf76Jstkt7Q45hX0-8XJh_CjygsCLcCCb9Vw5vw>
    <xmx:KsOxaPTMeW_kqi9cMgnQO_XfwWJiDVBSpaCDo2jBsx8yN5QSBXOJMw>
    <xmx:KsOxaI5YtL5atRttClYDYWb-qCdpuSKnEttOqXWCjOt7uXahjkiNiGs_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 11:11:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ron Yorston <rmy@frippery.org>
Cc: git@vger.kernel.org
Subject: Re: git whatchanged breakage
In-Reply-To: <68b14aad.X1BRkbvYn8oZ8Dhp%rmy@frippery.org> (Ron Yorston's
	message of "Fri, 29 Aug 2025 07:37:33 +0100")
References: <68b14aad.X1BRkbvYn8oZ8Dhp%rmy@frippery.org>
Date: Fri, 29 Aug 2025 08:11:36 -0700
Message-ID: <xmqqwm6mp3h3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ron Yorston <rmy@frippery.org> writes:

> I use 'git-restore-mtime' from git-tools[1].  The latest release of
> git broke this.
>
> What happened to politely deprecating things before breaking them?


Perhaps the wording was not explicit enough before the recent
update, but I thought it has been in the deprecated state for a long
time, at least since Aug 2013.

