Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A661CAA7A
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736876804; cv=none; b=dNRBDZvsfZcdwDwQKyJWaYoN/AjFoF5QdMoIDoM0oyjxzErs3700JhvE3HT913QWsQ7VU2ppLDvm4pWS3+ShiUaKItfYMiRauZ10WXrA7M8N6FNJqJ2hXNw+ZWRMQ7Vm07wLorhBFhbWyQe/EUobDTvs8QbUT7FjTYslEp1jWmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736876804; c=relaxed/simple;
	bh=x4tmbDhKxQXAiCoY6ff07byRWsCmUBqwPlcCy1zCqLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uzlCxzY5GB+13/ZenncYlk4MxgC4pomSBSwkcFAwT7mjXsifWev5bVO1eTSFUGLXdXqzqCp9tdKh/lkbKSzRlsukRgu5ZleUMBZ87auMz8Z8TiT2Y6pWw57/pB+5omzpxWWfB4FEm1SzrRE5tZQDH1+ezhpPN1ZKG1YgoVKge8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BmpuoJZm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vpYOFQKW; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BmpuoJZm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vpYOFQKW"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6962C2540140;
	Tue, 14 Jan 2025 12:46:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 14 Jan 2025 12:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736876801; x=1736963201; bh=5yTaPooVAM
	6wrftk3z5aj1w4Ap2ngG9txNzAXwOL14Y=; b=BmpuoJZmYgwyQssM41uSUk4bpL
	RfoVAU2O8SPUByTNGZq54GdfIWO30GxX5nu6VwyVD5gUQgX+QbHh3OSWOWLbphmb
	xRilpfSY7BW6F+YWUznAjCR5HqOwPZDOJSqpbTbwjnW9JUX80RzM9hk8Ei+olIGz
	3rzN0iWy4knH7AuOlFNMwv/wM/vaekoM0lu0LZT4hH4LbYsolWbtzZd/oa/Yuuqk
	CRCaCaVUoO5xXW1czJzMPX36507ayzwah2T9ogXBBtBCVJ8dhvn6WV/N/o6yacbF
	F3WJKmvZzKiNj2QltKn5NW4TWMWkiI9e1lzjS26lHmhg2NrJbQLZLuww+uqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736876801; x=1736963201; bh=5yTaPooVAM6wrftk3z5aj1w4Ap2ngG9txNz
	AXwOL14Y=; b=vpYOFQKWs8ugMYLeLlRr8/emqJj8abdZq7CyHauWucf5LRIkcad
	YXTz3xC1/Rw7ED9xe4o5vS7u5GeKgN7NX5CDWWBLPEQETPp+xxfudrz6iM1Pd795
	7VHrzmgC5uz+wksvx+601p0ZOZSeGERhtenb1+Hlc9E29g7GhNuVFR/fFQEY1p7q
	TwMK0dHYNctOlFx35lV1wRshPUf9K3lPZaqsiQ6XcnooUVZDXMrKXt4xYLPeG0rx
	fn1UturiYcCInbMXah5L6AZH1rlDV6k/zVCuow0YZaTwa0WGbX2MiL/rFXLtKewZ
	7twrZwG2y8d3z0AJ8N3MYT6TjrfuGVOdgjw==
X-ME-Sender: <xms:AKOGZ6kd3mOdSrygflgXR__HnZoeu1snngTAEUhM4hXGmIfKONYBlQ>
    <xme:AKOGZx2T-kHg7Z6nhG8QhWI5hr1wIVAmvVIZaYrtHaBLLtqz8qtjQqLMsxCcwRq2L
    OvBnsbLNkd9yw4ExQ>
X-ME-Received: <xmr:AKOGZ4oJ-fOmmTGOtmpg7ULi0j3-gdSvur70Yv7eN8XPru16YUr86Mmmye0BRB7PWewUXHl010fFRIr7Oi3Z8Uqt3On43tz6pyti>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfi
    grrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhho
    rhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:AaOGZ-l3tluXqbSuUiIuGiqQdyUVh8Rt4Zdurhqv_VK6yw2BtnYDCQ>
    <xmx:AaOGZ40ofNFyuCFL_nSbPvjWPvGlBas5ZOl2dlZZfJrZwWgDj1Z_-w>
    <xmx:AaOGZ1uOLuf6e9Db90Sv7pIW4UWQ7dG-yubqZmjxgicUzdcB1HrNVA>
    <xmx:AaOGZ0XwOdtzaYbMq6srzhSChFrm4LRqv4aOLTQzC2RCKknoAVivBw>
    <xmx:AaOGZyo_opPdYZ8AvVV5D1k_uHKK7zk9R7ejSawwZSSGvjlooLhmgC46>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 12:46:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Evan Martin <evan.martin@gmail.com>,  Eli Schwartz
 <eschwartz@gentoo.org>,  M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2 00/11] meson: a couple of additions
In-Reply-To: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
	(Patrick Steinhardt's message of "Tue, 14 Jan 2025 12:56:10 +0100")
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
	<20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
Date: Tue, 14 Jan 2025 09:46:39 -0800
Message-ID: <xmqqplkp47b4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>      -		VN=$(git -C "$SOURCE_DIR" describe --match "v[0-9]*" HEAD 2>/dev/null) &&
>     -+		VN=$(git -C "$SOURCE_DIR" describe --match --dirty "v[0-9]*" 2>/dev/null) &&
>     ++		VN=$(git -C "$SOURCE_DIR" describe --dirty --match="v[0-9]*" 2>/dev/null) &&

Ahh, you only said "found the issue" and it was building suspense
;-)

It turns out that I wasn't affected while testing because my build
infrastructure around "make" computes the version string by itself
independently from what "make/GIT-VERSION-GEN" does, and stuffs it
in the 'version' file, before running "make install".  And that is
why I didn't notice the breakage before Ramsay reported X-<.

This fix looks obviously good.

Thanks.
