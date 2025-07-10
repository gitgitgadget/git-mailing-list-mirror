Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543248633F
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187525; cv=none; b=eTJPL8zdQPoTtSV5CNDIls9+tD6eiGrq5mbYYp1IyHFW6Phdf46mOeeU22HeIv/yEGihvFnQZoWLClwu5DYYJER5CGj3xRkCKfdTl99BngLn6Gu/sr4hs0ptyJhsRUX/Wm2FoFx7O7Mt8yg4RY5zCckzZLN2aFPsvot3z4w7n2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187525; c=relaxed/simple;
	bh=W6B4AV69VnUvI8RwOzDai187AWsj18y0a/ZO2W+g7PA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sXiUN0rc/aFzxn3HyGl9mk87fqqzg5IZl+FwOTnPEQM5e8afpuyYQd0x5TLG1kh9gYDDnAVzbQX29k0OthU5IWSlAcZ8IzqFfMyXPgDobNPk+S17HFmmk4Nd1Tn+Eo5BmYev3FCur/UBnZOBa5hQ3nrNb+qqTWhXcMVwKxdPSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mcMXyWa+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ba6RiK0d; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mcMXyWa+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ba6RiK0d"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A9077A0135;
	Thu, 10 Jul 2025 18:45:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 10 Jul 2025 18:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752187521; x=1752273921; bh=Je7Cru2m+m
	6gS51RYqxffa91qwgerGoSZgJzpw0wYMk=; b=mcMXyWa+lxgyeY/5qZPhETkKYe
	G0yyhfk7slYQjzmcP/KTIzYgnRlztEmcpayQ/yoP3qgk7PpVERPB2kqQlJ8dFQSj
	7zk9OzSXM0ylU6NnUvOzY5keTkemFmDfbui5bsSp7p120tjKYifA41X30SS8wYJD
	YpWhVrPWS1elljpkyyNZs4hWvNc5DdBD8tgp1lqfPYi4GtQ5m+MT1T8KygQu4oEo
	xaPuXwk80Ees8dFTAPdTCg3JIwA5M7QFMyKJq5AX0hu9m7sjfN0dQd5rGqenkHqX
	XmXWmmcJdlnIs3VUepbByZt1sic0WXiw84InuOwp0qIHifRnQyadgykE8BKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752187521; x=1752273921; bh=Je7Cru2m+m6gS51RYqxffa91qwgerGoSZgJ
	zpw0wYMk=; b=ba6RiK0dMI0J9P+X2B0N4OmBm4BbSgGBw/xxJ9B6mmt/3ChS8yR
	CmCx/Q2R46a6st1BGw6S5edCpxXZN+LHdGhkbCssSjMmvXLUfdnqpnxrRv89qVkM
	lyTI0YpvQPRWgj6oxRSlL0ocmjZ/+rXYSQh1kKHTBKQ+rfCN0na07TDW8L8XomOF
	kbvacc38C93U7cEWJBxB4mLmmsXL6c1AUwJrV9t3FL/8UReKrZOhTO72DxVzX3g4
	ErlOH+p+hbXYYi9Jeb8wfL3fxVuEji4Jmrz5cmfhAvBcWvJRodwMcMgb0jrK1eWw
	fJVS6EAZOovwl5lhRgFUqI51OqJ7g+0i47w==
X-ME-Sender: <xms:gUJwaJAGclckQHrDG0ylXn1ZfZG7JPSTw9lWXcz98Dnx6QM0-VpArw>
    <xme:gUJwaDC-RD21egFwVXPdlfTtdAKruC4ya0AhEv-SBwEJpETIKtgmiEhW6NkYIW83L
    6cOr6E9A9q7zg6Jvg>
X-ME-Received: <xmr:gUJwaLBEBVNMdNVaCInDWZgI8zyr02iZyzVbo069_35NuHW672gm8erLqaVdU0MksUs4FEWde50wK2GYrGx3-kgl4M3r3DI44no6t34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegudeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedthefgveejleelheehgefguedvtdegvdeuheetleeiffefteeuieetffdtteel
    heenucffohhmrghinhepghhithhlrggsrdgtohhmpdhhthhtphdqphhushhhqdhsmhgrrh
    htrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhh
    phgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegvuhhn
    ghhjuhhnrdihihesnhgrvhgvrhgtohhrphdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gUJwaOobSjye9-3X_2ILlzvOWpz2KpCN0tCQRNb7caZSyVOVaUg8uA>
    <xmx:gUJwaFl4Vuw6dWMgujelpvRdVXFM10338f1v_yqOtbadxSS5KWXIpw>
    <xmx:gUJwaOx7NsfAZ6PUBDTuaJa-vDF585qWofx-K_VE_6oleCbW9ILnZQ>
    <xmx:gUJwaN8MiqJKf63xSx13aKaHgW3lNOIOuHEeYQtbp4V2MvqKGAyqLQ>
    <xmx:gUJwaFW0vNTKakMFooR-LOAD3khTZPpq4_fZ0nrfesJn-P8XJw8L02YT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 18:45:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Taylor Blau <me@ttaylorr.com>,  Yi EungJun
 <eungjun.yi@navercorp.com>
Subject: Re: [PATCH 0/1] Filter C and POSIX out of Accept-Language
In-Reply-To: <20250710221641.857081-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 10 Jul 2025 22:16:40 +0000")
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
Date: Thu, 10 Jul 2025 15:45:20 -0700
Message-ID: <xmqqfrf34qdb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> At work, I've seen some cases where people provide "C" in the
> Accept-Language header of their Git requests, such as when they provide
> us with debugging traces, but "C" and "POSIX", while valid locales, are
> not valid languages and do not belong in the Accept-Language header.
>
> It turns out this is actually very easy to reproduce and fix, so there's
> a patch to filter these out.  I have not actually myself seen "POSIX" in
> the header, but it's equivalent to "C" and I've seen it in non-Git
> requests in various places online, so we reject that as well.
>
> This can be seen in GitLab's issues as well at
> https://gitlab.com/gitlab-org/gitlab/-/issues/412077.

Sorry, I am confused.  Is that Authentication failure in the cited
issue "caused by" the client sending "Accept-Language: C"?

"reproduce and fix" makes it sound like a correct exchange between
such a client and a server is somehow broken (i.e. unable to clone,
unable to authenticate, etc.) if the client sends C (or POSIX) as if
it were a langauge, but is there a breakage there?

I understand and agree with the change in patch 1/1 that it is the
right thing to do (to more strictly adhere to the standard in what
we send out) for hygiene.  I just want to understand if this caused
real problems, or if it is primarily a preemptive clean-up to avoid
non-standard behaviour causing problems in the future.

Thanks.

> brian m. carlson (1):
>   http: don't send C or POSIX in Accept-Language
>
>  http.c                     |  8 ++++++++
>  t/t5541-http-push-smart.sh | 18 ++++++++++++++++++
>  2 files changed, 26 insertions(+)
