Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAA115A85A
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766299; cv=none; b=ExcJE6KwDcV+sq8a0Sdxad9NlmYbnlEShS/KteuLfmw0/jZzefAfkIYIx/+isGzrTNAqZzWT2g6wKh/kW4fzuvXRX6h4vA2ZVg2lpFQH4miKj7gWNJwvYTumy1znFTwhcrzT4kevE5uED9IcLKPBQB/56k/q1znwqik2CIx7Arg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766299; c=relaxed/simple;
	bh=6Y2eix9pz2ys52K3zRLC9AWAH5+eN6vC3+zlXObByCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xs4Su73s8U02JPU7O7Mg1UtR9959LkZxBkoFtE4ZsS1cKd1wZRiaFY2UZ7zB5PXP1Li19oo2gSiLweZCgUqFdZ3V78vPYPCXqG88vD2iYpuooi0o+HGp8RUp0joWRXW6fCazwOyLXeebA9N+voEu7Spof9ujBsEIj85poeC46nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a0Bf8HVR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MnbfMdJe; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a0Bf8HVR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MnbfMdJe"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F24877A00F7;
	Thu, 17 Jul 2025 11:31:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 17 Jul 2025 11:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752766295; x=1752852695; bh=rNzfIscjCQ
	PqQqRKFX1PoTui2Q4PX+MJ92MDpKwkWs8=; b=a0Bf8HVRszw9LIqvC/3n5foR8p
	DWoKNi5JjcIpbOPSteEF395WM1cdcMSg8lMdoUjfvfPqN9JzdDFxFRXXexaszXJN
	3QpTsh+kHfs2RW15m/g8cgbGWBAsl2MKH1h/UeME0vmogiqtYamDEgiLUYMt++r7
	pVMjHB8/bmM7VRtL1sr7gqIhUEKWJEn+chGXIfcHVDKY2Kzxi05LvaRqafvnuJYk
	jeSrzn74Z/kBbmNhvPTcAFZHv0hOuwNDH9xbcpqRzN0OqTCLFVR071hjCszbDssn
	oclQcPna9lFFpGVRco/miEQVprzmCYIoEItRlZLkZ0totSMhbDD8qUZezRwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752766295; x=1752852695; bh=rNzfIscjCQPqQqRKFX1PoTui2Q4PX+MJ92M
	DpKwkWs8=; b=MnbfMdJePyvwpryjR5w0zDmh7ajGedTpBcM08Q8LIDFDnV5GiCi
	BGVFusnkCzSnagyi9uLnTyr+3NrZ39ivmgahK/1JKB9QYMNWFfPITMbycG9m6pHu
	5PixPyHuKyzzOGyXeLGFv5eHFOX/a1ZkbKFBrphjTVazUGsXaZq/j/DIQD9Bm62h
	LX2xt2k6YjqwEhXsZMWq6TI4gqQIJfem8PydV/25EU89N+h+YKsM+t86p6tyW9TN
	CJrNviRqiRksBIbIYJsQ3XKq/XNLcPIHDEu322e0Z/E4DEay+rOCexMRwAHBhHgs
	s/uZdg/eygl2SFRKfmvixnKAQTijU/hzleQ==
X-ME-Sender: <xms:Vxd5aLK6UjPmFNIqPnS5xzWHjG50fwEcJLUF3d92KbxGqKc9eGtUTg>
    <xme:Vxd5aMtFUZGxaIatfqtJFIbCmgROYqNDnsoRXfQJE6AqT-suNE6NlfR6gatQ6rvrd
    dSXMmSB4YyixNtk3A>
X-ME-Received: <xmr:Vxd5aKKHItRjmWMJgd6-8fr4Xs3JSWB6TuuhbzcKmVdKLO_4FxOclQeOgQzjP4_g7zdBx8RbW5Vf0LJ3IKrPY-hG95soff8dblHY-pU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Vxd5aF8gnCWuTJlJobqRdeYUL4Dan31fBpOL73AIxYWaigZG0p6kvg>
    <xmx:Vxd5aDyCcNSomqP83-W8TD913CeE_hqtaU_xfKOB4VigRIOsxJ711w>
    <xmx:Vxd5aC63ExSiPpDPPwwz180sHiGEUEMcTYeXQbIxE7vzNI1zfySNwQ>
    <xmx:Vxd5aK9NyZO7RID-BZk2PxZj9Om1L092wVbYsbajc3kPmXZOzAyeag>
    <xmx:Vxd5aMMZ6u0rJrHXYAcQS2wOiO1eZVKEXN5k5QUAknDKanG1AofG7L5p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 11:31:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  schwab@linux-m68k.org,
  phillip.wood123@gmail.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 5/5] for-each-ref: introduce a '--start-after' option
In-Reply-To: <20250715-306-git-for-each-ref-pagination-v5-5-852d5a2f56e1@gmail.com>
	(Karthik Nayak's message of "Tue, 15 Jul 2025 13:28:30 +0200")
References: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
	<20250715-306-git-for-each-ref-pagination-v5-5-852d5a2f56e1@gmail.com>
Date: Thu, 17 Jul 2025 08:31:33 -0700
Message-ID: <xmqqikjq7s16.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The `git-for-each-ref(1)` command is used to iterate over references
> present in a repository. In large repositories with millions of
> references, it would be optimal to paginate this output such that we
> can start iteration from a given reference. This would avoid having to
> iterate over all references from the beginning each time when paginating
> through results.
>
> The previous commit added 'seek' functionality to the reference
> backends. Utilize this and expose a '--start-after' option in
> 'git-for-each-ref(1)'. When used, the reference iteration seeks to the
> lexicographically next reference and iterates from there onward.
>
> This enables efficient pagination workflows, where the calling script
> can remember the last provided reference and use that as the starting
> point for the next set of references:
>     git for-each-ref --count=100
>     git for-each-ref --count=100 --start-after=refs/heads/branch-100
>     git for-each-ref --count=100 --start-after=refs/heads/branch-200
>
> Since the reference iterators only allow seeking to a specified marker
> via the `ref_iterator_seek()`, we introduce a helper function
> `start_ref_iterator_after()`, which seeks to next reference by simply
> adding (char) 1 to the marker.
>
> We must note that pagination always continues from the provided marker,
> as such any concurrent reference updates lexicographically behind the
> marker will not be output. Document the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.adoc |  10 +-
>  builtin/for-each-ref.c              |   8 ++
>  ref-filter.c                        |  78 +++++++++++----
>  ref-filter.h                        |   1 +
>  t/t6302-for-each-ref-filter.sh      | 194 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 272 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
> index 5ef89fc0fe..ae61ba642a 100644
> --- a/Documentation/git-for-each-ref.adoc
> +++ b/Documentation/git-for-each-ref.adoc
> @@ -14,7 +14,7 @@ SYNOPSIS
>  		   [--points-at=<object>]
>  		   [--merged[=<object>]] [--no-merged[=<object>]]
>  		   [--contains[=<object>]] [--no-contains[=<object>]]
> -		   [--exclude=<pattern> ...]
> +		   [--exclude=<pattern> ...] [--start-after=<marker>]

Not a problem this patch introduces, but as I noticed it, let me
leave a #leftoverbits comment here (it is OK to have a preliminary
clean-up patch).

 * "--exclude=<pattern>" should be enclosed inside a pair of
   (parentheses), just like the way how [(--sort=<key>)...] is
   shown.

 * [--stdin | <pattern>...] should be moved to the end.  There is no
   reason to require "--stdin" to be the end of dashed options, but
   the <pattern>... must be, as they are positional, not dashed.

> +--start-after=<marker>::
> +    Allows paginating the output by skipping references up to and including the
> +    specified marker. When paging, it should be noted that references may be
> +    deleted, modified or added between invocations. Output will only yield those
> +    references which follow the marker lexicographically. Output begins from the
> +    first reference that would come after the marker alphabetically. Cannot be
> +    used with general pattern matching or custom sort options.

It is unclear what "general" in "general pattern matching" refers
to.

    Cannot be used with `--sort=<key>` or `--stdin` options, or
    the _<pattern>_ argument(s) to limit the refs.

or something, perhaps?  It is curious how `--exclude=<pattern>`
interacts with the feature.  Presumably the exclusion is done so
late in the output phase that it does not have any effect?  It does
not have to be mentioned in this documentation if that is the case
as it is a mere implementation detail.  

    Side note.  The limitation that sorting and name_patterns cannot
    be used with the feature also comes from implementation
    (i.e. the name_patterns optimization will compete with this
    feature to take advantage of the "prefix" thing in an
    incompatible way), so while the reason does not have to be
    stated in the end-user facing documentation, the effect needs
    documenting.

> @@ -3189,6 +3221,7 @@ void filter_is_base(struct repository *r,
>  
>  static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref_fn fn, void *cb_data)
>  {
> +	const char *prefix = NULL;
> ...
> +
> +	if (prefix) {
> +		struct ref_iterator *iter;
> +
> +		iter = refs_ref_iterator_begin(get_main_ref_store(the_repository),
> +					       "", NULL, 0, 0);
> +
> +		if (filter->start_after)

The start_after of the filter comes from "--start-after=<mark>".
Can it be true with non-NULL prefix at this point?  Unless you add
support for the option to "git branch/tag", it would not happen, I
guess.

More importantly, when you do add support to "git branch/tag", the
code need to be updated to keep the original prefix while seeking
the cursor to the specified <mark>, instead of clearing it.

> +			ret = start_ref_iterator_after(iter, filter->start_after);
> +		else if (prefix)
> +			ret = ref_iterator_seek(iter, prefix, 1);

We have "REF_ITERATOR_SEEK_SET_PREFIX" for that "1"?
