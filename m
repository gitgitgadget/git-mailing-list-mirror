Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AEF2797B5
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226963; cv=none; b=b0ZKN3I8UwdUi7AJqyeBfmuI5ackv+mvhQTGs9q6OZWuQi7F95QIT/Id6+7CYv78pF+AMdZn4FFjU+nEmNj/Y0BeT9cl6LO9dTtAzO5TjtDLLk2pE7MamlEuSKURDh9JlESf9lqw8RsQKbqx2lw/qqD/SKrIqZFMoExHEGuKHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226963; c=relaxed/simple;
	bh=f30b+e/ZJScNElPWJvhj0AnsjdHosTbBhHECKkUuYJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LGgplv6uLhpj6qnKdujVYVoIvGkPHusE+MMuTBADWTFoAF7lgqQ74iGO8PJsq/Vx0buFea8Yafw6J8rW0GphDa3VccOrpNIOecaPOZ/OzFQzstuzV0JbMWSJtwGWojyNRRxg1dAV/74n09rjyVk7sLjWJAUUzwnmU6vKS0n5yVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UIhPkLmu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LVdn7XCq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UIhPkLmu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LVdn7XCq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 951A9140017A;
	Thu, 23 Oct 2025 09:42:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 23 Oct 2025 09:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1761226960;
	 x=1761313360; bh=ahpHUcDHLXUTSeAhKa7ZH8XJs3MEOLio9f8jrYJOy+Q=; b=
	UIhPkLmu70mVeJCLfKh6Wj0nhqvytilE55pKeEWNDkA5Ji+j46JlgjMyMPS5ASCI
	KD8/iI5y/WUOlwDaeW5IU7f9m6n7wvnxnQInsYq6D7LWRGNSbQSXSiksJo/4S0Wc
	OCPKN4gX6soKMgb5u9N/Ral/cryFf4FBpXylSBVz6A6itsjg8G+5yvniw/WhGwmZ
	8E2BFZQ47gQiMWcRjNh519GJLh3vpkTkvTxx85BwYI9spxeW/4W7uY1PWgHpnwjo
	HpVK3tWbe23mwlJxw2RcICNzvsMGIO5iN2fi6+JRCnnNzcMOkzEBjQ9gzqf+dVcV
	ujn/5wJz9rkoe1U1WKaBTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761226960; x=
	1761313360; bh=ahpHUcDHLXUTSeAhKa7ZH8XJs3MEOLio9f8jrYJOy+Q=; b=L
	Vdn7XCq41mdlFEXT9Gd1bY9oIcX2aFC3h+0Q0BQwAHdcBH7yZBtyitJvth34+Zkp
	0Ek2flwyA1ec9bZ1NQYEu6lf/d3NGgARyncWRdjKjZmNujuKNXXvMQZkOtVABzkT
	nl5JFvH7f1xmsWTtkYFKnqDDaWO9BLp4lMRF0+JHNioPYj8Ol2CCkeINklvEdIY9
	ZTbXwEYvG4+rBRtS0j1SLli17lc/IRgMJkjx3pKRQ2ynxwuRBQYxZMnic6+8d00U
	pmAyS3MevYe4/4gk1KtadUxwPwbFFaxMz720B8J6bcCqJ7NZiCwJhW9SMzFm+G8I
	tMDs0Kh9f6rRbdw8nZqfw==
X-ME-Sender: <xms:0DD6aLMP5M9N_woY6PjhJp23EVm3_OFv8ZsXkZGdX4c8uWg31IkzSA>
    <xme:0DD6aM1nZjhG_cA6k4bzZkqszdqKnUEbFoTDHsk5VaXNkI84csMTZ1J1-pxREhkT_
    8j21zh651M35bzy043hISGr9z6Y9XX5eRW4A2Llv-kPyelHhws0WMk>
X-ME-Received: <xmr:0DD6aCnz6h6paDUXTHV69vlMgD4pfvBmzk6eXVWGPFK7UTV8ckJ6GhvhzVL3e0reEvYQPK752nk2_4pw8hsTdqE19Y10xOxtAkci>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeiieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhmrghilhdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhgrkhgvseii
    ihhmmhgvrhhmrghnrdhiohdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0DD6aLWI7X0dHJPb68oIf9GFoB1ou7PJchwm5CiDRF-exPUXLBmfUw>
    <xmx:0DD6aAuQ5zj1fIGKyWqNsF_pisOWTxYQAvUOCApaqPJ5MmMzPDMbTg>
    <xmx:0DD6aGaQIp61j2EcYm303YomGUhgnzip1uDVJnWxLtMl2aBXkmpb6g>
    <xmx:0DD6aHVntEqzZHnp6qcgWeoVEVt0wOEkEEaTHjHkTPimGR93mKBiQQ>
    <xmx:0DD6aM2_R_tF89W8e3HWHcX0EJCatriEEMbPz_eg1t-9ntwcOt34q8Re>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 09:42:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Jeff King <peff@peff.net>,  Jake Zimmerman <jake@zimmerman.io>,
  git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
In-Reply-To: <09150C80-0238-49C3-BAA2-42983741C905@gmail.com> (Lidong Yan's
	message of "Thu, 23 Oct 2025 08:33:48 +0800")
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
	<20251017075153.GA4078773@coredump.intra.peff.net>
	<xmqq7bwt1kyf.fsf@gitster.g>
	<20251018094037.GA1060824@coredump.intra.peff.net>
	<xmqqh5vww7xa.fsf@gitster.g>
	<20251021073640.GB259661@coredump.intra.peff.net>
	<xmqqy0p4wcac.fsf@gitster.g> <xmqqcy6ezvi7.fsf@gitster.g>
	<09150C80-0238-49C3-BAA2-42983741C905@gmail.com>
Date: Thu, 23 Oct 2025 06:42:38 -0700
Message-ID: <xmqqikg5wx81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Lidong Yan <yldhome2d2@gmail.com> writes:

> Do you think we should make a new ‘going to be flushed’ queue
> and flush them out of ‘quiet’ loop would be a good idea? I think we
> shouldn’t discard output of flush_one_pair().

Thanks for catching my sillyness. 

Peff caught the same thing but in each iteration of this loop we do
the "diff -p >/dev/null" to decide if we do "diff
--(raw|name-only|...)" for the path, so redirecting the whole thing
would break it big time.
