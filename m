Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A13F105D
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787866745; cv=none; b=A74rTB93bvZSNRYWF94j2Ng3nDOPIHfv+H2O6iCPk2p5soi4EajxNe0GqynGonOpqoMRXIt51Xa8rmM7eRSvKq50NfmhtaKvJU/G9EsV08/R37sb5xXcRBNAbdzqtn341y3d9WW4odAjyL40PWjPo89Nvao14CsQAo58c77sZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787866745; c=relaxed/simple;
	bh=bEnireCq0RH6DLCTSlxSBL5TaB+3RLRYmcbvs7jC1Lc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tzR9TLIoQBxiK39r7plbY+7EI3vGR/PAlk69jJZC9n+8TxUukgOEt6+qo35jxkbKCcc7P2RLt+7qpYFBXm5qt0tIufIF38oL39PQfjbBFf7VVJVgSjWEj4WcA9rCmE73qI5JY96cHPdy7wIBGvSzMdGJKZMVktV1Hkxe3Ofk9uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xKIEkIEq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7XAnXR+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xKIEkIEq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7XAnXR+"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 80888140014D;
	Thu, 27 Aug 2026 17:39:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 27 Aug 2026 17:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787866743;
	 x=1787953143; bh=2dJ7uZS1t+H/okYb0sbtBr9D8g7KbSzZy+BAJyNfa3k=; b=
	xKIEkIEqcUXzyLJl4vEAMNA8aQBAtWCgA5r9srjrRpTuaUB2N1C4ibYkdDeRdw2x
	7DKbAJlqXJ2A6Q67XSha/NpvfkAKNk5bfx5ejt8x3kmvk7aD+attYWcfTw7ItwIy
	2LS7pGOPiY7KVEjJtRgBWGy9PLuwWWGQyEqfP2pvP9orgcRbUWhmD39dWFqn59Uh
	YpOJhb+ZSErZ9SiCOYL7NZH6jKIAQ4Nigy1Wp0lt2zJjDbIhVCI/JNRePiBiKXaa
	3bYREoIFoKpZPb0crJ/RBHDux+L/6I7f5Ju0niWV1R0HyomTIzTDZdV9k8zPJqXI
	3/3L0KkrDNqNlbxtkEzeTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787866743; x=
	1787953143; bh=2dJ7uZS1t+H/okYb0sbtBr9D8g7KbSzZy+BAJyNfa3k=; b=j
	7XAnXR+8uKFL94HDNZ6vbL+gRIVfY5aujY9hr9cdbFLUWB40ljfv/1V2W4bClvLD
	6ciIlv9xfL7b3kuaSRoCG/PQ0nW1FAndBweLCA0c0AsW39U32xvhg2ZdipBKnQVj
	EMS7QPvRADd72feW915LPlOehaCHLz59wfYoW59QsYXfX6nJ9+5s1ispplXPpnvh
	yaIle+nxEy3hosro0W5l/FbMwg6Mlro9qUPIe7D0D+VqhZGhypQkMsSrd3bD9fUL
	Cv1n0ernwlChJ1tmJOeLjtyHy96lNH7lT6hp41M7cabRxRcF5HEUCJQIQ9vYd9Ru
	e6HyzKtEPEIHJ8ewXleVg==
X-ME-Sender: <xms:d66QandBcJaCEh4KWTsC4PLfOIH4mPZEReKD2u6y-XFkSVEChdOUTg>
    <xme:d66QanzXOuJzHp9wlMZtHWzFtqjofHUYJkeLyy4kx88Je43Ie5bOCf3p_02CmLjf8
    QNxfGQC1Ct0x7J5M6lElWWCadI2HBTYS8mmGemOtSppjM1j2gfO6dY>
X-ME-Received: <xmr:d66QatE1FzimAOTG0rbT9t8p84Ab8kDnR7uNtikX3qfJBcNxsJEfAKBwp78MViaqLzN7pGsaLYHiE9rNl34TBoyHnHe7t0s6Mg>
X-ME-Proxy-Cause: dmFkZTFEkFkF/hkOK/JwtmrOP1y269/uXm7k893Ioh+J4WB3xFjpUBXUNM0X8+elcb/Nm2
    EiFgLVi3tvpEBeq/N/EDrfqTLIudCrkLahf7TWj3z3Cn+TIG9YR7pQaIgAAKTHyPbjfMJl
    5PljL3NpHpPvX5gaDeCGWec6GPsUbqWBbL1AxDZwFKJFqAXdECUs7RNSzLqzV2tw6uS9T+
    lqzl8OyCKX7G/W+nFczFamUUfCAEissZszwfgIrNTclKvJ7kitxx0L/CXi3nsIb8jXex6h
    xZsnyutheI+mUQxBUo4rpPI7DVs5V0HdIxoOjvOyN3GawaTa4mErLZ4rZzUyxqCTRZR7Zm
    x5WuA39QcYEMaMaTZHKz9zD53o4GcWD7U67RWXV9/PgMyiwSjOOhbXF4Lul6rN1w9ORnBy
    wq3thzLJAmEd21ZlGpGODEhbHie5oOWDvI8jmjd7DIhMxA3oNbwJTMVdqhH6zs9mO5tYix
    Kja7sytd0vaGDgWcX+/8urRYN7lQb4rWlcRUnX8aXldWa8Q1D0AvNuXd5C8qE87jx9BVDp
    6b8EMb9f/eQfSn0Ly+sBVipA6udmWeTWI+tuUFl9SfYMdLLQFD1YwUoou7xBMILI0vqq3N
    ApJdLUCCawwNu6/Nrs6qaIPQLvk2VM92neqye3HqEHe615L0xTdLxmtWkusQ
X-ME-Proxy: <xmx:d66QarzlKEQYbGdJq-uYF389TD2-MyqPAbyvlNGAsW5CoXc0quS46Q>
    <xmx:d66QausGt-MfDZovLVTRo6WRUP_4EhcLVYo5-1XCMIt5UnGWZLcFbQ>
    <xmx:d66Qao0ntBfJq2OKNurcKmjd2l3g3vQPUWdlNkQevAvVkBvkOzhfTQ>
    <xmx:d66Qap9rZso7cKVA3xafGwvwRN_AgMSR_IkKpc1wV7lF6kTZDy3bhQ>
    <xmx:d66Qatty5CBl3D4KjJwgokb4yOhJ40kh8dv1-zQ0Rr5OKVgEhWKJzpVc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 17:39:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Hardik Kumar <hardikxk@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] builtin: replace the_repository parameter in
 is_bare_repository()
In-Reply-To: <F276C11F-1904-496E-AA77-953724362C9A@gmail.com> (Ben Knoble's
	message of "Thu, 27 Aug 2026 17:12:19 -0400")
References: <xmqq7blb8g04.fsf@gitster.g>
	<F276C11F-1904-496E-AA77-953724362C9A@gmail.com>
Date: Thu, 27 Aug 2026 14:39:01 -0700
Message-ID: <xmqqik4v6y6i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 27 août 2026 à 16:30, Junio C Hamano <gitster@pobox.com> a écrit :
>> 
>> ﻿"Hardik Kumar" <hardikxk@gmail.com> writes:
>> 
>>>> In general, builtin/foo.c::cmd_foo() are concrete programs that work
>>>> on specific repository (i.e., the_repository), and there is not much
>>>> reason to rewrite the use of the_repository to use "repo" given by
>>>> the caller which is git potty.  You'd also need to deal with the
>>>> case where "repo" is NULL (hint: "cd / && git foo -h").
>
> [snip]
>
>> The utility functions builtin/foo.c borrows from outside builtin/
>> directory are being "libified" to reduce the hardcoded dependence on
>> the_repository, and cmd_foo() can call these functions with
>> the_repository as a parameter.  But we have no reason to waste our
>> time updating (and also reviewing patches that make such updates)
>> the built-in implementations themselves to take a pointer to an
>> arbitrary repository.

Line wrap to reasonable length.

> Hm. What if a program wants to do « exactly what ‘git switch’ does
> » sans shelling out?

Instead of cheating, properly factor out reusable part from
cmd_checkout() into a set of libified routines, and make both
cmd_checkout() and cmd_switch() to call them

An approach like that would help "libify" things.  libifying is not
just reducing dependence of globals.

Calling main() from something else is not a libification.
