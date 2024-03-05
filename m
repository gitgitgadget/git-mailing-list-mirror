Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6BD84A48
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652772; cv=none; b=ac+E9RayBgodtgYQm4NITxQ7RQw95ljak19T9viF3q3Aa3qVjUFWMjc8ifiuD9zHc44wESerfpulNp+8eNH+qjKkccZSEGDGdUOLDpn5nTdh6IuN9UDTksqGY9lWWfYNAhcYQhnbpl1vyF72F57ubms1b7Lvkt8x/wUSdledwag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652772; c=relaxed/simple;
	bh=9zNsDziKUHVPOsyIrjPHRydLKvnxfp6vlo5fp4VzXCo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pdjGd5bMW9l0NTcHxzPQqOOVf3y8/GGVxWl42Dr7Ob4THX+CyhWFKWq+gwtaZuGZe3C0y8la2dhi4ofmrYLd3+f5q8eM58Da/8s+dQX5WtK5SNqMiT6//yAznEXPmiZakqnIbhM1kaaOP/2hZ9eaetyfsSZBuj02vW/5wWXpE1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jW0c471Z; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jW0c471Z"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 72F6C1E18C;
	Tue,  5 Mar 2024 10:32:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9zNsDziKUHVP
	OsyIrjPHRydLKvnxfp6vlo5fp4VzXCo=; b=jW0c471ZDQwpUga0e00pB/x8e+js
	nadLzG58HO3cAFAe0l1KQBoXlaHMMbrLtsGjkDp+VGem6H+37IA/pUqzsM/AHyeR
	pb0xgnPSH/VTfvi99OZbXmh2YGt8OESiY6f/j7o7SrnS8OZeuJVwnyO9rwG7hNSh
	6YCvJ4T+fB3kmTY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6AF7A1E18B;
	Tue,  5 Mar 2024 10:32:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2B0B1E18A;
	Tue,  5 Mar 2024 10:32:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Manlio Perillo" <manlio.perillo@gmail.com>,  git@vger.kernel.org
Subject: Re: Clarify the meaning of "character" in the documentation
In-Reply-To: <5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 05 Mar 2024 10:00:06 +0100")
References: <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
	<5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
Date: Tue, 05 Mar 2024 07:32:38 -0800
Message-ID: <xmqqsf1466eh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 99CDF3B0-DB05-11EE-8721-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

>> As an example, with
>> git config --add core.commentChar =E2=80=A2  // Bullet (U+2022)
>> git does not complain, but it is rejected later.
>
> I think this is more about `git config --add` not doing any
> validation. It just sets things. You can do `git config --add
> core.commentChar 'ffd'` and get the same effect.

This is not wrong per-se, but it merely explains why "config" takes
it without complaining (the command just does not know anything
about what each variable means and what the valid range of values
are).  core.commentChar is limited to "a byte" so in the context of
everything else (like commit log message in the editor) being UTF-8,
it means ASCII would only work there.

As you said, we should document core.commentChar as limited to an
ASCII character, at least as a short term solution.

I personally do not see a reason, however, why we need to be limited
to a single byte, though.  If a patch cleanly implements to allow us
to use any one-or-more-byte sequence as core.commentChar, I do not
offhand see a good reason to reject it---it would be fully backward
compatible and allows you to use a UTF-8 charcter outside ASCII, as
well as "//" and the like.

> Alphanumeric characters (a-z and A-Z and 0-9) are ASCII. And one ASCII
> char is represented using one byte in UTF-8. This already looks precise
> to me.

Correct.

> I=E2=80=99ve never run into a case where git-diff(1) does not handle UT=
F-8. I
> don=E2=80=99t even know if it really needs to =E2=80=9Chandle=E2=80=9D =
it per se as opposed to
> just treating it as opaque bytes. Maybe it matters for things like
> whitespace and word-boundaries, I don=E2=80=99t know.

The core part of "diff" is very much line oriented, and after
chopping your random sequence of bytes at each LF that appears in
it, the code is pretty oblivious to the character boundary, except
for a few cases.  "-w" needs to know what the whitespace characters
are (it knows only the limited basic set like SP HT and probably
VT), "-i" needs to know that "A" and "a" are equivalent (I think it
only knows the ASCII, but I may be misremembering).  Outside the
core part of "diff", there are frills that need to know about
character boundaries, like chopping the function header comment
placed on a hunk header "@@ -1682,7 +1682,7 @@" to a reasonable
length, --color-words/--word-diff that first separates lines into
multi-character tokens and align matching sequences in them, etc.
