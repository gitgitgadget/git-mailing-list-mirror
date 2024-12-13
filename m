Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782F61A8F8D
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085084; cv=none; b=NLHQBn+x/ji0f8LtGm+G1ySSNRDdoRdiccZJSnMfrTpkNzPilqg0lOg5rAuYWtmDN2+3Y8uRt89V7sQloxwXnjDJeeWg6Y5+wlb+rxv2KKDeC0XhrmqAKuh01iJ6hhUcW5oMUWJ/Kzm/wSMSGkSZrNj4aaoupSuE0h11XzKtFpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085084; c=relaxed/simple;
	bh=yG+7VCVQQYPoLRKNqeZ9vyU4RGeutCLBajCYHrru3u4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dU3JGl2D8D5W9XJNBnolNMsmSD72JtN1xe4sZuH9po8pcyGf8Ba0mL60vThhtgoPFwPLXx+WihksOkiQnwP/0jul881azRig6gZl/RDf9EhDEQ7IemDCXfwXPi40cWrIfRehYQZaxDu0Kv+1eSImZFNU6wQHg4AgG/xFZ6u2VxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=naSMyICE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IxI+043s; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="naSMyICE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IxI+043s"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9FB322540139;
	Fri, 13 Dec 2024 05:18:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 13 Dec 2024 05:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734085081; x=1734171481; bh=CGeajt/BbF
	f4/zrI0Z0bcLhxRKajSVkCL7zjmkdcMqw=; b=naSMyICE0SmvmadnxehCg/03/E
	K9GFy0zciUfdCz3xSimsts1YdHMQfORUoQGrT5TJIUCKQecXCaEave73K6AkO66+
	Z0vwwXSP9VeUbqd0BgNCbxEkK1BhVwMkHaB17tCBlk5W8UNWMWnXAwyDHpU7xzb2
	JXIQHoz65uiYRD51M7adyOHNr1QQCqmbgnrkBGZ3gPwgZr8AF2hU+3XlayYmruA6
	zducjF1r7oyOSJt75pCdbZ23OeNhx5/ExKNqMoqta00QBVVmodLsc+51UJ0GUmA9
	0Bpo7ZGLNtKy6y7ARTO9Sz8FRMFc22FaLy6Q8sKwJYYt6zIVqGQqRktCInTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734085081; x=1734171481; bh=CGeajt/BbFf4/zrI0Z0bcLhxRKajSVkCL7z
	jmkdcMqw=; b=IxI+043s0uStPS+BF2fBoNJR5jTs4INqoNCoELD8KJNDOhBeLpb
	jKoZgbDT8KeqebR4yj4IsIpiJc1WU0JjRV8cZSDo672VTr6R20T5dRgQtkyY7Q9u
	4fgBR7UUE/SkdsyvvwMagGnObAnD7dp5h4AIqD5Bm5LgmjL3+367ZNPtnqItZyay
	+KescNfxs0uGAuFEV5FuuMK9pJGokJGLMlaDNrTMP+fkO6zaFaYmFbdI0xEnJyQF
	VulO1UnEYoNcOjUopFTnf6OsdYu+NhfMjPD09Bs2xo1Nab87aOu3Taj2lsABPSLe
	fiunmCGMICxUABt9S6k+GGKBb90inTmPu6w==
X-ME-Sender: <xms:2QlcZ0SqKNW3CpKu7R93ogCXMocIhpVx9GgxzCqCVfb2KXXPaJU39w>
    <xme:2QlcZxyz74E5rL-4fpwWHMYqy2ZT_KsxHU0gVLYbTRUtc44Oeug1Ue7HZBdZy5n9x
    JLZUjany7ZJXsNr0g>
X-ME-Received: <xmr:2QlcZx3DKgtZ2LXq7vonR8NZ344Ac9VKp-nh3gXb7z9BjcP1LCRWlYp4sXWhZDJKCVAoflG_IEdZ2bUr6kGsUhvWEazkuEXDo0rG5ZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2QlcZ4CNIHZOIvD78LqTKdTtuWR5ypJcNiWw--K6J44aEeVwbTC-Hg>
    <xmx:2QlcZ9gDQTnxj_XSMSziKA9jIlHpL3Qwvp8ANBhQMwOpR2qhi23AnA>
    <xmx:2QlcZ0pPKSZOOwxOThlQhVyNWiT7MUvgA3RlMNAipuQoZS-SQ4bIWg>
    <xmx:2QlcZwjQqBMAYdHOy2w6gAmb4DZ2HS_Or2o2qwkZVtAHj61XWDUXeA>
    <xmx:2QlcZ7aGyvzUCRSmCxJpByUuuNPZEsZxFxzWk3GxrIpN0EJsecFWPm1n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 05:18:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
In-Reply-To: <20241213081211.GA1443203@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 13 Dec 2024 03:12:11 -0500")
References: <20241213042312.2890841-1-jltobler@gmail.com>
	<20241213081211.GA1443203@coredump.intra.peff.net>
Date: Fri, 13 Dec 2024 19:17:59 +0900
Message-ID: <xmqqv7vnevjc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Feeding just blob ids has a big drawback: we don't have any context! So
> you get bogus filenames in the patch, no mode data, and so on.

And the lack of filenames and the tree object name at the root level
means you do not get anything out of the attribute subsystem, which
in turn may affect a few more things.

Unfortunately the format used in the output from "diff --raw" does
not capture this.

Does this want to be a building block for the server side diff?
Would it be a bit too low level for each "request" to comparing only
two blob objects?  Can we place a lot more assumptions on the
relationship among blob pairs that appear in the --stdin request
(e.g., they all come from the same tree and share the same attr
stack to look up attributes applicable for them)?

