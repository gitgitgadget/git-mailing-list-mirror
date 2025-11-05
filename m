Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1601C32E15C
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353655; cv=none; b=noEHkqB2JUd/0SWHzQwwuHqr5eap/fnW6CtEi4Plf+6nJDVD9cr21q/4PPIcxf9ZnrGtOMzBhW8cZzJRiWgl+FgDEACtV1wGU8zS/76AKnjcQYCusZ+CR9Z5SVW2J4vucvtqGqwR7ZCgWD2zwQyWP0jDvgAJBuhHcJEn8FaW6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353655; c=relaxed/simple;
	bh=zi3aBFQ6Ya6qnSKrmDmfatZQpubd9yk/iI4tI/RGZ8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W9i5Gz/yeJS2Z7PqZddhHmLLCecFMXVt+kXtKmu3/VPxW9sGg1ZtBisEjFJo1xIS+nQER2EL9UYjj7D4lJCNfQp0U/XJ9WeytRFLKXyRAS4+lzKwXAwoO3Swwh3RuKq7OoDl04eA8IsRC66T6On7dTQ+yXgM4Jn2bkjgpqlQmF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BxT5xe4W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JC7WhiRw; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BxT5xe4W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JC7WhiRw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 11A9D7A01B9;
	Wed,  5 Nov 2025 09:40:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 05 Nov 2025 09:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762353651; x=1762440051; bh=DufifCwAzF
	0ocKv3ba9DTzSyYDq04aqF2i30BO1Nw0E=; b=BxT5xe4W2rA+QAIx6hdU4mEKJl
	YYGODZw6UUKzLrqdMA3X76notdSuihE9L315wg7pFa2WhbyzTnU1wAsUYx0A+vSy
	+oOPxZTy60XTdCulFWJnzlgRRXoJLDwwM1mJuJ7YdFwJK/oS9PJWHZtQYva7CH0k
	KoDdEpfv9KRqgJjqdP5XNiw/KdvVBjW25FqyYkT0p5w0g7mIwVAToK0CG26oKwA9
	TRJ85tCC6GP+rTbcjTftmGnkyIR3CHUCmC4LIg2JTV7D+kMokft2Z6F2Clp/EY/y
	0qvWdpC7Ewe1s7qVjyRI1T1YXeHOqJm3moQzKTGD20M0wVcv0l2JFCDj56+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762353651; x=1762440051; bh=DufifCwAzF0ocKv3ba9DTzSyYDq04aqF2i3
	0BO1Nw0E=; b=JC7WhiRwliM8sZkMYYeXJ69AuV0wBI5mRwRIQgaaJV7h4dJuvLb
	esduMt0emuJLZczAiCRk3CMriLgS3IzhD755LJZIADh4BXSekPjEJH7EWzICEoei
	k+A7zLKUXkmYLzh5b0dUar5HC0N6WlgEYqOdjFm/HfdcaLo+/AP7CXn2by3org11
	wfcMjnin+RRBM8qRn3ofYLReEQAOX2sn4wuAUR1nE+1EPnXW7UqX2xOWy8DnAWHV
	DjQjBapFy2FpjW26DxlnDXtvOVJkLfYHuyNxqtOMx1MdM2+csHYrhe2RoF/1kLi9
	S9EEbvGiqpB8FK6BK6+HQEp6wloOF5e+SAQ==
X-ME-Sender: <xms:82ELaSn1BH8m6Y3EnOt1bFI1H3ctVfoDO8UfOjPKYXn68VbQWDetqw>
    <xme:82ELaY4zlKeQnnPMWYW1C7D2_EnMVnkKLe1egZwNAdt8LH7tHXuTI99Qwz--_fo4t
    qRycdMIB9Fd9M7qFTounvuf7NiLLQx1fGfPQcwrtAWUA3FpHAMAr6A>
X-ME-Received: <xmr:82ELaW1F4L6oCtq_3-qMs5JhhEShrPcIEuIYPZYKeAntlONZrycsaB5HqsLbPgU8iIJczJfWqkwLgK6WcptnaOYw9KCc3-ySuxSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:82ELaTGbQr9OlADYXnvJiHRHnRXQsk7bLpkikrE9L85zi2W154uwjg>
    <xmx:82ELaVioNP6s13xAuD2lMdO8K6yT-VIZ0XJGHOL0E0CuQsA2K34Qyg>
    <xmx:82ELaWC7gu0DAdStBC2atMs8ibokknxuLZdAbBt_bOMUhfPo6H4RfA>
    <xmx:82ELaXRYRRRYYbiFVYCuQiW3O5WRGZWoWT1RlDc7Qirq2slX55u54g>
    <xmx:82ELaayF10T5WEIQjcjCnXgbT7LHQXWjta4ah7JoX7WMZ1_f1lnStB8C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 09:40:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] fast-import: add 'strip-if-invalid' mode to
 --signed-commits=<mode>
In-Reply-To: <20251105061918.3688870-1-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 5 Nov 2025 07:19:15 +0100")
References: <20251105061918.3688870-1-christian.couder@gmail.com>
Date: Wed, 05 Nov 2025 06:40:49 -0800
Message-ID: <xmqqjz04mtji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> The `--signed-commits=<mode>` option in `git fast-import` allows users
> to decide what should be done when commits with signatures are
> imported.
>
> For tools like `git filter-repo`, it would be useful to be able to
> strip signatures when they are invalid, so let's add a new
> 'strip-if-invalid' mode for that purpose.

Sorry, but I do not get it.  What is your definition of a signature
being "invalid", and what is your assumptions of how accurate a
validity check ought to be?  For example, are you assuming that you
have all the necessary public keys, revocation data and accurate
clock?  Even if you are not changing a single bit in the import,
some of your early commits' signatures do not "validate" and may
need to be stripped, and after that happens, wouldn't signatures of
all later commits become unusable (i.e, you may be able to verify
that the signature on the original commit object may still be valid,
but because the commit has to become a child of a rewritten commit,
in the resulting history the signature would no longer match)?
