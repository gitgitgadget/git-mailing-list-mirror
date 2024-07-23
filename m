Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06E432C8B
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721696062; cv=none; b=WxiCU2eJQW5X+2lWUWp0Z8EBIhMZMqCaudUo3CfJE4CoCzWFabjbZAXI1H6dvlKgfz6Q7obc7c5aYAj7buMNtEVtSrh+zNnrBdgiPCWA28NOG6uKpvmxL55lx0vG4eHeAt50ATfY5ytUjjVgqt9Eko20YRi+mf9TCyc2eBis52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721696062; c=relaxed/simple;
	bh=CkCV3saQ4uQ/MR4ORi/dGb1uZQLc5ph9lClxN1gxVho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HFZXSy5MjI5290PZBAeQjz7n7dlucCl91bxNhJYP1mllyk048+/JxqHiTtFyVlXCq6NjsV/t9KVUmcoziTZU6RT5YzlWg0ZfUkYRt0jYbi4YYlsrZ9jqNIlLjzD1TxtZ24fflpElFZzFx6uKdzP/Ff5J7q9LnF/JATMt3zuHWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ICslZASR; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ICslZASR"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C92C3F128;
	Mon, 22 Jul 2024 20:54:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CkCV3saQ4uQ/
	MR4ORi/dGb1uZQLc5ph9lClxN1gxVho=; b=ICslZASRlUgrr0tfM6psvBmXM1ZI
	NTlLH6s82kpBrFKXJJkKeLZa9KOjdxb1uqzt4uSgtrP+m1y553K8jnj9JS29hmkl
	kmB1Wu/wif56Uls/AJ1e2ySvRizoRbwZ0w7G5W0hBmUJRYLxFhA9DcvFzlkuK61V
	baZ8DwK2x0Tmpm0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 05FAF3F127;
	Mon, 22 Jul 2024 20:54:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DC0DC3F124;
	Mon, 22 Jul 2024 20:54:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] add-p P fixups
In-Reply-To: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 23 Jul 2024 02:39:58 +0200")
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
Date: Mon, 22 Jul 2024 17:54:13 -0700
Message-ID: <xmqqa5i953nu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 15264A76-488E-11EF-9286-92D9AF168FA5-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>     +    Note that POSIX is not specific about this behavior:

This is misleading.  It _specifically_ says that the behaviour is
unspecified.  Here "unspecified" is a term of art with a much less
vague meaning.  With respect to the points described as unspecified,
compliant implementations of shell can behave differently, and
scripts (like our tests) that assume one behaviour cannot complain
if a POSIX compliant shell implements the behaviour differently and
"breaks" them.

So "POSIX says the behaviour is unspecified" would be more
appropriate.

>     +    http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_ch=
ap02.html#tag_18_09_01
>     +
>          One of our CI jobs on GitHub Actions uses Ubuntu 20.04 running=
 dash
>          0.5.10.2-6, so we failed the test t3701:51;  the "git add -p" =
being
>          tested did not get our custom GIT_PAGER, which broke the test.
> 2:  f45455f1ff ! 2:  b87c3d96e4 pager: make wait_for_pager a no-op for =
"cat"
>     @@ Commit message
>          "cat" [*2*], then we return from `setup_pager()` silently with=
out doing
>          anything, allowing the output to go directly to the normal std=
out.
>     =20
>     -    Let's make the call to `wait_for_pager()` for these cases, or =
any other
>     -    future optimizations that may occur, also exit silently withou=
t doing
>     -    anything.
>     +    If `setup_pager()` avoids forking a pager, then when the clien=
t calls
>     +    the corresponding `wait_for_pager()`, we might fail trying to =
terminate
>     +    a process that wasn't started.

It may try to stop one, but because we didn't start one to begin
with, there is nothing to stop.  Then is there any problem and why?

In other words, I was hoping that we can clearly say what the
externally visible breakage was.

>     +    One solution to avoid this problem could be to make the caller=
 aware
>     +    that `setup_pager()` did nothing, so it could avoid calling
>     +    `wait_for_pager()`.
>     +
>     +    However, let's avoid shifting that responsibility to the calle=
r and
>     +    instead treat the call to `wait_for_pager()` as a no-op when w=
e know we
>     +    haven't forked a pager.

These two paragraphs are good.

Thanks.
