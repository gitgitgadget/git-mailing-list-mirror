Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208EA3346B5
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768748311; cv=none; b=b41J5JyDh57U0gM5hhTZUQp+yyX/+fH1y8SW0pOO3IBkHHccgDHceP1ZyaIo93cVbqrVMHCidvS1Tgwaubm9ic/erFF/SRRWyua1A1++vaZwMMyItitLrcdfaBIQMsuaySqyJerw9hbCLVMEIGFBuH7Y4cr7oCTDnDY8NUI7UMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768748311; c=relaxed/simple;
	bh=l3arzVdXRpT+Jb4etd4cFWK12/ZsYR/ZxcP9krKw1JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAMpeNF0gCzDhUz86uu9SoWFmpP/rPOP5jdbfAvM8pNQsplqaW+9bonHuwdJFTFgZnuBX/IACTfhe9ERNxhzZFYChyhwt8eRd1hSEmCscNjV/A/BGsw2sCh+zcRt81Soi6Er7QVMJXhjasSBZXZ2AqDxi+BLc/E9Oh4dJ/H2TbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Vp4tuepE; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Vp4tuepE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768748308; x=1769353108; i=l.s.r@web.de;
	bh=xCZ/9PTFqMW/L/unhB+WGbYC4hBmhXKD+VJLtrB6Afs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Vp4tuepEC3ab+z6SJdMvc3bFiMiXidmPfsUJrK3ut71mDIONY0KqVZO6mLrqv8Mt
	 xM+Ve2CYoIPfXGwhl76aZdXbbRVu0TBi+UrcD05ir/H8PO966Ln0zUgKcN50HLaPZ
	 qw7VC2TwoqPMtIBV2lOCrse2LF7YTRyfOcI3a6MGiUVxHaqhTwJz3gWAgR7AqA/F2
	 UtQjtDk4a88sUkpeDmG/UgOP71HqX6A1H0V7HzXdjt+wlZ3OeCb1rhJPwMVg36xZl
	 VL+Dl5RQt41GuRbAscKiMoC1HtLaq5A2PRmrxYR4oXtghJ5YIwpliCtJQFYgqZcSC
	 VRECEEcN+YbAq0o2Qw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.19.215]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgANG-1wIBcw0Mww-00cd1Q; Sun, 18
 Jan 2026 15:58:28 +0100
Message-ID: <f5b36fd0-1942-499c-bf4a-1107a3afd951@web.de>
Date: Sun, 18 Jan 2026 15:58:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Ezekiel Newren <ezekielnewren@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: phillip.wood@dunelm.org.uk,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Jeff King <peff@peff.net>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
 <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com>
 <fc291b3a-5ee5-4488-9b01-d3de32f7c257@web.de>
 <ed06232c-4c48-4d5a-a269-8663b32787ea@gmail.com>
 <CAH=ZcbCuY22WCqzyK-=Adw924a6ZJqnMYjWK9fxwoFn5xK9q-w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAH=ZcbCuY22WCqzyK-=Adw924a6ZJqnMYjWK9fxwoFn5xK9q-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SLzAxuJ81SjLVlTWFFSaXkKWbGlRNFuhMqpPPRDSKpVKZtCqQ36
 P8B8oQmi+GP06k/dVeQ66Z8bCz4w5ra5e2TcDvDDMuI8++yI6oIRrspHt54tPl5XEPFgTa+
 wSsvD2rjXeL8yNWy/EqKcimlKTyb3TSsdAsQtWIW8mQfkid46Jl1DP3koVDCeC2SvBrzKRN
 O185a6gvg17sLzgKTkOvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:COdS4LUxdjw=;juTkH5HNc6ZhMKA48LJumQPGJbz
 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
 G8sWnhMqQ4DIB//hBMxwsyGL1ClCXSc+2ZvG+I

On 1/17/26 5:04 PM, Ezekiel Newren wrote:
>=20
> I don't like this solution. ivec_push() is the only function that
> deals with actual values. The rest are just generic memory management
> functions. What if we used:
>=20
> #define ivec_init(vec) { \
>     (vec)->ptr =3D NULL; \
>     (vec)->length =3D 0; \
>     (vec)->capacity =3D 0; \
>     (vec)->element_size =3D sizeof(*(vec)->ptr); \
> }
>=20
> #define ivec_push_unsafe(vec, value) (vec)->ptr[(vec)->length++] =3D (va=
lue)
>=20
> /*
>  * grow by at least 1
>  */
> #define ivec_push(vec, value) { \
>     if ((vec)->length =3D=3D (vec)->capacity) \
>        ivec_reserve(vec, 1); \
>     ivec_push_unsafe(vec, value); \
> }
>=20
> Instead of concrete functions?

These macros are OK on the C side in respect to type-safety.

I guess they would have to be duplicated somehow in Rust?

How would ivec_reserve() look like?

The macros use their parameter "vec" multiple times, though, so callers
must not pass in an expression with a side-effect, as it would be
evaluated more than once.  We have a few of those already.  You have to
be careful not to do stuff like this (example of calling a _push-like
function with an argument with a side-effect from
strbuf.c::strbuf_join_argv()):

	while (--argc)
		strbuf_addstr(buf, *(++argv));

Also they can't be used like a function -- you'd have to call them
without a trailing semicolon.  That's a small issue and easily
overcome by wrapping their body in "do { } while (0)".

Ren=C3=A9

