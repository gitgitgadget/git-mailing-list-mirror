Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF131EB5E1
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771965526; cv=none; b=VsN/WJzF/VrlHG7oyFHZ+xwq0M27nchGpSD3wHISX+Bnsb344bXRGPlBEmogmeQsj44CcixveqnWsJFM8WJlyuasBhSeo9P9y3HUckOkXIr1XAbi/qnZHG7KbrLWzlulwRE7G20F6IG1uMbLmQyNqeC5+eN1bKdK00qWdRH0dkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771965526; c=relaxed/simple;
	bh=sTLPVWX0k66izODn15sXWEW50yNp0lDea8QEZJsPwO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZyXlwA9906cjkOUk+fdMHbaRhlQddfTHZj0jWUisNnXlrrBKIGZ7pQVXTUw4freK7h70ZmyzeShGsUjcnbewtsAYVhQavfNPF/99XwGu29MchXQTUFiQcsCz7znywcGiy+FQz22cWdFfnvt5mXacx8xiQRJZIBkLFnhGyuIt/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bAGr/AA1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sw+SLRdi; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bAGr/AA1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sw+SLRdi"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9572A7A0249;
	Tue, 24 Feb 2026 15:38:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 24 Feb 2026 15:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771965524; x=1772051924; bh=45nxlHUJ6D
	AqHj+0m3w6N1bZWiq9kFwYdh3u0JHMrYY=; b=bAGr/AA1gc7eqISL737k7r+V2Q
	PuFptKtdXZmBZLYujMh5/3QYYmdZchPk5zbfh9/1a4egJrwIUVDlYGGHQT+FXvId
	fcoIa9LCCpAkwb7xR7gsyYl/mV8Bj4xRhtip5ZQKndaFBUyMnYSlNJdYkvwTNb+u
	3/ejwmxfwBHbdqtrJjQNFrsZI3jBxPfWHfNNaXig7Mkn48QeYG6b5fRYLAAdwhvy
	ZfpyRrqfmzEDEsX+ZE4rhRGkHTSYUj0tyichzawH4DNLP2yoO5LmKrqv+iZ88uqL
	UJAIMd5z/pWB/KbSJZUHbkZKEZ8xzAufPgVLKlF7Q/qfB+o7TRHzwefjY+6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771965524; x=1772051924; bh=45nxlHUJ6DAqHj+0m3w6N1bZWiq9kFwYdh3
	u0JHMrYY=; b=Sw+SLRdiiKXVOgGx3sEt4OMOlFbA2W/TyjlT2ZAUY1Tcb9O0pnj
	w07kCrB+WOuJ2CHsNh5xh/OR2GkJ9tsGQ11oZPvRGq+Su03d1qJ4hGCpwF9Ln+Qf
	YqWfN7R9pKgfWszzvx/wlIbaIco5pVTE7lH/A7dyk5u1jw/T9EzdCJQ77koSQrnQ
	q7oHctNF4n4sive01gacRLPwBOut7/vbhvS5GTuw0UAso0i3mNWn3tvPISPJ+hEB
	xmJmu1mA/hapVpJSsa5ES6UlSCzRn5b7b0Qd3s3PzniGuAwnwhXUwbZoolLfn2OB
	pSyVIkUUc+Jd8p+7541h9bhifPzj2TYgccw==
X-ME-Sender: <xms:VAyeacEQgVHiMbkCvcAJDbXi3lBWqjU9Om6Ym9KgemMzDgTpPBdgKg>
    <xme:VAyeaf6V1-ale1XT4gBQwIeXxoL8RS-in-wkv79eu1sM6uyKJOeJjn58ya0n78oSV
    UhmjlFCvvsaOreT_KQTXaJw3Cc_xy_JUsa6ECrE4jmzci8ieelaeQ>
X-ME-Received: <xmr:VAyeaSsf1V07e2HyF6c112RWc0NAj8LCTDbVajzJgp12J4sYZNFHjnYfxgN0KZEBrr1yTEZAMNwpFQLO8r5oLw2rzALhPjX08g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VAyeaQ4dpCCJ3l0AzmGdMFwflUFHuPQqhGoDEN7MKBGyUVNDS4tLKQ>
    <xmx:VAyeadVAeZPOaEq8evrXzIMWkJBVKmrz-qtVCt4xLe-fS25Cc174-w>
    <xmx:VAyeaS8MJ71vZaeKMOSk_EKzV0M-I1-ia0jFCeaarxuSRU5EHtfgwQ>
    <xmx:VAyeaZlQE7c0BLxl4e2EVNIfVRwZspcnrBnYAnTd3Jf1SIzmlJTIcg>
    <xmx:VAyeaUvtNNHxW3c-p2FGeE0-aNY4Zih6dEL-s2MHB_65bgVWiXlYAU9x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 15:38:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] format-patch: add cover-letter-format option
In-Reply-To: <cover.1771925291.git.mroik@delayed.space> (Mirko Faina's message
	of "Tue, 24 Feb 2026 10:29:00 +0100")
References: <20260224040400.751247-1-mroik@delayed.space>
	<cover.1771925291.git.mroik@delayed.space>
Date: Tue, 24 Feb 2026 12:38:42 -0800
Message-ID: <xmqqjyw1g9m5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> From: Mroik <mroik@delayed.space>
>
> I've dropped the first patch of the series and applied the changes that
> Jeff suggested.


These are queued somewhere in 'seen', with a small fix-up to have
the build pass plus a bit of obvious tweak on error handling, but
most of the remarks I made in my reviews (like "doesn't this leak?"
and "shouldn't we have tests") are not addressed with the fix-up.

You'll find the topic in 'seen' after I push it out for today
perhaps in a few hours.

    a981554b03 format-patch: add ability to use alt cover format
    8bf8e6ccda format-patch: add commitListFormat config
    a85e8e535d SQUASH???

Thanks.
