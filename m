Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3D02E3714
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754239730; cv=none; b=ccFnqP3Lc4GEQtYb5QiQUTvOwfRXnJlo7E7rDzk7swBcDC50fp7Z77L+jKXl/Y/YxymMk37jjBPzAPqgUit0IDesAeW56FAj5MdkcyMDiz/GuTm0QzP+y94KUgG4TgQP2q3kEwc7EzE8arfpFaa9kHbkEFS0r1fr8D1vgMmupo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754239730; c=relaxed/simple;
	bh=vpfHMSGrj3LKpRJQO0zZB8TdbnxGSoKQdO5+JrkbYH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IPFIO2+StZ0GTdW11IMMBHKMngbQ70kviOSL2iefTUDb0fVKgbB7xqzVMdadwuZjMjfY4qP6S0FTpKKLNASSpx8m2pshmeWGonxoX0aB2vxCDTNKyU1pS+dWL8mCUouDihAIAMjrBttqN6uWFj+wwWWXIsGmBPkPJTW2JGlTfBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YjXVe0fC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jzvec6GP; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YjXVe0fC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jzvec6GP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 48C807A0047;
	Sun,  3 Aug 2025 12:48:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 03 Aug 2025 12:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754239727;
	 x=1754326127; bh=kCEoAZKfJONl5ZPwAfZ4Fa4TSm0YhjRlSeWorqIBh2Y=; b=
	YjXVe0fCpdox7T2HYh/s0U6pyQUSl1GrRls1jMTNwdEiiikbYEnOViuAGCtbmFM3
	zyqcjSwq/uxDZIy4yZFOlt22CVMaGgqrmuF1bbqUBqb9YtItUGVVnl6F11fhGY2c
	/6BxJzl0eXPnW38iMiGqn89X33tbZXUbSQGcFlbt4ZB48pYX5Sr4XmaNhKK6zQcN
	Mx1gvjiEXQFpOxeSwR3AdxhCYQ70zadeJxK2vqS3/dJ3ZqJO6stVHHeExWxe3tWf
	Ca0HuTjl9W/52G/IwWJVB1Fot40WHUnwubX18DDkixcQCEGdcmBPiiYdgralRbsc
	adl8Gl05ffD++0ut3b20FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754239727; x=
	1754326127; bh=kCEoAZKfJONl5ZPwAfZ4Fa4TSm0YhjRlSeWorqIBh2Y=; b=J
	zvec6GP0NIFiN9ZH1bM5fbTBYD2nLwXjBvY6Al7IVGH+CkSluykjAKmIraqTGKzA
	mFi1X7MyVPnUknOzWeGG0A59tJwBzuJsqa1FoLu+A55j6RiCxZMtyXr+GlCGnwE1
	CGgKHa2Mc5Wrf7rFJqGbfW8gchrC3zQpxMM0KH+WMDLBRAXaCP+UfWBhHzcvrcMZ
	bQ1EDSm3/p6agZZATdWcKcFPmZ1buqaz+pGb1iOqCW6RZjWZJ2Kjx44VxxJ443MF
	BBLz9A3RZ9k3IUO+JNzx8JoVkFo24mdlvJsUyq4d3j+rVmd5WvfdezZaBxkbGdak
	dWsHrdgL1V3vgwym10LpA==
X-ME-Sender: <xms:7pKPaEyKpYHM0hd3JOCd1cqf7JllEX_3hQ0KAo_gcg8RGILvdDUeRg>
    <xme:7pKPaAuFj5yHiTufpn0wKlKwcWjnLUyDMNTaXaKNEC2WhoKiU4hlxx_V4xMGn9JWB
    GUbFLQHnoW37L-jMg>
X-ME-Received: <xmr:7pKPaGz3tK7RRHlhI8sXHa4BA4hEK7vOYviBxWkTYX8ImY-LGcXoaaylMAe-JOn1G3Snw3Ea-XTtEpaMhjbiaBXM1Z5butoGGx5-KAM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdelleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    ihlhguhhhomhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7pKPaDAwXh8HVvY1WNuGzWAyeg7nQ9FcvZXc0Tj6TgSqF142bF6A4A>
    <xmx:7pKPaEfD1ZW2v6mcKK6xfMhFtUBVqlODvRQ89wbHUIpcL-im3D_3pw>
    <xmx:7pKPaNll8n4b9WlyMdvBmOIjp7l2rN7qODL3IeOz-r92RJI6DQimCA>
    <xmx:7pKPaLFXkOXzczZqTjTiUrB3pMx9_qZQ7ExZsSp-q4EZCc6N-Cxtjg>
    <xmx:75KPaIdC8cxUM4tigfiVs-FbOB5Ip8HASD5gY5ExN0qVYXmeCXs7_Hjw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 12:48:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Lidong Yan <yldhome2d2@gmail.com>,  Git List <git@vger.kernel.org>,
  Jeff King <peff@peff.net>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/3] commit: convert pop_most_recent_commit() to
 prio_queue
In-Reply-To: <c5d91cec-3fec-422e-86d4-78767d95f208@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 3 Aug 2025 11:54:26 +0200")
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
	<8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>
	<5d7c631a-ae94-4a59-b4ee-8161b5136d86@web.de>
	<148541F5-DC9F-4A3A-B1B1-0FED8AA5A101@gmail.com>
	<c5d91cec-3fec-422e-86d4-78767d95f208@web.de>
Date: Sun, 03 Aug 2025 09:48:45 -0700
Message-ID: <xmqqtt2oe4gi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> We add and retrieve each commit in the (relevant part of) history.  That
> takes O(N) and O(1) for the sorted list, and O(log N) and O(log N) for
> the prio_queue, where N is the length of the list.
>
> So the best-case history is a string of single-parent commits, keeping
> only a single item on the list/queue throughout.  That requires no
> sorting or heaping, making the additions and retrievals O(1).  The
> overall complexity is then O(N) for both variants, N being the number
> of commits in the history.
>
> Worst-case history might be a single merge of all commits -- a
> centipede or myriapod?  With all commits on the sorted list we get a
> complexity of O(N²) for the traversal, and O(N log N) with a prio_queue.

In other words, for a typical two-parent merge, we peek the current
one, "replace" it with its first parent and then do the usual "put
and sift it down into place" for the second one.  

I am wondering if there is a more optimization opportunity if we
allowed "put more than one, and then sift all of them down into
place".  In other words, if I told the machinery:

    I am doing this put.  I promise I won't do get until I say "now
    I'll start doing get's, so you are free to delay your internal
    state maintenance and do so immediately before my next 'get'".

and did such put's a few times before I do a 'get', would there be a
way to teach the machinery to take advantage of the promise?

In any case, it is very much welcome to speed up "describe" with a
better data structure and algorithm.  Will queue.

Thanks.


