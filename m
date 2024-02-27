Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2982547A7D
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056719; cv=none; b=b3+WpvIUe9LK6vZJRot5YiCZDHXEWeJvVGbVbnb43yvWiZ9ujYw/xLL3/QIingQZZZlGgqby3agHSMRW8fiO0MY7yeBEgOUzMKRC6jW79jmMlalx5VVNr2tr5Lk4AIY76sbPAijJht9DH7qmG916ryIhhBtKP4sxe5G8Rz7CWLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056719; c=relaxed/simple;
	bh=BJK6MOynDR2haXG9JXWbWlQ5ytUQ0lMf8pgEL0u1FgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lT81jeTr+7xIaT4Tcyc3DObNzNQa2AUq5m9CbuEJBKnbzZhCD8OM9hkdWPf2oiGzANfy/4Y4BLBIYK5yFZqjDor7n1iDC0vSIndvioqX/j/QB660IVRCK073+Awbvt58xrG5RbdhPnXL8buZs4SwcYvY7/oLPt+WkuvnMLb5zF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=mpdCZmF8; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="mpdCZmF8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709056707; x=1709661507; i=l.s.r@web.de;
	bh=BJK6MOynDR2haXG9JXWbWlQ5ytUQ0lMf8pgEL0u1FgY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=mpdCZmF8GdOCrSXV6/Wacoaxo1Dtt81CVvbu5vwgfoFyESmGg81X5wxhfxfMVSTV
	 ++6r58ET90xPRE+oUWvOuToAHQsuNjko78kPxt6YqQKIQaLx1i/sYLBuFxkomgKvq
	 TdioJqIpgaCfHjdykEl4R3SenLO+QBhxuG0N/tWkGLv5tQk/edbgk2U9SUPaStOyI
	 xFFAnyx7OnMLKcZj4mzq6IvxpMKL9KOYhx62oFQB2JtVphaOfHTuHDUM130m4U4/2
	 rC+RjaOh96zeBKTuSAEdsXNRU4l3amca4h+frxgwsD3PopM0dau/Gg2TbkSuqm8L7
	 YgMHsCIAg1j2bdtBBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mhnvw-1r1aEt0X8S-00dicx; Tue, 27
 Feb 2024 18:58:27 +0100
Message-ID: <3aed87d0-4789-4e96-8c6c-31cab2d996cc@web.de>
Date: Tue, 27 Feb 2024 18:58:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mem-pool: add mem_pool_strfmt()
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <20240225113947.89357-1-l.s.r@web.de>
 <20240225113947.89357-2-l.s.r@web.de>
 <20240226070844.GB780982@coredump.intra.peff.net>
 <1868c502-b915-42fd-8cb2-efe90429f9b7@web.de>
 <20240227075350.GE3263678@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240227075350.GE3263678@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t7e1rNalMC1//stVWQF8CT1Xfac3b3GQjSOD0Q7ch0NIFSKPEaK
 YPBhc8kqKaikQAOI0MXqCNoeZkG956Y+6lf44Hgg537H7YN15b937SCWXKoWK/2sQUjyKDQ
 mwj2O3A3TRa6/z04EuJ2TOPF0SF4qr73VRExlBgAiRSV2MEs8rvyBc9P2hAK8hCqiyop8xU
 D93tSA12h4xUzicw82FcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GSOtyw03Cyw=;dzq/ZFJUqKmz2l8qeihPJw5QV1q
 BLWJT9UlxBZBRH4voLIsq4K+HMGAZiHPv22rMKgeb7mrs8CsyWNxA59rLX5Al600iipQ8cOx1
 Lb9x2XkSIWNgAey5hMcMd/rDRP4CBN8Pw0MFspU5wiWTsom4WxnjHgZEdIHbonpiqZ0D4A4OT
 DaXVCD34eAsFoefi8Ebnmz189ZGqBv/oSAPuwnMcG5KbeEuZUdL446uSOa8zlE9+QslwUCapJ
 Y9iUTF/IaPVql/fUQ0IP0kypbokXS2F3BS33swR3nm1NHnkjbzNfYpBZSdBnnTtVaMH0AfC/d
 eUsfyf51eODzU0+s1LTXipGT0l0aFe1vp6kqAMHR9QO34Quczw4ptiY5sUYKrq7HLYSth2Zhh
 42ff4KvOhkN6zmkdj4KEBDj//Y2E9ofehweOwP5HAKs4YJG/kHs9N65+pVYmiEO/6rAHz8que
 hPC0rKBADT2BtsgeluL9tkCdLQ67r4Hz2Sb2Irhsjpbd5GfIE8kTXgdYbjj5Bw95t/oq0iBxy
 FQs1tICm2YZSNX8yWADD9gtxxxjKo5O3Z/ITi8HMQw/xxn4ycj/Vu3oJdRW2dzAEEksBzMzSU
 Oa375jM2dCUxxT+aP7keJuFEH0XM0ocZBijb37ypiDlX93/Xaxv8ygX0eq9ewKvUrEOWt9HDe
 fJYmkes/3aTUygs1aAn5vmY3tci8fUDnejIYGb6BS7qf2Xe9CFhw79Eb8aB9wDOPTG9t1qIHg
 nHtftTfnaAjk0i4pJ1gdRdo6e2H4oYa0qXO+5N0H7CR7vRVcDtE0cgh9rsWZGxgjdT1H+Tbpw
 gNboetAfIYjZnrJKYzWuP464VAqaC0cNEhoH1PzCkwEXg=

Am 27.02.24 um 08:53 schrieb Jeff King:
> On Mon, Feb 26, 2024 at 07:17:00PM +0100, Ren=C3=A9 Scharfe wrote:
>
>>> This is pulling heavily from strbuf_vaddf(). This might be a dumb idea=
,
>>> but... would it be reasonable to instead push a global flag that cause=
s
>>> xmalloc() to use a memory pool instead of the regular heap?
>>>
>>> Then you could do something like:
>>>
>>>   push_mem_pool(pool);
>>>   str =3D xstrfmt("%.*s~%d^%d", ...etc...);
>>>   pop_mem_pool(pool);
>>>
>>> It's a little more involved at the caller, but it means that it now
>>> works for all allocations, not just this one string helper.
>>
>> That would allow to keep track of allocations that would otherwise leak=
.
>> We can achieve that more easily by pushing the pointer to a global arra=
y
>> and never freeing it.  Hmm.
>
> I see two uses for memory pools:
>
>   1. You want to optimize allocations (either locality or per-allocation
>      overhead).
>
>   2. You want to make a bunch of allocations with the same lifetime
>      without worrying about their lifetime otherwise. And then you can
>      free them all in one swoop at the end.
>
> And my impression is that you were interested in (2) here. If what
> you're saying is that another way to do that is:
>
>   str =3D xstrfmt(...whatever...);
>   attach_to_pool(pool, str);
>
>   ...much later...
>   free_pool(pool);
>
> then yeah, I'd agree. And that is a lot less tricky / invasive than what
> I suggested.
>
>> It would not allow the shortcut of using the vast pool as a scratch
>> space to format the string with a single vsnprintf call in most cases.
>> Or am I missing something?
>
> So here it sounds like you do care about some of the performance
> aspects. So no, it would not allow that. You'd be using the vast pool of
> heap memory provided by malloc(), and trusting that a call to malloc()
> is not that expensive in practice. I don't know how true that is, or how
> much it matters for this case.

In the specific use case we can look at three cases:

1. xstrfmt() [before 1c56fc2084]
2. size calculation + pre-size + strbuf_addf() [1c56fc2084]
3. mem_pool_strfmt() [this patch]

The performance of 2 and 3 is basically the same, 1 was worse.

xstrfmt() and strbuf_addf() both wrap strbuf_vaddf(), which uses
malloc() and vsnprintf().  My conclusion is that malloc() is fast
enough, but running vsnprintf() twice is slow (first time to determine
the allocation size, second time to actually build the string).  With a
memory pool we almost always only need to call it once per string, and
that's why I use it here.

The benefit of this patch (to me) is better code readability (no more
manual pre-sizing) without sacrificing performance.

The ability to clear (or UNLEAK) all these strings in one go is just a
bonus.

Ren=C3=A9
