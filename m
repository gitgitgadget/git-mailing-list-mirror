Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5913A271
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714109959; cv=none; b=PIeUQCPCyak7zkiOpL/rGzDeXAgGrpqA4Dg5VBfnnjPknd0dvoPPxbgy1PWvvwJ3YQylgqE1z8J1PoUaKv9H0JIan4Tsa4AyvLOh873Tk9dIlntpMLyhteGC1WB1BRRBM5FL/a1T5xxXOorgRq8cKvrgvx53igjytIEbMK9RjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714109959; c=relaxed/simple;
	bh=nuwJ6UDz/cQDG8qzyGrQeFe96hmxliI+JC/UtaiRFMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L7RZTTLaRzetcpHkpeoMlkZtp2qVNVGjYdb5jaVye1MLWc8sLDbeSe5ZPxfWoHL2CNI18/Ne8tnkNg5gpu0n1vNwPwOWzTn9h1vnvmZmj+SS62oXCIQyAPdzz6eQUJMkA9GoeI3dfPbR/pPD78nh3+YyZHhZWVrq6a33ZE+Bn7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PUBuDQlN; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PUBuDQlN"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D261C19E6A;
	Fri, 26 Apr 2024 01:39:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nuwJ6UDz/cQD
	G8qzyGrQeFe96hmxliI+JC/UtaiRFMA=; b=PUBuDQlNqSliwFRt9pe4SK4gX08A
	pDs6ccbtpAhGBJmHFkTSJn429589a3fvulEs13xv978BU2ErABGvgDi1OjlSarXT
	vzPsGM0sof4QRjzx4iCZDP38sdLiZpFMzWJlRO10aAZ33C0i4a0Pk/6ZE9Ux8NO2
	flwe42p6mBu6FVs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CA7E119E69;
	Fri, 26 Apr 2024 01:39:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 203CD19E68;
	Fri, 26 Apr 2024 01:39:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Jeff King <peff@peff.net>,
  Git List <git@vger.kernel.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4] add-patch: response to unknown command
In-Reply-To: <305296f1-975b-41b9-968c-3984d8056196@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 26 Apr 2024 01:46:38 +0200")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
	<db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
	<b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
	<20240425014432.GA1768914@coredump.intra.peff.net>
	<CAPig+cST4_hUwWg+P_drqT-mv8+eLAzBmuMFXm=Dui14kfYZzA@mail.gmail.com>
	<xmqqedatfay3.fsf@gitster.g> <xmqqv845dug2.fsf@gitster.g>
	<5854e33c-b84e-47a3-94c6-c5fe8c9a4c98@gmail.com>
	<xmqq8r11dr64.fsf@gitster.g>
	<305296f1-975b-41b9-968c-3984d8056196@gmail.com>
Date: Thu, 25 Apr 2024 22:39:06 -0700
Message-ID: <xmqqwmokbs3p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4D28A232-038F-11EF-9B91-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> The current options are:
>
> 	a.- make the test check for stderr and stdout, separatedly

There is a downside that we do not check what the users would see,
as I mentioned in an earlier message.

> 	b.- fflush(stdout) in err
>
> 	c.- make err print to stdout

Yup.  The last one is what I showed in the thread.

> I suspect that similar tests for other commands would produce similar
> errors, so (a) seems like an easy fix but feels like kicking the can
> forward.
>
> I'm not sure of the implications of (c).  Perhaps moving current
> messages to stdout breaks some workflow out there?  The other thread
> about disabling all hints has made me think.

That depends on "other" commands.  As Phillip said, "git add -p" and
the like that interacts with the end user via terminal, using a
single stream, whether it is the standard error stream or the
standard output stream, should not affect any end-user experience.
It is very unlikely people capture only one stream and feed it to a
program, and with i18n, these messages are not even designed for
machine consumption in the first place.

> The (b) option seems to me the less disturbing change

Sticking close to the status quo would certainly _feel_ the safest
at least in the shorter term.

But given that there is not really a reasonable justification why
some output goes to the standard output stream while others go to
the standard error stream in this program (note that I am
specifically talking about the terminal interactive session with
"add -p"), the approach will force us to worry about similar gotchas
and we need to decide which stream the message needs to go every
time we add a new one.

> but it has not attracted attention.

I think the same reasoning from the old thread that made us avoid
the "flush() and keep writing to two streams" in the worktree code
would apply here, too.
