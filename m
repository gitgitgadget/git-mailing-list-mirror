Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F197726E6FA
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507925; cv=none; b=Kor3VvWy1wjCxH3fk6q570/CqELoVOFvMHyrR7Rf5XXzv77i7MPtDbh7zilsBR5bamCNxSZUCIESsK8DB688wgVTZtjEpCRXz1HNn5uETjj0jszFN0Z+9c4nY+z2lYPMGpI3W3lVR9K/Ft/iSpHPbT54/Mc4pIAW2HmDdZYt8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507925; c=relaxed/simple;
	bh=i+hcqOYibcagNQw/I5OdeiVeb3PWzgMn1IBnpJZ6pyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vc/PASbvWyFzBLY4cXN4Tj6x+i/o1v3EYAgutEqIt/LZLZnfsCKLVDFcnTtC2NSwUYbuP4i3oUvg5cvXUQGVsnR43sghtZZzz5JGqhye4N5sQPWdH70hxMYjQyBVYbyk1MiUxa75APZDCduGRkJtKUu8Jyv4hgToO0yPhIzOUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EIPgk6ZY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l4I9TY/O; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EIPgk6ZY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l4I9TY/O"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16D3214000B7;
	Fri,  3 Oct 2025 12:12:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 03 Oct 2025 12:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759507921;
	 x=1759594321; bh=mp66r2owFExVVYyZXq+OZcfvP35mVcYiK4VFrrJH59E=; b=
	EIPgk6ZYTCnpYYolkCXrXVYNXXBi7uYZILBA4tWc4EAi4xT0d8KVHhdkdsI0dsaj
	U/doDFemwO+5Gxb7tRga2io0979MTTCgIkE8/TRO9rCZoj0CpwEORbIbb3IS9BPo
	kxrCydHXVZqzW1etRQId12Vfi3jbPG9VcNg4rZoQ+Dp4Ey8NvqFD3kwvQuzSqelD
	m5c+Bfpn41Ib1XNOnHdPeJjH8d60TNniitcYNHbrzfUgbFs9ydgdWCigYJRdqg8N
	I/9x/PMmlDNY9Dil1hjuxpGEuiGtsD7A1XjeDfNAtO/bSTX/mEexjdqOMu7dn8GT
	xlr94S+OOVFZzPtHYtlUEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759507921; x=
	1759594321; bh=mp66r2owFExVVYyZXq+OZcfvP35mVcYiK4VFrrJH59E=; b=l
	4I9TY/O+y8SAWesqYz+DGP9uU+cZqTSwPlH57OX+cAK+MehmLPkXiXVLu64eLh9W
	r7YFWi5Q8kIHaf76lpBt7s/CsXgizN/loPlQrg1nVdFSRK2aeSv4nrVMKmqGWk1S
	xjM+5UnSz1Hkis+wbx0bKMt6rnsY8H6VHV9wx8IlAfpTy25j8zDyfqNHUfxw+yMk
	0SJcfC0Zj3WDgudspQmfPTZjTiX03ZxfySfzkDWnE8CbezLbLA/n5GNWXIAbS7M2
	TzHmbaRizhbNyjwZOzHqBH9z5hcstKBpioN7Jn5HGtzs6Mgc4NS3xlmV1r6AE2W4
	MDV4oNLHivmBivCiN8vuw==
X-ME-Sender: <xms:0PXfaK5DoTftNspLbs3sVxXF2oBLQnBi5UkFoApZacMC4v2jWTxDGw>
    <xme:0PXfaK7lDj7hqCYO0bL0TQGa1-40kPHpMBQv5apNxiyO5l2awBvi43KwB3WznfzW9
    xLk0Lmerirk1bjbGkB6ktg0snIRrILXzskH8i7YKx-vtPFWnABGt0Y>
X-ME-Received: <xmr:0PXfaOcsBN0b8SQJ2lNK_5zHHrxI6a5K6rxfNxDt5zD4SrIzll4gpDe4uuU8er1SBySr2l7ASRfWSkrPsRlvJjcPdxP2hgDY8wZa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepuh
    drfihinhgulhesuhhkrhdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0PXfaGC2MmvOaNP0PRTgTTUogW3GGo2pyKGKjbkv9Oy3OOUpj4WsoA>
    <xmx:0PXfaJ8cM0L86fsrn5aAbt_kaZSeVI0Tu3AJSjFj2jQA4uBCy6e_2Q>
    <xmx:0PXfaJJXpK6xVVSNZuMaWutEbNSIFbEjeRE6stEPBYM-66NZw22HbA>
    <xmx:0PXfaKiIKeHYbD64UiTEgn9H7h5RdJLxzYXhL4n_Rnqkkt3FybITZw>
    <xmx:0fXfaEaH-S3S_nD4nO5ZSscH-hHQA3pJ42kpLxmESOHPBzquM3ooBVua>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 12:12:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: "Windl, Ulrich" <u.windl@ukr.de>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH] add-patch: roll over to next undecided hunk
In-Reply-To: <76665b6f-cb92-4694-bc89-5eb21197df34@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 3 Oct 2025 14:16:44 +0200")
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
	<76665b6f-cb92-4694-bc89-5eb21197df34@web.de>
Date: Fri, 03 Oct 2025 09:11:58 -0700
Message-ID: <xmqqo6qoufqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> git add --patch presents diff hunks one after the other, asking whether
> to add them.  If we mark some as undecided, e.g. with J, then it will

Perhaps "mark" -> "leave".

I somehow find it awkward to say "mark as undecided", as I have
always viewed J/K as a way to skip a hunk, leaving it undecided.

Besides, "J" lets you revisit a hunk that you earlier have decided
to use of hold off, and it leaves your last decision on that hunk.
A statement that implies "J marks as undecided" is misleading.

> start over after reaching the last hunk.  It always starts over at the
> very first hunk, though, even if we already decided on it.  Skip
> decided hunks when rolling over instead.

Nicely analyzed.

> Reported-by: Windl, Ulrich <u.windl@ukr.de>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  add-patch.c                |  9 ++++++++-
>  t/t3701-add-interactive.sh | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index b0389c5d5b..42a8394c92 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1436,8 +1436,15 @@ static int patch_update_file(struct add_p_state *s,
>  	render_diff_header(s, file_diff, colored, &s->buf);
>  	fputs(s->buf.buf, stdout);
>  	for (;;) {
> -		if (hunk_index >= file_diff->hunk_nr)
> +		if (hunk_index >= file_diff->hunk_nr) {
>  			hunk_index = 0;
> +			for (i = 0; i < file_diff->hunk_nr; i++) {
> +				if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
> +					hunk_index = i;
> +					break;
> +				}
> +			}
> +		}

OK.

This is probably a closely related tangent, but last night I was
looking this function and found that its per-hunk loop does
completely bogus thing.  For example, find a case where you have
more than one hunks, among which there are splittable and
non-splittable hunks (a hunk is splittable if there are context
lines between an added or a removed line).  Start cycling the hunks
without making any decisions with "J" or "K".  Once you visited a
splittable hunk (where you'd see 's' among the possible choices),
coming back to an unsplittable hunk will now let you split it!  's'
may not be visible among the choices, but telling it to 's'plit will
give you "Split into 1", which is a technically correct nonsense.

This is because the handling of "permitted" in that function only
adds, without resetting at the end of processing the current hunk.
Yet it does something like this:

	for (;;) {
		...
		strbuf_reset(&s->buf);
		if (file_diff->hunk_nr) {
			... add choices to the prompt ...
			if (hunk->splittable_into > 1) {
				permitted |= ALLOW_SPLIT;
				strbuf_addstr(&s->buf, ",s");
			}
			...
		}
		...
		printf(_(s->mode->prompt_mode[prompt_mode_type]),
		       s->buf.buf);
		if (*s->s.reset_color_interactive)
			fputs(s->s.reset_color_interactive, stdout);
		fflush(stdout);
		if (read_single_character(s) == EOF)
			break;
		ch = tolower(s->answer.buf[0]);
		... dispatch on the command character ...
		if (ch == 'y') {
			...
		} else if (s->answer.buf[0] == 's') {
			size_t splittable_into = hunk->splittable_into;
			if (!(permitted & ALLOW_SPLIT)) {
				err(s, _("Sorry, cannot split this hunk"));
			} else if (!split_hunk(s, file_diff,
					     hunk - file_diff->hunk)) {
				color_fprintf_ln(stdout, s->s.header_color,
						 _("Split into %d hunks."),
						 (int)splittable_into);
				rendered_hunk_index = -1;
			}
		...

Notice that the prompt is built correctly but that information is
*not* used when deciding if the operation is possible?

This is another ancient regression that was introduced while
rewriting this program in C near the end of 2019, I think.  And this
causes many other bugs in this area, like 'k' at the very first hunk
gets complaint "No previous hunk" only once (you move to the next
one with 'j' and come back to the first hunk with 'k', and then 'k'
no longer complains, even though it is not among the choice).

With this bug, however, we have gained a bit of useful feature, I
think.  Even though j/J should not be offered when we are at the
last hunk for a file, we do wrap-around to the first hunk.  I just
checked the original code before the C rewrite, and even though it
were written defensively so that incrementing the current hunk
number to 5 when you have only 4 hunks would take you back to the
initial hunk (instead of barfing), because we did not have this
"permitted is never reset" bug, it actually did not allow you to go
beyond the end with j/J.  Today's code seems to have inherited this
defensive adjustment to stay within the available hunks, and with
the "permitted is never reset" bug, we are taken back to the first
hunk.

