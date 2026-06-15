Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBDA413220
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543017; cv=none; b=jktjJ0ICG048PDqWbD7NMe8MmIE1i7IFDQTwZj6dnOzdcg4Fy23rbxZEjlJuarTHwO3gUeebd4Shxe/4dSiXCw/h+kHcDmjNnE+5SZiSEYCdqX2spwSBte0fbdMAi6Setz7CHYfwJrSqGJTg5CZU6vKGc3xlVHrXH3iqNly8hb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543017; c=relaxed/simple;
	bh=O103IGDtG9EVsqmwaLLpH1WeDv0y849xHeNsW5k3nJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AUBzvsjvFGLlzn4QLFUqp1BH0ZE5HP3Twip3wlsPyn/E0gUZZxn62IK6t+Rl9BN+HEeysdtSAVUuW5FgLUDjHllnZ5EQf7IqBXWaAV8syE6kTeLZKHyLzaGpCbsNEJb0RU/L52oZwuUW2mAoMlQI+Cp4Pd8GMLQDgtBaUBpYTD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WOash/rv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B587fr1r; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WOash/rv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B587fr1r"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A927140004E;
	Mon, 15 Jun 2026 13:03:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 15 Jun 2026 13:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781543014; x=1781629414; bh=CZWgDUmCjs
	8j0wq3pvZjwjZsAI8vWy9T9J2wZovNEi8=; b=WOash/rve+Iktz/cdOOLyt12Rf
	QKJnZGGTgrD1iiV9pBQIuMhZwGWS2NitDpPSegCM6TWRCNbHUxEUJjikdAKipMuj
	xQ2lkZ3Wb4E9kuHUgAVk0gRIJzQUGUoY7qlrMV58RgDsqzInQmhoQuBY2UctcUOQ
	3HY58dDZ4TPxZGxG8yeJ+vaPzG5zYcmDHv3SV8H82QW+BsAgEjRApC9kDW2BTPtw
	ttFdlBC3lmErUKLFOjKdVYJseT6nj/G8SNwdoWe1gd932CxE9h69PFIXniTSmSav
	Rl+dXWm5gCFKFUkkF/gbo2L9ntYmCk1AhCTq//2bsnTvLjBK9NVaYvXPWA6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781543014; x=1781629414; bh=CZWgDUmCjs8j0wq3pvZjwjZsAI8vWy9T9J2
	wZovNEi8=; b=B587fr1rFdAqSEFVcLQ/NtdKke4qxA2D1iAT1OsvD81AYR0658+
	uXE6qhgBTuBsFuYMYfDzFwwKRGcWTAm99ZgQJqk0V33h53pWwFSb2U5oJEQi1gjF
	Mw4qCHbFVdb1OiL9T0p2PP7Kv6TagtfkcoFnL0aa+SD9vo4z9hHqf96w/+Kaa/q8
	9ZN4r2qQwMEdXqrrEHz+gmqsdPScKypdRkEoOzDUAvhLQxDRjRBHPZH+pyDosCHv
	Ga76+G8viwvCY4BcyLrI4bgaYya0S3hL9wCGUe8z8uYKh5sr1eA/R2IKj84hRxrH
	S/R4qmEAVILzM+/tXIMq6jmKS38FJ0jS6ww==
X-ME-Sender: <xms:ZjAwaqzdMo3vzhLFjsaemDZ9M8SA8l-MakLk0JOyQExCUsb6HXHlFQ>
    <xme:ZjAwatvhMgbLWzzt657V00uRtLQZWe4JOwaybFx_WhI96mpFuPNQPaOx1teqSvYwA
    PQYJje3sthxSkAgn3AolndCCVM0gk2VCKpgeM_9AEsF5YSm9vS94Q>
X-ME-Received: <xmr:ZjAwapv09q7jhz5iq5LD0zRA0t60RZWJJT9t83b_z1m-EuTznGbfu9BcswZj3gfTE1POviaiHcFe3XA4q3udoh7sWcx5s78EWSQp>
X-ME-Proxy-Cause: dmFkZTEFweoDU+to70G7kfaMDNCaWWZA5Kxbp6/vhXvnUce1itJTmXaoKIEikLOPfO8QQH
    id5Gej4waw8WdkrIxVKZazBfJMMqkqFA3hVmOGejAIvj4RpDD5eH5cUNwMR858sHcubvvD
    8ZWS9ESvlZ87Z5/q36TToxy0NCbB1amssbBzSF0gSAWVUO08UkPG16BQYx0OLmEnMpwLBy
    TE0yF9cPwBY4id5BsrpyyveyOnrLGegiQ70KWzR9p6CH3bO69F0tn//dU77N7NXi1jYDYd
    lzu5QjhkeiI02shSmiO06LsTM/s8znO+XpqTA9iaV/uwmUgvgbhEvfkpBCJpR2Rg1naJOi
    EXMrriKwjA1ldtTTcqvaaAJPybZFBVnPpGV4px4i4GHWwQChXtx+6ivDcdx3M0umm017IN
    R5ftYLoO+HCgysAOB+7ouU1z9K6Sc9WJC67PgzMVXeMtl7+oPQwuVizfNrWkxPqRt57nVM
    T07zvbMECRVVYF5NUVBdThHZv02IkXa4sWkG5I7uIeEHWsfVnFidRbzYRLYt+4eURWdIDv
    pu+0/u/zR9l19Gdn9DuCh5AGDJKFS/irvZq9QCOqS/iShyXZUeopL1ZMb9x7E8NJCQUKSd
    2hjkW80TS+BvSA7gQLPklJHyd+1eGO7yxc/pXLqPYEtapIdwYaPfHcelg4ZA
X-ME-Proxy: <xmx:ZjAwaqPrlzBpau-JBcIKhEaRa_Th1l_2u3L2ok3gEyh1f72M5WhI9g>
    <xmx:ZjAwav1BCS13_kQVapEFhg9Ce5aFXuestxdCNJa80CbTVoVBH7ualg>
    <xmx:ZjAwauPnB8SEx7zWZVgfaDyreVC8tOhCPkeWlZOFiWW4jqNthpaAtw>
    <xmx:ZjAwan23yp73aWEmb4JriCG2ii_l6L8JBh2zFtwWQE8NC6Q_simsAQ>
    <xmx:ZjAwal1ZQ6M8NjrbvhNuo7KX7J7bJ5QGxlQgr6h9jNCfPyQSAbJ-uBFQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 13:03:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] update-ref: add --rename option
In-Reply-To: <ai--jEk23E7RJPnc@pks.im> (Patrick Steinhardt's message of "Mon,
	15 Jun 2026 10:57:48 +0200")
References: <xmqqv7brz9ba.fsf@gitster.g> <xmqq7bo4n4ge.fsf@gitster.g>
	<aiugat0gvprSX5yr@pks.im> <xmqqqzmbhikj.fsf@gitster.g>
	<ai--jEk23E7RJPnc@pks.im>
Date: Mon, 15 Jun 2026 10:03:32 -0700
Message-ID: <xmqqv7bjbusb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jun 12, 2026 at 08:41:48AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > A slight tangent: this is part of why I really don't like commands that
>> > determine their mode via flags: you now have to worry about every
>> > combination of flags and whether they even make sense. With subcommands
>> > we at least only have to worry about the set of flags that directly
>> > apply to that given subcommand.
>> >
>> > Makes me wonder whether I should have a look at extending git-refs(1)
>> > further:
>> >
>> >     git refs delete <ref> [<oldvalue>]
>> >     git refs update <ref> <newvalue> [<oldvalue>]
>> >     git refs rename <ref> <oldname> <newname>
>> >
>> > I always wanted to do this eventually so that we have one top-level
>> > command that knows how to do "everything refs".
>> 
>> That may indeed be a better direction to go, but isn't update-ref
>> the "everything refs" command already?
>
> Well, it doesn't handle reading references, which is something that
> git-refs(1) already knows to do.

OK, fair enough.  "git refs" should become superset of "git
show-ref" and "git update-ref", I guess.

So do you want to take the topic over and add it to "git refs"?

