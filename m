Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A7285CB8
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218015; cv=none; b=Ik5wRdAwMiwGwdchkWkSVcrTIUXjaedkynn4iYPm0C70UQrv/nBfVmx4aFUgoITyTXa00UdHKXgLCkNN61afv43i+h5Tgo/7Wzdhv7yPI51CjCyPG1fvqko6i+3auQ2q83ozmzKP22DPakxzi1kWydAzLx3cMGl9csvuzp9wcUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218015; c=relaxed/simple;
	bh=LMLlnY7ux/r0bLj5Mj7Wxun6t5nX6YProshPfAHWHAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jn1s/biQ2UtjZZogu+ZeKAqAI+RK33BpNMowv+vm9nIqKRYLPcOIfDoS51Ya/jDPxwDa1XBoNwOkdgMsxePs626gtkhqb90+cDeY6u0fnVR8L4E7sPRFVe/Xv02pIcDKqsL88JhbESVkWEmMnQMPRZNqjxMhJ7vqTml48Mvk0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OKGk0XcK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jQuS0RQs; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OKGk0XcK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jQuS0RQs"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id ED7EAEC0569;
	Tue, 22 Jul 2025 17:00:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 22 Jul 2025 17:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753218011; x=1753304411; bh=3QDLlxHc6X
	ShmblxiEtM5oaJteMCSQji7y5dnZtP7jk=; b=OKGk0XcKggnWyq0AK+ORJx0Ztt
	F2sCuugiZTndU8OPcvo/IvhNMeWE2bdBByu/fhsFFGCUgkx4dP/f0k4SbPxYlu1K
	+7fNF98ufSR7ME5q3CG/8QEXdKgQ0ieIUyv+PpZ0xyobxjVyzExf7WtMZc3WBhd+
	EcykpH+RrHqQvRDzKIT1Z+EfREngtDsHpl1B8Z4W32QpgRFqjxrSM0kDiznEssa6
	ofMHGgZq+VWiwONVzkn04HHJDuT4WrIb9BfMgH4mMZWnk9OhoUXnAOowyp4TEV1w
	v57wE4CdxeQN0libpNATtYkGkELDRV6x3YT7AWos+tJ9anQ1tRZKH0ts+ybw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753218011; x=1753304411; bh=3QDLlxHc6XShmblxiEtM5oaJteMCSQji7y5
	dnZtP7jk=; b=jQuS0RQsoPvsBHvvrf45jjUVEreXesjORzDzKePdCZOlMdBbsV+
	b9TMgd4j+UxUP0QADNYYIbo/3+DBlbEkNiaL3pMgtdHET2/+FMp3FwZ3ZuaKKrtr
	+gi37nEvPT61rvw3RG4AxkZp2J0rfE0ZwONakcZwZj3m5g/1YLOQDT0kr1P+HfEp
	TE0YEH85lfTQ9DwlsGtrAhmTMTBAfk/XcRu6njN5tvRb4vrgfawCh6A7M7Fr3G9t
	eR4OnaJSTO7WSfWJ8rZex4RAFXssxchwYFYCniLtdBaW+OSie4ISEZpnesLi1Slb
	7CYMIJNJ1Pa6x7WPoKosDuLmgKsCL7M2aJg==
X-ME-Sender: <xms:2_t_aJEFQrA0r09bGV4Kq7qc3J8i848vwIGtlimsx40ibyvVhVFEaA>
    <xme:2_t_aI6ysqqoK2rXrA8a-UCVbAHAhSWfxJ8ymML-eSzSMmMV4ZBhUEXdTafme3nzS
    2jzyhNw6y_MNntrlg>
X-ME-Received: <xmr:2_t_aHuoidIyw3jlPxFKRQuAaofu11OwEC4pTjxtWV8EwFhn3JlcfGxZhz0DVpbAPzCFMA5sko7QjamDpx-eBXMJ1RzsZY5QPMDHWhU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2_t_aB50oPpXU2J3jjOm-07eTXXXynf8lLALS9Mn0CGwB-5fhCmYNQ>
    <xmx:2_t_aKWy4jxaD9i7y55jz4R1XzSB98UfmUCC9wbdiXny9pMO9lyYzg>
    <xmx:2_t_aL9hDedmdnMwQOcThpo7HsUy6R7v07B2ADndbOD0eJ7pKj7vLA>
    <xmx:2_t_aOkexT-rI6YX6VcHSwmCwEAexw6492fZkAI0i1TvUowwsWIo3A>
    <xmx:2_t_aAUe9yZEkZwG9VSJyLi9mIh1XqjXCiLku2jOqlpbbtMmGFs8UcJq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 17:00:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 2/2] builtin: unmark git-switch and git-restore as
 experimental
In-Reply-To: <20250722180818.1043014-3-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 22 Jul 2025 13:08:18 -0500")
References: <20250722180818.1043014-1-jltobler@gmail.com>
	<20250722180818.1043014-3-jltobler@gmail.com>
Date: Tue, 22 Jul 2025 14:00:10 -0700
Message-ID: <xmqqv7nkq6ud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> In 4e43b7ff (Declare both git-switch and git-restore experimental,
> 2019-04-25), the newly introduced git-switch(1) and git-restore(1)
> commands were marked as experimental. This was done to provide time to
> make breaking changes to the interface. It has now been over six years
> since these commands were implemented and there has not been much change
> that would warrant these commands remaining experimental.

Remove "and there has not been ..." and everything after this point,
and replace it with something like

    but there hasn't been much change.  In the meantime, these
    commands being experimental has become an old news.  People have
    become so grown to rely on how these commands work, it is no
    longer feasible for us to now make breaking changes to them.

    Let's mark them no longer experimental.

or something like that, perhaps.

> diff --git a/Documentation/git-restore.adoc b/Documentation/git-restore.adoc
> index 96de9bb5ed7..903e8c4618a 100644
> --- a/Documentation/git-restore.adoc
> +++ b/Documentation/git-restore.adoc
> @@ -28,8 +28,6 @@ otherwise from the index. Use `--source` to restore from a different commit.
>  See "Reset, restore and revert" in linkgit:git[1] for the differences
>  between the three commands.
>  
> -THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> -
>  OPTIONS
>  -------
>  `-s <tree>`::
> diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
> index 7b24450f841..1d46010292d 100644
> --- a/Documentation/git-switch.adoc
> +++ b/Documentation/git-switch.adoc
> @@ -29,8 +29,6 @@ Switching branches does not require a clean index and working tree
>  however if the operation leads to loss of local changes, unless told
>  otherwise with `--discard-changes` or `--merge`.
>  
> -THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> -
>  OPTIONS
>  -------
>  _<branch>_::

I think these two changes are OK.  I personally do not think [1/2]
is a great idea.  At least I am not convinced myself not yet.

And if [1/2] were a good idea, then we probably should apply it, and
then wait for another 5 years before proceeding to this [2/2] patch.
