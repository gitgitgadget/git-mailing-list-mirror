Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E921F09BF
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764670; cv=none; b=VkKSJlUU2eAqh0jnKWf40Hj97oHTFvZE0iosEAVRUE0WKGquSSYpHwO9XI30ngR+0GP5ALjkkvRSI0gLQwhNNidt9RbdyjxUxoXi4hFkp030sUn95en3Q/FmVhghPW9RzposloTkHy0s+GYUY5JuH9MYqKaLYsdpWkF3XcB8sH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764670; c=relaxed/simple;
	bh=JFvOm6wv35b8bOasvcEoLA3xyif1qI3QWICjQ5noCDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=madOHZfAeTjEdWifdBThVdCkUGfVFQI1g+wAjR56EF5d/2Ee2KHjguvpfQZtgEGWgKkEQJpBmUSF9e2osmL0DQGQkbie42FCeLAQ+RTuKPwzHsfhOkwHEc5zdnXPIpdQtXScatarRp+Kx0TdBISO7iIaIabZ23dPuA4kv1gnK24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hxklCVVE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCgAsUob; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hxklCVVE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCgAsUob"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id ECEDB1381DC1;
	Fri, 28 Feb 2025 12:44:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 28 Feb 2025 12:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740764666; x=1740851066; bh=2aaCjXHbzF
	ra6HWGaZps5yGsUka6GUYumDoLsIepvyI=; b=hxklCVVEaQSqnXeAN/lRaz/aJn
	q8D72Imnz4GrFOwRBoeLbd57Iza2nYVKr0tvWaKbyH6+LSp6sSMCewX99D77StVC
	lNt0X+3x03YFpEBT7U71MBIle7iE3Q5lw4rmQam2K8UE2XgNErtuNVnmIbLaXHeC
	mTF00vOCk7F+Meknt07Eo8qQGKqa4kM4DP1G4Bebi+AhlSk9Ez0dmIJPdhWMSAZ9
	dEEulYi8iLHVePXd7KbQwfSg6h2PCg9xbxxQUslaogXtXgXFPqKZ07+bmOmpMip7
	U3dV5XZZHADJSxOKimUCqg7BGNi3rc2qj8f2bd3jKa2PCDashUWHF5azUylw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740764666; x=1740851066; bh=2aaCjXHbzFra6HWGaZps5yGsUka6GUYumDo
	LsIepvyI=; b=cCgAsUobyBratsap71xgK5mxzJtvnjQc5Y4xjSaRbpY8b0IlqtM
	Rz+VPGOwb++drZhjSdN2TRDWo/+MYYdkiTa0T4yZku74Cne+EuOpTq2GUm/owskS
	G5KfUgLgXhG6cPBi1HwcBq3ol7uKRqOlqenJXtmWpOsdQGHc9kGO9myokvmFn+XC
	+oo+ndRwiUNAkbEHgGZxnYeULl56lvPR8JuIvhpbvwdmcmBfBeiTp9/n17lgg1CB
	rN2zWQS2m48bUJA4UTxAYzKnZgglSlfo6hlmt63A7YQu6fGGHtsZqqDPs0uf3xGw
	rCD0e9QS3M0ehjLyxpl4uRzCf8/+8rP2Y/w==
X-ME-Sender: <xms:-vXBZ0YT1JI9WYR2XyQlLmF8QtiHoQWNIim9WeyFrUdbak3hpjoo2A>
    <xme:-vXBZ_Y0G85U1ZM089Xp4W4Pk-Max1eIprCX51W3j8NaDgacAP9WnVJkJuIsO6Xy2
    s3DNMLLzF-bbiBtIw>
X-ME-Received: <xmr:-vXBZ-_oUlHRkGjPgQGLq7zr9aGsf1YKbmXq5u-rFWL9KwLFV6s0CZJNKN5v3r8UrQJCx8kcNNedvhTtKKHbE2P6JAU6oRqEI-Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeluddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:-vXBZ-pTy2Anq0lt3zqR9UshlWah3rPoKYw0nS47LoJrnR5ZaeGcXA>
    <xmx:-vXBZ_q68mdKhRmmqeLRYMYH12ddVvylJ_ExDKNOJD3sN0uP2OUMcQ>
    <xmx:-vXBZ8TUtAFiseINGSUi5kvXNi51KkN0HiGOVlGYbAF91K7UjDByXg>
    <xmx:-vXBZ_pAdMA8Vdc2WgMhXS3DRLV1ikdqjQcd0No6Qw0PvIOJ_RXPxA>
    <xmx:-vXBZwCh4D92PqaouGmwWy2bejg6_wYbExZvzU_id52ey9WPoZ-VO33l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 12:44:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/9] builtin/cat-file: wire up an option to filter objects
In-Reply-To: <Z8GVKLee75GDG2S4@pks.im> (Patrick Steinhardt's message of "Fri,
	28 Feb 2025 11:51:20 +0100")
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
	<20250221-pks-cat-file-object-type-filter-v1-2-0852530888e2@pks.im>
	<874j0graug.fsf@iotcl.com> <Z8GVKLee75GDG2S4@pks.im>
Date: Fri, 28 Feb 2025 09:44:24 -0800
Message-ID: <xmqqikou2ccn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > Note that we don't use the same `--filter=` name fo the option as we use
>> > in git-rev-list(1). We already have `--filters`, and having both
>> > `--filter=` and `--filters` would be quite confusing. Instead, the new
>> > option is called `--objects-filter`.
>> 
>> I'm not sure I agree. I would rather have consistency in various
>> commands. Because `--filters` doesn't accept an argument, so I would say
>> having both `--filters` and `--filter=` is fine. I see in various places
>> we already use `OPT_PARSE_LIST_OBJECTS_FILTER` which defines the option
>> as `--filter=`, so it's pretty standard for several commands. I'd
>> prefer git-cat-file(1) to follow that as well. But that's my 2 cents.
>
> I'll wait for a third party to chime in as a tie breaker here :) I'm not
> feeling overly strong about it, but still think that it's just too easy
> to get wrong when those options are so extremely similarly named.

$ git grep '^[^a-z]*--filter' Documentation/
Documentation/config/gc.adoc:	`--filter=<filter-spec>` option of linkgit:git-repack[1].
Documentation/git-cat-file.adoc:--filters::
Documentation/git-cat-file.adoc:	`--filters`.
Documentation/git-clone.adoc:	  [--filter=<filter-spec>] [--also-filter-submodules]] [--] <repository>
Documentation/git-clone.adoc:`--filter=<filter-spec>`::
Documentation/git-clone.adoc:	`--filter=blob:limit=<size>` will filter out all blobs of size
Documentation/git-pack-objects.adoc:--filter=<filter-spec>::
Documentation/git-repack.adoc:--filter=<filter-spec>::
Documentation/git-repack.adoc:--filter-to=<dir>::
Documentation/rev-list-options.adoc:--filter=<filter-spec>::
Documentation/rev-list-options.adoc:--filter-provided-objects::
Documentation/rev-list-options.adoc:--filter-print-omitted::

The above does makes it look that whoever called their invention
"--filters" when they added it to "cat-file" wasn't paying attention
to make things consistent, but that is not the case.  The word
"filter" in the context of existing feature set of "cat-file" has
ALWAYS refered to the act of applying the "smudge" filter chain to
externalize an internal "clean" blob object contents for the working
tree representation.  We should thank that somebody for not using
and squatting on a shorter and sweeter "--filter" ;-)

"cat-file" should call the feature "--filter=<filter-spec>" like
everybody else does, or the feature should not be added to
"cat-file" at all.  Unless we are willing to rename "--filter="
options for _all_ existing commands to "--object-filter=", that is.

In retrospect, such a longer and more explicit name may have been
nicer.  But given that all users of the "--filter=<filter-spec>" are
about object transfer, it is understandable that we didn't invoke
deliberate redundancy when naming the option.  Historically,
"cat-file" has always been "give me the contents of the object I
name", and never about "I may ask about many objects but do not
answer requests for objects chosen by these criteria", so it also is
understandable that we didn't redundantly say "--contents-filter",
too.

Am I third-party enough?
