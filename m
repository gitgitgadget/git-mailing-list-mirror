Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5821DCB26
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468439; cv=none; b=t7+ZXwHc1owLQrQv7VtEvxwwVaOJgDoIIet2i4KLJPgICNZw4rJD7uGkcVxsD7jK9GA4VMyKQSaVQi78u0rPrim+cub9lx61rA+UUY4SQtZqzEM5JFDExvbe+loXBNc4aoWnQQ44OKwJpzuJJtjGAcyD1XI+G74OinoZ5ROJnVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468439; c=relaxed/simple;
	bh=czhZVIYtyTFQ9aJzvxBuXXK1+pM/Ls4TMDrPbA71Yo0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cimOMiu1Sa7szF7gS1e+4Y1gLJmwSGEUCsXyDUUbBNcl5iA0SGILLJFg8OwS+PM4CneuN3kmIonbuziGPQMNabEGg2MHL3mEUANV0z2azkgQ5nDg3+ZR24+tUssn4xRbKAL20Etg5TDli0sEPIGzV9t2Ku/4QYh7/Dx1egYHYOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eWG0vDET; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eWG0vDET"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A33371D789;
	Wed,  4 Sep 2024 12:47:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=czhZVIYtyTFQ9aJzvxBuXXK1+pM/Ls4TMDrPbA
	71Yo0=; b=eWG0vDET0bkauvAsilFE4jtXbTkGsxfU0UdKmxWMGVSZfBro2tIlbE
	JRdHPtaNhoyyRgU0fU/ZWmTi9CVw2vYoQ98FZQV7Ut2LAJgPBrsJC5zkuvBTuELC
	AYowYk7FjpzZq4ki4gWLYqtbugsme4bE9IxiqSeX7UUUAcZJ8GUgw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B9351D788;
	Wed,  4 Sep 2024 12:47:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B65E1D787;
	Wed,  4 Sep 2024 12:47:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Han Jiang <jhcarl0814@gmail.com>,  git@vger.kernel.org
Subject: Re: `git fetch =?utf-8?Q?--refmap=3D=3Crefspec=3E=E2=80=A6?=
 <repository> =?utf-8?Q?=3Crefspec=3E=E2=80=A6?= `
 providing NON-empty <refspec> to the --refmap ALSO causes Git to ignore
 the configured refspecs
In-Reply-To: <562614e4-5384-4220-896a-20b3f79771bd@kdbg.org> (Johannes Sixt's
	message of "Wed, 4 Sep 2024 18:38:04 +0200")
References: <CANrWfmSe0ekbRR9VsX8jALWQQVdhDv-2WTSm47jHTiV9-Z7-pg@mail.gmail.com>
	<a33a73f7-e6dd-4f97-a635-c6c5dfcadeb1@kdbg.org>
	<CANrWfmRdz1Xxud=f0GWrc=nURV2xZU8Wm=8u2X+W4tL4d-yeTg@mail.gmail.com>
	<562614e4-5384-4220-896a-20b3f79771bd@kdbg.org>
Date: Wed, 04 Sep 2024 09:47:09 -0700
Message-ID: <xmqq5xrbbc36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 548D7074-6ADD-11EF-8DF3-9B0F950A682E-77302942!pb-smtp2.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

> Am 04.09.24 um 13:12 schrieb Han Jiang:
>> 1. If the doc says "providing an empty <refspec> to the --refmap
>> option causes Git to ignore the configured refspecs and rely entirely
>> on the refspecs supplied as command-line arguments" then it's
>> reasonable to guess that "providing a non-empty <refspec> will not do
>> those".
>
> Fair enough. But then in section "Configured Remote-tracking Branches"
> it is said that "The latter use of the remote.<repository>.fetch values
> can be overridden by giving the --refmap=<refspec> parameter(s) on the
> command line." So... I dunno. Just my 2c.

This cuts both ways, I suspect.  It is so unusual to say

    git fetch --refmap="" foo bar baz

to use an empty string as <refspec> in "--refmap=<refspec>", simply
because you would not say

    git fetch origin ""

and expect the empty string is a <refspec> in "git fetch origin <refspec>".

Any string other than an empty string, e.g. 

    git fetch --refmap="refs/heads/*:refs/prefetch/x/*" foo bar baz

would have an extra side effect of storing what gets fetched, when
your primary focus is "I want the command to ignore the configured
refspec".

For these reasons, I would actually say it is quite fair for the
documentation to single out the empty string case as an idiom that
may be hard for readers to figure out for themselves without being
told.

I would not be opposed to add a sentence or two to clarify what
happens when a non-empty <refspec> is used, though.

Thanks.

