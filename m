Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E0E111A8
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721242288; cv=none; b=eDyxDEZ1F9BSA32ChxHxmZagSYOSDVtT8xY/oUnC+sMLXOBRfgjW6wjy6TL3Vzgz0xJZVRZa/zx+Lk1U/PZjy6sWCkeuS2uAwnuSL4Bgn0n395iVgsg4Zdsl2vZ2oSEznhEKzEa01vD5n8BnGM4W2LfyGJaXhUzwceh6DCr2fwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721242288; c=relaxed/simple;
	bh=qTkVt5zsI0FthxeD4Hf9GmQiCoz+3gvy3seJfLp5fwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gXfBPoMGbg0YCY1j1zzAu5ImuOHdMVzK0IsOjuMYQ5EGCRZhbH3vyqwSHdCv43d243WwdG4s517LzcafotUPMxCzMytK+lm7FmucsuN73cariryIPta4xmWtHTQNy+4gU6S5IlBfOPk8n+aGA7F6askXqttnX4I/fh6VvFoWWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sVP5V4xr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sVP5V4xr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AAC641886B;
	Wed, 17 Jul 2024 14:51:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qTkVt5zsI0Ft
	hxeD4Hf9GmQiCoz+3gvy3seJfLp5fwo=; b=sVP5V4xrdqcCpYe1q2m7MtQXsu+y
	46KfOw7FJGueqzhLEOmoCrhq5llV6PUwgr9qtdi1JvrMYD0Pp/4ZnD0Rmhtgyn6V
	fQQW21tIyIajMbNETKXvQo8p6vbLmwHlZq+R4Tf74xrV/e678/NugKuDgVi7jb7/
	OOLEYJ1EiyNskHU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A23E81886A;
	Wed, 17 Jul 2024 14:51:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E11C18869;
	Wed, 17 Jul 2024 14:51:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] sparse: ignore warning from new glibc headers
In-Reply-To: <9bdac465-5f43-42de-9cad-e6c43a5a53cc@ramsayjones.plus.com>
	(Ramsay Jones's message of "Wed, 17 Jul 2024 19:40:35 +0100")
References: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
	<xmqqikx42c42.fsf@gitster.g>
	<9bdac465-5f43-42de-9cad-e6c43a5a53cc@ramsayjones.plus.com>
Date: Wed, 17 Jul 2024 11:51:23 -0700
Message-ID: <xmqqr0br26ok.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 913F06D6-446D-11EF-85E7-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 17/07/2024 17:54, Junio C Hamano wrote:
>> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com> writ=
es:
>>=20
>>> With at least glibc 2.39, glibc provides a function declaration that
>>> matches with this POSIX interface:
>>>
>>>     int regexec(const regex_t *restrict preg, const char *restrict st=
ring,
>>>            size_t nmatch, regmatch_t pmatch[restrict], int eflags);
>>>
>>> such prototype requires variable-length-array for `pmatch'.
>>> ...
>>> Thus, sparse reports this error:
>>>
>>>> ../add-patch.c: note: in included file (through ../git-compat-util.h=
):
>>>> /usr/include/regex.h:682:41: error: undefined identifier '__nmatch'
>>>> /usr/include/regex.h:682:41: error: bad constant expression type
>>>> /usr/include/regex.h:682:41: error: Variable length array is used.
>
> Yes, I noted this about 2 years ago! If memory serves, it was when the
> libc6-dev package went from v2.31 to 2.35 (well 2.31-0ubuntu9.9).

Yes, our mails crossed.  I was just writing to linux-sparse@vger ;-)

> I mentioned this problem to Luc on the sparse mailing list[1] and
> he produced a patch which 'fixed' the problem in one way, but
> caused a different problem[2]. Namely, because git passes -Wvla
> to gcc, it now issues the 'used vla' warnings, which gcc does
> not because of some '# pragma GCC diagnostic ignored "-Wvla"' which
> sparse does not honor! :(

Sorry, but I do not follow.  Isn't -Wno-vla an instruction to sparse
to tell it *not* to complain about use of vla?

We do not pass -Wvla or -Wno-vla to sparse ourselves.  Because the
tool comes from the Linux land where VLA is not welcome, we'd by
default get the "hey, you used vla here---did you mean it?" error.

And the patch by Luc Van Oostenryck in the thread you raised at
around the end of 2023 does apply to the tip and with

	SP_EXTRA_FLAGS +=3D -Wno-vla

in Makefile, sparse seems to be happy when I do "make sparse".
