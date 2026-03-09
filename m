Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70C3BA24D
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063501; cv=none; b=ShORgXoVceav4QBUj8hSr2gFFnuaCBu/7BUhhBv9EIUm3XArKSIHGxnlDZ8MEUh5moI6nfXIzwjwghZtRnzR6sx5CgM6xxcEnIf5Ju2CkKO81WKMhnLZ2AfUEurrynYxjBCzaU+iR7Gjc6q/dHfxMfrSHRuz56LLiUCQvW5oxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063501; c=relaxed/simple;
	bh=EIOULMQkc8nQxvz92ux7v56Ivp+befdbqqNXiNIs46U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mvA5nAd7FqdzZ+ovbljynjOPnCrft+mzD6nhWjkunoAebS+Y7H2KONCXIQpEBmwvOdRGYWfFwGCdsXRGwStNzA1L4mPaj/v4ZU6E6eAlA81tfTj0NYOzBhc7cU7wTow2rKMDBlFuIKaYn7SfEfTLdMemj9P2AJu7HLVNgA2SIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I6jvOrCP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KlpRTNsH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I6jvOrCP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KlpRTNsH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EFA6AEC02E6;
	Mon,  9 Mar 2026 09:38:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 09 Mar 2026 09:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773063498;
	 x=1773149898; bh=jdsMbipkp+ARclz5gpqB5PsrgQgxTBFnhS/VQ0hGtOo=; b=
	I6jvOrCPysheINYCZDTelQRO7s8O9Y7sapHimjqF/AMr1uXYE5nCcj18XBP3Jdr8
	xnmitfuVQrIC33binwWyoZSGQY/ABQFZCxQwDred6xzEff0TZlXZpV/gWv7cnZIu
	QbYr3GNVN8wbWok341Jq3qBty2cwz2YUvo6ftT0A/+bwbouNZB2VsF2Qutt6Kia6
	M4tYD1r1GQz/v/kz3eXJ1B3j4vlQst1JQnZklsUXNuARRDyS/vafBLAJ3HczoLvA
	/6tvVfC3Qd8x3Ov165SqP57JY5nJWLlKZ7QwKEpZpfPFEEzg2O8DbNyq/moE0a79
	FWG0hsmtU8yJpdHzdjIeQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773063498; x=
	1773149898; bh=jdsMbipkp+ARclz5gpqB5PsrgQgxTBFnhS/VQ0hGtOo=; b=K
	lpRTNsHD9s0kKOMy0KTjuethKfGlztz6/3sq+IZWsjaHqjhOrcpTefghZB6ypgrr
	GToTTYhZqAnR6kxBD+bQrVVmZNLUswrUmiT6a0DOJj+ncGqIwrmFa9EiUvRas+At
	ho9Cm+kdC7+8ljCT/asAbDTA5LJUZS5gCDaNw6TM+TKiSSiKnH4SoGi2KqI/QN+Y
	MXwcoGF6MQXIMMoZpsxARrn36Bu9nTYqsYoXjtOw00yrrzsILINmkEm7nUQdrShX
	sRiTQO/yyTYOzoEasVgm0chzY66bcp76UeOUBlqv9P8fGptXuCPvV88cmOk6E6kY
	9eEagUkb1qvecdmKY9PMg==
X-ME-Sender: <xms:Ss2uaUWOYtTcxM4pNtfB5P9lMckcIRT470rfBGxAL2sSBJBV38lZ0g>
    <xme:Ss2uaa2VMvajsSTefRkGs_KMZWpDW771407txmbRxFHTFq2Hh_7SAvm5GZvbRyMqU
    HS7mP1lQoNwsAep_KZISK-TexJ_I7n30XdDXhlvvKhdiuV9tMAcy8E>
X-ME-Received: <xmr:Ss2uaaoEwzIQjhmLUHuSOJMmmc8mOsi8HmwQj-vmGDRkm9O0ZZBY_RFRvVRi-LETVInV3JroAzM97Hub6OkbTRnBV8fkwdTOqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ss2uaZUmoRqz8SMkioQiaBxh87MCoeOJDoZTvDCfHv31dAK6BJ0PXA>
    <xmx:Ss2uadYfWC5p3NIEvsibZdWYfoXm78MkPSzTq687MOoh9SYMgbA7Sw>
    <xmx:Ss2uaecxtSduP7jBPQABcdgAGebuePv9Road6DixNP0BlQ2xdk7O8A>
    <xmx:Ss2uaf0kynma0XwpUMe0Ds-6XdIAyhxPRWN-8zihax4Jpn3SZYUlZA>
    <xmx:Ss2uaQeNMEd6y4WyjdGrxLK4zp4ywPlDb8GtgHC4bXDWAYXuxI-x8vbk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 09:38:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  me@ttaylorr.com,
  phillip.wood123@gmail.com,  ps@pks.im
Subject: Re: [RFC PATCH 2/2] push: support pushing to a remote group
In-Reply-To: <CAPSxiM_KVU7rE49=omWUwaYS-u_J6eQPDgTRjPop1gj6BM1qKQ@mail.gmail.com>
	(Usman Akinyemi's message of "Mon, 9 Mar 2026 06:26:49 +0530")
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
	<20260305223248.170785-3-usmanakinyemi202@gmail.com>
	<xmqq4imsv13x.fsf@gitster.g>
	<CAPSxiM_KVU7rE49=omWUwaYS-u_J6eQPDgTRjPop1gj6BM1qKQ@mail.gmail.com>
Date: Mon, 09 Mar 2026 06:38:16 -0700
Message-ID: <xmqqzf4h6s3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Also, in the cover letter, I asked some questions. I think you might
> have missed it.
>
> Quoting here again:
> "
>   - push.default = simple interacts poorly with group pushes when the
>     current branch has no upstream set, since setup_default_push_refspecs()
>     will die on the first remote that is not the upstream. Users should
>     use push.default = current or explicit refspecs for group pushes.
>     It is worth discussing whether the group push path should automatically
>     imply push.default = current, or whether a clear error message
>     directing the user to configure this would be sufficient.
>
>   - force-with-lease semantics across a group push are currently
>     unmodified — the same CAS constraints are forwarded to every remote
>     in the group. Whether this is the right behaviour or whether
>     per-remote lease tracking is needed is an open question.
> "
>
> I will want feedback on this also.

Quite honestly, I do not have strong opinions on either of these
points, primarily because the answer would become self evident if we
follow a simple general principle to explain this feature to end
users, which is:

When you have N remotes r1, r2, ..., rN, and a remote group G that
expands (possibly recursively) to these N remotes, then for any and
all values of $options and $args, this command invocation

    $ git push $options G $args

should mean exactly the same thing as

    $ git push $options r1 $args
    $ git push $options r2 $args
    ...
    $ git push $options rN $args

So the answer to the first one would be:

    "git push r1" (without any other parameters) may work while "git
    push r2" (the same, wihtout any other parameters) may fail,
    depending on how the push.default is set and on what branch you
    run these two pushes.  "git push G" should behave the same way.
    There is nothing extra fancy needs to be done.  If the user
    wants to push to these N remotes as a whole in an identical way
    by using remote group G, they are the one who is responsible to
    make this sequences of pushes "git push r1; git push r2; ..."
    make sense.

The answer to the second one would be derived the same way.  If
$options includes the "--force-with-lease=<commit>", then the
command should behave as if copies of the command that pushes to
these N remotes, "git push --force-with-lease=<commit> r$i", are
invoked.  If <commit> is not given (which is not a recommended even
for pushes to a single remote, because with background fetching,
guesses based on the remote-tracking branches are never be
reliable), the command may guess what commit to expect on the remote
the same way as if these N independent pushes are made without using
group feature (which of course may make different guesses for each
remote, if their remote-tracking branches are pointing at different
commits).




