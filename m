Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389C21C9F5
	for <git@vger.kernel.org>; Thu, 29 May 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532815; cv=none; b=NC1i7qpYhi7VbCIWmsObc0NvaYBt5hif76UpCPGmAKrdMLjASB/fK+jE+l226wFlHZUkLbxSG82infc3Idq5oUK08c0NFx04sGyCIxaCbK/XFCshxAUuM9G/Fw6O5HFFOKTnXQPKw4pYWSS1DPxE0p9QkMbkx+GO9ZvEke2+/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532815; c=relaxed/simple;
	bh=QZwa6yyNvyscu0MN/87bLBx7oIqDhXJEWV5vk41iUPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AVlUMriEhiKUaLILLgGJPZDtTysCHknSvYIWkpdmcr5fTmeZzSzR/tzIB2cUSVjh1wu6+u5hahSaUJDyfPAJgwitxYAc3yNqiE+Dbqrh/GqFgRYN3tDEpp7y3jgJ3Zg+EJ70vC8UoQIbY62zBVrsoCCjCxg9XHvxXp0sAqP5dew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ymiDKDY3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FsRixiFP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ymiDKDY3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FsRixiFP"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1EA33114018A;
	Thu, 29 May 2025 11:33:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 29 May 2025 11:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748532812; x=1748619212; bh=QZwa6yyNvy
	scu0MN/87bLBx7oIqDhXJEWV5vk41iUPU=; b=ymiDKDY34kydyDVYuXpMx7YJZd
	2WmBdKew26IjerDWQuSjTD5RX61sIUWXgWrFTgp86rBQ3dL+A0Y/twBbTBsI+Pk8
	h4FR3AJQQO4RkfVIK55Pf9UAGyKJGBnjBdbc/RkgmfJygKsUNY4j2I31T4FHyZ5l
	5ZI1/4XZfPZr2erO2yxzS4VlFjaIkzfFDENarXLagl8lK7CimGvr4GgXqTqnQlBK
	4uT27RtVRqfHe6iphShjFc8aPpX7oMn1dwacQuW81tRQrojlVz4AkqozJEeprLSi
	cINyKaaYlfpiUzDt9AU/2K9yQ9MFvGeaKsmMUWsQzZI1++GzlAcu3XqAac0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748532812; x=1748619212; bh=QZwa6yyNvyscu0MN/87bLBx7oIqDhXJEWV5
	vk41iUPU=; b=FsRixiFP6OXW+dzJ/AuTZYrtme3pfWxOBWBBpHYkqYiPlUVPY5y
	tFexWQ5Su2ApTnyyi6IBTcAi7HtonIkzGXVZ3A4XEuk6LN8US4piNOwe0EL+CHsc
	wLGG3WtroFcK/72tHAH2/Z5AphHnebH0zIi0sNIKZN4muM1Wn1lnr+KE6MC7zwme
	vfupF92c0z2AFSS65/APeC8PhKmAcyeXGbbF5Q1ujQ8v1JDluGBAGQKGqv6cV5E2
	2obpsuS/tqbB/tw6J9GLdJ7Mk6LuFomSvDCPNbZnO+GdfxFv+5CSVYYGseeAfIm5
	d7ZVsZuP8OpEUymBSyc9iTWae8wEjoWY/YQ==
X-ME-Sender: <xms:Sn44aPkVAnYpbvGaJu_qiKEHQ9_FwrIge6IZZPDGpmGMa_JvxQ8XCg>
    <xme:Sn44aC0tI5Y4uxXnrMdSskyKHXWbcbtrfJbKHGghz8VNoQ7nbwWskVrrWL4NVHukN
    2HBB5z02s1q08wXbw>
X-ME-Received: <xmr:Sn44aFoCbSqxPNTV_cl_MOl7TNneLFX0kEXE17CL_v6V_7MGD4_ANyh0hz-IN-25ycj5-Fjq5KQ298SV1gj9pshqilT8aihnCedj2v4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieehtdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    hedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:S344aHlIYnxKyPbjEWC4FzZZrF9P5U8h-DKgyC9le15cmJbNz-M5ZQ>
    <xmx:S344aN1VxTwZSFFgs-9qt7D41t0Hv8fOC5JNBI1FPB57HDXiWBj0Xw>
    <xmx:S344aGu5zHlnYfSgPcJTk-u_FATY7rOSpfFAtgcsEO3DuklCIvdW1A>
    <xmx:S344aBWmAvbRI4S113X3fDQ_yx7EPLuKFcZrGhLX_usB4wfJJWJHLQ>
    <xmx:TH44aK-u_cagq1h7aWMBlYeInLUAzS_G3BYrDesHMjPwZOmFnsVB_LB6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 11:33:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>,
  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v4 1/2] pack-bitmap: fix memory leak if load_bitmap()
 failed
In-Reply-To: <b6b3a83a22486d0c104c494d1950fdaa2f2a658c.1748140983.git.gitgitgadget@gmail.com>
	(Taylor Blau via GitGitGadget's message of "Sun, 25 May 2025 02:43:02
	+0000")
References: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
	<pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
	<b6b3a83a22486d0c104c494d1950fdaa2f2a658c.1748140983.git.gitgitgadget@gmail.com>
Date: Thu, 29 May 2025 08:33:29 -0700
Message-ID: <xmqqjz5zmnxy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Taylor Blau <me@ttaylorr.com>
>
> After going through the "failed" label, load_bitmap() will return -1,
> and its caller (either prepare_bitmap_walk() or prepare_bitmap_git())
> will then call free_bitmap_index().
> ...
> The solution is to remove the error handling code in load_bitmap(), because
> its caller will always call free_bitmap_index() in case of an error.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---

As this is Lidong relaying <aCOFqYdnPp1Lne4Y@nand.local> that Taylor
sent to the list, shouldn't Lidong's sign-off be after Taylor's?
