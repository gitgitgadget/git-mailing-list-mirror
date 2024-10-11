Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA77F9
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665308; cv=none; b=VsDvwmNcFCPDCBbshPOZSWQYj2yPOTWq6pUzYKYT0yJxNW8yOk1F9ACUuEzb8lGuXnGJjUrg1+7hGelqReOuCBJXizMERwq7M76/WYYFnrr2kCe4DHbvOeauT5DQldG8AcI/7utKvdYh/LQ0tv4f0cOQ8XbKAlng98wa1W1I4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665308; c=relaxed/simple;
	bh=AlD0h3atKQPC03HZps5OiRnyY9OqDU3CeZm0g5qkOnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J/4wA69zMg43YtFxiUEjWSlA48pGCaIzIeFaFB4l5STvbmvtSYfGqcm+c7cocxq5AHISMqwgRKCgbel1SUt362GGVvkTTHPv7audb2XKePymNyuC2d07cWJFO3s4ts/eSdxYgoLNpfdPSC+Xq8FrDZa7lWWT+85rNW2ZDZ+2Hzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cm1SMnrF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O+K2bHMr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cm1SMnrF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O+K2bHMr"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 567A513801B7;
	Fri, 11 Oct 2024 12:48:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 11 Oct 2024 12:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728665306; x=1728751706; bh=c1VMPROYA4
	YOHZ64wB9ppR0Qf+oaBqcbCeob1nyHqHk=; b=Cm1SMnrFaRY+t7rT3Pz3fGhhZe
	Oif0bwy1eSqdUIN4upX9rpilVXtSTM8cHot5MsO2X1GItLOv/wn7t+gDEcxBolQG
	VJ0JQ+E8V35FWmHdZ0xoPw/PUSBhNIkXvHm+2wwMNUuig4BibUS5lCE/1Hr6Qk1M
	jmaj27+KwaVvCmoaRBu2VWOvD2UgHvbkX1cs2sKjEybLnFpfXErsEpTDokrY9CGx
	EK+QGKnlhXRWBh5EykjldPcl1/gGSdZpZ9appvrkjvpVK2mxbuYQSUBegliZm5bl
	bA6y/K2EF9b+bY+nIyRO91+dRx1FvFimIF5NiTD5GjWQbv/udNrFXvvnw4gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728665306; x=1728751706; bh=c1VMPROYA4YOHZ64wB9ppR0Qf+oa
	BqcbCeob1nyHqHk=; b=O+K2bHMrMNvUJ9qx6U3XXjwxYZbWxWVLpFrlW8akXck2
	ziabPxfBk7rxFKrl94pNlBvcVHhuzDvQ3TkMKYcIL7jnxdtbOBSxzdrA9TF6eTQX
	mBm88koV+KbV+Q1SLr5Jtx6u3Ecp2nHQWvRjBjwy6A5mkrj01DPxqC+Vyke/kMom
	6v+zzZLZhCASj0dC+eup5DNW51mpfvr8DF9I9dyU8e9QQyVUf+sZ7VmvMAgCBOVG
	l9CQ43/VrNwlTL3J+rbIGY/ezzZYs3oj8vZwwXsoFcwjgzGs8TNnm4bZwKy4rF8c
	tegwSRJg3LjXRS4qLf7Ksdyw3cOdXsiiVtyD2RwO2g==
X-ME-Sender: <xms:2lYJZ9I8A77c49JgPg9qLsyA4OczZxw350raXl_AIc5uH0-QU4yTWg>
    <xme:2lYJZ5Ktk0UC7L-Kq6Rim0QOEssLDlRytuR6Ta3epikKhcG4TrX7na1EZuYEzvybA
    PgQN5_O_kDAlk83Qw>
X-ME-Received: <xmr:2lYJZ1tryuP3kP_YvGSeZi0-8tRQxv_0Gg3fpgkTYPQ0g2KA7KeJROLzu-A-S-9k_4qgzVIAD4TlfhXB8YCiOKfWfrapxUCXjzQ3Ijw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:2lYJZ-bjagDbdLRBuvso4wHvKCX2W-jkV9MXT_kpT5Uy02ct_6atmw>
    <xmx:2lYJZ0Zxj_4zTZi51xj_85k5sQkAuUB2cu80tctZdZU5TNePARhu5A>
    <xmx:2lYJZyC7RuQdRjR8IDmn_WpZ5x6q4h_4E2KgfvopWT8LVgv2qHUU2Q>
    <xmx:2lYJZyb-WXJ6OwIHWvlg_MkRFOaMXL34MjKmP30AiDQw9jSNsB9ZEg>
    <xmx:2lYJZ7Xr4kwEoO28Q0Bu6Xnj9U9KReNlRKGATwFx8u8x12Knf5jwXRpN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 12:48:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
In-Reply-To: <20241010235621.738239-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 10 Oct 2024 23:56:08 +0000")
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
Date: Fri, 11 Oct 2024 09:48:24 -0700
Message-ID: <xmqq1q0mh9gn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The final commit introduces a small but useful change that we can now
> take advantage of with our newly updated Perl dependency as an example
> of why this is a generally beneficial change.  It can be omitted without
> problem if it is judged to be too noisy.

Quite honestly, these two changes, each of which is a one-liner, are
so boringly trivial for being "too noisy".  But on the other hand, I
am not sure it demonstrates why it is a "generally beneficial
change" sufficiently well, either.  The pre-s///r idiom

    (my $result = $orig_to_be_kept) =~ s/...//;

was concice enough that

    my $result = ($orig_to_be_kept =~ s/...//r);

does not make all that much improvement.  Where it shines, I would
imagine, is to rewrite an original that did not use the idiom using
the 'r' modifier, but fortunately we didn't have such a code?


