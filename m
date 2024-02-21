Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034311FDD
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708479985; cv=none; b=Omct3EiM/6s2nXAazEzkleAJanjAjRfdDGA8neAvnX9eINybxJrwE43JcWBkhSl+0HE7FzsIwcEHwDASl1NJfCAg/2WJ8DRsbHmnzHc2ErU0/ebFfQn67RKYW/Z1UHTgQW1MiL5bCBLiSU9PxuG0PuLGidEouh2L+nb/9kmMHSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708479985; c=relaxed/simple;
	bh=mm95qqBxlipIdTtMRYWqJ66PwbO7y/sgxz+JkuYK8JA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bg5HG9EEzvF1git6CIbKaITKpDGXRGwjeVuDMMapH7vklAGo0OsSPBy4/y1QipUJr0UIm+5aM4+T5NeCSjk1GsfMMTqIOZm0UkZKcvZnD5/XvRo+Vqe6ot0CRl12Kp6lBDdpbZ/27PeIKzJSa2e411/GfqkIfb84V0CKBS1zWB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=f1HtUlzK; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f1HtUlzK"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABAE11ECC8E;
	Tue, 20 Feb 2024 20:46:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mm95qqBxlipI
	dTtMRYWqJ66PwbO7y/sgxz+JkuYK8JA=; b=f1HtUlzKUn9dzRc9gjiYPnQLE8fb
	COsdXNLvDQ19SkiKjxKCcU7SRXLPAbfla46YqiKygo1o0RBzOOzBBEJzr/4tEjJO
	yGMxaTeSEgZOmrqnq4GmNPzVAdSe3xzY+PCovArdRXBhBjHQKvx6Kpa1kzQ0n7kO
	2GM+oJ9fRV1GhfU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2EE01ECC8D;
	Tue, 20 Feb 2024 20:46:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16E961ECC8C;
	Tue, 20 Feb 2024 20:46:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] completion: reflog with implicit "show"
In-Reply-To: <dd106d87-3363-426a-90a2-16e1f2d04661@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 26 Jan 2024 21:20:07 +0100")
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
	<5991b58c-770c-4aaa-bce5-f396d9f7f16f@gmail.com>
	<xmqq8r4cnfju.fsf@gitster.g>
	<dd106d87-3363-426a-90a2-16e1f2d04661@gmail.com>
Date: Tue, 20 Feb 2024 17:46:20 -0800
Message-ID: <xmqqwmqyr3mb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 03E60F86-D05B-11EE-852E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> So, when we see something that could be a subcommand we complete it
>> as a subcommand and return.  In your example, how should
>>=20
>>     $ git reflog def<TAB>
>>=20
>> work?  We try to see if there is a subcommand that begins with
>> "def", we see nothing matching, and then run __git_complete_refs?
>> What if the branch you created earlier were not named "default" but,
>> say, "delmonte", and you did "git reflog del<TAB>"?  Shouldn't the
>> user be offered "delete" and "delmonte" as potential completions?
>>=20
>> >  __git_send_email_confirm_options=3D"always never auto cc compose"
>> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> > index aa9a614de3..231e17f378 100755
>> > --- a/t/t9902-completion.sh
>> > +++ b/t/t9902-completion.sh
>> > @@ -2618,6 +2618,14 @@ test_expect_success 'git clone --config=3D - =
value' '
>> >  	EOF
>> >  '
>> > =20
>> > +test_expect_success 'git reflog show' '
>> > +	test_when_finished "git checkout -" &&
>> > +	git checkout -b shown &&
>> > +	test_completion "git reflog sho" "show " &&
>>=20
>> IOW, shouldn't this offer both show and shown?
>
> What should we do?

I would imagine that we should make the above offer both "show"
(because it can be what the user meant) and "shown" (because it can
also be what the user meant)?  But thinking of it again, because
"show" is a prefix of "shown", this should offer "show" and then
another <TAB> would offer "show" and "shown".  At least, that is
what I would expect from the usual bash completion behaviour, which
would look like:

    $ mkdir /var/tmp/scratch && cd /var/tmp/scratch
    $ : >show 2>shown
    $ echo sho<TAB>

The <TAB> makes the above line expand to

    $ echo show

and place the curser immediately after 'w' (without a space after it).
Giving another <TAB> at this point offers two possible candidates.

    $ echo show<TAB>
    show shown

So, I'd expect a similar completion to happen, i.e.

    $ git reflog sho<TAB>
-->
    $ git reflog show

because there are two candidates, "show" and "shown", and I can type
another <TAB> at that point to see the two candidates.

    $ git reflog show<TAB>
    show shown

If the branch name were "shot" instead of "shown", then the possible
choices would become "show" and "shot", so we'd skip one step from
the above and immediately get the two candidates against "sho<TAB>".

    $ git reflog sho<TAB>
    shot show

That is what I would expect.   =20

Thanks.
