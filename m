Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A013A35208B
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300353; cv=none; b=qD6cM1FDIwmv/6L4XWdJrTZco+mv4LJpgiWaTdDIWCJJRG0Zb4c9UBN3h3u824SNvCoHQirB6LZvNU8tQ5TkXwenRzh4RBsA6AOMMmPPBMiA/1+Rhwla33VKaHS5q2ns1VN9K/er7WwoSaHAJTCU3qRvQZChQTPfUjZs5nTQMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300353; c=relaxed/simple;
	bh=IHrAX+0vzHMSP9Iq5f7b0Raam7miJbXqtKfEaFrqg7U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pLqYRJROQzQcOFElo+w+t7y1f0ZZexqzIi4TnrDOPwwVt8O7E/WWNne/A3df5bQKImctumqnHRqY7dqrd4p8YCU0U/ziFSmdZNEclhmPoIcwZUor93vZyAbndynZT6qri3YrXqRkF2FfhbABI+6txVeARfmSgizXl80S68zAUV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=shTEoS3Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jKx6ARLs; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="shTEoS3Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jKx6ARLs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B2ECEEC03E7;
	Wed, 27 Aug 2025 09:12:29 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Wed, 27 Aug 2025 09:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756300349;
	 x=1756386749; bh=yDefvu2SrJkc5a6/zDv20AoMsOdHUChMVg/XLzAhaFs=; b=
	shTEoS3Z0JzPpR9f+36CCEBNF4RX22/3f7YOI+cpa4/Y6wirqDfIyFgvCHdk8vJX
	Y8OxJQ6c7NRSk5oBCE8MT6M8nxwNWBrT/ViSi3+NozvXO/s3Qj+AxlHzrGul8pM/
	uPJZtIqJzy+V47pcG5nCyHmZsEvXVrCAg34YTKF0GDE+/oJ2L+4NedhFLwzMi01m
	55zjoKe9qJR0lagkgAGuHve86Cp+9BvFHzgLRd1Dhk1WzYUvP5yhpw8GhXQkql0Y
	dtcCB60esB/l1RX5jYwyxtlliyYdT0eo0FejzZ76pzrzzqRxNJQHkkxFXy6/maSe
	MhIh/N1JKFLlOL286q8GiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756300349; x=
	1756386749; bh=yDefvu2SrJkc5a6/zDv20AoMsOdHUChMVg/XLzAhaFs=; b=j
	Kx6ARLsHwnhUEyoI2CwrjNNuI4m8y46hKvs55XeiAk6WdH6a2GIUazvwOuxW5xI3
	AXCl/HalV846AQOvxKuDkUvJIahOdiP5zHEncPZiloiK/MKCPU+SOApVZsmAaH+i
	6PY57iV9KGb+TPvzrIHZ0108ZQGFMi/wdpleCjdmJYD87QG0I7caddVUqm0Sl4Av
	CMuyc4zRwNH8m4sh/Vi7i/uJUKIH1Ehn3mrHU9LSibIaxZetIWsC4z29b6RLDp/O
	VY9Yh6f3liAB5q/mbrBH+B7+OSelW/OZ3xcIaEI13nByx7W2HJXDCefPgXWahfpp
	JhTBidsRNbfAqxYc98CXg==
X-ME-Sender: <xms:PQSvaMMi8abJwhwq1nvl-20ENd06WDNEWmlK6-QZQUQWGmtx7pIqAw>
    <xme:PQSvaC8boScpb9FVp-m1iPom55dS7pErnpa4b8rRxmn4SEFQwq-cGaWtxMbLgsoqM
    BiNiIoYHZz9LIOF_64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfluhhlihgrucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhn
    shdrtggrqeenucggtffrrghtthgvrhhnpeefieeigeegtdefkeejgfdvteejfffhveeuud
    dttedvjefggeevfffhleegvddvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PQSvaK0eoJDWoXvKuWWl4bR4JI1Xyx5rPn2znTwMGZEoVC13648UBA>
    <xmx:PQSvaD_5mSckHROTtz_Heb-Xf-p60USsmFDAgvr2JRE8s6twnbY4FQ>
    <xmx:PQSvaP06I6XJJ-U4LsHSQkQrnZcZg0iGspcPni-rzVf51nwp_vapUg>
    <xmx:PQSvaI91DixhGbECKBG6_qkzUtkUUpsBx1AGocCB59H8SQ6vmyyiqw>
    <xmx:PQSvaNXdIV-zai9VoigCOogpeozjD3qeXTqXwuXSHTCOQayRZZ6x7Z9R>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 622437840CC; Wed, 27 Aug 2025 09:12:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAA_JS3oAuXV
Date: Wed, 27 Aug 2025 09:10:28 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <15c8cf10-e1a1-404a-8a99-d2aab098104a@app.fastmail.com>
In-Reply-To: <xmqqsehdfyho.fsf@gitster.g>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
 <72114133aafc94354c8b7f3c8ac65456421ce34b.1756240823.git.gitgitgadget@gmail.com>
 <xmqqsehdfyho.fsf@gitster.g>
Subject: Re: [PATCH 4/4] doc: git-push: rewrite refspec specification
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>> +`:<dst>` is optional.
>
> It may be technically true, but I am not sure if it is a good idea
> to say it here.  Without "when missing, <dst> is inferred with these
> rules", saying just "is optional" naturally invites a puzzlement:
> when do we need to supply it and for what?
>
> As you are going to say what happens when you omit it very soon, and
> you already have said with [:<dst>] that it is optional, perhaps you
> can scratch this sentence.

The reason I mentioned this early on is that when I read this for the fi=
rst time
it was quite confusing. Since `main` (or another branch name on its own)=
 was
the only push refspec I had experience using, it was disorienting to be =
told
that the format was `<src>:<dst>`. It made me wonder if maybe `main` was=
 not a
refspec after all and I'd misunderstood the SYNOPSIS.

I know that I'm not alone in this: it's very common for Git users (even =
very
experienced ones!) to learn the form `git push origin main`, but to
otherwise not be familiar at all with the concept of a "refspec".
So I'd like to do something here to help those folks connect their
existing knowledge to the broader concept of a "refspec".

That said `:<dst> is optional` may not be necessary: I think the examples
here accomplish more or less the same thing.

>>  +The format for a refspec is [+]<src>[:<dst>], for example `main`,
> > +`main:other`, or `HEAD^:refs/heads/main`.

>> +`+` is optional and does the same thing as `--force`.
>
> Ditto; this one is less bad than the :<dst> thing, because at least
> it tells us what it means.  But we are going to talk about when an
> update is not allowed (we haven't even hinted that some updates may
> not be allowed yet) much later, "the same as `--force`" is probably
> a bit premature at this point in the documentation.

The reason I mentioned this so early is similar -- It's very common
for experienced users to be familiar with the `--force` option, and
so this is a quick way to explain to them what the `+` does.

As an aside, I noticed while reading this that it looks like
the description of `--force` right now is not quite accurate,
since the rule about pushing to tags is not "it must be
an ancestor".

>--force::
>	Usually, the command refuses to update a remote ref that is
>	not an ancestor of the local ref used to overwrite it.

I'm going to think about whether there's a way to format the
"rules for updates" so that they can be referred to from the `--force`
section. Or maybe just move them to the `--force` option, and refer
people there if they want to understand exactly when `--force`
is required.

It's certainly much more common for users to use `--force` to force
a push than to use `+`, from that perspective it would make more
sense to document the rules next to `--force` than next to the
description of `+`.

>> +You can write a refspec using the fully expanded form (for
>> +example `main:refs/heads/main`) which specifies the exact source
>
> This example is not fully expanded.  refs/heads/main:refs/heads/main
> would be, though.

Makes sense, will change.

> I am not sure it is easier to read with numbered list.  It is not
> like these rules are applied in this order, or anything like that,
> right?

I had a similar concern. I'm still trying to figure out how to manage
unordered lists, since lists with a `*` are formatted by AsciiDoc in a
weird way in the terminal: there's a tab character after the =E2=80=A2 c=
haracter
which I don't understand the reason for.

> A tangent.
> Is this a refspec you can write in .git/config, e.g.
>
> 	[remote "origin"]
> 		push =3D tag v1.0"
>
> If not, it might be easier to explain if we tweaked the command line
> synopsis to say that the command takes, after the destination
> repository, zero or more refspec or "tag <tag>".  I dunno.

I checked and it's not a valid refspec:

$ git push
fatal: invalid refspec 'tag v1.0'

This list seems like a more natural place for that information than the
synopsis though: the synopsis is already quite hard to read and we
can't use it as the only place to communicate that information.
I can add a note to say that 'tag v1.0' is technically not a refspec.
Git already has enough weird exceptions like that that I don't think
it'll be too jarring.

> Perhaps move it down together with the "push void to remove"
> at the top of the list?

I'll also move it down.

> Good.  Somehow we have added the description of these to "git fetch"
> side, without updating "git push" side of the documentation.

Yes, I copied this part from the `git fetch` documention after checking
that they worked with `git push` as well.

>> +    Deletions are always accepted without a leading `+` in the
>> +    refspec (or `--force`), except when forbidden by configuration o=
r hooks.
>
> This can be read in two ways, making two opposing answers to this
> question possible: when forbidden, can you make a deletion accepted
> by giving a `+` in front?
> "except when forbidden, deletions are accepted with or without `+`"
> might be less confusion-prone, but I dunno.  I just wanted to make
> sure that it is clear that forcing or prepending `+` would not
> change anything when forbidden by configuration or hooks on the
> remote end.
>=20
> But because you haven't mentioned that not all updates are allowed,
> this might be a bit out of place in this list.  How about limiting
> this bullet point to only say that this is the syntax to use to
> delete a ref from the remote, and move the "deletions do not have to
> be forced and operations forbidden at the remote cannot be forced
> anyway" down, near the "Not all updates are allowed" below ...

Will do, that's much cleaner.

>> +    See `receive.denyDeletes` in linkgit:git-config[1] and `pre-rece=
ive` and
>> +    `update` in linkgit:githooks[5].
>
> ... together with this?

This makes sense.

- Julia
