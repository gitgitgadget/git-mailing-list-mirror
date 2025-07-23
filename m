Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB072E36FB
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313801; cv=none; b=XEUkCU2GcKQqBRFmcbiPx11GkfZF1qZD1SQ52s5tB6dLfKByXfOMjX2WGKi9Zq4AiXJHtefZT7PlDm7115dN0vgeSC1CwDjZPqJ/gAkz+h46o/QEpBZfijyJW0e6K2yFGTxP1+WdyEG6rIQCg1N0BgP0M8e/kvt3an7YboozSZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313801; c=relaxed/simple;
	bh=noNO8yPw1Tcko3DcW57MvIQOCGSBJYiMD5C7NpVN5O8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nurr+UqOh7xBFjhBIDZeknjvQB963k7dh3sFV6gkNGtaB7j8mIR10pkG615Ce+QQaET7wmkw9mon3ADGYrw5ibfuTyL43ETPHmIGR0ZEPztyvYk+JQVBlvS4CByZnP5C5uX2Hz1wdyy1tQBXXaErQc9mY4lM5w9G/hC2cFEvxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UNE3AJn6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gLAbW4xb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UNE3AJn6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gLAbW4xb"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A1FEEC1C5D;
	Wed, 23 Jul 2025 19:36:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 23 Jul 2025 19:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753313798; x=1753400198; bh=DEZ80ZDvCB
	X++//Rb3ZuAtpyVV+fL4COVjEMofI19ao=; b=UNE3AJn6X2pbzA/+hBgLR6MD1g
	S3/r0r24QNC9B4WsvbcDDAUEyJ3Zh3c/OzjkSb5AssOvLg6KJXyAEoXG58vnoZ0K
	tn6TWZTaEWMgu3MV8Kdf9ALBXkhd7ey4/qnbb4rXE5319+OJRx15mP+QkIfK+DAj
	aKguGvjgdkB3E2tZu/FxtjzqYwVhQzRj0HHMqCJg5z9xcJZt5EMx5QMkthfREDxn
	hudhBLCfbn19jzZKyUmzeuNDjO8AzsxQ0wKMLLxnaYce3OzFgHu39mdd1Hs9jTHj
	SWeKrmx8gVjcIdhkXJ8xtY62WXLro51grbACREHk8jo4kXyY63GRsvSK7Qpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753313798; x=1753400198; bh=DEZ80ZDvCBX++//Rb3ZuAtpyVV+fL4COVjE
	MofI19ao=; b=gLAbW4xb3MPcRsW18Rpld/IJ/r+jtM6PvJ+h4+XI56rpOinaD1q
	iZ0EBKh9UygFCjRG2w2UM5Dj0jvAWX9lRPKrx7fnf7vYAb9ja1RogrMXYETE2N7L
	1r2iAgfiCPRJD0U/THSk5wtyFvfvPUVMathtuZFwS1SqWkj/kFOBpqFD03m0jDO8
	UQE5ZsB18YPlV6E4bglAQQrVYkcnKPVEq5itJbScB3RThKBQkqLbYXZ1bMaq/7WQ
	zVEs0kQeIrJGQ1BHsxIOhZQtsknzKIRQZ56PYB/zbZKXa/HSyNiFCys60bBTiXUP
	jA6WKf38RXPlAkchWRDQspGYode1TXYODSQ==
X-ME-Sender: <xms:BXKBaOZ7ET6e6RgRmtoSlEzLKdgTYgZC6hOgtxd6cPJkiYyT3-upfg>
    <xme:BXKBaL9ytDys7t0VEXrjjgjTFwtfiJfAClcbCc31Fj3Za71dkBvuZjLIUR5ljZWO1
    Gj59WYLTA8Mo49-oA>
X-ME-Received: <xmr:BXKBaFiDIDtH9IhD6cA6f-u0OS14BkyEjf86WhvBMtajdh7B6k7d3BhoWBbDMf6QWfaOQU9IQpD6vrxVzDObF93okJZmbhVl3CBIubA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejledutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    uggrnhesfhgrsghulhhitghhrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:BXKBaDcyOnUjpJp0MhR-ChcN18IaoHgFV9946MhtstNEMpdjNoIaaQ>
    <xmx:BXKBaEoZL36EZlU2ANWR43O8n__dJkH0Lr-NdSyD-R4WBm9Hxj4sTA>
    <xmx:BXKBaABU6Q55Xzz5jjQCGSGf0w1Kg_kOX8h25nJBUPcE2h_w912Xbg>
    <xmx:BXKBaJaq_YXw9V_6QSbCLL4wyq6Qn629MaVKNnsVQZsC2uxlUrMckw>
    <xmx:BnKBaA3jJ4AWKDGbw4tegYdIchAB6pmhgAalCrASfhFNcKd6SnmVHsCp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 19:36:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Dan Fabulich via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Dan Fabulich <dan@fabulich.com>
Subject: Re: [PATCH] doc: clarify difference between `push.default` `simple`
 and `current`
In-Reply-To: <pull.1944.git.1753311625075.gitgitgadget@gmail.com> (Dan
	Fabulich via GitGitGadget's message of "Wed, 23 Jul 2025 23:00:24
	+0000")
References: <pull.1944.git.1753311625075.gitgitgadget@gmail.com>
Date: Wed, 23 Jul 2025 16:36:36 -0700
Message-ID: <xmqqseimjx8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Dan Fabulich via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Dan Fabulich <dan@fabulich.com>
>
> The documentation made `simple` and `current` sound identical. The
> difference is that `simple` strictly checks that the upstream tracking
> branch's name matches the current branch's name.

All of the above are correct, and a patch that sticks to fixing that
would have given us a great improvement.

Thanks for working on this documentation update, but it seems some
unrelated changes are mixed in.

>  	Different values are well-suited for
>  	specific workflows; for instance, in a purely central workflow
>  	(i.e. the fetch source is equal to the push destination),
> -	`upstream` is probably what you want.  Possible values are:
> +	`simple` is probably what you want.  Possible values are:

This change is not explained/justified at all why it was part of the
patch in the proposed log message.

And I do not think this is a good change.  `upstream` is recommended
for most people when they employ a purely central workflow.  You can
start working from the common 'master', even on multiple topics in
parallel at the same time, and perform "git push" with push.default
set to 'upstream'.  With 'simple' you cannot.

    $ git checkout -t -b theme1 origin/master
    ... work work work ...
    $ git checkout -t -b theme2 origin/master
    ... work work work ...
    ... changes for theme2 become complete first ...
    $ git push

Here, if your push.default is set to 'upstream', your theme2 updates
their master, which is exactly what you want.  Then

    $ git fetch origin
    $ git rebase origin/master theme1
    ... rebased on updated 'master' at theirs --- at least it should
    ... contain what we did on our theme2 topic, but possibly
    ... changes from other people.
    ... more work ...
    $ git push

Again, your theme1 updates their master, which is exactly what you
want.

> @@ -23,8 +23,8 @@ push.default::
>    given. This is primarily meant for people who want to
>    avoid mistakes by always being explicit.
>  
> -* `current` - push the current branch to update a branch with the same
> -  name on the receiving end.  Works in both central and non-central
> +* `current` - push the current branch to update the branch with the same
> +  name on the remote.  Works in both central and non-central
>    workflows.

Again, a change that is not explained/justified.  "a" -> "the" I can
understand (i.e. a branch with the same name is unique over there,
so "the" is more appropriate), but not the other one.

>  * `tracking` - This is a deprecated synonym for `upstream`.
>  
> -* `simple` - push the current branch with the same name on the remote.
> +* `simple` - push the current branch to its upstream tracking branch,
> +  but only if the upstream tracking branch has the same name as the
> +  current branch. (`simple` will fail with an error if the upstream
> +  tracking branch's name doesn't match the current branch's name.)

That is correct.  The additional text may be somewhat helpful for
somebody who just got an error message and wants to understand where
the error comes from.

But stepping back a bit, is understanding why it failed the primary
thing our documentation should aim for?  I'd rather see our
documentation help the user achieve what they wanted to do in the
first place.  I.e., Be able to push without an error to publish
their work.  And for that "this will fail when X" is less helpful
than "this is appropriate if you work this way."

    simple - this is like `upstream` but with additional restriction
    that the local branch must be named the same as its upstream
    branch.  Suitable with a very simple centralized workflow, where
    you fork off of their 'master' branch to create your own
    'master', work there, and push the branch back.

>  +
> -If you are working on a centralized workflow (pushing to the same repository you
> -pull from, which is typically `origin`), then you need to configure an upstream
> -branch with the same name.

I do not think this removal is explained/justified, either.  Those
who set push.default to 'simple' while using the centralized
workflow must use one-to-one correspondence, so this advice is very
relevant.  What makes it a good idea to remove it?

Thanks.
