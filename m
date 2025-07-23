Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A88272E67
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753308852; cv=none; b=D2o6nZleOtuXlgSRpJ0gzvd+pBlanCbrJjwqDh2luz9UaHrffPF9/g1FZJeIYLVBmynPymIhbvTfvp0jM7Qj1GFVCKwrn1H3xDgtuBquZe2bEXSana8ejcNGHGu8SpX7vmsNP2rslKsuV2EN8CoyaWg0RuGaPSilcio69uMD8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753308852; c=relaxed/simple;
	bh=a8/ET3S+GbRjFa6H7jcMsgjkeD1lvagE/7nccVnPJPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AhEecDAqHTbJgyL13LvUcHURCCByHzrPqqSdeQHz7EKWPYz+fWTuevM32+pbPP6uum4/QMH6u/MlHTNab3nddW8w79srR1MhTcicZoKHTWHkfDd8QzKQ9wIh6kshSrDhcxEpTCYE3QOCcPZvuqpIg35kSk28C33moFjeSCmEk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IqHBrr5X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZGGYk0yo; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IqHBrr5X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZGGYk0yo"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B9A414023CA;
	Wed, 23 Jul 2025 18:14:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 23 Jul 2025 18:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753308849; x=1753395249; bh=5oUKNh8tph
	G0vfGgM9AT39hYsFyLtDdIEN8AZ8GK0Tg=; b=IqHBrr5XvXapBHJWMQP/KP0YzD
	dymvLaTrETg/evcztQrmaDglo8krkexgu/JbrQTK1Y26xRDeFvclqkcyT6cJoaqF
	/b3QyN0+iuuX3fEaQABmXEKmkeWWS2k/JjqSrlm06MHwJsMb3NKLxIT3BG/l9aM7
	W2DK20S2LXT/KDzHbG5N+8D64wk2JgZI70HCvvLhjQh9Jh9tjtLkTEu4PuWh00Iy
	wfsnFZfjXg3VPcHbpRPlalPL4JOtdS2kENFV92Z4pJbadOhze2MVuwmT/fsaBqxt
	tYrQMl2OItUVL7Dd59Gpzli2dTsYoWZpktVCFg709bpDLyQxq6NBcbdnzCNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753308849; x=1753395249; bh=5oUKNh8tphG0vfGgM9AT39hYsFyLtDdIEN8
	AZ8GK0Tg=; b=ZGGYk0yoRvyL4/JkQGBGWkQLBhdh4W69unOwTzBT8qECWKZ1s4x
	f5Ap2vFkxqvRCaKYhLl+LzgKiDmrfGmbKfQNA6yV9bGUHZzSABCb6m43JPTloi+F
	zsreKacTj9qwZ6hWREKpGbKj3oAbRVgcb9nyM+dYE68sU64LIqk9IUEwqxZiOPCS
	0UhQQEUY7ECbH/Vzil0GktmiaX//+s6bbpk9zm6sLdrDPs1aAeJJg/ou3DYoBJ3Q
	9Ezbzg6iNSLlI5lWgCxARRy4pU0NcmfFYAiLZDzcoYJ7DbTtccabvW0GTvrIpFRr
	oOuaMKajonESS3njuFCZxxyQaQ+6NF5qHQw==
X-ME-Sender: <xms:sV6BaCoTFoRJVexa8wQqDGOI5Hk3fXG608sPA9cnpzNN0cg-nolb7A>
    <xme:sV6BaNmi4rxjtyUz5nP6GuzDGtFL5SdCdjVgtQZAHvEHJOnzXz9_5-szJuxF0-GV1
    4ryZG6h3XVrB4cZqQ>
X-ME-Received: <xmr:sV6BaC1qw80q8zzC_xK65lSiMHn_fcuszTKQAWdKqm-tF_7bl2U9L7IuIfrJ3euGHFUj24bCPGoEBqmkhANKMb0UHdvoFSMiFRKe7rc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sV6BaKQxUz12MY_4YElD7za5qRwMc9ibtnm6GujZr1DayAcVosR0Tg>
    <xmx:sV6BaLx47bZs1ZOmJZK_pmZPP0ECiuEluDCdheL0pUKhXmyqfl4GSg>
    <xmx:sV6BaKCgqBW4Bbcc9KQr3RgVv_oUkIKE2nC7DIsNubij7Ez7HG6H5w>
    <xmx:sV6BaHEEUL9QjI-7sAJ9SeLo-HE8iBm2pvRgUf9V6SUftXlBgJ00KA>
    <xmx:sV6BaGge7V76xXHL0uAZpkPINDxuxgWgpoFTcRQ8a1vaWjRkZ425VMo4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 18:14:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  shyamthakkar001@gmail.com,  phillip.wood123@gmail.com,  ps@pks.im,
  ben.knoble@gmail.com
Subject: Re: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related
 global variables
In-Reply-To: <cover.1752882401.git.ayu.chandekar@gmail.com> (Ayush Chandekar's
	message of "Sat, 19 Jul 2025 05:41:25 +0530")
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
	<cover.1752882401.git.ayu.chandekar@gmail.com>
Date: Wed, 23 Jul 2025 15:14:07 -0700
Message-ID: <xmqqcy9qlfm8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> This patch series aims to remove global variables related to
> sparse-checkout from the global scope and to remove the definition
> '#define USE_THE_REPOSITORY_VARIABLE' from a few files.
>
> It contains three patches:
>
> 1 - Remove the global variable 'core_apply_sparse_checkout' and
> move its setting to the 'struct repo_settings'. Also remove the
> definition '#define USE_THE_REPOSITORY_VARIABLE' from
> "builtin/backfill.c".
>
> 2 - Remove the global variable 'core_sparse_checkout_cone' and
> move its setting to the 'struct repo_settings'.
>
> 3 - Remove the global variable
> 'sparse_expect_files_outside_of_patterns` and move its setting to
> 'struct repo_settings'. Also remove the definition '#define
> USE_THE_REPOSITORY_VARIABLE' from "sparse-index.c"
> --
> Discussions since v5:
>
> * For 1/3 and 2/3, Junio told me that it was concerning to put so
>   many calls to `prepare_repo_settings()` so I tried to minimize the
>   calls and made sure that there's no useless calling.

I didn't mean that the number of places is the problem.  What I
found troubling was that this is not done in any central place, so
it is hard to notice even if some random cmd_foo() failed to call
the function before doing its real work.  For example, shouldn't we
be able to, at least for built-in commands that have RUN_SETUP bit
set, centrally call prepare_repo_settings() somewhere late in
git.c:run_builtin() after we figure out what should be in
the_repository?  Now historically, setting up a repository may never
have involved opening and parsing tons of configuration files, so
such a change may be incurring extra overhead we did not have to
pay, so it needs a lot more thought than just trying to minimize the
number of calls, but some performance measurement.

> * For 3/3, Phillip told me that it broke user-facing as it will be
>   parsed quite late in the callchain and might throw an error mid
>   operation which we do not want.

So has the behaviour change caused by 3/3 been resolved?

A meta-level comment and a half.

 * Please do not use "-- " (that is a line that has dash dash and a
   single space and nothing else on it) lightly.  It is called
   signature line and often MUA pays attention to it when responding
   to a message with such a line by omitting everything after it
   (which is supposed to be your "who I am" advertisement) when
   quoting the original.  Since you had one before the "discussions
   since v5" section and the range-diff, I had to manually resurrect
   the part after the signature line while composing this message.

 * This throws everything in repo_settings, but these settings are
   inherently per repository and they are meaningful only when you
   are working with a repository.  What makes us choose to make them
   new members in the repo_settings structure, not direct members in
   the repository structure?

   Not an objection and not a suggestion to move them out of the
   repo_settings and to the repository proper.  Just wanted to hear
   the reasoning behind it (and have the rationale clearly
   documented, preferrably in the proposed log messages).
