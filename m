Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632F17D355
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153259; cv=none; b=A/4omRcJDUl9P5+rKyGmaIi872nAs1qOLRAWAs7tz60AmRO2UFx8jgrLg3qEAm6z+t7ug/3saJ9m1pq0fMw/ksFhNHTwzWCMk/Tcjf7ITJoz0r/a3/GmTXsp6waWlqvQaPJ31lr4AXgWgiBlC/qI8bm8yIqn1kmbYVvTophB36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153259; c=relaxed/simple;
	bh=NZjSgLR1Iwm0pNSaB0FZ+cOVcXAbYbYPrihFU+BGTVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjPSIqeArX810H2RUAtcRKGnbqSw/EEnTxFE47+DLl20oUbZ/pBYYosQDps2IHUnCnkOpVzFqXh87OsZTCQM0DCYBqvOz1mB4epQPyh+GmCIdybDJ66oHcgBvS8+g93VgDZy5/pwR/F4lkYcMsiwkVG653deOMF6gl+9SWIvpk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=S/bnYLJU; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="S/bnYLJU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730153240; x=1730758040; i=l.s.r@web.de;
	bh=xj//+jOUtZ2zBOfTbx0sxgi03aMuCPcUGiO8vT5f6PM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S/bnYLJUYJS/qQs+jTuVDgwUmhx/77LAvWtkdVx0EX5MntTDJ0GL7YLJa9opt5mQ
	 gK8HvvZ8PqyKpnDwnK5D1reL6bcN62NMmy1Xe30THpyPSpXnymsI8wWt5Bx/sYfxV
	 lvAkNSVbBhVRqMxMF0/QrbvUD49j6Nlz6Mcab9+TsGY3zxf6jLHIfp08z1inwJiWV
	 e3zYq7PndBKPRPtjadCcwNA0UsaI9LvLSbzZxkB9NoqXcmP5UJADT2qRs+1+jP2uS
	 sweHTBP2QmvyPhjD9fK2ZZG+roa8LwKLev1XrParVYkwtY0bMILcLtlmbzBNpXnkg
	 rl2WiL1S3GO5gnmWcw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.30.137]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuF8x-1u07QD31zR-014Kl0; Mon, 28
 Oct 2024 23:07:20 +0100
Message-ID: <d74232a4-126d-4bd8-8f60-a3fac80492d5@web.de>
Date: Mon, 28 Oct 2024 23:07:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Inconsistent handling of corrupt patches based on line endings
To: Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>
Cc: =?UTF-8?Q?Peregi_Tam=C3=A1s?= <petamas@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
References: <CAExmRTbMCayh+vHW3g=2p=FMb=VKXomEbn7_0t+kK-eF79JnEA@mail.gmail.com>
 <Zx/TwhuG4Ni7mf6F@nand.local>
 <CABPp-BFB+eG7WVJFm3EBfgKzuspAYn9KpDHodpgKuFmWefARBw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CABPp-BFB+eG7WVJFm3EBfgKzuspAYn9KpDHodpgKuFmWefARBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kRP/sU2vp1PHCuyf2WzqEKkTY5NW5Odp1CrRVeZmI3Iu4fdJnOc
 Go0pkdsnBtmZY3em5VORj+wP6xlwg0ofzt0SAxoxxaJf3uwbUmOEdKrXovsiSLPrXC5Q/Qc
 6WQrKtE4r0Vd8OOgUzhetWlsHx8zI/ofCkgZx/Cq8bW2NqZvDBEpIBJL60GlVJHj7Yrd1A8
 dixEprCxxPzflQVvEVPMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lnC0DRt/T9g=;ukbZY69lpuTcDG2gLTKEkLZBkb7
 /2bvl9/vdrF3VM0CNWa31eO7z1x3x8qUXIr6EOHtxYKEzJ20q2Oz59aVGVAtnhRwzt9In40ET
 LWRSXI4Xb2U9zr38xMzAcZNFdfGL++wSnYX1H+uFNviugM6K7EwN4yDeZhFeSmN/UwJLs+YXQ
 eBt2k7YckdB+T2a7Vfu97gDGHa/wn978ElNsDsImiGtjQ+QwLSL2K7X0NjyDm6vUNUUU+WwEO
 uLqRQZCGI58DChKDAHuv/2DyC9bXbg1ZL6JkzeuoSU1RWh1m0Vh5X3dqkl/0HLecqEhpYAecy
 LAZMRo5mCH46XcgMljU2bgNMGkWkB8eSFrzM6xnJtfpTTiEwzCBaVZDBBMByMx6s+lKaAy+Ik
 few57+/fcubeRzyMytiXB5eSicJlVy2A9lvrJ5P+TR6NA10OhIPzfSwS/LryxF7FXrzMaSlMs
 g6W/+/vAA99Ihbc1yV25z+jphSh9nBCpThHQLoMsNShtn6Jscy0IDjbdeupg/OTXwgddeaasy
 fzgGkDyadGBVGRkEjGRj8XAyQkqPxIPUL8i6ENUf6XGFLYq4tuJKvUOrKzhX7u1SE2o7xsvwB
 YolW4NHAPrO+PxuN3z2RFQhsl68nyzJSqTZwwIT0t11x3yAQFNwbEcDCVB9+SyFSpLQhGMnlT
 14EcKbH2KzBrQXmXMcs8Bou/PIWaSbhD3Wbrybcxx18m3+Rj7WVGy3PRPdCySV8NtFtYMgzdA
 gpttay0ScJc7K/IDRhUVVr2noQgVf5NYr5JOZrbpEAZEjvLJJUBZqqW2OUxQ2+vg4i/GGXXX0
 QoDkOaavG55+nGKVJFJnNqQt0jCemAv6hDs0JjjwO2MarXwSZBqc1G+/ia/zXja1PrJtaLqsN
 eevE/PbFoyyBhgQ==

Am 28.10.24 um 19:39 schrieb Elijah Newren:
> On Mon, Oct 28, 2024 at 11:11=E2=80=AFAM Taylor Blau <me@ttaylorr.com> w=
rote:
>>
>> On Mon, Oct 28, 2024 at 05:57:54PM +0100, Peregi Tam=C3=A1s wrote:
>>> Hi all,
>>>
>>> I might've found an inconsistency in how git-apply treats corrupt patc=
hes
>>> (representing empty context lines with completely empty lines instead =
of
>>> lines containing a single space - usually a result of a "trim trailing
>>> whitespace" editor setting) based on whether the patch file uses
>>> Windows-style line endings (CRLF) or Unix-style line endings (LF only)=
.
>
> I believe this behavior was caused by:
>
> $ git log -1 b507b465f7831612b9d9fc643e3e5218b64e5bfa
> commit b507b465f7831612b9d9fc643e3e5218b64e5bfa
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Thu Oct 19 19:26:08 2006 -0700
>
>     git-apply: prepare for upcoming GNU diff -u format change.
>
>     The latest GNU diff from CVS emits an empty line to express
>     an empty context line, instead of more traditional "single
>     white space followed by a newline".  Do not get broken by it.
>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>     Signed-off-by: Junio C Hamano <junkio@cox.net>
>
> That code special-cased a line containing '\n' but not a line
> containing only '\r\n'.
>
> As to whether that's correct, personally I'd rather only special case
> workaround important existing clients.  Back in 2006, working with GNU
> diff was incredibly important, and I'd say is still important today.
> I can see Peregi's comment that this make line ending slightly
> inconsistent, but I feel like the blank-line handling is a workaround
> for an existing client we want to interoperate with and absent a
> similar important client with mis-behaving '\r\n'-only lines, I
> wouldn't be interested in adding support for it.  But that's just my
> off-the-cuff feeling and I don't feel strongly about it.  Further, all
> but one of my contributions above were mere header changes, so if
> others have other opinions, they should probably be weighted more
> heavily than mine on this topic.

What would the patch(1) do?

The first column is the exit code of the subsequent command (0: success,
1: one or more rejected lines, 2: failure):

0 patch                     -p1 --dry-run original-unix.txt <corrupt-unix.=
patch
0 patch                     -p1 --dry-run original-unix.txt <intact-unix.p=
atch
0 patch                     -p1 --dry-run original-win.txt  <intact-win.pa=
tch
0 patch --ignore-whitespace -p1 --dry-run original-unix.txt <corrupt-unix.=
patch
0 patch --ignore-whitespace -p1 --dry-run original-unix.txt <intact-unix.p=
atch
0 patch --ignore-whitespace -p1 --dry-run original-unix.txt <intact-win.pa=
tch
0 patch --ignore-whitespace -p1 --dry-run original-win.txt  <corrupt-unix.=
patch
0 patch --ignore-whitespace -p1 --dry-run original-win.txt  <intact-unix.p=
atch
0 patch --ignore-whitespace -p1 --dry-run original-win.txt  <intact-win.pa=
tch
1 patch                     -p1 --dry-run original-unix.txt <intact-win.pa=
tch
1 patch                     -p1 --dry-run original-win.txt  <corrupt-unix.=
patch
1 patch                     -p1 --dry-run original-win.txt  <intact-unix.p=
atch
2 patch                     -p1 --dry-run original-unix.txt <corrupt-win.p=
atch
2 patch                     -p1 --dry-run original-win.txt  <corrupt-win.p=
atch
2 patch --ignore-whitespace -p1 --dry-run original-unix.txt <corrupt-win.p=
atch
2 patch --ignore-whitespace -p1 --dry-run original-win.txt  <corrupt-win.p=
atch

So basically the same as git apply?


What does current GNU diff do?

diff -u                        <(printf 'a\n\n') <(printf 'b\n\n') | tail =
-1 | od -a
0000000   sp  nl
0000002
diff -u --suppress-blank-empty <(printf 'a\n\n') <(printf 'b\n\n') | tail =
-1 | od -a
0000000   nl
0000001
diff -u                        <(printf 'a\r\n\r\n') <(printf 'b\r\n\r\n')=
 | tail -1 | od -a
0000000   sp  cr  nl
0000003
diff -u --suppress-blank-empty <(printf 'a\r\n\r\n') <(printf 'b\r\n\r\n')=
 | tail -1 | od -a
0000000   sp  cr  nl
0000003

So it omits the space only if --suppress-blank-empty is given and the
blank line ends with \n, not with \r\n.


Anyway, I agree with Elijah: The targeted support for GNU diff's
eccentricity is fine, and we're in good company with that.  We could
remove it, since it doesn't seem to be the default (anymore?), but I
don't see much of a benefit.  We could add support for blank context
lines that end in CRLF if there's a notable source of that kind of
that deviation from the original format.

Ren=C3=A9

