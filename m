Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81E337C8C
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OkDwGP2y"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD4811D
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 11:09:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 169B01C9A93;
	Thu, 19 Oct 2023 14:09:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oSYpOX4Ii+xJ
	ucItxp1GqQrh5TCDGJ1uGrul+8QcYpY=; b=OkDwGP2y8PurOcYqVJdaXn7hRjCi
	j38L6i4Q3l1oGOsW25zT3Ry9gm007hFcvgcsOyT4WtEuevWJgg4/zyDqOgV3sEDE
	Z3CZYOFHBNwEXg1XG3oAqNIDQ32cxEgdMHiTro5I0Ede9MuewKItcdg0H1RjyknI
	3zAN/rihKyxtBbY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07DFB1C9A92;
	Thu, 19 Oct 2023 14:09:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08CD21C9A91;
	Thu, 19 Oct 2023 14:09:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc: ks1322 ks1322 <ks1322@gmail.com>,  git@vger.kernel.org,  Victoria Dye
 <vdye@github.com>
Subject: Re: [PATCH] diagnose: require repository
In-Reply-To: <CAN0heSqmZ7QXJbet2Tp=YYCjBLToOHtNy+n=zcf29XYaukYN0w@mail.gmail.com>
	("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 19 Oct 2023 15:18:45
 +0200")
References: <CAKFQ_Q9WjF9i-Rx2jdCw-adPVQrWNfNKrDY-em8Rpa5RNLXz4A@mail.gmail.com>
	<20231014135302.13095-1-martin.agren@gmail.com>
	<xmqq5y39unvc.fsf@gitster.g>
	<CAN0heSqmZ7QXJbet2Tp=YYCjBLToOHtNy+n=zcf29XYaukYN0w@mail.gmail.com>
Date: Thu, 19 Oct 2023 11:09:05 -0700
Message-ID: <xmqqo7guwkla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 981D0F3C-6EAA-11EE-89FD-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Correcting myself: The zip archive would actually contain
> `diagnostics.log` with some general info about the machine and Git
> build.

So it could contain some useful information without a specific
repository, perhaps.

> Good point. TBH, I had no idea about `git bugreport --diagnose`.

You are not alone ;-)  I didn't, either.  Before responding to your
patch, that is.

>> +       if (!startup_info->have_repository && diagnose !=3D DIAGNOSE_N=
ONE) {
>> +               warning(_("no repository--diagnostic output disabled")=
);
>> +               diagnose =3D DIAGNOSE_NONE;
>> +       }
>> +
>
> When the user explicitly provides that option, it seems unfortunate to
> me to drop it. Yes, we'd warn, but `git bugreport` then pops a text
> editor, so you would only see the warning after finishing up the report=
.
> (Maybe. By the time you quit your editor, you might not consider
> checking the terminal for warnings and such.)
>
> So I'm inclined to instead just die if we see the option outside a repo=
.
> If `diagnose` the command fundamentally requires a repo (as with my
> patch) it seems surprising to me to not have `--diagnose` the option
> behave the same.

I have no strong opinion.  Victoria is on Cc: already, whose name
appears a lot more often than mine in the shortlog for "diagnose"
stuff, so I'll defer to her area expertise.

Thanks.
