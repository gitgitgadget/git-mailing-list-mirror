From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: htonll, ntohll
Date: Wed, 06 Nov 2013 16:58:57 +0100
Message-ID: <527A6741.4000507@web.de>
References: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com> <5271392E.8020003@web.de> <CAFFjANT=-mQoKUU2KsPHo3Hcq7RAuyM1t4kvJu4OfiNeHrA+Ng@mail.gmail.com> <52713E67.3000202@web.de> <527158AF.3070204@ramsay1.demon.co.uk> <52716C58.3090507@web.de> <5271750D.5010801@ramsay1.demon.co.uk> <52725A05.1050805@web.de> <52783518.1030908@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VmljZW50IE1hcnTDrQ==?= <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?B?VG9yc3RlbiBCw7Zn?= =?UTF-8?B?ZXJzaGF1c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 06 16:59:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve5Va-0007I9-6P
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 16:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab3KFP7B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Nov 2013 10:59:01 -0500
Received: from mout.web.de ([212.227.17.12]:53409 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754580Ab3KFP7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 10:59:00 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MKa6N-1VeuBh07OR-0020aR for <git@vger.kernel.org>;
 Wed, 06 Nov 2013 16:58:58 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52783518.1030908@ramsay1.demon.co.uk>
X-Provags-ID: V03:K0:ZPImyrsC2turUlcYx11/aQbFGOK5RkxWJoPcnqCzUrmx3973QUN
 rd4kZkyvhRt5/FbGD95zYPpl5sEgMcnPzPUBHYDYP5RCTr6UtK90/LVqEwxEvBd6/ZjNw9b
 Pt7YddstrdoZifcsAX6nB3crnowdptyBwEJsMW1SgDQ8jjO0YyruLNxQOAo+NBmgk4Rlvlv
 uI6y6vtBDOQQXRzNh7XdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237356>

On 2013-11-05 01.00, Ramsay Jones wrote:
> On 31/10/13 13:24, Torsten B=C3=B6gershausen wrote:
>> On 2013-10-30 22.07, Ramsay Jones wrote:
> [ ... ]
>>> Yep, this was the first thing I did as well! ;-) (*late* last night=
)
>>>
>>> I haven't had time today to look into fixing up the msvc build
>>> (or a complete re-write), so I look forward to seeing your solution=
=2E
>>> (do you have msvc available? - or do you want me to look at fixing
>>> it? maybe in a day or two?)
>>>
>> Ramsay,
>> I don't have msvc, so feel free to go ahead, as much as you can.
>>
>> I'll send a patch for the test code I have made, and put bswap.h on =
hold for a week
>> (to be able to continue with t5601/connect.c)
>=20
> Unfortunately, I haven't had much time to look into this.
>=20
> I do have a patch (given below) that works on Linux, cygwin,
> MinGW and msvc. However, the msvc build is still broken (as a
> result of _other_ commits in this 'jk/pack-bitmap' branch; as
> well as the use of a VLA in another commit).
>=20
> So, I still have work to do! :(
>=20
> Anyway, I thought I would send what I have, so you can take a look.
> Note, that I don't have an big-endian machine to test this on, so
> YMMV. Indeed, the *only* testing I have done is to run the test added
> by this branch (t5310-pack-bitmaps.sh), which works on Linux, cygwin
> and MinGW.
>=20
> [Note: I have never particularly liked htons, htonl et.al., so adding
> these htonll/ntohll functions doesn't thrill me! :-D For example see
> this post[1], which echo's my sentiments exactly.]
>=20
> HTH
>=20
> ATB,
> Ramsay Jones
>=20
> [1] http://commandcenter.blogspot.co.uk/2012/04/byte-order-fallacy.ht=
ml
>=20
> -- >8 --
> Subject: [PATCH] compat/bswap.h: Fix build on cygwin, MinGW and msvc
>=20
> ---
>  compat/bswap.h | 97 ++++++++++++++++++++++++++++++++++++++++--------=
----------
>  1 file changed, 68 insertions(+), 29 deletions(-)
>=20
> diff --git a/compat/bswap.h b/compat/bswap.h
> index ea1a9ed..c18a78e 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -17,7 +17,20 @@ static inline uint32_t default_swab32(uint32_t val=
)
>  		((val & 0x000000ff) << 24));
>  }
> =20
> +static inline uint64_t default_bswap64(uint64_t val)
> +{
> +	return (((val & (uint64_t)0x00000000000000ffULL) << 56) |
> +		((val & (uint64_t)0x000000000000ff00ULL) << 40) |
> +		((val & (uint64_t)0x0000000000ff0000ULL) << 24) |
> +		((val & (uint64_t)0x00000000ff000000ULL) <<  8) |
> +		((val & (uint64_t)0x000000ff00000000ULL) >>  8) |
> +		((val & (uint64_t)0x0000ff0000000000ULL) >> 24) |
> +		((val & (uint64_t)0x00ff000000000000ULL) >> 40) |
> +		((val & (uint64_t)0xff00000000000000ULL) >> 56));
> +}
> +
>  #undef bswap32
> +#undef bswap64
> =20
>  #if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
> =20
> @@ -32,54 +45,80 @@ static inline uint32_t git_bswap32(uint32_t x)
>  	return result;
>  }
> =20
> +#define bswap64 git_bswap64
> +#if defined(__x86_64__)
> +static inline uint64_t git_bswap64(uint64_t x)
> +{
> +	uint64_t result;
> +	if (__builtin_constant_p(x))
> +		result =3D default_bswap64(x);
> +	else
> +		__asm__("bswap %q0" : "=3Dr" (result) : "0" (x));
> +	return result;
> +}
> +#else
> +static inline uint64_t git_bswap64(uint64_t x)
> +{
> +	union { uint64_t i64; uint32_t i32[2]; } tmp, result;
> +	if (__builtin_constant_p(x))
> +		result.i64 =3D default_bswap64(x);
> +	else {
> +		tmp.i64 =3D x;
> +		result.i32[0] =3D git_bswap32(tmp.i32[1]);
> +		result.i32[1] =3D git_bswap32(tmp.i32[0]);
> +	}
> +	return result.i64;
> +}
> +#endif
> +
>  #elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
> =20
>  #include <stdlib.h>
> =20
>  #define bswap32(x) _byteswap_ulong(x)
> +#define bswap64(x) _byteswap_uint64(x)
> =20
>  #endif
> =20
> -#ifdef bswap32
> +#if defined(bswap32)
> =20
>  #undef ntohl
>  #undef htonl
>  #define ntohl(x) bswap32(x)
>  #define htonl(x) bswap32(x)
> =20
> -#ifndef __BYTE_ORDER
> -#	if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_EN=
DIAN)
> -#		define __BYTE_ORDER BYTE_ORDER
> -#		define __LITTLE_ENDIAN LITTLE_ENDIAN
> -#		define __BIG_ENDIAN BIG_ENDIAN
> -#	else
> -#		error "Cannot determine endianness"
> -#	endif
> +#endif
> +
> +#if defined(bswap64)
> +
> +#undef ntohll
> +#undef htonll
> +#define ntohll(x) bswap64(x)
> +#define htonll(x) bswap64(x)
> +
> +#else
> +
> +#undef ntohll
> +#undef htonll
> +
> +#if !defined(__BYTE_ORDER)
> +# if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_EN=
DIAN)
> +#  define __BYTE_ORDER BYTE_ORDER
> +#  define __LITTLE_ENDIAN LITTLE_ENDIAN
> +#  define __BIG_ENDIAN BIG_ENDIAN
> +# endif
> +#endif
> +
> +#if !defined(__BYTE_ORDER)
> +# error "Cannot determine endianness"
>  #endif
> =20
>  #if __BYTE_ORDER =3D=3D __BIG_ENDIAN
>  # define ntohll(n) (n)
>  # define htonll(n) (n)
> -#elif __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
> -#	if defined(__GNUC__) && defined(__GLIBC__)
> -#		include <byteswap.h>
> -#	else /* GNUC & GLIBC */
> -static inline uint64_t bswap_64(uint64_t val)
> -{
> -	return ((val & (uint64_t)0x00000000000000ffULL) << 56)
> -		| ((val & (uint64_t)0x000000000000ff00ULL) << 40)
> -		| ((val & (uint64_t)0x0000000000ff0000ULL) << 24)
> -		| ((val & (uint64_t)0x00000000ff000000ULL) <<  8)
> -		| ((val & (uint64_t)0x000000ff00000000ULL) >>  8)
> -		| ((val & (uint64_t)0x0000ff0000000000ULL) >> 24)
> -		| ((val & (uint64_t)0x00ff000000000000ULL) >> 40)
> -		| ((val & (uint64_t)0xff00000000000000ULL) >> 56);
> -}
> -#	endif /* GNUC & GLIBC */
> -#	define ntohll(n) bswap_64(n)
> -#	define htonll(n) bswap_64(n)
> -#else /* __BYTE_ORDER */
> -#	error "Can't define htonll or ntohll!"
> +#else
> +# define ntohll(n) default_bswap64(n)
> +# define htonll(n) default_bswap64(n)
>  #endif
> =20
>  #endif
>=20
I have had time to test it, works on Linux/PPC (big endian)
and Mac OS.

What do we think about going ahead with this patch?
/Torsten
