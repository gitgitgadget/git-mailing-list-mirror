Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7E1CEADB
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372908; cv=none; b=jnlU7wvBGJGncJ8yKRCsPrJfQUCra8/1NtsCVIK2is/z2JcgD7qK9NB6oWRgYkB2ZiYbb5mf4H2REkZdiL9grWIxtWDpGLon+80xnMBeSOv0dcZ9ZH+rQ7dGqs7j0woLeAS7Qua1lF/OJhpzTmFgxKTMrFHOwRIIulpUnZqjHfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372908; c=relaxed/simple;
	bh=kgcpgBZB1npv8VfjXc7GxHHVm2NEhH7FyKQJz7XfZqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FJuIMJWlw7oLfty9M1pWAHgHQHJk22CgtWK5HOBl+nLltazKi4nU/HcB2Ft8XWpZqvoBjQJo2yts7exX+ta7UBubOWNR8Z0ZerehnqX734KNIjrkvselEF80PLu9/6x6Sc8oTKDqWI5mxwoT2L7xCc2N9TF6pfjyyxdoos8ZT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DGHpDd9k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f5Q3WJSl; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DGHpDd9k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f5Q3WJSl"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 48ABE7A00B1;
	Thu, 24 Jul 2025 12:01:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 24 Jul 2025 12:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753372905; x=1753459305; bh=GOdYipQA19
	qHoaCdqKuCxBGdE8tcUuRHDrJo6cW6IxI=; b=DGHpDd9k6/KqD/CjdPPCkqsYJ0
	hRhjBtNloACJOocM+kSuxrLrShJURUaC/hdqhYapkb6yu0JDK9IkBEs1NS4IaEKw
	pJYhnV9VRVwlMCwHLqqmTQiAjmapx0JtoPDAlKgWWGdOj2Z+CI9FL4LGhXOFx2SQ
	WV7nROd0hBX9ZZcTtXAG9QWjntEwd96jDrnwYjlmIT/wvorla0s/TwkHE59gKc1L
	7RFX8Dt50pyVsWxC629GlAuTu8aUnXfBANv7zheeeHwjNhxJjFHsSpQ1cvlmMrw7
	2BRbtdRqPY+O/peiDfDSBBhewLxPfZfS0HSzXX36bdvIwL0xoQRqAs48xFvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753372905; x=1753459305; bh=GOdYipQA19qHoaCdqKuCxBGdE8tcUuRHDrJ
	o6cW6IxI=; b=f5Q3WJSlKbWLneZwg+A5pL3LzBZ9QGf36IcWfG86R2uqkZUTHrQ
	h+FstHpoqqQJejblzI3PjDRpdMQaOHlqOqGep9JrZVlFTZp4sykxP9csDLwTBjZD
	la96NO4kXvRjGe0tFcWO5hqoZiST5CvWLAQxbEsp6X5OBFESY77y2wkQ2HIxdhdD
	eTZnjfA8t5b2Q4bRw5kdXQDx1J1KGxp+wW3Ksd72ni3OSC3fxlXLMYu/5QeR54fI
	Xf34+nxq9QJuf6J0+zAFN++hVj5C3CX/YmOSwWskfxROv2XW6689CBL7Cn03LNNP
	M/lDUOvJtpXl9XuQbgD1tIYWspnKfxlyvFQ==
X-ME-Sender: <xms:6FiCaJjzSgX61-oHqfyTBI-emOaX8DHf3U_HGSEK4_eFKg9iI5Mvtw>
    <xme:6FiCaJuAimv01aQ_b1-6UkGEBcxhg0TlSgXYDPMKoqLZjyLcSTnfpViA7v4UXG92r
    Ez3OzGULyHlv7HimA>
X-ME-Received: <xmr:6FiCaFgF3WLNAO_gvEqV-wNnQR9rFYTL39jUB3av-mVsycF2ydveGzOqmAlpGM-3oaJFMrW7vhU6Hn5TKzd8CAlYn3kt7CaYYXAw3Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekuddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunh
    hshhhinhgvtghordgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpth
    htohepvhguhigvsehgihhthhhusgdrtghomh
X-ME-Proxy: <xmx:6FiCaHYuJkSFB0G7KnKKb50-5Afo1wy5cgx0Zr0AraHg0yQMvkjaCA>
    <xmx:6FiCaMZDylPe2gl4EyNLqfM2IleRczeOcLFjYNqj6fI3CevArAyhLg>
    <xmx:6FiCaEwoSyhCGroCXliYSun2SwpLCCsOISZVMpEnth1kM4tC0zO_sw>
    <xmx:6FiCaAeBtn7Bm6LQ_N6VvDWDxOq5_EAAH_rW5nUCvVB7wQRIE8jnHQ>
    <xmx:6ViCaPLYz3g0qoZhs4tfPRs2x_9liOf-uHUM6OV7tfQiwS_F5vxPWx_v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 12:01:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Meet Soni <meetsoni3017@gmail.com>,  git@vger.kernel.org,
  shejialuo@gmail.com,  karthik.188@gmail.com,  sunshine@sunshineco.com,
  Taylor Blau <me@ttaylorr.com>,  Christian Couder
 <chriscool@tuxfamily.org>,  Victoria Dye <vdye@github.com>
Subject: Re: [GSoC][RFC PATCH v3 1/3] builtin/refs: add list subcommand
In-Reply-To: <aIHLdkhdVNy72Yf-@pks.im> (Patrick Steinhardt's message of "Thu,
	24 Jul 2025 07:58:14 +0200")
References: <20250717075009.26262-1-meetsoni3017@gmail.com>
	<20250723064313.29866-1-meetsoni3017@gmail.com>
	<20250723064313.29866-2-meetsoni3017@gmail.com>
	<aIHLdkhdVNy72Yf-@pks.im>
Date: Thu, 24 Jul 2025 09:01:42 -0700
Message-ID: <xmqq4iv1k26x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jul 23, 2025 at 12:13:11PM +0530, Meet Soni wrote:
>> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
>> index 5ef89fc0fe..f7bbc1902a 100644
>> --- a/Documentation/git-for-each-ref.adoc
>> +++ b/Documentation/git-for-each-ref.adoc
>
> Tiny nit, not worth a reroll by itself: it would have been nice to move
> the extraction of the common options from our docs into a separate,
> preparatory commit.

True.

>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> index 3d2207ec77..d7d8279049 100644
>> --- a/builtin/for-each-ref.c
>> +++ b/builtin/for-each-ref.c
>> @@ -16,11 +16,27 @@ static char const * const for_each_ref_usage[] = {
>>  	NULL
>>  };
>>  
>> +#define REFS_LIST_USAGE \
>> +	N_("git refs list [--count=<count>] [--shell|--perl|--python|--tcl]\n" \
>> +	   "              [(--sort=<key>)...] [--format=<format>]\n" \
>> +	   "              [--include-root-refs] [ --stdin | <pattern>... ]\n" \
>> +	   "              [--points-at=<object>]\n" \
>> +	   "              [--merged[=<object>]] [--no-merged[=<object>]]\n" \
>> +	   "              [--contains[=<object>]] [--no-contains[=<object>]]\n" \
>> +	   "              [--exclude=<pattern> ...]")
>> +
>> +static char const * const refs_list_usage[] = {
>> +	REFS_LIST_USAGE,
>> +	NULL
>> +};
>
> Shouldn't the usage strings for git-for-each-ref(1) and git-refs-list(1)
> be the same, except for the command name?

A great observation, but where would it lead us?  Something like

        #define COMMON_USAGE_FOR_EACH_REF \
                   " [--count=<count>] [--shell|--perl|--python|--tcl]\n" \
		   "              [(--sort=<key>)...] [--format=<format>]\n" \
                   ... \
                   "              [--exclude=<pattern> ...]"

        #define REFS_LIST_USAGE \
                N_("git refs list" COMMON_USAGE_FOR_EACH_REF);
        #define FOR_EACH_REF_USAGE \
                N_("git for-each-ref" COMMON_USAGE_FOR_EACH_REF);

is very much desirable because we do not want the options of these
two commands drift apart, but it does not quite work with the
current usage_with_options() infrastructure, as it leaves the
indentation of second and subsequent lines up to the caller, and the
display widths of "refs list" and "for-each-ref" are different.

>>  int cmd_for_each_ref(int argc,
>>  		     const char **argv,
>>  		     const char *prefix,
>>  		     struct repository *repo)
>>  {
>> +	int cmd_is_refs_list = !strcmp(argv[0], "refs list");
>> +	const char *const *opt_usage = cmd_is_refs_list ? refs_list_usage : for_each_ref_usage;
>>  	struct ref_sorting *sorting;
>>  	struct string_list sorting_options = STRING_LIST_INIT_DUP;
>>  	int icase = 0, include_root_refs = 0, from_stdin = 0;
>
> This follows the same pattern we have in "builtin/blame.c". It's not
> exactly pretty that git-for-each-ref(1) is aware of git-refs(1) now, but
> I think it's the pragmatic thing to do.

Although it is yucky.  argv[0] can never be "refs list" unless you
are calling this as if it were a subroutine by hand, which is in
general a no-no.

cf. https://lore.kernel.org/git/20171010040604.26029-1-gitster@pobox.com/

In this particular case, it is not like calling cmd_merge() from
within a loop in cmd_rebase(), so many reasons against such program
structure would not apply, but it would be prudent to leave an
in-code comment to warn others not to mimic this pattern in general
case.

>> diff --git a/builtin/refs.c b/builtin/refs.c
>> index 998d2a2c1c..41e29d1b5f 100644
>> --- a/builtin/refs.c
>> +++ b/builtin/refs.c
>> @@ -13,6 +14,15 @@
>>  #define REFS_VERIFY_USAGE \
>>  	N_("git refs verify [--strict] [--verbose]")
>>  
>> +#define REFS_LIST_USAGE \
>> +	N_("git refs list [--count=<count>] [--shell|--perl|--python|--tcl]\n" \
>> +	   "              [(--sort=<key>)...] [--format=<format>]\n" \
>> +	   "              [--include-root-refs] [ --stdin | <pattern>... ]\n" \
>> +	   "              [--points-at=<object>]\n" \
>> +	   "              [--merged[=<object>]] [--no-merged[=<object>]]\n" \
>> +	   "              [--contains[=<object>]] [--no-contains[=<object>]]\n" \
>> +	   "              [--exclude=<pattern> ...]")
>> +
>>  static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
>>  			    struct repository *repo UNUSED)
>>  {
>
> Hm, this one is a bit unfortunate though, as it feels like it's just a
> matter of time before the two `REFS_LIST_USAGE` defines drift apart.
> Might be worth it to move them to a shared place.

Yes, but see above.

> Alternatively, we could pull out the logic of `cmd_for_each_ref()` into
> a separate function that also receives the usage array. Not sure whether
> that is worth the hassle though.

I was also wondering about such restructuring of the existing
program.  Before adding a single line to support "refs list", can we
move much of what cmd_for_each_ref() does that is common between it
and upcoming "refs list" into a helper function, and make
cmd_for_each_ref() to call it, as a preparatory step?  Then a new
"refs list" implementation does not have to touch the implementation
of cmd_for_each_ref(), or call cmd_for_each_ref().  Which would give
us much cleaner implementation, and we do not have to leave an ugly
comment "we are doing this because we want to introduce 'refs list'
synonym that behaves identically and calling cmd_for_each_ref() is
the easiest way, but do not mimick it! It is an unacceptable pattern
you should not follow in more general cases".

Thanks.
