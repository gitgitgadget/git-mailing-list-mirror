Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC93093CB
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785304; cv=none; b=l9icF2GB+GRRFuQHyfVWJLvqgRR2L451twwRwX/5hsGb9vGAiUK86lD/rTw4rWp4MYobBTtHZ2KJ4LcvyF/wirXPgCHPUODxCQIcNfdymSWZ+ja8ug3k0d0lqIzGm62kyOo3CQ9arMtaQ/Rv0iH9NkMbWECprnXcCivKBzbyMmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785304; c=relaxed/simple;
	bh=nYPCrqOw+BK3G465UQm6kgvPnkMSr6jy7XqPYkJledM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YPS580Ah09wO6zWgqGPk6y2JtbKsiTJjBzLBrj0bk5R4JuHaXOMKvQlh3OrTY3xrSagce/r3xZzD9EdD/vJNSsPilfgsbypKtx9K9/iUf2FXh0jWJlt5DwisMW2FAneE2Le6ZhijK3iwZ9Pm3NP2kpd9NhdwmcjZxurNXJbIADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Qn9diePj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K++kSHsG; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Qn9diePj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K++kSHsG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 998C31D00178;
	Tue, 17 Mar 2026 18:08:21 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 18:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773785301;
	 x=1773871701; bh=kJsbMdWVnD7PFIz7J9b7dLjnuDLR2X58MzE5aiLmHWc=; b=
	Qn9diePjPBw8ZECv/v7or8bOcX6TMfqrBZldkumon3Ig6eWzjgAsIb5MeLdqA/fw
	aovCCozu/LvOoiB/6hMVUjn5Np3s+coyWWLGniP7BC4c+1cWfCHsOYCiJUguZb6S
	HuWEpSlbW1JFWDALS5weKq0Q50URnb2Qs7lAAsWb6texzAKYtwQWWUmqGQDtesal
	jpviQx0O5HiR8HJVkb2WwZvXlVvZ5vwGvByLJO23+qvSFJeVRUpzc7dtE7MJS7VC
	2fRyU40cDvh66Rj0Pud4fRGST9aJisTzIwlNdogDSm5UAk5EHbJCDK/HYd0thj6T
	91y33UI8Szl0tBBv5wf8ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773785301; x=
	1773871701; bh=kJsbMdWVnD7PFIz7J9b7dLjnuDLR2X58MzE5aiLmHWc=; b=K
	++kSHsGW21rX6FwUHrSICSJewtaepG+Vc1WOlV0+HAp/HqK0w2yBh8P4Gu7623gx
	iKXUqx+Yd+9qUS802RB9r3hmZEsdES6+tP+4bvfoYXT/wpwt8qf1kOa+ZMaoXlbF
	mEFG98/mXQLFTOU+KSBAGlExtZRvEFsqvGgROQySkQYM9CaT5b5xihYFOL24xFEb
	bQgr8SQKOeeudGyREyq93MvTcwO2vgY2zUfrPXAbmB8It2L4O1dF3kAC6cwu50VG
	tvslRpJLmRL66ADSHt1rnX3AWnVf/zXaNaKXSc++D3oQJNuann6Gs47CE0NrlAEs
	RcBJSdeS8Wvd53Gs/yPVQ==
X-ME-Sender: <xms:1dC5aQLqRYYHuikXlPr_UJuuWp2A5unek1Okhu6FhnTMKb4gdmPjZSA>
    <xme:1dC5aa9CaU3upmaK1qVE-XvfhuSqCOtqCd66x1ZUn1rZom5VcQGZ_WSS1R9VjV5ve
    k3rmNKjdJq_XlJ5aIfZmb-07BG675BOxoSA2Y2p0TB9XabZnX7F3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveej
    gfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptg
    houggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:1dC5acm3lCumQdrfnCNQS-hxLtU9O7wuuHprdHmvjOGDSuJYqfMXmg>
    <xmx:1dC5aTlah89mrgpPfhfVt5BJZX4RIma1UGVl8omCUQNCpLrV7SUWPA>
    <xmx:1dC5adsbnvyRW7qlclnfLu075vjvuA9Qf71bZ_NhmvZ7OU0Kx48RHw>
    <xmx:1dC5aWkfzj4PeaG717pEfd5rkjkIVm05vqoafg61QSBjtrNC1KqO1w>
    <xmx:1dC5acd_ApV0Kzqda8HbbAaIChqvmbjsDeuwHAbovxZBb4RmmTgtUYsN>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 068821EA006B; Tue, 17 Mar 2026 18:08:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALlot-drpGVV
Date: Tue, 17 Mar 2026 23:07:59 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Message-Id: <d3813f1d-174b-4d1b-b0c5-c6a8db260f6c@app.fastmail.com>
In-Reply-To: <xmqq8qbvz2dm.fsf@gitster.g>
References: <CV_name-rev_--format.4ad@msgid.xyz>
 <name-rev_--format.4af@msgid.xyz> <xmqq8qbvz2dm.fsf@gitster.g>
Subject: Re: [PATCH 2/2] name-rev: learn --format=<pretty>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026, at 01:22, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> diff --git a/Documentation/git-name-rev.adoc b/Documentation/git-name=
-rev.adoc
>> index d4f1c4d5945..8f050cd4763 100644
>> --- a/Documentation/git-name-rev.adoc
>> +++ b/Documentation/git-name-rev.adoc
>> @@ -9,7 +9,7 @@ git-name-rev - Find symbolic names for given revs
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git name-rev' [--tags] [--refs=3D<pattern>]
>> +'git name-rev' [--tags] [--refs=3D<pattern>] [--format=3D<pretty>]
>>  	       ( --all | --annotate-stdin | <commit-ish>... )
>
> We acquired a new option.  Do we need a matching change to
> the contents of name_rev_usage[] array?

I looked at it and it seemed that `[<options>]` were supposed to stay
inside that placeholder. But since this is a new mode, maybe:

    diff --git builtin/name-rev.c builtin/name-rev.c
    index 6188cf98ce0..13e67a7723c 100644
    --- builtin/name-rev.c
    +++ builtin/name-rev.c
    @@ -504,6 +504,7 @@ static char const * const name_rev_usage[] =3D {
            N_("git name-rev [<options>] <commit>..."),
            N_("git name-rev [<options>] --all"),
            N_("git name-rev [<options>] --annotate-stdin"),
    +       N_("git name-rev --format=3D<pretty> ..."),
            NULL
     };

>
>> +--format=3D<pretty>::
>> +--no-format::
>> +	Format revisions instead of outputting symbolic names. The
>> +	default is `--no-format`.
>> ++
>> +Implies `--name-only`.
>
> If it is implication, would
>
>     git name-rev --format=3Dreference --no-name-only
>
> do what is naturally expected?

No it wouldn=E2=80=99t. You=E2=80=99re right, it really locks in that op=
tion with no
escape hatch.

But in my next version I have switched to a parse-options callback so
that `... --format=3D... --no-name-only` really does turn off `--name-on=
ly`.

>
>> @@ -462,6 +472,25 @@ static const char *get_rev_name(const struct obj=
ect *o, struct strbuf *buf)
>>  	if (o->type !=3D OBJ_COMMIT)
>>  		return get_exact_ref_match(o);
>>  	c =3D (const struct commit *) o;
>> +
>> +	if (format_ctx) {
>> +		strbuf_reset(buf);
>> +
>> +		if (format_ctx->want.notes) {
>> +			struct strbuf notebuf =3D STRBUF_INIT;
>> +
>> +			format_display_notes(&c->object.oid, &notebuf,
>> +					     get_log_output_encoding(),
>> +					     format_ctx->ctx.fmt =3D=3D CMIT_FMT_USERFORMAT);
>> +			format_ctx->ctx.notes_message =3D strbuf_detach(&notebuf, NULL);
>> +		}
>> +
>> +		pretty_print_commit(&format_ctx->ctx, c, buf);
>> +		free(format_ctx->ctx.notes_message);
>
> Is free() the expected thing to do here, or FREE_AND_NULL()?  Unlike
> callers like log-tree.c:show_log() where a context is prepared, used
> once, and then discarded, format_pp is initialized in cmd_name_rev()
> once and then repeatedly used by show_name() potentially multiple
> times, so there may be a risk of getting confused by this leftover
> non-NULL pointer that points at an already free'd piece of memory.
>
> Or there may not be---I did not check, but you as the author must
> have already checked, hence this question.

This is supposed to be tested by `--name-rev --format=3D<pretty> with a
note`; it has a note on the first revision but not the second.

Here we never use this pointer again and we get a fresh pointer from the
strbuf before freeing again (whether it gets populated with a pointer or
not).

But it does sound better to just null it. There=E2=80=99s no need to hav=
e it
laying around.

>
>> +		return buf->buf;
>> +	}
>> +
>>[snip]
>> @@ -567,6 +599,10 @@ int cmd_name_rev(int argc,
>>  #endif
>>  	int all =3D 0, annotate_stdin =3D 0, allow_undefined =3D 1, always =
=3D 0, peel_tag =3D 0;
>>  	struct name_ref_data data =3D { 0, 0, STRING_LIST_INIT_NODUP, STRIN=
G_LIST_INIT_NODUP };
>> +	const char *format =3D NULL;
>> +	struct rev_info format_rev =3D REV_INFO_INIT;
>> +	struct pretty_format *format_ctx =3D NULL;
>> +	struct pretty_format format_pp =3D {0};
>
> Hmph, would we want to use the full init_revisions() instead of
> static REV_INFO_INIT that initialises a lot more members of the
> struct properly, most importantly the "repo" member that points at
> the repostiory to be used?

Here I looked at the doc for `pretty.h:get_commit_format` in order to
learn what I needed to set up. Since it doesn=E2=80=99t say much I did t=
he least
work that I could get away with when it comes to struct
initializing. Since it does seem like a struct for a lot of different
situations while this is just a formatting situation.

I might have done less research than I ought to.

>
>> +	if (format) {
>> +		struct pretty_print_context ctx =3D {0};
>> +		struct userformat_want want =3D {0};
>> +
>> +		get_commit_format(format, &format_rev);
>> +		ctx.rev =3D &format_rev;
>> +		ctx.fmt =3D format_rev.commit_format;
>> +		ctx.abbrev =3D format_rev.abbrev;
>> +		ctx.date_mode_explicit =3D format_rev.date_mode_explicit;
>> +		ctx.date_mode =3D format_rev.date_mode;
>> +		ctx.color =3D GIT_COLOR_AUTO;
>> +		format_pp.ctx =3D ctx;
>
> Why does this code initialize and assign to a on-stack ctx first and
> then assign it to format_pp.ctx, instead of working on format_pp.ctx
> directly?

You=E2=80=99re right. I=E2=80=99ll just assign directly.

>
>> +		userformat_find_requirements(format, &want);
>> +		if (want.notes)
>> +			load_display_notes(NULL);
>> +
>> +		format_pp.want =3D want;
>> +		format_ctx =3D &format_pp;
>> +
>> +		data.name_only =3D true;
>> +	}
>> +
