Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816912E540C
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765319138; cv=none; b=b7IgY4SitHrd6tdOw+fpN+EmQVbju+h6gAfYYIrKWCnLmeQ4UwPG8/Atdx43slZl9g58SNbL/Grz2AlhFRj5UbPjJo1QoS0MZ4sU2F6taLeHcfR3Y6KQ+vUN5WVxKL9iVGdKy+SbAzKiVk0by6tu6LrAx4Dq6T8+YjTH6pGS9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765319138; c=relaxed/simple;
	bh=O/5GM6PxN0i60Erc+0QQJXKfeaz9+F+R1KjISK4of+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFBDPbJty+neuOcwzL2ql8dNQxMQVX23xVoOY0h1F+MNAHZSpQfYL/vNAT2g6+afmNbzZDD22zRS9BqoqjHq4li+mkPRmKxxm32ayKXTgc9llojfg2L5vCU7J5W/3vqBSIuluG7ISRRq49txVDxfT+9M8NfsIFyFkOLKivL/D+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=bY0ehhzB; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="bY0ehhzB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765319133; x=1765923933; i=l.s.r@web.de;
	bh=vurOKioQCxMB5t6txACO1wv/lBeld0o3uIpds6vnsWc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bY0ehhzBxRPEwzJZLM3thmfiK3cI3c98uj8Eid9vEgpcbBT22pUEeNoYAx8Z2mzE
	 ExCHnb3mOEMOc1ifZ90R2TaXHlSKTbgIJz61LvJN+Eh8qVYPwSesD/OKGoONx1/CQ
	 JROof0ZTXmzlr6pGcnvVlLobLmGVWoM062sRfQbPrOTXel+layXm79D6Qt+YInftP
	 VWDRPn+aM0TdJoxp8ijj8LDh3ELTUUceywZY98BjG0gmBglDRF6ByD6lLZk2Q604i
	 5A5v16X2NWfzL2/04p93OCxJB5nquztDHKWvvY0Nussa8I07LGJIrzwm6e2VepAMX
	 WORIuKlry7+shH4FzQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuVGC-1wKNSR0Hxq-00wiQv; Tue, 09
 Dec 2025 23:25:33 +0100
Message-ID: <22b1f482-2012-4ee9-bc12-1b2123ee0101@web.de>
Date: Tue, 9 Dec 2025 23:25:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: t3900 failure on macOS, iconv(3) broken?
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc: Git List <git@vger.kernel.org>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <20251209163356.GA5762@tb-raspi4>
 <51dc4ca7-61fd-42f7-8e72-a516a870e011@web.de>
 <20251209212420.GA10149@tb-raspi4>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20251209212420.GA10149@tb-raspi4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z/5MgnGv9zWMI/UXuNVkFtGZMAYfEo8pGry7kkN4MURcdRIwU5O
 KilgNx5/qITCQEtX6G+d2SxzbIVijf5dole4d9Tf08U7VtpE3jmzNSPiaNs2R7X6lq9ZkJ1
 4avIAj/dbjWkIL5M7qbcX82fRgUNcMiZ3CBnmEkcdYcDTzkr5dInNN4MWWltaF5UriMMmxX
 bYDxbjN9tgEyYuxfOzFCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lfkIrmDfpe0=;OaW1WJCmKwPm1CbCrOkqejUe5Qs
 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

On 12/9/25 10:24 PM, Torsten B=C3=B6gershausen wrote:
> On Tue, Dec 09, 2025 at 08:35:23PM +0100, Ren=C3=A9 Scharfe wrote:
>> On 12/9/25 5:33 PM, Torsten B=C3=B6gershausen wrote:
>>> On Mon, Dec 08, 2025 at 11:59:11PM +0100, Ren=C3=A9 Scharfe wrote:
>>>>
> [snip]
>>
>> This forgets to reset outsz and the converter state.  With this patch
>> t0028-working-tree-encoding.sh seems to get stuck in an endless loop.
>=20
> Thanks for testing.
> I did another test here
> (increase the outbuffer with only one byte per round, old MacOs)
> and yes, we need to reset iconv.
> Back to your patch. I think it is good to go further,
> with one or 2 remarks, see TB
> =20
> 			out =3D xrealloc(out, outalloc);
> 			// TB: move into else outpos =3D out + sofar;
> 			// TB: move into else outsz =3D outalloc - sofar - 1;
> // TB: We have seen different breakages of apple iconv. Should we run th=
e same code
> // on all versions of MacOs to be more future proof ?
> // and do we need a Makefile knob, if one, and only one platform is affe=
cted ?
> // I don't know
> #ifdef __APPLE__
> or
> #ifdef ICONV_BREAKS

macOS 14.8.2 reportedly doesn't have this particular issue, and I can
only hope that Apple will eventually fix that bug, so __APPLE__ seems a
bit too broad.

I'm also not thrilled about adding yet another build flag.  The patch I
just posted sidesteps the issue by using the existing ICONVDIR setting
to use libiconv from Homebrew.  We do that for gettext already, so it
should be fine..

> 			/*
> 			 * If iconv(3) messes up piecemeal conversions
> 			 * then restore the original pointers, sizes,
> 			 * and converter state, then retry converting
> 			 * the full string using the reallocated buffer.
> 			 */
> 			insz +=3D (char *)cp - in;    /* TB stumbled here: "in" is "const cha=
r *"

We can add the const qualifier, but it won't affect the pointer
arithmetic.  Perhaps casting to iconv_ibp would be more consistent?

> 			                              And I didn't like the fact that insz is=
 destroyed
> 						      and needs to be restored. That is why I had a originsz
> 						      (or szinorig ?)

Sure, storing the original value would work, but is slightly more effort
than subtracting the progress made so far.  originsz would only be used
if ICONV_BREAKS is defined, you'd need to declare it conditionally,
adding yet more overhead.

> 			cp =3D (iconv_ibp)in;
> 			outpos =3D out + bom_len;
> 			outsz =3D outalloc - bom_len - 1;
> 			iconv(conv, NULL, NULL, NULL, NULL);
> #else
> 			outpos =3D out + sofar;
> 			outsz =3D outalloc - sofar - 1;

I'd like to keep buffer increase and rollback separate.  Perhaps
splitting out the output buffer adjustment is worth it, though?  Not
sure. *shrug*

diff --git a/utf8.c b/utf8.c
index 35a0251939..c99243a63b 100644
=2D-- a/utf8.c
+++ b/utf8.c
@@ -513,6 +513,18 @@ char *reencode_string_iconv(const char *in, size_t in=
sz, iconv_t conv,
 			sofar =3D outpos - out;
 			outalloc =3D st_add3(sofar, st_mult(insz, 2), 32);
 			out =3D xrealloc(out, outalloc);
+#ifdef ICONV_BREAKS
+			/*
+			 * If iconv(3) messes up piecemeal conversions
+			 * then restore the original pointers, sizes,
+			 * and converter state, then retry converting
+			 * the full string using the reallocated buffer.
+			 */
+			insz +=3D cp - (iconv_ibp)in;
+			cp =3D (iconv_ibp)in;
+			sofar =3D bom_len;
+			iconv(conv, NULL, NULL, NULL, NULL);
+#endif
 			outpos =3D out + sofar;
 			outsz =3D outalloc - sofar - 1;
 		}

> #endif

