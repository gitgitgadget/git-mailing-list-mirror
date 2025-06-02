Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D82C325E
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878315; cv=none; b=GJdvxgBySEQzU37GDiUNqmac3pdafS+NhTFp0D7Vrgw0LjQy2sDP/1fckEt+1m3BJqkub0ZuXDNtKCzSwk5G8I7ZGKUTP9qi/x4w1FEvWuGD3X2kn49yiJlPxlhtH0UvX39tEzw8Z1kkdyvrFCBJM7bp7OQiygtOnan6GkcfNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878315; c=relaxed/simple;
	bh=Ml3tjwouy1ejxa9O3hPlCwqhZM4GYU2qC2W9ikoh4Os=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SNpSKRYDOyEBwIte+Wd06LGsZ2xWP5GKv5bYNk/0xa6TK0CH9ntc4jREZ2X236tOis3d+gr4EkZCYd78Km9So99IZ78oqU42LlhF0NT7uRr6DKyhw/h4B8VuWbFN/ILQ7hJNrIM0ip6isOvEZB7Ci/vKOsPmyh1Mji3mmX2naVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vT5UGfhF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nmfSCGTk; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vT5UGfhF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nmfSCGTk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 34443114016D;
	Mon,  2 Jun 2025 11:31:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 02 Jun 2025 11:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748878312; x=1748964712; bh=OHVuyBXKRa
	zGd4tGgGfdaZO5U4021LiyltsiAIWH2mo=; b=vT5UGfhFXujXH0jLnKWbFxxjjz
	MHAjzjTvu5n4vIhwS2AGZWJ0FC0cnnNa9ierLvf9ZKeed6z9lsLONwLM7AxioWm2
	rU7cmanQClerPOCqW8mT0nGwoKtNI1dtkv4ns+dzX6KKIgdFZitQgtP3kxVOX/zv
	YjPuTD+Ku7lmY2NLz3MpyooeEZcOs29Bt8Oe0y/tOgNAi82qfy8daa//ZbfunMwh
	R63gK8N5VThrMfeDojhL0T7Lzs9Adl1o5oENhP6bOPQzTH6p3gQKlqgECWLOiHom
	x07T9a/hbUhvgicLLlTpvMYkU8Qzgi1oNk5i8etWADPZ/xTPOK/BVMP6z9fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748878312; x=1748964712; bh=OHVuyBXKRazGd4tGgGfdaZO5U4021Liylts
	iAIWH2mo=; b=nmfSCGTkj+AechmWByF+GIWBgyh8f07AMlQJ9pdx6JcvzJW5i+L
	8w/CiH0VGEwP9P2KuA/RB1J6IqKJXhGyVE+oEemUs7xxPxmBGcv5bF2sC4R42fE+
	gVeC8xkzpLn+gGndfOYQdxVfU0fGi6u2/wvCXzqTj/H5mOw2yi9mSGGEYEefW47D
	GePhwtKXkCV9/Z77EXJcgBJ593vOXfxuhq0Ym+sTImTLZfGjYFthG3yAGJCYS3Xd
	ucJSyh5er417FU8rHraUtVcYBs5PpB+MV9YjqBxRfTh1yRu6jTXDku/ewjMdZoGy
	fAvi9fTl1BvB2oeoTdt/+pTTbA3YDTjpcsA==
X-ME-Sender: <xms:6MM9aPtvK5yK0AlAjnIzO7W_zUzwe6Fcb-wJAa0312MsxouFP5m6nQ>
    <xme:6MM9aAdMdLJCM3usJiSaDxmpjob7UCaN8aeyEGih0O7QEGuMwPgPYcAnHSuhxl6_k
    akFhzqcds7PG7MOEQ>
X-ME-Received: <xmr:6MM9aCwBp5fHq9gCqupBDsGhRlROuMIKU-c4JtaYQ5yz2JG7b0FbJVP8yHDsxQNp55Vls9zX13Q2OxjQJgnVAGgc72r5W-X1W6yl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefkedtfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphhiohhtrhhsihhuphgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:6MM9aONznB6qEuXYN8IMxiiY2WVtmhhXdQoeOHueU3mTNH_nZiFt-w>
    <xmx:6MM9aP8NQ4TkjHb8ZsUkGpWqw15EAT2j0gY2Um5qAA_gnDMDyaJlcQ>
    <xmx:6MM9aOWrGhmL4GqRh0zXuYvSxbaEg4G84wF6ULZjzHqvtzTvtImWyA>
    <xmx:6MM9aAeAhCYfcPz7Z6_kIrLiupmyi5W_5r1PS713fsehcDabX15nFw>
    <xmx:6MM9aOoQMxKaUEAdXraY-lH5BfyyNtSbUC2r8XKiyu0xUNBliQOEc2Fu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 11:31:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Piotr Siupa <piotrsiupa@gmail.com>,  git@vger.kernel.org
Subject: Re: [BUG]: Non-matching exclude pathspec causes an error in empty
 repository when the flag "--update" is present
In-Reply-To: <e790367c-6777-4b4b-97f1-3b3a2cbdb177@gmail.com> (Phillip Wood's
	message of "Mon, 2 Jun 2025 11:07:17 +0100")
References: <CAPM0=yCcOAGsUE8tX-o8ioihr+oWrORD6Tz=WH1OnmhpO+uqrA@mail.gmail.com>
	<e790367c-6777-4b4b-97f1-3b3a2cbdb177@gmail.com>
Date: Mon, 02 Jun 2025 08:31:50 -0700
Message-ID: <xmqq34ciupll.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> git add --update -- ':(exclude)foo'
>> This results in:
>> error: pathspec ':(exclude)foo' did not match any file(s) known to git
>> error: pathspec '.' did not match any file(s) known to git
> ...
> git add -u builtin ':(exclude)*.[ch]'
>
> which will never add any files (the builtin directory only contains
> '.c' and '.h' files). So I think maybe the bug is that we don't print
> an error when there are tracked files and an exclude pattern matches
> everything

I have to disagree here.  The "did not match" error is telling you
this:

    You tried to tell me that you wanted to add something, but you
    didn't enumerate what to add in concrete terms.  You instead
    gave me pathspec, so I tried to see if there are paths that
    match these patterns.  This pattern did not produce any match
    so out of this pattern came no additions (even though other
    patterns may have contributed to other additions).

I think the "'.' did not match any file(s)" in the first example
makes perfect sense, but complaining about negative patterns that
did not match does not make much sense to me.  If I said

	git add -- \*.c ':!auto-generated.c'

and there is no auto-generated.c file (yet) in this working tree,
that is a happy outcome.  I didn't want to add it, even if it
existed, and it turned out to be missing.  It would become annoying
pretty quickly if we started complaining a pattern in .gitignore
that did not match anything, and complaining against "you gave me an
exclude pathspec pattern that matched nothing" feels pretty similar
to me.

Thanks.

