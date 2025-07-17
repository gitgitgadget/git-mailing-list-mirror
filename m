Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612591DE3C3
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773509; cv=none; b=mCRgSTj6CewXevD3uTc/NtrMaADCiPNDjZaKHO8vn3AP7C8KQd1rgC+WpPjqBiHh6kxtTrJJ7WOhyudUS5c2KT+bHIzrbEnK+7G0lEuInH8qTJULfIQ4zbs06Dg8H5Bjb9OGtVu+hzesnJMOQWjKD8T4n6m+nxrZVd6PTttuTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773509; c=relaxed/simple;
	bh=48yxbcL6DcKPAv0QwRo7y1sJ3K8OlJLdmMvemxQJOqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qXN1gBfQJmk/9AqyW5hYkL3+mzyWhRT0LhdCmXXpgm1e9SrRZlRNiRsX5Mb3VBr5mDyQH9/rRZYDsxHvjyr46OWDBGwLhFGhY8eqVD23c8BYxrkpH076EUwCwMintbbsLxNQOuOLFtMnw326/7saWJmhJ58dA1o2JEmpvi6bR2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AU1j3GGF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QrSPnIqz; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AU1j3GGF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QrSPnIqz"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 608271D000A1;
	Thu, 17 Jul 2025 13:31:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 17 Jul 2025 13:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752773506; x=1752859906; bh=ZqbtNBiZQ2
	q2NVHIqh62cV7EfWVRLYA3KavgyogAKEk=; b=AU1j3GGFfLGCsilIuCzShE9jFx
	UpvphBh9/Tv/hBjM5tQV9XqPoR+XwTY+Ao1kArRMX9S3atGzTck4b7NYuoP0L0Pn
	5bJ6+lcWyJG0WQAe76BjL077wNZL2B69hc/UyQ+pzZwdNik3H4tOKIrHQad98u7V
	cWR65uijHPu2heN7C7WEceXHvTQ+KEU7NenPGidd8qtf2CqsOuFNKdm8WKgh47W4
	YAZ7Q8tu5Ty0k7MsfHi4gn6rXcoa21SYmuNFd4oX9T7/y4JLk/ow8CAuQPj4gEU3
	xJGcetqpA9T0Vefx5i2m6UtZOG2F3f/bSkSOs0L9hpW0IvjnOVAGsUlInGbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752773506; x=1752859906; bh=ZqbtNBiZQ2q2NVHIqh62cV7EfWVRLYA3Kav
	gyogAKEk=; b=QrSPnIqz0gJJRtU7kmXeUnR8QZshGzHHN+g6brZ+ColBbAD0J7L
	eEQ/mXt5/GOd6ivpKj46xbbqk2lUkN/SrNfVvnT9Fign0i/yvMORkR4W9x7kTnJ2
	u3Gsi0eaICcqwxkpljZwfXL0sCPeG0/A7tKdRAL+yjH+W3VFcU3Kw/pQyJNcWRGp
	PXzeBre15wPrQ/5Azy3nObrgw4WJN0eYXZ181YEbuXi2z+ohovMwrlL9PXEEnJhv
	qB6iZKjskRJiJ8qd47/aTTf1in7QYpMsVo+47wzEs82GoV8XK8brTxi6sKB6TUgR
	wAbm+cXMINcEPcpzlE811kcAZk5/s8TwzVw==
X-ME-Sender: <xms:gTN5aK-b_iv2NX3LwAylbXu0iptIqlAKkTA5x6w6_RaCuWErtfXTWw>
    <xme:gTN5aDLeXgvCaSc3jsV2J-AaecqXOV7QJDmOyzKdno9fsUrAL5jObTsg5172wDQrz
    9l43ARHDm8ZTELWoA>
X-ME-Received: <xmr:gTN5aAf3CilBs06MuR6pq4dPNtIm0ygUT4DjpGArWh19DdCEURaaFaw94hl91wdP9Ur-sW0AIp7hR8obu1romkjO4TpdEMN6B9aDbDU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiuddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gTN5aC9HhYYcqXdz3WcrigEldpSqjW54i93o_SSApp3ABPgQ8pRTYQ>
    <xmx:gTN5aNqnN_VtJl5GfE8EU9yipRTY8lk_NbvfyokVA5XJOkUHcSLxNA>
    <xmx:gTN5aHDKgECyL6JQsam1RLugX0tedGSW6dLV2QeRLRNYP-rl_Lv13Q>
    <xmx:gTN5aPzVxOo8pJdsoCSe0sLIxkoVM77vUHnK7p_W9psZ_0JzhB5Q8Q>
    <xmx:gjN5aDfzRmYTsgTl5_gb4utla54mRPJkJo-x9ahxsN7vvPrJOCnr015Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 13:31:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  schwab@linux-m68k.org,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 3/4] refs: selectively set prefix in the seek functions
In-Reply-To: <CAOLa=ZSKsdGDERNS_1hJrBMn0muSOJ46SZz2bn8OHZndJ2Hu3g@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 17 Jul 2025 02:01:05 -0700")
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
	<20250708-306-git-for-each-ref-pagination-v3-3-8cfba1080be4@gmail.com>
	<aG9hMP9gEFLhVgJL@pks.im> <xmqq8qkqvjnu.fsf@gitster.g>
	<CAOLa=ZS6ASf1+nbUnCTeeH1Di=kgmhQUEQ5UXPZu051rfqx9Pw@mail.gmail.com>
	<xmqqms95if8e.fsf@gitster.g>
	<CAOLa=ZTc2_g3+8MM8whW+eZAj-+36HNsnUFDoLgnN42ytFLwAw@mail.gmail.com>
	<xmqqfrevc3b6.fsf@gitster.g>
	<CAOLa=ZSKsdGDERNS_1hJrBMn0muSOJ46SZz2bn8OHZndJ2Hu3g@mail.gmail.com>
Date: Thu, 17 Jul 2025 10:31:44 -0700
Message-ID: <xmqqpldy67wf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> Yes, even though I wouldn't call such an operation "seek", "Ah, I do
>> not need the entire refs/heads/ walked, only refs/heads/feature/ is
>> enough" is an operation mode that makes sense.
>>
>> But not for paging, though.

Actually, you are not using the new value for prefix; you are
unsetting prefix to nothing, so you do not stop when you go over the
boundary of refs/heads/feature/ hierarchy but will run through to
the end, so my worry is unfounded.

Which is good.

But the application has to decide when to stop as "We obtained an
iterator in order to list all branches in refs/heads/ and the last
round we gave refs/heads/main out.  Seek to it and continue the
output" will no longer stop after making a callback with
refs/heads/zz but will continue yielding non branch refs after that.

> The current implementation doesn't
> support '--start-after' and prefix setting at the same time:
>
> $ git for-each-ref --format="%(refname)"
> --start-after=refs/heads/master refs/heads
> fatal: cannot use --start-after with patterns

Good---in that case, "unsetting prefix to nothing" does not make any
difference and cannot introduce any confusing behaviour, as it has to
run to the end with or without "--start-after" anyway.

Thanks.
