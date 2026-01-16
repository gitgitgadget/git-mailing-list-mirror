Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418DE3A63EF
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594749; cv=none; b=eljgvOM5w5TWeJ40IS7pmt4jNbYybO6voX/INMtQTKloMB8t6ZIXsFSIPk++4aNNKaBR161+WcTAUaC35hkfhCYDye8lKXRFu5hKc+NEJ/ZZqkAs7cn/YMrN1fPZNKt0RN0dj/sTcoQkstWCnBUvrxlcux4UkWHrLSwl/XUWU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594749; c=relaxed/simple;
	bh=tAxbeQaQL2o6xHpyPmvL/f7sV1FM+QYsDe1/L0n+3dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8FCX3EutdiZ6oHcGbbxQabe7GCuC0chKIgObhqvWdyh+V4n/sCVbonbMnR2jucmQfvgh4THiCUsNzqZcLtvjPtoMuWq2gNcvx2W40Sp1fMXAABDdUd/AY+w//x86iXeBo81r9a9cHwT7c2cf6ZympR0yFEH8kuhbuPREqviZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=OFXk5WJW; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="OFXk5WJW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768594742; x=1769199542; i=l.s.r@web.de;
	bh=3Mnf+kXc5JR8iTZONb+7pGQ77WUVabBtB7W7Mld3h4Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OFXk5WJWTmtyCsi3VB35yycYdkmFFIVd5qnrONWcXdArN92+W1PndL4nw+Fdwkmp
	 2HHbU/KWOk9ik1nymYwJfQJ1faAt//rgbvo+IpUQdg9pkuqLzfBm1ufw7eiUGcLnH
	 fAv7SSZlSBJKvkLMaHQpT8J/x8pSMQQ+MH4huaHtHKHT3ea2W7C/Wrt8/Qk78nXNe
	 KRu4RpsNZE689k/gj6NgDredvAIFovC8eLdzHEBLtvyWEpkbAlyfWhYTfYPqVWGNV
	 PSIJth1GZDLPTq/ykhuIOII92X0a8O3s2FsyzthEkWIw6+vmm7kkQ80Tkbd8ngDig
	 4bkExwtbzkjpUJhdkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.19.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mfc4g-1wI4qM0lmy-00fwX3; Fri, 16
 Jan 2026 21:19:02 +0100
Message-ID: <fc291b3a-5ee5-4488-9b01-d3de32f7c257@web.de>
Date: Fri, 16 Jan 2026 21:19:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: phillip.wood@dunelm.org.uk, Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Jeff King <peff@peff.net>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
 <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kz89xYLpVPrbfhA7u3sHoxQ4ufyWS3v8Iuzl5hV99+IfhRvEZXS
 OlLK4Z4xbFiw4DphBQ0rrKLjGQCA2OWZc7GQwduaUtyoiyaJk3CcjEdNNB1zIbOx1QadCIE
 JLWoB5uUX6Ae5bcdlwkbBwzsQD35MY9LDvPXNCmNDMS8Xopf4MGs3majBDb8oMpTIRrLPmi
 /BNZvAUG7r0+SYZIMBDig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kqzsNofZeps=;iLnxVisJLMlWuZw6WSZeURXm6DR
 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

On 1/16/26 11:39 AM, Phillip Wood wrote:
> I've Cc'd Peff and Ren=C3=A9 for a second opinion if you have time pleas=
e.
>=20
> On 15/01/2026 15:55, Ezekiel Newren wrote:
>> On Thu, Jan 8, 2026 at 7:34=E2=80=AFAM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
>>
>>>> +static void _set_capacity(void *self_, size_t new_capacity)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct IVec_c_void *self =3D self_;
>>>
>>> Passing any of the ivec variants defined below to this function invoke=
s
>>> undefined behavior because we're not casting the pointer back to the
>>> orginal type. However I think on the platforms we care about
>>> sizeof(void*) =3D=3D sizeof(T*) for all T so maybe we can look the oth=
er way.
>>
>> If someone finds that this code does not work because of this
>> assumption I'd like to know. But I can't fathom a case where it
>> wouldn't work.
>=20
> So we have two different structs
>=20
> struct IVec_c_void {
> =C2=A0=C2=A0=C2=A0=C2=A0void *ptr;
> =C2=A0=C2=A0=C2=A0=C2=A0size_t length;
> =C2=A0=C2=A0=C2=A0=C2=A0size_t capacity;
> =C2=A0=C2=A0=C2=A0=C2=A0size_t element_size;
> }
>=20
> and
>=20
> struct Ivec_u8 {
> =C2=A0=C2=A0=C2=A0=C2=A0uint8_t *ptr;
> =C2=A0=C2=A0=C2=A0=C2=A0size_t length;
> =C2=A0=C2=A0=C2=A0=C2=A0size_t capacity;
> =C2=A0=C2=A0=C2=A0=C2=A0size_t element_size;
> }
>=20
> One the platforms we care about they will have the same memory
> layout as all pointers have the same representation. However I don't
> think they are "compatible types" in the language of the C standard
> because the type of the "ptr" member differs. That means casting
> IVec_u8* to IVec_c_void* either directly or via void* is undefined
> and so
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0struct IVec_u8 vec;
> =C2=A0=C2=A0=C2=A0=C2=A0ivec_init(&vec, sizeof(*vec.ptr));
>=20
> is undefined. For the compiler to see the undefined cast it needs to
> look across translation units because the implementation of
> ivec_init() will be in a separate file to where it is called. Maybe
> that and the fact they have the same memory layout saves us from
> having to worry too much though I'm always nervous of undefined
> behavior.

True.  The GCC docs give a fun example of what a compiler might do
when using different struct types to access the same memory:

https://www.gnu.org/software/c-intro-and-ref/manual/html_node/Aliasing-Typ=
e-Rules.html

Not sure it applies to this case, but the point is that compilers
can and will do terrifying things when they smell UB, with little
concern for safety or original intent.

> An alternative would be to pass the individual struct members as functio=
n parameters
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0void ivec_init(void **vec, size_t &length, size_=
t &capacity,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 size_t &element_size_, size_t element_size)
> =C2=A0=C2=A0=C2=A0=C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *vec =3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *length =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *capacity =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *element_size_ =3D element_si=
ze;
> =C2=A0=C2=A0=C2=A0=C2=A0}

The ampersands (&) should be asterisks (*), right?

> and have DEFINE_IVEC_TYPE create typesafe wrappers
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0static inline void ivec_u8_init(struct IVec_u8 *=
vec)
> =C2=A0=C2=A0=C2=A0=C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *ptr =3D vec->ptr;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ivec_init(&ptr, &v->length, &=
v->capacity,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 &v->element_size, sizeof(*(v->ptr));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vec->ptr =3D ptr;
> =C2=A0=C2=A0=C2=A0=C2=A0}

Mixes "v" and "vec", misses a closing parenthesis.  Looks viable,
though, and this method should be applicable to the rest of the
functions as well (on the C side).

I guess this doesn't require an element_size member anymore as
each wrapper can pass in the sizeof value.

> That's safe because we cast the "ptr" member to "void*" and then
> back to the original type. On the rust side the implementation of
> IVec<T> would also need to split out the individual struct members
> when it calls ivec_init() etc. It's all a bit more effort but the
> benefit is that we don't have any undefined behavior and we have a
> nice typesafe C interface to 'struct IVec_*'.
Right.  No idea how ugly this would be on the Rust side, though.

Ren=C3=A9

