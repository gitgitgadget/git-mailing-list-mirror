Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45537204A
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789197214; cv=none; b=qVFV47sNCDLL9jnDyjfO3L3WImX0Vg5BLdKnBoS90hgLv/rj+MSe5IqC5iFIpDCqYKfvBzPTSugIcSCvdADScFwMerMT/feO9MBmmBKmus1AzXi1mKYwcG4cLJDqhX2YVsDhmbrvxrWf7Kq4peduwuIdEWn0G5Sqd3HUk4KK6TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789197214; c=relaxed/simple;
	bh=bPOvmDwsOzBJdy9vQSq5paXitXLvW8Cc47RaANdlVHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J+bLEdFI7wVPISaZ5BHVcAkStgR8lQujW69ZYzkpNyFSAbINPlXO8S0TjySnbWmpetU4/42UueoWP0J60a6LUGw/OktVAX0bPDUY6oF7P9Wb5ObNNo2nglM4SF0h/2AF7vh3GrkGAiiF/pvFkBgPFNOlJHa07MamdLruJIabHOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=jtPdNEP0; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="jtPdNEP0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1789197210; x=1789802010; i=l.s.r@web.de;
	bh=fKGeA3IBFRldxRkS544PaPUVZuOBcbCR5VH4eeiEdpM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jtPdNEP01Hf5pTYLx99Xwa0M/77hFJYojTQCR2sUJpsa/7QSSs5Yo54zEzU8BAQX
	 T3RL7DDGYS5BzKWk2swfiTFecmDtD819AiX9MtsEadgZ+8jkVGBazs0sL3jlxkREj
	 ehugTULubRQXzc4kVvwlJpYMAz13pNyFNpIKiVQRGC2m7Bii0D7XrHBBtMcwdtKwP
	 Va+Gu5Rb8/S7OWuVAN65uwMKI5T/X4A+GmkI7Vo1MoMIEDTbzEfsnJCXOqJlnoA3i
	 1P6oN6SpWOa/ZvZxO+wkg/xJE4oilXRzPOVMTw/F6uwdfi+zXpA8Yigfy2KRwssrF
	 hqdUcuNAo6jMmmolVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlsKF-1wNwMs4AAl-00dDAl; Sat, 12
 Sep 2026 09:13:30 +0200
Message-ID: <caa39ca4-b35e-4fff-80fb-af6856cb2098@web.de>
Date: Sat, 12 Sep 2026 09:13:29 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cocci: remove risky "if (!E) free(E)" conversion
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqld978mok.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqld978mok.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AXpLJE5ZY182Xk2eskt6YIhUgrrBX48jecGjSBPpJ61q/xjei9q
 xFN/Kbw1A5UPKCD4VZH5i1xGx+8sp1D0ZJ64PNgdU/m2VxpX+kntqGd5XCu0Y5v4KvsVqWM
 jMkS8ZYhp0fbAlibsYdCkbmXDtAfQgQmaU9n+LdJGAkHkueNOHDwgL/wfQ93QW8KqUi+1bV
 NsNMKrdrG6GiZsw+zNKYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CssF87gIeh8=;LE1g0s0l2ClKggIPuDlESV2z26Y
 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

On 9/12/26 12:09 AM, Junio C Hamano wrote:
> The current cocci patches try to convert
>=20
> 	if (!E)
> 		free(E);
>=20
> into an unconditional call to free(E), with the rationale
>=20
>     cocci: detect useless free(3) calls
>=20
>     Add a semantic patch for removing checks that cause free(3) to only =
be
>     called with a NULL pointer, as that must be a programming mistake.
>=20
> which came from ec6cd14c7a (cocci: detect useless free(3) calls,
> 2017-02-11).
>=20
> Leaving _something_ in ALL.patch output to draw programmers'
> attention is a good thing, but this changes a piece of code that is
> originally a no-op to do something else, which may be even worse.

Good point.  It's likely that the programmer just wanted to release the
object in question and got the check wrong, but it's also possible that
the free(3) call is wrong as well, and that could do real damage.
> We could change it to
>=20
> 	if (!E)
> 		BUG("free(E) is certainly not what we meant to write");
>=20
> to force programmers to think.  But it probably is safer to just
> rewrite one form of no-op into a simpler form of no-op.

With that last sentence I expected the patch to also remove the free(3)
or commit_list_free() call, replacing the no-op with nothing, which is
safe and simple.

On the other hand: Do we get any value out of this rule?  Is it a
useful guardrail?  LeakSanitizer would find a forgotten free(3) call as
well, given enough test coverage.

Ren=C3=A9


>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  tools/coccinelle/free.cocci | 10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/tools/coccinelle/free.cocci b/tools/coccinelle/free.cocci
> index 03799e1908..3dfaae9dd8 100644
> --- a/tools/coccinelle/free.cocci
> +++ b/tools/coccinelle/free.cocci
> @@ -8,16 +8,6 @@ expression E;
>    commit_list_free(E);
>  )
> =20
> -@@
> -expression E;
> -@@
> -- if (!E)
> -(
> -  free(E);
> -|
> -  commit_list_free(E);
> -)
> -
>  @@
>  expression E;
>  @@

