Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC70D3469F4
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871127; cv=none; b=EXS1zM+e3yshjJnvijjew7QuKCOa7gsKrBgHxwH/4z0pnFziQcPnmdppEgyRmpC/1evCg4V2m6UcLyKdD0SOzJK/KKJ7HHEK+qMAjEmGVRq9QKm9diDHUl1mCYWTMUHoPXbupXIhgzhko3jMb4OTTefp5Y6VfYLRQSXE1hlmqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871127; c=relaxed/simple;
	bh=iqqBgjFDLgR+5to7jZ+5gyOfxJtD0PGTODB4KgekG3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H2s/B915Tf/AeH/eEbYq9PZl2XPExKlqBwudkJJ7GcjjjeGHpiupOPs03nam4VhPtqakhyPFwR1MTf4DaHApC9NEux4FVFPm0SpKskyBkfv69MDAaUu8ToMthQWX8FK3nIpsos3WeqSyH967yeCvhEWoCUX8t+RTTJ9LK7tmA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U+ZxHjw8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ccQRe5fK; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U+ZxHjw8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ccQRe5fK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E9FD7A017D;
	Wed, 18 Mar 2026 17:58:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 18 Mar 2026 17:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773871125; x=1773957525; bh=iqqBgjFDLg
	R+5to7jZ+5gyOfxJtD0PGTODB4KgekG3Q=; b=U+ZxHjw8E/yWUhWYhjTjEEvfSu
	I8WSvBhGw7hWc5IbqRIwYxAVdEw3F8DyGt0XQ04cFSHyu2Qfp6PJe9fFQEHNnVtC
	2gtLke/x6fpIDp3mcj6Jnce2xVnBC29TnTlCXQl8X6GVd5bsaFmhFjpCA6bdXCoA
	tSr40sUd+PcotMZU6bNaoshTe/9LVMSIEqYtZgueo5evK4/r5C1sTFZhMF39cjFw
	esYPZcWu6vMcT/bkdZxo7brZWk+uSjfVW1EuQtp99CW7peObBDL1h4YSs/FG+Gce
	nWfqu411xhlS1WlW+l2Sn08r2cuYdCzgHUiJxQs8iLRkef6fVFXVFNSAk8aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773871125; x=1773957525; bh=iqqBgjFDLgR+5to7jZ+5gyOfxJtD0PGTODB
	4KgekG3Q=; b=ccQRe5fKgCmLfHiMs2Z/4EMVW1/K1Uby+woR3dNZTCiTpUCDjos
	oFkStJ56BZwWkSvHGJF9gSMH5HKjADfDbKtr0nMYr00QBplgt+WeHL5U475i4cOk
	A5q4PoMd8+v26iIYpnBm4Tp3sgxkiorsK0pk8inzbG9BRMJ+cQpb7hnfgRtecnjT
	8NRUM9HBnnvG7t03Cg2XXsR/T84a9m8x2/HBq6j6nnVnGw9vRoR9bK48eR460dHR
	XuuZYUaKtIAIXzI6FmsTOykVrOL/388Y8v+hg37c1RBmQtR6JpmUCekFLhdG8NYS
	EStDquqAr1eDkA8y9WrN9J9WD6xTO1EGrBg==
X-ME-Sender: <xms:FSC7aWzxFeqTCnUgXkpA8zEuYlrXa6XPL7xDapslCTHzVvXF2oMTJw>
    <xme:FSC7aUjXnJi8cegtGX3Yhfuadp8fPs5F17gEyP8hsp1axRtXCWgarLEzWY2vxlEW0
    8_Tz6TCAM_HVgxddd7xw79KmonuxXZ2wvaMLR2vWWjB_7A7D-E8cg>
X-ME-Received: <xmr:FSC7aak11rWR_wdfWX4OLg7y0LTfeeDjnKJrudnx4sG4pUE0bhz-JAvXMUkCRzm6A0MQF5cW3mEFGJ7Rd9RiReEsvpPVh91o6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FSC7aSgd5nRn2ZVVDkgLwNisCvzS2Czy68qnw7pY6cIkWqpXw8DIJg>
    <xmx:FSC7aW0uwVwOyikv8qMpzS5Ov4qMTu1lWdPjkFiiAggaazVe43lQAw>
    <xmx:FSC7aTISwLKojEUMB4V7zQ3MBgYkHQuYAVIiI6nhbDw3PNTO6adReQ>
    <xmx:FSC7aewGE0KYd3jeVMTYFMKnbjMBXfbPfLkcCgaXJDK67gbTMPsxbA>
    <xmx:FSC7afKAMxb7MqLgAb60Xu_FzoUjD7E0wvctHAX3QeNv7wKsAPVE9Xnt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 17:58:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  me@ttaylorr.com,
  phillip.wood123@gmail.com,  ps@pks.im
Subject: Re: [RFC PATCH v2 2/2] push: support pushing to a remote group
In-Reply-To: <20260318204028.1010487-3-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 19 Mar 2026 02:10:28 +0530")
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
	<20260318204028.1010487-1-usmanakinyemi202@gmail.com>
	<20260318204028.1010487-3-usmanakinyemi202@gmail.com>
Date: Wed, 18 Mar 2026 14:58:44 -0700
Message-ID: <xmqq341wpzor.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> When the argument resolves to a single remote the behaviour is
> identical to before. When it resolves to a group, each member remote

I find this hard to read without a comma after "to a single remote".
