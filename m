Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0012E17BCA
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771558224; cv=none; b=uyopum0YeXDrhbXRc8bgBsdKiWYrvoLpI3vv6Iv942Py6MPv2BYR3Jic1qn8Udi0EBHiYdmlB1LrKWecyI2jQgcyt5tLd6g1WwsAzz8C5AdtfLEd9eHTpx/vMZKEGH63xAmg8D9jwHKBK4XG+4f400Tu2CWYJfS35IZopVvVzu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771558224; c=relaxed/simple;
	bh=OH0qWprSL/+LDQ4fBEyBAaoT7+iqSkwcrHQ+KRZVtIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O5Sdm0zZLESRc+5A0XAZucJf5ve4IyytgZlmsExG2qEEW2o1B2pXqp3z2ER55s6xaVnw9xje1F5QgdjoYH30WH/y5lXRZICmSADn8kwPtvyMEwAAODFsBbOXEIKPi6lqeLunec+TdRKS7LLyG2n5/MjyRBGcllkHgYOzGp76tMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kf4IFlaZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Obi129kx; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kf4IFlaZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Obi129kx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CAD2CEC05BD;
	Thu, 19 Feb 2026 22:30:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 19 Feb 2026 22:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771558221; x=1771644621; bh=+clQWqo6cr
	PIk9ZdkdbRxz9MM4xyduTmmR0fGcrZWMs=; b=Kf4IFlaZqB/y+/iYbhTidCtRuE
	UtMmbB7/G0ExwMyJbD7ndQEy+dHm3oNkdaYY/LwYqf8PPIVgHsq9cj6kOhF/R/TX
	qVUxtyV61GzxaO+Iyu844NOaIE+NJrlUkVvXy4rvL9kNDJtd8rl5QK4BO33b1Tjc
	DQ5t893ytd4wS9XK+HQv845ykQJNMPTtmd1Y4I2FEMNkMmB/hDnKB8hKx2jjUCRw
	LJ6WMCa6CHfmXPIbZvqZK88eGIx+tUu6Vzhx0kbeWTtmphG3J3zI4Qey1Noc8PnE
	ENnCJ7ANxuyBQnNJkneUuEWoNKFapiexqSe14icYve9zuaPrRvUZ+FtHp7+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771558221; x=1771644621; bh=+clQWqo6crPIk9ZdkdbRxz9MM4xyduTmmR0
	fGcrZWMs=; b=Obi129kxZQo+2rxxonSlu59FQOFPwB6yOcZA27Ecjy62AYemT5n
	+FTLk1kki3I1KBRInWVw7+g/Y+oKwMVEjSC9ICtKbRVgnysCyLoiMD+YkqitUGyj
	oJqcWWcGvtekSBoSCgzLIWWVz0jrNYnglymrkhSILTLy+lFsB4ioQ3zVJtvf+eX6
	7zQDQ+y/lQ8Kzj546x9ADYsDtmxf5f5590seZjDmLTY6IFAOPWphN7J9y/q7iJGK
	iIYa+stnJDKlBaYUN9bkYb4gjsar4b808S2GyDJz1U2cUyT8QG9f5XEWlBEr7xrQ
	cSHiWB1CtWaQiT1yRXoJN3ju3edy8lgM4/g==
X-ME-Sender: <xms:TdWXaR8f12knQyB1uHytmAmtcSoHFM5Ed6BRXIQXFm2MIhCbHyiD-A>
    <xme:TdWXacvaUEy00GQ07QcgXdXyHabISCx0WiGrpFs0q243q5ziLhatVEGBLDD-zniD9
    5vx9CuNkAx9zM1Vzl8rKqKSrVAj63PTtvYtfu-kO7V2q-Mh7Cubeqc>
X-ME-Received: <xmr:TdWXaUCYDU7UA5K2XqbRMqrndGVBJfbyNSbYQibK9JyfAUYl86kLgQJGMLY6wMUMfwVaIKj0RqbNjoUV1xYCUqw64ho5CA74nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggvvhgvshhhihhguhhrghgrohhnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepvhguhigvsehgihhthhhusgdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:TdWXaUVhsyZAR2qB6vYWdQyI8XUQT-MgbfW2X0SJDc0pT_rdGcu7KA>
    <xmx:TdWXaSCeodKN3flAZmTd9FMauU3SGou9_mr5hjQrJ_2Y4fk80GE4zA>
    <xmx:TdWXaX9h97Ykb_la7IzrtKJokOOfcanYYzotvW_oTR-8GbuaYOZKkw>
    <xmx:TdWXaZGw67PtSqnuBb0tsxOSCSBfPz9Rnaa_MIriHWLpRF30RWCX1Q>
    <xmx:TdWXaegaTND21FVo2_22aNLA4hHsMP4PZohvA0-bO-j0YJoX1SYWUxZb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 22:30:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>,  Victoria Dye <vdye@github.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t1006: fix %(rest) test for object names with whitespace
In-Reply-To: <xmqqzf5431ek.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	19 Feb 2026 12:48:35 -0800")
References: <20260219152407.12160-1-deveshigurgaon@gmail.com>
	<xmqqikbs4iod.fsf@gitster.g>
	<d2bf79b3-4407-4fa0-ae2b-fcb3178f36f7@github.com>
	<xmqqzf5431ek.fsf@gitster.g>
Date: Thu, 19 Feb 2026 19:30:19 -0800
Message-ID: <xmqqldgo148k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I agree that fixing underlying issue would be a much more valuable
> outcome of resolving that FIXME comment, but isn't the approach to
> give $object_name fundamentally incompatible with %(rest), making
> the issue something %(rest) implementation cannot "fix", is it?
>
> That is a part of the reason why I said I am dubious about the FIXME
> comment in my comment.

Actually, it is worse than that.

We already _promise_ to chop the input line at the first whitespace
boundary in our documentation when we use %(rest), so there is
nothing we can do to "fix" on the implementation side.  What your
original tested, i.e., if the early part of the input up to the
first whitespace does *not* name an object, then the test cannot
succeed (not just that, the test should fail, unless it happens to
name another valid object), is the advertised behaviour of this
feature.

Thanks.
