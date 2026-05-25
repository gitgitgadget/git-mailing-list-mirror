Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774E314B77
	for <git@vger.kernel.org>; Mon, 25 May 2026 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779700546; cv=none; b=s8Ob1JN5uXhOZwoL/O8LNsSJQUn12MBcHh9v9MocGs9NHE5W6d7QQRQQzeqYdln0VSUjCqwtWf+nqUJY0KAcqCoMMxG6xLqZMHxaQXdolgA4sYCo30K4MvzAPcwTwIyExF04N+WExFYq4ksWbTYjcJGzpcJxRWKX5ETlGxiljzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779700546; c=relaxed/simple;
	bh=djAVCICkhF2Eub47ZbIk9TgpuPXWr0rETmTiJHcF4BQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hbbbf3FIOwFLC88GvWOKBEiZdh58yB3uZE2F79aDB93xYHMIvqZI7UlT1yED61TzmlTCiBK9n+j4o/0rTZFwtcG5U66ldOmGRGeGUsZGTRzRDimUDedBidT2NTjpkThMAGsDkfdYEPWJi4p6V6pFuTS8QivHrJATeiPb2S9bo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EVeLnLsS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e+awMhr5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EVeLnLsS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e+awMhr5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 651CDEC0349;
	Mon, 25 May 2026 05:15:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 25 May 2026 05:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779700544; x=1779786944; bh=LgqrVVKj76
	Rw21TYOxHRVV0JDnUsnX/7n58GuvAVPFw=; b=EVeLnLsSRrTR0qs4hpuhHZjaJ3
	P/TOet5nRerQY1tHgOsGZ/1ZTXM6CS+IGpINBfg4zO9J8DQaU2bYoml/Zv+Pa9Wq
	agAxTN+4NPl5gNCedPVlHK4y1y48uKC6oCk4Udt9E00eWbNGO87sOIS+MHvodKy0
	IpxwC1RdcmTv1EWzskwwaxW2UmqNQUacZmrdYh5ixaOgUIc7j/IgahicwgMmkeZY
	yt+FqiZ5SN0F3nuK+3fbrMu16/MV2mYa8vTZDLzuDoyLawxc+kB+jxkFffdvk/k3
	jxx7ND918M5K6hckoyyHPIpOt60JoTN8+EzogjXKEYlQIPjIY50NEdgDMVSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779700544; x=1779786944; bh=LgqrVVKj76Rw21TYOxHRVV0JDnUsnX/7n58
	GuvAVPFw=; b=e+awMhr5/B6EYgtLSPOKihHZLv7YG0KnAfLy6W8iZTrxX9BgYzP
	GI6uIjgNXa6ef7JBKAsj6CreyhwLsGpaUSfZFuJUsOtJdjlBibJtQ7wCMhQX6jA3
	vXePkkgagEasWgRROO16/cSmiwDZpdg+cWxR8SE9rdlJ1yrGwMDIcQRsEbe9OzKt
	HF4P71NOsAuplU9mUf4GWyqbsxodGc8sAl3Z86My9stkMxPMea+A6VKS+snzV8Zg
	ZjnyVhmdU63aDnFarF446faPrYgwINo6w0DZqQNWP8dSZBy1624jdSVC+NqySaa1
	U3CkcSqLEzv6wb3OcmZhfzr1bYS1RCOoiTw==
X-ME-Sender: <xms:QBMUatrv0TJ1Ih5q7JGAlUOJcJn5Yol4iMelDbR1j8Lg4vp08aZ-Tg>
    <xme:QBMUamjiBYVIi6ZViJf6dOb4hRjp3ttluD4vlsX2ZxteWIMjINBjvYRv-2c4o6zUm
    KLr_daH2vg9AsadBiEJbOsGYahvDmrgwnHg0iI0y1CQT72iF1FM>
X-ME-Received: <xmr:QBMUaihp3XfY71NiuHrEp8_La5vJvcjWMbDPSCJG3k13IanXKwV9FblS2qJueExwSaOM3EP6js7Vft3aOhRcvhfNv2YlgS2H4C6A>
X-ME-Proxy-Cause: dmFkZTFmxEkGORMDdw9JSOCAnZzDKq6r+hOFPFgv5wnkH8vSB1TdH0FU7fE6xP7rl2GRhS
    VDYA8l259xIOTfoxjKnDQwiASUJE14dJ9H1n/MO4BHSX5pMrZ+UK5jZCF7C673uV10Hti5
    nTraaOM4UYwQuy5skhpTAJ4n90GoXeNlqMsGp3oD0VZjQPBaLDOnk73XapZta1QtLasxB4
    WUe8c8vRzz6CjIvqGehxZelDq1tsT8fpDQxZe9nPxEy3d/wqkzMuzRPiuLeEOJ9zdFCyvX
    gAYy15N7mluLtXhN//jzepfUq84HEXx3jt843AZbNLpNnhMweqjajAcWzxQZA1cvDa3nQO
    dHnUBX6QyNj1Zui8+RUhFaMicxU2oUAKtrvvIvaOwlXq948Rn1BUtqGIXSH2OUdSkWcRgG
    GBHqtOP4KUtQsCMjFS1Km8w0gkj7QH8pJjMNHBPZQLOSpVu+NZ3RSpZANPxv/auBqKERvG
    rIyhXHQLgn1+pE0UQZgdLf63I2Dl14ZKzx0/WE0NIqqvtlcdITfD0SlB3Qf/vswfzY5UPk
    Z91zyxSxs2vmMpPmeoMhwAh/kng+UTu41DApnQf7pVpV08I53M5CE3cItsKwmFXEnUoV3w
    k9qTy9SPr9KhDsC1RtgXXA/uVxhXCICKbwMWUktqKbBljNSvxQBBKuNfLfZQ
X-ME-Proxy: <xmx:QBMUakjgQBzCdVZR9edUoFmcDO-FC7w2myy7Tq5MrS8AOC9x_D1iqQ>
    <xmx:QBMUaqLrlbimwWmliNtJE6tq1q-64OI0sviejWx0OhVXcLMlQJiVOQ>
    <xmx:QBMUarE53QJSPASJ24ztSouFJDxsoqCXNsqzA07AVrAj854eHrcuIg>
    <xmx:QBMUamTea_3Z6rrEMvmBXDDw8bXqf6k813bFhzgBVoG23q5aOMJliQ>
    <xmx:QBMUaphLQNEU2ullycnPH9pR9m1RKarGs7sW_H5d-SQ_onXJFTtZP047>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 05:15:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3] config: suggest the correct form when key contains
 "=" in set context
In-Reply-To: <pull.2302.v3.git.git.1779697995418.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Mon, 25 May 2026
	08:33:15 +0000")
References: <pull.2302.v2.git.git.1778935976330.gitgitgadget@gmail.com>
	<pull.2302.v3.git.git.1779697995418.gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 18:15:42 +0900
Message-ID: <xmqqecizetoh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Emit a "did you mean ..." hint suggesting the split form.  Restrict it
> to plausible-set contexts ("git config set", bare "git config <key>",
> and their 2-arg forms); explicit "get"/"unset" keep the existing error.

I understand that it would be a good idea to give this warning
against these two where $A is an arbitrary string with at least one
dot in it (making it a likely variable name), and $B is an arbitrary
string that may contain anything:

    git config set "$A=$B"
    git config "$A=$B"

It is plausible that the user wanted to make the value of the
variable "$A" to "$B", so telling them the right syntax would be
valuable.

If "$A" is a syntactically valid variable name, then I would imagine
that we want to say something like this:

    $ git config set "$A=$B"
    error: missing value to set to the variable "$A=$B"
    hint: did you mean 'git config set "$A" "$B"'?

If "$A" is *not* a syntactically valid variable name, then giving a
hint to try to assing to it is a counter-productive.  Ideally we
probably want something like:

    $ git config set "foo=bar"
    error: missing value to set to a variable with an invalid name 'foo=bar'

It is pointless to say the user may have meant "git config set foo bar",
as "foo" is clearly not a valid variable.

I do not understand what you mean by "their 2-arg forms".  Do you
mean

    git config set "$A=$B" "$C"

by that?  If so, I doubt that user meant an assignment to "$A" by
this form with explicit "set".  If "$A=$B" is a variable whose name
is valid (i.e. three-level name whose the second level component
contains a "="), we should just take it as asked.  E.g.,

    git config set "foo.bar=baz.boo" "some-string"

needs no hand holding.  But
if "$A=$B" is not a valid variable name, we should just complain
that the user is trying to assign to a variable with an invalid
name.

    $ git config set "foo.bar=baz" "some-string"
    error: setting to a variable with invalid name 'foo.bar=baz'

I think

    git config "$A=$B" "$C"

that implicitly uses the 'set' verb can be left as an exercise to
readers.  If "$A=$B" is a valid name, we shouldn't do any complaint.
If it is not, 

    $ git config "foo.bar=baz" "some-string"
    error: setting to a variable with invalid name 'foo.bar=baz'

It makes it clear to the user that (1) we interpreted the command
line to be "implicit set", (2) we interpreted the command line to
set variable 'foo.bar=baz', and (3) 'foo.bar=baz' is not a valid
name.  I do not think there is anything more needed for this case.

> "=" is legal inside a subsection, so only fire when "=" lands after
> the last ".".  When the user supplied a separate value, use it in the
> suggestion instead of the suffix after "=":
>
>     $ git config set pull.rebase=false true
>     error: invalid key: pull.rebase=false
>     hint: did you mean "git config set pull.rebase true"?

I really do not think '=' needs *any* special casing in this case.
If we used "pull.rebase*false" as the variable instead, the message
would say that "pull.rebase*false" is an invalid key.  Two important
things for this message to convey are (1) the command correctly
parsed the command line to mean that the user wants to assign to a
variable whose name is 'pull.rebase*false' and (2) that variable
name *is* invalid.

If you find the current message suboptimal, I think we should try to
clarify the message, as '=' or '*' or any letter that makes the
variable name invalid would benefit from the same improvement.
Perhaps something like:

    $ git config set pull.rebase*false true
    error: setting to a variable with invalid name: 'pull.rebase*false'

perhaps?


> Signed-off-by: Harald Nordgren <harald.nordgren@kostdoktorn.se>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>

Interesting.  We typically do not do this.
