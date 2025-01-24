Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A051D88BF
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737743946; cv=none; b=ny+SAG3PEXUGl+OZGm1SvUPMr5T9XkCWCPxmuSirAARnY3Sg1IilO4VQsckmP0OjbHxXjqgtqAN8OJtfAYUg9D3P0otqxcXXdDHGeRRFAqYs8qYn5KfBj/rbGnNR23BXRaqK6cUd5ExSG7qCqAiniPnv+nRbwFqLNp4lnuO1bSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737743946; c=relaxed/simple;
	bh=MjM/k+kp44sbo8ZZkj63k9Twi6V9O8J18quo981nKgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H5x/kBUhBRXhhL6RogiTz0oHn6RObKEMLf0ymIp/ZkxJlsrmKWSXu5oBGir1AfG2Q24+nT57/Lcodh6/xoawK7JxHyGKg3Diok3GFF5Q+h+3iPjqL3FKP6pK6C2LQqT9emvLV7JAiubi0h5OeUMAHDdRCD8rI9GFteV35knkM1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j4x7yU0Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=piExR4yJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j4x7yU0Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="piExR4yJ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 55B6413802DA;
	Fri, 24 Jan 2025 13:39:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 24 Jan 2025 13:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737743943; x=1737830343; bh=kaAQQWFQlz
	JzxAoEg61Zx2IvzEmEaDa+zOSZBS0/XkA=; b=j4x7yU0Zzr9k+mN+FMf9ePGzfC
	LD9r7MhGdRy91aRx18JYLcuadnJO9JubqyoIEdxa3iANikXmJBycKPfrfWzXjSXn
	lCzfcAoTCjoK3qmmqxI2lCEb9Zps8X9jzbdeJIaa+sXCXys/Ur76r05jABE26Nv+
	Ez/wOHmoyn4uIb+RXyzR/7FO+fYn9AKJL2F+2H444Wxg1NFoYz1hK8xMJwZK6ZAz
	u+uqCDoLcoURJHi60BsIPn7WvFCjHukHy13WbZixJB7nbLNTfralN3xVDtapt0pB
	Np0m4DmzkOkiJk1SlAnQz6pEUJsgaKOSCkki/zyTsjqvQxtzqSLnGXR1X5QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737743943; x=1737830343; bh=kaAQQWFQlzJzxAoEg61Zx2IvzEmEaDa+zOS
	ZBS0/XkA=; b=piExR4yJ6jztZnNCNerzm5qKmNxfpaTjPsrJT+KkXjpZyOd79KA
	fpMkQfEv0jF4gI58+ZGhgcDNj2ayJtxVcFThzTZZ6At3klZavdwY5sqzj/XTrbkI
	cwFkhZjmhtUFhlU61IwqwU9Or4JFlgV5OkkJQ8IWjORvNS+x+k6FCyNCV211oyfh
	kdcXixiajSplXNEKHoMhjrw458iJllucEEyr1kc803WY5QgFr3x1F8z8VLuip288
	87JD+vDJfFrpmsdT9sBSHHbdc7/VJ/kGx3T0Bl0iroXLMTO1e30foaKiCLTWAty9
	KQfXY43Mmo4MPWjplliHd2qRYs+SQnY2u4w==
X-ME-Sender: <xms:Rt6TZ_MzCR1IH1oAVqQJZHWl7W0H2DvMYOkAEqsvzKq8FiPb4pQtoQ>
    <xme:Rt6TZ5-MkYdozAHnw9wuUsf9XkQbB80Wlc6H1evyPPHkzFRDNlSnM5kRE0M_5-OJm
    iWKJG4W2IWNOTTN0A>
X-ME-Received: <xmr:Rt6TZ-QRRPnnPszKm9KVyIwjAvwSR04tf8gK1k60r5X0bLgQf-BwoEe-Ny93dC21D24Ipee_L1k5pvYWKwcOvkq3YPYcS9P2sLnX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedghedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:Rt6TZzviIcXHRYbOcKvpSefBotcWKxDhasdG9nEpCFkGhh8g-C9KDQ>
    <xmx:Rt6TZ3cZVlXH5XAnwNYgyPETNvIzj-fRUhnMvN63M4-uKceb5swS6g>
    <xmx:Rt6TZ_1dJN2Jx2aXCkDRYI0YANjBYw56j8uMwFOdtaWDKk6NEp39Sw>
    <xmx:Rt6TZz_kxlKYXdCUrNd0DkR3Arc33xASDhUucBsIbRHiJAoAszxjbA>
    <xmx:R96TZ_3pMSQWxAG5GcpLlhQYNG18aFBdADjmzuW9_eJhze5ihSXvzuQg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 13:39:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  rsbecker@nexbridge.com,
  sunshine@sunshineco.com
Subject: Re: [PATCH v3 0/6][Outreachy] Introduce os-version Capability with
 Configurable Options
In-Reply-To: <20250124122217.250925-1-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Fri, 24 Jan 2025 17:51:35 +0530")
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250124122217.250925-1-usmanakinyemi202@gmail.com>
Date: Fri, 24 Jan 2025 10:39:00 -0800
Message-ID: <xmqqed0sxdiz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> For debugging, statistical analysis, and security purposes, it can
> be valuable for Git servers to know the operating system the clients
> are using.

OK.  I think the reorganization done in this round makes it much
easier to see what is going on in each step.  Very well done.

The only remaining issue from my point of view is if we really want
this as a separate and new knob with capability, or if we would be
better off to carry this kind of extra piece of information by
enhancing existing "agent" capability.  Given what Web Browsers do
in their UA strings, it does feel cumbersome for analitics tools to
pay attention to two separate input sources (os-version and agent).

Has somebody brought up any downsides of cramming the OS information
to the existing agent thing?  I have not thought of any possible
downsides since I made this suggestion in a previous review of this
topic, but I may be missing something obvious, so...

Thanks.
