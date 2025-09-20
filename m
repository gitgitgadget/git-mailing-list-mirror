Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7461A2392
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758408200; cv=none; b=JYiqObEVNS+qN1U+Hb9sWulw8p4m54l9OpQizrPsN0gy9a2HdIr/kiJtr2cy4Yo7WdzNZsZQEePiMUB57Q/YLXMJwqYL+SU7x/QOJGMsTDMqPPEe/Bba9HDxYzeeJ3EaHoZyPGNxxVInxrfmr3JAv9xnK0xveP8UJwx/E7eTX60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758408200; c=relaxed/simple;
	bh=/UDpoRxqrrorDtpfzseFp+ucTg/c6LVOMjFxgtbhpy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hI1kfbNcXqkjMp2fGv7AiAX04I/CGxIIYFnHBF/+IxbV9F0xq0/g+r2J4RYvvb8SLhwdJTqJ286BvYywsRbRw2qdxiV8B6c09xelcFI2RFyY5kZnGpEMXr/IL7+iBDOzfldFqU+pXvrez7i174Nssp/r0Udvex0neKnJ+HZifu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YMhOy+v+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJfG5Mry; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YMhOy+v+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJfG5Mry"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A5F397A0096;
	Sat, 20 Sep 2025 18:43:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 20 Sep 2025 18:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758408196; x=1758494596; bh=0E3UqUlNB8
	WELj8LjWhQpmTf/ZmyAih9vT5u5nj7X/M=; b=YMhOy+v+LOKxy4aII5rBOIAZn8
	WwICBRZe3z/FfPeajjkFoczu5SAoYIlhiQUNqWqdNWozqFU0JjyYN80enPdOgn6D
	F6Mwaqyd4r4uFoQ3BC0EpqFjL5OUPBkwwrWyICy9C/fj01Pi2CUvzWaVkypE4zUP
	3c+jTspcRnUzFCQf7AwBNgepJKs33Y5Axyt0E1HeS5l9DK8nVh+86nLwdhq8minR
	S1alWvyJfOjS8ByK9GTT+6+JEqOnSAfcNsqe/RINzuY21Pg/ti3rslAxIf9VwkGI
	DsEbJRLKMH9aZJNcCSCHFj5dGvLlSZAiGjnrSe+Ny/wBa8KBYfS84RbMpasg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758408196; x=1758494596; bh=0E3UqUlNB8WELj8LjWhQpmTf/ZmyAih9vT5
	u5nj7X/M=; b=OJfG5Mryus4dOuOKzhfOMc/TsLEi3e+bdISMyFV7s0DDsNezDXi
	a6xYwa00XM9QWsTmS7k1MRJSAGppOWUo5dXIaK6OpNduw2+FslO7l3uz6u+rSL/b
	FLKVtKC/EBFFxQvApFZJfigsuEtZQCw6AKOxt1BTXxYOwlOjd/nKeW0QWiyjKjOd
	/VxJy96Mp2HURll2WjmfRGYEGUbudZtFh5sxXcpmrgwjKPHM3iJ+rnhaNi0/q/XT
	CKB9jmTP/8HCB+MolpfYt4+7Sjetv+lYx8bhFXalonoLwCsCJXBONd8VFfwFxp6K
	dH6Ps4hbbvf3qGsTq9paxi9PFFQEWP62xzQ==
X-ME-Sender: <xms:BC7PaC_ZVbXS9FRWxyC4lhTq3SRJ5YRnE4_ZTErKWCabx4A3ZgjVig>
    <xme:BC7PaASPRTvl84H7UvZ6X9m0EqtNljXu_qu4W1Rasgr67xtyOfh-cj3_VkviTCq6Y
    bnTatkEXVfnMWjt3w>
X-ME-Received: <xmr:BC7PaOfqepnSpoJrCzvrlS0pO7emw88x4Je8QTl9BBsW_8ormfVMaVrPKbp9t5uChEuAKBVS29jUsR1UIEuaKkoS2T8QBX-Gcq4X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehfeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BC7PaMBiCu-cIuKQJrFuhNEPbumkQlFmx3u9FdSC3_DufS3rpf0K6A>
    <xmx:BC7PaInrcfecPY49h3dVzUxXUQqBlBgJmAU1PVjulJHWEcHP1sY8IA>
    <xmx:BC7PaPe6RBkMCoZm6DCE5EBS-id3lKDv4jOj8T1fS5K_03nKdk_TQg>
    <xmx:BC7PaESAWp5BpQbSPLDa3UEB0yhHOlY1gtJ27jqfufqPI5Mua2c1uA>
    <xmx:BC7PaB_VgKoWQp3_r98P7VhSOktI1zBAbS9cbH9pOxCb9UiYRu2A_5-U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Sep 2025 18:43:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,  Ezekiel Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 01/10] xdiff: delete static forward declarations in
 xprepare
In-Reply-To: <CABPp-BFJPdVkA0U14_B_EzTj6rAi3jPFcQgW2uPqSz1ZBOdKAQ@mail.gmail.com>
	(Elijah Newren's message of "Sat, 20 Sep 2025 11:31:23 -0700")
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
	<pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<784cffcef564b31a32c401b35f33610b85126f7b.1758294992.git.gitgitgadget@gmail.com>
	<xmqqh5wxxcwq.fsf@gitster.g>
	<CAH=ZcbDzBvmzE75-7-BresWG0tYW05-1G-cnT+FLeuJe6JStcA@mail.gmail.com>
	<CABPp-BFJPdVkA0U14_B_EzTj6rAi3jPFcQgW2uPqSz1ZBOdKAQ@mail.gmail.com>
Date: Sat, 20 Sep 2025 15:43:14 -0700
Message-ID: <xmqq4iswyccd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> Huh, I have viewed this patch with --color-moved dozens of times. I
>> think CLion (My IDE of choice for C) "fixed" that for me, and I didn't
>> notice until you pointed it out. Elijah missed it too. Maybe my
>> terminal needs a more extreme contrast, so it's easier for me to spot
>> things like that.
>
> Yep, I did.  In fact, in v1 of the series Ezekiel didn't call out the
> --color-moved thing, but I used it and mentioned it in my review, and
> Ezekiel decided to mention it in v2.  When I looked at the
> --color-moved output, I saw the sea of purple and blue and skimmed
> quickly to verify it was all purple and blue -- and apparently didn't
> see the one red character amidst the purple and the one green
> character amidst the blue.  Since the range-diff showed no differences
> to v1 and I had already thought this patch was fine from v1, I didn't
> look at it any closer.
>
> So, not only did I miss it, but I missed it despite being the one to
> suggest that flag after using it myself.  Oops.

Heh, no harm done.  With enough eyeballs, these little things will
be found ;-)
