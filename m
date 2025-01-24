Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2C15622E
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737732346; cv=none; b=gEHiSkDQ713YuKn9O8n9XKCmhwT2ByaTfk1P0L55r79TPkwgyM6xGy0J1dzOrv5IwTWFBL9pnZysnMIfvjQQBFjoqBsO7pvKijdjRKVeS4tN/Z0LQcFo67sdvHVzs/vgYl+9lASv43Ym2mOJjnAE/c7AHDjnZ4TM4Za8W59hUeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737732346; c=relaxed/simple;
	bh=M8v/tgk31zyFodNFKy+KNc+bobbHMwAnCW3ma58vpC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EQbVJ9ZYxvlWCzpF4OjaV5hu+z6lKxlk+RT/lRYxvsnOfumHvtMPoHyRRDqDfU2Xcgss3p7H9bXHPF9ZwuqeDVK+cGAWqXq49jTd1wcZir+zCezt9aSCzOjz4Ad7Y4zQimL5dpPij+mqQFWsIpvb9d1/RCreynhkdOBzuWBzz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FKbKPXmv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JkxOfige; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FKbKPXmv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JkxOfige"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D2512540219;
	Fri, 24 Jan 2025 10:25:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 24 Jan 2025 10:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737732342; x=1737818742; bh=WcRmmgZzHg
	AWyPUMtzlfPa+guEISmFcyAOehU32jMPg=; b=FKbKPXmvbtNnaKCn4NTJXu8IY/
	4wkRPR+/lujQYHUdIeS70BDQ8ejbhjuDl69agGf0UTrj+4v3fpGHpgEXXb9xZmqr
	h1xglJwL7s2uFgHqB2ixpOuCGQT0EysQIqXDZNygp5Y9lBcg0Ii9908DO2dCkkCe
	lpkk208Hk8vi19Z6ekslhrDWcDwPPXgfcgkvkJVTvDY8IDQ6gQ/zdU4G6b9cosgJ
	9aFUytsU4Pk/YL+zPIrg0NX7pvzNf9HVqkmFRXWYWS4Iabfg+0gWIaW5QSUuGqW7
	i4eOa1mjicVxBtIJ4KR2wIIX8Y+hXSge2yayNmRB/i1T3zCjQSuP2lLa6B8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737732342; x=1737818742; bh=WcRmmgZzHgAWyPUMtzlfPa+guEISmFcyAOe
	hU32jMPg=; b=JkxOfigeL3M/1zusriWUvaqeCuFqxAt5XrLr71l5iT6WbH4bDBv
	R1juq3xQ4yya5O/bXSjcW49B6jKO8IOnSzW+YobO5Aftv/AVZ0iHLNyXiCr+RH6M
	ZWW+80qoszdyR1kq4VeBXoELicz0S1J7do7Q5hjWpDP/zcW1+KhgXoKGgF8WFM9+
	c9jbW3NoOm6bsayTgrjNISxQo+4ypdV9lIvMd1qy4hEmTnuLBf5FtGylUsEK9ApK
	iGINFW/A4cA53mvz0Kd7/rCcrOmDbsn4LDarEOZm6+TqKZNDwsQO7R5mVjsW00E/
	dFy3jrQ4HEBZLSIeXG9+b9sOmniRfyTFJ2w==
X-ME-Sender: <xms:9bCTZw86G1Oz71Wlbn2ENx_8tQExFsEg5qHkhnaAaar0wkHCHwRD6Q>
    <xme:9bCTZ4tOi6iSIfkrqM7tnld-V0qXWl9X4EfHZCGQsXVtH5bmna7QWHuvF-rYJvcGc
    NYnNuVMlADFjTVKLw>
X-ME-Received: <xmr:9bCTZ2CrZdV6TQG5Gd6azrJi57os9miZx3--cNFUBXNJ71mBSedsJbckx0k-ul3HfHdtiD6zCDb53Lytc7ybR-rP3WEkicA19kIU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedggeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohhgr
    nhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9bCTZwekpbUvt3zfLwL1TL96bHdzBS4t-oQ-o6_lnF2BBCUdZcfRDw>
    <xmx:9bCTZ1PlnK021m7tzElAqCifYxhqsJqsMQZBb7x5aNlh2UveEJCpOQ>
    <xmx:9bCTZ6nSQMW5zHd3uJSmCeAKrdIxUnCyjUwbxh-lKwWyZdffu84T5g>
    <xmx:9bCTZ3sZR26ewUP9cuxFc-RaHayNwJr4w3PQRW9QYYHmVtVdNygTeQ>
    <xmx:9rCTZxBBl-piJRfCBHNDDD4k_I_UAS5CY4JzoCkrwPNd-kUmGSp9cAGJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 10:25:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  sandals@crustytoothpaste.net,
  Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] reftable: write correct max_update_index to header
In-Reply-To: <CAOLa=ZSisRwmUyLHAP0e=8U0QjfFbDfXwd2mJXKjVywcmM56Tg@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 23 Jan 2025 20:06:21 -0800")
References: <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
	<20250123135613.748916-1-karthik.188@gmail.com>
	<xmqqbjvxs8me.fsf@gitster.g>
	<CAOLa=ZSisRwmUyLHAP0e=8U0QjfFbDfXwd2mJXKjVywcmM56Tg@mail.gmail.com>
Date: Fri, 24 Jan 2025 07:25:40 -0800
Message-ID: <xmqqikq4qlmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Thanks Junio, I understand your reasoning here and it makes sense to me.
> Do you think it is worthwhile to also add something like this to our
> Documentation? I couldn't find anything there. I'll add a small patch to
> the bottom of this mail.

Perhaps.  I think referring people to "Notes from the maintainer"
may also work without duplicating information.

Thanks.

