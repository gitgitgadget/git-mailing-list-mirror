Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54E1FC7F3
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735931791; cv=none; b=CGAMhldDrNBtd3TbTg/ujFM5WRd7Yh8ngJBwFXqD7kvQDNTb+h/wSWsC3oFspol2wzRsz1YDGeXUmMq01rDd8LWQZvRYiFXS4oLTKZ7lzj3Ub2+DVDXGkcSR3jYnpQYcplYjRfVVPJVgPP9JdgbXsDO3uCv+WxFCyIPObtAi+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735931791; c=relaxed/simple;
	bh=opqJrcD6gKe9Zh4a08oTPLbga7RFZ5Jv6GHQRIpLw4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DwgVXJje4FzG+TgMfwJ+p2NQkScxdyAz4wCa7DMUzk+SRICRQr+7kxNorotmYI7iTp6N2efpqF22KdFDSx0MOYvVOal3n8H6Ufugr3MM9Jyhvqpz6DzfwUQVU2sAM0i+i/02ZWtXMN2Q3LtntqRlUvaFsYyc1pcwGbsJBOeFBRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mw2N32Fg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BqUPaCe8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mw2N32Fg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BqUPaCe8"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5EDB71140222;
	Fri,  3 Jan 2025 14:16:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 03 Jan 2025 14:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735931788; x=1736018188; bh=UwOsJxmANn
	5/GV93VZ+asGqmSpPy4JC6KrFjMweA3EA=; b=mw2N32FgGMksKHuw8oY7xOdveM
	eHybG1fbcUNJ8r5FXrfhrh52yQYqAwBQ2ZJpxBqOet0XAKRkRzI9DnkfvOD3Uxl8
	HfwfUxvJUUtpFmTz6XaEf6FpWQtRPZAan2ywpYwuFkefk1IuIflMqbKdFoS7wVun
	H4jwnFb8vOmeXqJCIJk8Cfaj80V8kLxHuaP2EmKJyQ0VDHINKfPVOD4chbHfRKd4
	kO1mjzeztSKb1NRkdaVlHyI6zPf0PeHTjlwBkZG7ZRsJsrRWbQGxvUhhu+tZOL2p
	hqvl3YUyPcQv8ycY0PEuJThheXp87Lm9qmcfihFhpqEcLYX+IINYFUXwo7og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735931788; x=1736018188; bh=UwOsJxmANn5/GV93VZ+asGqmSpPy4JC6KrF
	jMweA3EA=; b=BqUPaCe8cFSKoMbepKKpYEk21I2C5b+QVnfGiHVF/GabP/NXuxH
	PQDpWJ/uIETZwm74Up/qDHBcsnh5vnzTFs/JmHusqHqev0037VxHJsgaWw/NWelm
	B512pLm7JIyP5cDlFXd2eZK4da0d2xGhmCrZdvHul4D1Pexc1A3ljunVSex/RrKx
	kmYUJFZt5xZShr8Rerny6s8M5Q5+ZR7jPYDqSnZLNy8Nfnrcj/UfR78ZawmfV6AA
	O6URXpEJi7pvKa7qMznM+gnH05iPvChPm/3lU2BRC4O8FkU6yV62GsdZAdbwploC
	UAjX4FwzIpPTPOlfzN0BMYaqtGSkrRjRUXA==
X-ME-Sender: <xms:jDd4Z8hog6cla622ePrwjICdQ54xa5HXsc8IrnTauWoRWQs8JJkiSA>
    <xme:jDd4Z1BpbbPperC4la9dHX-nFc2BlF1VtqRh9k7_jL8V4fGK8_55F00iRHLly44eo
    b9y9f04bwM1LKwP0Q>
X-ME-Received: <xmr:jDd4Z0EPVB8JZhkriMbNKL9mZSKswNKPwbo__abwF5Fs_W-XgCufw3G6C7NWxytI80eWDUq7tZD9uYj7TuLqLPws-OgN4KuB8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jDd4Z9RQTo_QFWP0C5H52bcBUxtDOj7g_cXTq0bWJ7_0KNxUBPgi1w>
    <xmx:jDd4Z5ymqvjUWJZw5vzWweeKNdMJxGrvtDrGs_yiXLhPQ1nG_t_BWQ>
    <xmx:jDd4Z760D5OU-6P2Sens6T6CFQjzmNNLGaL-3jzpzvGOaFPElIxsWQ>
    <xmx:jDd4Z2w62I-TcFmzFUPL6q7iUIuFbx1-kjs5P1UTfasCssjEcZvXpA>
    <xmx:jDd4Zx-0Zr3HO7jisP35qB7MqPljRVI4eMapsZiVfuZxE-BbZ4tNjIjM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 14:16:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/10] github: convert all Linux jobs to be containerized
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-4-a9bb95dff833@pks.im> (Patrick
	Steinhardt's message of "Fri, 03 Jan 2025 15:46:41 +0100")
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
	<20250103-b4-pks-ci-fixes-v1-4-a9bb95dff833@pks.im>
Date: Fri, 03 Jan 2025 11:16:26 -0800
Message-ID: <xmqqwmfbpv1x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> ... The containerized
> jobs shouldn't cause a significant slowdown, either, so they do not have
> any significant upside to the best of my knowlegde.

"shouldn't" is a somewhat hand-wavy word.

"knowlegde" -> "knowledge".

Are there security implications for us to worry about?  How tightly
are these container images controlled, relative to the way forges
prepare their selected environments?

Thanks.
