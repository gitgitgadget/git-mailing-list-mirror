Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54E25525F
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189293; cv=none; b=GI8hiEUYOvlzUS2wdpcdbtUldehh3cyCGhTF+GhykzN/xZ+GoRScOyEEEQKa+ja1HoYrpBE0PHztz53QyqAGpYv3EcKx5NxGZTlB1rtODrKtm/hBUZW60FwwRacGAJ2wqFc6eBLlDBrEsX0TOIXmEGW4jMwHgQ7Ju/70Ho2cG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189293; c=relaxed/simple;
	bh=apEBU5XqgbzG28SzReNNi/4n/5GF2YbG1fg8zQmqUwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fWkW1qr9wKZoeBTfXYFyJaJF2JWXekrP3q+9Mvl3gBM4Z8jbVz+U+XINb3FDjDqaX59y5yfAD35yiB7lexYyGlnd3QbNU37mMdV2OtBQehJFmO76hvAN9hYOynEkWyPe7/rlLr2wT6K1wz7Z0KOrb41anI9I5jXosFryPh9I1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A2n64Ll6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CN0/YdCB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A2n64Ll6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CN0/YdCB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 53A01140018B;
	Thu, 14 Aug 2025 12:34:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 14 Aug 2025 12:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755189290;
	 x=1755275690; bh=Jdan6cjnNLnK/vU1aHSPbo2gfKTX56H5ii5+tUlMWok=; b=
	A2n64Ll6LfDE3P85KZ5xxDucnh0MqnXjdaIGT0pVDUpbEgfCdyiK92mfVZoJvzpm
	LpKwfAAbPcic5bDicBU0EcvQ6WiQ0bpImhUCPWFacmIUfgJyekYKXCVFSiqCvIga
	pl3QhETAEIFEiDc4FZ7ytxOUmCxyZNZT5dR39sjYw9Wpoq8cWEY0jmTjZkdQ2MZs
	6rQ9D+YmZrGc8ejjwcYtZQ9+yCJZugUoR8JCg0/TSZ9jBrL4lU3zPz3ntVrrkfUQ
	89VY8rtVsLitPQZu17IAi2ru4CmKYLD7jHNTSx6rXdwoePfsCAHserEjIf0clQOB
	IMx06fnnDRN5b+B0M7yijQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755189290; x=
	1755275690; bh=Jdan6cjnNLnK/vU1aHSPbo2gfKTX56H5ii5+tUlMWok=; b=C
	N0/YdCBnKNX113232kjNDeCukS0bcYu/Y77taAOVzXnD/84be+jobyWTzdvTTLAm
	uFuEfZEGL3Q5AzvTwxIWiZjvJTbCDI8uVg2fWv0g3mOLtviqqOjgeGROLaqyHNnr
	WDqtGRSZhwFJDllrbeLwn1M7N2x+qc9WCuy5DJjoqo9tMOyJu4mONoAjLzD9KihM
	Tt2qJcUVxl0giS4RXYkiV5MvvXKH0vMudvuby1DUYhoyBZcu0XGO726DDWFcqNOR
	8QgF2OiNBByLHfOYXPZPN95Y60Ek0vFDNCPfLW7PH455+Oh4Svj6F23omzE4rX/7
	Sc67dXcqMmduS7WiglNKA==
X-ME-Sender: <xms:KRCeaMvJNks3YFCR9FgCzXHDjdAHU8V9Blrh_M0_8nvcCqQ09Wk5Kw>
    <xme:KRCeaKMcOrfZMDOhBPPk8vu9aW-4ibqyxkvjEEZivhfsVMGw2WS0XSjDrxGq_Bp84
    F-HZ35DRUobZaFxXQ>
X-ME-Received: <xmr:KRCeaD7C7Ij_K-flst6zvSnQSiSwaKLtlpFsD6XnLAtXvJ-pJm9XKdY_wLhJhUfElEA-7M3wGbgqMc_G3wHFZFENCBLkIgmy6kHvEaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeduheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtth
    hopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdr
    rghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:KRCeaATfguZ7TLBZyPqLJl70sXSRe2Djvpmx1f85UECAnIUxMXqE3w>
    <xmx:KRCeaACRlMjAdPKaqXQ3SuKGH7e1bUG6DQCU_LDjJiQoj1PtCPtKwg>
    <xmx:KRCeaAGZy3gznheZc1EmBcO5rKZeGMVj2_wAszyWhvQooPEYwd3gpA>
    <xmx:KRCeaKB5wtNYt7UN-VqGtwNA_XPOZvIKd32cXVCkwmEl2Qplq7XikA>
    <xmx:KhCeaFqBzMwHHWx8F6cHfxflzEV8M8dR2uEf91QK2fXAFykmtYqS-OY_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 12:34:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Collin Funk <collin.funk1@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v3 0/6] Introduce more doc linting
In-Reply-To: <pull.1945.v3.git.1754945600.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Mon, 11 Aug 2025 20:53:14
	+0000")
References: <pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
	<pull.1945.v3.git.1754945600.gitgitgadget@gmail.com>
Date: Thu, 14 Aug 2025 09:34:47 -0700
Message-ID: <xmqqldnl50bc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Reviewing the documentation part of the last patches, it turns out that the
> majority of my comments are related to the latest documentation guidelines
> which are both easy to forget and almost trivial to automatically check.
>
> This series implements the automatic tests for basic doc rules. At the
> moment it conflicts with "[GSoC][PATCH v6 0/6] Add refs list subcommand" and
> possibly with "[PATCH v4 0/9] refs: fix migration of reflog entries"
>
> Changes since v1:
>
>  * fix a small typo
>
> Changes since v2:
>
>  * extend range of check files for multiple entries in definition list
>    entries
>  * extend checks for new synopsis styles

This round has been in 'seen', hasn't triggered any false positives.
Let's mark the topic for 'next'?
