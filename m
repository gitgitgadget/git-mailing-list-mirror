Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC5A2C027A
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399547; cv=none; b=RBoFRItY6/ZWjjGA8aWjJWBYUnHj5wAFFRijoftxCrKSCwYMd37C/iq4/S8/LjRpsKDuXN5W3qJBR3RR9+YJLjk3Q7zTJ12U/PMO2gonjgpPkFIy5+tWf2DN8CP4anKEWIy/63RMDt4BEJ5LszFZGaVtiZ5a9mtp9mTvob3011Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399547; c=relaxed/simple;
	bh=WnDhuEW7NEvjafN3XlPb2Q5jxC3t93SXwgevr8SBdJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WS7i6wgVhJQirZMCiZUJLANHB3e4OEG61wpZSRSwAxEjQ4c4KZ4DUW2+8Ky3wFdwPceQx6pBAM60j50PgVr9lugCpGKUKXIZqazkRrW8EGz9K8KD8V8fEs4EhspHh7Ny004JSFaRbdzmYjjinrqF2OBZuaDRfceXAcGt2PT6hiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VyKGGzlD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vbj0Ju0t; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VyKGGzlD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vbj0Ju0t"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 137411D00047;
	Wed, 14 Jan 2026 09:05:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 14 Jan 2026 09:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768399544;
	 x=1768485944; bh=06ih5+FokaF0nxbi3l/bqpHwfYOOHYT0AI3EqvZIwsA=; b=
	VyKGGzlDk8CoCh+TCO06p2kK1NZTxrjnBTEGOGO7B9AnwYeiTVEBGswmebHpQeWe
	r4BUeV1fGYBnF7p94QvE2iAUg3LwYY4DlvN1cuV3ync6wSaD+aLl0/wpTLZkubLi
	Fla0Z1QxsuDP6NjxQK8/zX6UcBswLbtes70pCa2W3KtQO3Ju57CowBadCc/3mCTx
	wlEPsD/ccA1waE9gj7j76ydHGYSyA1tFoi1+J2UmlfF/56iU6gfRuwtuVJZ6gH+Q
	IzQzwG+qmp7VMqOci/auN7nO02qVgtBQWhwNR93tvKmko7ZmUJ4NJZ8Wqg3jKh+l
	lYqbk2zpc2/8F7ptZZWvYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768399544; x=
	1768485944; bh=06ih5+FokaF0nxbi3l/bqpHwfYOOHYT0AI3EqvZIwsA=; b=v
	bj0Ju0t9ni7qxfsTWyWgzrvDbND1QpjJBLs9sHp/45TRWuvcNjlCRsrZD78qlCZh
	lVq0J7k1mnH7EHQ9RQ9SI3d4K0Txf8hxYVpS03jcm2fitvg7agUgr4tPmHaD+kw/
	ZA4SJqwuhv/0KCLw1/sUOmu8qRBpk/JDgztZq6oWUVN55dbO0TrJSOUBNqzofFgC
	AE0cZcf2ZrgB0+pWUzTW8uNeu556y3J3WXBJozuU5KFZGuUsGHQ9DGb3LFD9jG9m
	3n8o/9uV4QysB5RXYKujDi7Vq+LHf+MDI9TjBrutXVm0hMfrcWcnw72iuvwn4glm
	ykzz3I+ow7De+htZaE8Pw==
X-ME-Sender: <xms:uKJnaSt3v2VTjEAHk8jmO8axfXht_Xh2L0gVIXcU9UFtt0KkCWAX-Q>
    <xme:uKJnaQzPJ2GZ0CJ_5n46JB6DX6iyA5gDysLKjHsDnusYreqz65LpeKa6Ohs-wbVGB
    x6Oi1h4bimO25RfRRceuQzKc57dh4My7VZrzIrAleUvHfTYMtLMOg>
X-ME-Received: <xmr:uKJnaVC_fc-pQ6vE5uX3affo9gXtRi6zuQZo75G9l4s331amTPJr3D_2ebTedyQifw3OoxF6MqgkdIMsFowIAmpn_bCKVQIdRoH2U-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeffeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehnrghsshgvrhdrghhrrghinhgrfihisehoshhsrdhquhgrlhgtohhm
    mhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uKJnaedzXJ_-Z-1BwmPXApoCnbQ6nndxSbSFNln_UaQpn7i-7gAL3w>
    <xmx:uKJnaflZeyNmcGrv_9FkZA5PenQzRRpGzyvESnAcFS5qzZUBMVGcZA>
    <xmx:uKJnaVEJtcw9XrlC1CoKProMHbDPgKZ6fBVVz6tUoETE4WG37fgRcw>
    <xmx:uKJnaX6ZY48pjJKD9b-ku4jHOxcDkQBMIhaZwG9ySVjBz64t-hUVtQ>
    <xmx:uKJnaexOmkrsf5_H5sO7bCx6AhthPtn0VjRDlRFPgJJEkT8XZsmnc5-t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 09:05:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jacob Keller
 <jacob.keller@gmail.com>
Subject: Re: [PATCH] Fetch missing submodule objects from default remote
In-Reply-To: <7FB6BFD0-4C54-4924-851E-D4B5C574D7FC@gmail.com> (Ben Knoble's
	message of "Tue, 13 Jan 2026 16:51:37 -0500")
References: <20260112213612.2761854-1-nasser.grainawi@oss.qualcomm.com>
	<7FB6BFD0-4C54-4924-851E-D4B5C574D7FC@gmail.com>
Date: Wed, 14 Jan 2026 06:05:42 -0800
Message-ID: <xmqqqzrsguh5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 12 janv. 2026 à 16:36, Nasser Grainawi <nasser.grainawi@oss.qualcomm.com> a écrit :
>> 
>> ﻿When be76c2128234d94b47f7087152ee55d08bb65d88 added support for fetching
>> a missing submodule object by id, it
>
> Convention is to refer to published commits using the
> “reference” format supported by git log and git show :)

;-)

Other two conventions violated that you may want to point out are
(1) the commit title lacks the <area>: prefix and upcases the first
word, (2) we do not use // to introduce a comment line.

Thanks.
