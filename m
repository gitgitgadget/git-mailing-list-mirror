Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DE37E315
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049947; cv=none; b=j+MSkDv/h3s5U9xk+8V0ckXF3Wv+v6LxsqHIYJ3NbnJauBpIjvC+QKykoFw3rSKe2Oh6/ZJue7miHO06Dx4S1dwr1B9+FXauWz1LzbPY/YAoNcDFsjFvN0uCKvCsUBdm3FA5GL/XsbGUlDtrmd3XcOXNBs/qQzk2CDqL4dWOPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049947; c=relaxed/simple;
	bh=ZIeAeLDHD/8fsgAwOfgA8XktYHMGOy5qrJ9pngbylyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bFpNFnVryzTNrDoYieVL+HHbEIxzP6ud1nnkX3a9Er70+ZptrrfLYwcHCht0thfF7g6p/DAiYNXV83ggfK3wAzd92eneuO38rWPNHupLkVjABjrafX08MOxYvmeNYwPrQdP8Uaq5aXAcHMNi7wV/pEj3Oau2HhSFIADL2CRc6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J5gWHWVj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f4/2EQub; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J5gWHWVj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f4/2EQub"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E11E37A007A;
	Mon,  2 Feb 2026 11:32:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Feb 2026 11:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770049943; x=1770136343; bh=2Dp1LSjd9D
	FJwSJ7ezYhU9HTUK+mkNRz9hlzG0ZtuZs=; b=J5gWHWVj7ColftCz/9Gwn5PDHs
	eGeWHDZ3tFA1U85uNiy6+/A7LrH/twhsO+bf6rMqwyGX22bS/GkGn/mUI4ZrwD2a
	FAxwxSo77bhhPanY7E3DP40K0PgriAYiZYnHvUqjXUJ3wxS2aeyg44QuONWOQ/2C
	6m4H/vcOYaQa3sS25rL9Ke22IRIzMfoHtASi6pfD+lUyMMYoIxaD2E5u4B0vR7wE
	3M8S+da0iVjxW9MazXGBYOqfXbYLapQrt4b/BxN+YSe2m/tqTPEKP4UeQW9STn97
	8tQAnnGSvOedi3HQpSGntN2KxBIjlRHQobAmYdIxROewz64byqmhiH3/KBKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770049943; x=1770136343; bh=2Dp1LSjd9DFJwSJ7ezYhU9HTUK+mkNRz9hl
	zG0ZtuZs=; b=f4/2EQubrPBBoKprY+8yh1wY3FRimo06GEKRenXR58keMxWBzmy
	uv6vhykm039SZQoH0GHhTAku9RfKe91fxdyt3DFEjT9bnUPLYkZg/fdRTBAHkdz9
	WTGcbnwNIGy3t8Dlcl7jjSnWpvhXVXn2Zr1tygbPTGgYyqerUPXfZkOVnwmwWtRx
	SaZ1K9tUeN1UA6166pGxyl3itHKsMaoAjsLnduX4Q5/ZUzarFfQT4SrWlsVdTLw+
	dHjKSkJ5rTF7k3Mxjo7TSQs4KtS/ZviWO5n/eLlv8SjV38Pcfw0O1uati1Gewfnj
	l9hmn8OEk352BHjI+zRSr5b4H4irG0bIEDg==
X-ME-Sender: <xms:l9GAaQ8VhIj31fEh26UDW0dLy8nNAHMxf1sM9XXle6HAnCwbZH6XLQ>
    <xme:l9GAaVRYyK6VEfKEfFHTJ7fUx0PuVi5_X4YZ4ueQobdu0kLtNYH588-qvKPuKKhJb
    Hrwok6yf33lGrYuaZvMyt88jWETHwgRHtM4boNrKrmBXTJ-8cjE6g>
X-ME-Received: <xmr:l9GAaadMvyPIVSHQcR1l1WRjOQ50qwayYnGFbac6C2BYhLf0qgXMMtLZjWpLiCmq56__HnsNM5q9sFtpLr1lE13ZHxJ2yOaYCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsugesrghprggthhgvrdhorhhgpdhrtg
    hpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtvggrug
    hmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:l9GAaXSuusMMNxnnLSNxNb0eMecuh1AlhoRqJ8TuF5Urb3WIhQWmYA>
    <xmx:l9GAaWJXRtbzfZmef73RoP5k4T5_w0lOi9JssXolk9L2Tn4ijuA7EQ>
    <xmx:l9GAaUK4z9EvwsCTQvgZ-SR9ReIVBbYhqFW-x92xXTWoimwsG-78cQ>
    <xmx:l9GAaRgplaHQZINV_jruKQokid2HnrIDF8hdNsC6V6Ksem8TEEgr9A>
    <xmx:l9GAad3hgQ2r4BZmz_q68W6q4vkzuGSdpQEInhoMpkQ2szyPLapVgcS6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 11:32:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Darroch <chrisd@apache.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,  git@vger.kernel.org,  Jeff
 King <peff@peff.net>,  Emily Shaffer <emilyshaffer@google.com>,  Patrick
 Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v8 06/12] hook: allow separate std[out|err] streams
In-Reply-To: <9a4d95c1-61d9-5192-2a41-d8b953088452@apache.org> (Chris
	Darroch's message of "Sun, 1 Feb 2026 19:17:09 -0800")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20260128213927.3026875-1-adrian.ratiu@collabora.com>
	<20260128213927.3026875-7-adrian.ratiu@collabora.com>
	<9a4d95c1-61d9-5192-2a41-d8b953088452@apache.org>
Date: Mon, 02 Feb 2026 08:32:21 -0800
Message-ID: <xmqqqzr314yy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris Darroch <chrisd@apache.org> writes:

>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ...
>    Thank you for all your work on this series!  FWIW, I can confirm
> that the Git LFS shell test suite continues to pass with your full v8
> patch series applied.
>
> Chris.

Thanks, both.
