Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611B27B32C
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901330; cv=none; b=IxW0JzL3Y59MJZw+Y2iBAAWbFaFR2LGfzYDHtmqCGcOymjv20GOzisAV589pDhmbwoAGxv/HNB+ggeO3hMkx0iy2ZWOyqI2PzPdgtcWRdCCotwSQLp3/atvRGwq2r24KUxixDujx/Knyr//ZTapudZuExk28yvWVQR+NnA+zAz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901330; c=relaxed/simple;
	bh=8IfMvJLeCXnXNTDso+TZSOzK1VbaNNRAX7sxiMwt3JI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LGnuxcHcGx+yIdOXXEgzUlxQEZBuHJg+NNxFDpMpnynFViohr9W27NmdT6WnavSwtYFxRzp9L5/u67vNVIcG0NnA56VOO4SqOTI4QI5ZQwLw/qVm7um8r11IHtOKnFUNLtd0bIiQdg1QzYapL/EpKQB+bPxGO2h54U3WqcK+pXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tk850W0W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jb2OPjmf; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tk850W0W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jb2OPjmf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD25714002DA;
	Mon, 30 Mar 2026 16:08:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 30 Mar 2026 16:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774901327; x=1774987727; bh=Xsr3ox8t2K
	A3gca8tqBoXRCamwyjGGY5wftu0yn/wnM=; b=Tk850W0WVzIH6c7WU/EVjpqwg9
	jpGJ3Ms96CiUP+CZE3umF++JdDF3459mqCuWPRXtASsqZVYZ8VhPNOiSbSoQCx3y
	DrVAETqZNL+M5k49m6jkUwY+ffs7hruW8R375gm+27yfj+yj1Wgc99i0NWF1rdra
	L0PsQ1YMfUmYdV5MkJNIzbYguBhj1wLG6qv49J9PVuop89+n/20vNkbr4wuOGjdR
	INvEMjec25RGSenyPaHGKS1I3boBhJR2iT2vxpwuEQkK69UOzi9Ae0lXXWkPz6NX
	cbTMB7WUBUiD7RCQzLeFAdtS5PWZ9YMTvuBdfm2suAPFt+OTAqyseZfG3XAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774901327; x=1774987727; bh=Xsr3ox8t2KA3gca8tqBoXRCamwyjGGY5wft
	u0yn/wnM=; b=jb2OPjmfL8ILU8qJY/9thakNcMy019re6zdRgLaJYg9VE6M5KCL
	URSwxyF1j7xiVzPlz8O67B9cNWZBU+CaZABO53ZjdZFTbkaK+XmgQR3OcstYBjXt
	qnOcWBqtIYUz576NRjCGHYjH4ip7BQ3VQdIgyCEt/oiscxW/FQBV+BXmTjbSh/CS
	qiR27A8u3MPe8uWMvhHuxf4P//IDR0G2r5IBcCFcd7spFkufN9bAV7TD0Rh3u3lS
	ceNJkTws1uRlEkRmq2PbYal5CCyJ+qDFcBakL8Veib++x4YzjUpQDWVkwgp21ZYc
	nJkxIoQ8/T8DYhoaN9Vi8fvzff4z/OgPjjw==
X-ME-Sender: <xms:T9jKadypTc4WtRmVIxosZVjE7x_n-cvLeB3oqujp6kVfY9_ApybYjg>
    <xme:T9jKadZ7Dgfo5W4zhAec2K0pZvq3pLbCcqI6bTlskyTqQuFS766CD8XWNK0ZOjFgk
    V3Q7Z0lHVlU7jBh9o6nAHQZQSCM9dJfYaJnzOZx2FXPGTGhnDmP9g>
X-ME-Received: <xmr:T9jKafQHiC8cNIAiMtlsMXMbeW1NR0gFdnrQH6ehZ90_Vdctw7ztxjR8hpozK5HGPXkUn3rVYcYpLRlKgrt19xdCDNNu4XJ_7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopedvgedtjedt
    jedvuddtfeejsehsihhthhihugdrshhiuhdrvgguuhdrihhnpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:T9jKaXxbL8RfcthIpNWIKK2n_kJs8sLYrp4A6NViQvKMmgHQKGmA6A>
    <xmx:T9jKaZ1plWCJ9FReYRATl8T8AuQ_YQUrnoN6mmxoegqhQLMz6PVZMA>
    <xmx:T9jKad4TXbjX1ulO3VRGyXdAZYeP62RZkmQk6UlvjXhXy_OEN3laBQ>
    <xmx:T9jKaUUfZKFZ2KtVZtT9dWVvAlVxd_g-KSg1702VVLeqO7RCRZ_kNw>
    <xmx:T9jKaRbel5H4zuSmA5sgNwCZe2mgb_6dHVHfdCxY4GNo9YA-FS5-jIEM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 16:08:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Smaran Jaianand <24070721037@sithyd.siu.edu.in>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v3] bugreport: revert incorrect usage message change
In-Reply-To: <20260330174131.456-5-24070721037@sithyd.siu.edu.in> (Smaran
	Jaianand's message of "Mon, 30 Mar 2026 17:41:10 +0000")
References: <20260330064454.76833-1-24070721037@sithyd.siu.edu.in>
	<20260330174131.456-5-24070721037@sithyd.siu.edu.in>
Date: Mon, 30 Mar 2026 13:08:45 -0700
Message-ID: <xmqqldf9dqr6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Smaran Jaianand <24070721037@sithyd.siu.edu.in> writes:

> Revert the previous change to keep it consistent with documentation.
> Based on the feedback, the usage string is intended to represent command syntax rather than provide a description.

You really do not have to post a patch to revert something that was
rejected and did not get applied anywhere to our tree.

We frown upon a patch series that makes mistakes in an earlier step,
only to fix them in a later step.  The "git rebase -i" command helps
us pretend to be more perfect developers than we actually are,
whipping your patch series into a shape that builds one small step
on top of another in a logical succession.  Such a patch series is
easier to understand than a history that faithfully records all the
stumbles the developer made until they reached the final solution.

If you rebuilt your changes, while removing any parts that shouldn't
be there, in an effort to pretend to be a more perfect developer,
sometimes you might end up with an empty patch, and that is OK.  You
can just send a message that you are retracting the earlier patch
and everybody would understand.

Thanks.



