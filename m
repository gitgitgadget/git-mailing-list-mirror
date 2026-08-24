Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A21990A7
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787535177; cv=none; b=A4nOl5gGEIPwIVp+r8yaNMo3LqHnnfzG0NiK4gNaqYqzIeRqNY+y9qqcEiJ5B/PPVhnSwWzdVcCQk6zq8Bc1CL++3Wokeqr5uvZegKJoejdGEgky5DkEWn4ZfUnfzszimi1A44B42UzJPXzf6gQkuXzDFNgD/vxYdLwAdeGfXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787535177; c=relaxed/simple;
	bh=zLb8RMQH8oqU+losqrz+youcqAsGidC2OESS2BosSaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=llC16tTZyuUR9dx2EDpzvJtJ7wvishMMQ+i+xegcPzp7+y0HOghr8cfqr5X8IAiGS8ZuQaSVYQ9WY0a19TCPIO6540GrbFXBqVmhDsrYvnfrDjXWwzhgNXVneWg0gNR1Ft2upf5RQ+js8ixVOFtkGny9K7yofbdQFhm5tiKyMWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=USR4w5Um; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fbdoFxIl; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="USR4w5Um";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fbdoFxIl"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ABA7314000F3;
	Sun, 23 Aug 2026 21:32:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 23 Aug 2026 21:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787535174; x=1787621574; bh=stRN1AVjsk
	Uyzt5g5jNhHuEC3KCWa+uojZl3Q0IGoco=; b=USR4w5Um89wXecxbQuMYf264Tu
	hLFwA9y5d306bNrvZYm4XSYK2JLTR7MPJ+LRCFskxqVBAMkJ1fqmpBczQ2NqL3ev
	oZdriHfQJ6wL9gbLgSNUH8NOmXfivpFIeJfwDq0a97hwdmmUbVdSIndUpt/xOfmT
	3pBYNPDk3JwYp3p6vLfe0T1BeSV1aWopQMP+WEmYabTsy2HeQKSdIMX9QnCsJOb/
	NLsi/Voa1QbI8RAwZR4wdv14tuw21auex0t8pUZ7qRx+pRsGMXO8niV4Jp8JfDaw
	rYDKAoPzUWaV1sDWwA7J3UcWb6C93BCBGJ7x23FK2Cv/4gM+q3JVTDF95fyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787535174; x=1787621574; bh=stRN1AVjskUyzt5g5jNhHuEC3KCWa+uojZl
	3Q0IGoco=; b=fbdoFxIl03X6Lk0iUIFpb7IzShhqsvNJAlJSfifmaGsMkRBx81M
	hUcGDI/AeiQEg3e1FwqTYvLALNar87orm/AtEQ/wfoewGoCne3JYaPKrxsFtvy9+
	D9lGUxM0/HNYex4CrE9gHupD9zA06/PNrbCD0s3p3K2FD1a+JVKnibQ8iEZIJcZO
	N7I5xldISg0w/Fm5HQSYUG1T55sozJx5BXELeMoKmUIRu8SlFJtZLKtESwdVFx1W
	VrUEyhbn5LvNKibw/aMkt3o4nd8wG3p9WbptQJx3GSn/AY9qF00q+xS20r1J7C4X
	iyg+PzW64MI2G97pwOSHPp13qu7FCTnxyTA==
X-ME-Sender: <xms:RZ-LarHA95QIOUtI41skh_S5Y0-S0LmRH-qiOk4QZ7yO9tFKes8qXg>
    <xme:RZ-Lau2wNYuK501Nm0mkocsYyFR1uat82d8wdLBjsSwZdVqNLZLs2r9Fa_sAGzU_O
    z84HU0da3-u29ZzDFsF5r6-0d_PWnzuRbKygcx4qOVBI_b2BP7Ktg>
X-ME-Received: <xmr:RZ-LarJNN7y_V-P0bJCpkU3ASv3_z3SuoXvW8OKDaVXHk620U0apzP8PCpLLOTpXSvJuqjZe_w8isaSigLXc2ipYsJaE_JR-7Q>
X-ME-Proxy-Cause: dmFkZTFHZ9FlK+iT1R9yvOf5hjz+JHuaSSyXnVzur5oJHhxlftZbmv/8psu7iYZLSDGKkN
    c19SZVbyqmEFOOwBh/bHQ3/OtgV1cLt5+OrT6LF4FANyrMFPFWi8vwwZbXjLpQFkByJgLi
    8xayE5FIe5ecPQk+4+Zg4Lj476hvBMyDMyZeSY10p27AFibUvnA32R5CuV//yr1m6Wiwe7
    hBdeuBsbMto+chk65u7lElr7B9iBN9jrCN8kd7MkxcLalOzMDsQad2QegW7fn7X9K291LF
    lK5rIgX/IkTXBptPiE50J43NJGVHfCvUpW3++pLdQGsKL2bPrr6kwe1KQW0qBNP5DzWIBk
    qxSqf+H7nFwmciNxkiA2+qSvXfQm/iMaeRJhiv/pojDnIb3e1CHc2QfsmBMtbIwUgDIQqk
    +kLQLn6POtchTJwIcRUt0yhbH9aTg9B6h1cUNIcdn8MVmkIKcUwIRZcsL7CQXzllHj+oDe
    xkbR7Yvoxn9vqR2JqJkUm9hWeBLN0EQe4m6/cNz/xliBBRSh5aNFlSe0KIlyz6HS0tG31/
    QB5JqhKe3tjauce1TekICkppvMEnBUbnl+K+UCEUSKADjuSf8Ik266pvXZKd/C3qw53R5v
    pAQvdzZ5jwdNRJkFtogXE4sODrMQ17cqOjl3mEmk2n0rY9nx8zhdNVSAN+Cw
X-ME-Proxy: <xmx:RZ-Lar1MHN0ywn9Z7OJbdd57KXAjdAFbdY0Rz_1vYD9MtTME8TSIpw>
    <xmx:RZ-LanldKLBSHD0Alkh-fxGPOFUvi6mEVPWcOO1VyDfOWsi8_RJZTA>
    <xmx:RZ-Lauh1fPx0_01l0BafGwElC_a86uoB0wemIyagYLBlKKIVsX0gwg>
    <xmx:RZ-LamTxQ_zUwh3hV7gbyBQo1j2loZ4a9YPfvEix2_1Bm1DY4RvPyA>
    <xmx:Rp-LajMhE_K_UI8E9lNHn-hJXGzzzGkgP9UFRsj6LBp8Y7mP3_vWFxpK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Aug 2026 21:32:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Delilah Ashley Wu <delilahwu@linux.microsoft.com>,  git@vger.kernel.org,
  Nils Fahldieck <nils@fahldieck.de>,  Patrick Steinhardt <ps@pks.im>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Delilah Ashley
 Wu <delilahwu@microsoft.com>,  Derrick Stolee <stolee@gmail.com>,  Ben
 Knoble <ben.knoble@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Jade Lovelace <lists@jade.fyi>,  Glen Choo
 <glencbz@gmail.com>
Subject: Re: [PATCH v2 0/3] config: read both home and xdg files for --global
In-Reply-To: <CAPx1GvcDNx4BUPQkVjbKxYLxTJ=StvLC43R0S_2=T0R8NKbZ7w@mail.gmail.com>
	(Chris Torek's message of "Sun, 23 Aug 2026 05:36:28 -0700")
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
	<20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
	<CAPx1GvcDNx4BUPQkVjbKxYLxTJ=StvLC43R0S_2=T0R8NKbZ7w@mail.gmail.com>
Date: Sun, 23 Aug 2026 18:32:51 -0700
Message-ID: <xmqqo6esti9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris Torek <chris.torek@gmail.com> writes:

>> Git still reads the XDG config as part of its effective configuration,
>> as shown by listing the configuration without `--global`:
>>     $ git config list --show-scope --show-origin
>>     global  file:/Users/delilah/.config/git/config    xdg.config=true
>>     global  file:/Users/delilah/.gitconfig            home.config=true
>>
>> The documentation, quoted in [1] and [2], states that `--global` should
>> read from both files ...
>
> I have a related question: which of the global file(s) does
>
>     git config --global --edit
>
> edit? Which one(s) should it edit?

I _know_ that having git-config read per-user configuration from
both places was a deliberate design choice to help those who choose
to migrate away from ~/.gitconfig to the XDG layout, while making
sure we do not disrupt those who choose not to migrate.

For the write-out path of "git config --global set var val", we also
chose accordingly, knowing that the majority of users back then had
their per-user configuration in ~/.gitconfig and some, but not
necessarily all, wanted to migrate to the XDG layout, while avoiding
writing the same thing twice to different places.  Therefore, "git
config --global --edit" should follow the choice in the same spirit
as the existing write-out code path (and no, I do not think we want
to open two files in users' editors).

As to the primary focus of this topic, I think "git config --global"
for the read path was not designed as carefully as the write-out
code path or the general "git config" sequence when we introduced
optional support for the XDG layout.  Any discrepancy between "git
config" when reading per-user values (to be overridden further by
per-repository settings) and what "git config --global" reads from
per-user files is very likely not due to any deliberate design
choice, but merely bugs caused by a slip of the mind.
