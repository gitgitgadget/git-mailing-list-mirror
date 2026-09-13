Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0E35E1BD
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789296363; cv=none; b=TXX1bqTIskZE4s2vHz2iXc9wb02t+UkWnSlTs1bXSP+KGEwTYO3Jtxnn0h2dQomhnZqpzxuw5HiAkwX6rnJIcQ0Qsv43ylKcD1Q2DeZndKfi3uBJG2JkUCIC/RgGwdATu6ahYwTeLS+NIVyflmnmwooxxFEe2ZNwZ7bkfRQw6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789296363; c=relaxed/simple;
	bh=U+d0jMKuhi0ELGR49UglNGDuzn67UEt8t07wB8USvKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faBhT8y6xee7eeLJGsBqhoAErosEb9KnZQIUY/fk8whOjngY/OThCs42cxMYdqe0W9y3l2PRR3xiMcV3hNWFI8Q22zZzZzjo9+7FAQ5Ad1BCRh5US+LZEtMoodN703UW3YrIzWJoruSlTjR7sO9dyUQY72aBM9RsuuK5rDwBqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Eu2f1F7o; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Eu2f1F7o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1789296349; x=1789901149; i=l.s.r@web.de;
	bh=GSfC16GFc2zdlMpWgPEcMuw2HwSMdVm4m7pju+EkVf0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Eu2f1F7o7GUjC/UEOA8FK1MnyYFQ3gA7eFf48NVNLss8/txmHU3gcPkpGlHTIgWh
	 +U9BeRlFunCXpfc8vpWuyN7qeDHrcQN/1VsrP8DZ6FI3s16O6VG9GhDkg/Kwm6IMm
	 EBlHMdmF9sVYtyyv3B25IWODsmSMHDWDbLM3R7DADUoPjDPAmDb0p5VvWNkrHszNC
	 Z84FlsTyockSwxui/mhbjA5IjpLKkXfSCVb7w+vLGD0MFsdS+ITFrG11NPuJqxs9r
	 F0PtPg4oGW0RipvCD0N2Ck3jMk0iCzIeWLMkCchW5FjBk64l82K/5U28Xcrmtd0pT
	 4tGE9+fNzEm5a7XUXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKMA1-1xO2qZ3CsZ-00OOtT; Sun, 13
 Sep 2026 12:45:48 +0200
Message-ID: <96aca004-0df4-4e21-b60a-0288239122cc@web.de>
Date: Sun, 13 Sep 2026 12:45:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cocci: remove risky "if (!E) free(E)" conversion
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqld978mok.fsf@gitster.g>
 <caa39ca4-b35e-4fff-80fb-af6856cb2098@web.de> <xmqqcxui8f0c.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqcxui8f0c.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hGyrHjQARH3chZ8VmB4WvbS18Qhy/zJdc3vzGfnumHK7hVbQk/Y
 +k4O40xDJ1hxarCB5q+ktgYrhd6OecsdiL1jOA0W7xvUL1h6oduZZDNAuHrdeT5Ymgfs62v
 zwCH1x8hOPVjW1a71oyijM99veXXtpNE0tm+B31n1v9Ih9WmGvPnXVSVQNn/XL/HGLklp+n
 QsocGs0YGOeWH+LGJJ/CA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TGvPki3F810=;z3OdWK8De0NkCbSNCerMHbTio2m
 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
 CIf6CFc61Qw5prOspgVj2DmZmcbZK5d

On 9/12/26 9:07 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>>> We could change it to
>>>
>>> 	if (!E)
>>> 		BUG("free(E) is certainly not what we meant to write");
>>>
>>> to force programmers to think.  But it probably is safer to just
>>> rewrite one form of no-op into a simpler form of no-op.
>>
>> With that last sentence I expected the patch to also remove the free(3)
>> or commit_list_free() call, replacing the no-op with nothing, which is
>> safe and simple.
>=20
> You mean
>=20
> 	 if (!E)
> 	-  free(E);
> 	+  ; /* no op free(E) */
>=20
> or something?  I guess we could do so, but I feared that a compiler
> that is smart enough complain and trip -Werror on us when E is too
> obviously a side-effect free expression such as a reference to a
> simple variable.

GCC apparently accepts "if (!E);", Clang warns.  Both currently accept
"if (!E) {}". See https://godbolt.org/z/9h8YdjrGP for some more
variants.  Other compilers or versions could react differently, of
course.

I would have just removed everything:

   -  if (!E) free(E);

, risking the loss of side-effects and welcoming any warnings,
accepting that this bluntness would be rude and potentially unsafe.
That's a bit like in the "computer says no" skits, I realize now.

I agree that the polite thing to do is to leave the flawed code in and
let the programmer find out that it's not doing anything some other way.
No need to put up a targeted defense against this inconsequential and
unlikely mistake.

Ren=C3=A9

