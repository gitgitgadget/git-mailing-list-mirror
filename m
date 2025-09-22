Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1402405E8
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 21:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578295; cv=none; b=EiNa0Ljf1psx1cx6MSJQKN7n86yyRiKIWwHRMk3ULBK8FqYhkVwhR7zBv36d3n68Ole+bAJHaIpf0zPLketGDczv2Wmcf487dIUO+IppDWIMzS5APvKdi7ac2V2RdB5g/CZmr8NhMYvPWkEHdfNrxwmKPxvW5DHdZu61EeAS8TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578295; c=relaxed/simple;
	bh=hpeK/mr/eTrHlb5/6Xpd3vEaZD6Ou/rH1O1l4tDysIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GPylZBmzAGCucA78uz+Ni4D9XHPy3wXpGzDJroKkQgc4ZAMf5iDEPiZKGiXrvKQgtDQGKOsDprbOOtnS34A2N87B+SrPUIN6UUXsSTvjhdSPQmUkIhxKu27/rf6w25DfXxrjABz+7B45+PDF6UcL4BaseCJOENOzlScl9KHL+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GjFy0CVt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SQfUYAQ2; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GjFy0CVt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SQfUYAQ2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D57EF1D002C4;
	Mon, 22 Sep 2025 17:58:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 22 Sep 2025 17:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758578292; x=1758664692; bh=BdH7452kG+
	SY8+3+DeFYV2Z/EBPRWotMn0gFSPgC9Og=; b=GjFy0CVtGisVlZDnHFV9IhUBcA
	W4gN67QCMbqcQpSSUZfzkM8qei8Mw8rXQELcPir7HvZ5ZCligBgVo07OqVn7Gqzx
	mrgFVG3r02k9aAx+Nx+sQtNBQGkEBRBdo3rAVy2Ed8FD56XOcm5Io2lt5quzdRZ3
	Th1hvGyCF9aBzhOKORDW+xI2uyUgG2C1xxRo/EBm/6UfYpeX0jk+4SbwvEcfZ9+U
	AbnbjfkyV+fPjQsJGcsSdi5uXWhBfLK1KD++lMn85IK1VgJAH/9KH2esTJTxw8LE
	Rji5+oTcf7nel4iZ9L2km8DfhkKostaOFZG8F2+JPaujNHbSRsASDeZ/9I3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758578292; x=1758664692; bh=BdH7452kG+SY8+3+DeFYV2Z/EBPRWotMn0g
	FSPgC9Og=; b=SQfUYAQ2K/K5LQDJcorfS7JLH/DK/6kVQSoljQ2lPxjfJwxRxJp
	XGTt0pq8UaZ6cfH3qI0nHpl+7iq9XLdFVNstbys66KFP2cQS9LQOC0KKoM+91sGd
	7ZkhQKTXguIk/RjwSUeoZxwbgN+EElXm4IDwU1nMeGL9lXsS66pZ1q8jzdliDZWa
	LWF6eBceRheLzzgTa6VhPPHb2cOL4zLTNFZXLASI54bn4v/W4K2Qt9VqeTEin9ZC
	ULiiar2THKOScL63s/9/3CWPkp5QZVwWouWUd3w6DBfeZ4nMfmqBYTFOtEOe2Qw9
	g4pPQjMruKqXxSddlPnQMZnqqx/Q87rKvSQ==
X-ME-Sender: <xms:dMbRaLp0WTro5Z0gK68MPfqNHRfbuzdflPyknpIR176vKViiALIsvw>
    <xme:dMbRaMqPnIE3UYw6HvlH74TRFefse97PXiy0CEEAt92j8TclSoKvRQK4dXLvsN5iA
    mgMYLXcdvLS7nfhYX9Ukdfp0qC2B0_MlLmkTkhhQA5rhDgeKmwsdA>
X-ME-Received: <xmr:dMbRaNPC-gApoz31dVKB_PLfg1Y4hN_7Lk6z_nldO9Ql2BZcPiw405She-l6sdpBEWrj6g-53NqSSgzoivmsfZj43xcAo1vgevtC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtofdttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffge
    fgfeeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghu
    ghhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:dMbRaNyTciPoJxpX_-lERjWl6TCQjar6g0nwxK_PFJSk-BehCIIxYA>
    <xmx:dMbRaGvSscwTxluqdSEVlSWgVFem_aAg-uJdHd83Bub5V5J7Y_8bzA>
    <xmx:dMbRaG4H_f371yGe7Ld71KYjOb5YtpyZi2BQgELGGzbAzmz2Ozfl2g>
    <xmx:dMbRaFQRvD7DuJW_f3BsCsx-w3u1EYRUL-dor5DbQqC32qLT5BLleA>
    <xmx:dMbRaL0cyY6hau34nPvYn9fEXsfIbAxuNfrGk_saACKIGImuyGqkTYo5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 17:58:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 1/2] revision: add rdiff_other_arg to rev_info
In-Reply-To: <bb065767336.1758574974.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 22 Sep 2025
	23:10:22 +0200")
References: <cover.1758574974.git.code@khaugsbakk.name>
	<bb065767336.1758574974.git.code@khaugsbakk.name>
Date: Mon, 22 Sep 2025 14:58:10 -0700
Message-ID: <xmqqikharvyl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> git-format-patch(1) is supposed to treat Git notes the same between
> notes output beneath the commit message and the notes output for the
> range-diff.

Is this an opinion, or are there things that existing pieces of code
already do to achieve such a behaviour already?

> diff --git a/revision.h b/revision.h
> index 21e288c5baa..26c18a0934b 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -334,6 +334,7 @@ struct rev_info {
>  	/* range-diff */
>  	const char *rdiff1;
>  	const char *rdiff2;
> +	struct strvec rdiff_other_arg;
>  	int creation_factor;
>  	const char *rdiff_title;

When embedding a struct A in a struct B, we should always make sure
that initialization macro/function for struct B is updated so that
the initialization for struct A is done correctly for the new member.

We do have REV_INFO_INIT for "struct rev_info"

        #define REV_INFO_INIT { \
                .abbrev = DEFAULT_ABBREV, \
                .simplify_history = 1, \
                .pruning.flags.recursive = 1, \
                ...
                .expand_tabs_in_log_default = 8, \
        }

that does not allow any existing callers to leave it uninitialized
or get away by zero-initializing, so all the users must be using it
or the system before your patch is already buggy.

And we do have STRVEC_INIT that we must use in that initializer.

        extern const char *empty_strvec[];

        struct strvec {
                const char **v;
                size_t nr;
                size_t alloc;
        };

        #define STRVEC_INIT { \
                .v = empty_strvec, \
        }

So this step forgets to update revision.h to teach STRVEC_INIT on
the new rdiff_other_arg member.

Back when it was a random one-shot variable in range-diff, it might
not have mattered all that much, but now we have it as a proper
member of the struct, can we give it a name better than 'other_arg"?
Or is it the case that truly any random crap can be slurped into the
array and thrown back at "git log" without range-diff machinery
understanding what it is doing at all (which I would not be
surprised, as some parts of our code base is written in somewhat a
sloppy way)?

Thanks.
